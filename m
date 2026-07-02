Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29A4DD6F3
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003246; cv=fail; b=b1ceExr6W18kf12KEHufc871y7C8gqABKiQvTk0qVc7mkrhYfrjXhBLEG1izGUKOpuZLiALUBJsPk2w0e6uauszKHQdT/BzoojXG2mVVJqwGfnqUKPgpTk4Oq3RhA69jThdM0KVaBknZe2qxtK0E9gZoFVDzKiKNdl8Z82WJMJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003246; c=relaxed/simple;
	bh=WfNnKKvAI+Vv0n2riPtBZs2VpsvhIXCKuplLxj+1O8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXsVhoW6kwlmxoMV+5i2wfFQ2S+5p3dzOa2azyVcK03V8CzDiE+Qt7nFkqUC4v1off2jJXW63e0DicTOJ2H1+sTHoMiUaW8xnYhfKbH+0zREs+jTNrD4ysOfvyKnEpfNtfoqOUDWA7lItaDXK2eKav7bz/+ysMzGT4p+QnVgH+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=XIe6qgAo; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XIe6qgAo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc1Z+4dBQcdCIpRcktQUACz/HDFLXmteIg/rFx+BUKa4ijs/Z2BLLCC67P8AVnFMsC3fnVo+POzY4hhESI/zuqwqcuRsWzHIOJMbtui4QHHO9dokNhlUTReZHcIdpyoHZWVm1J9r7/tvZQrcxAXYyf2BYgKAO2prGNPxUtHNvbKxaEF3AMuokWMtRy3KnppDbU3CIhTxbgFsrt4FUc+qQbVTvBiTLEqWCVdNWplfZeH3ACtOZQ0PBEpXV7sKjk69sdPBIaLrUn9BwPEcxWlITHzebHScFxY7Hmyx05Aas3o/ssAGI251bue/BjC/jj6uxuf3Uw4sjxygWLG1CUMX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GowDM8UXj4/1QHpqmqZDDJ76ko2jiPqVQ0eCLer09bw=;
 b=rq82jXw6Kpe89W+DwMm/XuANmuXRUYg4vz1iIo9tdxk0ygwFUeBGE5hc9SQD/ANpvQ+lxjDg+iCsAfWtbgAo9XGbO19hLZDdc82aQp67zbt/mBIBYkCn3b3+e93pcQuzEf1/epmg7hQ0bM23nGT4BSzSYcr72ompqPHqLvBpiOIF6V7DtV3KefDVP41LYp3PDS6+JFCLJ1FsvhQsG3VLbaHtsmsJsFxhhczc27DEpi8eYVQkZql9jwf4Eer84BjpYruIHTv31OEP8qH/wT7mn/aZUyHeCZ7qMhpsIHTKDkQaqFbjh290bJWjPKrm7IzE0dS2uHEkd5KlqZru06LAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GowDM8UXj4/1QHpqmqZDDJ76ko2jiPqVQ0eCLer09bw=;
 b=XIe6qgAop5WhdiJUL5WfJFKJXj0kH3l6ffOi+TYiWcQ6rukT2QsDaQcz89lYkHNMOhSpBLSmZZoU/4C3ia6RZ6xENPZ+bPUlnod0uTGI/O561L7DI8vaE2hK24rfZbOcsYt7G9uEizYZIgVpmJCdPz0gMu73wdhqRqtVizufnlhAaLnjkvCueJck315kjjzCIBvOvzW/6xCdClpYpMxaSBY4mnLS4S/r+0LJyvpHuLifktxQbCB63XTxLT9+lBjJ20WuNUkR/MJUr2LI140Z6bR19zBeE6c93TxllkVX5t3W6bb8bQZNQ8vLvFZ7cqxcKdWdR0ai701C3tJ4L8KaLA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:40:39 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 14:40:38 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wei Wang <wei.w.wang@hotmail.com>
