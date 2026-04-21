Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012056.outbound.protection.outlook.com [52.103.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B3299923
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765661; cv=fail; b=ZmmSWbi+cfDurAlDbTMQfB90VPTjfDqcVo+K4dDoEHORnojO9ntJ83mMhezhKVAcrN4+B3eujiykzJSyKhgo2HHuN72IRKFABhLCKmXOJcNVF0ipwGp0DYPdCxHF4JSUZIa+TOzqq8vmsG34+/I7ewX4VnYgO9o8t+tcDvV/zYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765661; c=relaxed/simple;
	bh=ax3T8MWiJbS62AByrh674GQq47iiHgz/gClw2pRdAgg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hDp1rkOdV4nAW0N6TwSgv2NwAaTjnWjjfDLU+12OcbnY3a8btHbFjFZXyWpSNWHGOI9kAxrJ3EUwil1axuOnbatevBkOJQIzHrEHdlfznbKWp3oxz0Vd/uxsIDuvD8ZVVT5QFzMR4aIRGqc+e+DkF6o3msymslihZvZtUb2sfrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=aoI6ru1O; arc=fail smtp.client-ip=52.103.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="aoI6ru1O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7vNqa+yGS4QHRAs2KYOaly70VOHKmtzKrFM1rik6vN90cjYvSKmVbEgxTYo+hC/HBgNh6MUxkMv8Avsj0G9bwNdIu7JfEo7wwczv7OiD4M6Kj7aSHimuzxPAg4nfWEq8p+RKJZmkjtPRjq5RLZNVUa28FMXs4W1kVI1m+vjNyNbzs7qcCec/Jamg1Xn6dv8OpoEyUCP0Oi0lKrSjp7vwyNEqx00q6AuR49aArEWTNtn2/U85zu2ORGxPambxd5ue9vkrMYpLQXrLYNv4q/3YbIZnFrw1q2UfjZyfoeWaO9wo4bqd5a2glB6AV7U0Lu4P7jeEuzD88f6o9K4OI/YVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2FBEFcjMrp9WeMjJufLJlgwgOwoYu6NaNyQL+ztBLQ=;
 b=Vzmxwl6e1URJFEKMdouSjDx69HlCNAp87l7p9j+CqJZqMowt6dX2wZaEwRBD+CCmd1+Mxq/PIi/f5iVFLn0SC9FJmogs7ZfJNgLPvaTyi7yvUS+M7P9My/mc0kTwWumaAViF6ex46hOc2lAnSBo/HYzSvteNUrb39Z8eIxga1636v232AlyDCJ1bpDoY2CHPu/M65h23o+6VgOr9WBhzuuVU/sTqCBggXu/8Qc6feNMzIvAS/G/uVl/HaXRjVNTQt9hsybyQ5HHd6bGW++Si7l87P4Pw1U8DXLRxyWZfJO8hWqV1zwo7zAgu2KyZJfYrMaTY2wfdNdInr4bfEmQRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2FBEFcjMrp9WeMjJufLJlgwgOwoYu6NaNyQL+ztBLQ=;
 b=aoI6ru1OyzJUEToXogAxrDrpzd2A8WJ1xWHMmhnFoLTvctHnUllEJLPzelnxWEZiBpGUHAWaZUZS1LqfmsHPTQcI63dTuCifb2xQMFJ4alFHrDu/E2QZZILstcWaAcQ/kPVZ8iFhH5JQiFct0XpWGfdjGES2OWrHZu+Fu6yag+G4S+yz1HpcKYon61MQswyq97nny1loIhBS/NiTrW0Cjk+rWKvGXuKvLVXzRBnbelUTmXZ0QkBYx0Oukd1YCummddGnRBpJ4j+1lhyEg8dOSyfNOcUL3fFQUCRI/22qoE1Atg3RDS7J5SiYBAB5FglWjN1av7aSUKaGovfEza5LTQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB5728.apcprd01.prod.exchangelabs.com
 (2603:1096:405:26::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 10:00:56 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 10:00:56 +0000
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
Date: Tue, 21 Apr 2026 18:00:38 +0800
Message-ID:
 <SI2PR01MB4393EF02E213EA4111DBEF74DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260421100038.222939-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d2c3bc-b31d-45a3-6b3a-08de9f8ce0d0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|19110799012|51005399006|15080799012|23021999003|37011999003|5072599009|5062599005|7042599007|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IvxCwOack4RuevDvlmc0S4SYoQQXUCfo3bA5VEsve2yzN03Gp4+fbMH80/V+?=
 =?us-ascii?Q?HM7/ekERAoScqi8vleJKR/TAaYVUEspkCfen3l8dbhcSreSsSKwjeWxQqNRT?=
 =?us-ascii?Q?ym5Xe/0XQtZJ96eEEUc6Yc5paOT9h8qMQ1uJIOe29I+kPpXmpkVAOyxLU39n?=
 =?us-ascii?Q?4F3xGR/kZuLn9AVBYVS8J/KTu819hMW/Vi7neKrW6zc6DTPDgPxKVP6pPkzJ?=
 =?us-ascii?Q?/J/ucLLF/4Ly9XcTWRdM0LHhuq4LFHUd+R+BgvNsOj/pYSRqTHTvgcwj1Ow8?=
 =?us-ascii?Q?rR8u5RY3MvcylvTboo94qFtX3AVhZ1nLH3GFPrio4+HATb+qZ/CJaOve/hbl?=
 =?us-ascii?Q?OF8s+jE0EbjnqiIR6VmMNomkKtlQR05STu20/+4VkfiE8GAi1SaSNcQACPiF?=
 =?us-ascii?Q?W6p0t47iN5cudbf/0n7la2RoDyxa/AAJDGXA4JeYEyBEdR4BhiyMZhHfxByx?=
 =?us-ascii?Q?O4JYnWIL7+NWgviBlvUfZeOoMATgLcrYcpxz/BPcFV1I7Tk8PW8/603Vqylh?=
 =?us-ascii?Q?VEQgdgx3nQI2zUlxEqpgKLUISAMBIRtloc3yYstU2MIzUOM1ndIVUTNW3+7D?=
 =?us-ascii?Q?RA07wbT/sx/xtIYaDrT25duzNO2Q9y5D0DEfQE0G2vNc1cnkiWaKBL2+jbdM?=
 =?us-ascii?Q?zuIwhIiAPpkwXztYnZa0NU+gRARVzQKXW+T9xz4dunuveRXUacRqqMr360YK?=
 =?us-ascii?Q?84p1nHZdvFuivtoBSnqcWuIiL8s7SxmapL4YGyeV4cNADgAGksDiJB9Ttnrx?=
 =?us-ascii?Q?zsnO7lgo2ngQYGdGNc0qmeff/iYP6R5KJWTKS5/akl4OJFI1ND8ByVfrsiqT?=
 =?us-ascii?Q?fNfhqq1h5+YIkIVEe89rWb+EEa33kA+luwVtR0gbzDx0vFoCquBq8bszEIw/?=
 =?us-ascii?Q?wKM0HQPSYfIX5SccIJQEYQEiMIfxlDL+fubTrPMxGVkk0kv2EW8hIRQoPnx/?=
 =?us-ascii?Q?tHwWJUEg91Nga1oebfEVg4P2lROpW4GDeY4FXfL9zveQMqAih9HzyNv2lX61?=
 =?us-ascii?Q?ZQ+aUAHqvE4yv7+/NoOO7T9Lzw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTxOgLYbZppr9ioxJyKbr5vgpGbYJMcv5L/vUqBeXbvGSEkOmNSUXrOxBZ9g?=
 =?us-ascii?Q?KJooxxvG4xF39wKeTd82tPhUEBq1kcks1GTP7ucMHh9cVBkt3YX2io0UXyYa?=
 =?us-ascii?Q?eoMKP1XUoVHj5vV4z3CJryxEKkj7iHGSRDwIgCINcqx9rGJNGsimLAY3rc72?=
 =?us-ascii?Q?j4EHXgwuTtHTkMyUt7K9qdUXGcn+FetxvpQyu0A/HyvgkvdAO4irLYw9E0V8?=
 =?us-ascii?Q?DJeXwAmKdQwI+QVPAZpkbQggYBRMF6P1Y/9oyRo50fwI2IEEiUGkv3fagVxP?=
 =?us-ascii?Q?DSbALRTBT5ATHa7TMEjgpPPTcEklcSmkYxeXgNJZ7B8Gvk8x5byOSpqcxjDg?=
 =?us-ascii?Q?swx91PooUqK+qC6/gQ+8nyKvD2KcyIME1vKd1AQHmS9kFmvBYJ421OceR4mL?=
 =?us-ascii?Q?hs6rFDA9H/cUhafaDWP1ckeQK8BKUnm9GcwahS8rm/uqzeOERDEN/dvVPr9a?=
 =?us-ascii?Q?vRRdvqt35SDp7nqmJkB+BnOZrYUIyuNyabLq3iNdarpAyLwd19nCe2O5pD+C?=
 =?us-ascii?Q?ecmzR3zcef2Y0axiPxXXKQYSUB1GaOJLnmggEq95sYm3sAZH3zp8/rTogVYv?=
 =?us-ascii?Q?Qd/TQ9R2xZq2w+83liBMzxKBEdlaYbEgaxbHs3/7Sc6QBoOunGa7UvVTWgoE?=
 =?us-ascii?Q?g4OHqu9MJkxYweZDLldHiJxfc1kimEn4Rf0c5e/fSjGycy/CButWcOxfy7Og?=
 =?us-ascii?Q?Yr5j+gswJQiranJChnZG23iR+Bl0+y59oLYOYi+gT/xfotFapSQljOUnfpXc?=
 =?us-ascii?Q?yESQoGwBC7Ll7HaXtE+ZEHJFnEfgCuVnmfwVYa26lUUrH4+CsmwaPl+ego3e?=
 =?us-ascii?Q?QUGalTZEQqKDKXTCDtDOxFX254RlFcyKO5R65OYWvWYqZiCVxCvvJGo4YaX/?=
 =?us-ascii?Q?nuW1yNy0Zs/I3Vba4gYb4AlqgyR9Pm6f5/LN0pcMlX3Gi29b3qn3K3x24hGm?=
 =?us-ascii?Q?wjZlELmYC2P8SJDEy4u+K4mj50ZiLh0z2GPcLYvTXSbmM2ZJRVcBiXcEQqAF?=
 =?us-ascii?Q?JOSwdT3JLTYZ56w7n6xGtMzxvhJ7vjkYUWZKUdyTTVXRjpZcbcJFYdjtal/1?=
 =?us-ascii?Q?KBlWR9oQSH4BKnu5ySq7ZsgieLjFuwXd8jXR1xw5v7BX2BLWSWuFn57h8Z6M?=
 =?us-ascii?Q?M1l7EmUyA3rZrYe/W0erA53AOsVocYAkGbT/EB/q+V9tVfBDvVFw4/fkBuPl?=
 =?us-ascii?Q?PYIUuXR7s6qvxvWYLVu3Oup+plPdcJbOADmLCYIpXARSS/UTHbr81lTTv7mG?=
 =?us-ascii?Q?CyNHrBDax/WGl3n1uehiVpT1hUVPrHcU8KOGYDU/SGyULmsi47Lt3f9veVtG?=
 =?us-ascii?Q?NwP/63xCMJN2lD8U3u+yf1mdz3WfbNHBwoGF5OyllpoKDU1UMqRvFsTfpIoh?=
 =?us-ascii?Q?Z4hBiKjZmVA9ZsfuA5bCjeKBn5Mx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d2c3bc-b31d-45a3-6b3a-08de9f8ce0d0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:00:55.8351
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

