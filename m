Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D717BB02
	for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108283; cv=fail; b=IFbZuWcKnwYRPciazn4mUX2lV9/h5XEMq3s6vs/E/cDpsZWWQRWVz5fN1d6+r+MxjdU2rbZ1eiV0ZB9gUPCCPZ8Vq1deahu3cM0Qk6suaYgWI8C2TlqOq9sq46XQWWctjfH2CTb4cpqSviT9hOtK9Q24G/1XyMvXmdRzbgDDJHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108283; c=relaxed/simple;
	bh=v/63263NSBf/8wg9m59K0/ccB6xRDC44IhXywTdruWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=br2n+j+QuMAGIw+s3JOOXfOHAdTyTH36+jZz9rLgcBiJMQWaf/2vaRmA40+podb9zBlJxjpCm9zOlVn1ln7AgrmUeMCJBhk7qWaZuiwZvWQP0st4DcZydtj/xoSMra/nN+FM5k6ToJH8aGrIgByGD6HuM/FnDkhmZqUSwenTwUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkxYghIO; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkxYghIO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8ZwVlxP1frSYbJqHEeolr+7yoeWvRGyBtU2wBx5hPEm6DFbTDYnoLmPtG9q+ukHS6mOFKz8yEQpVbxuOodqyjqum3ODYJlvLeX/QKHXlD+NjUzq+2gAJk5M0GiNZB3N6fRhNGfsfz3cYL03LcUOxrs0eZu7CZEZjfgKQNKlewtrR7z6VtIDSUSgdn5ncOu1HkBtHRYjazwSSWDGATkKHYC4WbqhNoWPZ6fj3vGYWi8S2AaXKekGUERmaQllIv4vuzxQ04A2UoEqVoum9vV6AuO0cTepN5Bip2o5wMoqIAr/RE3H1Zi9TA9i04UbGvbf+PXSQBgEL6c5ebE0FrzeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E5H23x40fxmDog6KH2x1and2Kh2vzQED6xjhx5qr0c=;
 b=nWFl8UJXjkhSu+TrPwAMrFms3N8R1uIHXIFI0PkwwIGoFwJo4ecqB6w91tYMorsMEG2WbiZZimeAJA0WSqdeZHxU7BkdLGRFb/V5kzn9dXtFfU2BXdB2e3IaoBEo/al/E1+dGNzdNieC6znH0EV+/31m/jb3T4oISP8Z7ay1FoXMieXCP0RinkOh+3oHBqqkeF0NCTOyunAXOPOBGMKjvyRWltnqN0mDmLD5zF1v9C2Eh3E5FiwJ3a4BqX7WF3RGqSFdw1fYHGrDECXnOxq94x3VRJBPqxX2zOrL0s1PPCxG1buVNE4MXVHKTdZqDvjN5mF7o+pP99IAAXLo2zOvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E5H23x40fxmDog6KH2x1and2Kh2vzQED6xjhx5qr0c=;
 b=mkxYghIOqI+HuqpGvoJXtr3PAIXyxanPdAepQZE3dWk5bC3jHxPE63I6RXXM8BeEWR1HDixjPQUjgIN/U/u4aVdvjGUcFA8oPojXkBofmDm6S0nI1/iAKcV4i5r5fp2cQOorTSAOGEHXWTaR3/BsB8ci6BOv+bqx+ORMw3ktdX4OJNPMYJQAmGI7BJjN4t5Un8VdrEUd0kZrtL5nMR3QO7AtuKQfYX+/0fpYTV0E3Egq/H7GCTNZ43l4Qbfsdei+G0yRAvDbd7xM2MhC35lTFGP7mx503knm+hjWGja+tyBp/shzXDyo2bB5GdHUX+4mIk6RK/Aa6ifERhzSRdO2kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 12:17:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 12:17:58 +0000
