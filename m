Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2D2153D1
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044746; cv=fail; b=Im+CY1JNmZRCjwwxRAB79y9c8d87SPxta7mBB/wBTP1O7NfXZUMODkAsylmpEMFFTwCtq2UetECundrPB4U4gevve8LQd1KAb7rVj0G9P2m95fxCFWhl3WFr5zkrAJXV8QJqvPdI4DGeGedQzdA++5toENws7Ig/8Q8jDkrbiHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044746; c=relaxed/simple;
	bh=kIKgmVBAdbn10kLYaqxh/4yAUnMnLa1/9LVuBhjPhio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZ+t9eu2CEBOUjv50wiRVrhInomHZeqNT+Ddjzovg2wzmWbGOH/V6rHUCXjeGjZ1AFWmHE502GzAJrsIguZURF3qjFtkhEk8YuFpOG9ZSaDo5YNVsd223W/kzKKFWxge+UtydDDDQGGAvnlfOKd0fgza2wTOJLBFOdGj2zXCU/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VKcfCrBJ; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKcfCrBJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3UHDPBVVOwuE2O+wYWUv4Cp5Y4zOAIT6Z6H8ydQIMu7V6kJvup9lMqN+0NoiCQWE64heGv8sKL4EM1ua4WiiEnAjnhUj+l/2X0cz6bfp4Bl4OKjxb2H0hVI2DYwul0cwhoIpL7XhCVWZ3WGXyNTryMcC2zE3f01xmlmWSJuI+heJEQOHTj258CxUNJ3/de61bmTzUjc8eo8dMDWoaW7EOAW/QzbBIMmXfhVJUtOEH1YvUmnSuaK0zeDmHTFS3X8BsdH7wjQXHdeFg9w+Kjfv5yB/4R1i4Y6/qqELtyMsqu6uiMcoweRtbMrmJQvZxuaUyepIy5br6nTvp2UwKBpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWG7QzFyNO3IeY8vNAD5cFDgLl9EBUpbthRD5d9tcqI=;
 b=IqBOOt4xCvrLvBMiz9aolN/A2tuXzRHN3GS5747fWgxhCeUBu87/MUl+3R4v1+BxREiWT/6aLnDwP2U1d/3UjH3Kaa50eHaSAgtJP1EAKOsgeoXDD7lytdGrneHRMnC+R9d8VEi6XMpPNttmHmE+iWvIqpoO8XIKXlfGaDYsyqPEtL92pSHK4n47ersEBjN82DudFWuqqHWdRHNqzo7/ctvBOWHTh5uA3XFgu6Ym97D17DfPnnfawr7kg7gvpKwv/EfyAwOwc4jnAbK0kF25hZH5YYYAfEuoxlkYqOZMHWENM4pcV9uNqyGeX6r/l/ho3mCC7uqOLF6hMt3CCwRE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWG7QzFyNO3IeY8vNAD5cFDgLl9EBUpbthRD5d9tcqI=;
 b=VKcfCrBJ2bW6QauEP7JWyMLEs3ri/fVEkESgutY9B2X8TZPnbDGDY6KzxgIE5/2WS3fFUlZgQnfQe421DziPtZO53szGzQog12sR90sJwYsxgTgluKaQWnmLAikem04PP2fPQlcB+J+2U6zWvOI+l4Xfv0oid0GWKDspow9Sov4FKKxjwLEzeCVVVD3Y7VExQK10v3vTFKYrWcEXAdTpIv2MlpFHZySxiciPkGe3Ahc8HPp3+WeI2H92UH242ksaIG2OJxMcwWA6uV19kzT2l0ensk8c5vPYYjjiCK6/1M7kLs2DzCnpqfS1v/yYOJ19Kqwqr4/Rh7bbrGJMOi1Q1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Mon, 7 Apr
 2025 16:52:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 16:52:21 +0000
Date: Mon, 7 Apr 2025 13:52:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 3/4] iommu/arm-smmu-v3: Decouple vmid from S2
 nest_parent domain
Message-ID: <20250407165220.GH1557073@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
 <Z_OuLJ7RGnChDckY@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_OuLJ7RGnChDckY@google.com>
