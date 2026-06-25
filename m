Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32332E128
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395047; cv=fail; b=KNAL/4KW2TItGwrr5y3N3FQds2cjDglOOYJxZumcHCA8rFrsvjaQLet1KP9hQquIYtNXfh2RsvmvjdoPN7KpqHJsoOcuz39nJThIHnDNA0kKhnf5GO3xmOwB68/gR8pkIwhGLmc0kTKQOBPvFECLd4upj34Fj9MWMDVgYgK4b3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395047; c=relaxed/simple;
	bh=0hBL8t4zm6b1Ki+1bx80nDJR7nmAzAjXYR2DpiQKWcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+9M2vvL7RCzDxKy6Wcy5woPFXrYVqyU9pRMAzwiJsxdxiBQiCUc/vZoojoXcB4Ni5HkL5g1cqz5HrfNyQ4tRGMd8KRSNNCtQFS/QYJlfomA4FWO9umSWuKF4z3EmTCXQchyDdrdGOo98w74FhiziNeJfR2slIeN1RJpIgWp0GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyPotZRq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyPotZRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782395047; x=1813931047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0hBL8t4zm6b1Ki+1bx80nDJR7nmAzAjXYR2DpiQKWcE=;
  b=cyPotZRqlanonmQz4ylXzLeWwm90eeh3CyTOmyHj2vetATke6LLqUyZH
   ueXeylVASJDiEMrG7BsdaSu/R25sgTjfKvN9rqVHuM1ehvpHvnKBUuZQy
   dQ0Bu2o4e4rk9Rax0it2GDUq517juS/N2M4lweZrtSt+S0ZPFaGEmcYmq
   ZoXuoxx8KD6UQ3+hqji9MJHzwW0ZuMrP1Cf/YKCKIHVOTPvtzKy5V9jmY
   adc2qbtnBkdRM7gTN/694bXpjiu1rxTSTm8ew4ZIHwj5rsh46OynqHW5N
   xo4KlHP95NzB5+1UPR0dUeokItH2yh2WIc3IenN4yvT9odKJB/vRX//9Q
   g==;
X-CSE-ConnectionGUID: EYOsjhs0SleqoVGEzYLYmg==
X-CSE-MsgGUID: s+Bk0bbgT5Oe1jupjh8eSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94566673"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94566673"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:44:06 -0700
X-CSE-ConnectionGUID: x/2LkOv/QgeuHerSfcybvg==
X-CSE-MsgGUID: BBYD1AZZQ+O5M2uIdTnnww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254419554"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 06:44:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 06:44:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 06:44:05 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 06:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL5XzXcz8j7muMPRDbgeSxhnNy1eVPenqTX+Z3jtyoNPFrs2t9wrroremByTr1MW+5dg/ALDEapM7C205yPfIJQOTrJ7MWWafMRUCsb5VLlfhBtujh4hrCSlv/ahpcYUNAerZ5CwhWu8CSGy23CdWwKbvqx1ALG+cMo/jla5kjGlS95Mn69SubCFB3bZsw7vWb+P3hLDUoZ1aWSKwfNrKkhoiLEATNMyiV7kd7uxqIs/9IjSTywM0LZUZXoWuxZXk5HmMoDXbwWT56REtw9VukToTXpi7a6vtjQpk7nw2BjTHRS07f9I+ry556uqCC4ovxXwJ6AHbB4DNPUk46aFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9AapEic+rGaIlmnCjQhISTsL0p7ccS75yqnkKgRc6M=;
 b=Be9WmYfNvmo6OWalJ8If8MpfIS3Sc26m99iFMkgw2hmVaj6J9TmIL3utnQ9MM1dtvzHlo49nZhdvOeAMYn7EDTzqlV1F9OGPp//J2gn8kqESFsQlmT9/F5rkiz705+WASWyvqvC13kzv/tPzSd0AucA6+5wNv78Yx6cuxRhVHd+MMic/aDLc1WPIi3WZx6k00OueDb8m4ZcI/QXncZ0BAG4sXUkE+jNCQQ2+oaXNzQQLO/BSN72zUNTGz//q+NMIEqaG764mu/4Tt5qsISKIpCKPYOb0Rt3XB4AfyrAC1avWjJE0nVqreEqTTShXEq2rSrl/01Rr90x6A2Wt7meHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:44:00 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 13:44:00 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Janusz Krzysztofik
	<janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH 2/3] drm/i915/gem: split shared memory allocation table logic
