Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353F18BC32
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055909; cv=fail; b=i3w7D9pJcuJTHe5a0KbRWjtbNeRKO5BqYIoHRXZ9m+C/XSzgGXLR7sl67t1LH671Pa3nW6KpSSUl1fpAgSechojenmryzbflGfHtiKA/pkdoUeq+KlnitHq6C17xtIg4qI07BeYhBspkG6sdQAoWiPKJRtm9b4wc/boCxETHONw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055909; c=relaxed/simple;
	bh=4u5pNnXEu16CrHfcXuEgecYFjNug5ieRgFcVsvJ1bk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IM/w5bHmKKQEQtfz+O4PYGWv3xsYd3iYvZbIUSXdwrU/q3zixnow6BJOz3WKCej8Wc++pg1scTP6j7cCchWp5wr6tzz2qYNQxf+u3vyuHeX/cIyM/RbkDWPwBgqqEJTie4jBIyop+N+U2/edD3w96Bp4iOLKOuFSsJ6/bmvMq98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uHRRiDlO; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uHRRiDlO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYK0B9VSsnWIqVYsxahPx3scTr/wq25yH9N9rANzANZWHYgu9NvUgoTkzpaZ49rBOz/NodsnsRg0pvFkBXklGow1DzKUzIkRDLj//Z6FRL1NlVycxS1ZUuCpjgYMZbGNQkQ7aMl1M2AlmvMDREU4o242bEG53dtDfADXEdCLf/45wC7L2rTTwXh6EuxUPercQOWXouBS61ZD8oR/LuIuEk6uttfKTTICLBxb7B3Lf8ciDn9gMHaiQHglnFRHYSZJulFYLS7qWSoe6gIAmI/hwsNJrWztR+Ia0QMfE9rsZVN6BXVbxjMaf2wvwUOlN6CogKFv+zrxRVrQfxwy+UQXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CbHLXRauztV9qYrognJvOjdX/iYxWVfpKEPEeqDsrs=;
 b=xAkn3sWJeWBBxg4jy91F0vwzA3LqPveJRX0UqUgbl+q2Np3HJ50eRcMUZY5uzE2rZT1jxpUkPavgsNjAPSmGlpXZBcARL8rrCeY6CQ2FguJ7c6/MzI3dy+LmRgi/RmKT3tjB2gzQAIU3QM6MRyowAHrHyqzTuTt7lQ59C9aKDlrV6MWoizEWJbiCOU9t0HbIf6g7h5qdH19c4NQ8sqrbhSnKSb1nOqictqB41gYV2vWrp7M0Ukfvwi5NGfL1kIO9nifRZZS2c+bO8pEvZtm0b+PnM3uFYsVjmhKMf1AwY9CkoyUOpjHPxwXMAqMYvn/e6qPUoTDJr62y06yjw9Q0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CbHLXRauztV9qYrognJvOjdX/iYxWVfpKEPEeqDsrs=;
 b=uHRRiDlOaO86u9yzfmgsgMkbCp7eXz2e4cqsh6aO5AT+urXXgrGdYjjEDaW/b+LSpboiKP7e4cYS5l1o3UtPsI/oeVFrfnLPmEQEydtS/w4M2kUgfHaZYSqLfMrSyAoHRqIpg4+kViqsax4viRgNTGnls24Bv9i5nZLgNMSINhM=
