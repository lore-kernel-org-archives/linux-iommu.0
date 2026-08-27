Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA9499F12
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852125; cv=none; b=iV/4iEkwspChvYjOhVC6rd7OSxu7tyQiZt0Mlm1N+QFSnHZdZBQeFeJntD6H7qLmsyhrLZGXbpA1fw62THyz+Xgy1iS1zP/2AFxhRUvmv8DsCDMO+/ZTL/AFNO5aFeISJjJejyYUkQVG8JowFzgP/1LSw6DBO+GHFV72VcueUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852125; c=relaxed/simple;
	bh=w71Et5wpQCMNemYcecfDHqCh0RM4Z1TQVLm/oPzTJ/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=auhTSVRIC9LSEbyt3cPlrZObogmLbEkvmSz4L8wsEL55RQA6LsJ2zio51+lfh0V2j/TCCqvsSO4nHyjf6vtzBC0ziCezahbNy4u9GjRZG7NqHGy427DWYdqfhhMZqEnjScJbThBsBIGw2h9t35QaEdPgHqzQDFvAheMmUNUVGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF7Hi+3l; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF7Hi+3l"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d52734fc41so1746685ad.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787852122; x=1788456922; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6i2GuB52vsi1dvGmgIuAll9oKdxoOK0J1vulbgdbfqA=;
        b=ZF7Hi+3lZg0v3hwlK+/U9d/IiHCr3x5cmjVStW2kwMXWE830BG+cEZ9mPuXtLfAWWG
         a3dnnrEEyEo9T/8wf0hI8o6ZXRwAFZJO/CRPgpwvJ4zNURm5UkUsXsrE6UMHdV/aQ4m1
         crrWTYMBnOjPRGckm1u7fmmg8MKobJq4HnLYQWEe9IfOmxPjqUjFtJEfZB0tvhTVkMRG
         6TwsdWGWvsMBZ7ufWg7qT5txQNe+vq3jD9l0n84eI1I/Z64G4DrQJvnRmexCe7Xc/USf
         wS7YF9PIbZegI8grtLM6K6p50CHPDKKZnqei+st0hQtd8vb0Fc41liqKnQRIkg1ZTrSj
         wG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852122; x=1788456922;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6i2GuB52vsi1dvGmgIuAll9oKdxoOK0J1vulbgdbfqA=;
        b=AkIBYNE9YBlrViUycaKC41XAU997wI2PAqOxTVJtgfSdoe3jaBxHGHrqr7NQlJeKrV
         Urj/lcP8nuqygDnueSrUvKRe/3LNa1GXvgcWucou74kjKnEdvxWqTt04uapnySwNJQBe
         3ZmcAzHp8RBmOiD3Ub8meVFXnM8ebWgUlwzgRAUIKEeO15FaqQAcTuRT89DImF3CM0iI
         NWwgz/4ADo9oPwxmlJOnPwcdOfzWmfJxzdKOwE9ija7+wiIp6PUEF3SxJF+ZDoYgfSEW
         SNRbn+Zi7BqyuYgKdS/+jkvK0U4Rx4EqruA4OnQA8+/SbVtbptzy8lNCFnma4TtFCsu7
         jG+Q==
X-Gm-Message-State: AFuF++lsrz5e0JyEK+2mF2zLMgTAL0/4e9tX9+1zVvoq+aVy14KrzxRW
	Ttwxp4lc61JMNU0AUWLLeWtpsqZRL6UDzX/ZjZX1qu6EnjjEVlR1J/PcrBpzgLzFdTL35QC/HQc
	IOhODXRC+AKlIbUABdJPzGuyBVVA0H8f8IdQ1dLWBSsbsUyzxkYXmrBKRPXbdp+yYS6f9dWFh4h
	O/wbj/IjRU4hS4vwv6S76dY57TCnaw9Ne+1GuYVNwMy/1lIA==
X-Received: from pjbpb6.prod.google.com ([2002:a17:90b:3c06:b0:38f:659:4491])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:530c:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-396d0d4c43amr1737954a91.3.1787852121369;
 Thu, 27 Aug 2026 10:35:21 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:35:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827173511.2322549-1-dmatlack@google.com>
