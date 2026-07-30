Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895B36493F
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422714; cv=fail; b=iUvUpZ863zZ14YiaJc+lFiSVllBW6tFEdKTbJXNisLJX/e1OPbBhqh1CTltsFzdsjJXYC7fJVirBUT4exhwLjHSHo4f6Hk27KCfZ37Hay1h8+h4QKg4VjYSapPIYeoaQXxmpw6J2DKyidqXOu1RgwgT8KsykkS67X8d2o54Vbe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422714; c=relaxed/simple;
	bh=YIh4A9kDIwpo+LlmhHNNa/WSq+a7eN1c+eSbBjx+7Xw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9g4BwkpB6jMhCjae32wAh/pR5qOVHnXLZR7+pBW5Lh91KmNyrFQH6TX3GHlcq/0am+Psrfegpud2Cf56ZmKJqtDRHM+9Urkcy2Q6RN7qjrtEBWUudHEp6MrLVxMUOAntg9FjodtzBtlhfsilD3oE8B2AZgNYqwvleMptbQzWI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bEkCqfWG; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bEkCqfWG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeDw/bb+guA3kn85Hx8OUv/DkQpry0OJjU4G/4kgHP9Oc1YVsxIh28dDA8WmuXC23miFxGeOBAkPLd3/gV8z90Yx0C0ZrAvuge5k/J2v/wnpHB2X7HSiMfWAT3uB2aIbIGenaG03W17sveIqvbOLRkrA0sMWbV4f+Hm81k/sYronc5FMkc2OXiQLC/wvnMWzpH4fpzPtbdEleqWKYjN6b5mCgpOj5zJrEPXYBCY4rFORjVnIEV3bfYVDA0PcswU3yUwsv1NiR4qsy+xrm4Oyl632RkdpN+FUxXjrSfeprzwtM/Ca/H0hYadc+ynLWbTHe6pavuSviTATTDTaOKs5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF517QP8AS3+3yTa9jjefecQNX/Hib76FUzh/rkGqUs=;
 b=noJjPbk8hHtEeKbJZ4THnS+E5I5ZkPiBnnNCRyKPWrKOmpXSOLMPLBKtk2/Ycf928rUbq8YVUc95fXFWcBRlkpDg/+vtvp1VouRxkFswYFOYYKQaLujClFY9EIq7m4mLZU7GE4nJKDPywX6exxGfaWIIgjor1UrDggpePc80HzWzMV/qSHwdD77jRQjR5HsgkrDUBnTEoUu8C9t/z4MPZNu75DQMamIMgbBWlwqzvjKBnM7St7ZsH8KOqB7uaasmscEsvswUlL62opDjjA1/ifHmnFnaWGkPz+5yoMy7wWL+FYT+ZMjGljATtqOYFWgoa70eVCdVmFVBQODPp9xdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF517QP8AS3+3yTa9jjefecQNX/Hib76FUzh/rkGqUs=;
 b=bEkCqfWGb3lm0EWzTlIlVJVBIp6sKup1JDXU2e1hDpQG687QWJpxuppnWyGwGZFbXuCgnGjW3JcnQTWwM6SfbBLK2bWz1BjERkAYpSUBvhuRwVWcsjJFAa2Z9EA/5RStr61WHxVIZCkjbIwS71YSZAjvHWLDP4fd2X/e6pAh5GQ=
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Thu, 30 Jul
 2026 14:45:03 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b4) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 14:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 14:45:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 09:45:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 09:45:02 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 09:45:00 -0500
Date: Thu, 30 Jul 2026 14:44:52 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 0/5] iommu/amd: PRI related cleanup and fixes
Message-ID: <chqv4spqefbykeaf53oubfvpge7sehhrkqgtya6urfubl73qfd@c3lus2mi3o6h>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc0e6b2-1fdb-4980-168e-08deee4923c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VbPLccvL1dtDdDqj+gN6sEgDEBN08b/dNClCijMFvBhEiX9PH4ctKrJwBT+oYDACSlYMGjCIcyhbEpQOJuddX6UEWk29LnLldqtkza8pxn2kk1VdogMagOrfSNztx+s6IlGHCCBiw3bBr+BJnG3Dsjpf0X6+uSSJBNzboPTVePagDeqyankfIY+mwCdkiCnd6PPSxlUDU0SNUTXYAIWSS4R2e1fZk7FrCeX8NQ0DNhCOY5CxUH79XjJzjjklF3snmaqZaSV5GHB/ljSdLpRfJ7VqgtR0ul4DTEedr+92X11DNT6pRhD7A1PeBPH212kkhPbnlJ6nZnpHCAnRh6pdutak2RNmV41FSyptYuRgsqwGlX/OGFGELVj8S5mDPrdpYUemFGeGe/jhrFBqPewDfyf7xT0b1YbXx2zTwvyymXmIFVX2sh1MGxfkIEX85BbFc+SutCrHVev1iCjo6is1KJV1/4jH3WId5a8cKSm4FOHeZ1gLWq8883+VOPr40MxddBled4qTFyDfHLJC3r5CsyGHGOap/O6J6ELDXVAt59lplSX6xtmDbDr3APb8u5t/R3cAxoOdmttPTNULWtSkcUijUWRX4mp8UrRUjr29O629lLOPB084cFcRogEs3Gk8iT6tP4Xfoo0zIJUtej0p+zas1hKDeLCGMJUdUyJL3ir4cb2PQPqxliOhFA15G6asIe/fUoc/fldNq+rP8HUM1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7pJzSGfYNqiE8R2lN3HXV4wwTIF1pD2L/5W9GL7B4fspi02p6w5AEJd9GyfBS1+Mu5KhLhbIh+metBqKxabuE9z3m/a0JnbwJsRBaVGvKvDy6XGGEnnYISatdChpkXAI4aXw8vU41/iMvvmVREyFhylBQw8PjWEhoX2COJ2Z1/xFsqyftSLUJvMwQOqTGdaohVh66tQCP8vocrqdZoqLzLHdVUp/aHEo8TpAPg77YeL5hApOBt+wgkUcSQeFcgyzn4gl7eQwXt3xhe4eW9Afn4/rLFTVMwrpo1jssyIhx3oLxsaZvIc93wQel814b+sq5BQi8XEA6TV+KLHm74h4uTSLua9sm57A2xLyAQQguLgA3yJrxRdR8R8hJDnvaipjDsvRXRYk32S8D2YN8yxgMukRy0ZkmGK+8mMA/h7D+wfx73iNjn460J6ttLPgQccw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 14:45:03.2801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc0e6b2-1fdb-4980-168e-08deee4923c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On Mon, Jul 27, 2026 at 05:39:02AM +0000, Vasant Hegde wrote:
> This series does few cleanup and fixes to PRI related code.
> 
> I will have followup series to re-arrange PASID/PRI enablement code
> and then eventually enable PRI support without PASID.
> 
> 
> Vasant Hegde (5):
>   iommu/amd: Fix incorrect device ID in invalid PASID error message
>   iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
>   iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
>   iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
>   iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command
> 
>  drivers/iommu/amd/amd_iommu_types.h |  5 ++-
>  drivers/iommu/amd/iommu.c           | 63 ++++++++++++++++++++++++-----
>  drivers/iommu/amd/ppr.c             |  9 ++---
>  3 files changed, 61 insertions(+), 16 deletions(-)
> 

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> -- 
> 2.31.1
> 
