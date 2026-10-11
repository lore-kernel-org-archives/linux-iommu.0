Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525343AE71C
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718026; cv=fail; b=jdYcGCqadJSYDe58apMhETITtipjslaOdiBYIYldoj/OPjceqz0QIX95d1sxpBrAnBXlVF2sDFoUP0cv9NXVLmb4BNdygi4cLgC8e8TdRa/BpJ2UYuN/DrAHwsAU3NXQqM121gcZJIJwG8F92tL7icRq9JgXJokzCCn//9UmLSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718026; c=relaxed/simple;
	bh=GQEUxiytmsyREvH4/ogWLq9/v5woX8+ymxQTggaYXwc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JWRfzr75dojaWNt/65kEaWr+ommuSLHY4OAHkUhEh/r+Fl1B0JW9smXpFQ5vuzWZ9p/JlrCEd0brnjUYZO3fxOQZKLDodKHr0csVMizIQjMNBA3Om6VnsgHkX3iQETBn145peT9Jj0WcD/kzYHXKg8mRDvgYlrZdfQGINjDneR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mKtjg8FE; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mKtjg8FE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfzdnTzcKnMMUU+Mz8cqaFqNNIgO16lo42xjrk3GyhPSccXg88FB+9coDdKBa/xJdNU7asDfRopfhjuKOrF5nasgQ2k+PZsICIp4j6Pnkspiefll3g4eMRkoq+hhxL0+Iwnvv8F+2koqilJPaug+xYY/MLYHOW0nSXbS8KEfQi+dLwtsa7oWHkosxgdKnIGW4x4B2i+w8N2d5tZx3DGoe+qtsCGmVwV2u/8qoWGEGhPLjOb1lj4/tI5WswuwjrwwCrH3Yo7uB5afa9uhwS1svS5V477q1JT/XIXVmpaBoojBjBGHMvqcynoOXmOrX9u4AuCi1lzdOFQ9zFSqLeSamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reiuSxdUyh7LNbU26nUGZojxYFXV1NE9I4yGsCQjaoQ=;
 b=enteHLPIFJJ+FZffTb4xIqaTJCNjL1fKYK3/2w81a843mOMD7G9HAApOgkpT2vBEYKaMpBaDmVIS/+f1KUV18MVOUqSKkpyC5LiwRrvhSwEQY1faGNfWECnH+pL0YYeMibGnOxjPvlXxuJ027QWYHPthQOsB8/3sxxySD2c+WwCrQ7OqIUb1LYVpds+lZNAClBsp9iHJyvFhlc4pKtMALhgmkW64LqlA1r6vga7dPrjtyrhfmDAvgtiUsmBfT+bEOWNZG+WFHx+XwyZq4/Yq8AjU4bQ1GHW8Ndw5b7BUbQ79pskLarRjyG31mCtEHFlcpIBGkSHyQL3U8+zaHSryrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reiuSxdUyh7LNbU26nUGZojxYFXV1NE9I4yGsCQjaoQ=;
 b=mKtjg8FEY6OmIRcw4otfQOSC+D5I+cQsKzJTnoGMKCXKY5mHgBkhgbOD3vDES8kB56PUBGofpOa1S5HbiMTc0Vmw4oepdUy02fvXwhra+l4ykGoaTDiEzlWm+LSPK30UBfJvBvNaGmstvaZLOFJw8JrRZ8B/nke1JSBOtm56vOyXSyQi5arElMnRZIkAhqcJNb4l5vlE6446f74H9+wxZfV3SXgbUkPvFCVY4p4NeQ5RAQ9oRtdcySAWQd7wdAegu0ypOW7TPxfP5nXspI/0Nc1/j6aFfUNhetTD671g41LiqlTfVT7FzwXlHGbpRHdqnADKadYnsuCwTMCBPgtrSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 11:27:01 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 11:27:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 11 Oct 2026 19:31:25 +0800
