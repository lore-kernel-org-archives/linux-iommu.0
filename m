Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BC51DB1B
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858764; cv=fail; b=oACgS+B3xOuJDV2Tq3XkTiK8uJix+3hOhnzCkwSgZC50UbE+2XQ9r2jb81+vkx36JDmW1nwkmMt6cjka/vtBEplMDte/PZzvWE537PkfpuxDOaPolzitUkAFlI+PUBOwOzJmusoq66hGuvmBUUMksI6kPfoGh7M0LX6u6VdT3Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858764; c=relaxed/simple;
	bh=PgmAAVe80MzaXStPoPVnTBzRE+K1wy+rZ/lnzifhoRU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G9YFLDqBzIEkVJVtGwMr+sxSlVhhjOxMLp5AMbrJeikxb0bnYvRlbiNHMjXGNQ9FkwZc4vm4vWHE4Rhfm5y6fYK/24Ge2PjE8kmwajYVIrB2UXyP+R0MA03GSwm2vUuGXCYNUoe/IsIt/wxNzwmwCb9QxuA9qeFUL+aiLpWUqLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EpTgRIy3; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EpTgRIy3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy2DkZ13el8H7bcMZolGzABQlFblThFdtwDc0/AlCp34kv9yvCg5IrvCH3uPBRbLVvnOLeWDWF91wphaUUtYkOCZyWM+pbwomdA4chQ7qM629ieC2kbsPi0n0p4uNFNAZajL1RBE5ZCsNnmCK3v1f3D5s/CqUJpBLM+7m8V+qa7Y8lJNWQRRyFCBEnIt7/KObf/AMTnAigWQMoMncj2Nn8g0iqrebhm4AiLpfRyaf52RvBDj1VDwIfncehS4fj8gtvicDPDEjTlH2TF8py6dzLfv3+KdOL07/kQxcRVNkFWfgY9dgun7IClOlaJaKUdGl9tp6+azabMZaKhZK97y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuyL1wwJeUDEomUCIKns5ZUhhAqTndCgEgpGS8pLnG8=;
 b=fqzDREPNnPqzD9OiQqps7E7QE2Yi1TyvE17Mq0MDE25m5p80jwPcFz3C4NgK44tw5Y66remojmXLffAWGofA3nL1hHq/WYwQVnV1vFYxh5Lu92TsFswrqH0DWtz61+k63ZHZUw2ZVnBUElyQx3UsFKiapoC8cblkxqTFxIaY8ytoThGgX3FQf+mPTRXNSHHfMSXT1nTP8fag6Zlwkq9eMvyU4A3m1hkBRPTiUlyMAlHpOpuBCBkvIBw/W4AejaJcmFUW6//rjKx4cocsYDpweaUJJjiHG+yGUi6No47V/Cx5FbA2UkMLvE9PwR0WO4XH5cE4vOJrWRmLZorP+FjXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuyL1wwJeUDEomUCIKns5ZUhhAqTndCgEgpGS8pLnG8=;
 b=EpTgRIy3qePf1r9LrVbCkzaHz+ge8D7dE/xjxNoNmAkYNvpDIxEgeQVizox27ndIkxRsFn9HRZj4351ElaYBc0SOoNAQhaz6/32uiHX90YYh0CJzdIOXo+JZ83yJgDOSLfEibNqiB7pyKRdcj5IDV/Umi2kEuHVJwIzD647qkW8np1pBezKFHY5GVDy0W47H1UlY3qCECjyuPzgJ47uxS5wOTbfsKygjcftxMdAKU6GtF22XRfdiEd0bNlSu0LT/qryDt5ca9bKgRJFDbMVAjyVuvKfV9VhbO/bri+I1pqFZipTwx4rnVgWryUqJ3weokpCBfvnMhDfgTxFc6pyOKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB11839.eurprd04.prod.outlook.com (2603:10a6:20b:6ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 12:46:00 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 12:46:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Oct 2026 20:50:01 +0800
Subject: [PATCH RFC v4 4/4] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-smmu-shared-sid-ver3-v4-4-06b34fb2e691@nxp.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
In-Reply-To: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0352.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB11839:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a175c6-f928-43a8-8b6d-08df1fb9f243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	pY94cfcxpqq6LPT8wNltd9Qc9naq2xyZ++bXyiW6MRCBRX38Q7F09Bt1DrKijb6p2igHJ1lG868SZFEQgPaLds7Bbq2BJSRsjQKlRYpNuQ6ef6/sY7YvQSrtaTLXWtWhkZQjWnucJD+aU0m+UX0NXzcRQgulCxPASP5G8GmNReHf986z497eu1EiwnRAB3tSJ1Att9hmbdbnYQWyQBJ4r6Df0RBZZsqQeNKHTn3cVtrIvQPF8qqI5/djEcEuplUvSDJRGvZHVs4+9PmH0cIprn1091OrvIT4MEd9SW6qJ5VA2Vbotx/c5QI+1PpSruzmkwQNUcGllJvokx4awGrjM3kvrDO/6O/6JkcmeZRzQ0xhv6xSQvarpDj/lXG+GIAoj6RnwB4pe2Lqy752FEd33Yoz7OM6eQAGiFt99kxLiQhvL040wkndA0r+Fya/AteTk22M1L28G8MltERCL4GyclCk1BqOr4Yd9jxCzkLTg6c2QFgT2dbaPsmbC9T5WwE+x3tB5hxjVzxT06jGyvQI+WkljtOAY2m5Vl8/69ImITKGZntn64t0pQJ7Yy6BpyASSUA8jzvd5qHXkswoRiBrOXETgAkhmT2kEmRDZskqa99BmmaggC+5WCjR1igbh1nD6D85h2jjPFCBgEI1ih3UkkaLzVR/Loks0WE8cKsj3Cw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdwU0Q3L2lFUmJaaUdGOUpxM0gyTENpVFdDaCtJVVJEYkpZUnpoeDRQa05P?=
 =?utf-8?B?TUR2RTZkdUxkeUdEUTJnVlhpOXNzZ1hpU3MvK1RWVk5UQ2dGUHpzc0VhSWFy?=
 =?utf-8?B?OFcrUEx0ZjcrMkRodHRPc3E4UE9mRFE5TEgra00vZ3NQNi9aZlhFNlc0MnJh?=
 =?utf-8?B?YWU0Y2F5dmwxRXU2aU1PNkNnQXRXazJtVFI4VGtkRFU2aXBxWW5QTGwyaTZl?=
 =?utf-8?B?ZEhlbkJFU3VOR3NqS3V6RFl0a09xZ0RKd2dlamN4bWNyU0R6SmpTNCtDVG9i?=
 =?utf-8?B?M2c4MStNL1daL2xvcWJYMU9tQTZCNGtsZTNoSkFZdFZYUXVHSGFueStnUkxB?=
 =?utf-8?B?b3ZSdjNmODExTmRsM0tQNlRPNEJieWlGejNKcWV1NVB3VlR2Vm5acE9LSVA1?=
 =?utf-8?B?MENzWXlocUcxT01FWE80UEl3R0VoOEVuK09keElBWnZpMGQwcytJSDV4VXBR?=
 =?utf-8?B?SkUvOFUxaHdNbVNiQThIRTJDT1ppRWJtaFN5dTg3ajB3Z0l1MC9JTlZwNzNv?=
 =?utf-8?B?a0xvYnJjR1V3ajZqd3J4QzJlOUJPQ2lUTHVBZWxBMitteGJLR2NLMmFZbno2?=
 =?utf-8?B?a0V1dmcrTnFDaEVwVkcwMWpkMmxQNFFJaHdRRE92d0JGdkxQQUlLZFI5RFJ6?=
 =?utf-8?B?SUk3a3drTFVGeEhsQ1hGSklXQ1hMVEdaZ2tSdlFZbGxQWXNMWXlYakdKSlhP?=
 =?utf-8?B?c2ZYK0xtdVQyMUlSQ2p3b0FsQkQ1UXFSR3FZQWFlVFRIUDJKcjNzdWxaWnZV?=
 =?utf-8?B?bUl2OEZtUEtPUkxDVVVsTUV1Wnl6dWt6UEJBSTlna0FEcHFLay9vbXlzYWhM?=
 =?utf-8?B?ZFR4bzkrYU1STlc1UTBKMi96NWF4UjI3YmF5U1ZydG01djhNMUJDQlpianRa?=
 =?utf-8?B?d3pIQkFxdmdDV3l5UFpwZkdOWDFyNU1CSEQ5OGVJUTRnTEtOOHlVRlNLUEZj?=
 =?utf-8?B?Z1N4RFhQNzhkMGZaYzNITGpwMU1rL2MyUG4zRFJNdUhIRHZtTWp2OWJiUGQy?=
 =?utf-8?B?b0M1ODlXbmY3dXN5cFJuS1pkcDIyTWJrYmxxOTUrbTBHQkdNaHpEY0k5blVo?=
 =?utf-8?B?Z3dCeUVRWW5jY2h4Z3BWWGpySWl0ZmRvREtxRjFuZmZRbTRoTUlEOFR3YjVs?=
 =?utf-8?B?VWdyT1BGZ3dRZjI5d1RTSW82VUhUaDNjeGtTN2NLdEZuby9lTTNxQy9vZE5G?=
 =?utf-8?B?MVhuajlBdExjdXhLb2FWdDZKY0JtSHRsSTcvTktyK0lZbEIwN3lkZ2Y2U213?=
 =?utf-8?B?dnhjbStvK3RtVFVZVVZzS3JweHhscGU3Z21ZSnRSd2tkMFh4QVVlTGt4aTM0?=
 =?utf-8?B?RTNYSDQyeW5XYkw5RFNxSVBHaFhmYVhWeUI4TlYzYVNLRHR3NjEyTHJKWHJ1?=
 =?utf-8?B?L1Erclo3VjBINjFLTnZ5U01xTjFGWHRUWTlMcnptcmVPSjBoMStxOHE0eG9C?=
 =?utf-8?B?Tlp6NW5HbkV4V1JUZ1duU1hxRVV5TnNKVXhqYWxya2F1VUtXbmdoWTYvU1kr?=
 =?utf-8?B?WU0rbEJJcVIvVWtmL25PeWdWTDFQdlRMTUZyYUpNM2R2RHJkUVc2QTFVeG12?=
 =?utf-8?B?eVhPWHRvYVhmamxMODB6a3Y3Y1VSUmhHaGtUTVpmNGMvZVhUMld2MzVsTXlT?=
 =?utf-8?B?SGF1ejB1STRaRnFRZCt1aldVNzFIKzBOT2ZVK2Q2bEhsc1ZEdm5Cb1lPR2VC?=
 =?utf-8?B?MWNUTnFyQ0R1S041dFFmNFVvbS9iS2xmT01jdUZ2SlpuYk1vYlVYd3IxVEFK?=
 =?utf-8?B?Q3Qwc2FKNHZiczhqNGsxdi95cERSMVRIVFU2VUtkTy9tY080K2tzQTE0SVd4?=
 =?utf-8?B?QWo1TS8vNG9ncnBMdWI5eTlaMUhqQmVFVjQ1WkE1T0NjMEJHRExmblhWQVdj?=
 =?utf-8?B?Zk1Gd2xzRXVlWE54SFVuUzQ3TDh1d2RxU1ZKUW9lK3ovbEoyMnhFWiswSVFw?=
 =?utf-8?B?aGdRRVlNR2lrcDdjdzlLQ3g0bmxZRkpEYXRuWlJCZ21NbVhqcXF3VTRSenhF?=
 =?utf-8?B?WkRpOE1DL29lelJSanQwYVJ5NlJZRVVPMVdxbVFBMWttN01pckpPWHI2Yjky?=
 =?utf-8?B?KzBuVUxUckpnU1FKTWdHNjNDT2pvdE9LY3R6Q281T2Uyc2JjcFZLVVZzbWx4?=
 =?utf-8?B?dk1DQkd1cU5PV1VFNUZkZG9MWnBYS2o4ZWM5Sklmem8yUkJ5REtLYXVlZXpt?=
 =?utf-8?B?T1UzMU5FZ3pzaTNZaGUxcU9ML0JjVHpqdmNpTkI2dUJrYm1QZ1FaQTZrbTFV?=
 =?utf-8?B?RkdvU3BUVXcvR1REUmpkbnd3cmM3K2l2ODBMMGpvYXVyTWxqeUZROFc3TWZu?=
 =?utf-8?B?dzBtSHFOSkltVmprTDRDbVpTZXpwZUVwR1hRUTV2a1JaT1lWRCtPRTVMR3I4?=
 =?utf-8?Q?FQU3+JrXkjmMoEm5oh0846ZmoG0fRT3cimAG2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a175c6-f928-43a8-8b6d-08df1fb9f243
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:46:00.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLS5k5dspG54rEuCvM+LtUq/jGxvMSS0h0dl/1NT/mc43bW5mR0CxF+BO4aWV9UOG/XsalXX+f6Qhoa9sj4DYdl3gacSefYwmL3nyboXxNREFI9u8WAk6PKqhC3o8FWA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11839

From: Peng Fan <peng.fan@nxp.com>

For shared SIDs, only the first master to attach writes the STE
(tracked by ste_installed under streams_mutex); subsequent masters
skip the write.  On teardown, skip the ABORT STE write while other
masters still share the SID.

Fault events on shared SIDs cannot be attributed to a specific
master, so arm_smmu_find_master() returns NULL when the stream's
shared_masters list is non-empty.

Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
since all three require unambiguous SID-to-device mapping.

Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  3 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 43 ++++++++++++++++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d801..73fb5fad1c181 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -309,7 +309,7 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || !list_empty(&master->shared_masters_elm))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..54a0a65669ac2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -271,6 +271,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	if (!list_empty(&master->shared_masters_elm))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0f7e90af5823d..ae33660ca79e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2976,11 +2976,36 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+static bool arm_smmu_is_shared_sid(struct arm_smmu_master *master)
+{
+	return !list_empty(&master->shared_masters_elm);
+}
+
+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
+				     u32 sid, bool is_abort)
+{
+	struct arm_smmu_stream *stream;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream || list_empty(&stream->shared_masters))
+		return false;
+
+	if (is_abort)
+		return true;
+	if (stream->ste_installed)
+		return true;
+	stream->ste_installed = true;
+	return false;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool is_abort;
 
 	master->cd_table.in_ste =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
@@ -2989,10 +3014,12 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
+	is_abort = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		   STRTAB_STE_0_CFG_ABORT;
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -3001,6 +3028,16 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		if (arm_smmu_is_shared_sid(master)) {
+			mutex_lock(&smmu->streams_mutex);
+			if (arm_smmu_skip_shared_ste(smmu, sid, is_abort)) {
+				mutex_unlock(&smmu->streams_mutex);
+				continue;
+			}
+			mutex_unlock(&smmu->streams_mutex);
+		}
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3149,7 +3186,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 		return 0;
 
 	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_is_shared_sid(master))
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {

-- 
2.34.1

