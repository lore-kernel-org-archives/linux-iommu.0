Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012057.outbound.protection.outlook.com [52.103.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17086377EC5
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431589; cv=fail; b=TvGMWxkY3yS5ETg9k13VW5xi7ZgNa4qH1GWRm2eCB1hmpRopvvoCXP0QDCM5VV53V/uESgoVR8xKNGU8qVETr5RkncX4WO+LSMFscmlMmZ2SzIyLrNqCrlFEftvTux6WrSp80671HCHHdXtmB+sKR+1s7IFdSh69k0k7H6cY2RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431589; c=relaxed/simple;
	bh=9yybKzKFW/lQXN6VXiVDzheqqS50RBOtyUepB8zf3ls=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kCfjnI6d466WHmjcIpbC4Y0dSZeXbRPGayEx8AmbiSeCN6/0D/jDgDecdApbjJdbdXL7wM8ZCW5VqzTNIWKURm7pjRsJRfp1/xjBCDKqJcMYMwwQcKW81bOUA8rvfVk7QrPkkOBfMbywvqRkC9lq2nPnJKGBNTDhApN1mYpbQEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=WAWujCtj; arc=fail smtp.client-ip=52.103.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="WAWujCtj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5tqH2j0qE95rNf1W3LIsK9WtBiwmmTMT8YrV7fjXEzLVzRuBpxSYDobfGGCSw+Sw4eE0FqWKb+yVaRZNxWxs9yhmwkCLOtZIPAH4jyTjH1aN1cPFd5Ey+UHITlIyaQOF0AjzhlxWc2ZhGimWkrhQxLZu6FviSSgNKaFpI3dVVCsZx0Tikp/chf5Yn7QeRwpC9bPv+knCUsT9NntNDzgFf9MWpjzEUuHIJ8rfhvd2hipHaZM+4gIM3/+gK0wDgJN57VRQ9ntRD7Olyy2CeEAz/PRpBOKpCu4D/DAD7GWiakhtKeOOz3YOCk6fkHtt9PwvU3JE0DSZVJ/brr7AxB8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnEF3IeHtKrqh1PJTOLdyKgCsEkKC4Z2wdEuZSNmvIc=;
 b=XkX1X1AbmN4qM3rc2EHk/MjHNbIt5h9u+FmNfjLI28vYWqS2EIpWHwFrs1FUW0g3S4GrUAWdlZ29tdvxX5fG9M3Pn6X1CjNa/23yfD1aww1jqAQK5vO4jZAB9HtUhWQwy6/hDRY0MDDtayX7KX3L359H5EgRqu3ve5mKsgqZIOD03ygZmJpt6NDT3epWdvx/GKosJ+CuXfSpNc35dn0HDFe/+1swJj4dA8h5PFyhfIsZCKoCLNmKMFRu6nrpmPk4k6jCZy2RPFN6cT+5n1mg7QIdNpeQKoJxDOMiKKNH21UiIZZq5HZKDqn77t/y04ooyo6LKXdQ/QiekL5IJ6Ck9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnEF3IeHtKrqh1PJTOLdyKgCsEkKC4Z2wdEuZSNmvIc=;
 b=WAWujCtjZE2ctfn3CUMkj28mzBksiRrY53Y3KHI/kjt4XeDh7rnRbV1CoSBaBlSVlYIKLkSN4I4eZBIyOeZEdyRx5iQeGz1jF3hU/aqWB8FylpHUCUzhiE7NU2BcBR+gQvannK/tKPXf3HRYqjbq4bZeVTyxrDjLnI7XmzNXy16kHqHNK0FFZmJcmZrjXp1J8KBS+T+e/WAjHkomWz4/7tAYFisAp5RKqmiqaVWD23TcJO/gUrH5bxpMYskDZrkDyxb3jXcw19YrGJ4LIpRARHcxeZKUyGJxsgO1KObN85juAE0me1ssDubMc/Gbk/AqwI1HoVFH+gJd/l4qhruobA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by OSNPR01MB7722.apcprd01.prod.exchangelabs.com
 (2603:1096:604:31e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 25 Mar
 2026 09:39:42 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:39:42 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v1] iommu/amd: Recognize Hygon southbridge IOAPIC for interrupt remapping
Date: Wed, 25 Mar 2026 17:39:29 +0800
Message-ID:
 <SI2PR01MB43930F54C5B058A26D768C5FDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::8) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260325093929.33032-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|OSNPR01MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: b9080960-2f72-4860-d8e6-08de8a5270c3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|5072599009|5062599005|23021999003|51005399006|8060799015|19110799012|15080799012|7042599007|41001999006|461199028|37011999003|40105399003|3412199025|440099028|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HPk/5N12Ilg22NdKWVJMdDCbPCwyAhSRo9PbKX0Bn+yFCnS2oMCJwH3IM5sI?=
 =?us-ascii?Q?llI1h5Cgc9o3+FFgYpHb2yMMXPVNftB4AuWySoy2akL+C+icVpxIYUgcu9uD?=
 =?us-ascii?Q?sXQ2m3vqgn4SjFCX8M+tYX+6JwSVQyY4J96MF4Z9ehTqvE85hozNMx2rEqlv?=
 =?us-ascii?Q?1Pr3KPIVf6pgweS0EDC2CMSuuO1lLnj8Nqo+x+WRu8D7gGmJTZ3VlKzyYl0H?=
 =?us-ascii?Q?ZnuxQxH4NyL/ehBhfRinIc3KghO89367vpdtNcF0KQoZ1X1IDZbWhBMahiaC?=
 =?us-ascii?Q?YptkuG70xZb99We+0RrP1zsB9a+HUVoDKpTgHwSP5e9unEfwAt8mDGDb3yvH?=
 =?us-ascii?Q?uXoCWy75VAuG2rk0sQdHsxsEM3SEuo16HR5JG3vIe9IfpdeHPtTX2YhIVtYV?=
 =?us-ascii?Q?YDXESTF4guwmOrJSY/uhl4AWXFilmxIM5wSpATG1eFQX+mrexFJ2iNo1SQIx?=
 =?us-ascii?Q?Em8VfcDwtBVHxlvdiOgFeGZJcy+EOzADpJbzM9RkuDjpm9LZ7hD50l0mPuhw?=
 =?us-ascii?Q?U2oAIC6VBtv+W5+mIhOy975G7m8PBPCIubB02a3QrBCaeGYruSwnjABLSomK?=
 =?us-ascii?Q?zoCNYSaCeFs0nx3oLwzmIkUR7d9rck+/Zt+1WzdcYLc58IyQ/TwJf+JVPpmO?=
 =?us-ascii?Q?XnsyQWHWQ8jVQnsW65wT5dEnKWw54ZmVi9QZlcoY+1cDFgWVT9h9/q3vNIDw?=
 =?us-ascii?Q?3iBrASvcQ/RmRqG0deRjT7CI8qv4onLskmPaQr8AcyrrdZJYnex96Zzzysz/?=
 =?us-ascii?Q?rZiSEQRTWxjiDRrXwIe8exx3MfInhKuJOIH9wQxPsKNhxFAY3vzDzpy52pmX?=
 =?us-ascii?Q?9jL/SxLkM+UDWVevghMzgv6z+SNLbwc3Q+0xDkTe+kyUB3Ly2MoNeEZj7a1U?=
 =?us-ascii?Q?lqgo4jWdYf1G+fm2xygpkrqfK5eSd1G+SOMIf4UhaX4LkWdOvOw13fi/WkWN?=
 =?us-ascii?Q?bhzQnhY/48vEPB9r4FogFDV7A7d/CZAfnrnhKDg16YLDtOKBKgOg7blIyozf?=
 =?us-ascii?Q?7In4GMP62z1dIhW+ufzkj/MM41rSYH9P+Y4g0YbzztQtpDIuG2WcpJVW+QR4?=
 =?us-ascii?Q?nsosH7n8emk9/fZ+lhJd/+L3+r9ohdCIeBwplpGyM71AGtZXPYDcWyZfz/BH?=
 =?us-ascii?Q?5/CM3pE5L5mm?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbplgVzNxjofxBQgd8tpSrsDRhsBytWVrPVH+q8JqnqnB9G/e1iDyjHU+YRG?=
 =?us-ascii?Q?KxTlEg8aau1TR8vbCm9R7enirIW4EoyTdc7VCIxZ817PsSsuH7aOmTPYctq+?=
 =?us-ascii?Q?QZaTLoKPcTi4qDQyZ1/sGVOwedIAQylYJN+ORZ8PEIz4qqVnsvuwZSyh4ute?=
 =?us-ascii?Q?nVRNKUK9MHrszp4O7/yC85B7pMojrBFNp57BhStcH1MyZHjmBql+8sKCj9lJ?=
 =?us-ascii?Q?4IDZj3C79e9YQwX0rmPf5q43HAjrrARK5Jx0Jw/Otgoaw07KGxTOjCv7268Y?=
 =?us-ascii?Q?p3b5sNca58H+EolholaS7MV1LRj1NK1ZEJTZUPsxWq+BrB5HlKLHDodgcyne?=
 =?us-ascii?Q?nlNaLAVrk1uiYLIagrbdfAA3LwT0U+kLrDFgekhK5i4M1FauY4x91WVLAL6G?=
 =?us-ascii?Q?8Xj06XmB+TAVHLgHWJLqay+wVlfmaNCG/9uXjx8Z5pgMqm/JYItCtUrFEzMX?=
 =?us-ascii?Q?q6/vfQ055bDoagIgiuuEdMFtoVxqSDDIjJ23kW3Uu4OLWJb6biXUjwWQQHN3?=
 =?us-ascii?Q?3ltIsWwwJ1I3/3Vgb80aQNBxi2I4YXMFcWJU7lqnMsM+y2i/zdYCcIcwFqX+?=
 =?us-ascii?Q?SOnpsd1xwCx4YkjoGGUDoDHcVXKF6Te1t/tMP+6CJ4a3RvNHNoqS9mUVXzev?=
 =?us-ascii?Q?Db9CY60wW7kLRpVhMGPxx8Pu0Bk4/Q2ose/8SgNmjxbD3x7bWrRvKOkFQWO2?=
 =?us-ascii?Q?LAIVE5Y0GyOM4HynUYGqfXrqDNBIdvNYYu5W9tKXg3b3Px4KMUCW+RseMF6s?=
 =?us-ascii?Q?5ZiEK3OMgnTrh5s/oxOKG9GrSFUIvsqwvYo7gCEsl2pEtIV0XyLHtMhfYkvT?=
 =?us-ascii?Q?MZyro91u/Xfl0cjLjGxmytgucA9iGHVf/Dw63QRUmLL9nEMceuxesud2F29w?=
 =?us-ascii?Q?q3VAEQCd2z6vpwhpkrKJoJ8ftx538nnwmeJEkQywLsC+K8aW1CP2aSw/5y+o?=
 =?us-ascii?Q?9IW1Jj/Cjtiv/Is7kUL+VqoOrc3h3aE1paVBwpuQcSC3A0TGC5BysDuJYYIP?=
 =?us-ascii?Q?v1FxzGuTKYcx84cDTEveR2icu8+qnsL2Ss6/i6cIH7tL4qgWKNM3DxL48tLj?=
 =?us-ascii?Q?4HIy7mpK+oCYXYFPPEa+f/KRfUVHpiLqbzxUb9hpdhCLlIaWU3QTyIoW49Az?=
 =?us-ascii?Q?llI0cdhrToLWDqUV+dawjyIgjdq/5U0RNHaLdwlke8GB9YperYps0IFdDf10?=
 =?us-ascii?Q?85o6hbkw+R9ds624Mk7FVvxK/7Qx2Sg+IV9rGBe83eVdwFBxpS5uLeQFbiJw?=
 =?us-ascii?Q?odCJrcwN2F6nPEoxDJBVJeDPSZuq59riERdJrwWwODW91ZhiaxXZvEQmvf4w?=
 =?us-ascii?Q?4+reAilAsFlUJXBPcS27sRCaNFCw03F1aX1//t3Tw/kJRHAJNJYCpxQ/+uBt?=
 =?us-ascii?Q?GCWTKtzvz/iOE5ksE8P9GIOTHKx5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b9080960-2f72-4860-d8e6-08de8a5270c3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:39:42.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB7722

