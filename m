Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBE3ACA5D
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411816; cv=fail; b=Ga81z/C3XqAO57l01p4g7qcFLNsBqD2TpTg/3e2Xyk+YKGLB68R1ld+Afs/XliZVPdWir3WZ4aTdAt8r47tzsufhOzP78GHE0n92JNL6Z5IESWEVzE295mA9lam2rsXu8xLDPLoS8r3ODzZ6yTqOfEaEHLljQWmaBa31ODAT7xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411816; c=relaxed/simple;
	bh=fGiuAUps2tVO78oex3pj+mOkOaC8E9MUlmvuWvtlYos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0851+ILyUzolVOulApWl3H0kjwRz13zsPV0hldXMHHEqdZyJRr8dyTbD3BghAPr8j78ZvDmIVYLz5QyZBIiP2wlzMfdnXYuYNWqY3X11HkMaZ3FyhAJibz7/6EWlFyASUV6eeyNgMNL6Fjm2gJ/qApcaytFtkkI2dQJKFbD8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppmkx2hm; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppmkx2hm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y13lay4Ux4EKN9P8OCe1jHi5nqUQWNIykqI04inGIldsPKr/gst3e9VSwHXl/TDYsW6/XfHYlQmUUfdtNatA3UUtstuIDsaOjS6fylGygJTnwAqiyW7lxcqPxfnnHCSipAXBvvxIUh46+IxJineOpmepHuc/nXVpztkFkUuhBRAMCQKvfXzmeYi92vSZdIJWCxG6QJZjayk1/WOXCZFO8bBX7/QcitjYCKb14dleOngmhxsgLln3ofFlHJYXDc3kD1yfrBqeFGOslLfpqIu2xaNItpyeavcKswJzpTJW698dOjvFPod9yeTQnSo25aYy41SkeDGnnNoHeU5GpDC5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuqZAJnpsK7cWfCza6+3peaCq2hQp7BovRW9eG6v9u0=;
 b=KZemtPjIMhvT/Xid0TV1TwJYuYoy8OSqvtuqgHPzP0Ql1sCbsKn6im1dgYnu1+PRJvnDg6ZKzzKzsSbsdpOW/dNK/P1X+d3lajfNcKCab97gpca5uOxz7Sbi1X68FNJW/NZI1YVJotMhFYZoYETFwMHNn9xyURP4z7JS/u2JAwRsHzGX64hgy5JMoXDyzVJ5yET50E0U/IqcASfPYwt8u2O/WAcrOO3IVNMtrnmeioe3Vp71iJXA78qdCTwAzkukZ9sPrgM6okQ4tsa3eh5I8ThFLKMNucvGUztnaQmdz01gl5GII6y6ZFj8cOocLkKQttihHZzOoUBt+TWs1XkrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuqZAJnpsK7cWfCza6+3peaCq2hQp7BovRW9eG6v9u0=;
 b=ppmkx2hmT1mARRiXg3yLF2hzNSXDYit868YskizHaempNcbAhT5gNnbvJUNRt2fJvxOWXd7ysmrSEOAStIrewBlcJhB5QrBX1nDjpDP7c8l83riwWxhvHEoM7UEYZ93fo/IM7vgvFPfNGQIOLlIUbDsK3wVd18XHZ3VZMvDvPwE=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:06 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::1a) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:50:06 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 18/24] iommu/amd: Init and clear vIOMMU DevID and DomID maps
Date: Mon, 14 Sep 2026 18:47:44 +0000
Message-ID: <20260914184750.222939-19-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: be77823a-aa17-42d1-dcf2-08df1290fe5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QksHxNL7DYGc9kHIrR73f6ukBPPD+sNwiFP3r6HSOjjYhwq1WLTZTHqO0/uDSBG2o2OC664FAb8IH5Pn6VBEDWTAsItjTOPa3lTH9Q3rWjQWCPN4orGaNar72nhvf0SoCAZSfdkfy5qRo2x+520AVGTNO0CFnbLPSJlgvcDJTcp8TNRvS1uSgiOmxLEyu+icGKKKM4Ds0zveNAljMSPYjo6aQmccrS2/avmYZKVVndtkEQt9DpAdByl9HFqDkjb6e5aiTChoA29lP7x1zbAszj/Q2S3CVeYycufjmEtAeOd0qk+1le7X0M2f4xZGmWk1PnJKRqV/9jLRAWQZtKsXfK4B2jqx0HjrfJ1EWl01EA5gwjamsdNSc3W7zSCF2ztycN9PaR10nXbBBq2qaQqqBtquUq/bvGkvtpSj5UNWu+RYUWSfFQYyqiX0oafrp5Qei2jhoNJ8zblL9uKihPdgkHQSxBCLd3zZAwTd1jg+B+O2LzcTijnX/Kq5xWu7S20loGi1TmRhauQStwPg+Ozllrg6FdEH7XYV7M1bSmqp9Yf6+d/XvPen0KdK31BmwtLPR+LPT2rPKv/0pXe0fTcXCl9CQiGigk+svRt5+JdF1jjIQZZr3cJtL26hbB5mcyV3xe2ciStcktgcc80PeEwYIrk5OXP0b8DzjHUA3AaWskGsN1s5N7ND4LSZ4YhnIOyBMZMkJxb8fp8qhQXhI8N5TA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mZWzl3J4+1Z7Wbg5AA/FNn9btS4PR8JxLzADwIjn+hWy1E8v4X35ahsYzKcn5k+hd6r36prnpCBddJQAYxftwFWHy8CTkiKJeSEvSy2PvF2wNlUTFMnxLOcJ+llKZIdszZSPTRFmVBs8tLeeUfufqrWxn089DSpy3J/We8XgVfmpWY7leUfZLfOKBjZoL7b4JTiGX/kJJLqaEzrDX2zhi8w8+O7C1r6WgqhFP+Ujn5nQguyzP4NY0qQ9iMNgrCT2T7CkQhGI9wMVh82gVNCAOjRD2O2glfgDeqH+MN+j9fXDkAS2oKZ1P8ISBAtg7atnammxX8YVv6rEX5brv8Oj0biOUlx0ExcgVlr5Re1l84iT/NdCSfxC7CQR8pC50wAD0RUOAjT0HuHbs4tCMKKAVOtddx47+UV0lMikmD4FTEQe0YnEystAjzurqfSJ9cy4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:50:06.1756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be77823a-aa17-42d1-dcf2-08df1290fe5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601

