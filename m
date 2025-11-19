Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855102BE04C
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560031; cv=fail; b=tFtlEA2v7BXDpqaYY69MvPnisTgzEsUOkggxVR0STESilJG99/qZUzLILLUFW8bikPcxEh+Iuu0djpP5FgENbT0HZ0nGmGhi1pZs8dSb0wD4bELEfZsFVUlTthzB5l2yzx1YFAysl3dhrVBbH7wleKfXlHxEzKcuBO/HJREpdXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560031; c=relaxed/simple;
	bh=krEeyt/Js4czwpgsjB7phUHbevd7CYcqLrjKbiPpw9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q/aC21ihkSrW2jtk6voZJaQfY0DE7kvSomHwd2TvoY3c8DfU5IHFKFKay1C9UxvjuA7j+QeqOC0nI0RYmTxd8Uv4ca/G+wkXe3J5TTz0BpKIH1lrdXJkI7lFWzsISy9VBUK0DQ0mG4qfQRc4ePetb/KdFy84nRu8DoHro7Vaup8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQzcFYPJ; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQzcFYPJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKhmHKXtPdHvCNeG8EJl4Wda0QMuwXtv2pA0BeiqEewGJssNO383/l02LS4BhRcNrmrPcvxvgQUPxIlieN7mYUqlpU1Ob/pMwDQp0mbvdzqtrF7qBaf/jYL5Cc1/mRfNqM5iZ3sN7+MRQZ8BYQKE7lVSLvOVaQFFvNuN/zWaVbF8DaTQmehNdYyLjYAHJQD934XVyCLgQT+KLG0ZwVdUZ2/B3kaD489ZS69iAWrVrKSuEBsWapcZ66bUwxtNJpFnLePi6jReYYL82rk3hG71TFg5gXjlKrmgMOUbqlT4lVI6P7S6ydqJq8iUKqqpXCV8ymyysircsygNTjcw+qzuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3ESzC9tFDVEbasecoDS3z2syw+EQcz77LP7QPNbdL8=;
 b=WTMLth9xikuGv1PmKFTLkgVO3kZ95I3gd+jGh6rfToUq24ZPbD3YpP+hY32IS7pvOBometjUmJv72ymVAG/r/aAgd3RaGjHlxfYDeTbr7QBexnQyEiWjOpv9FZPuLqC5+TRT0drvjekKIiJJ5fk0/6niBRRLXReEf76/yXsstV+MjbUIDJCvDWXV94O2wHZYU8xqCzPeJHYgeK2F+Y65+GXmniFpanyUPF0B1GOI23ONmW6aC+cg3tSXItdD92n3FQIV5JeI4LUPxXWJYsHpCghUiNIkYI/F03jNxEetbJbeyiht5rpj2VRHtg+G6Svo79fwXVxzNCWFBIZjMx3RSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3ESzC9tFDVEbasecoDS3z2syw+EQcz77LP7QPNbdL8=;
 b=nQzcFYPJjvWFQpShuKbL0US/aaSnczAKEtA0XeyI+yYEQ/wbNZCfgx/SmJ7pe2k/Qf0NFhP5ZL6KvtFmHJGZ9PWa+1MjIdV4J9WPHTvs2hYbE15WER9LsB2d2JQm+PeuA7353p7QS72DdrfwD2vlXANb/OdspmZ7HqW1DRDM1G5M242PttabnfgnZ7WTUQuC9jhIjOObcpk5ZiCxzbgBXdSKYkQ+h+LkOc2aPxUwHPkrwYAtN/duuA/uxsG2/QHavUd6MOno470rXaxxHelkVsTi1wylTcFG1BnJSA2aox5rkcYlrcw07QSbuLbvOIwZ0Tm4mcen7Mk74H5rR+NfsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:47:05 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:47:05 +0000
Date: Wed, 19 Nov 2025 09:47:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
	ashish.kalra@amd.com, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH 2/2] amd/iommu: Make protection domain ID functions
 non-static
