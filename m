Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC31CB507
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400198; cv=fail; b=dLmM6Sea9bSmALbLRzVlTMYynDJeiJ/bGV1q+4F3ZWqccZ/RENHj2p1sBYS1KmJ3/aiuiSoefx5zBh7WrFW82OhAtulN0CbgfPBWACG+XmpMHITVPr7RRt+LFF4rUefKlnrHT4pQA5z/mU3o2AbQKnig8bInGvktaYSS3sjbjJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400198; c=relaxed/simple;
	bh=ZO9mKCEHnUVcv2smGEZRLFJh9CdlQX9zoJETQejkZq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOKHgvSqI90BB6QyXbOUNpPb7FUnWZ0Vbbr/xd6zPD9fii0VtHFijCladgR4IDGYJEYFkr//Y6EJZ2P3fxr0jsXCeRHo8hbJaG0wI9sByZpfeeRv7xMmxXFtlTef0AUM4j4qAIpsCSzt93mWewz5HzAg1AxLnbvkKku/DfQVflY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RtoMOFxC; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RtoMOFxC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDvxskJJattXGiHGuoc1+et91HXFUVzeY6vCqpVUCC4Onp536zlkksU1FeCKbLbmEM8CmVciZKVaPda3ztSefdh7UQDmxDZ6ZPKePc1uGutxdtyfNwVf+cKkakwAZK/lTbyijUMkF1b+G7it/RuUbMaZYrpXJkxiY2cUtwk4ikj0fX3Qka0h5Y6ZWeiVssl4p+3JbioEzV8IP9RAr2CuhokNS3SgUN2+0NsTTs1uN1EdHM2fgaRLrr2cpeA7oIfVadY4GkVpUK9YuftYxx+/QrAuwQcfeKNh7QtYfrLX3W7ULLmWcZ1sqE0H31qpacfEO3pZAQvz57v5juMwQFc9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9jPtNcs+tWTzm8P4fh+2iZVSqTuTyq1Q3rqecNaUQ4=;
 b=hhKiWU71uIe93qsOVFsauZQgUuUw/or+27jfO0a1nlrbWD8CzfThb7T4+LjVRjo5oJSGs9XJXPEuzhdtgTqyUDwS8xUjwrNcXCNjVBMxhk813cWsm+vyCkARe72niCf1wykWgkToVBA+fTzSyj/2+MKNiWmeD/yYtbFQE3vn/X6aTlW+R39cP6AvadsvSXQyb6pkJdloOA9mVJd3Jq/7ZR6WMORG+dKnhxoM8b2yKdGtCMwo3mVVJPeLnrwQ3H8SX+7JR95S0knQux8wwaJDksV6X8wYt+w64fDGRfJOKSk7zkrdkIVnGI66JkwTmNxUA+PkYA1UKdxi9g8ONDlQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9jPtNcs+tWTzm8P4fh+2iZVSqTuTyq1Q3rqecNaUQ4=;
 b=RtoMOFxCY4z3amS9CVdSPEC3sf7TxMbnFZH7tDc0PFARvUT26+2w6OIWfxc+JGBzIn0vIjnxmlwKAySdjrXVLVeExxlTy3O2spzOl26t/opl+ntJj7M2lSKocV1FJopFqMJ7mHZFDwEqTpXobQSqqCB9jwX9Gb3N+m87AcOpi1Q=
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:43:13 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::24) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:12 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:08 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>, "Uros
 Bizjak" <ubizjak@gmail.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128