Before using a vIOMMU instance, prefill the mapping tables so hardware
never sees an unknown guest ID. Map every gdom_id to the nest parent
domain ID, and write every gdev_id with hdev_id 0. Init cannot be
scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.

Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
resched. Attach cannot run until viommu->ops is set after init_one().

On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
the full tables: that would start 128K DMA writes into pages about
to be freed. vDevice destroy and nested_domain_free already restored
idle entries.

Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
viommu_priv_unmap_free() on the same uninit_one() path.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/viommu.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 7521f470e5d4..e0c5e79cf795 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -7,6 +7,7 @@
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <uapi/linux/iommufd.h>
@@ -447,6 +448,8 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 #define DEVID_ENTRY_WRITE		BIT_ULL(63)
 #define DEVID_ENTRY_VALID		BIT_ULL(0)
 
+#define VIOMMU_VFCTRL_PREFILL_RESCHED	256
+
 /*
  * CONTROL0/CONTROL1 bit 63 (WRITE) is a doorbell: hardware copies one
  * entry into the IPA-backed table and clears WRITE when that DMA write
@@ -559,10 +562,95 @@ void amd_viommu_domain_id_update(struct amd_iommu_viommu *aviommu,
 	mutex_unlock(&aviommu->vfctrl_lock);
 }
 
+static bool viommu_vfctrl_ready(struct amd_iommu *iommu)
+{
+	return iommu->vfctrl_base && viommu_cmdbuf_enabled(iommu);
+}
+
+/*
+ * Drain outstanding CONTROL0/CONTROL1 table DMA before the IPA pages
+ * are unmapped and freed. Do not rewrite 0..0xFFFF: vDevice destroy
+ * and nested_domain_free already restored idle entries, and a full
+ * walk would start 128K new DMA writes into pages about to be freed.
+ *
+ * Skip after disable_iommus(): CMDBUF_EN is already clear, matching
+ * viommu_priv_unmap_free() which skips IOTLB invalidation.
+ */
+static void viommu_drain_mapping(struct amd_iommu *iommu,
+				 struct amd_iommu_viommu *aviommu)
+{
+	u16 gid = aviommu->gid;
+
+	if (!viommu_vfctrl_ready(iommu))
+		return;
+
+	mutex_lock(&aviommu->vfctrl_lock);
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
+static void viommu_prefill_resched(struct amd_iommu_viommu *aviommu, int i)
+{
+	lockdep_assert_held(&aviommu->vfctrl_lock);
+
+	if ((i & (VIOMMU_VFCTRL_PREFILL_RESCHED - 1)) !=
+	    VIOMMU_VFCTRL_PREFILL_RESCHED - 1)
+		return;
+
+	mutex_unlock(&aviommu->vfctrl_lock);
+	cond_resched();
+	mutex_lock(&aviommu->vfctrl_lock);
+}
+
+/*
+ * Prefill every guest ID so hardware never sees an unknown mapping.
+ * Map all gdom_id to the nest parent domain ID, and all gdev_id with
+ * hdev_id 0. Cannot be scoped to IDs in use: none exist yet, and
+ * INVALIDATE_IOMMU_ALL walks the HW table.
+ *
+ * Drop vfctrl_lock every VIOMMU_VFCTRL_PREFILL_RESCHED doorbells so
+ * the 128K MMIO loop can yield. Safe on init: vDevice/nested attach
+ * cannot run until viommu->ops is published after init_one().
+ */
+static void viommu_prefill_mapping(struct amd_iommu *iommu,
+				   struct amd_iommu_viommu *aviommu)
+{
+	int i;
+	u16 gid = aviommu->gid;
+
+	if (!viommu_vfctrl_ready(iommu))
+		return;
+
+	mutex_lock(&aviommu->vfctrl_lock);
+	if (aviommu->domid_table) {
+		for (i = 0; i <= VIOMMU_MAX_GDOMID; i++) {
+			domain_id_update_unlocked(iommu, gid,
+						  aviommu->parent->id, i);
+			viommu_prefill_resched(aviommu, i);
+		}
+	}
+
+	if (aviommu->devid_table) {
+		for (i = 0; i <= VIOMMU_MAX_GDEVID; i++) {
+			set_device_mapping_unlocked(iommu, gid, 0, i);
+			viommu_prefill_resched(aviommu, i);
+		}
+	}
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
 
+	/*
+	 * Wait until CONTROL0/CONTROL1 table DMA has retired before
+	 * the backing pages are unmapped and freed.
+	 */
+	viommu_drain_mapping(iommu, aviommu);
 	free_private_vm_region(iommu, &aviommu->devid_table,
 			       VIOMMU_DEVID_MAPPING_BASE,
 			       VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
@@ -591,6 +679,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 	if (ret)
 		goto err_out;
 
+	viommu_prefill_mapping(iommu, viommu);
+
 	return 0;
 err_out:
 	amd_viommu_uninit_one(iommu, viommu);
-- 
2.34.1

