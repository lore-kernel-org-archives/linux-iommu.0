Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439D2797B5
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137020; cv=fail; b=XnFnaCdGGDa6PlAjohe3kKU0ddtB+pNCdIw0vXPJtT9zbOR6rMhg8Uz0Q4b+1iCko5SW0VDpj0nAT6ifWVURxxFlfEZkjURsAj7l1f+ruISzdAiI9R5cfbodnFfDwgXQHahdlkL/ZeNhTO3WM5eOOYYMaMlCWbSmtpDKlFrlR+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137020; c=relaxed/simple;
	bh=CGfvh9L/mJ0llLiB3zEoJ3LvYeej6hbEyqsPufvoC/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rLyng3gRqhC0gk37aY3ClVRhdcXIlGtxQ6IqzbMtql74W8vdqJb+v0uCzC+OkbyPF57JccF5vnVZ1oEV3PUjm6le2T9irWPY5glPUT5yJjRjGJYvSVFkBxnQgQcaUXF7L5fXcUdW4U/iatjoY+oo2wQxMaW9Yk/ECyc8UGrA2mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MVUGGMHT; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MVUGGMHT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKesSQowCna7fGso8OGlmXl5uR1w0/B3fr29JTFtg0v3f1/MgLsUAr6nNfHQeqyddJb/5Qpgo8FQ8HfX2ryiUN89Ycth8jAzNEPHloLtzMNn8kN6OS9pCNSG2bJXcbVS/q7YjvoscFjm4YJvVJl9NE7NOqLBf2OJIjTe0JzViLoWZvkqA+4BDzzETXhCKTaN5ZBn/VtTQ32O0inlQWn8Uj8KJnKrvi/uC5rCWUK6TQYuOJ/kb+dtYTDbs8w9iyF+S+ELFjhzHTmvyOxmTxIK6zRnn615YZiVc0Ze6vjmxRsgKD2MOZvSC4mwe+N/qy6MQp5MqnaXDxiGggI5Yq84qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwgeSuAXxWIm4kfhycImkKB0ij7ceXpXagAPWK9PWr8=;
 b=zBbCojrfAWDIEnPK2sPzialpKMguSlNRGKT6Nv9TCtHIEvTpcWJk3xkhpqncuCLXV6M1TZB8mUnRlDbYoQcbyB/q4PZ2eQ43dw/Z8bTWSK1kTT8odSW1Z+xCX1Pgdf0u9MpSq8riaMvXFteYrIpe/dVUBAk4fO0wMoTXDVRH0oK3/CGJstKbNK5o80uvhWQ0GELA43sp3txuayhislOrGoZTFtZVhhahGPPR4n3TYUnvpSJDH07uRZXGKfA5ESzdAOjcYMKTu+KJcjDVXtqw8m36uNDkhhd9Og//lBOSY5D+bL2eWgnVxv/fkHRm7H/r3GsKsg0tkpfMXO212zQ8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwgeSuAXxWIm4kfhycImkKB0ij7ceXpXagAPWK9PWr8=;
 b=MVUGGMHTYYuIE0q6A0965hK5kYDp+Kk8LzTdKlihaeRYcSrzb+4zVRhmHTDVLMNIX/n3YQiwMqaV6j+HGKD3MDDI/XY8p082emuc8yhJCmIhXYHekm+h0pD66JpDnSH9vTOZYWK+D4jWQInoOCAPoaIW9ve3Ia6YhjgGbdpgYU4b7Irvh5kcZtWz4zU1KYh7xP66fYR7nRw5ZqZ+xMyPznin+Mjxy9UN8I6Ui082bbfMp3zmFFi2pXbsSCBnZWK0x47OKbCU90Xhv7ffMnjhWNF80uFABWZvUB70Den0kMl1cZVPek4ocLf1WXubiEtlBLZuzJwiBB3+xsU2eIqwUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 22:56:54 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 22:56:54 +0000
Date: Fri, 10 Oct 2025 19:56:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 13/15] iommu/amd: Refactor persistent DTE bits
 programming into amd_iommu_make_clear_dte()
