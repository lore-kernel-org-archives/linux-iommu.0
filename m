Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825E1D79BB
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115237; cv=fail; b=GM2LjdaXonlOdmVfW4xLexAWLxGIAhn2Nc+CbPEkzHBB4APBBwKDw3Mdzrg7QeJLNUd5XfRod36/67NNqi5NsvE8HH9Ro+W9n+lVAe9O9P2aCYLXaUe8HOoYKumAbRa0UIgFnGbZ4Bcd0mvNB0WV4szhmtVb9ZVZs3yintkbSDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115237; c=relaxed/simple;
	bh=Wpg3CaZe5mCA4fVISlznwtrTj5U8vLXJeItAQpQVO2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3P+kXFk7Nqgcz/Tir8urdXE3zQAENzWKO3XnvdKBKTWCtR9dZAUFsp6V+Jzm7T90agk7GTyA+mOhG74JPK3ZwBLPFUj9nfPpYKd6UfskAZUkepRaQkGoSGBm+TbNhfXDto4FWoxkMZivbsSK+DdMoJbpwasd3vNuf6GEUEsN2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jV0rzFOx; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jV0rzFOx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBsvuAtxh6GJ4H36XM8BCDJ3kjuxkytO2of7Sp99GyBzF36NEvMt8/ShOVe2w/BWPuog0hg8EmcdKYSk1oSelWRJ0hS8nXHKZ+/IOLW66I1Cuif+CclJF2tM3CdoSsVTHH3gGjuerMc7JB3FbVc2ezEWtDlltVUrGU4nIOr2lN/cJEBs+gd7ayX+LY1xICRfUy+tIBbMsHMiCjOJ1+KwmBu6yRwaMhARVVc+CfcZ+icQL+NFXAD22g13vWn4VcZB2hXHM+ejLc/PvmQtfvULL9tzytGp5t1DMsR3JJfCxu62UwUoxQ2m9MK8lyTxbNxlVsttNkPUaHtx22P/zQL5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4KbWzyAT7OX8dYigvtSaOIo0FCCc1nqOl8bV2QB90E=;
 b=jcDMxghb25+sarP8+/qycBPicPpcwdNdrrbu7I+70Y4MQZ7Rt01L8Eop1m3XyeaCk0PzYVd8c+uCgCJ+K2i2LCmptt1P8gmjqN4ciMX7zrHJBo3Fzw2Iq4xg+gyLFEMRepRXqQdqoJAoqcIyIYp7UJV2sHUtcPhXePdZmfjuDYEHQYi3Ea61c7By9pE3OftbMciOw/fbahIpcBQ6Sr+IFm6OmTsWP7YTCZpEq4GLDS9k7qvmLrjOrhtd58iRJtwgoDbAJI6T96bvx3UFEGtEZsqwS6Q0rnYLfF8G5CzBCQzdSE8xMgVd8WLjrmsPxTurP+B88Qjge1TEPhR8PJWDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4KbWzyAT7OX8dYigvtSaOIo0FCCc1nqOl8bV2QB90E=;
 b=jV0rzFOxD5uxO4wgo1tGW0o4LZAQ/Tw4+6O9ejIOBPntPe18e9Iqfvy2XrQdPIVV8UpUPKycltpdnWI+bAyyCDkkVtjxVMSelO4meulwzByPBWXoos3kg0Z1ooFyFN8HWoGhBgiZVcVYsCDXQcg9Bebr8hjmj0pLLXrv48AbLVs=
Received: from PH7P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::13)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 11:33:52 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::83) by PH7P223CA0013.outlook.office365.com
 (2603:10b6:510:338::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:33:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:33:49 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v4 06/12] iommu/amd: Do not detach devices in domain free path
