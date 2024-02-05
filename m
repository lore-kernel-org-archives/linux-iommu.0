Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D381BC53
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134314; cv=fail; b=MtQFgdrT4S8DGFsyBJ8cLXGdXhANyQEsZEx3CTmA3NFxSVZJ0NA3HP1O+HS0+2Gn07/3ba1jgxnaMqgMwJADVonanJQ+4n/R99oYOKs+hRirI/4IIERxn2fjbkgQLWi2T/zc99tTNlEmvHAylxzJp/0VYyoIiOuwKDIDJbCdh4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134314; c=relaxed/simple;
	bh=kAZnUgewA1jwn0G9V5Ihb5OV0echWaJzh7BHTFDNduE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBjkrk7zh/C26FzsVhjKtzVYKW63t1KdSXWLdByuIAMtH/2LMO+QyAmlHjidH4eyOWdhLvE7I405xopkU8NEU87MDbNNpW7CjAJ1M3VAMYpy68HLTSqJu+uCpLm4oGzg4vv68xT7B10W1NWKoiL+JVteFiP/AEAyVZjhDOy6A0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5SiM17r; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5SiM17r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMretGfrJsIhgvgbA4gk5vcngwvRSIdRavES5mUBg2u+BN0Yz0JgvSeQG0E87nO9b5jjmBjK2LuoDklOuRifuSL3NWgyD3bWihklh/Qqa3WQLoMHW+/iyVjCJ/RJcLNlCFVWF+b/ZR1CDACsFwgoW8+O/A7CuA6ATCMw4RJRbiIgI+cv6sL+n07CZF8AxHyjlG/DRl2mH/bTnOYwM3nUS34XeP1KKslhO+DLtw+2YojQzZ2YVU6/JVpKHSVautr0LZV6M9sEddUlLLIKjNRp64+rIYpzVEBum0O7P4RTYZBJ3w0MQGxF+BH8WvrLEgEFhpliRhCsiNnNs/GJc4djJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfW8UHbQgkEriilkFZgl1lo5QNhXEHd1FM5p3CgS/tM=;
 b=EGNFSd0f5/Kc26rASfwFz7xCyfIF10M0hdCdZZDNnPp4vRba8t9rsW+vMiWLmHEqWFt+OfdFeISiCYuAAkxFn6W4/TKlVLa/c6EKpDyKcTN5kB/atyOJDQ+E4ehER90Wq/OfzU/pGsJFo7cfeAS2iTja5nbg7a4u5ySYb3wuIf63evnfC1w3NOBN0TEk+lmI1I7hQn7xE0Ttd0EUxuBMZlQ86jjE/nK9+bJ86y4eLDprzGnTSCcGuZ7DYasG9ZdbvoKBGv5Iw0aZCUU5p5kiTxP7aqJKwiPtm5ieoyhLiLwL5gOPV0ALFVND03mObd5907kmGOP6MpqwX1ejuIsmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfW8UHbQgkEriilkFZgl1lo5QNhXEHd1FM5p3CgS/tM=;
 b=d5SiM17rnwqOZ1fu83jY0Jt6k5dtvnVo4ybUYPFBsVezSElDQVZPVUMvBRLkERfA3X2sfb+jxPr+makMk/MqTVfxQHm5JNKN7QwSg6Zinuo4vcdTOKBNnfbAGacHkSPdWF9XkH3VJ1UwXqhbuaf7yCKPPG54kE2hxVDvO2pXCP4=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.9; Mon, 5 Feb 2024 11:58:29 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::35) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 11:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:58:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:58:25 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 04/17] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Mon, 5 Feb 2024 11:56:02 +0000
Message-ID: <20240205115615.6053-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 731bb65f-05e1-4013-df3c-08dc2641c47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6zt/ZG/Pb/ksRUKzECO5n4EMAk644AdYXykcMi7JQSO2snjCz+j9iDuUF8LcB1S2+b5hbori+jKFSRHjkkdBCcbDK62rMTSqIl+3mmHqcLRIYvHjLJ8p9imYif1SZNl92jJogxCpEGmSAT5rmKoFlmaC4zfNH/vsk6fDptGnufgVcSRkgVqRTYj6vJap5zinETvvgo0IBuRDMKtn+k9hsxVMD9lhj00X8YTBk+Wry21oNVzdnmWR9PIS0c/W9FAXwf3BN9VvJanQQKNsN2/RVKMoGh9XeKRqpabgASWPj0HsV1N33DZhTupLxLnUnBjzi/FK+izcQur+B+o0PYoosucuwEOflWhVFQ6V9U3SDI23f1EwFZWXNNt4r1trjnVblgD/SiIAuB6Z3FF34H4hZjf07liEMfGglo+p25unjuLu+uXJSiwnAArzKv0sR5/xTmzkte2/Rm0z2MKLKaGujevQoGS47cmba1gfsGK/r1HXTrIysgDUm/FB3fi3tS5yZ7M3g8lOmf4Fr77I6xrKl0Gfu2kGRLBCjVZthvzwupaW2qoYz20vLS+fVJS20fauJY5NHEfJYOLwj7OnR5J8jmF/kg+BMRYLnwQghc5oRobaxKyQVAHkcNxc8eL4jsxhlL7PHgGOy8XNoargEh43fQT8B4dKGCgPfUuLOR7YirULJMfI0G+AGOoVfII1VLeUaIJkmZjHuUezDf9/wi0C5Wm8kRwsJEQxCXZPjveinpdVN+ID6upNeO+T6TLFw1E8HYnlhTj98N+tFF2YTWOw5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(36860700001)(478600001)(44832011)(81166007)(54906003)(70206006)(82740400003)(4326008)(316002)(5660300002)(36756003)(8676002)(2906002)(70586007)(86362001)(8936002)(110136005)(336012)(426003)(26005)(356005)(16526019)(1076003)(41300700001)(40460700003)(47076005)(7696005)(40480700001)(2616005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:58:28.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731bb65f-05e1-4013-df3c-08dc2641c47f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This enum variable is used to track the type of page table used by the
protection domain. It will replace the protection_domain.flags in
subsequent series.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ++++++
 drivers/iommu/amd/iommu.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 809d74faa1a5..934a63f64839 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -549,6 +549,11 @@ struct amd_io_pgtable {
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
+enum protection_domain_mode {
+	PD_MODE_V1 = 1,
+	PD_MODE_V2,
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -564,6 +569,7 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
+	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b82650a01060..8f718c4a0144 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2073,6 +2073,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->pd_mode = PD_MODE_V1;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2081,6 +2082,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
 	domain->flags |= PD_GIOV_MASK;
+	domain->pd_mode = PD_MODE_V2;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-- 
2.31.1