Hygon systems use the AMD IOMMU driver but newer Hygon platforms report
the southbridge IOAPIC at a different PCI device (00:0b.0), whereas AMD
systems use device 00:14.0.

check_ioapic_information() validates that the SB IOAPIC is present in
the IVRS table by comparing each reported IOAPIC devid against a single
hardcoded constant IOAPIC_SB_DEVID. On newer Hygon systems, this
comparison always fails, causing the function to report "BIOS bug: No
southbridge IOAPIC found" and return false, which causes the caller to
disable interrupt remapping entirely.

Fix this by splitting IOAPIC_SB_DEVID into two vendor-specific constants
and accepting either in the check. Older Hygon systems still use the
original AMD device ID (00:14.0) while newer systems use 00:0b.0, so a
strict CPU vendor check is insufficient. Since the devid values are
mutually exclusive and are read directly from the firmware IVRS table, the
OR condition safely handles both hardware generations and is a no-op on
platforms where the other value does not appear.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
---
 drivers/iommu/amd/init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 56ad020df494..1f545fe2f1e7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3096,8 +3096,9 @@ static void __init free_iommu_resources(void)
 	free_pci_segments();
 }
 
-/* SB IOAPIC is always on this device in AMD systems */
-#define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
+/* SB IOAPIC device IDs */
+#define IOAPIC_SB_DEVID_AMD	((0x00 << 8) | PCI_DEVFN(0x14, 0))
+#define IOAPIC_SB_DEVID_HYGON	((0x00 << 8) | PCI_DEVFN(0x0b, 0))
 
 static bool __init check_ioapic_information(void)
 {
@@ -3124,7 +3125,8 @@ static bool __init check_ioapic_information(void)
 			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
-		} else if (devid == IOAPIC_SB_DEVID) {
+		} else if (devid == IOAPIC_SB_DEVID_AMD ||
+			   devid == IOAPIC_SB_DEVID_HYGON) {
 			has_sb_ioapic = true;
 			ret           = true;
 		}

base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
-- 
2.51.0