Date: Mon, 28 Oct 2024 11:31:42 +0000
Message-ID: <20241028113148.5774-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c31c7ec-b4ff-4f8a-b795-08dcf7446637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0SKftGh77JvqxpodIGAuFy9tSgCh9DyQsVQkwkipK393mfmVeuYsLAtSfwjS?=
 =?us-ascii?Q?04RqscrPuxPp9YPLXIo+WRt/1NPTsulPVRohcU++/GluunNRsRzmAh41W5tE?=
 =?us-ascii?Q?5udEQVcZ+WlR+R+BIk0YY7rf8R4uzf2kmcxtvAMx1ARfd9dMLWK0hxBvQbte?=
 =?us-ascii?Q?DxzT8Vg+NT7+2nKJy93Kt3nLCYCMg5MqQGx0fXVhMMksu4VqtL6F9gEkUK2k?=
 =?us-ascii?Q?IRJDT5zY5olTLvUJlGVGw9MWh+TdBgJ6S0n8q8TCP/CpOzsH6IHgyDk8p3iX?=
 =?us-ascii?Q?kI78Wi9kSjtNEA8HEe+W8RKga6B0YggU7l41KUpTkm9mwFksZQy/rM6Kyx7R?=
 =?us-ascii?Q?RmB44ezxzGcmm70vwmDHYVhVlEg5HJWcMC98+xnLtr0KmHK9Hr/1kjrEYJ+I?=
 =?us-ascii?Q?8DendoPXasA6RHHosEKWhDed37W6CCrmy1Jm+N89Sh73rtDyCjvHKu8/MMCJ?=
 =?us-ascii?Q?SrEaXS4to7X3dLYJ98nN1SZ4aibb0Ejz73yNxgT9COxvAUA8js0crXU3Q5+h?=
 =?us-ascii?Q?E8kf1fRyDUloUo7HFf7wtUbqgCcjF9zXz8a8r8Qe3CHbMOkCKEhm0XE9bhZ2?=
 =?us-ascii?Q?cQKDbwygxJ1j9YrACejQfDJA807NbherAauy5damZehnegFK0VUnYqytWumC?=
 =?us-ascii?Q?UdYP15UYyDg0jA3S11LB/mxyr0ecpJ3JBCZqjnv5ClQ5wXWBZUjIRsQzrWXE?=
 =?us-ascii?Q?hcJvKIzZvlqpybaIsJYsiNATTsiUObQdjXDQkHtme3fExzHxgh/dfJmwXBnR?=
 =?us-ascii?Q?7ifWshBp0Eu3SG/Y+F0jXTr6sY0x30ivWMtel7ClIHDhcnNyzMU1Re7L8fUb?=
 =?us-ascii?Q?hj3qjSJAn1fWVB5EGmP0tZW3eYiF1rQ1tn6b7GH0l34RAPY2pCXYqpe2kdGk?=
 =?us-ascii?Q?H6MPqlU8aE+9O7HI7ByPBs5UWzh28FbU/untA+X5Uy6aTZN8SCJwN/Ukg502?=
 =?us-ascii?Q?wMK0Zo2WYxa9a59G3NdO6TcxeOW038E3uLIz9nCkdoGeKg6v5a7cq8g8hrIK?=
 =?us-ascii?Q?A52iB3WVBSoFkZYBlmNBEnlxmeqS4ZrvZbOplZ4klkqq9QtPINPWiafP3u3z?=
 =?us-ascii?Q?LMtc4nzUGE8JMGT3iOATKVHAi+uIyHrapDbs1tqj/SK+n+5Bp+AH7Gxwji/U?=
 =?us-ascii?Q?xMJihFOWT7J7xsrXGvSMh/p73/YGagxyoDukluPHRIlZysugKsEKDac+/Wjl?=
 =?us-ascii?Q?aP7G6HcEYRQStw4OzVBm2+kTq2/+YGglj7jL1gcPwlpiSoiz70vduXL0q/4V?=
 =?us-ascii?Q?Y2d4lL0woRGdN1WjsEKa2ZRRhQI9Eee8jbtMuLPK7BITaPrFv6esOa1SW4hN?=
 =?us-ascii?Q?8282jgIPAj/f/Gm89cHk4AZ67kPlsnZ7z7dhYvYkbGmTqhkhOTm8UGxCd2gV?=
 =?us-ascii?Q?Gpl1L8d7JVA1AamoxvqbO0o+V0R9zneZtWpzQdSg0t181sS0oQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:33:52.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c31c7ec-b4ff-4f8a-b795-08dcf7446637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

All devices attached to a protection domain must be freed before
calling domain free. Hence do not try to free devices in domain
free path. Continue to throw warning if pdom->dev_list is not empty
so that any potential issues can be fixed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 12389ba1e542..8919642a5bd9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2276,21 +2276,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
-static void cleanup_domain(struct protection_domain *domain)
-{
-	struct iommu_dev_data *entry;
-
-	lockdep_assert_held(&domain->lock);
-
-	while (!list_empty(&domain->dev_list)) {
-		entry = list_first_entry(&domain->dev_list,
-					 struct iommu_dev_data, list);
-		BUG_ON(!entry->domain);
-		do_detach(entry);
-	}
-	WARN_ON(!list_empty(&domain->dev_list));
-}
-
 void protection_domain_free(struct protection_domain *domain)
 {
 	WARN_ON(!list_empty(&domain->dev_list));
@@ -2446,16 +2431,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
 {
-	struct protection_domain *domain;
-	unsigned long flags;
-
-	domain = to_pdomain(dom);
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	cleanup_domain(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	struct protection_domain *domain = to_pdomain(dom);
 
 	protection_domain_free(domain);
 }
-- 
2.31.1