Received: from SA1PR03CA0003.namprd03.prod.outlook.com (2603:10b6:806:2d3::14)
 by PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:18:23 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::f6) by SA1PR03CA0003.outlook.office365.com
 (2603:10b6:806:2d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:18 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>, "Uros
 Bizjak" <ubizjak@gmail.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 2/9] asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128
Date: Wed, 16 Oct 2024 05:17:49 +0000
Message-ID: <20241016051756.4317-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: b45b28e8-34bd-4c1f-6bcd-08dceda1f4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMrGxaDzVYNsQP88ohQ4WqBgAPbr3XSIJLFMBQJwGxvsxYv7OEqfLfdbsAFe?=
 =?us-ascii?Q?KYVitlSoNoioN0UJbq/WLPVkzqaNYhTJl2LbME2R3pgyggHLKVO204tXBhI+?=
 =?us-ascii?Q?8Tt1Q4k/+O8YfljGKB5nij1Lu27Tj2Zjg+V62uyd30gsy1CvgSjvNTXrF75P?=
 =?us-ascii?Q?dmpmXuzV3nH7FQSkGZFX3rTjRbU0myL4A8WIRSZDr7YKymJpFbjYFFbJ7bX+?=
 =?us-ascii?Q?POACgc6aAA+jFAZdezaI9fCkbKlDi8nQeD0O5RhmRpwKe0P2LTaKbxR0o6/w?=
 =?us-ascii?Q?1c6Br9rvojFRP4d909/mLmDgqRVMtQOyOuJZruI5/F1fdHnHAz389WjCxAiJ?=
 =?us-ascii?Q?tW5hju7BUa2wvTSPxZx0OPiJGPZDIqk/6rnWam0GCrTKZCu4S14wN01/TVFt?=
 =?us-ascii?Q?OepmBZHIv6yy/9y8FrxWJhvvIb3REmpV9dSX+eBuSbc40fvYe0pq0HGAPLmu?=
 =?us-ascii?Q?ZUmHXtGcUmDqpSzhkdvcVxHj0R09BPZpZEGOlE/8b3NgpNM4qcKm8RXxv2kB?=
 =?us-ascii?Q?4lhCcVmAENQ9g/hQdRMB+Rc0ZygTdj/Q9iYcRTFoF4iv/uErLvqOw3xXiEQO?=
 =?us-ascii?Q?JzPh39RWpIFfEZRTUMQiDfBh1I077KOq8sKA3LrpdVqM318vU5ByHC3ZzpRo?=
 =?us-ascii?Q?ELPFq9oBAI2pq7rFZbhovNbKYxWl7CBZMAxWAYWqdiRHj4T5CZVGaW4KOGxD?=
 =?us-ascii?Q?7ZiZMca3ART2DkUEae5+uXinFdhHk2dxbecMQj3oacT8VQFmv0tF53psyraM?=
 =?us-ascii?Q?Jv/8AYcaoFVuc/B2m/TzmfoKyLU3oyXKkXSiofxFQ8n4W7rKVjmfxfikfypi?=
 =?us-ascii?Q?wIB7cxUb5KFKuugminFJ92YDHjEyTrtKWSmjD10QGavUZAwIHnx65DwfowsH?=
 =?us-ascii?Q?bvtXW/4xPlIOF8fWkIypUExP/x8sWM1CmvLqKrrGCZBtW6sDo6s1ChAvupj+?=
 =?us-ascii?Q?wvj5gd84X9MPoq7QMCxlkppeyDVLCX4hJ2R2JtFRgMVU7t4s9cyS/DaG0mBb?=
 =?us-ascii?Q?pNjdUI3eZ3n1Lt8v70P4ubr16+XGvWidfWR4EzzDiDR2t9j6M1K/p8PvK1/K?=
 =?us-ascii?Q?ClXJ1rhphhBdlqT5D57mmNZm28urZulGxzg9Wscc6ctSSgu5vuRKJqykp7d+?=
 =?us-ascii?Q?DWIwANtNcuiW+huXMKEIkimfxR4njk4Y/IRyUMMjYXXtU43CSolz6F/LyV0s?=
 =?us-ascii?Q?rkHdRa60ojgiD5EhhtpM4PMeYSKGgNae2PCMHUMwHqhexPnnT2qD0omRvOuV?=
 =?us-ascii?Q?h7X1YHDOkNPATJEwb+IQIHC0H5e9LdcDseeo6VAvzXDtxZmgemzu8xg5Kxea?=
 =?us-ascii?Q?351rRM1vAIUSldQii5cGQ68A6WGJjwORyA5xUuLSEshE0q3COWdgWlj664A6?=
 =?us-ascii?Q?sQpM7BJL6eMglzUKuaSzqmoiDZLw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:23.2434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45b28e8-34bd-4c1f-6bcd-08dceda1f4dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757

From: Uros Bizjak <ubizjak@gmail.com>

Currently, [READ|WRITE]_ONCE() do not support variable of type __int128.
Re-define "__dword_type" from type "long long" to __int128 if supported.

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