Subject: [PATCH RFC v6 1/5] iommu/arm-smmu-v3: Allocate streams
 individually
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-smmu-shared-sid-v6-1-cb76b89dc612@nxp.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
In-Reply-To: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: b8254311-6b80-411c-1c93-08df278a9175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|11063799006|921020|56012099006|22082099003|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	DzgzdwsaolNLLHs9/sMAZr3Q03huA7GzcaGAOaML+uc+AOZhvOL9C2dhW7/qcvkZRFgYuFDmeVuNv6Wm4SLolzPQ86JaRvE/9p9brCOIv54S9ZBsasQAMjtVfnGjwr0vnlFc3MEUIvD/EV/0Se4FKxePLvz/5EC27uQXliX7iz5oN+F05O/Q1lQEc59GgthNnYyIMqxS7ICLDYWIy9Rn535nwVhrYnOc/toR2/rXiiOyQ/hNIar9yA5ixQYk07hnzjC2HE8a3QCC8+vN90Zb2+v8ETCO3C0+Qq+TbWF8QctENMv8aiupdn0Mte5Ga/BL0aKb8wQUh+vdPbS0MMvto3ltCMEKUi3TBvQgw1hdTrw3YuJR2RpVr56JAXB2lWUU7vx+tY86XtQ6UjjYA4FNjGB6LxZuM/GRf+c01Ft0+yPWyB9tJD7o0tl4tYLrlcv76oSsccsr4+Kux16t1YW8EFtbIUCWZQr79pgRaE9Z2feY2bo0b+hzODWR5izv4FYhK8wv49SbsrM+IPBWgSRcqMYxBXH4eA+RZQkiOEXnObXAtZyfzfM3tYxLrBVSsY0uUQ95KmijHp9VH2yVtA+MTCDKmE0X8cldzDVFi2GRj/Ujrss9Ip76FpAiKDWp08t7rYaeszc58si2L/bouoUeSUAAPVb5/09tlUIRi8LFrwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3FFV3l0eWlYTmoxMkd6aGJyU1lrYlRxNXRwdVBMbVc3QU5WMENBeW50c3da?=
 =?utf-8?B?UXd2Y3BrOTVTOUR4Q21jeUNjM2g0dEhGZHB6V29tTEdwNFJuaGpHUS9BOVJj?=
 =?utf-8?B?aUNnRUYxNnRseUxpcHhLYmZJbmlPOFBubDVXMXNZeDNSV05LemR1NHJUQXdU?=
 =?utf-8?B?VWRRMmZLZ2J3QjdwSzRyZ1VOaW1tNzFRZUJ4aDY4bERDMXJTSUlaTFkxbkky?=
 =?utf-8?B?WS91ZmhkTGJmREdrWTFnNXV6ekRaMGUrTStmVWxZZFZTUnFLZ3RmK3BlVFNS?=
 =?utf-8?B?VzRINmwvYW9mZmhPM3AyRnM5bTNGWC9Tb2VyL3JMWkVHL2pMM05TeHJoNHlv?=
 =?utf-8?B?RnVRbmlMK3dubExwZUdRb1JlUkd6WXRLWHZqYlZvVjM2Rmx3UGd3aU5LWTNr?=
 =?utf-8?B?engzV3ZkK1l5TjAyTzBDd1ZQMkRzVUlESkp4R1hvOXgyVEV5TU51dUp6Vnd1?=
 =?utf-8?B?QTdEdTQ3c0paOEdrUjQybHpmWkZLV2NOWlc0Vkd3b3F0THVZQ0pkUW5IS3pn?=
 =?utf-8?B?Mk82S20vTklheFRBM0tkL3FVZkdOTWVDVnZRMG9nTVRmV0g2amM4Q3FJMStG?=
 =?utf-8?B?MU5LdEQ3ejhNTkRuOU8rZ3cvWkJzbTV6L01pa3YrcG9DK0V1bHFhUjNWUmdV?=
 =?utf-8?B?dndZT25mUDJHTHpYazV3bnJBbFVWREhjVFZBL3JSZml2NmdjU2VDSUxOZXNy?=
 =?utf-8?B?cGhKaTlwNnpuc2lLVHZmdGhNNFk3YllsRDcvSVNMNDF2SGZiaWgzcGZ6dlNR?=
 =?utf-8?B?QUpDYkRyZkNlQjEwT0VTSy9EVUVZbFF0RHRFQWE4YVhNdTdTRW10SDB3VkpF?=
 =?utf-8?B?SUlEV3d6RXZYb3RrK3A2UEZzbUNHMWxzOWgxeXlMOWhPVGRFKytHUjVpSUw4?=
 =?utf-8?B?TGZucEw2OG5LTEVVdjd6VmZjc1Rhb05pK3lSbHZpTm8wVXZBRXduRmJ3NWVx?=
 =?utf-8?B?WTRCU3F1QTQ0TGRJMG1XaytyUXRwR29yVmpNbXFhTEFibkZLOVpPYWlDOWdj?=
 =?utf-8?B?YUZSQnllV0szSGZQc3VMeFdDUndlZm5JZ2IwQnhOTlZvL09YclFXY2dBNlh3?=
 =?utf-8?B?V29sQW5ZYXI2ZHV4eXFqZnZlWjVEdFBLUUdVM212b0dMaEVoL0RTRS91Mms1?=
 =?utf-8?B?Mi9uYkZQU3ZnN21vcUUzZjFPVE0zYlJ5b2pORUVvZFEyTmVMUURGWGpMWU9q?=
 =?utf-8?B?NlRlYVFlRHNQQmxETDI0Tm5td1VxNUptL1FDNTNicmUxNW8wWEZQekY4TlRl?=
 =?utf-8?B?UVVmUm5wWk00c1RLcVFnWjRpL2s0L1N6dWNhaTN5aDZUWGR5WUUybEJ4NUM4?=
 =?utf-8?B?NXNzS0ZQSnpkMCt6bzNjYmJac0ZsNktSOHF2WjVMR2cyMHhUZnpQYS9USUFo?=
 =?utf-8?B?UHZESUQ5UzkraFdaOFMwRzA3bkVQVUt0Z3ZRcmtick9FOTdqdDFHV0w4RjNh?=
 =?utf-8?B?WmN5SDQyR0RkY25MaS9iTUtxbmVtVktzQTJkdVJ6YU90Q3V6bWVjUWdHU3hF?=
 =?utf-8?B?TFA3akJxNnVjREUrMzBPMXAvUU9MV2Q5WUcvcHF3T2YzeGdHSXQ5QXphVTlV?=
 =?utf-8?B?U1lMd1h2RUYxaC93NDJEeEMwckloKzRXZWRCSFFaZXFCaXRYU2pucXpyOWNS?=
 =?utf-8?B?Qm45R3M4WlFjSkhEM3pOVElrRmtYL01YMTRtYVI3NHZWVTRDcUk2dUxneFNW?=
 =?utf-8?B?YkxFeGVJTytBWUp4ZXpqNmdqYjFBZDFzaHVGNXhQZUQycFFPMGJIQVB4RTBx?=
 =?utf-8?B?QnA2YzlHYys3cVY3M2J4UW5pYzdjcTRjNSszbzFpS1pnKzV6TTU0Z0NXRk1z?=
 =?utf-8?B?OTA2Q3ZJU3ZVRm5ER0RtdGVwTUowUTdBMGNjQXJobWk1ZnZHOUJ4eUFncU16?=
 =?utf-8?B?WWx0d1R0cFBPU21ZdGZCRHBpd3psbUdVZzRaRm4zNE9jZmd6V1JqVGlTZXJJ?=
 =?utf-8?B?c2RzWmZqMTg4OUJhTllBS0hWSmZFUG16YVd6YkZRdmV4a2dzNnI2VG1zeWlx?=
 =?utf-8?B?cmNFRUZZOXJ1TG5YZUdzS0Q3dSttVFE5VkJ1Z1VOZ3IxSGFrckZDNGFjaWha?=
 =?utf-8?B?ajd0NGdsSml3WitGNVJMNzgwdllrREw5MS96ZVozUWFQY24ybHA2OSszWW1N?=
 =?utf-8?B?d29RRDdrdGF1TDJ5NTYrVmNxMkhYcWJNTWtNbVMvaEtnaGNxakJ1YkVjaFdT?=
 =?utf-8?B?VWo0WG1sR3h3S2FJelNEK1JMMGxHZE1ZYk8yN1VhU0VIWG8ycWdlcU90VElr?=
 =?utf-8?B?Rnc4dzNZcnR2dGlQNGxlb2FwYlRYRWRjaHpQSEMranJoM2pEck9ydThHanRz?=
 =?utf-8?B?WHczdlZNaHErS2lhcHl6Q3c2bzU5eXU3VTJCZHlNcjRqSEh6OEdUa3pDMUJH?=
 =?utf-8?Q?icCppM3tpkdWxibbxA3MZfWiZNIMhu50bICG8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8254311-6b80-411c-1c93-08df278a9175
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 11:27:01.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMqD9MZEw030clTEbBQd6aCQ1IvdJv7H4zC4iBW+L5pbRHEGlgBUOE07XFjmyUSdWnV/ct0i9ZljQ/XVyqlMXmQNfv0W8ii0VN1G+DbvJzKvi3N5WeTMkpNPXSuggdcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