Subject: [PATCH] iommu: Introduce reset_mutex to avoid circular locking dependency
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduce a dedicated reset_mutex inside struct iommu_group to serialize
device reset operations and domain resetting state without acquiring
group->mutex.

Commit f5b16b802174 ("PCI: Suspend iommu function prior to resetting a
device") introduced pci_dev_reset_iommu_prepare() and
pci_dev_reset_iommu_done(), which acquire group->mutex during PCI device
resets. In drivers such as VFIO, device reset handlers (e.g.
pci_try_reset_function()) are executed while holding driver locks such
as vdev->memory_lock.

This introduces a circular locking dependency that can lead to tasks
being permanently stuck in a deadlock:

[vdev->memory_lock]  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
(1. VFIO Reset)=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>  [io=
mmu_group->mutex]
         =E2=96=B2
         =E2=94=82                                                    =E2=
=94=82
 (3. VFIO BAR Page Fault)                                    ... [*]
         =E2=94=82                                                    =E2=
=94=82
         =E2=94=82                                                    =E2=
=94=82
         =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80  [mm->mmap_lock]  <=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98

Fix this by using group->reset_mutex instead of group->mutex in
pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done(). To ensure
other iommu_group operations stay properly synchronized with resets,
also take group->reset_mutex when checking group->recovery_cnt.

[*] The iommu_group->mutex --> mm->mmap_lock dependency was reported as
a transitive chain: iommu_group->mutex --> cpu_hotplug_lock -->
i_mutex_dir_key --> mm->mmap_lock.

Reported-by: Vipin Sharma <vipinsh@google.com>
Closes: https://lore.kernel.org/kvm/20260821193502.92431-1-vipinsh@google.c=
om/
Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a devi=
ce")
Signed-off-by: David Matlack <dmatlack@google.com>
---
Cc: Alex Williamson <alex@shazbot.org>

 drivers/iommu/iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde..29e63697211f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -56,6 +56,7 @@ struct iommu_group {
 	struct list_head devices;
 	struct xarray pasid_array;
 	struct mutex mutex;
+	struct mutex reset_mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
 	char *name;
@@ -1080,6 +1081,7 @@ struct iommu_group *iommu_group_alloc(void)
=20
 	group->kobj.kset =3D iommu_group_kset;
 	mutex_init(&group->mutex);
+	mutex_init(&group->reset_mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
 	xa_init(&group->pasid_array);
@@ -2476,6 +2478,7 @@ static int __iommu_group_set_domain_internal(struct i=
ommu_group *group,
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain, if
 	 * IOMMU_SET_DOMAIN_MUST_SUCCEED is not set.
 	 */
+	guard(mutex)(&group->reset_mutex);
 	if (group->recovery_cnt && !(flags & IOMMU_SET_DOMAIN_MUST_SUCCEED))
 		return -EBUSY;
=20
@@ -3652,6 +3655,7 @@ int iommu_attach_device_pasid(struct iommu_domain *do=
main,
 	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
+	guard(mutex)(&group->reset_mutex);
 	if (group->recovery_cnt) {
 		ret =3D -EBUSY;
 		goto out_unlock;
@@ -3745,6 +3749,7 @@ int iommu_replace_device_pasid(struct iommu_domain *d=
omain,
 	 * This is a concurrent attach during device recovery. Reject it until
 	 * pci_dev_reset_iommu_done() attaches the device to group->domain.
 	 */
+	guard(mutex)(&group->reset_mutex);
 	if (group->recovery_cnt) {
 		ret =3D -EBUSY;
 		goto out_unlock;
@@ -4042,7 +4047,7 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return 0;
=20
-	guard(mutex)(&group->mutex);
+	guard(mutex)(&group->reset_mutex);
=20
 	gdev =3D __dev_to_gdev(&pdev->dev);
 	if (WARN_ON(!gdev))
@@ -4153,7 +4158,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
=20
-	guard(mutex)(&group->mutex);
+	guard(mutex)(&group->reset_mutex);
=20
 	gdev =3D __dev_to_gdev(&pdev->dev);
 	if (WARN_ON(!gdev))

base-commit: 37ffa24c9d07edcd414d34283e02af3f3866cf12
--=20
2.55.0.897.gb25b4bd76c-goog

