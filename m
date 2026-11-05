Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896428;
	b=uzdfWov6uaEj5udm50E1ZaCSwOyl6TmYt6+5MOrFamGFl3boqB6Lfmg9w9mcNoVusMs0
	 JOgiDmFiSIe2F6rm/Td/LGYVu3ZDVqf12zpVls8oQfyHRDtbY36Uz1uzxmBDnMGq2vjEC
	 QpOM6Nn1uGgxSXe5piXuuJLsV4207u9pDVZ35TKiIhIu4VJUy++uZpAxD2Lf7fFCZplcL
	 Hxgs/bVze8zUgXfk2bfSjG5/6h84+Ef5TCsByB/e/+kz4+0HmFeucvJB930LC+yDmiaXE
	 OAo/QIpDc4HSkSTWU159BTQRWsmhYbaXCeyFDr1p7qvW6d3qGOBnlcVVnQyRACVU8BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896428;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SziyfPwW19THzCQsalsscSkzSYbMYPtuNchkFbxqU2Q=;
	b=zNdgfzznLV3urLk0Eay5v2OU8nRRr7MTtiCQWO4F8ST2xkK9G67sVI2uNYIReA5Ht5aZ
	 N+rzAStAObypLiFp+twHcDH1o61iciEiH9Fxm7empoTLrFegZt/dRixCVgYWePm7KuQ4U
	 LJ/8C5ABPRYc8SVZagLrKeJaGEH4zOIjkBhBlM34Jll9qRd6bxorxzuOCNdKMkROtA0+L
	 iX/SAs6lh+PHdC09CZ3bF7buI7BsknylolOfaOPu3D4SACC8AbJoBXBQFGc1whO11CCKz
	 43voGaJncSLA8gwqDzb6lLwyCmuGOevlYLmgLRPaUPEC7wVc3kdzw4S8Rf4WLY+8nCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hemr2yds;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.15
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B08B606A330
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B08B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hemr2yds
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMdg5zcDYWyDLz1EUvUT2HlC8ZSXV/YODoNaHdKRdMlTnu6/qGuchLSt9ltJt8dR2zZl2V7XzlHtZm4PXvpqONUhCbQL0PxK2o+jVixsHxnFCKzwbe8bcGvXR6Wzk+taw7/lhdI4LYCwq3SJW/9ZST96zmh6K4Of0zkLMAx0NjltJD5j5FmbZX75IPANJpr3vBJDpscn6UTvfpKyHi3GXg4FvGPt7yWUSNvbugXRNIw0j4qAETnT65gNt1phWR3QfFAvkmj6tkeZfN+2OSmdtFj4pZ8kCmLkmEKQ0xUSeo6zqFTniYMlZGDkHiVr8xUCxCsmubfyLsonx2KcKL5MwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SziyfPwW19THzCQsalsscSkzSYbMYPtuNchkFbxqU2Q=;
 b=lO8ncG7h/gDGbo70n/hdjD6F9O5WVIiFCnohlxuCXEEfpHQjHfLfngOHQcF6W8kVXIZjQ418MP6+yGxBgn4T3lo1wrDuVUBSNGm5unmWxjLjQt8vEFk+SJ9/W0hUyFrxpua515rIogEFHxs5vpI4gTww+Knhw+1wsgrwX8luAGl+stYeqlSncKi1XjhIt+1m3waKTVi/nxkMJSagFCC3on3VGcD+9VkSDb909xhT6hJmFxqGL0EBrc0VyYkVyzCkNnK98a7Tsx1H/QV/QF7q6hBmzDaY/d+Kiqzk77LJkV+ADT0jbCTogFWtSdJhJwXyiUzNCgerpDMl+W6rgmK+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SziyfPwW19THzCQsalsscSkzSYbMYPtuNchkFbxqU2Q=;
 b=Hemr2yds8bz+vc0OkfI1W6lwmj4Lg28ytJBMu6dsNbdgxuplBKv1wOyKuOuaDdxsaxkNs3fbbiavHvmDnlVHS6BBH1TcfvKKy1fyet7rlTnTTaCUPPA1CsBqvi2QfqtNqil2TQIDXVrNzGRVk9qC8yHL/PK5NS1Y6q7dhBulrbA=