From: Peng Fan <peng.fan@nxp.com>

Change master->streams from an embedded array of struct arm_smmu_stream
to an array of pointers, with each stream individually allocated.

Prepare for shared-SID support where multiple masters will point to the
same stream object. With embedded structs, sharing requires duplicating
stream state and manually keeping fields like ste_installed in sync.
With individually allocated streams, a sharing master can simply point to
the existing stream.

The sort comparator is updated to dereference the pointer indirection.

No functional change.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
Assisted-by: LLM
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 52 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  2 +-
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e68b464850955..853276dd54536 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -295,7 +295,7 @@ static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
 
 	/* At this moment, iommufd only supports PCI device that has one SID */
 	if (sid)
-		*sid = master->streams[0].id;
+		*sid = master->streams[0]->id;
 unlock:
 	xa_unlock(&vsmmu->core.vdevs);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c473086..5e092f51faad0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -977,7 +977,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	}
 
 	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
+				arm_smmu_make_cmd_resume(master->streams[0]->id,
 							 resp->grpid,
 							 resume_resp));
 	/*
@@ -1522,7 +1522,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			smmu, &cmds,
-			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
+			arm_smmu_make_cmd_cfgi_cd(master->streams[i]->id, ssid,
 						  leaf));
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
@@ -2463,7 +2463,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			master->smmu, &cmds,
-			arm_smmu_make_cmd_atc_inv_all(master->streams[i].id,
+			arm_smmu_make_cmd_atc_inv_all(master->streams[i]->id,
 						      ssid));
 
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
@@ -3155,13 +3155,13 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		STRTAB_STE_1_EATS_TRANS;
 
 	for (i = 0; i < master->num_streams; ++i) {
-		u32 sid = master->streams[i].id;
+		u32 sid = master->streams[i]->id;
 		struct arm_smmu_ste *step =
 			arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->streams[j].id == sid)
+			if (master->streams[j]->id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -3447,7 +3447,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 		 */
 		if (!arm_smmu_master_build_inv(
 			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
-			    master->streams[i].id, ssid))
+			    master->streams[i]->id, ssid))
 			return NULL;
 	}
 
