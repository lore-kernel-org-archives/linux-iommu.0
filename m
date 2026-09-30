Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37E3D1A81
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767248; cv=fail; b=Ce2HovnKCtmhA8JlTtxi7O4gTU6UTCs1WltDho5JbUyXdg9kKEfXho6biGAUHgrjNGLFOclS0YkqgnHSW4PrMNdrlcH4LGRT4/UaeBb/I6QK8VPep8oCyjZuyrR66b3Os+QKXpz8wYVRGO18ba+ypntG9VeCNlWVa6cg+qG4Has=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767248; c=relaxed/simple;
	bh=+GfV4jXvB8/IDHwifsfBOwTO8eJ00bes/V9bT1x9ntI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kXvvcX9hjq0oRvZuATVdYnJbR3H/UTP5RtcPEBeGF9yN/+khgqnhRX0QXzdGqnthRdHQYtQMrKmUvPBm5Hp2WyOPX//SVZm4ioAQWP6iaqHffhmDEHgQaFIX8APnGVeSxq5E3WNYGEKCRs15tSGi1NYsjVdZ0gErXxHXRa+2sqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NjX2ksHJ; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NjX2ksHJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn0XGz/C+1vE7NqXddgLaWwM9LIMwnAcm8kqIPzQe4ZWv2WGAg/pSR58LFZeWWwLOW9fFdn7cbCs7AvtWtfbTx2taQMPFYS8EN7LMPKvjovee6Qmrtcc8ksaARgdlit7lf/+HUJWcB0k/s+F7ZVUqlrHPMBbiBhPYEsb9mAOINMzQky40AIp4CCZqRF+eZwjo+Dhm4HEUSog7ruXa7KFd+zGfEZoI+haz2JVGo5bbXdUNHqqGHfkAautcg+I3TkOhEGk6rH/S8PiRsW/IrEyHMXCX6WetbA/zQOGP93tYQlpPra/DnSd/dktp3DofN6TAqHABTR64uwEVa0jOHAoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afsFMTDDywZ7QJoZlOGSH951C/2sp4EAtyqY2uB/vEo=;
 b=qyC+RqNQX1Sgj7NOW7VIMEoFvdMSjaOHjcTOhngWmpEoZ9h16+gbBW/1tEdGCN0cxrJyDC5toU/xqOt0arOXIxYmsWPhTqyRLOsi9P4T4FhFtZ2z0qdNJmFKrH6sxR8aBOPGvRQPMd6MN63UV0OOw1jP9KBh3U5LcEWQkKzlSJbQ1+saK8Aja5upawEna3plaP5A7vfbe8J6XJA9/73vlQp2a9u0c8BrDvYRaF2GPKQiVWjibuW42cJOskI7pioCuwiiQ/kn8n8sYkClH+Tux4mX4B3LNR/+UoL6FD71N9FQefP9xBCyj33Zjup6FzkBM2U/E4fTcCZSiXIyAr7wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afsFMTDDywZ7QJoZlOGSH951C/2sp4EAtyqY2uB/vEo=;
 b=NjX2ksHJURbwXdykahcd3Kwx2RNEqhArgMRLYyptPIX2S8zzCQgAYw2ZPZrOir8sGR3mhG65nDLfjhzBi2t8mNvH51blSZiTAnUtnG+6l9xN6CO1XK2dnQc26zVAbxRdpalCduXgrT26uwX/tteM1VlCzNym6xmwOARSauxY84xfiDsyvZGArHKdFcbk+Siowgj/cP8Gp+QIlJ8t9PBiyh+Bmb/hGal2LhAd6W5SaCN69HzGVaq13ZwnzCk+PeEQfXf0xjc+TUUJ8byti/8qa0vIQG8dDqM5kcH1iH38wrCpWYIKWCobBe2m1v9yqFTZggQTmSUwVeTOPpXi5eyVDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:20:42 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:20:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC v3 0/3] iommu/arm-smmu-v3: Support shared Stream IDs
Date: Wed, 30 Sep 2026 19:25:00 +0800
Message-Id: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzxvGoC/3WNSw6CQBBEr0J6bZsZGBBdmZh4ALeGBc400iR8M
 g0EQ7i7gGuXVXn1agYhzyRwCWbwNLJw26whOgRgy7x5E7JbM4QqTNRZJyh1PaCUuSeHwg7JpGm
 RWONMoWBddZ4KnnbjEx73G2S/UoZXRbbfXBtWsvSt/+y/o97hvxejRoWxPkWpiZXJia7N1B1tW
 0O2LMsXkX3IJsMAAAA=
