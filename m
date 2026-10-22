Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678208;
	b=Ny5tvIlepg9zw9GsowoAPDGnANLzUwM5K42SOw6PUmfJIMtphOTCEggJgcinCoB55++J
	 hDHdvPreBD4t60lTaaEiP+uWfPhf0lHWuMec2I2/Y0qIVe6YHQ7MqOoAx0XziKRe58AvJ
	 5MMm1Pf9jWArTuYIZhXxN2hW7Q11ljeWLR1jEbm0FsMbcCsI/nt8g/jOw2J3gvMAvCUVt
	 ZqZ6rzUkTUY8OpzA6+x0KOgLOzfauBdPQvgKQVOlwZj3Iqpkw3MrV37aJ3u/MVJTCsmG9
	 n+h5ouoqd8kGsXxO1KlMIc5DSG8MNP5gbaV973vIkk+6aQBKQe4u20xlcHl4UDoKiSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678208;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=O7iO3LVCjQSnGYGCE2vVj+SHHWr2zbeF4noFKjBGDT8=;
	b=RqwzYYvDddsncli3MCr80wN2GwB9KMTQFXQaA8f7/vGKKfJTWzF3TwVkI5KqHJrGoTzt
	 BEdKY2s/p9m9c+CiULVIvxhzbEXCY9vzlZLzwLMdwE6w8ca686rJ8H2/O61RoJjZlidhK
	 qZcadGKzggylcUE/+7LwjRHpiNKpS6OPL8crRBf/6FUdVHXNTtSp8OTPnJm4kjezJPcvz
	 W/bpJ1ZzeFVAF5HH6B5rbZ/m/JkjjZHw0UqWWU3047S9pIONm57ZxiP9Szx3diH6sgfnc
	 IU0Dsa3CxavAeWk5Acae00HF7/3OgFlkDJO/mega2RU6jozLjg4atJFriWKlEOI95zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUQsueqU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A84606A319;
	Thu, 22 Oct 2026 14:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A84606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUQsueqU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYVqEPO3IarIACQHwflz8IErcfL8a7bNovp4FUusU7qv29LmeZMvQ2D/BYgJ9Pbyo2bSRa416TOsjG17fQ4EHr5cEnbyiLbrFTSuWI4MHC9YWAhOFioE0ggEuy9saCxBgUm4kaztDFgFYmd0CWXcm0gp7PM7lcpp+GNrzELFYdpqBzz+VRXqNsIwR8hfNta9fa/o6r9KsmKRY/JhpnhlxAmGiKAx3Z125gR2mXmyOi4avr8KLdjOeMq2A2vr20RDJ0WF+/XrRNoCZLe/ilzyhPm8ATuqDtVbw+EdiVElNXRYqQFvGB89/XusHRtJ/4XtcinQe6U7kQZEjeIC/WKpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7iO3LVCjQSnGYGCE2vVj+SHHWr2zbeF4noFKjBGDT8=;
 b=JVhDnFwru3IZg4ReGHeKYxjlyFAFZWdNjG42gInTWZ04/DQy1zHRJ0SRcdv4K8LEuFYHwCI7h8bWtw6nBRvMRywpewiQywYxACMsAd+PFJQk9qMHaCUXvIbvx92F2fZRLP6CpaMXQNpZeJcQYwA8JpcuIiZTIQyn4VFcpWehvafHtFxdEDGGeEvrKdp6nn3uFkIFA9EzFFFlY0vEtXxv03pMFV2f8dLXtkg+v+03wa/qUYftUoWal1br1MPskwnairipLNz63bnafUBEC3l3DY+t+dMYO0XWM8l/dEDHpMd7KHv1CJLO5jfAcMi1fvcfhctHG7KC9fBkNQlaHwseuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7iO3LVCjQSnGYGCE2vVj+SHHWr2zbeF4noFKjBGDT8=;
 b=AUQsueqUZaXD/2yjhZjCIi8u21B6drJROwqLcoeuWSqPBTCr71gHmaQG/7e4ONtMtp32cuyoqaCBfYw7kTMkBT4L8Q+oZNhVUv1TklQfqZLBA/mNUq+3cpkwqpcOSPOt6i3HDSbD1gyvuYirbW3WlS38h6TMLFv4fXwWBnoeavo=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Thu, 22 Oct 2026 14:10:02 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::7f) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 14:10:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:10:01 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:09:38 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v6 7/7] iommu/amd: Provide kernel command line option to enable GAPPI
