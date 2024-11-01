Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890D1CC897
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478220; cv=fail; b=rv7nwfsKH2vI1WaNPhmR88lPHEMcHSgSQm5fn14ISs6m8/qo181eEyU1TGFUzkftv07tQW752ppQnGyh+gfFNXs+1ui5QUoe5q3gNxTJg/xNuhxxwUTxwr/kJs04xIPTDPXIAH4VCbiL0/OeFpcxSfCfXsW4uZQUikFXpZi5I64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478220; c=relaxed/simple;
	bh=ZO9mKCEHnUVcv2smGEZRLFJh9CdlQX9zoJETQejkZq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWw4+BpBEnvf38jXHrqfi7gr0ny3KbGJtzjxSeG2eKxsWcw1XO4nqbFD7WUL7S46VL9iNM7UlmFRWpD4KKjAhjWgjBWVlHK0SHFjcEOo5UGULyYQu0V6uveB9oG39FjYK0FqqQqmF0PIjTqbywihUZGDGSsE7w3MuPINXYm/jPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wa+9j0kn; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wa+9j0kn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE3gGFuPBdQngU0XyEGRbgnxfKtXxMlJ+keEDBBKoWsG9rJhP9cesUHhYR8+Vlp/7uDAE2vCt2KQdkLvmFGXYPczxQX7aQ2EB75zg5N0bCLTj3283n46lpCmsXIyvCfvwX5hLG9JeQ9kZGgEQ21fQThRuvo5+rIYN2DuaDdo1W5chGDDzz4Sb75pNEZOqeMBZTc3eCUZu82zLdBsaWDJNvTjdiP6i2dacmS5koNsI9JuQ3orTnc5uO/awuEZ08KMZV5IS0W/ctUvXPjkQxXqayV6XpHkLLaMDt39bZB8QdZbKLX/qOtKH0gRp0lRqYcvJRRYfkaNXOAbaVRISXb33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9jPtNcs+tWTzm8P4fh+2iZVSqTuTyq1Q3rqecNaUQ4=;
 b=gxKHd4bqEixVWun+c/xxN7Adk+vVs/Qz1vlElNk4U2HUg/lKHi+6rroauA3DPM5xYIxkMQ5cRknvq8ZsCyDCYkBPbHCbgvPWGm6a5pxm6ECPzImnxE0RbzWTdAnRuVjo6JveOti47sMoVsTAkMxUB6yzXLacKtsPQLCTffHAIS/Ut+eiEEhIuoiP/ALEayY/nsILx/CNCZKEScUpOCKsBxlnU+Uy71F63k0IFn9Xl+bFXuwQA8wxxun6M+V1iUzAS8r5aj/i8pxpVYod8TfohdEgus/2vMh9h1CUAIcIW/8s0DFN6y0NeX+bVFewfklOC6o6jlgrwsUOhQCP0x26Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9jPtNcs+tWTzm8P4fh+2iZVSqTuTyq1Q3rqecNaUQ4=;
 b=wa+9j0knrLnwifZOOp1xUMMk91NQ1DdOKFLLQ+ptp9Xtbmc26Aaevnm/qD5QgBmxS4EgBC8d74S2PfdLCudOMUH+VsyeEtDs8xxWV51y0JZDJb2Gt2TaVa9Q67rdKfOYWavBTGpq1AdBTGcENRfdmAMp+G2gz2fnHJrY674Ps50=
