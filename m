Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBE384CC1
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571316; cv=fail; b=EkUDNQjrwWxK1avdy1ofA0oHtyXuxApxmVbkSmIrL7hEaRDGzifg216c3d5cpyjN6LAMYA55CDkSKA3QvKVNZ65icjXMjy7Hbvk5nbJPR/MqGQ6hp53hREPnSR2hSBB2xIeVuIyzdR36OxfWKd+KtZvcKFP75CWQT5hE065Jmp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571316; c=relaxed/simple;
	bh=Ty5izmLVsGcebHQJpZKboiZjLVLLbgC3TEzmy4R4k2Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iwf5kz1VX5tqiEaZNtcPyV1MJCAMnKIwyJBFiGeRsOI4auQ/MxoO76cbPKKNVHiRILL7wZfhgigdHn4YvabUToApOyAPi+Qp1Xv6hbTI6kVbBQpmIxFYqHikVQU++BmEGBtym2i1eTUAmdpSeAe7U2bs610XriWHgGYgAnvJqSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iyo1Rkyz; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Iyo1Rkyz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeGXWPAJNS2kPJMtJU/zDOSoaT9iL21KZNizae4WOkFAt3U1iQDQynY5ppIEOW25MvqcZihFPuLwZDEDHLVvb9h+E8kPOR4IWTK/oq7/yEXIPxUVdM6U9hEy0y0KRJZYhpUbRNbCJR5K0NVUYtC9nm0lU3pYJQZyqE5wl7fTXgizOxY9RfIKDcUiEyJXBcqvvtNRGQVcQ7mUgIWVadD2Dhe9tDke91V0oyDxo6DIV+r3Yrsn6ZKDmfJkk8u7xX7kAWz9t3f5EHRAXntScdt88syNuB/43C4LWJppBKZ+Hr92EKJrtYejrV4phyyOBQREqBx1vTjI8a1eb3HLC89wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9xuSyTEzNjdY+vYe0JsHwjqupbu+yQoaWiBY2sGwqg=;
 b=Y+yu7B/kelzBA75pNquodKuCFCdMPnk5f19MwQZOuf119aw1YOAxzOwiN308DPEV4VM+7t8aavMlflwm3RYH9lidg8Rr+LfxMaOxYam0qQSsHaZB/mc1ix0eSyQR6LncZem85y1J8OuKLe7D8SdG7yLTxEmn92xkw4VciCzPYV12wyU9I+PVhiOmDD7mCTtb34WodxJ6OLNfBGINcmKJ9/79ow38IdfsopYe0KCEyCuAWNb3CZ7frFVNaB76J7OlGXeQx42tvdepSgkYnl9iS/7ryHWDOudDXHZQrWYI457DD9llc1YHodxClPgIsX+jr1hj5tUJTti86k0bkAL6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9xuSyTEzNjdY+vYe0JsHwjqupbu+yQoaWiBY2sGwqg=;
 b=Iyo1RkyzXMBvfDuTGwA7m240iWp0sYysggJWkEwIPJKRjF2TUjK19znUub9wwpTrb+aOU07aUCLoFhVFc9Xw6ewy3tXyE5vTSm+/HJ5vPL8bqNM9uWj6N5pvAzyCk6gDIawhZMVYqWLx2s7RB7yutnLeJco/ogqEUWzmB65EEu9xsZXopR6SF+iKEyGhwpiOrpn35IT3OPYH55byLPTD37xbIpJXpP5gvKUu2Ohf2s7CKzoQfVzklucewlwRC8JdpFjLV8yFo6w2Rs3nl9oSCXmgdNlfxM3J1qu0RtPIXh+a6qFkxpmtyTDbNN1VT6ppOSgRyHDhdCkKFCKHWSILzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB921731.eurprd04.prod.outlook.com (2603:10a6:2c8:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:08:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:08:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:12:35 +0800
Subject: [PATCH RFC 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-smmu-shared-sid-v1-2-517384504aee@nxp.com>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
In-Reply-To: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB921731:EE_
X-MS-Office365-Filtering-Correlation-Id: fb899bff-175b-43b8-bfb0-08df14045ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wBgVhnxecCpOCxkdkqgl/EKAcxbo8/wg3sw5Jt2XJidJRz4MlHTj18f1QbGfOhlOVcQdv7O9T4vv+B8X+fXfS6jWPem2JU/2YO3PYjDxnZAnik6Rg8KOvYxEvgsKezffQ0zmMqTcJuE0Cb9sNhwxwviM1IM5zKq2IKdeF1wDhLPHz/+QhqX9+2/O9ZGQErqRbSEazSncOvRRv3/dvfwfeMXD7Dy6I8kTtdFxvSuAf8MSfoc/a8KDykq24c4+Cud/LJf3KHdwnQ2pJTmdlclLgy3nkeZtmNGrGLyYQIl0th7LHe/Fwbo4qKqn3cQJu0WBupTBtNyayewgBX5bjcwFVPtU3FvK3fDYdpdBlVvv3PAWqEN4hWqnanCNR2XLG3NiDP7tkpif6ShW0Es2K2iI3PjEK6U34a9pfGC/45NQtan6lSJ+x7Z8QzMHtVklZ255XQjiWv0FVNCMjA1MdipsWoXxqKZuUskw4Nrkct1ecVqgcG7494QBnrM34fdeG7B2JRyoXnYTT2HyVGbUWgS/raiCCpG6xRLjLbr+95hUhBJmH2XdV7tm6i2sM4vOaPyWU05DsKe+eXOkPC+QzhNJZ8ZLksTxK5rYbbcaWrCoVD2Eb7e8XvV/a8pZRMeFTM2gzyrldRUBtR8OmN8BjEnM+N8EFzIDQ62vIHS3klMgVH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGxMN1Jhb0hyUlU2djZIekl0cU9FeW5sdTRtZlJjaWgvc0J1NFB4WGRjMTVq?=
 =?utf-8?B?TXpBWDlYY0lzUkVNYms5KzkxaENNcVdpeHNtYnNkbk44VjVmYmZtaTdFaEc5?=
 =?utf-8?B?dXgyY28yTEU1WlhsSVB3RzZmSlRnaURoYnBYc2ZqYXBZOHVYVTQxdEdiYmNn?=
 =?utf-8?B?aGVqbWRPNkU5Y2ZCWVEyeXN5ZHFvM0VoQjJhNFljVCtVYzVPOUJ0WG5kWmw1?=
 =?utf-8?B?VFRVbXFVbXp4Z0FsbGtwSkVlejJsM0p3ajRBTFg1a1kzSjR5RWU1M05maTJJ?=
 =?utf-8?B?aGVKQytOUjVlWVJsMFROZ01QUGkwbVg2dVJBdHBNazV0emdia1VzYW5YNnZQ?=
 =?utf-8?B?bTdFejlhV3ZxOVBtcFhRRlBLUU1Uckh5K3EyS0pPWXpFRzhDcEJMYUFaSE1u?=
 =?utf-8?B?bVgzNFdPWTN6bW1rczVhTmRGOUhNTlpmak9SWk1aTkpsL0NtSVdYSFRLakJF?=
 =?utf-8?B?UVZBOHVaYzFqUWZnaUpGQkVHUmQ2SFIrUVJKYUhEQXpVS2tsK3VSZ09VbTd6?=
 =?utf-8?B?VzZETEFGNjRhQ1UxMnBDZUZkMk1mWHExU2QrM3pQbEFyN05pbWpZL1g3cWJR?=
 =?utf-8?B?YTh1KzVkclZ5dURPZXVHT1IzK2FxbUM3TlVuZVE4aFRTRFJQOS83WkZzNFFu?=
 =?utf-8?B?T09wSnpxNVBEVHpnWUFXcEw3b0FTdjRSUGp0TWJNNkhMVlg5UVpoM3hmVEZp?=
 =?utf-8?B?RHlEMzFqUHdHcXRTMFRscFR3cmtaa1RhWTZnUWgyWVBpM1FXcUQ2RmtQSHdV?=
 =?utf-8?B?MFFiVTZIdm9HK1ZhVUR3Njg2VWNtUkNiWm5hUU9VRXRnVFZveGYwcU9jYVAw?=
 =?utf-8?B?bzdRZ3p2R1JvRXlPNitET1NCRGhQWVRoOEF4N2FSb1QxbnJ6YmpKNnZUUjE0?=
 =?utf-8?B?MU5kN1krSUF0MTZ5MXY4bWp1TDVXZElaQnVkeUhWeVczSVBPK01ab3JQUnRh?=
 =?utf-8?B?UTBQTlpZcHd0bWZJditBWFFYeTIzRW9JUTcvYm9OSGYzMnkyU3dCWmdRLzRB?=
 =?utf-8?B?OE9vVXBPWkgxaVg4Tk1TWFpPNmxxSU1yMXVvTC9hejA2Qm9qMjJDSVR3bW5n?=
 =?utf-8?B?Mjg2Ny83bU5uVTZ2c2dLSUUvU3BlaFhaWDlFVFQrZFdKTWIvVDFCNkNQdnp1?=
 =?utf-8?B?OEZSMFBSTVdFOTg0RkF2NnhZQlV4bDdkMzhhSTg5MGFxbnl2SDE5aHB2cUp4?=
 =?utf-8?B?ZEhVdFpLbDUzUnJWalpuaEpoNWNEMXNMNGRhd05aTTBrUjg5anNSL3VTUk1M?=
 =?utf-8?B?YVEwOXNkRE1TR0tvcDNlR0RRS2pBZ1l5bUtPbHhaUzlxQkhEeEFNQTAwMWFN?=
 =?utf-8?B?djJTbG5WbFRkeDBCMFh3YXdoNE5qT2c0eWdQRHdKOUV6QmxQRjQwY0hVaFBx?=
 =?utf-8?B?UWk5ME5MMnhXRHdWdWprOEZIdU9IUVQ5ZStRMVFNSlVTQVZlOVlxL3BUUzk5?=
 =?utf-8?B?Yi9FK1g4Q1g4RFd0QXlNcmZzN1lPNjFFcmEvLytIbjF6aE9jdWd2eTJGNVNN?=
 =?utf-8?B?TmFKOFIwV0FJNUtlVFUrcUhjOUJKb3ZkVGNDUXpoSmt5VU9SY3dVNFViWmVT?=
 =?utf-8?B?QnBrRTkwMDVZL0dSamZ3VmtTM2EvVnlheDZTSklucXpSVDBnbllqYlkzNXJw?=
 =?utf-8?B?WUlRejMzUGdIRlRzMDZhR1Eyb1BxTEF0dG85VjhIc29uUFJHdmtWOVo5ZWE5?=
 =?utf-8?B?RGlYM2lac2tMZ3ZWRGcweVZSU3IxQWIyZGhYK2l4bkE3ZW84alFUVFplak5U?=
 =?utf-8?B?SENkTE50Znk4ZlNyL2MzSGRNV09ycngvTVdUblE0MC9tS0ZNZXZFSG5vNVFO?=
 =?utf-8?B?eEZIYTB3ZU55aUtsTUw4T0dJRnI0Z1NHRzlkTjVGT21vSURnenlwcDhaZDJ3?=
 =?utf-8?B?SEptNkNDTy9FTjBwU3JWL2VxODZuaGdKelBIUHZEdUtPVHhKVmtOUHY4SzlM?=
 =?utf-8?B?SUVyS3RBZ29VT3lBaU1oMTcvUGpnT1NRNmlVV0NGVkJXOGZqRXdrWmVKQS9l?=
 =?utf-8?B?NENTNEtPZ3EvVlFsZmZQdGFIRm9OWG9GZmlZVU5ma3JnNHhhM2lJc1FzQUZJ?=
 =?utf-8?B?OURkVStXMHdhZzA2eFdQblhDd3Vxc3dwSDI2QTgxWEI4WUZNQ1NvcldSS0xi?=
 =?utf-8?B?NUdBMVJoWC9VNzljdTRIL2JhUnFPQXdvNy95ZUswMExGOXFyS2gwWmduL2th?=
 =?utf-8?B?SjY1MHVSckswdGxSbkk2TlBzSThSdGMzMnBaY2hJVjZTQWJCVDBpR05yMVhR?=
 =?utf-8?B?TzFJS213em5mUzRvRk9UT2M3K2JWL1Axb2h4dWd2d2hlZEFLQzBTeHNlK3c0?=
 =?utf-8?B?bGd2dkxQZll3andDcmZJVjYvaFVJTDRqSUEyZFFsbWVya0pYUWRFWGhOUlBZ?=
 =?utf-8?Q?RcjNCCJ3FR1Mr9rGc0kYIL1dox/Yt4LuzWz/g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb899bff-175b-43b8-bfb0-08df14045ecf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:08:31.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39a588/8cZHnKUHVTe69fZCJUSDPc0VwGQ7sqQBvTTp8Y+Lby0uDgvQb+ONk5zrasZh7lgNdvhz9NKbcOZ3gEogwaa9dZpAE9Xz5vjJZojYqcymV0phldGAXK/oRZK8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB921731

From: Peng Fan <peng.fan@nxp.com>

When arm_smmu_insert_master() encounters a SID already owned by a
different master, instead of failing with -ENODEV, increment the
canonical stream's ref_count and mark both masters as shared_sid.
A per-SID shared_link list tracks all co-sharing streams so that
ownership can be transferred when the canonical owner is removed.

When arm_smmu_remove_master() removes a master:
 - Owning master with ref_count > 1: transfer the XArray entry to
   the next sharer via list_first_entry + xa_store, and clear
   shared_sid on the successor when ref_count drops to 1.
 - Owning master with ref_count == 1: xa_erase (sole owner).
 - Non-owning sharer: list_del + ref_count--.  Clear shared_sid on
   the canonical owner when ref_count drops to 1.

New fields:
 - arm_smmu_stream: ref_count, ste_installed, shared_link (list_head)
 - arm_smmu_master: shared_sid (disables SVA, stall, IOPF)

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 88 +++++++++++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 23 ++++++++
 2 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 65e448a69a019..f53e1871426a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4095,6 +4095,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		INIT_LIST_HEAD(&new_stream->shared_link);
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
@@ -4118,31 +4119,46 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 		existing = xa_load(&smmu->streams, sid);
 		if (existing) {
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing->master->dev));
-			ret = -ENODEV;
-			break;
+			/*
+			 * Another master already owns this SID.  Bump the
+			 * refcount, mark both masters as sharing, and link
+			 * our stream so ownership can be transferred later.
+			 */
+			existing->ref_count++;
+			existing->master->shared_sid = true;
+			master->shared_sid = true;
+			list_add_tail(&new_stream->shared_link,
+				      &existing->shared_link);
+		} else {
+			new_stream->ref_count = 1;
+			new_stream->ste_installed = false;
+			ret = xa_err(xa_store(&smmu->streams, sid, new_stream,
+					      GFP_KERNEL));
+			if (ret)
+				break;
 		}
