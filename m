Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA673198E70
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366220; cv=fail; b=HbITS4Mo5wziG9u7zRWA8fCT/ZbNzIn86pHvnPV1B5JG0ONDdU55wq8deKPJ8xZY8yoTOyg6PIilwXmow16+fy1IRGTUEVP4f+s7iiA/+iM688tybZw3QDT5OYIrWnFQUVUgWOpwjKCJh+qreC4whu5zNT05oLnxfKc2YZF+WVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366220; c=relaxed/simple;
	bh=ZO9mKCEHnUVcv2smGEZRLFJh9CdlQX9zoJETQejkZq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeymhpwQdT0AfKC63Tomggs0ZHuBn5tZvfvj9NdkXNtwYJS86Mxk+7PSHvhlK7y2y4/CqjTfe5XXUBzfFWTdCX0ZsrByN/OqW2FjNRr8qF1EuqLLgClTxGx55Cgs8CEo49EDJSv2DaxlbGRvQKVlyhZoMpSPm9Jf2UYLJZOGCLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FVb75QFt; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FVb75QFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6s4WX1Uw3bRfKdJjx+GRuD83D+3KBu6WTSo1UUwzqyivHqNTBkPEypm0RefAqR71VUWWmZZ9s7sKjqkKzITWKj0IImOAj6SAPQyP5NOSDT3ZTtEWligEmazrVn0n875Ss5EaAMT8zJo4z6OAMLOiYiTdoPDbNL4ZvO3Z3345S+a4JVyKy8wU+uJArHT5318CTl1Mf9tZIOJyGruj9yurWeXZ/tJT0pOp3p8v90bjBOGj1JpuqI21sbk46fxs1sC6/TPYjOMcPKfukf8Ce51YpBdwNTqjK2M0fDKgWueRrJ6lkddHabbGuwyEV4SzBTO+/q768nzQR9w41ty0RRysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9jPtNcs+tWTzm8P4fh+2iZVSqTuTyq1Q3rqecNaUQ4=;
 b=GEKwIVlvQrdHlK9zgaQpYxpjdDpwPMdnJQGoymzQMY4i36jIzYA8dhOhFoNv0saCVyYQEFeSzmal0nUcFsoibhp/NLGyDrmvEN9PXqerpqe44OH9wLaJ4LFRe32s3321foYrvdV7lQr6H/2KEvlFQF0UxaPlx6fc2APLcwdiiIshhGszIq1oJt7wiQgbSF3/e439Y3tTNnmGrCK54uA+OnKKwbJocMCMNlRV6JUM1Xw+356dUSyuPoNtpuKwL5kNnPGVT/+RHQp6YOE/58vF6MSb+A/5ZPbo5/uCc3VeqWhjxk/IIzs7kq1TFI+sOFBbqjAhDJ1kVQ16Lr89/4IxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9jPtNcs+tWTzm8P4fh+2iZVSqTuTyq1Q3rqecNaUQ4=;
 b=FVb75QFtLHTb5sY1wBmiPQzL+o07xEYssfyjaXog7jJaK/PTONNB9LZ7BA+9dB8Ek2B7Ifysk+gB7WQ2+Rr8a0Jq1koBhLk5y8bL1e45529vbbfhtp/XnwuA2Ozf07GWFKf5iUezZMo1LSp6dUfQsPlA7TQgkhdzfGQf2K/mqsM=
