Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012060.outbound.protection.outlook.com [52.103.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A145329C6D
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490030; cv=fail; b=IIgDkU2walEq4EzaOEIgs3rnGft9dG7nj0tAe/+gSYp5Z3mLiJwu65G8TjEsjCdGRNptZMOT5Lwb4Vv1A6k1x4VBwBGjClRs96V1TgeIJ2nxI9scB09cAFXlfacTmDe3quGC9OjeERq3FIprtVcoVV2L4nYckUqbx2siiJOvups=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490030; c=relaxed/simple;
	bh=e6oHfpCnHsae6ipeSosBwVToAX2AOKY0Jd+R7krpW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+VWkviXHKCcpWu/1Yju+RQbMcMlgekOl1y6JahXNDduW0LYrpH9HD/t9TsvSg6sT65OYtTlKrSeBp3+1Wmx5/J75wDKf3uT3VoK52ufA6oBG468AuS4A+wnUI02TtDmzhEhRHHjlHYYUwFmGZBWNmpyWCt4Afzyh/biaBdVsAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=flhRwLSr; arc=fail smtp.client-ip=52.103.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="flhRwLSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW4in7R1p7oXcgwAKuE17Xp8CqLeQfQSb8MQ1kl81ot+jNkU8YCUSMU6PgB5Facl/tYyfewzMJ92E30E5Al05lz0cl1t+8ljnEUDz0DLncxMoyqwDUlREvBPRF8rH+t3PLhrZUtlzeuLaf5quhELAYy1eVeDHtuwafew4vFxkKXGDYr87waaPfx8TgUIfLRUA2y+lcXd8hUHFC5/Sj9BSXtt8CPesA+qg4rw7d40PVAbfUG+K8zQc6CqnToJWZnkn8dh65kxoolQb1ajBhI1iDoaPo5BQx4Hu6QGIVUXOfR1pR0fnSPtQkmM/VkA/0ze056Ga1dC4kdVrftYI2hNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA7TpUB+/87XCDYpEZvJTxqh37IEBu7vpBvieZ80EvU=;
 b=gIzX/55oLGcHt0fvH8OFCTANMIK5JJg9nOJkKb+F6QhRjgXkqIPOwONOjP5czQ6jDMsDNLYFQD2t1R9H2PEUf4/dzt1PCmSDN/IlWim1bX993vwOXE4E95Xmqnig7fQ6ayRuBV4ooocGSAFdlmn2jb9S8cVR5v4FQcGz8hHvfz4zbfFNUfGOczcCKYcE5euBXAU5DOnKa5z50TWW/02+e8zNhdt5k6AhgXXguiyJoBz+meZvcnRS7o3Z8g+HlZT0JhSlx7Ov8aOy+6bxHqn0c5MO1Az1/YqnCNcfnw4s62fkMhfA7KjeTE+cKe44oA2qCoEeiLDXTcUQisMCh5Dh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA7TpUB+/87XCDYpEZvJTxqh37IEBu7vpBvieZ80EvU=;
 b=flhRwLSrsg5gvgqXlN8vUJGpNtW6hkyfJ2dGxdQTqYrJvuuHCzluEwA0tWGgZ+r3Go+oZCGxKWvQ0G8KvnsxVNqLLwd4D0yWhvssIW5GukSit0yYVFftoJ4sCpFWlvqSa+1+LR108zQ+avhRNTjuagWLFPLDh1oF7vNBkjxgGv31nawxgstGXz4C8+A/2FSWp1m0cMH6pv8LuVnIdVwO4UDulJqlEoQG3/hPbZ6KdQlBMC+0cBlgLGhZA/yjgDpSJVfc673KElOgYxPSOBGQ7Pdgy/V0NbxRcnO2aB9fieEYZoRPUgU6pe89SYgCEVows0YvPVVXuY7iDOosY7Ov7w==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5150.apcprd01.prod.exchangelabs.com
 (2603:1096:101:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Mon, 6 Apr
 2026 15:40:25 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 15:40:25 +0000
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
Subject: [PATCH v1 1/3] iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
Date: Mon,  6 Apr 2026 23:40:07 +0800
Message-ID:
 <SI2PR01MB4393E6509A349AD67BD79BF7DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260406154009.580106-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a87a8e5-d6d8-49cf-1294-08de93f2d1f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|8060799015|23021999003|461199028|5072599009|15080799012|51005399006|19110799012|7042599007|37011999003|440099028|3412199025|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FI0YScnUv2UkRd5JcCmu4L4y9co429ZODrG+8Vk+biHSAtWa7Et6L3hec8fg?=
 =?us-ascii?Q?L/vklTBUQm/0/bUAGzHFaVR4Keo9Zx+36FXzz8S1HYEvdmNXR6dqvrX7ZDu/?=
 =?us-ascii?Q?uhT5vLD31MLDVqD5wm7w4nT6SrYP/LTYz/3no2IJ8AmPmfEB65VF9IZB1TsT?=
 =?us-ascii?Q?8Qgg048Y3whVirwIyGjGWKX7epe5Tsxfh3yH7+5Zc35DTIT4lGmDGNnvxoa3?=
 =?us-ascii?Q?WA5Vbs1Wvk8+NaIeAJjqzZfDVB5RTQZOIOUm4hKeUHxQXZr0TouEOxezpY0b?=
 =?us-ascii?Q?sV9wRnhaiHsjEK9K8mpPabiYEtMydmtUeYkbIOz/Q4QSPeDTNJ/6i7yRAIgQ?=
 =?us-ascii?Q?dMsA2L2LSKAZodLqv4qOQq7QBJzVnPbtuMtORoBMtWK9mjW7agq6+B0Qwxy5?=
 =?us-ascii?Q?5GOyDmvhcLE9qg3F2vLpT2nltFgZhZqmFR+c9KozTbMSnoV49G8WowgZCAgz?=
 =?us-ascii?Q?ucc/WsmTPk61SpU9zgZinDD/hQwVX0lHWf8jQL3RcpdLHUb0sCGJr+n5o5x3?=
 =?us-ascii?Q?SK8DfaZvu/ISEKjrsWmz0SHZc6q1Y7Sj2Znl0R/z74SyZtI3nTcg/ZV5VjyD?=
 =?us-ascii?Q?yxSVckHEWdAwKuk7IqVJ7lblHGlV4aMVqJrOD3PzrQZjVyXBZg0tHrkA4O24?=
 =?us-ascii?Q?ZE8a+qTPvOAkr7Us6NhWvgvvMcNG9OGq+b1LXZT8sqiMb3RwhoWGEUVkshZa?=
 =?us-ascii?Q?We2+cqaLKH8LW5+AacfnuJBkQK5phK1V/OLdusfPdbYFik0WUgePYXQuXnSh?=
 =?us-ascii?Q?NBENJrlhByBYzHAxz016awSvtxi4dfdIC9mUqXj/gbakuxTTuwM62a1i6trL?=
 =?us-ascii?Q?21u5XGNSMJdS/JbNjwb5d+w4stuozZkW/q6acY8Vu9/fJ3xW8nD1f+Sb8nJT?=
 =?us-ascii?Q?fm0A444pThjlsKZ3GzquClXOM41f2ysn+XQlNMTWrmiyz1ozow1n2JWiLrTR?=
 =?us-ascii?Q?P1aAueJ5EReb9RYl0L1QVFDzSqCRVaWf5SgCPcni1jQcYViwmcHJXOjOnz1H?=
 =?us-ascii?Q?zcNchSEb3PEN1sSA6eznR06wA+1pIhpzqvEpoAnMsZQZA+y6I0GjZL7JI+rN?=
 =?us-ascii?Q?I5BiNO0m?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdwWPF0qeFndTWn0HdluVP5NC8fNsoSMdzUfu2cHABUVooNP6FNcDdaJTXC2?=
 =?us-ascii?Q?4LCLCGqCHbDlVMJUvbDHxlnkKuNq6H8EU6wbwTBaFzNnxtEcXL7UQqKhczOe?=
 =?us-ascii?Q?6jMdINjyqavQ5sZC52GSa7xKmNaQ76CgjM/AxiLJoXhmpF2VFveyZwQyqodJ?=
 =?us-ascii?Q?/HLmZyNp4W8WU+b1YnJb55bFOnUOtxHBZQU4XO3oKLwncy9o/zY3M0k1eTTR?=
 =?us-ascii?Q?79K0u+lqZDEIDrRG+dOT/NsBN8HkGxHLAUhWsRGIDCZPUgw18rg0zxWxuL+1?=
 =?us-ascii?Q?2Imnt9uRsVP481Wxnt26oJrOhO3ANjXNP0TJ2LY/matOQuYJKdF8j3yocMQ5?=
 =?us-ascii?Q?4wJdrgsumTEbjRPwNN0PZQFsKCAn/6ggfYDgaoNy9VyxN3GFr1Xs6ROr04Ws?=
 =?us-ascii?Q?ueFO+RJjUbBJ5laxeOkhVeQblkUWVWM6lhlm2GAkPehexxE7YiAUHFF4Tjtx?=
 =?us-ascii?Q?INXRn3+YxNLPAuBeF+08QrQEwhyrqiOo7tsVxwr3wmY0aXl2pEdtB9C/VR5j?=
 =?us-ascii?Q?ROUcqMgXDoPGxc9c2khnbCrGbTAdPS0wLJEGuYdPDtwPzZJKVoI3pd9WPGfz?=
 =?us-ascii?Q?/N014w+87BuwWlT27dasRb9W1zoyIGJkS6nC/e/2/ME/G8sboSkagxoYVFn4?=
 =?us-ascii?Q?xn5aWl2WO2lgjnDLgttnUCp/j0hr0jkpsDJNv2+igiMqgT0lbYGK0mbheri4?=
 =?us-ascii?Q?U07t+ae1A072CrX2u1D8ADnzgm8NkcbvPpmMItLE4kbWOxUwRgdnZHpMDVtL?=
 =?us-ascii?Q?6dkgmmLDRSZxIQlX2MYA1h8Dr08DEUmYWA99zyOUQ0RR5s254m78aHI/geMc?=
 =?us-ascii?Q?91amREd+1Lqy+vJo11wZTGsgIbpqa8AZKX1JrUKbNN/lXoCxWMQmqaLezdxw?=
 =?us-ascii?Q?G8r/qJuY5wjiJTNlC9Ju1XKm6SFBqq291vrsjRMPmi9iqpy1eZSzVarZ5kOa?=
 =?us-ascii?Q?N/LEMxaVToe6B5hJnR3dYZBY96PbKwhVo80XkXSoGHng/3aokLklYD3rmvAV?=
 =?us-ascii?Q?Rfo/Z3WhSLRRwxfy5q/Dao+/9IeUZfMUTE8vWMqLQFXrjv+hyL695xioFNOe?=
 =?us-ascii?Q?ugFLB8/zj1Lps3HA/dVJHj6Aki4NapvIGqNP6sMn9n5EMr2AG1zITkzqxhkh?=
 =?us-ascii?Q?aIdEfHDv8arCjkUxUkTDoJi10ahclbB5mMef/eAWj1+JGr/LOYN7gClgQ6OC?=
 =?us-ascii?Q?mTMhzJoGN211eMMryigG5DF83ucML4hsxSZGaPX/xtOdYgXmDmKPWg47i77H?=
 =?us-ascii?Q?xW7xhENvSmzfvxcDeZR/rcfcc/fprR0mx2Z1vRi4eJE47Wmra+7R5x7aZWL9?=
 =?us-ascii?Q?08GwlqoRd5UNBPEsC2ssaBdXFhmmJsWsfHYCdR0hW3kgBfagBUAwIFKbq2AM?=
 =?us-ascii?Q?qvscpvXajsAdpgAWbpofCsbACQBO?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87a8e5-d6d8-49cf-1294-08de93f2d1f2
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:40:25.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5150

The check_ioapic_information() function validates IOAPICs against the
IVRS table to safely disable Interrupt Remapping (IR) if the BIOS provides
a broken topology.

Currently, the validation loop contains a bug: If an unmapped secondary
IOAPIC is encountered, 'ret' is set to false. But if the Southbridge (SB)
IOAPIC is enumerated after it in the MADT, the loop overwrites 'ret' to
true.

This bypasses the validation failure and leaves IR enabled. When devices
attached to the unmapped secondary IOAPIC fire interrupts, the IOMMU drops
them due to the missing Requestor ID, leading to localized device hangs.

Fix this by initializing 'ret' to true and only toggling it to false
upon encountering a validation error, ensuring failures are never erased.

Fixes: c2ff5cf5294b ("iommu/amd: Work around wrong IOAPIC device-id in IVRS table")
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 56ad020df494..ae9f1bc85375 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3106,7 +3106,7 @@ static bool __init check_ioapic_information(void)
 	int idx;
 
 	has_sb_ioapic = false;
-	ret           = false;
+	ret           = true;
 
 	/*
 	 * If we have map overrides on the kernel command line the
@@ -3126,7 +3126,6 @@ static bool __init check_ioapic_information(void)
 			ret = false;
 		} else if (devid == IOAPIC_SB_DEVID) {
 			has_sb_ioapic = true;
-			ret           = true;
 		}
 	}
 
@@ -3140,6 +3139,7 @@ static bool __init check_ioapic_information(void)
 		 * device id for the IOAPIC in the system.
 		 */
 		pr_err("%s: No southbridge IOAPIC found\n", fw_bug);
+		ret = false;
 	}
 
 	if (!ret)
-- 
2.51.0

