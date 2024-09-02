Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0415250F
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256685; cv=fail; b=QeLSlbqsEnsWpIGsBzGKTEIYwv4oPHEeDj/5jabXxLVQc/Ug4ln3KpVzQ3syJjQVYEBPWVJ7ehsQMsyYL8XeruthPmALXTuPyjzXSZ3/MWITbnSbRwutIxOuGmqB7xg6Ay27b/Azpst8PSs8xSJm2uU7fuX2cJFJ30eBvG+lAUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256685; c=relaxed/simple;
	bh=KDICsT1k1L+QQdL3U7Fz7Vbnv/zvb6zO5TKJCn/sQ2M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/7fzXOHzjKFiXm++EQPjRlaUwQCqHQbFQ4mlUM229gX2Y5Lyz+0Qv61ytItZV0yD+aSxCyVFlZyTl3dg+YBjZboiFg6Hfb8xGo5RSZyufOM3uP1zsHpoDYfPdcL9vReO6QSV0+hUNU7STplEOx7/sZmcJHbUe0QHYuHt/Ifmnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHHNSaGQ; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHHNSaGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp0AvvPauDuIpCLSvW001g1l7s8ja+i0Ra/enRmFbfmjNAOe0BCU6tBaXqh2LTSBCFuXl355QjduscFo3OlcYA6mu2wSUHhui42Lv9DafWpxo6Gtc/LE1S7327k3h3qsdk9MGwhzR1d/kLZ8D+1vo56fCFDqJI+fzhffcZFKpAGxdpk2nP7BVA+nreBgm9wJFkOqcsi+f3kZ0JuzHW2OuUGjvEfCMOZjWpzSPHb2YVQFZVYAbV0T7MssNpsWsRXB8M5EE3L9C1dtO+a20UC/N+cskC2dPXArH1XwGjwePEySjqVQDU+x4Bhu3uRo7deIITHkW+MuPMOimQO5dp71Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQI7bKPyyjZD4ONb1cqsRzh9eKQ7GYDoxqPSC0IZybE=;
 b=c8aAshYPaHBXbby9RuF7LGcB8fobPRWCV/WjXbDx2kyohDnR0EFzi2buQfzcRCyBeotov3XxsAonj0OGYOaaN/h7aOQyu2saN0MwvRn2ALH1NKywqSiS9vDbF4YJt0oKO/N6vOtgLQBq4RLiKOVfNyP0g0kbWyZO+NTgjxEDB+mC27w4XOkuaoz63C6ZE8N27XulH5PGs7QuBmwk2zX18Zd3dyVopOrHyfYPXsWTpXSuVKelrKitMZTuDlwP7cOoe/VvQ7WQteuhS8R6V6V1OsMB7UYcHPQZ297oP973GH4jIqBRHHWt/yoTNqlmGEo4qVW/EGwBeupP6wLtcAVqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQI7bKPyyjZD4ONb1cqsRzh9eKQ7GYDoxqPSC0IZybE=;
 b=FHHNSaGQDdxMTImEZvCKJ6NmQjcMc0vbtih8hoAo/g7Ini/mEBkTRH4RMRu7Dk4AJmbx8L8z2iPT750lzgc1BHMfYJ1J0+PxEh96jMyDLY6KS7rDnjLRCM+ODqrVLetNL8hxZqFZP2QW0z1wbEowpyKYXx2LSa8SsnqT6iRK0vpsvRwSyCk3eoPx3r1YvNGMox48+BDSDll990su+BU+P7Aa1IX0ak7LNPCDXIl4m28DhQQSpX75Tz2OfsjkqWaKS7r5sLNu1M+vMWn4/bBARHM6spsDpmXD1HOXDTCEDcYqtXl62OmNEeL6X+3nNtjNLq2CN7mvDc67ZX5MeQm0KA==
