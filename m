Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808B3AEF4E
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718038; cv=fail; b=pURoQGn0b5KkKnEuEJUIJ41oKxc9i3glRMPzHR+7RWHoKDlAcQdjJMYUNfvluxmjEe7i19VIhQprAMUDxq68xl9r/9ALjGXdFM8Dtp/gV2ss+RfuW9vXB+trNdeVVG3GwekUrRWGoCgOrdGbptH3Tdhwj/UEB/LpRkGlQylAGX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718038; c=relaxed/simple;
	bh=H02vaI8OkH/82FMZbh23u5YL/fAarka4FuqIFE5MFho=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OQQtaPeELtXD6MlVr8/y4FL0KnA0wqWKk3oKmTTX3pnEScfQSsJ5cr1VdrsbskckxOFeKTPjsOAWpc0TK7+BNF3O8Q8N75xlKh1pmfh7wx698BEJHYaXBj09uEfTCO/hNvCO+XWlxCvPgcLEgRf1WmTkfG9tdVH1bMFi0hsr5EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UuGaUzJw; arc=fail smtp.client-ip=52.101.72.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UuGaUzJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snpGdMHgRAQvaVxI8wPGpIEFHdTxXwig4IwGoGxtcA7mNozygBV7o1UW141OPZdkLz/aUBamI7bt5JNjDzAJ43aHwLlrl8SHVAwD7VR8ToLynN6tbC10hVoe9v17nDelPnBdH3sU3y8ilvKGloRMsFCs51PkfMdtELEpkwEpweQ1JrkUXIbaRJ/Rwcv4JUbu9shFJIiBDM21CPKFEr8BJ6muwP6BzLRSDD889KnF753KOGiAouop/nHBzx4N7whA7Xr+qzbs7vR4Cyrb0nDAbEBU1lWROP+VTGLqQX7/3sBknkx/eBO8M1qiI1jsjkTVLqYKUj5Boht6rF6/JtJ0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7ozklAFCdngqlBI+2BGZ7DnsbE2hbEoGCSRZD4rFgo=;
 b=wC1TxDumrYUXxrMRXFsDwnEeO64MjZXSnvV4f++feNC2QpcUYe/luXy624EjlKNKJCI5ZfEhuWrFMnjL107vpOwLLNvlwusAiavJTA68OiT7UiwkXKlKPHe9FaS3rz7AMxLpdfH0NfyZrvL7NFfoXaJPa57ubRgz/tc0YGaUgCta9jW9Wo0QqvJ7zdAhkoeJpaJTAF4saCTPP9py3KmPqEKgLjACETD+MCmuBYU4LTUZ1iYgJNnwdttTDyQLHwPb0SG38SrDk4zavRxFbYpqUH5ePuds412PPJVdSVCSkNr558QEjwMibXloQOrGcBCMHzyUGP/4QZtcGawAklOOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7ozklAFCdngqlBI+2BGZ7DnsbE2hbEoGCSRZD4rFgo=;
 b=UuGaUzJwg8t3pmWlriy7WNMi+ZQ/PFUuNH9buwYZJljX27CD7ZbnruaNQGQTK5uvVHl28nC8a/mIxpY0ViRXLjG6JiQE1bhpbM9TGUFhXWT7NIAorfZ83ooxMgH9Yc9pvrwOeVyd/T0Bbn7iKWynXVonebrOnWP8NEZwYtWJbKPHDFcesBdq2BvfxBbwU/vNBKW3Z07J8Wy72tnvX34RATTwOSYcgvmss0Xzm6k3NcDKkzAQYxPQaR7Eu/xMDtInR2iSzMLmIHaMmeRr8ne0jHupof2ZOfZPWb+uLfag/rj2Ze8I8pMpxCugblhTc2XoEET5BrNRA7Qruw/6buxHng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 11:27:14 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 11:27:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 11 Oct 2026 19:31:27 +0800
