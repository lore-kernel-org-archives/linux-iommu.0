Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431191CEEAB
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478244; cv=fail; b=No6uh49fdX03pyDqgK9snnkk5peXkLEpQ8MEQQTzdjMAdmZMshgyn2vSpxmp9yAKX6pjtUDtfEXg2ey2n1auo+NN3qvh2BYBRtTuOFtM4cdFB/Uom6a7zyE3aRRTq7VGaZcU9yufa9hlY7RWkw3ZUJK2HH/neMAb6sVxnvdH7D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478244; c=relaxed/simple;
	bh=pD3CmY8Vf1E5rTziOoui/AnVhcJWQmAJJ32cDLUAJww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYU3KmbxZbEBDbSKWmfgfhP0CVEsFdPRPRLVWVnxD+aTX84Pfp6d2pWLYS3eGZNtW0HtyUGYXJCpngKFnk5vxuVSJakErBqv5IqEIau7HLTM3WLo27M4bzF/ac0ObV3ZXgZtZfhnjvy5NjKi/ty4ckQuhp3u8FpmfdxcKzVAWlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wpsokaNR; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wpsokaNR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2dodd/10wDxc2MVA/NQrUCCUJuMWOsXnkq432zlgZsdParLHJuL3jl+sU1HPvXl9d0SZzeWNi3T+Bi7BBh2zPivcTPf3DYgIHjqZ0tOqB3gBpJ8kLt3QfPtWYlsRf3wdLTNbTtzzPAgY0wFvSI1FliobW75xO9bfAzVT5dL3cJ8uCvm232ouH64xuVJUWBbDVXwKy2zinIddJ7eXBEv6JU7UhuWPOym5jFDHnDIKJciQQAJXojLGXa1vcDRPlJcLz6duNb0e+gd4I2MVUS7nYfq4Tl4ej6Tfl2QX8s2yWS4GI+nKYNjzVy7z+tJf3pUF5s/w5Xznxv997AGtWon6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=lSKpxUanYCWEAen7nHi/6rLaz3C6Za4/BeAouDOZzWp9WdQGAXOXKS+TeeOBtWtFe9qmPfkxBFHHrB2ZySSB3o88+9Rz3ZrOc+Fw5KT3w4BXX4gNHt+GAFEIuJIiq/6fvZ02E+ZsLeCD4Y9EJMVY5fdspTlL+iWDbjZLgpoltXlIyL3xbm/QQSYWECy952U5WarOnWxDTg7kWEW91T3lGDqDzA8sE5+VoUVTm3Zhie9Rvs5vPOkpv07d/50670RfRuNFnDC4VAmJ8vPo98GU7GD8BfyQ8b+jTi+Q8KXjgD7slJH/aPNFOd0cCabiNmKVfTHQr/0yatNR0bWuGmCSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbvGlNcV3r/+rLNLwnQcH/ZmbvXRuw3wEjKIZO0sv+U=;
 b=wpsokaNRxuieNUyMII0Ynf8m5Qxcs6Ly9APYdhdEXHlaV3ZRsXQoAomv2OZ9wZvBGmRBHaz+6A4FPr2mMRCXtZlUcxVr3k7fMc6vtX2Q92xZNB9DNfaMSOywIoSeETcXsTE5VFF0ORMPuVal/TQGf09VzSSQ7ZHQNnya7uHT/ug=
Received: from MW4PR03CA0200.namprd03.prod.outlook.com (2603:10b6:303:b8::25)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 16:23:59 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::dc) by MW4PR03CA0200.outlook.office365.com
 (2603:10b6:303:b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.36 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:58 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:55 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 10/10] iommu/amd: Remove amd_iommu_apply_erratum_63()
