From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v2] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Date: Thu, 17 Jan 2019 11:47:35 +0000
Message-ID: <20190117114714.126410-1-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

When a VM is terminated, the VFIO driver detaches all pass-through
devices from VFIO domain by clearing domain id and page table root
pointer from each device table entry (DTE), and then invalidates
the DTE. Then, the VFIO driver unmap pages and invalidate IOMMU pages.

Currently, the IOMMU driver keeps track of which IOMMU and how many
devices are attached to the domain. When invalidate IOMMU pages,
the driver checks if the IOMMU is still attached to the domain before
issuing the invalidate page command.

However, since VFIO has already detached all devices from the domain,
the subsequent INVALIDATE_IOMMU_PAGES commands are being skipped as
there is no IOMMU attached to the domain. This results in data
corruption and could cause the PCI device to end up in indeterministic
state.

Fix this by introducing IOMMU domain states attached, detached,
and free. Then only issuing the IOMMU pages invalidate command when
domain is in attached and detached states.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 25 ++++++++++++++++++++-----
 drivers/iommu/amd_iommu_types.h |  8 +++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 525659b88ade..1c64a26c50fb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1248,7 +1248,14 @@ static void __domain_flush_pages(struct protection_d=
omain *domain,
 	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
=20
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		/*
+		 * We issue the command only when the domain is
+		 * in ATTACHED and DETACHED state. This is required
+		 * since VFIO detaches all devices from the group
+		 * before invalidating IOMMU pages. Please see
+		 * vfio_iommu_type1_detach_group().
+		 */
+		if (domain->dev_iommu[i] =3D=3D IOMMU_DOMAIN_STATE_FREE)
 			continue;
=20
 		/*
@@ -1292,7 +1299,8 @@ static void domain_flush_complete(struct protection_d=
omain *domain)
 	int i;
=20
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain && !domain->dev_iommu[i])
+		if (domain &&
+		    domain->dev_iommu[i] < IOMMU_DOMAIN_STATE_ATTACHED)
 			continue;
=20
 		/*
@@ -1978,8 +1986,11 @@ static void do_attach(struct iommu_dev_data *dev_dat=
a,
 	list_add(&dev_data->list, &domain->dev_list);
=20
 	/* Do reference counting */
-	domain->dev_iommu[iommu->index] +=3D 1;
-	domain->dev_cnt                 +=3D 1;
+	if (domain->dev_iommu[iommu->index] < IOMMU_DOMAIN_STATE_ATTACHED)
+		domain->dev_iommu[iommu->index] =3D IOMMU_DOMAIN_STATE_ATTACHED;
+	else
+		domain->dev_iommu[iommu->index] +=3D 1;
+	domain->dev_cnt +=3D 1;
=20
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain, ats, dev_data->iommu_v2);
@@ -2904,6 +2915,7 @@ static int protection_domain_init(struct protection_d=
omain *domain)
=20
 static struct protection_domain *protection_domain_alloc(void)
 {
+	int i;
 	struct protection_domain *domain;
=20
 	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
@@ -2915,6 +2927,9 @@ static struct protection_domain *protection_domain_al=
loc(void)
=20
 	add_domain_to_list(domain);
=20
+	for (i =3D 0; i < MAX_IOMMUS; i++)
+		domain->dev_iommu[i] =3D IOMMU_DOMAIN_STATE_FREE;
+
 	return domain;
=20
 out_err:
@@ -3364,7 +3379,7 @@ static int __flush_pasid(struct protection_domain *do=
main, int pasid,
 	 * prevent device TLB refill from IOMMU TLB
 	 */
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain->dev_iommu[i] =3D=3D 0)
+		if (domain->dev_iommu[i] < IOMMU_DOMAIN_STATE_ATTACHED)
 			continue;
=20
 		ret =3D iommu_queue_command(amd_iommus[i], &cmd);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_type=
s.h
index eae0741f72dc..6d17cdcfa306 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -461,6 +461,12 @@ struct amd_irte_ops;
=20
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
=20
+enum IOMMU_DOMAIN_STATES {
+	IOMMU_DOMAIN_STATE_FREE =3D -1,
+	IOMMU_DOMAIN_STATE_DETTACHED,
+	IOMMU_DOMAIN_STATE_ATTACHED
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -480,7 +486,7 @@ struct protection_domain {
 	unsigned long flags;	/* flags to find out type of domain */
 	bool updated;		/* complete domain flush required */
 	unsigned dev_cnt;	/* devices assigned to this domain */
-	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+	int dev_iommu[MAX_IOMMUS]; /* per-IOMMU domain state and reference count =
*/
 };
=20
 /*
--=20
2.17.1
