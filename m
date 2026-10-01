Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696504C8C6B
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858744; cv=fail; b=lc+VO8a5qkw7cvTHc9JyJfx+sJ665B0XOV+hUdcMeeAOvG28mjB+FppyWuHPyUYi0ALCjor5bi9j7XI6Q4B9DVhE2yV1BIuSLnb/2ocWOnPj3qNb+I3nPkiTPALwbbpGh2wZ3Zg66XqZgJ/BgBRpyIhHt//KduCfAA3ZCiS27PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858744; c=relaxed/simple;
	bh=JDbBF01+ZlCSScmAjbZ4sg8rbftLv0/WEDio4MLgtRs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qP/buS93oDZivsFoTtUT/4kQ7DxqGP3JWpoODa6+M8yDpA6A2nh4MivkTjyzHHPKtAnU5NVExXcNKh3W6GU+mSztQbkmv0WagkvW7B0B3aaxTwBdbCdyojp9Juav0+iUbpeSXLff/gNkdEDn93tc0rLnWSsuoVnLEWJHvGM50kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GAaL8vgo; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GAaL8vgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5ZsRItMy7kdhUJQ3+w3VerOh3010Sbwm9ZskooKiaDbUklW2hwdBPhdctt7j1w2Btq5wUhcHFE8uCDPsgSE1zw4sqGxOMTeSX2DToQYKuHnkV+errvphpxgX8zSLONm2P62xUOSFIAluFfYi6JwRFen4oiKOxShXM/kmifJ5tUu6JmaPYyh55/qCEPSd9SAZanAep0DHmdEOtesCsnqx48lVhGcuOU3vWK9Qe8gd6UE/JCPGNmBougJRaUQdQp8cBUT5yD/Z2BHpV23w8PRZ3CycMEvrCbMNbJ5j5/cXPpF3PNegMKMYrD/W0Wkg13NgTkDt0S1ClNBz2odgHj7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0faFNRndOgpJg/URwohOeL8tcq2P088uuWLeJogGk4=;
 b=vPrdrtnohv+/FU9CmzTsq2BePwb6bMCJ7kkWSaEaRioIi2n0AMf8UCxkcGCO19wFybdl4QaCF5bUu/pslw2uCQpcTevcPC+VXAofAqPiHBxqJAOjf7s+tpyMRh/1f5KJmg6Y7dwb04A++TG54FeDKbhGDqNyrTa+f/oKWBChTJ1lj9komSzRp/2yk+wsUUnoqw7S4nq9Qk0WuNMQR0xEC9+IcMH1oRxHWJJ/fRADSOlHxlYUM2f6klRrFgJ9kcFFaBjT7FucKx+yU3oJKF8vsYKgDyWTzpk1m1Qcxx2bITTEcLMBJyULnDODgHr7YZEGFdFhdJtwK2BqjxtnzAsvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0faFNRndOgpJg/URwohOeL8tcq2P088uuWLeJogGk4=;
 b=GAaL8vgomJchSuK3rzi9LpVzturQ9at4uaL9WSZqJE0Opp0rJBOs2Gs7mHLdFAt+nj9XIRBhEL9nuFgeCVs5b8ZjXL8pU6SrrV7yWZkiEHH26+DB8yJnutzQLxu9Y58g78I4XTsUL9oiosgyIUX5wF1t63Stk74zFGjTnsSY+6e8GGU8kcETQ1k9OpaU5/Q3kqAgjCUR39Zi6U0TwASwDl0+QSdgt2kf/+Zz6mwVnmIGmKM5DaQ8RAexI/b4mR47Eg5LBlaRpvq+6PVBbWqsjrBnGGqfdTSf/ka9gLVk0vfCf5WtT+vTwKMmjD2vmHQdisIGrbRg5RWhferjM1hZIg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB11839.eurprd04.prod.outlook.com (2603:10a6:20b:6ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 12:45:40 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 12:45:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Oct 2026 20:49:58 +0800
Subject: [PATCH RFC v4 1/4] iommu/arm-smmu-v3: Skip duplicate SIDs when
 erasing streams from RB tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-smmu-shared-sid-ver3-v4-1-06b34fb2e691@nxp.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
In-Reply-To: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0237.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB11839:EE_
X-MS-Office365-Filtering-Correlation-Id: 4363ab05-0815-4d95-5e0b-08df1fb9e64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LJ3uGMevZaOZgKqDDNapsc1KkDK2k1yg1JnzcQ2mJdWyCQcsKVybK79lASVHYrEu5pyMkDI1wqRZrm/shnj5LudLfIDV8ALEF48GbgwMsiPQNknTSsNlf8I1DPvXkvpPxc5qCtsb+DXNBexJbRTEO2FrhFZdtcJl2OjGVwgUVuERWn/2bKGHOf6m5+RoLsJS3X8gCryN4xL5WBqMAduRw694FBTjUie2rKv+4TPPZ9kGVekEXqmmAbj6fyHtJ0fzgH50Rgh2NrQRdZB3NMEdqlzCI7eUceOdbZQ+oKS2bSpUsIGVgBeOK689BydtE/C7jXWI4Qrm8QbIlsOe+JTm8fPaXhdGV75Bi7+KuFpebWRDJPTG/hn0wTGw/5c+jURZv3GKbKi5xl7zUjuIinaMqbjaPx0npeummpMJoRlz06jI8rBC1rYZUHmL8oGbh8AsKYz1kIIHjJ0NJ3PkbqCNlJxDnYSkN9TzXTNHh01xcni5Ah5B4YAIJHsXZO8GTQUUQ7/64kuAY6TqMojO/L/JWK3bWmsDno7B9VOoRb7FS2ED6lFPlYpfdo6aRmJvULYEQWwEo+4PVFrQIqhNvLFJJJSZcf9ICE20vUPniUq7+shd5vyn+EIBjtn0Wxga6cR2ZOhrRMtYwykHvcX+bhdvEKyyK0Ba7gINSe6oenQTSXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHlyTlpJQVh4RGlnQnQ1c0FhSzJxaGJTa1NQZ0pHYjF3dXNWOVNXeXJJektu?=
 =?utf-8?B?TGNJaVllc3pCd1pkRFlYSjVJOGdRdW9VRk1iTy9iNDNsVXRkSWFHdFJZWjY2?=
 =?utf-8?B?c0lWOFFhcGFsQUZXWUxGc3hBNDRReHlVWnZSTERnTlN3eXFoMTBINml4ZXZX?=
 =?utf-8?B?VWN2OGVyN2FqdUdyRUF6L0NmQjd4Qm53Z1pKYWI5SXpsVXNHTzl4eExYU21Z?=
 =?utf-8?B?alBCYlAvUVlhV29EK3dwdUZIb3ljbUY3djlKeTJ1TWhERkRDc2lkQ3NaQlhx?=
 =?utf-8?B?enB5bWZocmtuTFhNK0NJemZ0V3FES2F1QzI0TVg1QWtTVk1JU1dVSENxVFli?=
 =?utf-8?B?TEM2SnZxa0FNRVBUZ2liL2xjazNrYlZRQUc2UlRTQndhRTZvWm00SnJMSmJK?=
 =?utf-8?B?U2xkKytDdGlRL2c0ekc1cVNMS21lUVhvMlJxa21OY0drMkFjQ1RWWVZMUTQv?=
 =?utf-8?B?eUlqOGw5aUI0MDZ6dzJhemdaSUtEY3BNL0RIc09FQ21lclY0K0VJMXJZUGY2?=
 =?utf-8?B?akpJdElmZXcySnNUUkprNHVNa3REUlhPeWNMYUpGTFJFR3FvOVhZRmFaekYy?=
 =?utf-8?B?eHQvREtvVGtVSHNXSGJBNndobHlyV0MzODh2L3dvTEdsOSt0T1ZEa1B4QUVi?=
 =?utf-8?B?WHk4ektjUTNidDlaaFlUQVRDcjNIWk1ObHljUnU3N1NNcy9NSzVwV2MxcWpU?=
 =?utf-8?B?WUhDMlQrZDFxaVM4K2JhMGZwWk9vNlNoR1o3YlVSOVFJK09DdytRcFlWUWFa?=
 =?utf-8?B?NFdjYkpSaVR6b3BHWHBuV2xxNFh2ekdBd3lJTnhoQWxaWkh1TDlYUEVkS2J2?=
 =?utf-8?B?MDI3Tm5DZG5ZLy8xTGlBSUJWeFdDZ1BMUm9FV1ZUT0o3NXZuMm5vaTJMU0RN?=
 =?utf-8?B?OG40Q2IxLzhtcnBHYkJ1eG9ESDFOOG9RSVJlKzhUaWdkOHREMGZnRm5iRUJK?=
 =?utf-8?B?YTJVczM3dmxvVHd3bC9OaVJ1cE5nMldvQmZnVkQxck9YcTNRdUIzaGU3V285?=
 =?utf-8?B?SVpwSnV2c3l1YURTa0ZCakpSNXZFMTI2YklnQ0Q3eDRkcCt2TWpYRnhaSFpz?=
 =?utf-8?B?M3g2bUZLREJReFJlQWZDQlk0UVg4RW1iQ1owSk9NSDBtZTBpQ01zcnF3dWp6?=
 =?utf-8?B?K2wwK3kxVVhMM2x0emVMcTZicHpzZkFnQnlkWFZFcWZMcVZMR3V2VzQ0K0xh?=
 =?utf-8?B?dmZrTkFRMzNoUzBmTTJzZktSSW12YU9vTnd1QlFSdmhIZGQ4TnJRNytCMXBx?=
 =?utf-8?B?Z2Q4QWt5SXJ5QkhYWkUzN21TU0NLdGcwU2xIOWJ4THRLdXVGUVZiRUErR1BI?=
 =?utf-8?B?cW5kRHNRVk51aC8yZHNHWmtoeUh4d0VpdW9SWnFYWmcwSXlySHpZaGdyVkNl?=
 =?utf-8?B?aGpENmN0YkpWSnNFUTV0NkM3ZHkxN0FCUVpMRjFjTkhRSEpJSjFKWituS0NG?=
 =?utf-8?B?aDlRVjZVcjRrUTdlSXB1WWRSeWc3RFhhWXJkbmRySjFwMTgyK2FLeUlBUG5H?=
 =?utf-8?B?dm9ieTNjcStPVTBGM1VmaWRYY3k2R1hsNGF4ZmNoVTBWVC9ETWd3Q1Y2Sitv?=
 =?utf-8?B?Y3N0enhoTmc3a3pCTVh6SUh1dlRFSDhHWjJqdU52VnZPVEZaanNXTUxmVDhO?=
 =?utf-8?B?N2JpbVBkM2xLNmhnNjViS3RRZUpMbmdJRG1XMFhsWXU4cFBRQlRpZkJjODM0?=
 =?utf-8?B?bjd6dXQ3ejFsanFRTGc5bHVML3VLT2gyZ2RNQ0hSVEFDcGxYOWVUOUMvZ0pT?=
 =?utf-8?B?WnBKWVVNSk9hcGM3bEJjNjE5eGhVZVVhdS9RcXdlWkZxQS9HQUU5c0hnRnFG?=
 =?utf-8?B?RVNrNXFwVGhXaUc2dnpkVjhRbTZqY1gzcHlWdTdrT1NZWE4yVnlDT2tYL2Np?=
 =?utf-8?B?c25kdTdsaCtpZTJKQXp1ZVV5cjhGNCtScDNwS0dSajE0UVJQNGhoTjdQSWZr?=
 =?utf-8?B?aml3dVUzRE4vT1BuMVBqNGJBcjZYVldiOWVkemMyemRPb2pBR3IwNklUTWM3?=
 =?utf-8?B?N3k5WXY5UUowaEZsRzdVYUtXNlJQUys0dXBUQkRTZk1xNVplb3BuQlo5alFu?=
 =?utf-8?B?L2crNVNzUnVVVWZGMUlMcVFHaEhzbkREbGlPSWNIK2lZbm9iQll2dlQ1NWw4?=
 =?utf-8?B?OHpEYU9JRURNZVBxN2g3UjVVdUVMaFlOeHBOSXFmWUtMNWRFWnZaR1RYb3l1?=
 =?utf-8?B?a0dTVmhyRXFibzVxQ2xLeHgyMjhrTjhFYm5XeDAyb1FoRTVBRE5YN1VadGRn?=
 =?utf-8?B?aUs0N1FzdUdWQXpSWHRyZkxhQWRQbnI3eGtOS21TWXIxcUNsTW9xcWExdng5?=
 =?utf-8?B?bmlUOEt6ZURkdnVFY3ZHYmE5Rk1meFFaZVJWK1lGaEJrOW1pMFJWSEIyUVdF?=
 =?utf-8?Q?0VrHliHM7+bHrZ0abPdXZa3Glm48RUAonGK3J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4363ab05-0815-4d95-5e0b-08df1fb9e64f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:45:40.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuTg5P16pVZhyD7UzbUKVQzq/yOAUbPMdFVrEb4AjcjZIxHYbBbpl3BBse9MUer3sQI+b80Wuy+0XujU6Z0iLE8/s9kFevetrOtHVIDC9pwggtNQRIf8gZAjvcsQ4/gV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11839

From: Peng Fan <peng.fan@nxp.com>

Bridged PCI devices may end up with duplicated Stream IDs in
master->streams[].  During insertion, rb_find_add() silently
drops the duplicate node when it collides with an already-inserted
entry from the same master, leaving the duplicate's rb_node in an
uninitialized state.

However, both arm_smmu_remove_master() and the error rollback path
in arm_smmu_insert_master() unconditionally call rb_erase() on
every element of the streams array, including duplicates that were
never inserted.  Calling rb_erase() on an uninitialized rb_node
corrupts the RB tree.

The streams array is sorted by SID before insertion, so duplicates
are always adjacent.  Skip them during erasure to match the
insertion behavior.

Fixes: b00d24997a11c ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..a79f2250a4886 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4153,8 +4153,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	if (ret) {
-		for (i--; i >= 0; i--)
+		for (i--; i >= 0; i--) {
+			if (i > 0 && master->streams[i - 1].id == master->streams[i].id)
+				continue;
 			rb_erase(&master->streams[i].node, &smmu->streams);
+		}
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4173,8 +4176,11 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (i > 0 && master->streams[i - 1].id == master->streams[i].id)
+			continue;
 		rb_erase(&master->streams[i].node, &smmu->streams);
+	}
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);

-- 
2.34.1

