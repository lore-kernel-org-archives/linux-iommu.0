Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8867A13A
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511495; cv=fail; b=UDwNxzVB5no2wIHyGBgNUZ5gp53VTzNvh0WibSJDPwIhAVe33L+zzJBODt9IByfX45JJ0QQ1vQF61sdGrmcva07Dw2gZc297zOgUHffjve0ORu8aAjZHPuQsrDS3sKpY7fgegCWcLXSdkP6GkAfyZ0AglYcwE6gvbp392NFLfrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511495; c=relaxed/simple;
	bh=ymHZUZ/a5r38EWYdn47tA53Peru5LUTgw5YCmJ4MOAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dYoikY408FOaC+2/OY0e+MM9xC0sczkRQCfmUuLYqtkk82Z7FWAmmzBJ+t1Pw6Nje30Jsy3T0+nBDVt6Osuy2LaENVXcM2q9zY++G6+VWSi7aI0cgnDfwnKJSY+/iWncdqipud6JlTFCywPjipQGu+4JqVSRSlUwzM8N1s4LtB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmCBkKoL; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmCBkKoL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pabhM/YJQud7/+UHQR/48bHcmY0qWJTMua3Ul9DCuf6vraiQIeh0z2xEW64npugpaDenU6FNn0eXo2k5/naDs6EemUFV254Ur71QjCKW8ODADU+zz7mu+g42bcnnAzJp/o7szSXCIt/ADWZRMxeTkowMOXAlzT4i3ikPPDhhkliza00ZEk5cIsNM/7ek5n8auYVI2H8sm3NBDNFOa3cn09+x3W49l+1N1PWxCJDC4WgrQ8Z7v9NbKSEiiufSz3lSUytpEkbca7llTGezQ8CFzGYzZ6AylRKducLgUedoXOBnthiywucjq5PUiZnJ4QswInY53wDeUumcXvczK3wHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z959cLO+xRDNPqGaJ0ztUMYS4KWbvCrSfEoRheHayjE=;
 b=W8RtNs21rRqpIePBZgvF9RTliCpjkmTcZbq/2nxdfG9eFBzEpkRPbi2sU3NDkQ3ICI+hEiDD8HNeSRi67eka/mWdwgY94/dl66kZ30WMUCmM0wvib5BM4UW81Jgh5hbLpoV+satjbiJ21BOXIbhA5Pkp4puXbVMCVew62JPzlol/8wNF5YBxmoDTd9qtQX84s4o0a9CGGHlYEaow5NR7Mpn5QpsibtausGT8v6ExhaEGj6Vqw9vz6LGqJ1S6b+iUhZkzzUQYP6MmIGzSfAPswYp6Ys1k5pJdvGtUwvuincBViWI3PkZvv5Z36W3zHCUGoVLXYZgVkkYi96nTW+lF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z959cLO+xRDNPqGaJ0ztUMYS4KWbvCrSfEoRheHayjE=;
 b=AmCBkKoLgPpFeazouZcKUc7WrzY6GSE3LQKUfDwlbM92m5ahXvBHQ5yX4eTjynCzsZXKRWnItSpLzwgsGPUzhkIt0UfzvEqYNAV1Bi+f1pLpjFi8i71sraOyeeAsAv1L4Rt5Vmwt+BgX8SVkimg70UKGQKYMU/48qUZ3sXrArFqjLGA0ViEO0aTqwrz8ElOvNYdK+bo6qQbxBXyc+/dfbdh+ldqcaHlSqkI78p0j3LUvBnadMxFC+I/iZUbKujJql2C5HZ/HhuVjl7S0pp31e+nyu+V4F9kbkfPpIqBpZPFtr9HvUf+BsqzCmzxRkeH3qgpACYK0idkjgLYc5aBHWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:18:06 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:18:06 +0000