Message-ID: <20251119134703.GA135560@nvidia.com>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-3-sarunkod@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114104442.23296-3-sarunkod@amd.com>
X-ClientProxiedBy: BL1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:208:256::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: a179bdbc-1601-419d-ec9f-08de27721fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTDiRbIG9WRMVKpG3+4uAfJPUrnmhs1Jw5c+HiDO8nzC/6EGQILeqJIQgMdk?=
 =?us-ascii?Q?loq1pZC4uPKgMe7aCJOUNyVv0Va++8SbDm91VZ0tde48o6qvEApjozi9KjKA?=
 =?us-ascii?Q?izorQ8N0qPWP687Ygtj5VVb5kq6sdSFWMtLrqr2NEIz7e05FIg3c0BMZaog9?=
 =?us-ascii?Q?do7bwA740Hf5rZPr5j6dqkmq0iYD2WKMuRIpyMRGuSsVBNk75AjLzLtZ9Z3H?=
 =?us-ascii?Q?yLaLgMuO/lbdmTMQPL1igz8BMipdpL6Hbghf2DioyHlhOU6LUS4PkWY4T2Le?=
 =?us-ascii?Q?FNG3muH6IdpP/XwMS/HvQLrEFEWsOlzUgpRTDx//noRigDxva0wWvxBboxYh?=
 =?us-ascii?Q?P5WMPbsPDfPQbrUCAjzC2B0ca7+1X6ZiS981bJvs/H+8cmLN+777Bh7wVzwV?=
 =?us-ascii?Q?tFH5UUW4nUVhDVJYVVMk5rNjC7o5ysg7eXYe2xbFcE/Sui9x2HUOh3lrzcal?=
 =?us-ascii?Q?YaFI4U3ag+NHuvWi3KjhS1KrMSuEzZxAT9gXPiV3AxF7J8JetF8h0NApkpqA?=
 =?us-ascii?Q?G8ZGd55OnPk7L2lc6N5YAYuCqm5LVSy4aEsPx/Mjef8uKZ3jH8jZqDVe+xji?=
 =?us-ascii?Q?IO3R4ifnZATQKbtW+r78wdFYnn9lVaLRJeIm3vAlSwZD7gZbG8TAaaQbTkur?=
 =?us-ascii?Q?883KVi3fFHOB3JAg5sv1pbdhR81KblZQM1chDpmcPJhXd6n0hrBNVkmApLYC?=
 =?us-ascii?Q?SKHIk6W2psG9fqNY5ppVNuVG/Rmp/kmRwdq/WYphazn+X8j+M7Z5UBumlUEW?=
 =?us-ascii?Q?Mu29u+MAaYWNAjtae80UsauyI1cO0VmD7N1VQcFl016CRiGBlZ+LQ0paFQUE?=
 =?us-ascii?Q?hcCIRHaVi9itefghYtiocbf9AtE2Nn3uJE7sMpY16OumFVzM4djCxnFXgniz?=
 =?us-ascii?Q?b49aLLJBNv94Yv1lLMiu0OlnAWX4H/g6exy4DMGM3c08l24Y65WEEnwcQrhm?=
 =?us-ascii?Q?4DGWmOjSstdOJo2Y5GujoSNevH416RgWTInu+cLdqmO6Gt00Xk37RuE9jdWt?=
 =?us-ascii?Q?bFd2ZH3PHVPov1HylJKLCsfV03wKGmfVNTIQtA+diT+aG+1kH/CYSpZgZ6RP?=
 =?us-ascii?Q?gO70oe26/Y4/qgxZORdA1k3JDkm8Ncn2J0UFdr0/9jf3Dq7vkGHHdqmmaFj+?=
 =?us-ascii?Q?gFJTKfeMWA9nSmEU77TO1W8+TnRW+BewL1Ub/KCaNqSLfJ2fHehCUm24iyei?=
 =?us-ascii?Q?q49ldYyBpdqnpzn205WSJLmH7R9jJBpqqzhVNwp8YB21WStUq3PGkiEZNcYq?=
 =?us-ascii?Q?bzsE9PAF4q3M+MYC5LA+ERKmUG0GZrxGgOA2tPIfX5Z+uTD/YfZLd6Rg9vTs?=
 =?us-ascii?Q?CAmXcsyQYHyjlfrTXqeBjxoXN+qdogzny7U8RM/KFAEpX7DXR7vf37INhddy?=
 =?us-ascii?Q?ZMIWngu+1wcxUkqkYVv30bOKadooTIZ0qIZ1lLSTj+lV7bN7DfhHWsgXFDfh?=
 =?us-ascii?Q?0VQSmbsm8EUqgvltzZva/wF3eJrjNbE5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rb6esDlfbs1hR/hmpKvVCj9mXoIohxAjnlfFsSw18wGAQBGTeqYMmFDjNTM8?=
 =?us-ascii?Q?2xosUQJ3VkJgto+X7i7kZzeEbp41KByBQU2QfDja0dKtvbVqvHIJoKdTge7I?=
 =?us-ascii?Q?aQf5ITZHbz6ScqgH6AnhO5lLXSYWDjgk99TbLCcLh8BKDC1oqNc3gkU7vLJV?=
 =?us-ascii?Q?JH4LVEyq/88qLmd67TjtW+bHKofIBkzHtqwwqkx+6UO4c4ouFI8q4a8TWxBa?=
 =?us-ascii?Q?ZtivVk+bB12Nr8lPosHVUf158G69wLiH+Rwn/Qkb0/+Hc0T/cW98aUL6d2Qw?=
 =?us-ascii?Q?t1+VafCZ0G4hNVq4AN41GlYUVIHHAE5cOWvXUaUMRarzXxtwsl0pM/l+FEs1?=
 =?us-ascii?Q?7v65GEqPRbLpEqd14xGQOele4Usp7zF71LMat7yxhmFrwZtuXKwz1YGTO/B8?=
 =?us-ascii?Q?iHTRVHE91TGR/MMAX+4Pq0bxgTKn5OCR5T5Vj5yE+TlpLbIGPlr7xCmnS5M/?=
 =?us-ascii?Q?ehdU2Qc8a0yCKJx6Hf/nM5Usi5Wd8wB6bcmc4gTcwoueFaWzGXrH3sLlqpfE?=
 =?us-ascii?Q?Gm0fUaIZRAEQH8eccESt+AMFzazV6LqruolMavm0rz/Lsf/VCQm7ynJmad0B?=
 =?us-ascii?Q?jOmESWmbLp8ThpIyaElWSBodsStcCZ6lHcRv2TBfzP/Lfmt2hx1/tpaQP3qc?=
 =?us-ascii?Q?uZ34bL39Td1yyEAKnvpfdz2EPZzpkeCaXE5TcfdP6Wji86CDJCjZxnpdjV3y?=
 =?us-ascii?Q?gDq9dEyqJiAt0B8/oFLo2AUbBYLCv9GnXdr5XSliTbGvsV9yOh++Jj3LGkV7?=
 =?us-ascii?Q?5+zaBcDqLPmyeXPThSTn7Kzd6v9lBUzbPk7FZNmeuARYjygchfKVwE9khaVj?=
 =?us-ascii?Q?BiUnM+yaGf2f7w/Dnwo3BMbhNLLttpAczf0oQ6Zy/3R86H2LqXoJw6G0ldoX?=
 =?us-ascii?Q?1UIJ/MOUYcHA8E59yOiXrf4uIqh7I6LHngtvR5U9DOUD1qiprSpB6M+BUK6Y?=
 =?us-ascii?Q?g32JLGZjgv25JrEkbh1B+CMlIzuE061c4Za6EO/mv0aM8FJKlNqUcCoogTMC?=
 =?us-ascii?Q?H0aTyZ4rxx4leD9cVgaU05dnjNrzO6Frp1feEV2X5psmO+Uiq53g1ATeErHP?=
 =?us-ascii?Q?tNt9FCeJdIjhexo1F6VTI/8AoHwdowX0BA55HwEkrT3EOcMjP2lSledBdKb2?=
 =?us-ascii?Q?WBkmhbfF8h4F9w7Lvm59b9IsexhQEtCNPTNxWRPgrVa/Vs49LTslcZ9fD+Zv?=
 =?us-ascii?Q?v+Umhybk7qm7SmAatfW0NKEn4SzeCVxgI6KDfBhH8gL2oMKwkElS13XjsvvZ?=
 =?us-ascii?Q?oe5OIIBU2Ewy+2Z9A0385PoMCg1GElu+QDrEissAanab0im3IBaKsFsdZAbx?=
 =?us-ascii?Q?QAYQ32b20oz/PGKiJqwyH0f57bIs7bdn2v5aJ0cp73le6LAHq+L8nhsIL7Xe?=
 =?us-ascii?Q?tpaFGvvav5gmIiB2VmDayJw+/zqNfN/Vlgu2ortQPL0d/j5ttnpaMqe3JX7U?=
 =?us-ascii?Q?SjYAHutaBMeIX4/k9Nd12L/nHxF5uyyouDSf0TAvUtbVJ/Mvcj1CVONDGz96?=
 =?us-ascii?Q?ZLmJ+BY5mgy4TYJRoCMTW8/4Ggo42jD49XSkWeWgu3FHE1Rr5wm7FLhp+Osp?=
 =?us-ascii?Q?I31kRl156BYYO6tPvL4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a179bdbc-1601-419d-ec9f-08de27721fa4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:47:05.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOPEWYp5tD10zIZprT3CCQaAanqQVapOWwKTGwyeFMA0LNEt3BR/wc9jckB1gjyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409

