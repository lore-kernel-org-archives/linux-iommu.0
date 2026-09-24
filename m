Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8A190473
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208064; cv=fail; b=TyTsIg+QFw3+bQwo491ZJjP9RJj9cP9djPfOPcc1vQd76Y05qvl9WqbgSdGYEVrPK7JdCYHEtMi3sOrQ2OsAkzTAb3a8M3iFJZzhLgoCE2w6trmrcw7/2L8nAm5Y0NKbllYzX8C7v8eMnjeC3wS2uPYWlqnJEJksmWHwt4LNF1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208064; c=relaxed/simple;
	bh=BLfJoG1PNGSgvM5FkDI68R2gWfliZl4UF9vxeBW4Agw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=OA+YkcGZ+NiEK2mYFZ/IGuVWqszlIopr/yoZW4Fj55CDYErXfI7E2kHnm0z3+ht9uRibAGsQ/IBH0Dlsw9MJ2atKUwFWI9oVdGqj7wwOdzC3QcXpg7wFUhcDjj4ImWj08zld2sFinzKX1HRpvv3+f9+4erFV0dObzq70WoRfvJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=raZNqV/B; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="raZNqV/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOcq/vxnBOW+6kBhhfvC/EwsOERIzT2E2GxuwuHkP8Zyt11JrtBaGiUZIsMHNU9mQQISwX2nWif78IPlP9qPFuhpTW9XbmY+PN0oh8oZUHlrBtRSVE8+QfCYsIX6f4T4xnEMVxqwUZ6U9IMdMWp0Ebxtc1zlmHmNpGxwgB5sfjG7R7Vs6W3jRCLFCy3lTZVoZi1AanIqZfTGUlmGNjCYlevaPnmyOgfAStxyXILsSLusSzIjRolE8YVu70eUMJ5d7z0EsvNWDP9GUCYLmSRgj1B5RrxQQw5dY4im6zI+E+Zo0t0di3iqyC+UqTzKEUDS6uim+d9cK+9KirQHE2wWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MztaGqlVZqS58/7tcu+PV+XSzJSJ7VEssfG7m34E9+4=;
 b=sxrfyzN4UNQOjLkissBSWzCTKMBH4pfaoDmbx9WKB8Fk3e6PpteE6EbUj84iAK3YghlqkhZhuw5gScwqB7v1uhfimrbdiBarEENQXSCl6nhazGbbLdPRbUdUjUYa8T533zoyd5Tm7nNgA1ogMOLu1cR0yRLFDolTV/vUwJIFt4Da4LQtmt/4af74bo7aVM2WmuBnsnjLk8HkK8PJi8sa0Et75DMywcUcCGseZcaS3IKyj1nGJXWSMVMI+XxkvH6NdkSGJSWTTAyNIs0BXl5xh8CIZNfVQL3Ckyk2ni56+/vuXuPZt+zDTtZC6H6gBURonp+nr73894HuV3KXnjtPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MztaGqlVZqS58/7tcu+PV+XSzJSJ7VEssfG7m34E9+4=;
 b=raZNqV/BQy9aobA4uR474NfgmM0MNUY85xAwS9GT+YtFk+hUd4e+opRa6uiM2stkT6LgX+S69/2mpB6HEaozEPeAfxiYrw+C7v0co5KcvyCjpckj802veelT8AdR40g6rbwLh4wfKjuFkpchjhQbo7/bnWc/k0umZ5RAF81DCmxZNTo2Zp6p6WwE6O3kQn+OZBVI5ANoMQT5p5Zi8ZuVDYZXqxI4DfGOj5qa3rAiiIiOE7NT5nSwBjfMdfAzjKWnaPeGMJ3UlzkQiKkLEzO8q12b2gjXe9OGTlBKpTcXdRYoqa2t7earjc6x7qIx18wYvFKiskxOj8twkk7j0gDg0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CYYPR12MB8870.namprd12.prod.outlook.com
 (2603:10b6:930:bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 00:00:56 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 00:00:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iommu: Honor iommufd uapi for zero entry_num args
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Samiullah Khawaja <skhawaja@google.com>, Peter Shier <pshier@google.com>
In-Reply-To: <aphI_yNLYA64iOrw@google.com>
References: <20260902124333.2461949-1-praan@google.com>
 <apg9KNnBSjej2deN@nvidia.com> <aphI_yNLYA64iOrw@google.com>
Date: Wed, 23 Sep 2026 21:00:55 -0300
Message-Id: <179020805557.3550671.3361580303644507025.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e8dce2-9f6d-4512-6514-08df19cee878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	eHGGC2RkeVCxhA6tmvfZ3kqQxdHYbGDugdNYN9e1xEV8tkd9Gn7vjgtUjUGiyk5yXgbw40WkNvHH4RmWrjBFOb4CIo9+XfsH9WLUeIJPiMZcV4B2fAxArLUrqUEcjAoBkUlG7SKkby+fDxcxJyqwG6Uc8S5n8id913Uc56oJY3Ycex4C+pj/Vd9GXYtEYrw5ic0NoypXSWp+Q3+V78+CvgUnZEVbBJMDjIEbjBmDr74LtqMgFNOg/cQfDN+Qmr1/d232R/b/UcarsSz+TJQV0xlvs7ssA1PfT/5bMzZRndKqCgw8ZZBDJWiyfoQtIp9mYsEbFIZ4scFU7/QtC+leQBmHBBIEr18CWuIkZW4ZvzLH21eaS9LGsmaQ70NzqNnVE4HV3jTL242ZIdSmmUMaR+ZGbqQdCibmj7okH6S/0BaEqgV0Z9G8vr4WLOp38ebmDzTpCpBJY64bgGBrSEowBQvIHpJKvsc2CKbh49n86FZcn9BcoFgmwSQi8fuM3IHwtRt1Vv59MWM2i62gRyXlkUZLd+1HP3cT0SSzqUGbXjEMvg0/wZhR7sHdNv4aXtiEv0W+oK+g8pXV2kfeKUm6L+R0f2k1QTwqgKmoEyVdBjaW+eZUVTZRfFWH8cR5hsACjkG4DMaTV0UeR+tbYvNn1OY84UkkAdGZNej8qsJf46U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTNIb2NSN1gxVjdzb2N5ekoyMjdRRWdEODdsS1hTZlRiWEx4em9nZ20rRlZa?=
 =?utf-8?B?UVU3SzQ3Vnc2WWpkUnplbmNtQjloZVI2WlhPSDRrKzhLTEUwb3lTS3d4QmpD?=
 =?utf-8?B?KzR3QTZHd2RVWlgzZHlxWWl5Y3FXeVcveUJTQ1ZScUpmN1FUYjNRcUFYMDUw?=
 =?utf-8?B?ZWxtVmpnK0J2anZGOUlsaEtjNkhycWdrdndwWGRNb1o3QWxKVVpFc2xPdm9X?=
 =?utf-8?B?TVhTVkVid2JpWDRadzhyUy8wQXdqb01DQ2FnNS9QSnhBVi9OSXZ4VjJ1ZENl?=
 =?utf-8?B?M0llMVkwd2VHZkwxVUJVR2hjTjlTQit5Vi8zQllUbkc5RGpUTnVZd1Y2U0Vj?=
 =?utf-8?B?VzZVb2h5S2Fuc0RIaGVCY2htV2tUbHJQVUM5bklOUHFGTng4UGFpL083aFhW?=
 =?utf-8?B?Z2J2bWcwelZTaXl1ZEFUaXZZRmVIRkxpYnFxSWlvM0VTSmUram1OYjBzeXVZ?=
 =?utf-8?B?UjVqYXlrdGkrQlQyZTNZbVpsd0x0R1JzTkxGMWhJY1Vud3JzbS9YZTRLR2wx?=
 =?utf-8?B?L0o2dDF0ODc0b1ZyK3ZKc0hCbkMyeHpzTy81Umg0b1ByQnQ2aEJqTXl0dHBP?=
 =?utf-8?B?WVJpbEJlOHJuWVVpWitvdXZKWTJPVTRtWmNhT1U0T1A2M0dleVZ3TDcvTE9z?=
 =?utf-8?B?T2pjRGlMTU5LSFJwcjVXb2I4TEZxU0VuT3YvVWduaXMzUVNFRU5pNGNCUTBU?=
 =?utf-8?B?ank2RHRYR3l5SkVsL3dhUFdaS1YyV0lLVEo5RUI1aVF1d3dzaUVHY0JuMytQ?=
 =?utf-8?B?N1dwVVVQVm51L05jcVcyWHZBOUZXQnNReWFQc1piT0hDQnE5RkMvQnVwR2x6?=
 =?utf-8?B?ejFXY0tncTlLRXlCZitWMzV0b09UT091TmphTkZuMjMydHdTOG84ZjkwL3Ry?=
 =?utf-8?B?VFJveUMwSWtCZTRRZnQ0UHJWME5IZEkwNjlQWWlPOFNKLzY3eERDcDR0akdR?=
 =?utf-8?B?RVVhTjRodldOV2w4UTZqNndFVzU2RTZsa1R2dldLRzVqYWR0RTBoNDYreFd1?=
 =?utf-8?B?WGgzbEFlbXl5QUdYaFFUaUtQMU85QW1YT0RkTk1sVXplUjNXVHdEQ1B5YWkx?=
 =?utf-8?B?eVlBZkhkZ1JTTlp5N2dvRXpjKzRBZ3orQ2ZhRVJ4MjAwVDRMNE90MHRoMDlZ?=
 =?utf-8?B?L2t5RG11aVRHR09yQitPSEZjcmJQVUZMd1NBTXpaRjBWQ3FsWWJaZW1HMWl5?=
 =?utf-8?B?N2ZxMHd1MTVacGlJN0t4RlpOMVV4ZnNKK2hYYXIzWnJLWklBdHBBYlNHNlpW?=
 =?utf-8?B?U0ozR3RxUFVMbjN0dkYyZVBsVFhMRUtzRmJmS0dDUW5GMlFjWFl2aTB6bjNG?=
 =?utf-8?B?RExXUkxJdDcyTjVxZ3ZkWjZFTDlOeFZQdzJqOUo3T0xFK3hvL3ZHOWpyUmJ0?=
 =?utf-8?B?VDZtTzFSelVnOFM3TEc0MGhRajBQTFljQXhwc25ibnF6U3JnR0JOdDhaS0Jj?=
 =?utf-8?B?NWhhcndESVFnb0tmY1FoSm1oR25jaGhjOUV0LzRDazFWRmNUUklhQXRWaFNo?=
 =?utf-8?B?UC9rRjVpRjFrWFE1ZytQNW1aTnZIZWJubDFDTnNHNXQrcytTNDlYUmNHMDY2?=
 =?utf-8?B?N1BKci9acWV2M0hlbDVPVHJkbGIvSzRTMS93WG9GeWRoS1o5a1ZsNDZtdEU2?=
 =?utf-8?B?Y3F3UGg3NFZSdnIvL2VJbXJpRkpSNlhFajVPNStOMkRoL0JYQnVzOXIwNmFH?=
 =?utf-8?B?dmJjaEEzZmUzWHJWemtzeEhWNnJVSEMzUExxSXQwZVFhM1NjZ1ZtWXNyMEVL?=
 =?utf-8?B?WGE5K0JHNEVSTzN3N1lveTZlL2tnajBDTUl1ZXBSMWpzWDNMcnVLZTEyN3NF?=
 =?utf-8?B?VE1jV0xJUE15Mjk3N3RQU1BwTXdmR0lGeUg4dTd0MCs0Z3ZMMDFXRGI2RHhT?=
 =?utf-8?B?Z0szYUgvbmFWNmRtNktaT3JWTENaaGJqUzB6a0wyWjRaYktIRG1vMzh0Skxi?=
 =?utf-8?B?MlVDMkRSR1dLM2JybkJsNUVXUDBGc1lkUGlwR283cUt6QTVmMGpibzJYV3p3?=
 =?utf-8?B?SG13eGZ0N0h0UXRVZDI0Ykt3SjFLN09nY0dZbmF3T0t3T0pLZkswTkJpaStC?=
 =?utf-8?B?OG9kRWZPaVpMRThiNWFRbm5yVzQ2bU51Z2JEcGlqWkIyL2g3R1h0R1V6NmNE?=
 =?utf-8?B?WHo3WktEbE55WlIvZ3A2aFl3c2VTRTdxQlFMYXZaWnYxazVtalpGMWVSam1G?=
 =?utf-8?B?UERuN2R4MExNU1pFRVlnMks3TnZMNGxHbUg3ZDc0dDN0NzNPaGtiN0Ixbmxw?=
 =?utf-8?B?bXJ6VTNlQVNNbGxZZjF6VzlaNGJrcWxLUlpaR1gyUHFIY2JrS0tab2toN0hU?=
 =?utf-8?Q?lwLBkdkv2mj+807w18?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e8dce2-9f6d-4512-6514-08df19cee878
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 00:00:56.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Up9piagMf3SAWa7AjPgWPr8jBGx3Ekfj90Q6Yp9HsFe/9s/xAxpA68u25K9CF6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

On 2026-09-02 16:04 +0000, Pranjal Shrivastava wrote:

> I'm not sure if we should be returning -EINVAL for 0 because nothing's
> *really* invalid (and we check index >= src_array->entry_num at places
> where it is). It's like getting -EINVAL from copy_from_user for len=0.
> 
> I'm okay either way but it feels wrong to have specific users to check
> if (entry_num == 0). Would like to discuss this behaviour?

That makes sense, but this should be respun on top of the accepted one
and remove the redundant arm check..

-- 
Jason