Date: Thu, 22 Oct 2026 19:34:25 +0530
Message-ID: <20261022140425.27465-8-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022140425.27465-1-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e2b3fd-2080-4431-4365-08df304629c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|23010399003|261021121427099003|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|261021123027099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	0DHv2OMWQ3MqsgSl33SFC6tdMQnLPLuD2WqC5tPh7iD8dwFyZe+9fQ295MREvLYC1EOYhvARrU3605SL2azfRAjns10gUVxqIuQVe9UuXe5TajwRstRIUT57eum7XN+9JQjEurxv6rFJ+9FBmThth4UEkg4uTZVxxnN06G7sQgLlmwKmxV4CklRstvQgd9MUuGaCA3awuPS3c68qh15ElAIrY3jnQ6eq+axjhlSzXCY1SsykQ2Yf4RVYEXDh+NbLfvxzHU/tM+jvqhd/aczvZjw1aqz07X/ouwB5bohdtI8hxRoNXqKwx3MaJNbOrE1eCW7f2zwFdKL53PJAXlIe3zLWMJXoXBrgWM+l5LFiDxtf3puu+eWRv79YhtxbVFtoHF466YdN9H6WjDSZfgb+3s/VbxdVQeJT55D2hcNlK2aeCwwTGriEQACrB4kB3STHt6rscO/qjURamNpnXn3WAU3+EJ70FyYll1lqWBwI2dX4M3WXoYtF6xCTybbyjEZq2F2TjVsuD2v/85gITGl302sVfNNkJLbT6gkziT42/vzowiidHavegj/eEXn86TTUi2B2pt4zVlwMxZe+NVpTPG9fn2vhgCdY5uVPqk9UxMz/UPXD2jeeRpzORuVCwGkoAgb2P40hcKrbmO2rvYmpSlA/Gv2ha0wZRWuZJZmPazQNiY/L63WIVOc7lGXFIqrvmFQpbOmmTnQJcqP99LgF6jwv9d4N7Ey+UKaOPuHfgSDkZfytCopde6Y03s2r69h3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(23010399003)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(261021123027099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q9VCwg1h04pQYSm6rCVYvZOOHwiOhSMYKYZ98PdUSjOyws3xyBYj9mqgeR9FqD0I1GFnI8gRHUtjqrMPzAyVAJNKs3xnhnqqA1wZivGRH+paOr8/w9mW+3sJhDjRPJGzHnP72lnerHmgMAxbk2N6lC9TcWDxAndA2S9bAy15ogOD217nlrcMi7PVNSEhJvkLKCH8tFTqbQ+Z8RCrJTPTi7wpnknA77qkIQIoQ7WfGxx24FBf1iRsoBKHc8LDM7Lu2RsozIVO9GAU69HoAeA5g+Hvn4SeulJjp9IOLLXQFrphPpUWMjQYXUy8pgYYzdj+IAkhQDvb4VrsktkkHJHNxE6cWdaFHp4DPu6L5AiFvAiHZXNs9ZhKbQyfKeis2O4DNNI6h3TQujf2NVKOjdvfB8aDQsbeQnHL7mqB6wO13JsJSp88tvcGN+jS5HQnFMWh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:10:01.6236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e2b3fd-2080-4431-4365-08df304629c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

Enable GAPPI when the IOMMU GAPPISup extended feature bit is set and
the kernel is booted with the amd_iommu=gappi kernel parameter.

Document the option in Documentation/admin-guide/kernel-parameters.txt
and mechanism in Documentation/arch/x86/iommu.rst.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +-
 Documentation/arch/x86/iommu.rst              | 22 ++++++++++++
 drivers/iommu/amd/amd_iommu_types.h           |  2 ++
 drivers/iommu/amd/init.c                      | 34 ++++++++++++++++---
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..b260ebef118f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -456,7 +456,8 @@ Kernel parameters
 				          to 4 KiB.
 			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
 				          to 4KiB/2Mib/1GiB.
-
+			gappi           - Use GAPPI instead of GALOG for vCPU
+				          wakeup notification.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/Documentation/arch/x86/iommu.rst b/Documentation/arch/x86/iommu.rst
index 79c33560299b..6bac30f5abbd 100644
--- a/Documentation/arch/x86/iommu.rst
+++ b/Documentation/arch/x86/iommu.rst
@@ -150,3 +150,25 @@ AMD Fault reporting
 
 	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007 address=0xffffc02000 flags=0x0000]
 	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007 address=0xffffc02000 flags=0x0000]