On Fri, Nov 14, 2025 at 04:14:42PM +0530, Sairaj Kodilkar wrote:
> So that both iommu.c and init.c can utilize them. Also define a new
> function 'pdom_id_destroy()' to destroy 'pdom_ids' instead of directly
> calling ida functions.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  5 +++++
>  drivers/iommu/amd/init.c      |  7 ++-----
>  drivers/iommu/amd/iommu.c     | 27 ++++++++++++++++++---------
>  3 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 25044d28f28a..6335b577f80d 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -173,6 +173,11 @@ static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
>  bool translation_pre_enabled(struct amd_iommu *iommu);
>  int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
>  
> +int amd_iommu_pdom_id_alloc(void);
> +int amd_iommu_pdom_id_reserve(int id);
> +void amd_iommu_pdom_id_free(int id);
> +void amd_iommu_pdom_id_destroy(void);

Domain IDs are not signed integers. Use u32.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 48bca4dc8eb6..4d57e820b824 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1785,17 +1785,26 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
>   * contain.
>   *
>   ****************************************************************************/
> -
> -static int pdom_id_alloc(void)
> +int amd_iommu_pdom_id_alloc(void)
>  {
>  	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
>  }
>
> -static void pdom_id_free(int id)
> +int amd_iommu_pdom_id_reserve(int id)
> +{
> +	return ida_alloc_range(&pdom_ids, id, id, GFP_ATOMIC);
> +}

The GFP should probably be passed in as a function argument

Jason
