Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012060.outbound.protection.outlook.com [52.103.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41A32ED29
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490032; cv=fail; b=c9d9WzQTRmwDPpCc2DpgyV37LVbG+czvGn8QDA0Z2fvIrblhyg4HTMIepCqjKL20wxsbhtKj9Q0MUra0/gJuAerC5KZ+B22D88a0krhXG/0Uuyj+9JxzAA91aoMZTbEvqVaNNLFFTV7xD8EqZbGGQfebc1UX3FoRs8+A5wI8J4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490032; c=relaxed/simple;
	bh=N38GRKiAXny6gDqf5SjG5vH9sdsE+gFSfIELOS/HJBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBUDS2WNW8cqqf7Q1zSrDlT1yq4iUFnTnqT7RJbY3IqM239auUindRVNX8D2f2LyYoBAK7zA4/Ozcw8wWOSQ+Iv9iTnJkQDG+XW0kE2SkqSS/46YcJDz1r09QNlezadbg0o4Toe1vuu2jHuyiTa1M138HyuPPYiDWUWlsDBlb4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Oxb1ExiZ; arc=fail smtp.client-ip=52.103.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Oxb1ExiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBcY0TWX+09gjNRsGG1OQ129CyINsTItPcVLwsxjvfY3YyVnjvoDmxR0txEmE4FCt3T3XfB6OLwZH3HSS9SuW11pybYXjzBFaa8iy0GHGVWc2ZFLorHSq9Fuwz07v7WmtsIlqa/4/KrEpeI3B4HOuyIOBxo49wG/CLBwYO79xJVyyVefVf0NTrYHNKeK8CyVzfVkztk/pqOkZCx9ONZBeD2+o9ZqKe7lc2a4r8nbcadNcYRGZZ4nSsWrbclktZNI1pNKxHVWnZR1iv6oIbf0ltovEn4IfX01AJsCFSvfg1PQcrASQbYQ9ihWj48QcuQ2p/7aWO5V2QBAK3CL3dw/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA70qM7v6/DDt7gIcebMK2mWR3RAkFrNoN+p4CX0YkM=;
 b=Srk7B2PT/E4VkJzRfRNaCDCQkuofZABupJkvvZMy+IxnkWb3mc6/hwWuvDG6Beahe+210USEY+sfRex+6vOBv9E5MeHrK0resUHYvTEZZBq6mKlizhwUSH0oOsUcgC0Nebi/TE/Tp1H36ho8zkWepvxjp8FjmGrDHMBRmWDZpv50PFxBdUVHCPRdTvPml4IakAm0zEy52OJz0b+Q6v486609MtBjyxRluk+0u8rm/WSQ/LuR0elw8fRQFO9WGHljM/9tY5YlYo3/6lTQt3Um3EvIlMOUa6jmROJZf3vSNsrPyQNI+N14yKCc0vfEcia7sjEgC/nbEXsycLi9n7qcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA70qM7v6/DDt7gIcebMK2mWR3RAkFrNoN+p4CX0YkM=;
 b=Oxb1ExiZDp9BOAa9qAl+Z+mRH77w2JpjXnNoUyQGA+LwJVtLuhY7ZHSFuUn9Svio8UmMVQ+KzZIY0X2UogZ9/EQNEN2J6T3LYL9FciZi7lodRyTdBJbOxqrXRAuuAwwiLwwRpQ8R5fx3TwUKjvK9z6Nc8Uaaw7J9S9jeQhRDOhW+ybhkOtSgcLV1+rnx4j63+kfT67yzfl13pBg/CgIRAvSrbJoph+oCZKlgPRSFytTk9kEMf6Fhaiv0CXAzllWbZEiar5kS3EKuBgR8MQtK23A1KYS1Qa2/s+/5o6EDYanwrdHUxxZ3tYtDedwyOObeie1ax/gwHin/TCWINiJ3YQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5150.apcprd01.prod.exchangelabs.com
 (2603:1096:101:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Mon, 6 Apr
 2026 15:40:27 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 15:40:27 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v1 2/3] iommu/amd: Fix false positive in SB IOAPIC IVRS validation
Date: Mon,  6 Apr 2026 23:40:08 +0800
Message-ID:
 <SI2PR01MB43933B2373A4FB93FF5CD5D5DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260406154009.580106-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9469ec-5f55-45fc-57a2-08de93f2d34a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|8060799015|23021999003|41001999006|461199028|5072599009|15080799012|51005399006|19110799012|7042599007|37011999003|440099028|3412199025|12091999003|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T7sdxFj7R1OGRcg+SJaNiRNuhrsvluVEQNMCxs1kiFEsPoi4pVFbfmn42FSN?=
 =?us-ascii?Q?pdzaFPkl2/RAU2qfE3UzNALWPJFP9NlvWMDB+3D4vw4+xobwVR32EZkUFk9A?=
 =?us-ascii?Q?ws8uayz2/ZZjpXJm1mJYpuA+WGJiPeByk+i1PWG6Fsue/I5ToAjDKK3ntv26?=
 =?us-ascii?Q?EkolJ3RTZfJTcUpN9PzpjIz+3yaFZSFutHULFu46Jm44OZEmwg5xGVv5et1O?=
 =?us-ascii?Q?p2/sKWOn5/GDLqBbbGy8Q0NyYMHvrXBMpaKViiQYL9Mv+WoC2/avoNr1yfaO?=
 =?us-ascii?Q?qs2O2qEGFKZEs76bplRgbD+C0/37XuzIKFvXUKTH1dLNXnglFe0B3bRCLc+O?=
 =?us-ascii?Q?tGA8BAH3bgMAZyMj2NGWdPUoV78C4EEcmZVJEP0XMEDIRtt0IA1YiOa+ez5f?=
 =?us-ascii?Q?4Ufw0lrnLACOliF/njDT+Q4eb4Uc1NvjudJkc/ioWY+a/FImjzoS6k5ayke/?=
 =?us-ascii?Q?ouqinHJDltr7oCRWq4xmofc1FBiZs+aOztIS6WdtGg9onkLuZPgCzv4leGBv?=
 =?us-ascii?Q?wZLXYS5KY92eFBK7JIh5irjioEfe4MSvuC8jrJmy+4BzNqE2Ze+/8+4qG2OF?=
 =?us-ascii?Q?ACFM3GlEw53Wa0knKHfsEBIw55fv1ub+shHL7jYNXLVV6W5XZtLa7eiysp1t?=
 =?us-ascii?Q?ZqLDpbCsFQSIcfRce+DSDxh+U/deF0wzccQoQtRoEP8ffE4zRLWhG3TEQ2wh?=
 =?us-ascii?Q?oDwIkBhdj5LvH1ihvjeqAHSnjkJ+EOtRaDohhYP9rnY/HWTe+FNqdJJh8kjh?=
 =?us-ascii?Q?3HgZx9t9jN1fbXHTZCzymv6mNalXMQU5+h5Lgq1oUqMjfSRk0OV2gXezIrz/?=
 =?us-ascii?Q?nS6N0voxrqd+4UoWM2g5gSncXqYzNYJ5UMUZ+d9h9mcYZdkTzT0RolML9Zay?=
 =?us-ascii?Q?3UyekeommaTK+A6W5J22C/gS2xy1aZosjMOr4Jb5thSLa1uzoFrlHrleQMrK?=
 =?us-ascii?Q?5Yd4fKxKWSKoRWN7dsXQh1XcLuOULDIs6Ol2yuZOXzbziZ6e/G+IxeG3sSKd?=
 =?us-ascii?Q?B3TeAPd7f5rVWlkqOxxl298tO+J/mv6//O45aIgQ1JaWJbO2imYyHvMd3PZL?=
 =?us-ascii?Q?mxYcHCUvbpfmUQiUqBc0F4fma6TVL4ONPUxAL+AFhGCu8zLUKJgrvDVjGZVH?=
 =?us-ascii?Q?XtmKB7hIwkVO?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOqzkRjzrSWeA7ggaX5SmPSfYlQRCKA9Xaf06mKaM4AngN10cUq2m/ntfrMZ?=
 =?us-ascii?Q?HE/jI94wxCOV118FkYZyPWoPu465/vK3ZYK5i80lqDS0feqfoNHIkNVk+SXs?=
 =?us-ascii?Q?VoPezMuJVBEnH8ubSBulB1qVMjtuE5ZUtzO3SfVP6iLlEca61A/49pECTCZI?=
 =?us-ascii?Q?mfMjjBHi14Hx7EmGdB/lzcNNBJPlzAay+Wq43Blf6NJqCt9vvkqQh3aqgZQa?=
 =?us-ascii?Q?fW++HZwgkbFqINiHrw32KlQfZYz5hm/kiQIBpOHToxBcgVRLCYdi6UCXdZva?=
 =?us-ascii?Q?sxbnGbBKnX46x4vWEIK9gz1ZXpoOi6LAr4TP2/ucFMXGzr67S5o3o7BPScHB?=
 =?us-ascii?Q?oJ34W6IY8mEGsd9pvyGn2wbiMkw9w2SVL7vFIl+QSReC7jfmqyn/14B9jtgX?=
 =?us-ascii?Q?J/Q7mn4a2UWGMgBdhKnDoltmHtOXb8UEqhlA5Pfi3ywjHD5G+BVH+oSCKHUk?=
 =?us-ascii?Q?9J/NR0Ygi1fE5e9FyoGnywkgiAOehpxh978Qa+KNB/AmhjJSD5srHmeMQxIE?=
 =?us-ascii?Q?3VPqN+H0lrHx0KgxZdM3+x/gpkRRpb3spfivKSHIO85gxaPiYGuIukuO3T4u?=
 =?us-ascii?Q?VQqcKdytuWMGeQC0fXqU9CgJ/HPMt002GhHHqU8ppnONTQ42Rxd3NP7blzUK?=
 =?us-ascii?Q?+L/pTy0ougGBLr7YxquWlxgtyh47b1pmtUEDwElSVTFGUrlmLLaQdGydTWJr?=
 =?us-ascii?Q?uRVaKPCEOguzuCdVAqJWkez8x2Rvv4WgyFRaGCOcaLqansl8LIME/WPqnar4?=
 =?us-ascii?Q?SBaVc/lcKybHSNM9YI0Xa/cUYJkwMO0PPGKkorO6CcgHF5I3Flij1bdZJBj0?=
 =?us-ascii?Q?Kg9SSwVjvBro9JaqtJLXovCwgkat2Z6CSrA+F3EVJIfAIuDAKDS4qKiDGyrL?=
 =?us-ascii?Q?fv+y3WBPnDhOKewsOQJB99rkRi2YkJSnZn89wKNTPyeYKdtmjofnt6wFJOpY?=
 =?us-ascii?Q?nGxTcGy9E83T0RISG/pAc4+eplhizE0Yv1FoEspNQkHEoC0bXxtnWqCpoX7e?=
 =?us-ascii?Q?ZyW+LJlSMw+Fm1u/pMoRCm5WkvPvnMbzNyCmVWsvMhTTNGFFWdUOyTECfJR9?=
 =?us-ascii?Q?MveF6UorDhhsB8ODC2LPCGJTspl4sFIuP3HimlKkovP8FE7x6XwgB3Ia34+S?=
 =?us-ascii?Q?Ahclq2rWT+6x+MBCprzPd30Nj1zHznmk6Ap/3RlPiDbeTkO7iQb1ClVl3oCA?=
 =?us-ascii?Q?K+FKMkzOQ5LSNl8PS/ctHmEX4XWpPDk22+4qlM/fJLvs4j7CFYwTFrtZt/5w?=
 =?us-ascii?Q?vNaANF4MG4gL/gqcf0e0ebCakWaj5/IPbobju/xJMI3sa8BT3TEbE1Uxnkgb?=
 =?us-ascii?Q?t18A10JCvU85JjWtqkKUixy/rCrvXFGT42tR+Tk1LjMhd1TkrRN62FL9fLKx?=
 =?us-ascii?Q?4pPmoi7dkz8c956lFP/5xNb0h/WY?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9469ec-5f55-45fc-57a2-08de93f2d34a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:40:27.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5150

The check_ioapic_information() function is designed to prevent boot hangs
by ensuring the Southbridge (SB) IOAPIC is properly mapped in the IVRS
table before enabling Interrupt Remapping.

Currently, this check passes if *any* enumerated IOAPIC matches the
expected SB IOAPIC device ID. If a buggy BIOS assigns IOAPIC_SB_DEVID
(00:14.0) to a non-SB IOAPIC entry in the IVRS, while the actual SB IOAPIC
(APIC ID that owns GSI 0) gets a different or wrong devid, the check hits
a false positive and succeeds.

This erroneously enables Interrupt Remapping. Consequently, the IOMMU
blocks unmapped interrupts from the actual SB IOAPIC, dropping the system
timer and leading to a silent kernel boot hang.

Tighten the validation to verify the device ID specifically against the SB
IOAPIC by matching their APIC IDs first. This prevents the validation
check from being bypassed via device ID aliasing.

Fixes: c2ff5cf5294b ("iommu/amd: Work around wrong IOAPIC device-id in IVRS table")
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/iommu/amd/init.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ae9f1bc85375..8981117417d6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3099,11 +3099,25 @@ static void __init free_iommu_resources(void)
 /* SB IOAPIC is always on this device in AMD systems */
 #define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
 
+/*
+ * The Southbridge IOAPIC is assigned a GSI Base of 0 (handling interrupts
+ * 0 through 23).
+ */
+static int __init get_sb_ioapic_id(void)
+{
+	int idx = mp_find_ioapic(0);
+
+	if (idx < 0)
+		return -ENODEV;
+
+	return mpc_ioapic_id(idx);
+}
+
 static bool __init check_ioapic_information(void)
 {
 	const char *fw_bug = FW_BUG;
 	bool ret, has_sb_ioapic;
-	int idx;
+	int idx, sb_apicid;
 
 	has_sb_ioapic = false;
 	ret           = true;
@@ -3116,6 +3130,16 @@ static bool __init check_ioapic_information(void)
 	if (cmdline_maps)
 		fw_bug = "";
 
+	sb_apicid = get_sb_ioapic_id();
+	if (sb_apicid < 0) {
+		/*
+		 * Lack of SB IOAPIC registration is not a firmware bug,
+		 * e.g. kernel booted with noapic or noacpi.
+		 */
+		fw_bug = "";
+		goto out;
+	}
+
 	for (idx = 0; idx < nr_ioapics; idx++) {
 		int devid, id = mpc_ioapic_id(idx);
 
@@ -3124,11 +3148,11 @@ static bool __init check_ioapic_information(void)
 			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
-		} else if (devid == IOAPIC_SB_DEVID) {
+		} else if (id == sb_apicid && devid == IOAPIC_SB_DEVID) {
 			has_sb_ioapic = true;
 		}
 	}
-
+out:
 	if (!has_sb_ioapic) {
 		/*
 		 * We expect the SB IOAPIC to be listed in the IVRS
-- 
2.51.0