Received: from SJ0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:a03:2c2::23)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 09:16:54 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::da) by SJ0PR13CA0048.outlook.office365.com
 (2603:10b6:a03:2c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 09:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:16:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:16:49 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>, "Uros
 Bizjak" <ubizjak@gmail.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE() support for __int128
Date: Thu, 31 Oct 2024 09:16:17 +0000
Message-ID: <20241031091624.4895-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: c675b5fc-f86a-4f21-5e2d-08dcf98cc2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3G9OeUvrojwMoj2ZoynKxZXrvoOxR6NOx5tZrfdvvXapAln+WXQDm/FSX6gt?=
 =?us-ascii?Q?j8X0zZhCCOu38tl4twTN/YRJRRqQsB7kBAUmMQKJA9ldEmtfVmma5+aJCnUH?=
 =?us-ascii?Q?vKElnMuP7LDDjQNyQq5znp4nHJ+o1IilHNtdbfY8xKKz5QFA+GKb/zN9nxx6?=
 =?us-ascii?Q?ze2hUlcC2PJsAxp+cRyr/zjxbGVUTYI9hIf/375N6he0+z0cd6xsdCTAfRPC?=
 =?us-ascii?Q?BCqhxvdE/epricPTbsPFu8/PiexN6JNCnREv64M2WBA67SLC3f4XxxIJ6IZd?=
 =?us-ascii?Q?AolvaFTHtgXcvOtEBbYU2/Cf0G4cD6Jn59BgZ+Vntgp7CQSxrotvB4mMg+d6?=
 =?us-ascii?Q?bP/PZyktVwimXJ9SlrEOrHX0lpxSPaoxd/jFX/hh+QAX2GPl2HCrQbRzINPU?=
 =?us-ascii?Q?s4zlDhR6XGndRRWwuUBk0gjM2k8IqB4LXRuE1SQxs7jhT0qzgtuabalWUV2H?=
 =?us-ascii?Q?Z39o/1cHnLn3QQGbu26atqUvxJieHURBu7KTs3GCQf6/YZOHyGqFKwaKecVe?=
 =?us-ascii?Q?LvgbPG3N0B8hk6XYFdgGNcFDqDvbPAvIN0C1/BAl+gUVjhEkHuVWuh87ZKYd?=
 =?us-ascii?Q?0MXHfhBH3XMPUeVLpL1jQwfYTxtcWOh0LqQephQUFKJUY9cZCqJtLBMjhlnm?=
 =?us-ascii?Q?CtAjJ0kUjfJbMpZBo0QtdTKZaxQNGF7LAOYaeyTZ1jAPe1xFqWbdNruDRDWM?=
 =?us-ascii?Q?xraqtPPLc85I5vSNt0z1JatQ4ZerLXyOPNNmDFtEfY1D+f2te5fzvlPiflDL?=
 =?us-ascii?Q?bJRbkPi+4zcrdiS/KHLeNH92jSMzaSI+DImQ7ViGxZV4adIhN1vMVGzrnKv1?=
 =?us-ascii?Q?SOCkWx/jqpzrtAzJ7aWmI+xUhjsAG1+E/norGgeH68gsKiiJZm531TWwXDu/?=
 =?us-ascii?Q?Zu1/bRDf39UTzvRS064+B4X7HuNP/tP8blao53ceABTyyxQ0vZ8pKA21vdM8?=
 =?us-ascii?Q?1/G45di//3vpq8KjpJ9FpUS+4ZrDYFF0oVg0R10DRy9kG2OLpQDKtfQ5EMo6?=
 =?us-ascii?Q?kE/1HUk09lzeCQhfQZNsT8FdkAVu6RDskL2khVsswtbMHULcyDTcyozhzcTq?=
 =?us-ascii?Q?2kMW9z/5lzbPzsz2EcVQW7fnW8YA2sGuWbEwd87CUtG2Kg9ejZx6qPN4fiW5?=
 =?us-ascii?Q?gGCl+osWfuAOX+Z+v/d6zJvqK+lXlC3Typ1Gu+LR5fDPe4EbwukW2eUGMYtQ?=
 =?us-ascii?Q?aPznPfN2f37qlreXG7MTcRSC0QyV8q5qZO8HdOoBkluJYyIijpI9BbFXhFAY?=
 =?us-ascii?Q?7cMvsr4msD3HqGeaC0fqa8kPXRg07BfU6+L9H1YdrHmA9UiqIlHn0sLs27nb?=
 =?us-ascii?Q?E8SMG+rbeGz/1fU97G4T4b3WHIyQssRwADG+Kjbdyv4awp48K6pYfSYgYYKt?=
 =?us-ascii?Q?JcnnjsI3BwiqVAVPmQD9LLobuExZ8vzk569+p93YGCgM0ZdBpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:16:53.4429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c675b5fc-f86a-4f21-5e2d-08dcf98cc2a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

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