Date: Fri, 1 Nov 2024 16:23:04 +0000
Message-ID: <20241101162304.4688-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: be0d0904-4f6a-49ab-4060-08dcfa9196f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hdC/9eVSQ/JTgOXGJccaOuNW6Lz5dVmieQ9ktIVmbzU7MC3RQ8/2C1CkCbhi?=
 =?us-ascii?Q?+QtTYy57Zz5/gMczPog3ByppidQprZxKnLin4qBfpog1KDxVGT/FcGU3J7sa?=
 =?us-ascii?Q?FQIXlNqUa0MvBz07ShUY2e2YL6VTxpHoaJ5C6DSmqAVyt4Q8f5kfycB6f+2q?=
 =?us-ascii?Q?syJAoUml/ELbhfShwVlm4WYckGqtreSdxV/8mfnhnXWZv+a7eqfEpQh/ReD2?=
 =?us-ascii?Q?vMBbj4U8TPSuTwt7T4gIVshLZvVcSPUErbd01LLGsB7nrEEJyLv36ZbavBq0?=
 =?us-ascii?Q?4B0/0dnZyY4ZLnSRJ86Wn9P8yEf/tJkd0pJSHmIsVCHka+N+NsIFSW4VOWC+?=
 =?us-ascii?Q?WQapdA7Ydg90OH0WgAuPEEtZM+hytOSeHSYsddshhmB4CvYcDgFUGcT0ZYD7?=
 =?us-ascii?Q?9GBBzegHyBALe0X0X7ngFaUycrVXP+aGKyl8dhynfqMRfDQ/6IOinFLSZfnw?=
 =?us-ascii?Q?XO+x2rgxnKH+Ofvb7IZN6zZPIsEheAWwCU4rPkGuPZY4kN8FDr9rXyZHM08R?=
 =?us-ascii?Q?dHJsCHEKNk7UguVPt5rAlH3GXPhLDjFzNuu6uCauiea3xGIvLHlZInYII+zx?=
 =?us-ascii?Q?npnq6RaScz0gAjsCecJLpmHqKxJun7UwzbvtzoL7Z7IqqkHVIiihfNCgesiN?=
 =?us-ascii?Q?FciZcxlGtxrpw3EsWxBjrL2GMCq9j9r6apkLKdGl5LzL/VyfnEUBdHqGopMb?=
 =?us-ascii?Q?o+UBgfu+2CdCZ1s85jUgT6SrdZeAk9eVSgvLDHlPnneppR7AiioIpRnqXYGF?=
 =?us-ascii?Q?0DnfHmMOxf004W1/yz6srZwr1u2wX/r6UhbfmQDKvDgy7XCls68j4ag8Udiz?=
 =?us-ascii?Q?/kBFMQ0qJ84SIqmAGXckj1pVkEXbcYT43IamQLIpXIqQTvNF5CL+dOzFRIRQ?=
 =?us-ascii?Q?Kn6El6W/IJjxo4NAGFGsoel4oeGZYZmdp4n5OB0H9W4P8JQGk0BYCwXi6Uel?=
 =?us-ascii?Q?9PSXIUMvRIA9EqtBA2IgaVeUg5+an6xU/79GZbzl2gVddPliLF9R9/8QO87F?=
 =?us-ascii?Q?7JLasFG6Wgyh4lhKvd5JCqos4BfnRWj8VuyxLuyLIFzj2ke6C/W0GjiEXwa6?=
 =?us-ascii?Q?laWsD59Nel262x8lJNITKB20QGVnjHaKzwSnObg1uue9BbczpwLLHdUyB5k2?=
 =?us-ascii?Q?JJwrb0daLBw2GZSJkQCQbeK360DRAfbqMITHkL6UAcxrVHktB43ekWlzEOk/?=
 =?us-ascii?Q?rk+HdU2YWnJD+Xkd+ksMoeayIX51EEj9ErAohbYXqKBC5eY/i2JQIU/BRY6R?=
 =?us-ascii?Q?OwWFY+fT9bEZEhjQRO5gnpn9ywpqlrxD7ssu+6HF6zU8h/AxZlJNGbCneT7M?=
 =?us-ascii?Q?w9x5e79sDy///qj+z06Wcm5mhP0+ShshI86Am/s+0b3qBv5wYkjMGSTB6xrU?=
 =?us-ascii?Q?37Z4EKVvR86B6VxdXVKvhUwvVEQ/+HYyXCHAlP4MtnYE41HW2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:58.9065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d0904-4f6a-49ab-4060-08dcfa9196f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

Also replace __set_dev_entry_bit() with set_dte_bit() and remove unused
helper functions.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 50 +++--------------------------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7b43894f6b90..621ffb5d8669 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,7 +16,6 @@ irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1e4b8040c374..41294807452d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -992,38 +992,6 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 	dte->data[i] |= (1UL << _bit);
 }
 
-static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
-				u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	dev_table[devid].data[i] |= (1UL << _bit);
-}
-
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __set_dev_entry_bit(dev_table, devid, bit);
-}
-
-static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
-			       u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
-}
-
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __get_dev_entry_bit(dev_table, devid, bit);
-}
-
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
 	u64 int_ctl, int_tab_len, entry = 0;
@@ -1179,17 +1147,6 @@ static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 	return false;
 }
 
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
-{
-	int sysmgt;
-
-	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
-
-	if (sysmgt == 0x01)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -2637,9 +2594,9 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		set_dte_bit(&dev_table[devid], DEV_ENTRY_VALID);
 		if (!amd_iommu_snp_en)
-			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+			set_dte_bit(&dev_table[devid], DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2667,8 +2624,7 @@ static void init_device_table(void)
 
 	for_each_pci_segment(pci_seg) {
 		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
-			__set_dev_entry_bit(pci_seg->dev_table,
-					    devid, DEV_ENTRY_IRQ_TBL_EN);
+			set_dte_bit(&pci_seg->dev_table[devid], DEV_ENTRY_IRQ_TBL_EN);
 	}
 }
 
-- 
2.34.1

