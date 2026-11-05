Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852220;
	b=PvKOnvudxL/6aGU/P30iKpe4KEAvAXhElCUS+OxlZPwaND8ftys1J6DoHpp+XYPbh2ZW
	 z5TY/t/WL2A46+r2tVXknAY8OSDS5np/rInoios/fgkxkgJjpukB6soBt16End8l05oxb
	 9hcQEBhXwFMDqit0p0XFzpd/wAziVJKPHa4JDQ7OeiDj7e25W0ufGeMKKzcu5hLIz/LXb
	 LmGyqS1Y8DgfGDCbrfKDB9fUtkEFnbCB9bAw77MNb2fUKbzzuWVD4fBs6cyabRxkunxku
	 E6GQo0IbF+rC1/twTSxEvJ6SHhLYuzuvxq7XiZnyks01x1g3+16MdTJcg7rQAt//BXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852220;
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
	bh=+1oZhB0P9/JbpbO7GDGV8oaLFrcDSNjbXAeexPjMhE8=;
	b=yfMIMuNHfHSPVoYC88bcykJ2byYakmSbEMBp8oQSYqnAHACey0Kam1L+/TWkP039NBjJ
	 Px8Tf+s/7fDzfKbDB7LSq5v2vqIOdFmX+CWy0/mEFwQxOIKau4C43x4JQVCV+wzND81+k
	 EhNo1CjapfbVyxMrRsZU+B8gfv60+WbpFFRi/qo9dOtFcs5JfFTEXQJnLXVks5IEraKEE
	 piFOoPwnOKEaHn6/8P8Rxur6scWc3xxP/ijJAw4h9E7qaYcrp095BXgrdyVlsqjUyXwQu
	 2Z9QMyjzaP6oIY5NtLUrUZtB01vmkd8XfP0XoTeIWyVjAWYFKaA6KfLtXpsVcBzDI8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AGmCvisp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.15
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FB606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 381FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AGmCvisp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPC/yN3nwD7cKPFRFKvZlhwIIkZa5d8jGGTDBDT23e+MO7w92/YF+Sst03sRFpfcYB1+nHXQ0sSQkm1Wyos9tnR0QY0OykwKwtlpd1ibmFeIekj4LrrS9qT/pugNbBFCbE8k5+qZOKjMaYUsgx6eNA2LRLbb/ThV6usCbhJLY+lcsbbjekGACorao58m1XZ5piXpnRnVv/pdBfaMx8ioRoOtt+0+7P9otvovJSXgcnac5m9wJTW5BhcBhTA8sRlp3wM1u2eT1GqZuTIkFXY1/4pe0tun1sxnrdfuiawo7OskBGhyd0x4Sns4cdHfgfmKUvdtEa90PNd5gW0BsWryLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1oZhB0P9/JbpbO7GDGV8oaLFrcDSNjbXAeexPjMhE8=;
 b=Of0KjwoAtb15AwD05Uy10ySYrVCTUWDm/jOtiEYjPdckkYSCXxqqLcD6zuDW9O7IQsAFFLMsy+IlrLlQWu32O7SroF2FwkzVyEQ0dfb+dNzWLBYwcncR8U0gGBgiAU4c7ooht1RR5dLOoJ2i/ih8RWSV2CVi/RXdZRGZ4MLJzWjm5fsGUmO//TCxaIq4n1ip6ALzBULI4nSsnYSaYX2mKwnYSUqj/VMM+HhWSfA+NiASECfZ1XBAcRpjxyjlIbIMqpYiL2mltNTuF6+ReiZGl52xIZWU3tdHTJsTAZXG5otpC+ok3s2kAZUIGQUf8CQbmc0hjtoB8c1jXeOuUXhQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1oZhB0P9/JbpbO7GDGV8oaLFrcDSNjbXAeexPjMhE8=;
 b=AGmCvisphHO1T+SEVQsArGBMu2JId0+VYnAkhAx0beJ6O57t2frAaI4QUe4dSnMsekwbWF2GjSWttbW3Xse4ZcpYMfaEme85tVSUSb6I6zyY25u1Pcwb59H41rgBeqewM90w/juEKHquHZysSyHl0EuZyAV/tPX557IFCtFb8Z8=
Received: from BY3PR10CA0019.namprd10.prod.outlook.com (2603:10b6:a03:255::24)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:16:57 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::1f) by BY3PR10CA0019.outlook.office365.com
 (2603:10b6:a03:255::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:16:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:16:56 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:16:53 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/4] iommu/amd: Hold the device mutex across a page-fault report