Subject: [PATCH RFC v6 3/5] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-smmu-shared-sid-v6-3-cb76b89dc612@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0275.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8f18a7-64c6-4a99-7669-08df278a9987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|5023799004|11063799006|921020|56012099006|22082099003|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GogwSfY76+lDjkmNOusECLQKdWpkVzNoInAdBPq7DkpRPSDNAJjbm5RaVbX5Wnxj9nbXFI/wjT4u9PPdEfUKt+38a9aRkRVYsoQyEaJPxGapVyxAvpzlPBxPmkwHgwH2G0+IeZolK5/E3B/VEMSZslslO7rpz0jpDFiIf4VxqYKM3tIVH4Z0mYuW3xwN8KrkhS9TylSVZydbJr0+gmdlCNPVbz6v/0KMcCbtnI5JT016y75ae+Tk609xQEX8RR3JJ6PsPCX0zQc5B25sR2dwHuzyr+XSR+d27ALTquyhPB/Svik5BLN/o5rehljxWbRH0kA49Oeq+6vrCe5Lw//q0DT90SLwSfPwFfhpJRDFvFK61eTUcBdi8hyRpf6/ZkOKK0OQWcTFTlc2Zr82Dm1q32cBfFmhOmiq7hSS31aTpRfl4PHMOhk2oWzl0SaQm1wSEjDxrg9p8+34os8SM1NKppxcg4xyA98mLO34/ultIq0PEtD107OXGKf+ZTil1dGdAoyOoC6UB1xtZ1awkyroSP5ZYAxncS6bgad8zcqdq5zrNgAtRhdDozYjEdf75W5XNdFeC0bbyL+gEchIb3XBpCd6ls8a2sxCQ/TLB4RAK2wP1N61c1aBuX8dI8F7l9hKXIvX2/Lzp6w2B7H9ytTWN2Ye2/WjunSdqwGmglD21OoBwdsMdzCkj25sYEz2MAiAA9tKh2yIK/JX6yeEX2knxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlhjajFoSFdTMUNOaDVGaHNOc2FXd2tsRDBRTlRkQTZoU2p1TXFpR3dwTUJ2?=
 =?utf-8?B?QUN6Vk9Xa0JMQlVLK3NMTWJtcUN4WXRkRmxYSkFJUjBzOHg4NDJOc1pkajBq?=
 =?utf-8?B?anJwaTlySm5EdmZuV2dySjVVWDZEaGlxbUlGR3V6VVdFc1NDZG1yazlrSUhB?=
 =?utf-8?B?TDNlVFI3Q2dRMnhOcDVKdGdyOUo2blcybkd3c3l1d2luVExBTC94STYxMy9t?=
 =?utf-8?B?QjQxaG9Dc0NrWEJnYko5SGNuWm9xY2tWeDZQVDVJMVVHYmxvT21kcVhmSWJz?=
 =?utf-8?B?d3FoU0Vta3BPZ1NxeTE0dldQSUpVSEJwK3o4YVg4ZEtTeU00MFhKTEdkWWw1?=
 =?utf-8?B?UUs3MjNEb0YrUmZEYlFEdE04SlBUS0V6U1ZTdDNTN3pJNnpwRHh5RXUwVllY?=
 =?utf-8?B?SXo0bjY5cGVtZ1ZLTmp2WkpEdjFNd002eXRsZDIwbXhYaUhseFB3M2dUb3Bl?=
 =?utf-8?B?Z3JZK0twTnp4N0tYSmh2WVRpREkvMHVPZ3hpMW04cFFtRFR1S2RlbFM3cklB?=
 =?utf-8?B?Wit4ZjdlTVVKM0JocUg3VGdDejZ2L0pFNnFqMmtlT3JBMElOUDNEVi83THg3?=
 =?utf-8?B?VjRIR1dYaXdOQk9zOU5rbWJCTjh5NXkwTi9TSFJCS2cvcFVzZlRtUFRuZDJG?=
 =?utf-8?B?WDhKOUNrL2VQS0xOZjRZT0wrK0NGalB4UDNBWHoyaXNXUkVrVUN1N1Q3VDV2?=
 =?utf-8?B?NEd1OEFmR1F0N3JkVXQxQmM3N25aOFZaaXdrbHd4WTFHL1FZb0IwTU1va0ZI?=
 =?utf-8?B?cklWaXBBRXlmS1laaUdNU1l5TEZxVEdoY0NBbXFydVQwU2N2d1U2QVdDWHBU?=
 =?utf-8?B?Q1FpYnhlZ3RyQzlSZ1NoZFRzZGs2WnltNFU1SUF3K2FGZnpUMm9SV1pkWEZI?=
 =?utf-8?B?dTEzOCtMNEsxSHJBSUdCQnl3WG9HTkFReWJvcmExTUIvU3ZueEVVQUF6SVl5?=
 =?utf-8?B?U2ZYR0UyOWNGN3F6Q2ROMUY3RjdTQlZFdjNBU0tRNkwyZWk5OTVUeVBqNW5q?=
 =?utf-8?B?Y0pLOVF3MCt4SENSZU5kV1RxQ1lJek5RTld3UEMvb3RudjhJSnNEZ1lVamR3?=
 =?utf-8?B?UGFpQlFJZnBobjR4L1dmUk5wU3M0YnQ3RUNBZGNZZnlrZ1diSGVJZUh2Yjhz?=
 =?utf-8?B?b2RYT1BsWDFxMHY2amNxRHNweGpqRjh6Q1AxWWU4bUw2cDlTU3RSbVNnSDh6?=
 =?utf-8?B?a1o2UHQwT3c1TVd2dkNybEE3ZjhrQTVKcE9DcVpkNmIvR1RjTjNIS1FKTnFP?=
 =?utf-8?B?bGcwRkVzdW5zVDg0aG9KOGl5Y3EySkl4YUNPeEVlK0Y0Wkx0QkFsWkxFSGRJ?=
 =?utf-8?B?MDFsNnFyNmlmTGtpRHJJSUlzZ2NOT3dQU3pEVDJ2bWIrRmtPTzRzVjk5cHFK?=
 =?utf-8?B?bmNxNVQ1Y0Vua2publR5U29KM3BwcUZJc1FJelN3QTMxRkxZTWxGd0NpTmFY?=
 =?utf-8?B?M3FzRHpXVk5ZY28wVFJVUUtIcG5FQnd6VklUeVo1dG1RTCt2Z25rL2dpbnlK?=
 =?utf-8?B?bjA3a1RGck9aKy9XRTExbGRPVWZ6aUFSdndJVGpVdkZjN2t3SmgvMmFGeDJu?=
 =?utf-8?B?KzZZTFNBa2pnRCtld3dFcTV0bWJWTFM2SWNMdlNPd3hyYmtmUVRORU1yZURm?=
 =?utf-8?B?d1Z0ZEdlSmtWRElrTFphT3lWQnMzZk5STU1oajlhN1NwR1Z2TTc2VHpTRXdR?=
 =?utf-8?B?Vm16R3BCR0lDQ05CUlBiYWgyQURQZ014dk0vbWNTRGpsbElhWFdRN2VGdXcw?=
 =?utf-8?B?WW8zWTVOS1VZS01ZRExZaFF3ZUN5dU10MjV4QzdqUUlVNmlrK242QkFNZllS?=
 =?utf-8?B?UnZ6K2FJVFA1QWFJbThLTHJGTXBSTUwrOG5rT3VUVmJ6cWg4QmNnYTBqSGo3?=
 =?utf-8?B?anhtYVliUE5uRzVCQ0RHUTlLbElia1dzZ1krRU11V2RFNmswbWJYeGRrNGNq?=
 =?utf-8?B?Q1c0c3ZmNUVLQkQrYjdEVTVQOHpPOW5URUJka1RUVjF4a2tKSFdvZWpYbjl1?=
 =?utf-8?B?VXFFcDlGb2g5di9IMFROTDV0NjhuSG5IWHQwU2phTW5lNmZvTGtha1BUSjVz?=
 =?utf-8?B?VW13anV0c0FLVWFZdVhUQ0NxaGNGSWIxOHF1cllZMUoyOTM4dUsrSEcvTXM0?=
 =?utf-8?B?bGMrQnAydzRjSld5Y3FybElRQ1I2RFZiQmMwbUF5b1RZYnFmSHRyM1NWWHA0?=
 =?utf-8?B?UVJZUTN4dTRCRFZITGhjM3oxemYzWlhRdFh3S0V6d24zN3pzRS9JeTZ4OU1E?=
 =?utf-8?B?RHRwd21UeGE3ZEFDOG93SmxicG1PajExTlZlVnJadUp6b2hKMHQ3cTNHYVps?=
 =?utf-8?B?TVBMUkhldUdsOHJzY0d0Q1lROU9lZ0RIYzlZZU1tU3Zma09lMDlzcWN4TjhB?=
 =?utf-8?Q?EHPW7v4qr9GsDQWxx98+1KVrgMRzt/g6gAPQ8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8f18a7-64c6-4a99-7669-08df278a9987
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 11:27:14.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ilqt1RWJUuw8XPpYgS8bhwA5H/zFLbFuiETmVY8ne62sNGh6hjcl/24cx6q8c+NbpM3Z7F6NgY1eE7zMhke8C4U8OPZPqwR77PFxnPloaHOKzYacPISWl6mQWNUgQYqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