Date: Tue, 18 Nov 2025 20:18:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251119001805.GI120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:208:23c::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: b0089694-23cb-4eaf-5e33-08de27011c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zUcG2aFgKxrfnWcX/hGzPl3VqQiAkDffyE3lVvuRU3G4rJIWPvWi/8hBt8dT?=
 =?us-ascii?Q?UHHANHHei30yRkrFAfJTJ36+G/yDSaZ2moEQAZor35o1Ch2h5p9qHMCSXMvs?=
 =?us-ascii?Q?hq5e9ZYrf2dPaoi5TWTc7tT1H8fhY/2t2GdYy8DPhbIpe3ZZ+yTujaZ8TOAj?=
 =?us-ascii?Q?kx+SdouKOOOMwewgnbJoeYvhsgVECuoLdT/ck73MB39OYUMGgu3ihHTGqCUo?=
 =?us-ascii?Q?l9C4foNYLnLDmTRcmeKkGQk04ybYDqxoKQbcMKVu7sCSY2dTjuVTDIFJ7Zdg?=
 =?us-ascii?Q?MPQFMNWow+EHvsAxzX6d/WVDWoDMpIfRqsAIK8Vo/rfoDB//y1+eJ4zrOcav?=
 =?us-ascii?Q?+e24vWcxXX0VSj48PdGpL7k+OWIS6D9jhYL3m9m7HLjd7QpyKMlaZoFPPTO3?=
 =?us-ascii?Q?Yd9aaaUMP+C22LGkS+e5D1GebBpvFnP5eR5jXpeb0W/j2BhlMZVTvPusE/Yl?=
 =?us-ascii?Q?gseI8DAloDREWARt5k7K1LpZ2XbSjSYTZvKSjrngZk3V2igRl19ohM58hvnD?=
 =?us-ascii?Q?pRUuCXKDNzA5F8mlQupCseRqXJFb2icH5DzdUxYGgu19qoBdMhW9Fui4VlmX?=
 =?us-ascii?Q?SfbhdmihlNedtk3oBRw5AsAya3tci0R1Ie7w8v2s3/Pcep1VMd+R6FtbX4lf?=
 =?us-ascii?Q?yhaP4CzefBT8KcVze7kGFFiOddNpZTv3YjxU1AhkKc4WdNoDTmfKtjMK8oQO?=
 =?us-ascii?Q?iCl6yFzQF1q9dVfgE3f5hI/bxBXue5KGEu1eqSTNLCHgswelt+pt36F+evj1?=
 =?us-ascii?Q?BVkiVr6x5ge7bGCHzzz5wfD3jUkQyw+c/RxQCSuz6gzhmK/s7yeK9xK+wXcs?=
 =?us-ascii?Q?tblkijilkouMgUOJwLGOXJ3QJadFDc6/SkSgnLP5oW31QyoRumPbvKzpW1J9?=
 =?us-ascii?Q?NHsgjMaxIbNLpclv565Uq7MHFUmF9J8/Mt+nzKoTbcjdZz8EUOGn5V+DEHOH?=
 =?us-ascii?Q?0iJWUzuder+iVQRGus082Lx4lt6bV44Fdb4ud9eqxdGT6icqcsYYwzebTHfr?=
 =?us-ascii?Q?L8wufEYcfvxIOWPr9Ff6NwKD8P//QOsXkkZFFA4N45VhFOE6cK9YvzJgK7Ej?=
 =?us-ascii?Q?Q62ENgYnGWiWEgljblX0mHpQ4Mrznk9tIXnxTca/ZX7J25ly36y+vOS5ZTAB?=
 =?us-ascii?Q?Pg6AfRs6mDM/GxcmAUGtL0NCNbBb99jYnmvAdbtYst8+VlMwLNNSRbOsZciq?=
 =?us-ascii?Q?Rj8oR0V+xLGW6zvwh0gGhlU19qMdaVnPUavV/IRH8EMcL9/SCvv+5ryUTxoz?=
 =?us-ascii?Q?u2q5MSmc6GsGzfBJaYq5fXtq8yAxrOQcYewNEFI26ydu3SqxhZsl7yeB2zh4?=
 =?us-ascii?Q?pcQGwtMchu+RQZgT9ZAoc2s5SYdc/h5DwxOrteudTjswba0g7OVvsYKaYrUp?=
 =?us-ascii?Q?uJ6JqssnbI2tWh7E3zdA8NLBfrMT20rTLVszhg9O6PE4llA6rWU1DbqJOoUP?=
 =?us-ascii?Q?4WgFNm7oL26woaf+mWED195xvneXu9Fs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NsrXY8JrOYKjxTNMTzyS2gWmM0pubNkZygtk34u7NKhKicC3f/6lrfcUmH5?=
 =?us-ascii?Q?8sLIq0JeahQ6AwYqpw08E2eZAW195ACPHzhWK9M2EmuRqqejpHHn0T56OVPR?=
 =?us-ascii?Q?eC/FOOY3bnkhV78ZvlCstJQERGaKlXtQtBTOraagKIXGKGSHPRlhyernaN02?=
 =?us-ascii?Q?1f+4za9LolvCSWAJtefB5mBtPW8l3jwZKaRbAYSHSWn5KUf3hDsm57ZJFhxL?=
 =?us-ascii?Q?b9wJI2Hm3CpE8cVO/qBRxiU5amJEGDLDVikqXNn/yvl48ZEMm6Cs3jcqxEfu?=
 =?us-ascii?Q?muIDGJ0WDDvZDStpWKbn48BjI8kELH0emVsUpdIcEiSTw/LWnffws9YCIFjT?=
 =?us-ascii?Q?mnDiKt0+Hfc13X19rvolLLVA0VDZRULhCv9viez5dgBs/cKEhpRrLv27kfd4?=
 =?us-ascii?Q?9VVGCOTuYyl9dyAMTCeIfSRvslqJWE4AJX0m8HTuZGMt1plRak14HzUwb/5o?=
 =?us-ascii?Q?REkjkP10KMPD1i6DhZn5Np2jGBZqRcP1XyKBeo0vzkStpj1VDfT0MNtsbQ2p?=
 =?us-ascii?Q?tOpXdZ2Wt1EpDafqjveCr2TJ7xh/yF+crsuM0CELc7YPqAq8jZpxpWZP5bfA?=
 =?us-ascii?Q?Zh/36tW4/xDiLUhJ4ontuaSV14xdsoGs93XhoUyAV3u7/OXyb6pfp1AH9+32?=
 =?us-ascii?Q?6m/KzfShs07fx/+ehVE604EJaiMA/WX4jR92nHitpUEiZQROLh3uPYb00Zei?=
 =?us-ascii?Q?wiTvixGt+gqC5jj57KWoWasYdOZH6b7y92sffzTJP8oeqyGuvcNhbTFGlEU3?=
 =?us-ascii?Q?i3iOafCQFqv7qgas5dOb9LOj0f3H1z38u3LaBlrdzTQkzNg0Nbb8PiAPDkqE?=
 =?us-ascii?Q?9t1E3CF2X3K5Ad7V9CIOzPVrlnRadJwopqURrqMWQvcRyLtM779ZzeEnbAdB?=
 =?us-ascii?Q?Rd30uCZqW0kdtUlsqfv9ewc+zAm7oeL02+AMcOTecBKJHLzj891Oa4DUBVFF?=
 =?us-ascii?Q?4fSd8Dzg4QWIlkhCKuGcNY+meGBkGBwdMDCZiStKqJiWt/fC4cYEgpotfh7g?=
 =?us-ascii?Q?DksRAEHtJKY6x9rfcdmCBy33TrD3eFCJuFcDXCXpX/+vVcin+CmBVQ1OSCVe?=
 =?us-ascii?Q?qnK/LGFbFDyu8NF6LTijweHnu9UGtr4pRZ1bKsOpUbBdabAiQJ/sSzIfW9oy?=
 =?us-ascii?Q?hVEvI93EEDQ7dAUB0BzpcthAzPQQW970FY7hVMvVNJHJqE4ISFqWyUs5D3m9?=
 =?us-ascii?Q?vZv0PiaoSdd+7gpJrPTASjUnvq8bx6P1NdJOG/Q1MnJuJZ7ThhtdSMeUHTcc?=
 =?us-ascii?Q?G/MoI0by5BB4vP13oVgPHgbASwzeLWWvQoMCvOEI9cOcFBLg5yTDmevMmsM2?=
 =?us-ascii?Q?S1UEmfKC9cx6lAUliuCAiJHYnEjYGT6uFfDtf1fx2ehcJf9ukSJZmawdtUQn?=
 =?us-ascii?Q?vSQXfb90tm5T9e1rWWh1JieemTmt5YlOLJyp4HhFExjTiOvuSjwgYtXfRjPb?=
 =?us-ascii?Q?Z8qBwykZM9aMO3UNIhem8aUJbc2QE7g9xeM21I1yR526h5+J/NGvcDPO7St4?=
 =?us-ascii?Q?2LEGaUK0km65Nas9pdvm+0h7UN5ijF6nY2WijiFYNNew42PwcoYJ5o7qiz8O?=
 =?us-ascii?Q?AiG1LsLr7t7eBMs/E4I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0089694-23cb-4eaf-5e33-08de27011c5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:18:06.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRAulDRt4AiyU4dF4/xQ6pfM2JpI4P1FJF4GGQgBTJQUhrvH3ooT7ftC9UeEDJBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

On Wed, Nov 12, 2025 at 06:25:05PM +0000, Suravee Suthikulpanit wrote:

> @@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
> -	new.data[1] |= domid;
> -
> -	set_dte_gcr3_table(iommu, dev_data, &new);
> +	if (gcr3_info && gcr3_info->gcr3_tbl)
> +		set_dte_gcr3_table(dev_data, &new);
> +	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> +		set_dte_passthrough(dev_data, domain, &new);
> +	else if (domain->domain.type & __IOMMU_DOMAIN_PAGING &&

() around the & is kernel style I think

Otherwise this looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

In some future the set_dte_xx should be called from the domain attach
function that knows what kind of domain it is attaching already - ie
identity, v1, v2 all should have different attach functions.

Jason