X-Change-ID: 20260916-smmu-shared-sid-e488f6c4d4f0
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: abd9bbdc-970e-47b3-8865-08df1ee4dd4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	TpYvmnsB/dmTpQFa7ON5K0V70soqj7z99kQud5sUl/0k/tGqCju2EGe4AjoIDOf+JaBTmpx99YqTaHgkPkdyYO9w8WcZHTRHPIbQ5RjCMm+99d65W/RspCcrdrYGMVtU7sB7vCdfXep0VDHRyllzZRnWre4ikRQcqdHqp3a8ZJuPP922pNG+1aVkJ0nLM65z/W0GaTJYOlmykc0NbfWnpDbYbmGFknMG+u+NBte5z1ybbqncIzmdXzdyuwAIou+lfo1gdamCXs4OXr9kralF96fosbLkcOfH+yswz8qNjeGzBEuAe3AXS8t/5xQauJcGYyrLy8DtOhMRITppsxTTTpX+HLcaSr+Z+043qw86VyChk4Y33w6X3y6R2JZvY6Xf2pYyPZ0Fkrlg8JlZmF+BBG7SFDDj930pvrYzUUaqj1u18vLp6AAkSFj8yfwYuzUK1GmkRaz1QMm17rvz58M1okPuV5/AESald8T8meMu3lbLv4Pbsw6383QL18KEGFx0Q8XE3swR6x4OlMZgTwIzC0Sei33W5Hce5QGp1SMaCNCYVAGAcrpfwzJldNt4HmbIR6dlyKguyzuyy+QPGfp+F02dUKBXGfConKZ/EiZ/LLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a295cUdCZ1lyckZzN2YyNzZtV3ZZT1JJTXpCM3FWRTV1Rmp1blFzNk9qS3lz?=
 =?utf-8?B?SFVZS2poOWlVMXdPbEJCaEt4NzVpN2dxK1lXNXZSME8wM0cyekNOZDhVYXov?=
 =?utf-8?B?a1lvVUxubnI0dDlNWkxEMW5GekEyNE14UWM2eXVFbkZib1B3R1VqaVUwVHgx?=
 =?utf-8?B?QmdheUhWT3B3aVRjdStXUEtBeDdMVm1zeFI1VjZlQTZSd0ZWK2RwUENGQ01F?=
 =?utf-8?B?dWhHeTlnNjNyMHJRb241NWxBbEdPbDlrUy80TGd6bkp1TkhsVENzdHFnZEpw?=
 =?utf-8?B?N2xrSHFMK2dxUmp4Yi9Rd056U01GQ0pjbzA2b05PQmtpRk1rQmlWbGsreENo?=
 =?utf-8?B?TmFRMWZRSlhrb2hFa3lIbld3N3hlUXJlRjBJTVhtd29SYUpoMU1wdE80alZ4?=
 =?utf-8?B?ek5zdDE4VTBmdDNmenVQN2hSSlk2N0pNMHF6NEpaa2Q3b1R4TFJ6amhkMVND?=
 =?utf-8?B?YjJLNW42VW15bUFUS05hODh3L2NDR21YdUx1VGFmSkhPK2dCTjg5RHVtNTBz?=
 =?utf-8?B?czBSZVBWZ2x1TnVRek9nMXFaQkF5VzJyQmxZV3ZKMUFYTmZZQ0tTZ2xxaWhR?=
 =?utf-8?B?ZGZITkJyRE5JNXNRK0dpMUNXL25oQ1RZdzFleUt6OUV5eFhKclprVVhGYkRG?=
 =?utf-8?B?b1dIeWg2akVWWk5yOFBEVS9EQnlpc3pXaklZSjZZTWtGeWtRbWIzSDYyRnRH?=
 =?utf-8?B?RmVtd0NqNjg2K0U0K1hnUUlkQUdoZ3FNOHQ2ZTVsT3M2M2FxcGY0SmdCdHZP?=
 =?utf-8?B?Q0JkTXNvVUw1MHJKSlRZTENJS2ppZjVmRkQyeXl4ckxvbFZ1Wnc3Tkh3RjNX?=
 =?utf-8?B?WkhXRG9XVHVqdzN0VlBkaGNyaW41QTdiT0piR2JSSjRodDNhSmRaRHRzVjNC?=
 =?utf-8?B?VUlJdjhYZWs4M1lOKzZRT0U0TVN1MzI2RXNJNkwyUDIzWlhCOGI4ZnpFT2hF?=
 =?utf-8?B?NG1iWkNFdnN1YkpHb2VSa2NhMzhJeUNxL09nVzBDVTA5YXFka2NGZTMvMU9F?=
 =?utf-8?B?SmVhR2pmdTJBRlRMY3UyclR4K05VZTBuNXpOM1RsaDJWYmM2aTg3WFFkelNa?=
 =?utf-8?B?N0JDTndQeC9YelNFTkdlenVPdnRVS1RncmJ1SW16a3o3a1htai92Wks5WGF0?=
 =?utf-8?B?cjh1NzdlL2pia1dXNUtGa0pNMUtCZGtmWlB3d1grRVpkZGJUcXVWR0xnZ0o5?=
 =?utf-8?B?SmZ5K3JWTXJoN1dyeFBnenVFam0vME90UXVZMmJUaHVYTk5nZEpFMVhPVDFn?=
 =?utf-8?B?bHFMZEt6dml6WWhXd2N0TjNMc3ZxditiektHYnd6d25vUTNFOFU2N3BWTmRu?=
 =?utf-8?B?VHZTclV6cXBqWVlkWTFpQklRRzgxamhlSitNTldNbXNpZFdxWDRYNTVwU29j?=
 =?utf-8?B?a3BhOCtQWjdKZUZCM1I4TG9qeThKbUE0d1dlVkVjNzRyVEluVCthaERHNEdz?=
 =?utf-8?B?M29KYUI1WVVmeS95emF4UmwrV1cwZitjdlQrc3E1ZE45NTdSOW5EeHBpWTZM?=
 =?utf-8?B?Nmg4amtIK3laRG5vcFhZcThmRzVhT2J4Y1E2dDg4cW5mV3RUWjliMWtlWFZl?=
 =?utf-8?B?M1hJZ0x1eWZGMkFETmZOQkxwMnc0ZnZUSXBSL0p3M3FwaVpML09VNUQwcFNV?=
 =?utf-8?B?VCtKV3VucG55R0J4N1JpUGpLUzd5Qy9zRGdFaldhSUNITk5yUjE0ZXd3SjlK?=
 =?utf-8?B?YllENWwvV2JONUEvOFArYU9YT1QwaVVsSWw5SjBzT1FlMmdQc1I2TmJzN2hH?=
 =?utf-8?B?bVlsTzU0bTExU3ZjRHFLLzNEaTZ3bE1Mei9JS3pUdTFnWFdDUGpxK04zNTEz?=
 =?utf-8?B?NlUrTjlPRmdIRHg0cG1HZzJGdG1YRjlUUnYwRUZaM2RZVzk1QWVwek41bnE2?=
 =?utf-8?B?bDN3Y3FMaXg3VW1iUnkyMXZtby82SlpBRXNvd1lrZXRhSXBIT3FybS8zYVcz?=
 =?utf-8?B?dkZ4MUFyaitDaXNoRUZXV1FaYithQUE3c2xkRFF1TVRjNTVBUUtUeDhSSFIw?=
 =?utf-8?B?aFRmdTd5N2NUQ3lndjdxbUQxNFZiUjUzNGFCTEJlMEVybkt3dFJKenpNN2F4?=
 =?utf-8?B?SGY4NnZzU1JRdUFRVXVPdWlscWFwNzhzamViUkhDR2plS28zQ3dHakJ4WlQ3?=
 =?utf-8?B?Y3FUYUdpZ3Irakx2cVltNWlOV3FBL2lraStheDRQa0M4Vkw3amhRSnhmWU92?=
 =?utf-8?B?LzNQSVFXbC85aDJjVUdVNVdRYzVkNVNwTTRiTTNyMmpqZ0ZKdVF3RlBHcGU2?=
 =?utf-8?B?TWVxZXhRV3hiUEVyY2tSdHBjWkp1cE1RTzNtUmpQNzhUak54RVd3cG0vbHgw?=
 =?utf-8?B?U1U0UzN1RVo4V0tId0RuRXBBVVhEZGJQTU5USVZOcDNoTDAyTGcxa1BOb3lU?=
 =?utf-8?Q?yH6942rwnsaOorkuzEPnBJ1U9nwWW/+4d7/nc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd9bbdc-970e-47b3-8865-08df1ee4dd4c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:20:42.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtrB5r+dI4rURbtCoB05JDnTm1G8BVRYyeLZhGDsT4OnMNpmTzGx81umZ1DraOm4O7nPGubgKTvghzRSIY6RChoIhj5CXkagMDFk/YdYU0XgB7wEIUIya4DlR0OnzO+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800

Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
hardware that inherently shares them. For example, the NXP i.MX95
only has 64 SIDs, only 6 bits for SID in the system chip bus.
However there are many device IPs, such as SDHC, PCIE, NETC, GPU,
NPU, Display, VPU, ISP, ISI, JPEG, SATA, DMA and etc. Each Kind IP has
mutilple instances inside the SoC. So I introudce this patchset to
support shared SID.

The current ARM SMMUv3 driver rejects this with:
  "Aliasing StreamID unsupported, expect DMA to be broken"

I took comments in [1] and implement this patchset and only want to
support a very simple case that multiple platform devices share one SID.

[1] https://lore.kernel.org/linux-iommu/DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Drop the conversion to use xarray
- Only SID-sharing for single SID device
- Follow Nicolin's suggestion https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
- Link to v2: https://lore.kernel.org/linux-iommu/20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com/
Changes in v2:
- Only update cover-letter to make it clear about why introducing shared
  SID
- Link to v1: https://patch.msgid.link/20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com

---
Peng Fan (3):
      iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
      iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
      iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 153 +++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   9 ++
 4 files changed, 137 insertions(+), 30 deletions(-)
---
base-commit: 86fb14622b7ccaac8916e5541bebc4d70f64331b
change-id: 20260916-smmu-shared-sid-e488f6c4d4f0

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

