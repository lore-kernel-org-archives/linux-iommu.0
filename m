Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670A22A7FD
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513400; cv=fail; b=DRVTAKk14IxzidGJEdV+9of7/EOAegvsR7Lj5IC516f6nadkd+yrAdRIQ9p/3kTCraaaY2ufmipz6ce9Yj7Wd+lsSq3dB+ODytQ9bUVF/UVqFqiWTh0D2oWwFUVgPhyfFstejldlAhwwKsulXTcl12akN4abVCZ8OTkIeTqxal8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513400; c=relaxed/simple;
	bh=rcIUx+IkpBISjQVeYajq1VKLiupGRT9VKBAyPnT9a+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=crdtPmVP5WvfssAoFpwZ8HJ35K8a5P83Yzb3sp+5XtSXwBSUx4WeYihgUiZneZoCC+QC6wlAdH0EIaRYT+jIjt4atHI9UK4Dx/oAQyxHAzdn4Pn50+h+5ezcEjzqJTHiJEEeFgFW5ODS3j1QSvnniZ9ePJpFTCUIrKiTeXw3yqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j87/9upF; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j87/9upF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+JKzqv/FN27yMJQr7XK0rzHNoArcZdihpVBA/ONQdpYY9wel1f2p0hklzx6R2+m5g78ACHwqgxO+l5aap1c1uwSCEKijU8EpCDzRBDWKJfj9pQ5UbbYb7RqwYNtyM+UThK7NK6/JuLVm/4zFqEAvjbi4gH7StxJmqNTlYa5pGBtayokmczBoULP1ChbPzylUZRyNBdc84YHZniTpIvnt5WD4MDNYCvCO4o2wuY42RHqxprBaTCreaPN9o160wJT++kFTAUntVAGOCZY1+qEZfVklT659lh5quBYB/OAM99Xn3vDf9ExF3doqbXeEEzWZk1NIlAjZ7DzazGyNEIBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARTCrXgQWrSohMkU3iSUdbeJ1V9LIPZVKP1yq3svKN4=;
 b=dm1CnMFq5XFjHA9fEyUNSRyi0ALoiffjhJ1AIm2xeEsMcB3RjW4OFvDJ+XvYEvbwo+gro75+Ec3zhiMRq9q4ECw48E+CYTN6h/3zHrCznpli2/6C0tZGDvvcC3kDzjaSaagyq4h3VNORPrWTSyaNoz5X++JY7dA1ZVC8JSqpc/rOYgD10lsCy0sixRA1JoDjMyec3tK3KiLSlKNKPY8Rc0orGjlaAxDutU0s1Z6XLwSMpM0zUffATAfO3p+dD2DYeft58Blfj1Ga3t6JMbaJL+xdclzdZJEv8/0FGgS9E9pNThtOW4sWND8NsZ3TvAYlwx7GROrbTIJ5k2rcfoQumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARTCrXgQWrSohMkU3iSUdbeJ1V9LIPZVKP1yq3svKN4=;
 b=j87/9upF/Jf33me3H9OixY/N7UlQLfVuuFs125O6reQdihT5THdbyrbPQd5H+f4qpGzs4xRmiyhSiG+My2uBWejAXRacOeegiz2llyRTsntJE+I21i5HP0GBLCYAgXY8JJwBWpDNv35q3dqsKyMyZxB6SubPXA9Vi/dkbidVIyFoN2CaG8YdkoCeWrTDzBq1Ocr7tb4aaBiJHAjzzCr4LwI7mbmggnSsEP6zuD+/OkoRu1Uzc8yKLLYDO8MsAip/tz1aipQS44v7od7jUUjZSYi7P4rhNN4hderxXB1lxI2o3NGiLBCQaibEBabSuIqVA4FznkChEmeQNo2mlKFd9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:29:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:29:56 +0000