Date: Thu, 25 Jun 2026 13:43:41 +0000
Message-ID: <20260625134342.1102921-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625134342.1102921-1-krzysztof.karas@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4480a863-6bf0-49cd-bb73-08ded2bfcfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3gpESwtRS5Tb27TwRvarE3iBWmgmMamxfISfMH/c1tiPDJb8GkBbGUkQuvAs4g8N7TaXJi2jQKMVr4RoTyneq1Pd6xCGGIx44H7qewqeQkmBfjjPWcFeRfDpoRI9GDvBlZwqfN+rYsO1BJpJ7IdUZVD7Z9HQuliyOBZ9W5U4uEHvNogy9G6mR6PpvGm7fDU1ljWy4yAOfQgAvDeCvkRnxyhPYx3Btl9mmp3D+NtXJ2glpf546Cc9Z4ZQENgsc2oSd6C4S3uMl48yoOGzr5dDXGy5N400X2kj4mIsFApvybXnjvxquLq5X9Rit0e3bN23rWsucbMcqQd9DBZUw6KZneNkieg6WRuy+SPWaNFj0a9zq7j7Sy+4itBBGI+q68bI7OO49MFkerl1nxY399kgNZce7FQ7NekdXd38mmoV2qxL+Gjb0LM7ojv9ogd23Ldx9UWfI4+aqu678DgaxZTgOojN0s8PIfipA5yplM26uA7ioxn7cTWfhY3pReXkRl9444WZVxzw9L1fhXr0b+VY2s0c7TThSGppHnD/BSODMO4dlWss6JfE4hSiKq8sWfXWIUYePvtTn2L2MSsmXfqndW0jMNcXEPUxQ0cqvMtbJgWo/ZPqSGzpg/hDUKJ0QatzVo6HdOUrC05rgBKZnGcAPPA3DxgbNWyP5/CL1o1Wj6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gfg3980IDvBfobxURToNApcwpobmtFUccXniBupbFlUAdtW5C3tusw92Okj?=
 =?us-ascii?Q?ox/C972N4xnPAxnkn4A55n7jcQSSatOmleuLI/nwOYi+YL48zogE6mAEMryr?=
 =?us-ascii?Q?7Q03m9KGGLeygHxOPISWKNkRprLqNTHKdX8FwwZ6/BF4nX0HpAjvSaQkXIFZ?=
 =?us-ascii?Q?MTCSyI2MaqU190JuN+pjm3DtTXL2LGTOq+8dDkJAC6HhjMQE15CBWpw0G1N9?=
 =?us-ascii?Q?X7cvaQkcFwY6/7SOZ/6HTOO3SoGCqMzfw8odFV87s+ikWjlqQFQIrP9V3pjZ?=
 =?us-ascii?Q?bkkzzjfqdNR3IMPoxcbs0xHsmuVmIwjdKc+vfdyR/juNozR2uNEiBcZZVcy4?=
 =?us-ascii?Q?IoOm+QFPxxFZqBOX5YIU4cxyvZueqHrz19lLthRQuQYSAcaGvzBmsmmB9tmJ?=
 =?us-ascii?Q?tzrbKWErjLMkfI3NwX2yACWXXUvHmoDQulfPW/MqVREnetIU+FiiQDN9FfBn?=
 =?us-ascii?Q?WjSCLUhAzUVCA77qHxv2AvN0NABEetCezJ10kqcwyvX95HdK78Ybck4YJFFH?=
 =?us-ascii?Q?iA6NHGc65+d47gyCj2PS3578pUjiSxbMLFD9IZvO7BAWoSWv6D2tdmix8owp?=
 =?us-ascii?Q?4XZQd7+sYMSW6WKYVjjPFoPP9nmUKvABxNWEGUSANrmTBNghje1fR2NJDEzr?=
 =?us-ascii?Q?7LqhqiYRlUZPODGcofPtwsibx9qs48IKBK+rnIxVf6IT5bm6rGijZo73A3Uv?=
 =?us-ascii?Q?sd/Ec8PtJcz3wOSRwGFaFLc7CacHHbSXgzuTjB5lyNqpxm6kLwmLB4M663cb?=
 =?us-ascii?Q?cgINtWwmKNW8K/rte6uzh2HPUs5Tl09dhJ1lGoHzI4hbxwZ4R3UBEglwNE4r?=
 =?us-ascii?Q?dK0VzjFzcuzLmmhHJXzP5QPegCGVk3/xZIGUAu9uJKBQjOF7NV4yIoYIVCl3?=
 =?us-ascii?Q?0lhj5RkYkFXSclofiej18E2s/8ih9v8C8wmPgmAVTEMW8+484l1HDbE2TAHe?=
 =?us-ascii?Q?PiBtb1ifXBTlGixSj+/fehTS2NTKpAjc5kjFvrgS3W4t4d0FEEwm0tgWtyns?=
 =?us-ascii?Q?OjparEZKhYEDHhtf5hrj4I4bdc4c9O0BBXDim9spOpDTtLRgFgOQwN/Cdfx1?=
 =?us-ascii?Q?axKb1Ef9dn4Lq+twQeeoSE6J4rKn7ck/T4JLgdsmbeHo3c/JS6nwlcOfU+p1?=
 =?us-ascii?Q?PhPJpnah4WVYHMiiyC6Rb+G2jx+TZBN1393sqENfegnqaqj4lN+eyH48wQIJ?=
 =?us-ascii?Q?99ubdvrIdyuE2NaBroA5eTnOzXoHgVdvxfOtOrB2Ca5KLOJbcGBDPYa5IwfO?=
 =?us-ascii?Q?ldGWJ/7Ni5D6sk7P5nE0E2bLYoKBsRrNIrX/PAwPRjB1AoXYdqFpUR/LSLKa?=
 =?us-ascii?Q?qVT9iA03G7yvSKiUIJFiztAuf+2fPBXt14E7IuBlEy0iyy7NsK+WLH8FkRaC?=
 =?us-ascii?Q?C2gAXKwzugxfje85+PCKvuZyAixaeSXUqsqwCB/dRZ5giZoa8W+vywtTrow2?=
 =?us-ascii?Q?eDnGEfqww/M3byQuoZciOvz1Cw+AVh1796CKjIg3+S6sdAWDlEXA15846mJR?=
 =?us-ascii?Q?Ya0jomkcXA95XA0EGVq9q9mZcsdxYzCrbStTzMxcBv2xT1cKTNLhLJXllZKh?=
 =?us-ascii?Q?MjbCjoBc05peCURqTVPgul107uVqqXyr3PNqUgrZn1vhGDnc/G3JCewKNvIw?=
 =?us-ascii?Q?SxUtl9I1jSQqqU7YGKlbvBaKDbYMXNxaLKGJwUZYOelGsCHE5PxBC/I7eFI+?=
 =?us-ascii?Q?hBHSCcLedYJdIGH5LaerDLc8Do7c5k5pPqvbrDV7fuAHEdxlnORlf3pKY3iE?=
 =?us-ascii?Q?eRKPY18GSSgI/75t+th/muTfyfV+vxw=3D?=