X-ClientProxiedBy: BN9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: dc61ca23-3b92-4158-4654-08dd75f49084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82nfDlO5FEaVqkOiRBwVkSh4rjDQUSUCleb6MnNJL5IGzru5N0ZCkVvpuZow?=
 =?us-ascii?Q?pj08sO96sJkqa+/VVGtn+2tg8X00VSGomiFz4NAdd45oUof/7dowJj4oYv3g?=
 =?us-ascii?Q?EEXFB1JNZuBz4YJ194xdwP7u83Z/cfC/b6n/Pr58M8/lERrV6cJ7Y9uys8zl?=
 =?us-ascii?Q?FfO2c07weKkzie0ZrJBNlRS+HadUzpwNYqxe1MviS0nNfZiPzqi50FDcR3bh?=
 =?us-ascii?Q?SHcU+18PB0bASVReWmcOT5r+tF4boTP81wm0MSnABULWdRMHrSaRrgPfctO3?=
 =?us-ascii?Q?F20Z2ASNmbBG64JfDg8ti/rrt0T4VO6zpMZFBmeTOPIu5O2RIItFWPPgWAMe?=
 =?us-ascii?Q?yZAt/2QYWA9JTPEpfMWCnaX5RZy6MjhBy1LmgmnmvUzFiANfp2UdpktfIm8I?=
 =?us-ascii?Q?+4Ky1a1HbDt0SN2csg24fOXKkjaot2dcKqk6dblj44WKpP7/ommnLuhsFS9N?=
 =?us-ascii?Q?8wicphehzB0+BPrKqBxqM/0ydA+BTnUTuGnwhOvPk/BYd07O4iSuVX8CIXVl?=
 =?us-ascii?Q?mgtluIhYNuIFU8U5Y7P0GNcuT7i8xuhm02EgPPrU7Oi7mSauZgUuVf6s08rW?=
 =?us-ascii?Q?v1WQuOPZc134rXBy5htW8t9dm1EF05AK4HxTiDY9pa4gJhZmPx9g0bcIhcD4?=
 =?us-ascii?Q?+jym0LA/c0azvww9I+7bwDU+4c12vUDznkOjfejmGbI2r+KNOy0NsITmygLE?=
 =?us-ascii?Q?LWDrzczDumj8urmYG+sKpa+bHGWgKVN6giSxyEqnxHeFkto9uu4sXUrAV3mr?=
 =?us-ascii?Q?3wu3tHORoB8OXwzHHtck44S/0tLc96i0JJtl0UUeO7RFWY2k3B7kxZSp43EX?=
 =?us-ascii?Q?IZfi3UJ2mXSNDGWQIeYcUvlqhEPj9dekL9cFplQMWDFDynUZgcHQeppHv9uw?=
 =?us-ascii?Q?qfroZ3AGl5ADgZkG66tSefW0tD1Y5EcqsWtStPj58y9OS34duZQgtFJJ7WCu?=
 =?us-ascii?Q?C+YB4S+q0RqfAkFPVXQsjXjIp3+Hfl9JunX68677QgffSQpbjzXcfusFipS2?=
 =?us-ascii?Q?V6sPATQHb0lQgHsowE3XvBgqTvspE4Hnpxl+WnL7eff3q8hwdCw4bs10Qbeh?=
 =?us-ascii?Q?ESLSTWUmsz0bwohVF9W5o2eY12VBrKJVQ5nF+sLVyR/bJX66e/H1TKMhJZX6?=
 =?us-ascii?Q?/0sP5+Y7TCQrUwD4KE5m/QcCAj3djFoCwCGTDW4SyyOvRBbz/wy+ND8hKw9q?=
 =?us-ascii?Q?/CZDZSNKOgtdyeE9cIhYItSV3+GfZpTlzEp6yVsgOJrUto/syDv32dLxjt5V?=
 =?us-ascii?Q?IbPgzLEco6mHHG9tvwMQaZlb8gEsURjVLD5yriq4+mxncCnpsLz+nFjJ9G6M?=
 =?us-ascii?Q?4hm0fyK3mIS8P2nDHjwwyUF/MAM42wJEvD91FDx90+sRObO2baTPtFNSDEna?=
 =?us-ascii?Q?F0ytrN61Irjn9qfKxUqq+LfBCfP9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdb6hmG89NkMjl87bYCX8oR66zbPRrf26x8YS9GwcZUEW7V8pTyn0easGTxa?=
 =?us-ascii?Q?V9YsnAnYe54g44r/HfS5QQT/xOc2a+cOe0z1xoqUWUzBJvgRitX2+4uyOMOj?=
 =?us-ascii?Q?D4O3P3EkvCfSu2XhPtUoQ9o14fiH1oZJigNVZVB+bJUZQOnvcdd4ypVYUwAm?=
 =?us-ascii?Q?6XdFo6wcTW9OG1ISTpbQUYaHS7pApouecpIIpQLTRyZvVyFFaNQp4C1AvqP8?=
 =?us-ascii?Q?+TWD6qRKxP194upSXup01DoM7AXiSm3GbRZGDbYm0ON3AzFUz+5bYTF/8oKr?=
 =?us-ascii?Q?v7KfV8jMfiuDx2LZ7suvHlbplYC57Ub7wZTKe3RAimM1e6akN4wNY0rBQCDy?=
 =?us-ascii?Q?j/vkQvWsfxRiH3UBF0x3A9u8Zd3ADd+nYnJxj9OG4STCw/z6ETcbgZmipOt5?=
 =?us-ascii?Q?zbDkfffGqBUNlten5SOGgQEpwjTa1RjUlKUHxEJM84B7uV2Mr/1mB2H3nZ0C?=
 =?us-ascii?Q?m+4C9AR+5ByNdDELvV5Y8fWWJLPKYCiNN9aiqoUY1FVjOhOBkUH9hYBY80tc?=
 =?us-ascii?Q?ffEVAPszrJLwzZuzvgiD8aSRBLQy0wIyqmFAVyStep7bwMQgs/m2dMcoG10Y?=
 =?us-ascii?Q?bwfp6HCHhoXXzRjMXL4dBIYndGCcnhF37SngC9Xx7BbZxQ0zt3E2wdXvGeIk?=
 =?us-ascii?Q?IusIeMPOuwLCPmfxee7G/PagfSJUMZhttO5jFUZj30JxRlUt10KPIFdpJMse?=
 =?us-ascii?Q?B0H1zwsvl3wrSdtjkVtyLZzEfafCtuOKj7xvJygv2ZVKRaYhsIXmilRuwT5I?=
 =?us-ascii?Q?ld46A+MWjQNAYx9EuGGiTpQNsCKTCCLjvY91ZsVGj7SRrwizVc9mFcSesKYr?=
 =?us-ascii?Q?whElL9Py/E2asNCviduzxrMa11gUoD0V6Yo/5yXuopXG9GxbZemxZtpDoL6k?=
 =?us-ascii?Q?c1eitvYse/HRVw6bblvSslkR+/TMlzuFYdsE0GwHte3cbthIxnpho3rLopa1?=
 =?us-ascii?Q?N9NJNwuNwVnEiMougyUB7WwvxJFFh4ZWAf+QZmFfZjNIT3XgtnszPJjvFDU5?=
 =?us-ascii?Q?WSmACuOEjmqagJiyz6+xbQc+/p8Z2EIzYy+7dZ5swq3fSfnacCM8/Ni/yqCV?=
 =?us-ascii?Q?vWPmL66J6yvp4QAlgg0BpYbw1M4I6LarCXZQ06e+Qn/LgYQ3AqO4sRCxf47R?=
 =?us-ascii?Q?n/3MueEd9EY2CH3FX7PVFdGzMIZCafzfhWMhQcRkGMJWsxgVskP65SbI4HNx?=
 =?us-ascii?Q?VHWz+ctZaLa/OSQYlkN99Jk0rq9F246Bye5z8aIwEJrsjf+a7XL1OAIOe4k7?=
 =?us-ascii?Q?nbDGZpXh2/xEZS8U92u+nj87tPHjU/m7WKMyLZiMqm7ZTlPygrjsnFSQumwf?=
 =?us-ascii?Q?Inzub+SWYeBzXautgq8PaySJob/JlaZEnhoNPzRMfAorsrfDaj3RN8ejsHfB?=
 =?us-ascii?Q?0RyEWWK2cE3fA+UDSvF5ni2hmBKk70ef09Ar5Tg/WG6GAk7MTyGXHQhZE+4J?=
 =?us-ascii?Q?Hj/vH+NChr1/xqosHrq3pAtKe+4F2EG95zmPwXjl+FxL+AobqXYXV/kxVl04?=
 =?us-ascii?Q?62la+Zy/IoYCPF+oVQ4vtzfT44k3ac4quS/ZMmyOm1BrrsuRrniTC1KZmuYv?=
 =?us-ascii?Q?060V/DB5ILI+jgfDe+Cgr9Gz9oXh+UHWl1wNN8bu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc61ca23-3b92-4158-4654-08dd75f49084
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:52:21.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx+0ATQp2X1UPJeLXtpl/ejA2oF0oJ1ZZmP5i/6ql1fBLSsa2JFwGtUm+JeUrb6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

On Mon, Apr 07, 2025 at 10:51:24AM +0000, Pranjal Shrivastava wrote:
> > @@ -381,15 +401,24 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
> >  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> >  		return ERR_PTR(-EOPNOTSUPP);
> >  
> > +	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
> > +			       GFP_KERNEL);
> > +	if (vmid < 0)
> > +		return ERR_PTR(vmid);
> > +
> 
> Probably a basic question, I hope we'll have one vSMMU per VM? 

A VIOMMU is tied to the physical SMMU, it cannot be shared across
physical SMMU, so this is the right sort of way to get the ID

> Even if that's not the case then the VMM should take care of
> invalidating contexts of all associated vSMMUs anyway? (Just
> thinking if we should allocate a VMID per VM or per vSMMU)

If the VMM wants to present a single vSMMU to the VM then the VMM
needs to replicate invalidations as required to all the physical
VIOMMU objects. This will prevent using the HW accelerated
invalidation paths, so I expect that the VMM will have one vSMM per
physical.

> Nit: Does it makes sense to create a helper like `arm_smmu_vmid_alloc`
> and call it here and finalise_s2?

Maybe so

Jason