Date: Tue, 11 Jun 2024 09:17:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240611121756.GT19897@nvidia.com>
References: <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
 <ZmdbnGnp73yR36N5@Asurada-Nvidia>
 <20240610220110.GQ19897@nvidia.com>
 <ZmeGfqp26c3sGBmF@Asurada-Nvidia>
 <20240611002839.GS19897@nvidia.com>
 <Zmed4AtFjuF7+lWd@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmed4AtFjuF7+lWd@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 895f63c2-d6c0-4876-1958-08dc8a1087d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xFecqQpVwBNr/YtdcFIPyB15X/yUe2RFjDChmQ5RFR/KgKV/Bj9jTbQpgq9E?=
 =?us-ascii?Q?9L18uDU6XV2n/iGE2Y7U1hOwrEoz+lzrAtmY5KdbvXV4u2yfjfmLgTXyntdZ?=
 =?us-ascii?Q?LeyDOTTQLxro+jjqPNUxMXKyL9UDwrr5n/6n/m0Cq7ddjpq2Qnzp5Rj231SE?=
 =?us-ascii?Q?TD3kRXYNxXiD414vQtfnHP6eFOWZdV1mSKbcIQbnYB9yJLZEcQSIgXH91fGz?=
 =?us-ascii?Q?9mfjfbf+lC7iiW7acyG6cFHR3OVi7oLQIR/4IX5GxAQCrsZynzV8TI6qrcPC?=
 =?us-ascii?Q?BL7W7aqT6i0cuxjdkEZ6DOmZDh3+QVkpqXD5qGMgWxPESzG6oheeF702hIpd?=
 =?us-ascii?Q?Zrw5A9HQAm6/u/KH9ZuGKYEr7kmlxcTWNiNy2c9q5Mj5rvgTL4Ih0lOgCLWo?=
 =?us-ascii?Q?BMnLIrLoNSPDlfptgbe5Pyd+uSgS2Qj8okRAVznp2W/GhiNfTQLOTm8aV53R?=
 =?us-ascii?Q?b5Jrzp5z55wNh1EzfWUmenaON/+oW6UOFdvKNJfiY6gAruWGQNngBSR9o1ql?=
 =?us-ascii?Q?dWlalfZyfWcPIFII2eJbDRg/slaoWcpnUzEyjWtRGClKNUc7xz7RUok657Ki?=
 =?us-ascii?Q?epoKGZrnzJB/Lo3ZdH6R5j2XtkFchhBA5T8tYOQtwNIfZGLsIUvTD8Sr52k6?=
 =?us-ascii?Q?r0xKgctakMZHhEuFg1Sr1dbHcCbCHRp3llmr8m6X9tPj81r8qvCEt3+lc0DK?=
 =?us-ascii?Q?bnkT+MLg7oWV4ib+jipizidBkxhRmob1n2DzpccI64ubV4STF67B73E4kUlW?=
 =?us-ascii?Q?ha+az6PCJGEvSNV2xmAaSCtqhcYhAxslHiRFqfw+Q75U+yaIoK9lm6ey/6RL?=
 =?us-ascii?Q?W2c1hW/GWanUpUyHVWp3ipGxSJ9NGpXV5oVSDwDO6tXOdNKryehmzbyZIm66?=
 =?us-ascii?Q?uu7GkR9IhKSGggqJ9wqX20aANR1lH9+b6636h9Y+Y85zOY3KJX6wD3SMjVse?=
 =?us-ascii?Q?cGO5q3guasY/K26oI/1RjKOtrOvF/IG8L7H6b0voGiemoJqwjI17Uo1JBI8O?=
 =?us-ascii?Q?Dui44XXC4jUMsSxvr/2n/zGjgBlaJ+2InCHiAU6ot01rga6wuaMv2rvK9F71?=
 =?us-ascii?Q?HR6I02eHXOKCCpwPtrvEFr/rR+HyeJLpjthcn3kyQiSRGdjfTISxup7J6m8d?=
 =?us-ascii?Q?+5BlyAB1Rboh+wN0ntXy20/yD4d7Vs6ETkx2BUCZwTy2n+y93pIYwFwAmjCP?=
 =?us-ascii?Q?uQ3tH2+O/Hkdd82OaHhHXMcVGEzTnug6WGaXv8uzsW6F3m+zN0JsJjMgE6Uk?=
 =?us-ascii?Q?+6LT4AnpOsZcePI7sO/5RDCfbsJSouD+iMhLZzjQeIgTAq8q9XRhBEhknm8A?=
 =?us-ascii?Q?mgt/TN9zsT8MOyjXkZOHCiyD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5u/+IQ9LcwYjfzSFifxumpscmkGRcZUo23YuPawIP6pGlQET9qI2CGm+oe6?=
 =?us-ascii?Q?/BT6KkWhyDhNmjCsrFwor++MLvzVyNFxr6s7k+Wzk6SBoXKklnbR3O3Yl2nv?=
 =?us-ascii?Q?Ypi8Ar0QwrOy7G0I9EjJbg1yMNAkpxCee702/+fjNzI0j6aMzHDowfIYaIdh?=
 =?us-ascii?Q?2VsTo/SP/xu+blwaV6Q5bYUs5H7orKxa5hT174mgjKkxR+qk6jvz9myWlv9i?=
 =?us-ascii?Q?4CoykPo8pOa0pEmCORXFXj0QptkE7HbCTtZZCR253al+YGpV9pWq1Y79H1Hp?=
 =?us-ascii?Q?hth7+I0033MzfK6rn34Xh8TG40N/96kTOxSqk8c1YHnIPwBXDTmLMVOEZ7k3?=
 =?us-ascii?Q?X7OL8LW156aKHEvWS6cJlG8qsVpZaI7FLtrz/jnW8Kg8sOhY66TAxTNCdG2q?=
 =?us-ascii?Q?QvNeALODRwWt9rD2AFGYxePREIzapJBw6CujqHPEPO9AQpsqBFwVsT8vJCjY?=
 =?us-ascii?Q?fCsMR/Q/OZ26E0KYXwni5S51bpUNJJRjiThkR4DXimlBObP4tN8XxWzJikDZ?=
 =?us-ascii?Q?o40+2eI/GILxIwJPYBYOGjEPIM1yk8sTR2DmdaeSs7cRT76+fYGRiRz29wkZ?=
 =?us-ascii?Q?z9Har9lihk4LNaWdQ3IqpemXSYZehGv/14dBktFyxmsC2kHpijELL7rsk8RD?=
 =?us-ascii?Q?/7PfaC8YDAVCYabcPREZATIin3SytXMMy+TAhsMmoG5UPKTfWLT2QTpHDPlE?=
 =?us-ascii?Q?TLiOotBI/RNy71X8SrVKvwBg8IeFQ3STRN6yuQaWnGFhh9a+3stTaWT7Pqnl?=
 =?us-ascii?Q?IdHG1RB5cus5Vk/Z/QtyX/g6hiPlb5LcY86d8QI0uuUmp0KM8X4b9O6ujamu?=
 =?us-ascii?Q?SYuaJNCsN49EU3u8OieOOxXWsl0nFK+cofy4RqOfOYadx1ROJy+gAKYy2RUt?=
 =?us-ascii?Q?yqliOZCoukVa47W51pBVkfAkSjBgW7jpj5cRc2WK+T5fhkuZex9KwrDSM/nA?=
 =?us-ascii?Q?8VNFQNi2vXr/O+CULpVdOV+2PeTj9ChopolpugFvlsqq4Z/0n9QCM7ColECb?=
 =?us-ascii?Q?8bxIPbe3fx+1G9p0timDjqlhcdtuJb9y1vNe0r+5pbsSclCgn5AgtwjXckAa?=
 =?us-ascii?Q?tQfio4cJ3MtzI42BgHa0QKSgZSrxFLxdTpdAN2WW0Shb4xU71tLShOZb11Lm?=
 =?us-ascii?Q?PK/o54uZUsevApVISlUZ+Jbw0OUj7Mh3Ydyv4DPNv6JXY63wyBUWqaJc23zm?=
 =?us-ascii?Q?15ueCnTZ1Fajp1NxixEExzoerdplSWyVM4yRhvjEwvMsHb6Lj5ay/8k0lG+9?=
 =?us-ascii?Q?DJuiVjfxGcT4muK2AQC3qI9+W8jEqx7sjoRPA/0FL1+9luSWFY64vToKYm2z?=
 =?us-ascii?Q?3ftSELNewRso5gCybXYVYP16NRHWNVm/rhQ6s9b5IeHAshphQgdsvoDOhbKN?=
 =?us-ascii?Q?t2hSt0QrHhsnCkXMSHnyJ4PvaRSjbvkOnFu6QIj0CYGJZUNo8Q/96rK2QboG?=
 =?us-ascii?Q?iSKr8OOWf1ye1/qEravMv8zFRX0ZElxXoFrIe7jCQ53MADOSLUjKgcz4l6c5?=
 =?us-ascii?Q?7x5CAKNc6rXioO7gb72QCSQy0DuJlr5nUD1X6o3NNS3/SNyrnOBIaQtNtbIw?=
 =?us-ascii?Q?Nyfz/h9Qtk2CKTTJfJh0YzEf6fF1TyV/3x9BlWRI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895f63c2-d6c0-4876-1958-08dc8a1087d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 12:17:58.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfUqYGA1Ly6++3H/P6Axji1Xzy8z6lw1SlKsQUWBU4rDS38YaHS+llXbJOcDoqGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156