X-Exchange-RoutingPolicyChecked: R+4C8FWW0ji/zxAocpFCgdsX+xl/7ezb6A2oHH7YBUcELhZjRZSTTHUj+517Vx7KFyKzYYngEc8QXomT37NQp92JG//6YjuL6nBlfUUxUd17MmdqjChI2Mj1OZlKW2l7D6H8a8x/gymgzgB3pN7bf4SIJxxawjYLuB4up66IvfHAF7a/k/SAHQoimrOQMCu5+JtdpFljZTWuyyrM0/82L+TlrRn3hzj+XLv9O0hZQawHmxAGppq/DZtXzAe+jT7K07FKhZ9Y3tHvLdoQhNhd9UD8jsybKH6YTRudxA7k3XyP5evjGJ2FSu0/liM9Q9H6TIJPZl3fhHqK70r+/nL6bQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4480a863-6bf0-49cd-bb73-08ded2bfcfc6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:44:00.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR2IXFFhfR7Fhlqi6olq3nlA+BpPXIj/4+K49omapqq7EehbOT/cIQAYyWumVyAXkiCRuWzXC+e1b+kVtLqAzxHJKVLL7OkCfMQDheyBhSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com

shmem_sg_alloc_table is a complex and hard to read function.
Split its logic into smaller pieces to improve readability and
reduce indentation. Change main "for" loop into "while" to get
rid of obscure iterator "i" and be more explicit in traversing
scatterlist.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 176 ++++++++++++----------
 1 file changed, 100 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 06543ae60706..b5ae7e5f80a0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -62,22 +62,12 @@ void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
 	sg_free_table(st);
 }
 
