Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9B43AD1
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524088; cv=fail; b=sCQHgpNDm03urLA0EJZJjRfyMkhvvcogIgGcSJRwXDpPdoVtWeU3MON26dUQb9txy7zFuGcK4d22oa0Mo6Y2aBNxH/KtI4XQB3riAyxZ43/jC6ZqhtEJBAhvWNzK8YDZekqn1S9XzlqjEViJVV0o/Nfi5AOv9SAUSilh/wiLfBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524088; c=relaxed/simple;
	bh=0a0GgtlR/TDNGXVws1QyFMe8h0pKTNZdqQMM0LODjhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJwzzTh6qWNj6rsPE123cYj6GUEsd7DgjyejplMGfNr8yiWfDN/JGwuJ3s9vLnhtFsYNQOxoN5i3AompVOhQjENfcsoATC7vYBDb2bOg8auOok55zqjb3QpFngvGqSGcAI7g6iRSDcB3k7fzF2z2Km3Ufn4tXNQ/NUsmq5anYUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLBeMMCD; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLBeMMCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO19iIwvYiWGsEZ26y0NAXvf+CckgQyvOZ+bEtZrJwXhYLOugD+Gd2wcsGROpsKD1xFENhcLbIVbFFoZJY4Shkd1zEGdkShaz4reuwhZOdVjiC2FXW9yPXWC9QQ4H5eY+65Hqp1AeVCFF/TmAalBABBq1oG4bfxOhuq7KGDEokL+cymhia2mKdwcXFVnR20Dp5/HMJE+1SfOqDM17pwKz/Pul0GEvUMbou4qELsA6eW9cQFukP8HWWBJL+YDH8/Mwken/mX9PMI70dYzhLfzzSjT9rLsm4X8WleJkG8Otk4Bsfrz2wZv25jU0JW5QXHVIJSVHVYMybZLgEgZKFpRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESAXSNWqvPcv8oN0yIrvpCvYQMycgCvwv52avaBHFfc=;
 b=ctSMYJ3oyfKP7V9sMDIkmSxHMXIZAg9SpfVYUh0VE31HLiw4jDazTclXh+kQIYjY6fZQ3LfVEj3YdiT5DHU7FcMnLeMBuZiIa9GhmX8I7/xA0ELo+Z7A1vRyZhYon9Ew4k3N41Ob1VFBZ8ey08goghuUL8OwX4f3YvQgmqkU7oOWuXEWf2CT0la/cFXbfGftNT0BZ7Sf8EXLSjzk+nrf5t4Gp6vcTPx3u8hcOF4LwRyOQfhol4mYqTTe1oeKquRn0Qf3TxtVPmXEntQHRkUesTskf4DlLzCDFOYnrr9KZgXv9gOMDUm3rc07E2EP+XptZKd63ZjRvSf9jI/CDJY/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESAXSNWqvPcv8oN0yIrvpCvYQMycgCvwv52avaBHFfc=;
 b=dLBeMMCDnYLvX1zqd1xT/urkrteyAWyuREVfqI5HoKorLX3am6dMI+jb/fZiXn/W4AiAKWGvtaqT2b/G6obSU9/UGXr4jth/z8Mzz4dC0xWLG8H1Ncy3wyAtSFxDArBnoFbjgBTXlQKrqfww+WzkEs87JPwhE7d2vaRxET2pxi7gDokZr45bJ5ykpiV/a8cHJotmbqOanF2i4iXRBpnz+O90fyuJiYlb3NCE69uqkQ38qjRQkBZf8h4y4IywqJFhknW38jO79q0hyw4NGQeJwtxh7hjGrjkb0wWRj8O8htez5sRvDh77I8/FLVGzwpeLuyAFQ758lnvxvjOzS39DuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:28:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:28:00 +0000
Date: Sun, 12 May 2024 10:42:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 03/14] iommufd: Prepare for viommu structures and
 functions
