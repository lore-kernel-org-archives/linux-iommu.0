Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013085.outbound.protection.outlook.com [52.103.74.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EB37FF60
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765478; cv=fail; b=Fx6J1/81zf+4kodr89vLgal3B8eRxF1lPgHTIw9ADj23BOq8vnlQoGFH+QUSZETHyk9yz8GHyCis5f5yKcAQInK1x0qzh8JWmS3PoTuzy5MocsSnD0LTnuI2zYDFnNI4DOptdvu2ha17b5uXuwW7I4yX0Y6vBmHEkCJdFLoDOSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765478; c=relaxed/simple;
	bh=ax3T8MWiJbS62AByrh674GQq47iiHgz/gClw2pRdAgg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e+/eFjOV1zHCvGX8MKFpFVPKc2H+smIaRAqViQLqmyTZ2Z2Fj8C03y61vlEcn7ygNgS2D16tGTBgRtrqYDtfXg0LIYXuqhvZaDDSDmkhF48SLkTQu1MzvhCHKxE9DYJTs8uIxfsNL8zXbQX5ZEApjJZr06hNM7kX+DS5SxL6j0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vSimp/LY; arc=fail smtp.client-ip=52.103.74.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vSimp/LY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sghYP/zPME9XGwK4AYid7a0mvF0lp8+hB3PyWJIaHkHsVUG/t9DYe7Lmv682EdcZP0aEoUy0K8vi5uuKstRB4gxdnKq1hHeokswQ3+ibF+SR534DgVOCMBTlbQ/Mt7zJyxOjJzX+NeKDiM3fjVE4kyQyTEatL2YEAelwNj/d+Emf6xmFZLnBqU9E/fToQPOU5TAWQNXhtXfcTGG05c/UqgV3ZQwkfeFhdCFOTv8smPA9r6hBauIPu0Jh//6FUuFTAUKoxtRxrHunyc+2tOEnAXDanyKWGeZS+piXojSwNNMFqTOpVW2iONCvJlYD/PNPlgatoPRBctwOEtyzYygzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2FBEFcjMrp9WeMjJufLJlgwgOwoYu6NaNyQL+ztBLQ=;
 b=X8Tn8nkvOXwSUunf6Zh7wLA23Y5yWUhPTG0tAtuWAkHIHOHZTmXw8FGVYVNypAq6U8EaAhO2mpb54AIkFk/larSkDQLF7ULyn/7ZRFc4sDa12iUcZlFyn97u0+t9Avnlv4initWKZvvpHiodafffPuPBxoDt7n8SNRjgEKSzg3Zc5E+WA0LqbMsfK071zGtQwCEh2wLj4xq/XkiZDrTuhU+MR+mxPXzmr1SSwcCV5nDumbatn1PEuxaKax3f0vJkm1N5Dn8gESj6q6eCRx9d91DcqAWYs25kK8yNPiVFwRg/kB10wJNfyidURGvR767CLyAxoFZ8xDA9QgLoKJQZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2FBEFcjMrp9WeMjJufLJlgwgOwoYu6NaNyQL+ztBLQ=;
 b=vSimp/LYmzliUR3pHi/eOgfc4YxdMRc6f/Go/0T0eUG6Kq8iiMWxHqoGS/gpC8BNtO3h34N4DcWnrIUvmzS+76VWQARsCJ6a3p+EY882yamsVAFahXG9rOOSTiFfj8nU7ZNppmI9+3Hu/7M+yibiWi179LJ25+wCvBvhhsSjrbw1mJk1LsKddqDjFYDEIoeoHrNfNi+fx2SU1TtaTzbTiLem4ds6US82N12RQV5EnV+HYvFoFYKIkdadwLxr288q612dlpvanWKCJY1dLTIRCBHgriVsxIgeahPVpQf3ln/MVzay//sh5ReZ58RyInpoQHxQw4WVuehByImtq66xog==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB5728.apcprd01.prod.exchangelabs.com
 (2603:1096:405:26::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 09:57:51 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:57:51 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	jgg@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v1] iommu/amd: Remove unused IOMMU_IN/OUT_ADDR_BIT_SIZE macros
Date: Tue, 21 Apr 2026 17:57:32 +0800
Message-ID:
 <SI2PR01MB439351F56D464B8241EFC1B6DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0100.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::7) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260421095732.222252-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eda74d-bfe8-459c-217f-08de9f8c729f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|19110799012|51005399006|15080799012|23021999003|37011999003|5072599009|5062599005|7042599007|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rdXSSmjEqR6BidKI6CYaJjV0s4lVeEbnoQtlDynllTRcLpRrpLX5XQID2cuK?=
 =?us-ascii?Q?rMTtTi49ms1uHw+wF+mirlpQFAADeF8C+ywZCla/zYjEbKnKmpvROh3pLYVG?=
 =?us-ascii?Q?xE/tlBZJkd4JJjc15I+ZEwuRyu6iPcahCZtMsnIlUwlGTUtySFWaB158cYRD?=
 =?us-ascii?Q?QaHZ+mk1o5Rtx9GRVyiGZKOM7hAElVJUZWF7KGle+Opq5rjOHDC6c+7JuQRZ?=
 =?us-ascii?Q?+37K0dcuQXDhFK/OKt+IwtC2X4bZERLoXNREkeDEWSBi5R2AOJ7/qyT5EUH/?=
 =?us-ascii?Q?wSfwLiuUkjw5pK+0EpqxF2/oKjc8kDXEz/DweWKcj84gi5NRT6VfzotAf1wW?=
 =?us-ascii?Q?9zp95+mNn6Qg/uEWyC6gQLPH+GurB5NQuIIgdgeHgBiRzxzBQiRjwyPgphWx?=
 =?us-ascii?Q?2iouDS+ZBOE7a79jnQBhW54qPXXMk5OCM51oH75SinAgJlS+/pt+nGyjnJr8?=
 =?us-ascii?Q?Y6SmB9BGJMnKVIv88RaePb22xhE6gZXziJa4KZkoCw3sZ1E9H1ZPzn43EuTh?=
 =?us-ascii?Q?gN9DQH97/GBrBXmY/eaPWQpAhXhq3PXf/Ef6RVU34cl0rUmjlKyGXy/MySix?=
 =?us-ascii?Q?ZEOxmh7jKKqajG4ZqDj3lNmZyT1SYQh2ACxvMU/roCU0cK62GDfEOMlDweT0?=
 =?us-ascii?Q?twE44gbUOIecc1BaDMWKPcjVazfPALB7KrzD4g/Lo5Zd/dNzmI3Z63KOv1ua?=
 =?us-ascii?Q?9w921BEA0uyibxk3vfI8w92zBuHDjoOKg9GlNjLi3/TnodUoBvo28hIjEFsC?=
 =?us-ascii?Q?4aZwULuQUDqd4z61On+oevkh+CAOXjMCfDljKrX06HFPPE3Kziuub9Ri9d+e?=
 =?us-ascii?Q?YBXzTPzLiU+DdYqZpt7wz727AidCdjOLBdu7mhjS3cpahuA26isZJJ8kP9f9?=
 =?us-ascii?Q?y4tmJjRFmf8sBHWLxALlsBVKCz6MAE0YzUXsY5bTFNEP4GwDNMAjzAtmNVPM?=
 =?us-ascii?Q?+9v0FnPa8Fy71XtZoQ7FtAFW+WIknIl89+H5mwp58XjOoQf+kkK/Bn2MXlp4?=
 =?us-ascii?Q?QZPFTmQV0jc9AQbJ9TL74YQB3g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTfyEzrLMcQBS6gSCrgHSmZPCe+84aFgH7mMU9K2twClbp0WAF6o/H3+P/WO?=
 =?us-ascii?Q?TixRhqCkQuoLUs5X733YcrhRjLKXaou2JsdaSe+GwVoUc3tQyFmjY/ZCA6Xo?=
 =?us-ascii?Q?XacFQq+G8hYYkOS4ZQkPSQRPU08RNA8XE76HbpdM64cV51XArcLHHY2FN3WY?=
 =?us-ascii?Q?NqsHiFDMzoRRT+jWbFAKrmKnyPWBCZfr+KV2e6PdtFjOkvza7uEA+zXaxld5?=
 =?us-ascii?Q?VBOqc6TKanTNm3eLd5JN2dHjgzX9Mz2TNXM/Xs8kVPigVbvOVKWgtivgKYc+?=
 =?us-ascii?Q?bv2ddHVBeKdaT97HGZNVEIYhMrzN6RRWMAcQn/W7ADsQmZzOt9G/y2oQBmDl?=
 =?us-ascii?Q?xB6wHbCpbGlwiv7zd8sQSKndaIdc2L3ZdU8HklpKJMtgLQ4KafklY5e3q6NH?=
 =?us-ascii?Q?vKDC40PVrQLScAj3mYhl5alqLfoZgU3KNAVK2loLz9AmHW72pstpGswIH1IH?=
 =?us-ascii?Q?hlY0oWWWu5cOzMG3hlpjjq5yYRWV8mb3wtH7I1CggVdiyef+JZPHpQJuP3gd?=
 =?us-ascii?Q?MA6q2uU0MkcByn5pEamHd32t13TPU7eK5zdJZFAbmOmJi1Dn3nAMtutW7cv5?=
 =?us-ascii?Q?YLfpVe4cEeZK8UqGPvfL+wu+iebnjOtje91+9AoLXU29OEhU74Rehoq09A7Z?=
 =?us-ascii?Q?v3D9CAEUH6uRCySxSrdi5zvHvgzno/Yt9q4wyH0NRkXF8qm37+UpudOtei3G?=
 =?us-ascii?Q?PzjZEi40S4mmkaRGOpFBxMaQF0VvskzCKpOMzvGVhpNQ/r5W3ngOS4avfe22?=
 =?us-ascii?Q?+iQx2+dmB+auWsEvqtk+13HS3RYInfT7XMRxE89minKloyCieqKN/gpU0QVa?=
 =?us-ascii?Q?0YJsSeugOUAnwFHYmJDFzUwKGrotGTyeV53ud3JBJR1dS4kQmi4SMzYTxBxO?=
 =?us-ascii?Q?Jz/9XsIDqFOYTFf/wkliqOyn0UsSUcWVGWzt4H0ikfQ5OrNkea7GxIWgJDog?=
 =?us-ascii?Q?6q2pz54zf4C/0OMRfnelbmFxGgbd8tAxbXQX0l6ATG4ZGIqfg9oz85s765ce?=
 =?us-ascii?Q?RAv5N4uEF/0Vxhdf1dfIqs18ILv7NbOwK4psSm7nYnGC6JkunOf7jKYG6vBW?=
 =?us-ascii?Q?2zvRDkzFemeS0lNYPn74JwUuEECyBYyplN5U9YweMkfhGpDDnmV1yukK1an/?=
 =?us-ascii?Q?qNBoODwAIfxeI6CxxaPGarU52kmTpqQR/vCV3F+oxB59/JNwbCYTU5e+aMzq?=
 =?us-ascii?Q?TkZLsqm1NMgO4KJ4qgNqpCsbk4BYYcvGgY4W1zeCab1PkC564hMS0zj+GTK6?=
 =?us-ascii?Q?TJpiBM1NRXmD0oeGr1PLO6Rb9N7RuVhQ3Bo2tuoQHOsuqyY6tvMTS22cP+AH?=
 =?us-ascii?Q?6c/z4GG5W/qC1F+P5RluMyK6pAFWaw1ivZk3RCWoBgJT67pOvJaypbAbG2XV?=
 =?us-ascii?Q?YCMv22GCCVeAQeHyAfyX72VQNTr6?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eda74d-bfe8-459c-217f-08de9f8c729f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:57:50.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5728

The macros IOMMU_IN/OUT_ADDR_BIT_SIZE became unused after commit
2fdf6db436e3 ("iommu/amd: Remove AMD io_pgtable support"), which removed
the last references in io_pgtable.c and io_pgtable_v2.c. Remove them to
clean up unused definitions.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771436..19d73963acbf 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -300,9 +300,6 @@
 
 #define GA_GUEST_NR		0x1
 
-#define IOMMU_IN_ADDR_BIT_SIZE  52
-#define IOMMU_OUT_ADDR_BIT_SIZE 52
-
 /*
  * This bitmap is used to advertise the page sizes our hardware support
  * to the IOMMU core, which will then use this information to split

base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
-- 
2.51.0