From: Peng Fan <peng.fan@nxp.com>

On SoCs like NXP i.MX95 where the SMMU has a limited number of Stream
IDs (e.g. 6-bit bus = 64 SIDs), multiple DMA-capable devices are
assigned the same Stream ID by hardware design.

When a second master attempts to use a SID that is already claimed,
link the masters together via the stream's shared_masters list instead
of rejecting the probe. The stream object is shared directly between
masters — no duplication.

Sharing is restricted to single-SID masters (num_streams == 1) to keep
the STE lifecycle simple. Multi-SID sharing is explicitly rejected.

On removal, a shared master detaches from the shared_masters list and
ownership transfers to the next sharer if the departing master was the
stream owner. The stream and its RB tree entry are kept alive until
the last master using that SID is removed.

Since fault events on shared SIDs cannot be attributed to a specific
master, arm_smmu_find_master() returns NULL when the stream's
shared_masters list is non-empty.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/Z3r-cBm00tVE4eKe@Asurada-Nvidia/
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 +++++++++++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ea755ea82192..351ccdfa765b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2097,6 +2097,8 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	stream = arm_smmu_find_stream(smmu, sid);
 	if (!stream)
 		return NULL;
+	if (!list_empty(&stream->shared_masters))
+		return NULL;
 	return stream->master;
 }
 