Message-ID: <ZkDHNP/sCxqxeyRq@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <734ef2f4b2b3e743e276d65f775062c5996064f4.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <734ef2f4b2b3e743e276d65f775062c5996064f4.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: cb099464-b1cf-40f5-faa9-08dc728fb99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+PCbEU+lk+pT93NL31+JZYc0Tx0FAxM8lMMn7Ujsp9MmUv70qJOaCkoRxQe?=
 =?us-ascii?Q?81f4myeDcoMACjNWjzsu4SEtfG3oCHisoCoXLxpCtuZSOUj4wBbo9YYB+sPW?=
 =?us-ascii?Q?xsLC2pTSh99v4/+oYxkxU3CSplKsFTIQ8mJg+QckwYV2eDEyHdoamf7TbESt?=
 =?us-ascii?Q?E/XuAZt+FYpa3UbfsLPMkzAniv/nzTrGLTTtUhcN3hYhmQkhIQwOSifhrDiS?=
 =?us-ascii?Q?8Ltuehrqfx7sysAXY2bXcwanQycYnVkQGEbfTZ+/GyGmTrIEOW7bpaefTCBI?=
 =?us-ascii?Q?uj4/vVC5mYMbZTQzDBU2HZN0VM2q0rk5aAVK7UrNZQKjTfaCyZxptvAS+zMc?=
 =?us-ascii?Q?6QOc9qqyuNciXCEcwheWDsa3xcUnBE31+gZuSGQQPJ5b/JPmFEkfNe5/WfYg?=
 =?us-ascii?Q?KwNr1nlrLydBN16shNS2MQqboDXAyAONakPkovh+IKbtmhqpbOSW3/9JcOsP?=
 =?us-ascii?Q?aIw4nCSC8GGfq/ctLdrRA2/MCBeSkrbCXT2x1kB7OKrRAeS+R6E4SC22RRxf?=
 =?us-ascii?Q?JSP1HIV3pS/IYHEhlnhMKu0FO1T6nAeJ3U9vrKPxFiiTEBo1F4OHp4iQsIGf?=
 =?us-ascii?Q?O8AvgFoIk0yVyeFfNNYRNjCJg2aQIDcVSRAvkEyAX6+owrmuhRNNrAK8trJX?=
 =?us-ascii?Q?xIuR0FLWYoVHi4U+fVlsOUV+sZrWIk4fjaiMCY5/bEft2hDbSuHDQnV4fJSn?=
 =?us-ascii?Q?5QZ5D/Kux4LIAEyvYwNaN8jB5AKqYlAqDlNtzuK/aTrZDVLzYDgCKfcP4x/b?=
 =?us-ascii?Q?53J4cTxFfxs26gJDmyj410aBRTy38dJ/qYpIfkcJzVlPzJ/kQQvjN688+D5C?=
 =?us-ascii?Q?6cmveQElI3M1tI5gcyxI8s4mgLyX9r/a7iVuN1saPCempp94q6q2bbg7DJY9?=
 =?us-ascii?Q?qIpzxxJnofvVf/Hg30xS2UUBKRscioiHHby3Bm/EG4OaMInNIDarCXl0CeZV?=
 =?us-ascii?Q?f2Jgd1cTMc+P+1qNV4nJJZQQEhgio+hqP2Ja3cjze+kdJU72DnoJ+goCA9LQ?=
 =?us-ascii?Q?fKCVIX5C4F1JW1BuZtBYSFWw5/7cj54igK4d9TmdGGQyq6ofMFbj0svAB/rr?=
 =?us-ascii?Q?AFJXTlnoBil+bH+qWUvdFINRb4DZ5BdIoYuX9KURcYVRx1v2T/SBAnQeXexv?=
 =?us-ascii?Q?RKCCWfe05lsKNQt/SGFIXLHkX68Mg9JTdtnUwikZi2/IaHAmkEPzlR5DEXcU?=
 =?us-ascii?Q?tbtfxJA85mLrpSum6I7E5qVCe5tiTc10SI25LI++P/8vHyEjOCr4toae+30g?=
 =?us-ascii?Q?misiOASNUG/GSnWlvXyKEQLxI601vzxJsP6YsVa9xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3l6tfVtRH3+GM5MNc/kjUZQshRYJRukcU0LCtedjK1CeAoPPQQH/2XlgV7r7?=
 =?us-ascii?Q?XA3+ONl7spszXjoXerQRamN5buOG6Mznnl9OwnPm4SbTCCTk9e7Fau7nxjRy?=
 =?us-ascii?Q?+nJReyoudauU/Bhe2Pxpfo3eB4mdd4UK5+VzR//baT9PHIcgpwo0pfHMBmPC?=
 =?us-ascii?Q?BgcEHF8klg1iCe7Eac+0Ii3RuBp+maYBKn/xgRKi0uTQtC9o0vUijCqEQq72?=
 =?us-ascii?Q?c9UOLFYpF+d1nsu/WmpOMFDWL4H5XwjfxLbIBv9ejqy9eM3fpDlG/VDGnPwd?=
 =?us-ascii?Q?DUAe5l9zRm1FoHpLAODRAA7Os7MxRbbsjP39eIxI5fyHTW/S+ZE4Tb4MCqg0?=
 =?us-ascii?Q?GApsdUsQ7Io1Vge9gxmAFCL7yyDoxF5wf5AC0KfGs8ve6NnCODZ1ZymHZ/u5?=
 =?us-ascii?Q?5Uf/QszFcg5KsJ7rxFao0FpyRF92kTp2yXfoT9mhCYdN0ABAg2l+1bGL/f8B?=
 =?us-ascii?Q?eTpfR4K807ROLZl44Oy11HcVfqlj2dI/Y5Mh3817j4Q7VWJ91bMRyH2XgENd?=
 =?us-ascii?Q?bhqASCFioUTDJ8FQrHKQ53pFD/O6ClKNyEuTnhgBlcllFd2lPeiKWtjZnk4N?=
 =?us-ascii?Q?GbRIVsd5iXz7gvuaqXZIPyldRbQKCo2SZmyUAPXs4ZQrvG0dAMU9u7pdD8JO?=
 =?us-ascii?Q?iJC0shibyRKRIqTnVeDn+XJcuum/C1guIu70kSLvCF2a4c2zkfQH3zMrJCcK?=
 =?us-ascii?Q?oQMGYVBX4Xhy8nUipqxMdeWMaQrKm6qTfTZXcW1OR7Rt875sGg5lAV0fMHHx?=
 =?us-ascii?Q?AiE4wrqr/1uVinHFCc/sSl6zhqkPFsVQ0QEImLutWDaOj2QAqT+bIirxXmPd?=
 =?us-ascii?Q?D3VPl6yYUqnzrMCVmZ/T/ARQjbYW9DQ6JiBXvwbVVmoghRnrbaUtPUNUFNAe?=
 =?us-ascii?Q?qNPxLF3DJR6ku+21OwkZOa76cIrgtFl/2NbafHrbyPuVUDBHT+roAhX9HYSl?=
 =?us-ascii?Q?4AMV+CiB5mvP5IJr16RRykJfxG7dcJf8JJbHNODDt3TCc6TkEIHp1kXZOkGp?=
 =?us-ascii?Q?epp3GMMi60f6cPkbaF5kXAzS9sHMtgRFR6vKJnWGKcD8t1mF/+KuKysDjesq?=
 =?us-ascii?Q?CWPOX/FPO7t9GSKEkq/fAdFbweI4sQsIZ6QbTBvdwtsZw4Qmi4zkVtpge0ea?=
 =?us-ascii?Q?uaRt24ExCNypF7BXAzHZAceJUL5RREi5F3+Ipvv8ndWuHw2b05Z0sxyO952f?=
 =?us-ascii?Q?t6wr3azRxYl7BI4wv+ZAMsW1pho+iXw/W8EgWRxUY6s3JBsJSXANXr354th4?=
 =?us-ascii?Q?7XHWKosBMcRecmSbaOFJJUMvu9gRamn+ziFJlyjOse46g+kd5k424PJcUS8m?=
 =?us-ascii?Q?3mH7lWEj009kAPhTt1Ah0eG0kh3aHrNQMua9Dq8AreDKOH7GHPQu4MNTOhLE?=
 =?us-ascii?Q?/M0jVEPD1LD55FBbaZgbHH02YRWJfYX0UFkejXfMCsadMydtu91ffrrYDkP4?=
 =?us-ascii?Q?955YSfW/8tk06l2OrwCZFeXvLg5kPwJnvJkaEyikKid9qR1VckfChbn0RcgL?=
 =?us-ascii?Q?wiPCx29zvYYqb+N2EF0Ur8GzW4tEKI8VrBqERKMQz8fKMl7YzLJk3OiUbccI?=
 =?us-ascii?Q?oYq26Hi0LZU2SEHMMZmauciLiXGKwmrw3FtVZTGD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb099464-b1cf-40f5-faa9-08dc728fb99c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:28:00.1010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiVjPNEFmuvtamg6YhTmsnmF9OhHEn1QXFxaCl1nbA2mZEs7I58iYa2oq8HoUylu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Fri, Apr 12, 2024 at 08:47:00PM -0700, Nicolin Chen wrote:

> +static inline struct iommufd_object *___iommufd_object_alloc(size_t size)
> +{
> +	struct iommufd_object *obj;
> +
> +	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> +	if (!obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Starts out bias'd by 1 until it is removed from the xarray */
> +	refcount_set(&obj->shortterm_users, 1);
> +	refcount_set(&obj->users, 1);
> +
> +	/*
> +	 * The allocation of an obj->id needs an ictx, so it has to be done
> +	 * after this ___iommufd_object_alloc() callback.
> +	 */
> +
> +	return obj;
> +}

It is probably cleaner to just make the existing allocation work with
a NULL ictx for this case? Then we can use the existing alloc
functions.

> +#define viommu_struct_alloc(name)                                              \
> +	struct iommufd_##name *_iommufd_##name##_alloc(size_t size)            \
> +	{                                                                      \
> +		struct iommufd_object *obj;                                    \
> +		if (WARN_ON(size < sizeof(struct iommufd_##name)))             \
> +			return NULL;                                           \

Then here you'd just use the exisint container_of based flow with the
driver sub struct name passed as the 'obj'

Jason