-int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
-			 size_t size, struct intel_memory_region *mr,
-			 struct address_space *mapping,
-			 unsigned int max_segment)
+static int validate_size(size_t size, unsigned int page_count,
+			 struct intel_memory_region *mr)
 {
-	unsigned int page_count; /* restricted by sg_alloc_table */
-	unsigned long i;
-	struct scatterlist *sg;
-	unsigned long next_pfn = 0;	/* suppress gcc warning */
-	gfp_t noreclaim;
-	int ret;
-
 	if (overflows_type(size / PAGE_SIZE, page_count))
 		return -E2BIG;
 
-	page_count = size / PAGE_SIZE;
 	/*
 	 * If there's no chance of allocating enough pages for the whole
 	 * object, bail early.
@@ -85,7 +75,81 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	if (size > resource_size(&mr->region))
 		return -ENOMEM;
 
-	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
+	return 0;
+}
+
+static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
+					    unsigned long folio_index,
+					    gfp_t gfp, unsigned int pages_left,
+					    struct drm_i915_private *i915)
+{
+#define MAX_READS 2
+	struct folio *folio;
+	unsigned int i;
+
+	for (i = 0; i < MAX_READS; i++) {
+		cond_resched();
+		folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
+		if (!IS_ERR(folio) || i == MAX_READS - 1)
+			return folio;
+
+		i915_gem_shrink(NULL, i915, 2 * pages_left, NULL,
+				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
+
+		/*
+		 * We've tried hard to allocate the memory by reaping
+		 * our own buffer, now let the real VM do its job and
+		 * go down in flames if truly OOM.
+		 *
+		 * However, since graphics tend to be disposable,
+		 * defer the oom here by reporting the ENOMEM back
+		 * to userspace.
+		 *
+		 * Reclaim and warn, but no oom.
+		 */
+		gfp = mapping_gfp_mask(mapping);
+
+		/*
+		 * Our bo are always dirty and so we require
+		 * kswapd to reclaim our pages (direct reclaim
+		 * does not effectively begin pageout of our
+		 * buffers on its own). However, direct reclaim
+		 * only waits for kswapd when under allocation
+		 * congestion. So as a result __GFP_RECLAIM is
+		 * unreliable and fails to actually reclaim our
+		 * dirty pages -- unless you try over and over
+		 * again with !__GFP_NORETRY. However, we still
+		 * want to fail this allocation rather than
+		 * trigger the out-of-memory killer and for
+		 * this we want __GFP_RETRY_MAYFAIL.
+		 */
+		gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	}
+
+	/* Should never happen */
+	WARN_ON_ONCE(1);
+	return ERR_PTR(-EINVAL);
+}
+
+int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
+			 size_t size, struct intel_memory_region *mr,
+			 struct address_space *mapping,
+			 unsigned int max_segment)
+{
+	unsigned int pages_left; /* restricted by sg_alloc_table */
+	unsigned long next_pfn = 0; /* suppress gcc warning */
+	unsigned long pages_done = 0;
+	struct scatterlist *sg;
+	gfp_t noreclaim;
+	int ret;
+
+	pages_left = size / PAGE_SIZE;
+
+	ret = validate_size(size, pages_left, mr);
+	if (ret < 0)
+		return ret;
+
+	if (sg_alloc_table(st, pages_left, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
 
 	/*
@@ -98,73 +162,32 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	noreclaim = mapping_gfp_constraint(mapping, ~__GFP_RECLAIM);
 	noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
 
-	sg = st->sgl;
 	st->nents = 0;
-	for (i = 0; i < page_count; i++) {
-		struct folio *folio;
+	sg = st->sgl;
+
+	while (pages_left) {
 		unsigned long nr_pages;
-		const unsigned int shrink[] = {
-			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
-			0,
-		}, *s = shrink;
 		gfp_t gfp = noreclaim;
+		struct folio *folio;
 
-		do {
-			cond_resched();
-			folio = shmem_read_folio_gfp(mapping, i, gfp);
-			if (!IS_ERR(folio))
-				break;
-
-			if (!*s) {
-				ret = PTR_ERR(folio);
-				goto err_sg;
-			}
-
-			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-			/*
-			 * We've tried hard to allocate the memory by reaping
-			 * our own buffer, now let the real VM do its job and
-			 * go down in flames if truly OOM.
-			 *
-			 * However, since graphics tend to be disposable,
-			 * defer the oom here by reporting the ENOMEM back
-			 * to userspace.
-			 */
-			if (!*s) {
-				/* reclaim and warn, but no oom */
-				gfp = mapping_gfp_mask(mapping);
-
-				/*
-				 * Our bo are always dirty and so we require
-				 * kswapd to reclaim our pages (direct reclaim
-				 * does not effectively begin pageout of our
-				 * buffers on its own). However, direct reclaim
-				 * only waits for kswapd when under allocation
-				 * congestion. So as a result __GFP_RECLAIM is
-				 * unreliable and fails to actually reclaim our
-				 * dirty pages -- unless you try over and over
-				 * again with !__GFP_NORETRY. However, we still
-				 * want to fail this allocation rather than
-				 * trigger the out-of-memory killer and for
-				 * this we want __GFP_RETRY_MAYFAIL.
-				 */
-				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-			}
-		} while (1);
-
-		nr_pages = min_array(((unsigned long[]) {
-					folio_nr_pages(folio),
-					page_count - i,
-					max_segment / PAGE_SIZE,
-				      }), 3);
-
-		if (!i ||
-		    sg->length >= max_segment ||
-		    folio_pfn(folio) != next_pfn) {
-			if (i)
-				sg = sg_next(sg);
+		folio = shmem_shrink_get_folio(mapping, pages_done, gfp,
+					       pages_left, i915);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			goto err_sg;
+		}
 
+		nr_pages = min_array(((unsigned long[]){
+					     folio_nr_pages(folio),
+					     pages_left,
+					     max_segment / PAGE_SIZE,
+				     }), 3);
+		if (!st->nents) {
+			st->nents++;
+			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
+		} else if (sg->length >= max_segment ||
+			   folio_pfn(folio) != next_pfn) {
+			sg = sg_next(sg);
 			st->nents++;
 			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
 		} else {
@@ -174,7 +197,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			sg->length += nr_pages * PAGE_SIZE;
 		}
 		next_pfn = folio_pfn(folio) + nr_pages;
-		i += nr_pages - 1;
+		pages_done += nr_pages;
+		pages_left -= nr_pages;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.34.1