@@ -4276,10 +4276,10 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 {
-	const typeof_member(struct arm_smmu_stream, id) *l = _l;
-	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+	const struct arm_smmu_stream * const *l = _l;
+	const struct arm_smmu_stream * const *r = _r;
 
-	return cmp_int(*l, *r);
+	return cmp_int((*l)->id, (*r)->id);
 }
 
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
@@ -4309,10 +4309,16 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream;
 
+		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
+		if (!new_stream) {
+			ret = -ENOMEM;
+			goto out_free_streams;
+		}
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		master->streams[i] = new_stream;
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
@@ -4325,11 +4331,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	 * which sort_nonatomic() invalidates by relocating the entries.
 	 */
 	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i].node);
+		RB_CLEAR_NODE(&master->streams[i]->node);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream = master->streams[i];
 		struct rb_node *existing;
 		u32 sid = new_stream->id;
 
@@ -4359,14 +4365,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i].node))
-				rb_erase(&master->streams[i].node,
+			if (!RB_EMPTY_NODE(&master->streams[i]->node))
+				rb_erase(&master->streams[i]->node,
 					 &smmu->streams);
-		kfree(master->streams);
-		kfree(master->build_invs);
+		mutex_unlock(&smmu->streams_mutex);
+		goto out_free_streams;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
+	return 0;
+
+out_free_streams:
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+	kfree(master->streams);
+	kfree(master->build_invs);
 	return ret;
 }
 
@@ -4381,10 +4394,13 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i].node))
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i]->node))
+			rb_erase(&master->streams[i]->node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+
 	kfree(master->streams);
 	kfree(master->build_invs);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bb048e08d613d..56ed6ad1dd523 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1051,7 +1051,7 @@ struct arm_smmu_event {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_stream		*streams;
+	struct arm_smmu_stream		**streams;
 	/*
 	 * Scratch memory for a to_merge or to_unref array to build a per-domain
 	 * invalidation array. It'll be pre-allocated with enough enries for all
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 710a4c694b946..8166cece943c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
-	struct arm_smmu_stream *stream = &master->streams[0];
+	struct arm_smmu_stream *stream = master->streams[0];
 	u64 virt_sid = vdev->virt_id;
 	int sidx;
 

-- 
2.34.1