Received: from SA1P222CA0032.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::13)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 16:23:33 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::8d) by SA1P222CA0032.outlook.office365.com
 (2603:10b6:806:2d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:29 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>, "Uros
 Bizjak" <ubizjak@gmail.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128
Date: Fri, 1 Nov 2024 16:22:57 +0000
Message-ID: <20241101162304.4688-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: d63ef0b2-485c-4f97-84dd-08dcfa9187e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AS8Mi5kRnL9ykhNkc3BwivF557+YtUfw/D6zDvphpRiJ3ZnleDNZeqb191Lk?=
 =?us-ascii?Q?KnwndrvG1ULuKKZkXwtGKeYqO607WZEJyWU/E6A4fu3hJPjULMtIPGuQq3d3?=
 =?us-ascii?Q?JW9Nkpih3Lq9pIfiSqWzlDVLktEr+MH4QtMS7yU/MDTZ0GKkMOyEK+uw2L0B?=
 =?us-ascii?Q?rmKTrEX3esbr1UhdhPVtpjorQdt4YBWweO4qpjcuX7kxAM4sFNePGhEQvGKd?=
 =?us-ascii?Q?t89Jez5aGNgS8j5gizt8sRXxb2GFQPJqu/HCc3irsvqGlV8SIqBn9C/tf4+S?=
 =?us-ascii?Q?gt1fgFYJu4jB7o7E4yR+h5yfd7kRe7gV7dCMAIIa3vlY9+nIJ6d+MqLroL9d?=
 =?us-ascii?Q?8tGVCUC9nCI+uJl3M2TRbwUZh/L+8SowIg5pCpYZQ3QQrbYRswm4tELWqQKG?=
 =?us-ascii?Q?EZCkNY/5wM7FYE6hmMCcA4c950RYhl9hVC5Q7xi/mJrI9DpbR96fbwLEaXU/?=
 =?us-ascii?Q?CFfO6cl4AeQ8s+NowcNdPksSwnrN7TXBxufFNBMMOR/eLRwa8Ff0qFlnZbzp?=
 =?us-ascii?Q?297InTDhOF41Zo9hCV3RwT+Psq5jRlIAB7mi+2pWBTKvPI0GWfWRsfLfqtzn?=
 =?us-ascii?Q?HDThHv4U/qatMHCe+jranicfTnoMz8NWDbaOxP0fboSwZl7foXhHNeIgU8T7?=
 =?us-ascii?Q?y1urq+8t07PLgx58GfCwFaZO90qcA8Pcb16qp/fZVzo4N3psNSSg/EtuFKFa?=
 =?us-ascii?Q?dTgsWcXc8lGZbvCQyc+1se8tCg5Hq4YWSEylcNTr8OHuLA7npgU76a2q1g2L?=
 =?us-ascii?Q?aGsa0fETyP8x7oGWEarOFR7+CgeH6Xy9SnNWL7H2mMkWNj00riq8+dhKucEm?=
 =?us-ascii?Q?Y57KW6rDCei3zDN0ZpQ1KelHMjqzAorY/RqC7m8guC47yih4HyN904dzutWf?=
 =?us-ascii?Q?Xkn7xOfHChYD3Ej6Ia14MeKSF1vykpcYOiFENUp/1NHjoKLrgAKCsNfdSulD?=
 =?us-ascii?Q?VNi69/wfFLJWBe4bIglwTfwNQ0fRCxZw6IrL8Cz3TUqj2GXSjU+r12lXpSYB?=
 =?us-ascii?Q?WWNw+gInjgADv8HpgK6hN9xpw4/HxvXW/1fH4ERbKVo5bkcF9MDr5ekstClL?=
 =?us-ascii?Q?nCwF2ift0RS7+rK5OGl8e+bkiXl2C8MeDRT8hP3icA4GdDg9OMWTiZ7BbZZF?=
 =?us-ascii?Q?s67ktoTUj+NFkITQHf/RDvmn4mnyzklrt6MVN5JDQ4+4CagqlApKiVt0FGCu?=
 =?us-ascii?Q?3S6E0vLa1KsNCuVqG2sk3OW98Xp5dbpqIkAEpepU8sKotf0TudorWhB/OMvg?=
 =?us-ascii?Q?LvUOuVAbMvqiBYlUkkPy2bYWeWLj5DT++JrJyjYQwFRzhMbdPjDEKoGC+9CW?=
 =?us-ascii?Q?yhr1i1eaeSSzNPlXzY46Ivk4Lwr70sOJxh/l3C4osoMxk1odSqz54isRL0Oy?=
 =?us-ascii?Q?nnxUtOHJJu614XB+Cubi1I7b6R2m5+BCh/2MGXQJyNb8Gruscw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:33.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d63ef0b2-485c-4f97-84dd-08dcfa9187e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

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