Date: Thu, 5 Nov 2026 04:16:01 +0000
Message-ID: <20261105041603.399016-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105041603.399016-1-vasant.hegde@amd.com>
References: <20261105041603.399016-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 621f7d99-6161-4936-e94f-08df3af3a149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|11063799006|5023799004|261009223027099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261022113327099003|56012099006|261022075727099003|261102123227099003|261026121527099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ph2JpUuWv6JNFEcHd9debU+zj431h+ZBm+yYpgcua5ge6/vxVtmfUmQ1JLjJ4GRsJt+2NEZVkNTiHzUnorFGOHIrlnZ85DSKAcaYg3b4vBrYI+Ex2DTjqX/9L+FCsXTlwe4CxYDkoZT9TOWlBFjStUd1uZfTCc+7M4NdaFBFmtiAbn6C4TvI70jEYz9tb4xX11COrCdnDVJUBlyBIo+GCbeM3L7rrLNrZeKUimaM0oNduxHPCOId69oISIlxpnw1u0lVFvqzwguOGHNFePoLA3mRUIVm95Y6Oxfc8BmLJuOmv6JiZHhLHTL4d0qYPRjyWSrmqmQPE0tieUx+K1tUO1OL+o7SUnrBUKZh/Ebp1CvG44LJCzTl528GJn+5/CaSkeomZxPgd1pCWdiJHWXttDf4X/+8L5UYRn4weZYV5N1AwVrdjmoll5Ok/Xa23ysxC0W2JsMjr9dIBdjYzN5CuOmZ7WwroiLwhoBPNDp8VxJMICJA2ufOD+QQI7ZlloWYFM5gG4426VGf+5mOzarvJp+2oG9yvJ6PhunVWwYazncoDY0jzQw/Ionwlbo7037p9HymvYQMIPgeguKMevMstXVw7VrW0wt/EjZIZuO/+x2qvTMm4Yw9PBkd3qzfOHJojb+sd7DcekN5BxL1f1uEtq6Maj/oFSKUSY7EZKThEUVXjrsbiuR9XpQaZbyqVVwv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(5023799004)(261009223027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261022113327099003)(56012099006)(261022075727099003)(261102123227099003)(261026121527099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H/O+LxZ59UGtqT6Bcdg+XPs5xv/iEI87aJ0HhY1ZBxcboSIRKPgkIghI0r+ZszfGkBDPEgdmNPbg3Qwj5JZ8rMzyxIrt3uSxsEmf/OckVbaA1aidiaCEYIKhkiyEnmSaMy+7piQxrfbnu+/4uRKC3X0hgR0sdp82iiPSYeDndOcb5Mu8MIWy3C0A3zIkRHPuPEFhKFNk9zOfj2RrneDHbGpIAE95F8CQTsCtmIj3hE0V7ehNQ6/f9uj+toQLaemek9Zl8QcIzDEhuvYOzLI8/fYhz8Uwrocqgfm3YVttAXt7llRcQFEzTp2mxc9DepitO4NeM7iDoA3h6dAg61ZVMLbOv292ItK3PZegP9MunRmtW+FigHpkISySitKGoFjfyp5eMgd1LG21WUhjTRItqcm1wrE+VMpjPEV3PPWK1x14htReQI1nwnkhi74XC2cL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:16:56.6067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f7d99-6161-4936-e94f-08df3af3a149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803

amd_iommu_report_page_fault() read dev_data->domain outside any lock and
then dereferenced it in report_iommu_fault(). detach_device() clears that
pointer under dev_data->mutex and the domain is freed only after detach
returns. Nothing prevented a concurrent detach from freeing the domain
between the read and the report, leading to a potential use-after-free.

The fault runs in the threaded IRQ handler, which can sleep, so the same
mutex can cover both the lookup and the report. Hold dev_data->mutex
across reading dev_data->domain and calling report_iommu_fault(), so the
domain cannot be detached and freed while it is in use.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2d475a35c2b7..0efe6a58f6f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -831,8 +831,21 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		 * prevent logging it.
 		 */
 		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
+			struct protection_domain *domain;
+			int handled = -ENODEV;
+
+			mutex_lock(&dev_data->mutex);
+			domain = dev_data->domain;
+			if (domain)
+				handled = report_iommu_fault(&domain->domain,
+							     &pdev->dev, address,
+							     IS_WRITE_REQUEST(flags) ?
+							     IOMMU_FAULT_WRITE :
+							     IOMMU_FAULT_READ);
+			mutex_unlock(&dev_data->mutex);
+
 			/* Device not attached to domain properly */
-			if (dev_data->domain == NULL) {
+			if (!domain) {
 				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
 				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
 						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -840,11 +853,7 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 				goto out;
 			}
 
-			if (!report_iommu_fault(&dev_data->domain->domain,
-						&pdev->dev, address,
-						IS_WRITE_REQUEST(flags) ?
-							IOMMU_FAULT_WRITE :
-							IOMMU_FAULT_READ))
+			if (!handled)
 				goto out;
 		}
 
-- 
2.31.1