Date: Thu, 20 Mar 2025 20:29:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v10 11/18] iommufd: Support pasid attach/replace
Message-ID: <20250320232955.GO206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-12-yi.l.liu@intel.com>
 <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:32b::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe38ee7-b4fc-4e9f-796d-08dd68071f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?teYTfw9d6BUjyfZnTB4dlGReiqIMt4zydzDJ59KuPdDpXtvY8NbaaVhekq7v?=
 =?us-ascii?Q?R8RFI9z4o1EeQqorvBOHZP8PG3OySxmepJa16cvAp8hG1xeY+/T8BWLsv8Bt?=
 =?us-ascii?Q?Eg+j+kYaB+eygGJF5DEI643RU8prI3P0mtqHEGYWXX9so3Cd93NomDC+vEcw?=
 =?us-ascii?Q?llImxUENvcowSiCCr2uY/d7XU9TPiH88kp6bVtL7eRjaHfuVThd7H3d9W2+Q?=
 =?us-ascii?Q?4tNLPLJWYBplL/un0LgsEvUYCGx2gd8dSB0ms6Xy8o2XKT+3J6cMV2jcVOWM?=
 =?us-ascii?Q?twuPnpsMmj2TO4Z+MV7169fIN5O+uNXGK/4AqVaKTcv0deQ7OajAEFea5oar?=
 =?us-ascii?Q?e+99KA3NaxYby+5EZwomiDW3woE/HFIAlKvR9EO1MYUPPOH7u+DJyaIaTmXP?=
 =?us-ascii?Q?RxARbJ0Zq//OPlPKPgD1CWJSzzBrgQ68R0Gt8NF7uVmxC8HexpZ4WGZ1CI5T?=
 =?us-ascii?Q?2CXuevaFl4pOLJ9bdP3BRWSLJ40UV7MktKTHFfMfjLiza7JohV9Rq7yujFqE?=
 =?us-ascii?Q?d2gRYOoMOq7Ryekfgfg9TGpmUsYgCa7/QOsZ4ULVCGjfq+RT5sOI/f9QJNI7?=
 =?us-ascii?Q?/5wBeBs2MUvi4sHPwKj2V5zaktpARVcFmsPAxNthiGjBoa1tGxd7hkOvvJSg?=
 =?us-ascii?Q?5nTIFVO7vHhqUIlGt9pfqrNRm6CaeIhYPvnH0gIEktaWfmIgjJAbNcdDS4Fp?=
 =?us-ascii?Q?bN5/sVNxHWxojhG5A7H+lIn1eX0S+sUu310lRGEXo6Iea4oJckryY6njEsq2?=
 =?us-ascii?Q?aEtW8bRyjLsBsxQH8h5buRFuJEhvESgVLAJPqtGh95O1xAiN/U3RCOkgC0b9?=
 =?us-ascii?Q?FUqCNuU8bEGyINDwJypssLiyd+iEv7aXIowfUSOLPRXGtwVr43kl4rRBetGU?=
 =?us-ascii?Q?O0U0TFRgVr/QbhqN50dY5IkYdqyzgQGhuL5/c67r+ko/DlJu1G/gxOywOAdi?=
 =?us-ascii?Q?MqHWTdsZ3FJWD0TFmnl0lfzq9NGvXrS9O2snDEhBHyyJeBfBM2MaDV1yIkCP?=
 =?us-ascii?Q?iZQuygji/m+LRh5mxIFugoP2wdggV36H7iRaaToXwiv9oCtZUag98MlKupua?=
 =?us-ascii?Q?lpGCZUcIlnRmF2sE1C4+VpVpWrWWNA9qVl6xYsV62ict0jf2ysNPKLD2Omum?=
 =?us-ascii?Q?jNc97l8ADlSzDEbuLx2iCszlHW2icq5P3PxeK22U1pcZ2j80YsugpEmtF0gK?=
 =?us-ascii?Q?+NoZGmM9RLFwNq4kmeLQAfZba7/QdD9IZTWZ8cf5drorMdQgedINfh/ndc1B?=
 =?us-ascii?Q?xmlTJLqS362JUSnO6Y/8A+0Qf08K99PiEQggFGvG0Xq/cTvYc+cKM5OEYo7X?=
 =?us-ascii?Q?hISZgD1fCYIjL0Xvp/Q26YmMjIPcLehoUKNCLB/lmTZmOGc8Sb5SaYMAjMuF?=
 =?us-ascii?Q?u5ej9r2nRlJYMQ3slwLYk8svZ3Q8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMvfFZMRRF9yuSNgUOKpf9FBoV5IYWqNsIpIlksTHQgYC9R24LX5+TjzPNJd?=
 =?us-ascii?Q?9RBlnuS1KiqxLIRkRhEVpFslDZ+X/LRrKQ1MjIcKoCX3LaNxUXS6G0pp94ss?=
 =?us-ascii?Q?kZbjSN5axUblmc1eRZ/elbCjvsoQHYIlFDPR9p3RQ+H3gVtKqfxTWAe4D4SO?=
 =?us-ascii?Q?6CDoZV61Cr80wzUkexcgEPJYERYowR9I/1TbTnLVjCkD1zg+dXTpr+5knHN6?=
 =?us-ascii?Q?2uLHf467wfDhIeem4yie9+byXyPJuDn59VAg4OZcyslC7t38UGMebVfJ66fG?=
 =?us-ascii?Q?N8fXWUa+HOh5NASeuBKUzCjrgT9xgjRAH6m4wJglEF3HVziTua1GHRMaX7S6?=
 =?us-ascii?Q?jr1lNoucs+nKdF2Uet+HOArPC1/ClXgiDB/vsk2gSKR48oWs2Ue5UyGvD5Bz?=
 =?us-ascii?Q?QA0xAn8neWIEeENu9TFBA+WbWEpSm+VGki1gTIeLuyyLzOVUm//b8REIDR0t?=
 =?us-ascii?Q?nW9yhXRtXZ/jfUceHKrlzea86AhQFoS4dq4W9Ye3GDlk9iCxRKq0RV/thxYu?=
 =?us-ascii?Q?dEtmuSaAWRkHC9+9NBpkWa9ru4n4IoMJgjVIGAvyNzcVbTAxcBeiL2WfeTVI?=
 =?us-ascii?Q?ReMgXf+Ee315tlPCY4UWdERzX8v9a+HNtOQpmzQWRiNzMRDBwcvN6hTUjzvA?=
 =?us-ascii?Q?vYMy7gLB9rTaibn5tubMvOuNdWFatqa2Z2l/bbXNA5qjgNMEx7kXjsO0IBpA?=
 =?us-ascii?Q?0tIhW358Z7pCR6mQ8fSd7DMdMtqpfROuQlGeqN1FadSFZ/cg4TzEQuWQGNgB?=
 =?us-ascii?Q?jYlu3XGHoia5ZOKp7oKNgEw+2sMyUbsUIiF9M8MvR5OQWI2cDinWgCBWH5z3?=
 =?us-ascii?Q?Qz5WCh9EXdMsZQWnLskPv1KSZrgP0zuThUhtkAJd67WicunzJ9ZXF2nCDpla?=
 =?us-ascii?Q?09u1oD8xBEaoszLonx/9jjNvLQmqubJ6UzfHKqNBBRAerHbIZ6AkM4/4IZe0?=
 =?us-ascii?Q?NP3StQL0Y35JYd3PSAV2koHsnDz4qJWMngCTO3BZdOBpxBObyVTLsW1yfopR?=
 =?us-ascii?Q?U+2g9X4LpLKz07B3Wlr0Z2qSNg9FpH6ELEZYBo27W3HWMMhQlEfbeqey5lWj?=
 =?us-ascii?Q?IymOBrN/5Ufi25LcE0OxArh1uwUsiPYH8S7VRfK59p5f331zuRIfqwiqpo9F?=
 =?us-ascii?Q?pTftiQc4fG4LEucrAviMU46Kmf3z+bYyVSritMNLKMaMWUqy21aTDNVwMp1f?=
 =?us-ascii?Q?maXZrwY4JNxXaaHdPL/UQzXcAqJn2P+zOZenryN8e3cgVas2C/WaIi8VP3bl?=
 =?us-ascii?Q?wgh4SqD8zWyuPwlyHXXruR2u7BcuRy6vNqVNYfHgpwabyf9NdA5EvnTVBsiM?=
 =?us-ascii?Q?d7GI0i6ymFQcTNGkzzReW12rYcIlMm4RKVXjaT9eob2oSKoPSsWySLiIlD4y?=
 =?us-ascii?Q?b5hrG1DauCDDH07Osq5ZgN6j/rn3rSNumbO5gqo3IQF/db5nSk/M5wRV8xJ2?=
 =?us-ascii?Q?NVshKlKxg7U1tDP4FIYSp4oSMaoArZ8M05gINCk76UH4ghgjkBN9suEpYXKQ?=
 =?us-ascii?Q?MZIlUn5jQ3UddZ8hjR1OUhVtgby23NuwWSbLf0926KqaHkKUomwJ7byhGFdN?=
 =?us-ascii?Q?KCfuiMGh9j86tqYMrJyz3SKHHN8ID2+yb+TsEaDs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe38ee7-b4fc-4e9f-796d-08dd68071f73
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:29:55.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Oxa1JU8gcv6+SOeyTu6zseO0n0bSBM8SltNuJ6tfQV6l6FoA/aIqXYWr/gjiiV8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Thu, Mar 20, 2025 at 01:42:27PM -0700, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:37AM -0700, Yi Liu wrote:
> > @@ -579,10 +582,12 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> >  {
> >  	struct iommufd_attach_handle *handle;
> >  
> > -	WARN_ON(pasid != IOMMU_NO_PASID);
> > +	if (pasid == IOMMU_NO_PASID)
> > +		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> > +	else
> > +		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
> >  
> >  	handle = iommufd_device_get_attach_handle(idev, pasid);
> > -	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> 
> This changes the sequence of these calls?
> 
> Is it correct to do iommufd_device_get_attach_handle() after
> iommu_detach_group_handle()?

Nope! It quietly leaks memory like this! Good find!

Jason