Subject: [PATCH v2 1/3] iommu/amd: Prevent SB IOAPIC from overriding IVRS validation errors
Date: Thu,  2 Jul 2026 22:40:18 +0800
Message-ID:
 <SI2PR01MB439319D963CCAC2AEC2E82E0DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::19) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260702144020.1296835-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY0PR0101MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f74176-1ace-4fa0-ae40-08ded847e1f7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|45011099003|15080799012|25010399006|7042599007|37011999003|23021999003|5072599009|19110799012|8060799015|12121999013|8022599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B43cCw1p8sWPKF4ufXGQXWf6E05W7uELljFkgfF9Ma6Gaah+Mc3iMjYZGe9V?=
 =?us-ascii?Q?wS7+Q2cOzD47BbWPHmkg/xCS93U7NsqLy20DQMwYcmD46Lto9U5keHaGO0V9?=
 =?us-ascii?Q?6fZoxYxlS4q6Yh9Qdqmz0picaB+76DgN8xAGsPcZbGd7Q8i/lbooetrtCIYX?=
 =?us-ascii?Q?uvISyR0iUNrk/P1rRfxP6OiIozc6Krs0BrvHNdfnXS547vkd2gHoUlnFZyWG?=
 =?us-ascii?Q?93Sd2j9XSnVss3sDujA5ATZf52ksPWFvAms77ezPFoGzux6drpjTp8YDSO/p?=
 =?us-ascii?Q?8C85ZpRe0mUtwJoDHKFTY2dqutAMEmVrJSN7a4nTWnPRXReccMl0vEAraGln?=
 =?us-ascii?Q?aJd6hV6bNM8j9fKA5ZXuZXYjFbd3ubR0jnR92Agm3KMJvD2Ilmj0VmF2QamN?=
 =?us-ascii?Q?P1nKLvYnesmbeL1YHW9i8R5NJQJ+QTGqXuKHd9dF6snIa0MxWpQYZNhaPO0P?=
 =?us-ascii?Q?lyBiwd+nUsMlWGT+Stzvp4W59UFPFvmY5iF5onbf4eXRd3RSbguT8p0j4l7a?=
 =?us-ascii?Q?IOTHKHAzfYBw2ZQ8z8SyLUcZN1SMztoDyVk05Jq1zHGDKqTpEXhDzhu15OoZ?=
 =?us-ascii?Q?ZQOFiJiyA7QDHiLviaClJRXW9l91GJNt92OqRHt7p3rOQIHmbWFEh7debaXw?=
 =?us-ascii?Q?CaJ5Dh7QsxgWBjHN72HNAAVa086B9DdhnFb1iCuUY6wmvQIoi1VZoQc4XCEm?=
 =?us-ascii?Q?UlB+cUSfqg+oFBNru2lPJjQpg+1es4dhSbaykzXUdp26LSUJScxJ1SmTCvBY?=
 =?us-ascii?Q?8aZy97s+ubb7/cUUCQOS88FeYKHL5YX+In52KDICigu60smnvFU5ZgIWZVEv?=
 =?us-ascii?Q?R0HwHMwVoh81ZuoSVzNs228sAO6K+FeOYv2LDhl8yajPPZpdBcO9tOJp/mbe?=
 =?us-ascii?Q?8usFLAli/ejpbM41yCLvmh8hdInYKm1+zsdY8kBUxAOMEOpIxx4PhyAAJp7f?=
 =?us-ascii?Q?erS327CnuSZGPSBGqj5ql7W7X1etc5aHF2SQr1fdOVxJxdZybT1MjrzNojB0?=
 =?us-ascii?Q?IHoxOrSXjZ8QwF4xZybuSswAIHEP74c6ohlJRaqykkN9dl8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QqWcGgzTY+NRnBeOG1Omqv/3w1+wDCe32GIwIiSDhXQXGr1TGS11CjKrCcEK?=
 =?us-ascii?Q?8+F2XeCjxnjlAuKJGenhVEOZDZUC/6ctJRqI4nlKc0hIVT4/aO94/67rF6W+?=
 =?us-ascii?Q?PAObaltuNDE/nWdyWTly64ZJUNogwVJXHOt3ExG0bIwRx6idRt1D131DfYLU?=
 =?us-ascii?Q?WQwT0bjpC92zHj/GxD4M8AZk5FIykb1CxNNaWbxaf7qGlc4QD2IaniXgwwvE?=
 =?us-ascii?Q?w/F9Uj+CGx5+5jSsAvNR6MKQouG6sRNYH14Ut1Whf3VOO01Yg2/kk9FfN9X0?=
 =?us-ascii?Q?cuSIu/v1gKuPEW9juLv23GrxC/M99k0A245p959m/BlahlIBZW698b0AtU5n?=
 =?us-ascii?Q?gOM76/QhGPvOp00J7GVwBp881YnXvMK7ScEnpDMZA9LJ6nz6eAGmsogUf/Pm?=
 =?us-ascii?Q?j8xK7ofjrerDqsaq9xgmU/8zCMgX95/52Dr0MXpqoAJB7mqXy+Bu9ZY11dNJ?=
 =?us-ascii?Q?v73sGBHz/fjmbH/xZ+QzRVCodG5YOFLWzxfwVsjUwt1e6TxEmb437aq+7ci/?=
 =?us-ascii?Q?oaELbQI4c2A92XJIErH5Wtm0E28kaP0hITQ10wrQ1XoJDa/juctOEEvZZF1G?=
 =?us-ascii?Q?R9h2ArqJX/llCq5X0f8CpsHGpv3qZq1pHDWjOW40uJ3Cy+e98QE5GWKuhnrG?=
 =?us-ascii?Q?jhKHGI/JoF2v6t4WRHyz7xyola8NrJlbTK8NAJwsO1QncO0LBEkz8OZarjek?=
 =?us-ascii?Q?SAOWyUuK8NdfXOZGFNjGZ0c3eH1JyzY1qAUoM/fBFl9X7iRctm+Xm+MikSl3?=
 =?us-ascii?Q?Qqky3cbvY/z5+js9NtUmi6udRP5aQRupK6RBkVpGrbn0kpPkshSDTbY0H7py?=
 =?us-ascii?Q?HVnTSABMnlw5AWepV+AsIDQwqaBK6g1J68KUJL5Mw7Vrq0MslQC1Sjdu8Or+?=
 =?us-ascii?Q?pSYTDTW/pmr1ShRIUCV/ehd/pmPgUFZ3znFfU8c1qin3QxjFgKPB+M9I3Mdb?=
 =?us-ascii?Q?LbiBRmD4F4oP1lfsDejiwxSB6ju3jVo6CJTqcETAdshF61CXEwoQ8Sll94QL?=
 =?us-ascii?Q?eFpKqysddfmiw2DgdQY5tquwLqT1T7/l5obX6aJof+rfVa7kNx8ULGVoCX9B?=
 =?us-ascii?Q?RnaZ8N9G163TySLCYNIkdqkNEhRo+pJfSkix8UuhwQurN/HLbhaIxqD0V2Bb?=
 =?us-ascii?Q?KvSwoQzEbkuICZxq8+ELs75G4nqHCW90mKNfZXeqjiH6XAO+9o3Vsu9Ke98B?=
 =?us-ascii?Q?tJMbWsr2Hw/swICCjjVvJqssLBSBPjbALabwwe7LjBQAzgh+QElxk8UlfW0X?=
 =?us-ascii?Q?ZsRCD4w8JUb10yVYciyCWVAT//RTMMCsht9PQxbLrAfsCDJor3jxs0QjmfoN?=
 =?us-ascii?Q?DAmWB7CyU28+SeEU9qSDIcV/H9olbPuT4XXUjAneExiQa2KgluVg+fZ+oEsz?=
 =?us-ascii?Q?1dOG7bPOPIN7JIa5aMJQijWoQ9Dz?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f74176-1ace-4fa0-ae40-08ded847e1f7
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:40:38.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4786

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
Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e93bcb5eef70..f983b1961847 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3098,7 +3098,7 @@ static bool __init check_ioapic_information(void)
 	int idx;
 
 	has_sb_ioapic = false;
-	ret           = false;
+	ret           = true;
 
 	/*
 	 * If we have map overrides on the kernel command line the
@@ -3123,7 +3123,6 @@ static bool __init check_ioapic_information(void)
 			    boot_cpu_data.x86_model <= 0xf &&
 			    devid == IOAPIC_SB_DEVID_FAM18H_M4H)) {
 			has_sb_ioapic = true;
-			ret           = true;
 		}
 	}
 
@@ -3137,6 +3136,7 @@ static bool __init check_ioapic_information(void)
 		 * device id for the IOAPIC in the system.
 		 */
 		pr_err("%s: No southbridge IOAPIC found\n", fw_bug);
+		ret = false;
 	}
 
 	if (!ret)
-- 
2.51.0

