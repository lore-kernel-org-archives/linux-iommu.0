Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793846980;
	b=uU97NJ1MrYWai4LZA2NkNCP8laldxCgcW5eGReePgFDZRHTlIISpvUOVEKOxhmbl5fr0
	 hBGYflxGPj7ueeKiwsHSnBkYlXg6uolMppLBeJKfs1O+CINI4yzjAJrifhFPKutESfkaQ
	 8ajqrb0hPyRqhJFDpuOp1zqp/hEO+LWBCmgFphq4GmWkln37sUl5z048Ysb7Ui7I7s7en
	 nZNvsT/TEDOOdvnXu2Ygy95UUvetL7YEuaAMvK5xOT/3mEX4OiCBf627EXLpttYkgwGVc
	 204ojQP3yx/TIAv966luauNZ5OaZhy/WOL68hUlNzxVT+24zVvQPw1RNpbAyuQ79Ncg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846980;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MJZpznO9JjlEqmhz5KxnLTrct+d8fkTVgTD1BajbVVs=;
	b=h67GwKTGXsHmJnZ3LyP5FCbbjz5DAx41eWmUyI3z2qGrIxWM0uc8wGxcvZAsfMjm2Qj5
	 A9cvNw5x7S0iYIR4azvgKKAcW/LQUiRLImHTsyZAXJ84rQrL5ytBKOC0cbVXZl3cgE2GY
	 TMjgpANK3KPvO33MsdXXK5w6Xf+2KbsnnPh50yF6xJ8ky6wK0FpSfRFjL+/l124S3cwNw
	 WmjdhpmzjYoEcjN6ZlkiCF5ztuMp8vQyqR+xUIoPxLf4sCtWginTkUXdHdB2yuvNBIdup
	 qeO3B1pcZO26hja5dXGtzt4VM+/lyQ/lSjwfrrG3cgPED++ikirXRYaWdMxdZ9brYTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="d/Ui9bl7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.74
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020074.outbound.protection.outlook.com [52.101.228.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513D606D804
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 02:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D513D606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=d/Ui9bl7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV7Z+o3tc1zDCU/f11YD9lWY5XKhrAAroMgznZQhJ/uVuz4xoTOoXVXLizfLsHIoa/UWvygVrUY/FSNhL1CHQ97iM9yPD5jQdqKgihiVDGLPFra6103HsMS6f/BJFB+EBmCXY8LOKFxqEDSDZwbEtIRzx+azEwUpZajxi8xs1A0NA4bPTbTVlY/jxd4pHoBjfzlBR8GhWrRaELLP34xjzw8dP60mn03gagprleijulBI4mpCXd7vXJ+mSibHDrM0a6hx6OKVjw6r4s0lUjPtFOGbPFbV9LZwCtlvAL1iEsiFgCi0saTqQUWhbkoAfj91YxBWMYeuxfsSSLOKt2j1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJZpznO9JjlEqmhz5KxnLTrct+d8fkTVgTD1BajbVVs=;
 b=HoW169fJDhJLKeRikGHD7niABYjrcRl4PVt4fmGazR0jw5Kjm+BDL1Mwxbw+glLEXnEeONCysilteiRB2BqbBRY5RxW7MuCXLBu0P/B4qoDkCB3XCMvZbbnrKsLRDZ7+y31uDxhBlqkd4x6eiHVSeGdcWBZUnH0I37zoYJ3PY9UB4mM9N3DGn9BtBtTrB+xKRliFsfHfpie7jI8HO/nH9ROvF3mOIGog892koxdvcT3IMRCu/npq7EOJ5SQbhJlAVjVCpAzWzsO32druE7uNIFBtrkc9mIFECDqH2yvfLSs3YWe66nNEZ/drqBnSXjV91e+gW9iLdwvecvTqH78aMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJZpznO9JjlEqmhz5KxnLTrct+d8fkTVgTD1BajbVVs=;
 b=d/Ui9bl7FelOiso8rIdW0OsPc/58pYtKssjjshUS6MOiQMVMt6J/Tlgg6rzi0Oa2SBZ4SNBOM1vUeEJEDmIxlTnP9La+vsPl9ei2eM7BQBc59SIVadaQy7DPRQVDf8BmVxunKMsCB8qGCYrewNIljM/4HVjb7norCYs3vHimRJI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4016.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:49:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:49:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iommu/ipmmu-vmsa: Propagate errors from iommu_fwspec_add_ids()
Date: Thu,  5 Nov 2026 11:49:09 +0900
Message-ID: <20261105024910.1879230-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105024910.1879230-1-den@valinux.co.jp>
References: <20261105024910.1879230-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4016:EE_
X-MS-Office365-Filtering-Correlation-Id: 937b824e-665f-467d-2bb9-08df3ae76c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|56012099006|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	y14y56rMbjBHOioM676DE3Frz1e4om0WgmNdL3BsuXaipO9dKFUsvTqp6e9kUYDPqZGwW1uyBYjQkrf+wSVp8XuJriRh1/NY6c72rl7cLABYqijQwVhm7majOSZ7sxNSI7WRLD8yBiaFXd8FPKYjMg/dFSe0clNumLn9alCasZFLkmizmtGN0Esriu8YWqchrGqqafwLx0wacgajwU+VLbjXQEoZ9XA7Y6AwZLdCh/ycfFh1WNlX+lZjIJd6zT5l4V8U3xfWLWGfjMEryuZafJ87sxlCQiUFQyr4pdogBPB1PMe8hMTqMa8uWm+gulN/u74r+BFip+hnoTxM0DrIFBT5Z7YpYC9EcZKwO44j1SfxJUkgmxUbT+NP2OIPK43vA8vT5/aK6hwnHaEFX271rVgNLDZP6EV0EucPL3JOJyABwXopc8nmPsf8uMvrfAb9S46Jvvy7Owu93eOBhEmiejAAEtchhV4ZQhV11Li+jeXmjmjcp9rojGSRumsQVxVWETrW/WkCAiRwU/P/jkaISeuH1/uJmAaN+EIQAwCuCLwWLP8r2JHh2SIv1uJclWAq/3lytw8BMYmJHY0IrBRKJObQfY4EI2k+majOJPk+DIv/fRaemzk9kHBx/fmjFEUTyfcPq4QKDwbWnqObEszLUD7FlvwovTd82Q8Y/Vz7OyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gq2PD1P6JvL2vi34lAz6XL4mFVrpPm/3U18FcPnaR/mUfyfXeLN3WAJw7tgw?=
 =?us-ascii?Q?gx1nPgAo1p8T27oQsbmJvY+Iw2FHX++tra8Qx+O9pfs2dKTGzZE3AwcReJp0?=
 =?us-ascii?Q?9DdPYm+arAKZfAs0GegwdQqypLtwU/2UNM6mlBK4+l752bS8WFOr4L+ON3m8?=
 =?us-ascii?Q?I7r8NEepRW5GFKp1dEsjxzaPG0crTZPtSu5kwslHXfydWJkCPIxWcB1BwBV4?=
 =?us-ascii?Q?gH0c0JI0uqIrQdeFUVN5yHbbX8+jPN9RvBWKMaOVIBQIj3TPSlQwUm/RFDbi?=
 =?us-ascii?Q?wDfKHbnctNCDz1ieaYEJMuQuX/V7/IYkGAwi7Pa0tbuX2stU0eXRVIsBRclB?=
 =?us-ascii?Q?E73D1OXucGu85qQG8A5DlpMZIpJ/NxRG3x/fpv1xzjmAs3iiiU277Xijvu17?=
 =?us-ascii?Q?TVYH/E/dGc+gUa3wvVydkTIMhBDQomus8GrRSiFvCg650cEi2Zqsi06oNU1m?=
 =?us-ascii?Q?HZGY3+vq8xgrZl+iVpsL9Jou0JyXmEh1AbgvScqPeT3d9aXsI2ZzaQ4hKOXG?=
 =?us-ascii?Q?TOzyjjQ/tM7OOItsBDfV2uEPMxhaGL1qzOfZapO6QPTGp6trvD0zOdHTEjX3?=
 =?us-ascii?Q?fdklH3cfR3Opjy7/KiAyam/KvAihnFfGh88YYDn61v8chNc0PVinPNo9Fm73?=
 =?us-ascii?Q?Y1HIBwTl57tZ9gg2ke/wWur+MpucxM2Klt5SgFuL/4tJEItWp7F5D10mrA7m?=
 =?us-ascii?Q?Ud0KFvVa8vEWv/rKXf9PSxFSl5RPpNNhMQKSJgXxSr3Q3dgjfy6DfNgl5m+B?=
 =?us-ascii?Q?RlkkCYtVhUy7cuDHmpBxlQNQv7+VdfkHlp4zKmPMk6dO8wLkaPr8iCqB8dby?=
 =?us-ascii?Q?ckJF0+mfPUTX2ohnWh4t4ignI8FrjrxGpT+VDa3Otxhan/MWDK8honcmwjZm?=
 =?us-ascii?Q?A5rtJoTSM97Pa7kVMJtgDmNJp6G/4aBgeEq4vIu0PwLY5+nMb1ML/s7juNrZ?=
 =?us-ascii?Q?AP66nbrrL2fqoWfbpDVJD84FHQ+HQg8Lquso4rMC23YZoINoW76BUQIywa0S?=
 =?us-ascii?Q?01+1UB3cRV6ZdXpqDmQNnStNEhY3hCJj1f2ec/U/CkMZlvBhmhZEehfTyT+X?=
 =?us-ascii?Q?ig/tI/iU00ujbpBsUtbl1xPsaCFf72hGoZrDG+iX90LOvtlQBD4tZi0RCjks?=
 =?us-ascii?Q?/57obGtqKXs9eT/NLW1J0Ktt7Ipu5OwKcJf6Qrs2KJSbU/5klhpcACZw/815?=
 =?us-ascii?Q?3GW/1yKrKNMAe1k/kxCbUCgFfvIb8el2SMvA00h+d/l28fEePaEDrXQ8l2U6?=
 =?us-ascii?Q?VuxG2euAMJ4CLd/bzPQPQ4/05dd3FQvpmxpvgn5bxMl1I3bXvVOp9ja+Z8jj?=
 =?us-ascii?Q?v5qlaGZ4FD9qRBfljHSKB21eobiYRIYY6nMAWSjaTdbxhoKsQO8NAsGVAgI1?=
 =?us-ascii?Q?Fije21/FzdFodharhkfKE1AB9B/R+k7pf4fcPN+scGvyRFpx56oT4lNmojdc?=
 =?us-ascii?Q?4L1bPmjDimSga8XT4rsBXhCvKkLiixAymhCHGeAO1fM/xabb3VKeNtkO8lfz?=
 =?us-ascii?Q?VSc1W592vctNoFLaOjXoPGmOLX/BTF9AiAtt+9Wo1mUV0oTUKKvLgkuvE68N?=
 =?us-ascii?Q?CQFq7twuLX9WqOpH8CCO4dxf4z31sv8KsCvvNuwg4Z5Ol6ByC686BXeyN6uj?=
 =?us-ascii?Q?AdP88inGoDjF+cRjeSy7ID7zN6bC4DG4J7ZWTStk8URS1fNQCrgZsVu5egpC?=
 =?us-ascii?Q?S+q/L1cPxaaTjf5Y6BcwTRk/2nxXfzBAtXP7g90rbYnR5lQ/YUMqYg7CR6dL?=
 =?us-ascii?Q?lzfTrnuN1yFsTAFWbzIUGnMELwQL/QA6WViEdLU9rE3bVbAy70D3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 937b824e-665f-467d-2bb9-08df3ae76c68
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:49:34.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H52krZtG7wqAriibIi01jm3f+6gxavukj1W9NOeEvN/exGv3eCAh1JYoglFsBdE8CaG2EL80bX3+4QPOZOibUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4016

iommu_fwspec_add_ids() can fail while extending the ID array. Ignoring
its return value lets IOMMU setup continue with missing micro-TLB IDs.

Propagate the error so of_iommu_configure() can discard the incomplete
fwspec.

Cc: stable@vger.kernel.org
Fixes: 7b2d59611fef ("iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/iommu/ipmmu-vmsa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..99586c68ef35 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -778,10 +778,14 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 static int ipmmu_of_xlate(struct device *dev,
 			  const struct of_phandle_args *spec)
 {
+	int ret;
+
 	if (!ipmmu_device_is_allowed(dev))
 		return -ENODEV;
 
-	iommu_fwspec_add_ids(dev, spec->args, 1);
+	ret = iommu_fwspec_add_ids(dev, spec->args, 1);
+	if (ret)
+		return ret;
 
 	/* Initialize once - xlate() will call multiple times */
 	if (to_ipmmu(dev))
-- 
2.54.0

