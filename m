Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543A748D
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UuL+HYrp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md9ohdAKWNmUqhT5/v0Cag8I8iyE3qRg4kMbYfsg1dtU5rfqqqPZvoOjRXWrEFx6lyPiahoi9TAKcr6QXGJQcd+5gzN78Gx/a70cuK6YqUZBaFHW3FoiGg3NG98XLBNENuv5d/B/Rh8zaebS4LdoVP/FaUn1juJ6nA45o4AJTALAgamtJADpebKrgE0ErLkpYMBjMx1zLhkZk4TuLyi+iTyPvSB5NTVyLjvOle3t77qEtiqed5bSqPBDEZTZXhgf0OWgPvJVRgFetgqw5iuh3V3uVy5ZPEwqI82Kffh9szwH10Bf6x16p0GwbY+hiJkReeHmR3lYJ0pBu0Qz/PLIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwDmghVlyHIKu/eWWKs4hLQTV4glN001WB68N6U1S2Y=;
 b=ngO9yJJ0sMZ31Vqq+HpMtfZ3FlB9cF87EmOpfeIHzal2RjqLVkylaGvRQo71osUs1bvg4/HkTDOzW2RAaAEp+T7aVprZ7gPv88tGprdzCjfEEsKF9f8giPYiE9e6d8efI07vzD9e7Dnk6DrlegDP4khKC0NKE4bab0sACax2uA/Ly1NFflPXSHeh+otUsbzET4KyDgGzSJfx8tdcSHzwNO/ndGDe5M6ONJI2rCzdGZ3p8VsRwND0Oz2r3YC+puqIkly4IGxD09xGlcPV9/0qTOhT2uvNARe19FMUPvIJ6F4JD/VM1IlTpFH1Vf+A0o4RIGHJKOrQMncZFurXMpNt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwDmghVlyHIKu/eWWKs4hLQTV4glN001WB68N6U1S2Y=;
 b=UuL+HYrp9Aoyxi5TU1cj+vlWZbyGwrxbV/EVQt8gOuK+tGGZfpXYovXxJXnWG4b2SorQWbyzFLCc60vQb8ujwTv86BCPg1YIXLE9OjXy7/0dExTNFYdE9lQ0g/VpEnEdv4w3eAuTGK9IHlUiwFEmCDSQcEP7DdLDKpfm5QozhRA=
Received: from BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 16:54:14 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::1) by BYAPR04CA0028.outlook.office365.com
 (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 16:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:54:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:54:10 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 01/17] iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
Date: Tue, 16 Jan 2024 16:53:19 +0000
Message-ID: <20240116165335.6043-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: a645815b-7b78-4624-cfef-08dc16b3c52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jV+fIlMXFlExru9Lo+2BFdFSl1+dhm2D53RMKjCNrSCM3LhB5jeGqy3L6Uh1N+NUahQc72DkbYWL6MrZmWfqqLW6qgK0YS2Gz8Zh6da/u2ejQ2XrGGJe5d3mf+HXvcza49ZEP4jI/9iG4ADBxxnmmQEGL63fYBc4x1LRvQhTyZB5yFVGZg6220M7OINDscwG9Uw1r6rmE8+XXoi97txnhB1qY2ZsDja+KFPEDc16UonbPrTx74aqpjwsjEaL4CjuGSdPzP+fRnuomMJXyjrPVey1gJsCjAkejCX4C5bRhkxsUYlkBFFAqYwXpwvsUUoC9qhhCMZO+9PmfcH0M4XVtZpJql9EpRm9qnpc3SDq0JHmoKnTonT8s3XPq30FeAPe/GyS1vM0Q/LklmfY0P/Q0qng8eTzuZfVD47sQeJ+wl8TnWzX9fwwSUCmGc2Cnlx3Va90VO5UHr+06WqIDKbzhD0Hc5FV5kJGBbWKwbZAYLHNsfauXg7QdIwV+H9KMwZca7wp8fK16P53ku890iFICBK2H9Auz0V2QnNp2Xa6WOaiuc8xdcEBKZKs8/mZcKzd2+nLCtOPKtPs8ZRZRsgxJjz/5i623jamM0QZCqacyliTAWQy3eQx0CSnhtz05yKTb3ufCnJTnIqVbMH6ahAk94hCAM64AF88sCSEVkCA7rm4Iby7wnqpO/Kght18AILAYJXiF8bHns21xhwsgb82ukpAXSQHvBTh2d22ASn7QwGDV6UFrELwWNH1p0Oady+kxtVIajUMs0TZbFxcQY3k4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(40480700001)(478600001)(356005)(47076005)(40460700003)(36860700001)(81166007)(83380400001)(336012)(16526019)(426003)(26005)(2616005)(1076003)(7696005)(8676002)(2906002)(8936002)(5660300002)(44832011)(316002)(4326008)(70206006)(36756003)(54906003)(110136005)(70586007)(41300700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:54:14.1366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a645815b-7b78-4624-cfef-08dc16b3c52c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

Pass iommu_dev_data structure instead of passing indivisual variables.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 92d6596bdfff..77612142f436 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1704,12 +1704,14 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
-static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	u16 devid = dev_data->devid;
+	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
@@ -1729,10 +1731,10 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	flags = dev_table[devid].data[1];
 
-	if (ats)
+	if (dev_data->ats_enabled)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr)
+	if (dev_data->ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
@@ -1808,12 +1810,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
-	bool ats;
 
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1828,8 +1828,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2013,8 +2012,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
-- 
2.31.1