Received: from BN0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:e8::31)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 2 Sep
 2024 05:57:58 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::51) by BN0PR04CA0056.outlook.office365.com
 (2603:10b6:408:e8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 05:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Mon, 2 Sep 2024 05:57:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 1 Sep 2024
 22:57:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Sep 2024 22:57:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Sep 2024 22:57:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/tegra241-cmdqv: Fix -Wformat-truncation warnings in lvcmdq_error_header
Date: Sun, 1 Sep 2024 22:57:45 -0700
Message-ID: <20240902055745.629456-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: c7982b39-12e1-45a9-1d49-08dccb143205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTJpZzl4bVVlcVBJM1hibGlNdzZKd0taa0FTVG5YSjVDZzN0YmpveWJnVFhX?=
 =?utf-8?B?WWY2bHZ1YzRYakRNWlpCcEtaRHBVWWJSUDduL083TWExdVJGOTRoeUlPaVdO?=
 =?utf-8?B?SGxiNXJJRmJwOXpVV21TUmhJd2lnSEZCM296TFN3YjRvVnpTOCtjaHpKdGdP?=
 =?utf-8?B?WHQwVXprWDZjRld5UnlDVk5HTEZpNElLeWJyV1QzWnF6Q096WmxJMU9ocFpR?=
 =?utf-8?B?cmNJRlBUODUyVy8vSEw0VDdLMTdxbU9oNlc0ZHdWMnhLajExanBuK0F5NmFt?=
 =?utf-8?B?QUtKMzBPeUs1N1BmdWxwOHFjMnlJdVlIaHpsUlJaWkQ4OEFLOG9ObE5RVG54?=
 =?utf-8?B?cFRjTUpyb3NLamxkNGVORlJmYW4wM0pSbFd1NE93eEo3Zkc3c2ZTSWlmRE5n?=
 =?utf-8?B?WG5teUtGMklQeXNRZno5cTg1MDBYUnA0c044WUVuNll4bTdxcHJ6SXlYTUtp?=
 =?utf-8?B?djJTcWdaRDF5bFR4eDVvOWZ6T2lOVjBMSlpOdUc5cFUxRS9TQklvR2NGTHd0?=
 =?utf-8?B?azNidnlpSVhBOVlsb3VGZUFUOS8xenNKMy9ybGtFUDJQaWRId1ZMR0pLZFVJ?=
 =?utf-8?B?S3lVSFJKd05CVm84OUpIVzhvVmtTQjF6cUJUbjFVcFdDcEllMHpwanZBWTdI?=
 =?utf-8?B?KzkvUjNudkxjNWhkd2JEeU1NaEJVMmdxQkU0ZzkwOVl1VEZ6Uk83TUVVWEFX?=
 =?utf-8?B?RC9Ndk5FVnQzVmFGU0d4SWxFYXRCV1MwL3BLY0tONWFMUGlqS04zY2dLY0VR?=
 =?utf-8?B?M2ZnWlo1MzF3ZVUwbVlBeUwyKzRYbFFiTmNLSVptTENjUFlkVE43VjJVQi9D?=
 =?utf-8?B?T0s3c09KVStRUGxGSlRKRUp3RnM5RTBuTEFQTis4Qm4xc2RUaVRJcy8ra0sz?=
 =?utf-8?B?RDlqNzlrVkNoOXZEMXZ3VitUcENSc285SlRQdmp5NWFkSEk1RlNkamlyRG5z?=
 =?utf-8?B?SEtSeWsweStwQWoycVFkQTkwMEhUQVVSSTE1MDI5blljeHB3WlNCUTZPTk45?=
 =?utf-8?B?NTFNbTlBSnQyRGVrMkwyeXltekNySzA5Q2gzdnNGaTFKSWxDNGx5WUhkN2hL?=
 =?utf-8?B?clY2ZG1YajZhOVpGazlGYUk0ZXJKU1VWckZ4c093L1R2eFpDTmtHUGhobDN4?=
 =?utf-8?B?dEZvdUswMWpSK3Y1RllQd1IrN1RnUW9DbXRWbitBN2RSY284WlRxY05reGlZ?=
 =?utf-8?B?THdRNHZ5Y0ltY096UW1oN2l2ZEY2Rnp4QWI0TGVXRWNqaWlYdnJ0dlVQeVhh?=
 =?utf-8?B?bURCS2ZEemlmR2JBUHRiemNLU3RHK1JESFNHUDN0N0dWMnBhWW9PL3RvQWdj?=
 =?utf-8?B?M1dDeVRKYkg5aXN2YnBNcWlRUVdKMTBDenFVQjJSR3Z2VWVNZUFBS3VCVDlQ?=
 =?utf-8?B?bkJmZGVPS0k4Tnl4N084bVZ0ZWZCZTFJeURudkVRU2p2WnBQdmE3NHRnVW1o?=
 =?utf-8?B?RGpaWk51dWxidkpoNm41a2hCdUVGQWY0WSt2UGdDOUhoaFozVlE2WVZxeUxy?=
 =?utf-8?B?RGJoWUNMK2kvYW9tdHFJODNONXpGOHpubWlVS0ZaOVNQR1JkL1ZlTE9nTWoy?=
 =?utf-8?B?R1lQVjNOQmc5SzZjbFgwTzAzQ2xUYWx5NTVPMXFIU3J2Ti9hNGVOMmE4d3Rv?=
 =?utf-8?B?K25jNVFlZGF4RGZkeHZKOUlWYzdQTkJyR2lObit6WUsxQTJoMUF1OHNRdU1E?=
 =?utf-8?B?aU1zWmN4ZW5yNGRNWk9JMk5PNnBiNE5RRkEyU0gwZUc3SlpzRk45MS9GVXQ1?=
 =?utf-8?B?UTdDUkwvR2FVRDJvc1hDSHZhYnd2MjM1Z3dMaWx3eUoyOXVlZXhJNEhDK1d0?=
 =?utf-8?B?cjVGU2FhMGpCeHNTa1dZN3lwdkF0NC9BVmxQTGZnV3dmSVhGOEllTW9LU3BC?=
 =?utf-8?B?amtsK255dzErNG9vNXlPM3hrWklTZFB0bnIxUEkxa0dVM3JBZ3ZXekxvTVpM?=
 =?utf-8?Q?pN+ztU9gjkrUdc17pJj80Gz1C8ECTP08?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 05:57:57.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7982b39-12e1-45a9-1d49-08dccb143205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

Kernel test robot reported a few trucation warnings at the snprintf:
drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:
	In function ‘tegra241_vintf_free_lvcmdq’:
drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:239:56:
	warning: ‘%u’ directive output may be truncated writing between 1 and
	5 bytes into a region of size between 3 and 11 [-Wformat-truncation=]
  239 |         snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
      |                                                        ^~
drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:239:32: note: directive argument
	in the range [0, 65535]
  239 |         snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:239:9: note: ‘snprintf’ output
	between 25 and 37 bytes into a destination of size 32
  239 |         snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  240 |                  vcmdq->vintf->idx, vcmdq->idx, vcmdq->lidx);