-
-		/*
-		 * xa_store() returns the old entry (void *) on success
-		 * or an ERR_PTR on allocation failure.  Use xa_err() to
-		 * convert to a standard errno.
-		 */
-		ret = xa_err(xa_store(&smmu->streams, sid, new_stream,
-				      GFP_KERNEL));
-		if (ret)
-			break;
 	}
 
 	if (ret) {
+		/* Undo any successful insertions / refcount bumps */
 		for (i--; i >= 0; i--) {
+			struct arm_smmu_stream *existing;
 			u32 sid = master->streams[i].id;
 
 			if (i > 0 && master->streams[i - 1].id == sid)
 				continue;
-			xa_erase(&smmu->streams, sid);
+
+			existing = xa_load(&smmu->streams, sid);
+			if (!existing)
+				continue;
+			if (existing->master == master) {
+				xa_erase(&smmu->streams, sid);
+			} else {
+				list_del_init(&master->streams[i].shared_link);
+				existing->ref_count--;
+				if (existing->ref_count == 1)
+					existing->master->shared_sid = false;
+			}
 		}
 		kfree(master->streams);
 		kfree(master->build_invs);
@@ -4163,11 +4179,49 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < master->num_streams; i++) {
 		u32 sid = master->streams[i].id;
+		struct arm_smmu_stream *stream;
 
 		/* Skip intra-master duplicate SIDs */
 		if (i > 0 && master->streams[i - 1].id == sid)
 			continue;
-		xa_erase(&smmu->streams, sid);
+
+		stream = xa_load(&smmu->streams, sid);
+		if (!stream)
+			continue;
+
+		if (stream->master == master) {
+			/*
+			 * This master owns the canonical XArray entry.
+			 * Erase when the last reference drops; otherwise
+			 * transfer ownership to the next sharer.
+			 */
+			stream->ref_count--;
+			if (stream->ref_count == 0) {
+				xa_erase(&smmu->streams, sid);
+			} else {
+				struct arm_smmu_stream *next;
+
+				next = list_first_entry(&stream->shared_link,
+						struct arm_smmu_stream,
+						shared_link);
+				list_del(&stream->shared_link);
+				next->ref_count = stream->ref_count;
+				next->ste_installed = stream->ste_installed;
+				xa_store(&smmu->streams, sid, next,
+					 GFP_KERNEL);
+				if (next->ref_count == 1)
+					next->master->shared_sid = false;
+			}
+		} else {
+			/*
+			 * Non-owning sharer: unlink from the shared list
+			 * and drop the refcount on the canonical entry.
+			 */
+			list_del_init(&master->streams[i].shared_link);
+			stream->ref_count--;
+			if (stream->ref_count == 1)
+				stream->master->shared_sid = false;
+		}
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 97dc97ac704d9..cf245b5de2bd2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -976,6 +976,24 @@ struct arm_smmu_device {
 struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
+	/*
+	 * ref_count > 1 means multiple masters share this SID.  Protected by
+	 * smmu->streams_mutex.
+	 */
+	unsigned int			ref_count;
+	/*
+	 * When ref_count > 1 the STE has already been written by the first
+	 * master; subsequent masters must skip the write.
+	 */
+	bool				ste_installed;
+	/*
+	 * Links all arm_smmu_stream objects that share the same SID across
+	 * different masters.  The canonical (XArray-stored) entry is the list
+	 * head; non-owning sharers are linked into it.  Used to transfer
+	 * XArray ownership when the current owner is removed.
+	 * Protected by smmu->streams_mutex.
+	 */
+	struct list_head		shared_link;
 };
 
 struct arm_smmu_vmaster {
@@ -1024,6 +1042,11 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	/*
+	 * True when at least one of this master's SIDs is shared with another
+	 * master.  SVA, stall and IOPF are disabled for such masters.
+	 */
+	bool				shared_sid;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };

-- 
2.34.1

