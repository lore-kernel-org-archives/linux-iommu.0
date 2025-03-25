Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C5256C94
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908882; cv=fail; b=DNUPvmpDkeNXIwWwL5dJMv0TV7DhoTB8KFxzp3KJRXkYWivSXJHjwqyVQEGv0Ymo0ATjO7ap/D5E++bI7fayKzjCT29ow4IT4tKyYmaGn1oxmodUPkWMLtvFbfkNcvLGpnK3GKsAFhZE5bfwpeeYKMPbYV91FqcxKH8flJuqK3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908882; c=relaxed/simple;
	bh=j5nQWYqxh6qS/nPtKJoMCtIwYNgvVhBB+IN5CU5F7/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5VQ1BsQYGObGxcwdd61hRnxYUt1tD/oDzyTWK+YhQ6eGNX8/gaR5Harm6NUSbUi+JLQLcnB4kwnFj7Fk9QO9qa8KBl8wURUHO+UHCioLTBdqAQceVIOnSVEQmZr3Br59O3JYFswECf+z7DdVQ89DbxK6V2O6IzvecSB8hOGL54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQw7lTg2; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQw7lTg2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA8OQSs8NDcEUACUEJUP2OIlkVdQX79+cHTWmUelIc1DLhDH6pqFft03rVBK1lql8slJm+biARXLRSs5Yyp+fD/x/6j+CT3dVRNfmXxg2d7Z6SWir8Q/pElmDKnEVvyKFpOFJbTve2aPqzXDMO9Jh0K7r2+DmyRolwdXAmYbxxVxV+uwUEz+h4hgCBzOdPDyQoTsPTUE4rdYA2NXX5ByVWz1Y0yMzgKeyUyPu+KYmVZQZ8uH0NyPP7HzsprqhEwaVondCyzszIC36x0NIzkNbpWljSSuyGfDkzEK+d4SCNZVonBngBfJ+B9+eyCblS+2dXnOI9Z+OvPB42O5skC+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liSQ2ALdAgMDfAOcUPLGRJVnqBWyXsUB94RVFcr9U5c=;
 b=KgaWRk88D1YJoQgOIX0lbAfx/nbEQ1kB4gxs7xYzI7tt+0iFcF7pAw9hlXNoCQxEgbtDPNuakvwYxY899QCbNt8HhiAGBIMF9n7hg3OxTZfnGKCOz74fJC9M7/ZqtF06KkAZ3UP5gb9ob5ynzAwlRMc8ze3D0YnfNbzM7kwMA2gAergQTttvCORhO0Mmm8juH8maokibzm1SNlROdgAYAyzfLISSt47jVnpYSAsHVY8REJkxqnyDLERQUiRzhNAssSGMzQa3c3pjzRqMFqkpxsWkCAZvl7YWg57ZejIHWxPAu2k9/QLnPMVvud/NuBRQ/T0DDSf2M1ctitCdldyiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liSQ2ALdAgMDfAOcUPLGRJVnqBWyXsUB94RVFcr9U5c=;
 b=DQw7lTg2GP+DRoCIHKAZghy9PR0lM2IrhQXS1hqX9hqsoxJA3YGiKhSoZifTqElH9Qk5uPH09/pdqy31ijXu5FKUO/yDAT2jR+YrDQhn6e13cMAe7rQWEsOibwH1ELOHqJyoqtzxil62eu3hfWQ1Ys/HdvlSYIkjzeOq8+jFqKLdYOoA76YL+8TOnjdyv2xOC3KIMM/tZVPtNB2Rur0jWFkChfxmJtNiPDUyrLtDXtx60Afil7gQNK+s/HG+uw8NLLj++1Q6IW1Vhn79ReK+R4X3nLbeaBd56pueO79elY/GDtL2GxLA6bqIubrRQdMxlsU4ey93ZlR/YZxnFF1SpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:21:16 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:21:16 +0000
Date: Tue, 25 Mar 2025 10:21:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	nathan@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v5 0/3] iommu: Clean up cookie and sw_msi in struct
 iommu_domain