+
+
+AMD vCPU wakeup Mechanism
+--------------------------
+
+GALOG
+^^^^^
+
+GALOG is a legacy notification path to wakeup the vCPU waiting on an interrupt.
+When IOMMU receives an interrupt destined to vCPU which is scheduled out, it
+updates the vAPIC backing page IRR and appends vCPU tags to a shared GA log
+buffer and raises a single GA log interrupt. IOMMU driver scans this buffer to
+decide which vCPU to wakeup.
+
+GAPPI
+^^^^^
+
+GAPPI is an alternative to GALOG.  With GAPPI enabled, the IOMMU still updates
+the guest vAPIC backing page IRR, but may deliver a physical APIC interrupt
+directly to IRTE[Destination], using IRTE[GATag][7:0] as the vector. This
+distributes host wakeup notifications across CPUs instead of centralizing them
+in a log buffer. This can be enabled by adding option amd_iommu=gappi
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b89a2b3df0a4..51edd617ddca 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -78,6 +78,7 @@
 #define FEATURE_X2APIC		BIT_ULL(2)
 #define FEATURE_NX		BIT_ULL(3)
 #define FEATURE_GT		BIT_ULL(4)
+#define FEATURE_GAPPI		BIT_ULL(5)
 #define FEATURE_IA		BIT_ULL(6)
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
@@ -178,6 +179,7 @@
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_GAPPI_EN	55
 #define CONTROL_GCR3TRPMODE	58
 #define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 78e3c14dc1c2..72394c92a3fa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -448,6 +448,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
 	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
 
+	/* Disable IOMMU GAPPI */
+	iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 	/* Disable IOMMU PPR logging */
 	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
 	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
@@ -2273,7 +2276,7 @@ static void print_iommu_info(void)
 {
 	int i;
 	static const char * const feat_str[] = {
-		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
+		"PreF", "PPR", "X2APIC", "NX", "GT", "GAPPI",
 		"IA", "GA", "HE", "PC"
 	};
 
@@ -2986,6 +2989,13 @@ static void enable_iommus_vapic(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
+		/*
+		 * Disable GAPPI, do not check amd_iommu_gappi as it may be
+		 * false in new kexec kernel even though previous kernel has
+		 * enabled it.
+		 */
+		iommu_feature_disable(iommu, CONTROL_GAPPI_EN);
+
 		/*
 		 * Disable GALog if already running. It could have been enabled
 		 * in the previous boot before kdump.
@@ -3027,10 +3037,19 @@ static void enable_iommus_vapic(void)
 		return;
 	}
 
+	if (amd_iommu_gappi &&
+	    !(check_feature(FEATURE_GAPPI) &&
+	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
+		pr_warn("GAPPI is not supported.\n");
+		amd_iommu_gappi = false;
+	}
+
 	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
-		if (iommu_init_ga_log(iommu) ||
-		    iommu_ga_log_enable(iommu))
+		if (amd_iommu_gappi)
+			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
+		else if (iommu_init_ga_log(iommu) ||
+			 iommu_ga_log_enable(iommu))
 			return;
 
 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
@@ -3039,7 +3058,8 @@ static void enable_iommus_vapic(void)
 	}
 
 	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
-	pr_info("Virtual APIC enabled\n");
+	pr_info("Virtual APIC enabled with %s\n",
+		amd_iommu_gappi ? "GAPPI" : "GALOG");
 #endif
 }
 
@@ -3782,6 +3802,12 @@ static int __init parse_amd_iommu_options(char *str)
 		} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
 			pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
 			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		} else if (strncmp(str, "gappi", 5) == 0) {
+#ifdef CONFIG_IRQ_REMAP
+			amd_iommu_gappi = true;
+#else
+			pr_warn("amd_iommu=gappi ignored, IRQ remapping is not enabled\n");
+#endif
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
-- 
2.34.1