On Mon, Jun 10, 2024 at 05:44:16PM -0700, Nicolin Chen wrote:
> On Mon, Jun 10, 2024 at 09:28:39PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 10, 2024 at 04:04:30PM -0700, Nicolin Chen wrote:
> > 
> > > > > Actually, even now as we put a dispatcher in VMM, VMM still does
> > > > > decode the CD table to link ASID to s1_hwpt. Otherwise, it could
> > > > > only broadcast a TLBI cmd to all pSMMUs.
> > > > 
> > > > No, there should be no CD table decoding and no linking ASID to
> > > > anything by the VMM.
> > > > 
> > > > The ARM architecture is clean, the ASID can remain private to the VM,
> > > > there is no reason for the VMM to understand it.
> > > 
> > > But a guest-level TLBI command usually has only ASID available to
> > > know which pSMMU to dispatch the command. Without an ASID lookup
> > > table, how could VMM then dispatch a command to the corresponding
> > > pSMMU?
> > 
> > It can broadcast. The ARM architecture does not expect a N:1 mapping
> > of SMMUs. This is why I think it is not such a good idea..
> 
> Hmm, I thought we had an agreed idea that we shouldn't broadcast
> a TLBI (except global NH_ALL/VAA) for invalidation performance?

I wouldn't say agree, there are just lots of different trade offs to
be made here. You can reduce broadcast by parsing the CD table from
the VMM. You can reduce broadcast with multiple vSMMUs.

VMM needs to pick a design. I favour multiple vSMMUs.

> CD table walkthrough would be always done only by VMM, while the
> lookup table could be created/maintained by the kernel. I feel a
> vasid table could make sense since we maintain the vdev_id table
> in the kernel space too.

I'm not convinced we should put such a micro optimization in the
kernel. If the VMM cares about performance then split the vSMMU,
otherwise lets just put all the mess in the VMM and give it the tools
to manage the invalidation distribution.

In the long run things like vCMDQ are going to force the choice to
multi-smmu, which is why I don't see too much value with investing in
optimizing the single vSMMU case. The optimization can be done later
if someone does have a use case.

Jason