Message-ID: <20251010225653.GN3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-14-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-14-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c16e24c-6b52-4014-4ec6-08de08504eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gwv5C1Jj/SKqQzx1iMrLiaBGw3vVfezd4wJF+TjqAbLfXgianu7pgkPiiiyk?=
 =?us-ascii?Q?yJuVLRPDSeEltfq+wIZka6ttuKx8Nw5G1uEjhGQj3/hLCoRsneLkcYUcfBn9?=
 =?us-ascii?Q?5glDfd8n8RKyhNX8StUY5hEqsHWGvCfAS8ZTEd4D/xzgBRfarGOMyQcY3W52?=
 =?us-ascii?Q?aD7SCPNHOpGK+2KVCyKXCf2SmIEUXu8p5SwZAd61sE0ySoKj4/jiu9FtqLZU?=
 =?us-ascii?Q?9Bl+d5A6YoFYZtNpo0rhtG81tZ6cLGokV1e9hHnUXXg9r8nJkv9+edC80ti3?=
 =?us-ascii?Q?mM+4+/6TEVffNMhvzhy0Tw0rRCOkWe1CSk1BR2UXowfFGgXzktrV0BJgMeA6?=
 =?us-ascii?Q?FDlLLwSv8Ry2eG5U63sSBjvaoaeQRSORsajyg2G3ByWAdWuwKRqRmpVroSNx?=
 =?us-ascii?Q?zCIhFbx/7hgxOJCim7Ny3cE8H1fOxsqSir2R0r6DX85EKKrN2GGVD6oRA3Os?=
 =?us-ascii?Q?+gDuapbb7UHVpX3P67JDMtlY5agjJE5GG7fGnqeQhg1PEbV1UR7sRmgtl+M1?=
 =?us-ascii?Q?wjNrFgzGu49A9iHZw4em7J2a8zd+Y0KCsRPWS2NSQ099QsAwEtXJyFBrp0iQ?=
 =?us-ascii?Q?Wd5q1QMA27xOxwXcJXP7JPGn59RIQEeGf2zIi4CqWNps0DWrGovSvvjhf7ke?=
 =?us-ascii?Q?5Nb//vVpP2Bkecz/NoT0W0dg4VVpJEin5Wy0ouQXr9ynGA9SvHWQWiT3ROaw?=
 =?us-ascii?Q?Lg9C/IQm14/29t6gctNyLPO3Jghi0f1OcoKNNY/YkgHPtj0EyK0bUTybnFNV?=
 =?us-ascii?Q?EP/+hD6Kj64DUnzjjjP9j8gudmCcb9KiKPmdgICmGaE+0GbJHcsazQEalVLL?=
 =?us-ascii?Q?YG3zjXTevuZufl2YKu6fbeRXbuqAP8zmAn/X29rRINMLTWDeT2hwlryThLtG?=
 =?us-ascii?Q?CBEpFx/Tltv8inCpTNv6lcUMcEd3Cv7riVpHu3/qr+YF6sPzafZ8RdVu6LF5?=
 =?us-ascii?Q?Yv5Q7sT565X9mmxGX7Qe79Og5SAs77dtNtRIDZ/xBA020whN/ctSWP/sYp6U?=
 =?us-ascii?Q?8A7USfC4Bf6WR5AEWt7nrhM3y3Uso7zmAz8/DCyql8dEsJdCDdheIdODI8B3?=
 =?us-ascii?Q?XdU2XIjn2uuw2K+ESPmg4QHar7Fk7V1Stoqe+c7UDTtYqpeFiDAafyEH4Rtn?=
 =?us-ascii?Q?E0uYc2b+Qnx/TkYtsHLYx85iW2AXdijKOtnxVsWpkzu3BPtUQ9iBEBsIrSWU?=
 =?us-ascii?Q?9Vi9qdkwKaS1zsW201tFmn70As4MEKzzgOKv/TKLt1eUIj1yiR32zwqxumwW?=
 =?us-ascii?Q?neSsct0WEsy4xNzPOqUHsGvLVwdM1+MNv7ed+lQ0rzYX/rvBAwCQYdZvwlXu?=
 =?us-ascii?Q?rywvQXhzX0GT+ZC1X6uYkNIhH+IxXV4Nn61d+DLHkOm/4zsUlHNp0RrIW5Ci?=
 =?us-ascii?Q?iqbNj2JyHlLA2IrqTp2+GPsCY1cE3ZJYkTiXx++xN8+A6KngtrF9WlPg36KA?=
 =?us-ascii?Q?yM+r0UI1suIJ7gKBtqgy1I3XGRd+kLZj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOCVGim8DOFfuQduyRbYPOfrMW/SzpVREmcsOUJW3BAAlGym/E/z3tP9quDo?=
 =?us-ascii?Q?ucwmn9yxi7nvpOIZSkaDaAri+BToh0LptIKGb8LSpAbg67WsCkK3aQoWNgKj?=
 =?us-ascii?Q?E/dhwNe22t3RmJEPAhMTPup3/ETEvsKYXHXJ31cy66OTBmY/HN4+337iAzbT?=
 =?us-ascii?Q?L1m6mcbDmtMCm8d34LAZrjfMcMRU7MVVxdsEo1SFGHM0+DnzdE4rxEmf2wdE?=
 =?us-ascii?Q?3Pl0x2Ze7QE0DxyxeLNMFo6ijbMk2pPwxTD/aJaKymisNynpfR9R47Gh/OiB?=
 =?us-ascii?Q?KhKwMcTUHe+PXbiXvtpqCPPu5fGfesT00NJjtrpXnlkdRpW4CMD8GqXEW1UD?=
 =?us-ascii?Q?5689a9B8K5Wq7m1Jku+I4/IkIlVqv8eo+LDRmdRj4pkP8u+YIxd8Vb2vJVAi?=
 =?us-ascii?Q?8+LYG+nvi+yqykpuniVb4EBbc3oGdYD1UxcFII2/SOOcWmJw8vjxDGwbycrd?=
 =?us-ascii?Q?ozJMAWCn2rkGL9mZu02KdbvPYJP8l7Dhm25ps3PN4V97/aQkI3wJBPC8j4SW?=
 =?us-ascii?Q?ecsJdn++uhg+GPnBubWfvk/TFQCOA3QB+5wMGEEEOE7K6QxA0sWQ6aZCeA8B?=
 =?us-ascii?Q?+1Igt5gfrjGBWPoEqE0/39r1GM7JzDfRfgvxkuZLIYJtkCIHF7XFKzBDQise?=
 =?us-ascii?Q?gNuV2C6BlzhbJsQni8+3dEZRsQcnwFkBTITz4hMaEjQ+RXT+Iyl0Lf0KJcKk?=
 =?us-ascii?Q?aHeSp6oxxI8pRBISTd1tNX1evSttMu5JVWROuzvxlZxoYsRihaiz4O5Yc35l?=
 =?us-ascii?Q?CCO+Tm5A9kKIrJsdZ7GUhnB9fGo7KAafrPWePrHplYfjWfThdxoCEPTEROjz?=
 =?us-ascii?Q?CgrWnakVzm/Qsjtt/Dk47JenvPZXhuis4lJiqCwqU0MqBRS5J2L9+80cC6u5?=
 =?us-ascii?Q?dNlGLRLwvoyLisLZmjgXiwuqP0vH/bFxVQOvBgfumpJyR0ImJ6ZpfpAWMVgc?=
 =?us-ascii?Q?ADgX6wVfHfQeMxQjuE2obWkwp1pYhItJ/ulcjrwA4f16UuzyP7z955MKV5WL?=
 =?us-ascii?Q?WnFtJ5DfZzF9Ucd550e/sCIzsNRjZxFihZUHdw3EQ4j0Ffjh7lEeOxK+LSr3?=
 =?us-ascii?Q?44vhmd35lNsiXSTcYfH7OadxyJBy6j1K7zwBzSenqIfy13rhitYYRG5um0zd?=
 =?us-ascii?Q?mlFgazQN44zgCNMll2R1sccHBd4EsDUHI8sm6uFJtnppuJ/1Plk+uQ9m9HHw?=
 =?us-ascii?Q?K2NEC1LYIKCcUrNxGzC7A2GuQMTfv91WlN8KxzvN6AzXw3R9hoRUZdilC67q?=
 =?us-ascii?Q?fWAarMR31yP5HSveFTVNZPzI1uBPwXSVMxIyUXmbtJivjhh1rc6X33KoPOkx?=
 =?us-ascii?Q?9KAM5harAxV/ejtf6TRky58vkg0zv9X9M2iSiMB8KhESBDfOPzl0WXbPP/Zn?=
 =?us-ascii?Q?Ph78rKT6M4ZuuVPKpHTsrteq4nIsTozFObVMSIf9B9kl7cU26l06bSs0wdhr?=
 =?us-ascii?Q?YST+t+NxO+7mYvkL2lkRfhFwrljh6pYaKmlgMlrM4cyJrdb8bculIy5G1H1P?=
 =?us-ascii?Q?U4zq+vIc0Pj2ylezfbsQ5yUfk+hAP/O1/gK2see6m7JndCIRh1E4BwjE5NTT?=
 =?us-ascii?Q?0xNG7JpYBjBhcXEjq8E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c16e24c-6b52-4014-4ec6-08de08504eae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 22:56:54.4789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWpp7WlYp8YE8Y6kkt6fqpdiELKJEk1XMCBrVfWGO6wpo8j1mr45QwWnh3m+MnsG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On Thu, Oct 09, 2025 at 11:57:53PM +0000, Suravee Suthikulpanit wrote:
> To help avoid duplicate logic when programing DTE for nested translation.
> 
> Note that this commit changes behavior of detached and blocking
> modes,

We don't actually have "detached", what this changes is a small time
window while the AMD driver is changing domains during attach, and the
blocking domain.

> where DTE bit fields for interrupt pass-through (i.e. Lint0, Lint1, NMI,
> INIT, ExtInt) and System management message could be affected.
> These DTE bits are specified in the IVRS table for specific devices,
> and should be persistent.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
>  drivers/iommu/amd/iommu.c     | 11 -----------
>  2 files changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