Received: from PH3PEPF000040A2.namprd05.prod.outlook.com (2603:10b6:518:1::56)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 16:33:41 +0000
Received: from PH5PEPF0000002A.namprd04.prod.outlook.com
 (2a01:111:f403:c95d::b) by PH3PEPF000040A2.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 16:33:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002A.mail.protection.outlook.com (10.167.243.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:33:41 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:33:38 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>
CC: <iommu@lists.linux.dev>
Subject: [PATCH 4/5] iommu/amd: remove obsolete domain pointer warning on release
Date: Thu, 5 Nov 2026 16:32:18 +0000
Message-ID: <20261105163219.601561-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105163219.601561-1-vasant.hegde@amd.com>
References: <20261105163219.601561-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002A:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2c3808-a4d8-44ab-b0a2-08df3b5a8d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261022075727099003|11063799006|261009223027099003|56012099006|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261021123027099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	My1YBdpmHecgfYsZr6OQxwyWrMdRhpKD+jxsc4MPYVjGcN41h4JG0bWAikU0+JyYT5RvAmIYQHfeZllp3RT02F8JZuoZZOLgRgkJYgMplqrIL1njt5gWGSsOc4tCnzb4Sj7C7pVCSsawXliON7S00WKaML/3QfUPsO4rwbas52N3u+fQf8bo1Q1W//fiM1zKwzLBLcpdkE8mxdNfvRAAGq1dR3Lyn/Eg7A4QMSwjB7jpxrBb68FH8UvwM1fGtYN14Sxd0r1YwLsyMRXvM29+2XUgHw5pwVoTuTaJz5IrcHSco3FniRwgvYzy/RfdkKtUfDX/3bzGutCT4FpcYBWOg8cAfoJXkcFb2x+S/ACKjmULrhDZ6qF53LoEU+G19nAM3FsuVT7GWVlIIY1kOtvuArjVOvzdoxFWDWHPsqaMltyvwwetR18h4e7PX1Wx/BsLMCTCpPHLTEwo5rNiOcLLKgSGHJ1tswlsWv2F+jaoznnKfr42PM3gSZ9mfATCyLqK3ijsXBv8iZ9QRyxO+yJE5K2X4O513VJqeMxYzBsSbHgtGo9sHMSPDZkunJmY9j32xWPjh7OR3mPffblhYiyeHG9Q2N4Elu3KgiiEr3haoS8IvW6GDYQGI/JM++7v2lGBEfRUQdiPRCJH48BNhyu739Ve+MbMtI8I/uK/DEv7Toii5E9+0sF3xLeYlC8WC93cQEa9DAyftJpeLaU5bZyGiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261022075727099003)(11063799006)(261009223027099003)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021123027099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hEW9Sa7XhNIKPWBfZpWWJTvJx+BfhRC9bquO5boWQiX4uYbgmbco6NJoF7I7unK5xQI/xSDYkcnkEM7GZmbA82+3wiGh87yh8oU+WLGrJp8KFd4Wke7wgSLZQd5RsxLfuDJd1DFvrLj3nEozlN60lacfW0xq40w+VpkSy2hJjtDEouzMR8/GE1rd1SzLFMgGSE8HlxG2aYxnJ4JWOM620khcddVEfWFUu3+7jiQPcOhX7SWXBaFvt1W6m1QWfhU11PW6C0alaOCZN8JVOvSFcFWp+oUZsWjwEMb8/Qio5BPfDHXQaKQwN3Z3FjLa11PxPc5nLSjjkI3CPgSyRqF+aeG/JJwdB2oRxVYjobW9e5dAfZtwXLJ2fQ51555R+LSyPToSSHJ8OCA0Mew8Ul29gZv2zKwnZeansPM8ZDPfRo9uTtbVXc3e8DbltSGyViTy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:33:41.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2c3808-a4d8-44ab-b0a2-08df3b5a8d48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624

From: Kevin Mitchell <kevmitch@arista.com>

A warning is triggered in amd_iommu_release_device() on removal of a
device with an IOMMU_RESV_DIRECT region. The warning is based on the
false assumption that correct attachment to the release_domain will
always result in a NULL dev_data->domain pointer. For devices with
IOMMU_RESV_DIRECT (and consequently dev->iommu->require_direct), the
release domain is the permanent identity_domain which sets
itself to dev_data->domain on attach.

This behaviour was added in commit e94160488e65 ("iommu: Generic support
for RMRs during device release"). Commit c21b34762e2f ("iommu/amd: Set
release_domain to blocked_domain") caused it to take effect for AMD
IOMMU.

Remove the warning as it is no longer strictly an error to have a non-NULL
domain pointer. As this leaves amd_iommu_release_device() empty, remove it.

The warning was observed for a device with direct mapped region:

/sys/bus/pci/devices/0000:04:00.0/iommu_group/reserved_regions:

  0x00000000fee00000 0x00000000feefffff msi
  0x000000fd00000000 0x000000ffffffffff reserved
  0x0000fffd00000000 0x0000ffffffffffff direct

Upon hotunplug:

[   28.715475] pcieport 0000:00:03.1: pciehp: Slot(0-3): Link Down
[   28.715482] pcieport 0000:00:03.1: pciehp: Slot(0-3): Card not present
[   28.715601] ------------[ cut here ]------------
[   28.715603] WARNING: drivers/iommu/amd/iommu.c:2521 at amd_iommu_release_device+0x5d/0x70, CPU#4: irq/29-pciehp/99
[   28.715657] RIP: 0010:amd_iommu_release_device+0x5d/0x70
[   28.715687] Call Trace:
[   28.715689]  <TASK>
[   28.715694]  iommu_deinit_device+0x84/0x110
[   28.715699]  __iommu_group_remove_device+0xa8/0xd0
[   28.715703]  iommu_bus_notifier+0x48/0x70
[   28.715707]  notifier_call_chain+0x48/0xe0
[   28.715712]  blocking_notifier_call_chain+0x45/0x60
[   28.715716]  bus_notify+0x3b/0x60
[   28.715720]  device_del+0x259/0x3b0
[   28.715730]  pci_remove_bus_device+0x85/0x100
[   28.715735]  pciehp_unconfigure_device+0x9d/0x180
[   28.715743]  __pciehp_disable_slot+0x47/0xe0
[   28.715747]  pciehp_handle_presence_or_link_change+0x80/0x5e0
[   28.715753]  pciehp_ist+0x162/0x290

Fixes: c21b34762e2f ("iommu/amd: Set release_domain to blocked_domain")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 54465e041155..91981c8a9614 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -488,6 +488,10 @@ static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
 	clone_aliases(iommu, dev);
 }
 
+/*
+ * We keep dev_data around for unplugged devices and reuse it when the
+ * device is re-plugged - not doing so would introduce a ton of races.
+ */
 static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -2551,18 +2555,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	return iommu_dev;
 }
 
-static void amd_iommu_release_device(struct device *dev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-
-	WARN_ON(dev_data->domain);
-
-	/*
-	 * We keep dev_data around for unplugged devices and reuse it when the
-	 * device is re-plugged - not doing so would introduce a ton of races.
-	 */
-}
-
 static struct iommu_group *amd_iommu_device_group(struct device *dev)
 {
 	if (dev_is_pci(dev))
@@ -3266,7 +3258,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
-	.release_device = amd_iommu_release_device,
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
-- 
2.31.1