Date: Thu, 31 Oct 2024 18:42:36 +0000
Message-ID: <20241031184243.4184-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: cba414f1-56b9-41a1-0e77-08dcf9dbdfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMog2+3d/XAWZ59diP8NGClf5BSIU0KAn+xfsT06RigAJNT2WceEKa7f1kjQ?=
 =?us-ascii?Q?pQ7KIAG3zN/lnJtrc11enr7JONVBXPWiWi4JhXyMUWpRxstPolM1FYQAr6IT?=
 =?us-ascii?Q?ks1AtlwxcrvtP/y52O8CLu5K57HMrsKvTp5Cq4DiCVxKA/6BSyQysBIUIaE9?=
 =?us-ascii?Q?trEevUuPf9fRXskJUKbduLpqtRGYY9MVVgPL6TBrmoGcpLTrtBWebFVlOFGR?=
 =?us-ascii?Q?EFUSOW3qYKManG04y0sePhWsrq/Zl6dpW1yn9SWcWuGsveJhQBhFv1LPNMmY?=
 =?us-ascii?Q?H+q7UzwDs3/cphrnj/W9h9kO3uzcOmU9ssKgQo5byZU9lwpFQ9KsCquLw+0T?=
 =?us-ascii?Q?VKX2czIQ3oxsFApHKf542IXTpzWrveXTLxKT2B9Y58VlNt9DxbtCWbr2SmK2?=
 =?us-ascii?Q?LHR/hf1nurVPxWOhx8WQxdsLwZl7gCkm6qdyzGeEB6GgSynBud75S4rtTp13?=
 =?us-ascii?Q?KVU5/OkjkM5MRwI9sS6pwwlLLKHUqakToSpSVhjPNpwds5RUlk2vfpyZ2ejG?=
 =?us-ascii?Q?6wir92a/zfEvDqwXWaVS266ddpaMOzKerC8qHz2ZvH7w8xzYE9P90rtTVowu?=
 =?us-ascii?Q?lFj3taQQTOSNPWfWREoOlL4+IBsJjFTqrmCUMiNi301Bamq9aKiB0IBx1qAI?=
 =?us-ascii?Q?aApyqMJoOLo5qo0JavTvWn8Hqz1b042yLrgozkXC1/idTlbHM7o9fZ0NY+hd?=
 =?us-ascii?Q?++PeLfGdZVONGLtJidTKeCE4YIIPaDDwl7xIJsk75SV0ftlOkFbBTHtSUbS4?=
 =?us-ascii?Q?L98zOnrxN6TMjsWY/76pQTETy5TFLRx3AWA4a2erB7bRQjiHHwu2Uc9K6s89?=
 =?us-ascii?Q?748bHjCx9FUB4MSouyItKk7PZXSYB+hhySYrwmUr6kZclViFHHFCgjLD1NlR?=
 =?us-ascii?Q?HDe5nPvsabyvysvkmAU/qy1HT/3+zfN/jmd6o76JpI9sWbxF5sYCMGdDPgOe?=
 =?us-ascii?Q?JKTAzCnP3wRlnwWXmWWRHK6tUexEjrUwTAIgMXEvOMPukpTWYXvuPuNxFQZA?=
 =?us-ascii?Q?5kBH5tdkZxvJDSEmmH4C3IVBLGENXekOYBIulfZ2Q6qcogg4CwqXD6+o/Jtt?=
 =?us-ascii?Q?0Hf6s50MgM6INMK+aXQeC0N8zC8Z5Gs+8eirDRXySYuOEGTOfZDjSHQXfUIq?=
 =?us-ascii?Q?vEkBr6f0ulo7cVft8d0w+9XTo78UKtxQ98aZkC1nf+IE9VvftE6vHuyL4w1R?=
 =?us-ascii?Q?Swm+SaRoUnsrc1WGM6EMihr4RtCv9rK/WZlulkh6HYBvkTo3rFA70dapGTJr?=
 =?us-ascii?Q?1hmdlxxXyOrUrRTGsePY1CesBhYa/4b65X6072kw0fJOUnBXh1uuZzX3uwXF?=
 =?us-ascii?Q?hoz6Yp/+6LEuwp/Av6BnUJ16aewLoQ5Xb4Xs+2R1j72XAH0yJtq/6ZWcpB/7?=
 =?us-ascii?Q?taOrIcS1MgpyhsqzplzwoXPHBrz4lvniU+zQHrfzwVGIoeBAaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:12.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba414f1-56b9-41a1-0e77-08dcf9dbdfe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

From: Uros Bizjak <ubizjak@gmail.com>

Currently, [READ|WRITE]_ONCE() do not support variable of type __int128.
Re-define "__dword_type" from type "long long" to __int128 if supported.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/asm-generic/rwonce.h   | 2 +-
 include/linux/compiler_types.h | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e982..8bf942ad5ef3 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -33,7 +33,7 @@
  * (e.g. a virtual address) and a strong prevailing wind.
  */
 #define compiletime_assert_rwonce_type(t)					\
-	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
+	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(__dword_type), \
 		"Unsupported access size for {READ,WRITE}_ONCE().")
 
 /*
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1a957ea2f4fe..54b56ae25db7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -469,6 +469,12 @@ struct ftrace_likely_data {
 		unsigned type:	(unsigned type)0,			\
 		signed type:	(signed type)0
 
+#ifdef __SIZEOF_INT128__
+#define __dword_type __int128
+#else
+#define __dword_type long long
+#endif
+
 #define __unqual_scalar_typeof(x) typeof(				\
 		_Generic((x),						\
 			 char:	(char)0,				\
@@ -476,7 +482,7 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(short),		\
 			 __scalar_type_to_expr_cases(int),		\
 			 __scalar_type_to_expr_cases(long),		\
-			 __scalar_type_to_expr_cases(long long),	\
+			 __scalar_type_to_expr_cases(__dword_type),	\
 			 default: (x)))
 
 /* Is this type a native word size -- useful for atomic operations */
-- 
2.34.1