@@ -4332,6 +4334,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		kfree(master->streams);
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&master->shared_masters_elm);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0, n = 0; i < fwspec->num_ids; i++) {
@@ -4348,11 +4351,22 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			if (stream->master == master)
 				continue;
 
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(stream->master->dev));
-			ret = -ENODEV;
-			break;
+			if (fwspec->num_ids != 1 ||
+			    stream->master->num_streams != 1) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
+					 sid);
+				ret = -ENODEV;
+				break;
+			}
+
+			if (list_empty(&stream->shared_masters))
+				list_add_tail(&stream->master->shared_masters_elm,
+					      &stream->shared_masters);
+			list_add_tail(&master->shared_masters_elm,
+				      &stream->shared_masters);
+			master->streams[n++] = stream;
+			continue;
 		}
 
 		stream = kzalloc_obj(*stream, GFP_KERNEL);
@@ -4362,6 +4376,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		}
 		stream->id = sid;
 		stream->master = master;
+		INIT_LIST_HEAD(&stream->shared_masters);
 
 		rb_find_add(&stream->node, &smmu->streams,
 			    arm_smmu_streams_cmp_node);
@@ -4370,6 +4385,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	master->num_streams = n;
 
 	if (ret) {
+		list_del_init(&master->shared_masters_elm);
 		arm_smmu_free_master_streams(master);
 		mutex_unlock(&smmu->streams_mutex);
 		kfree(master->streams);
@@ -4388,13 +4404,32 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
+	int i;
 	struct arm_smmu_device *smmu = master->smmu;
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	arm_smmu_free_master_streams(master);
+	for (i = 0; i < master->num_streams; i++) {
+		struct arm_smmu_stream *stream = master->streams[i];
+
+		if (!list_empty(&stream->shared_masters)) {
+			struct arm_smmu_master *next;
+
+			list_del_init(&master->shared_masters_elm);
+			next = list_first_entry(&stream->shared_masters,
+						struct arm_smmu_master,
+						shared_masters_elm);
+			if (stream->master == master)
+				stream->master = next;
+			if (list_is_singular(&stream->shared_masters))
+				list_del_init(&next->shared_masters_elm);
+			continue;
+		}
+		rb_erase(&stream->node, &smmu->streams);
+		kfree(stream);
+	}
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 56ed6ad1dd523..95da4ad354829 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1020,6 +1020,8 @@ struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
 	struct rb_node			node;
+	bool				ste_installed;
+	struct list_head		shared_masters;
 };
 
 struct arm_smmu_vmaster {
@@ -1068,6 +1070,7 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	struct list_head		shared_masters_elm;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };

-- 
2.34.1