Message-ID: <Z+KtyiW/Y3w02+q3@nvidia.com>
References: <cover.1742871535.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742871535.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e70d19-2017-42b0-9f55-08dd6b9fec2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8nzbYHpmC96JchfipZdipeUTR1DSji1G3ARn2/Ca+jKv5FcCEDdTah4b68lR?=
 =?us-ascii?Q?1Q5hFDRcP1UD6iYAexcXdqFMRZ+9FbLJt5dgvm0HSUkHSPzk3t9tUp1RfiCa?=
 =?us-ascii?Q?P2PfHgov5zdm6UUQJ/JB4RFMYKoNbo7pQ2gkOOkKMMV5lQFKg+1QN4YrYb9c?=
 =?us-ascii?Q?NfXiwQSIDGNPWxf9wEyeJjdSS7gnyMWdeFxon3U3EHiKsNQtL6tS24vkH228?=
 =?us-ascii?Q?v/4nja68okDBwFFxqXNcKXTJGjq1+JMZf2ajMTMeRbFMZJeBgxMXIO7uO7hX?=
 =?us-ascii?Q?5itBhKfsVRA0tplY/7fmBbJSaqiLCHt3zvlNp7FjrCvY6LAiJFMgspyyZZ3T?=
 =?us-ascii?Q?TsNhKPjLdENaoAG3c4jb6v7i9EKkvE78OGohOH8xWRvPI1zbLF1ilyp5NjJf?=
 =?us-ascii?Q?M6ihVsOt7nYLm84fOzsxu5i2Yx78nDH8dLwGp4qiYRI+cKUqqUR4AmtLaPUl?=
 =?us-ascii?Q?oDaVV0i6UXaXM2363dnRXxNl40ATwwtbVlfKnSOBKYTv8gEQgAaDGsGFGHdi?=
 =?us-ascii?Q?WJNr1V8oOuSIQZxA9KIRxjrmWKwK+WPy84xhkQahYHMDWTtAn1thrnakG9Pl?=
 =?us-ascii?Q?MBkU+R/JgGcxKp66mH6siGftL9OrekPKF8NxLnUVLByilC/QwjiyuqqgH0fU?=
 =?us-ascii?Q?h9d3hKycLyd8QaKQ14DvsnPJTRcWX7Uhi2gOyDq7ze8RfbPNZutSypMIOkzH?=
 =?us-ascii?Q?vYUv4GGu9wW/OIYFuAzZ1io++wnH4sLwJL41r1K9WPgVDALKEUwnNjfwpSRj?=
 =?us-ascii?Q?O82NGEc0mrs65g6TPAl7U8tw3J00+T428NpfVfRIWtsGq4U3tUiG9+do2PUH?=
 =?us-ascii?Q?+AfU0+EkeBOKQGgzsZnWMBFIsuPwFyPL6eE1pxcM21V8YWG6keI46P9HOGHh?=
 =?us-ascii?Q?EevAiH8sjVEANHNFdh0rr8AjQgo2pqF3m7IfvNL6n8QWGxWunuIpfW1Ts2gt?=
 =?us-ascii?Q?KWd2b0RXMb3cDdKRc1sF1V8A6mY67vy+qZYmYD1R0hbnUZAzWrEHz5bIWW2E?=
 =?us-ascii?Q?Qzu51gkm5bO7cCfRLs1n9ZsMmuvTgMW2+WDNnbN1m+cQQuo8Zv9We7ClCxjt?=
 =?us-ascii?Q?bBFHJ13B1Ckxqez32YRbc4r6wScmUz5lW14XxRWefvfMRR/4lAoWpijB+J0g?=
 =?us-ascii?Q?dDlUJ/5klNVCTQgFZkKLyBAhCS4GbSUlo/1sqfnXRBnJMVbmkXZoNEzs+Ih9?=
 =?us-ascii?Q?oFpNWEU8yle6eQh1d8Gd89BeOxxGeG/AbQQEeXWB1O7PUDBJsdBcGO8thexv?=
 =?us-ascii?Q?8xT7C0fOYHQ8407wqHiW0kvvxUkNLINWY3+xgNCJEkhyPC2xJSVIAd1I9+as?=
 =?us-ascii?Q?uO425sOljZNthMA1LIG++h/YN4rke5WQN2EXaD9HBitb2nra9Rasu3saLb0r?=
 =?us-ascii?Q?c2g0DZr0bvgq9hM/w/4E134gpPeT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yVsweruKDJLSIONVgmaXMoYqGDec84WCnpkVSQHWUNt4+Me7BbwIunedUVbY?=
 =?us-ascii?Q?QbI66HyLFdtviLOgzTV7XpdbHPJZC5PnTY+yClPlxhlffrO3MgMulk1/8Xcp?=
 =?us-ascii?Q?HD9pJuBbx66MRwiNTxWB4iSTRBknWus8D7tFmCwRBzaZ5l3Pv3C67ljBFfK1?=
 =?us-ascii?Q?MZgY9ZEKMaY8VyrzxrcQh6+X3Yw/4ajKPBybMziiosARR58IN1NvTrVug2sk?=
 =?us-ascii?Q?5mLleVU9i3WXSjr10i5/GvZhZWfUxtBKhmJXD4iLIzB6EiznJ+eXpbJRK9y1?=
 =?us-ascii?Q?3CLmSj0tmkVGv2FdAGIQG2JD8YOo9eg0aSgI5NC/kFXfrMI5uA3q+zvl/s+5?=
 =?us-ascii?Q?YQ26A3Bu+O4IzSNI0taKh5Zn7G1ahP6WIBH4XvXdC8Ld2MdtUtQU8KSzI/eW?=
 =?us-ascii?Q?immDhj/GuAjW/AJE0RxC1bI03p5zI5kmrMfiYKsqf+TNxQn1wRuc5jOg9ziO?=
 =?us-ascii?Q?25sg/Oq4W5Jk/3fcfS1Ea0OnImrsiU3oRmeJOETmDXSx5APgj0LnyZlrkkHo?=
 =?us-ascii?Q?2vicSUmWF40AO8DhWCcyrnGxdtnekGnYjfXkzxRFteojtFpIdV2NdlIOlaZx?=
 =?us-ascii?Q?VdZrpu7fZ0HcId/OwGjQuPog48YN1IqGRtWDk+aws0+zdsWkCAoqXztqgxqk?=
 =?us-ascii?Q?p21HJZzsIBK3Sy0CnmcEXMVxezw5L8qEh9JkCaiApsKKhpPzvvNrdcHt4Qt/?=
 =?us-ascii?Q?QVEodrwNGuSoCx25XnexuSlBdWGTYVPMzn0fnDutc1MPUGsAoIz4xBhZLzmh?=
 =?us-ascii?Q?iHJV4TXBXqYbj0fNB/G31jzRIQcCMn6A4gfvrF4fWIXAHxpxYO/iUzgaGWLm?=
 =?us-ascii?Q?5hPIaB6QAF59/JWbeR+luOhsy2LbRGBHQw6bhkNKCXCDct/Sh9Wd5Dy2CgX1?=
 =?us-ascii?Q?cpXJii40b7sgVbGY3vkILwp2Uchy0E5lIGqas1xMSB8txu6tjT9FFyiHck/g?=
 =?us-ascii?Q?ed30yX44Tyc9tmcNffVJ0Aiq1EkwyGREw3pHiGnf8Lr7JF6byEkB2vzPOQXf?=
 =?us-ascii?Q?5bGgPYXcOdkrEqSwe6nLGwmOew9dJsLMWSoChSZhAmexrVFNlgBEgI4tWcaO?=
 =?us-ascii?Q?ArKHkYNtLUjIblWlU4Ifo6+wd7IrR8sFhkARBxRxxsQlwRHQLH8m4Ha/RIjn?=
 =?us-ascii?Q?IweqlwgG74M7pW5EFxQAMbKL22wapEvRwCSxsC0/3B9aS6eWHlUGcsiydbmj?=
 =?us-ascii?Q?k+j1K02PyICxpgYaetNfjLx7saBYoY2k4N+u3efsS8BagixdwfU0VFsvCxjx?=
 =?us-ascii?Q?G4rR94XwInyf+sHzDM/KBQPr4mJEQiANo2wsvPN16NGUSGKneTg4FnvCn+x7?=
 =?us-ascii?Q?GM9dbeAnq0DT1qY69ySqbMi5Xq+8/s2MLwLGpibtW8I+nvT3QTFAsSJVj7cr?=
 =?us-ascii?Q?6RpH1AWOc8VKncKqS3wO5PUDF4jc1Flvro3y0+HV8q9R86CeXzCGds5BhE6c?=
 =?us-ascii?Q?VK16pOn1o1Tbs4GmFbz84UI7E6xpBjGU49SylaM3dBYwbzVo42xtnvL39QkE?=
 =?us-ascii?Q?c42+nGyiW1ANtCdTAha3G0iMFg881jsXAu7fw0ktC7rpkM48dD6+/cNY+clz?=
 =?us-ascii?Q?toxPQob6sKhy9QRldN0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e70d19-2017-42b0-9f55-08dd6b9fec2c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:21:16.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pS3T+e9ivqd8vNMbsZxrOvO86u94X7q1oVf1iE0NoAI+h/XOvxwWjX0dCisO03JW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

On Mon, Mar 24, 2025 at 09:05:14PM -0700, Nicolin Chen wrote:

> Nicolin Chen (2):
>   iommufd: Move iommufd_sw_msi and related functions to driver.c
>   iommu: Drop sw_msi from iommu_domain
> 
> Robin Murphy (1):
>   iommu: Sort out domain user data

Refreshed, thanks

Jason