Fix by bumping up the size of the header to hold more characters.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409020406.7ed5uojF-lkp@intel.com/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 9eb9d959f3e5..03fd13c21dcc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -233,7 +233,7 @@ static inline int vintf_write_config(struct tegra241_vintf *vintf, u32 regval)
 static inline char *lvcmdq_error_header(struct tegra241_vcmdq *vcmdq,
 					char *header, int hlen)
 {
-	WARN_ON(hlen < 32);
+	WARN_ON(hlen < 64);
 	if (WARN_ON(!vcmdq->vintf))
 		return "";
 	snprintf(header, hlen, "VINTF%u: VCMDQ%u/LVCMDQ%u: ",
@@ -243,7 +243,7 @@ static inline char *lvcmdq_error_header(struct tegra241_vcmdq *vcmdq,
 
 static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 {
-	char header[32], *h = lvcmdq_error_header(vcmdq, header, 32);
+	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
 
 	return tegra241_cmdqv_write_config(vcmdq->cmdqv,
 					   REG_VCMDQ_PAGE0(vcmdq, CONFIG),
@@ -354,7 +354,7 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 
 static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 {
-	char header[32], *h = lvcmdq_error_header(vcmdq, header, 32);
+	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
 	u32 gerrorn, gerror;
 
 	if (vcmdq_write_config(vcmdq, 0)) {
@@ -382,7 +382,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 
 static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
-	char header[32], *h = lvcmdq_error_header(vcmdq, header, 32);
+	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
 	int ret;
 
 	/* Reset VCMDQ */
@@ -555,13 +555,13 @@ static int tegra241_vintf_init_lvcmdq(struct tegra241_vintf *vintf, u16 lidx,
 static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 {
 	struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
-	char header[32];
+	char header[64];
 
 	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
 	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 
 	dev_dbg(vintf->cmdqv->dev,
-		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 32));
+		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 64));
 	kfree(vcmdq);
 }
 
@@ -570,7 +570,7 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 {
 	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
 	struct tegra241_vcmdq *vcmdq;
-	char header[32];
+	char header[64];
 	int ret;
 
 	vcmdq = kzalloc(sizeof(*vcmdq), GFP_KERNEL);
@@ -587,7 +587,7 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 		goto deinit_lvcmdq;
 
 	dev_dbg(cmdqv->dev,
-		"%sallocated\n", lvcmdq_error_header(vcmdq, header, 32));
+		"%sallocated\n", lvcmdq_error_header(vcmdq, header, 64));
 	return vcmdq;
 
 deinit_lvcmdq:
-- 
2.43.0

