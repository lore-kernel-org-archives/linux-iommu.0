Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A42D792
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524086; cv=fail; b=EYuXW0PKyOCLjCQVedrcDmyO/vS6njyFbn+w700gzbhIn4hfNL12xfdhHJysI/906lV4azVB2HUvwAuKAZsXETY1kptgocVO9MDNR8z1a9NUJK0uTx1NWE9SblJ8rkdp4P8AT970W7KbdFLVXGPpGb/aWFgGUSR0JOJZRRNuEw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524086; c=relaxed/simple;
	bh=QKzOjYTnl/KPXQcud70Npzwu262Fjw1bRKsDI1QENUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iUyLnbLnRROxVcKX6n9+0+dralj7ONmxVFcxZpUTnpxr5OpfCD7i9uL/9jDPtAKqHFLtKL1p57sT9JqKMtagcNQVD2UObiSGKqFuKvFrMDPWaO9fcsHnE5gT6oZnEP/kcaAEiptHtjyF5GgiwBwJ/eKUsDdsz1CJVg3u29YkNOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ELCoSjAT; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ELCoSjAT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdL6lhFTIX81Ne+FeMCGRbMOWG4xPC6qDDQIITpsyYZuIavuyllzncAD610ihsm7uveDynksfRmNElsJxfvHDLYxX0yuifB6uDB1IAyUQTJ3Xe0q4ebJyq5Ejsxxy25E3884OIHr7FEXxAQ66rr+mLc22myiIVYfZujqAM8bIqo3IjtLWLx5FqUSea0UNXzrBBWDSxZPIUcAeE7HrLvaTaOMXpSQXIP4WivsPgupDJafGkwN/sI6Y61pV379+YSjIwOhqmJDKEPgBatswCe3AqkF1TXHq39yHbiBkgP67m21sNwRkVroKQ+N8nOdqxuh+90s9gZTbfu88oj8J7pwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rutzLXKsE3bK0ivTn6dDdXV1zCBZkAnRUq6eyCCECM=;
 b=mPcBMx2RJ9+bCfQZX7nKAOWOzaVwprX97w0TXjCegnKOJL6gYq8I+Y5uFaBqpti7hVNSfc+vV/L7q+dGpcFyCoJtczdZEipgUo1RkP40nn1mqVxFf+TAxoWf614PY0U3BJi5s2r+7pry1RbIsZHsYvRgqSBo5P1oETR5gJzFuDpWp4FDV/ML8rk8uKLkyKd3f75aICqREMOPbvtScFrdYxQz7NmSKduiSXa1YMSmNhi8OIqAFfvw96BVEbQ/6dS3ctJWgYBbQ3OrmLqmjZQR//phyruP7IALaseySjVhaT0G3XcC5Np78hrWvw7IDIcras7GIKzEuwIPZakKQylBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rutzLXKsE3bK0ivTn6dDdXV1zCBZkAnRUq6eyCCECM=;
 b=ELCoSjATbHzrUCBB9Sr4LAoO9y7l8OmM1xTebsVBzHLbSEZx+CZaMLFxhNFeLFxGz0X85qquSrL2OYy5U4uOip1tlHseRoSFb1pYcnqr4eQ2UsvpYuzxNa/3tQiflfp/ls5VgZTR733+D7tIgD7fOMmwhIn8GHdtUsyjaQjCtPoiyw5k5/3NNhF+1olyV6lXjBKBs9e/zOBH7CLAP58SnhiuFQVn+iSgXdTS9zPJpZ/21ujxiQFpUwKwHZhjKrIt8H6/yMCzezEameSMwNSeOLC31zQ+fKjf8pIVMwstkB9M4T5XlDGdqApJgqa6FInkn6zApxWFN6qdQ4/xjtiGNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:27:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:27:58 +0000
Date: Sun, 12 May 2024 11:03:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <ZkDMSfd9BXmsFfb+@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13f5c14a-136e-4b54-41b5-08dc728fb86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y76LWOBSbzZc5VS4C9h1/baIjpcLZ9a+bwvKXx8NQkzek62FXinvdwkQwtnq?=
 =?us-ascii?Q?4fnWMFZOrMKtTw4pjDe5cuInRZVchnmviyRmXXZk1fynUT1L6fuxLJsvPhHr?=
 =?us-ascii?Q?KKvys6koMvXd0OupjxCrecWLTbKhPLuZL2R2KobYU0wBWqqNumsAlyuVLwk/?=
 =?us-ascii?Q?xIBsx+6ALb5KK0AN+XUn8Vns3Ra0bpHorfaTIcmsVkiNn4vwtgCl92k94aMC?=
 =?us-ascii?Q?WWeXIwJKmrH9ExOWOhDIK5wFWOMfZDTEuGsH/MMgsM92RD05fMU5NwJFJKom?=
 =?us-ascii?Q?I37JAYtF2hyxKtfNC2QzUg1VM0J4cFZLX8oOZMPwjaAsI8EzBtZV9/CGpLJd?=
 =?us-ascii?Q?Y/wtIf16XmbGYFVCPufrfa58narcGbWlWyTh0dnOMKDekTcQNcwkfjccAd1h?=
 =?us-ascii?Q?4ac9jQl8P063wpCGNdbAg1jFGW+9fw6DE8bJar7+/4vF/v8pceHwDF0tBLdu?=
 =?us-ascii?Q?EQ2ZR7arkxqmzIMCC0rJFhSo2oLmsMwX4fjhsRvTFlV4QsBdeCz0q2G9jQzH?=
 =?us-ascii?Q?Fm2TqlOEPJJYYkd0GMFdPGzBri4kWKh0TyPIdaVurVBXmLcnxITcbGGTvBQz?=
 =?us-ascii?Q?3ISg5RkUgBepBKKZXJoVQMT9CMFVZbcKt1vZ0i29TMAyW7CavDXnX1zFVknR?=
 =?us-ascii?Q?LUVSTdzz0lrdZSgsvMzEdtD9s1FEX4EAoyQMm3hr10vzjPuXL/qpr5ietDuA?=
 =?us-ascii?Q?cwutzI3EoZkILo3ILCamO8y8Y2ypbtluEniwUvGxHRVKLSTDrkoFbmNhN/iV?=
 =?us-ascii?Q?jeJkLgZ0XH/LWiBXUK2cmJGBfsde9MoNV8jstf7CLgcFNh/rAFVWhlJa/tt4?=
 =?us-ascii?Q?fawSOel/xa2mLKEp0ueY7GB+Dd5hz9tcyCXYoYlLVoAUHAhPK77HBNgMtcud?=
 =?us-ascii?Q?gImNnuarQeeMnCzcXBfVjTrKq7QbPqABtatRxxDjuQXxe+Bks4Hw81zh4/lo?=
 =?us-ascii?Q?ibC2laND8PMsiB9Y5r2Gj3ezm0VtPRrKhFCTmyFZr4Yj7eJ03A3XBWFq4P5I?=
 =?us-ascii?Q?3oK6y8r4/zk23SHaWHE9N+QBi2pdSy8YmmVZLtzQ5Zsx46cpne2OSyl/qavy?=
 =?us-ascii?Q?fn4l2mUdEPSG0TEcHbcN9hVZC16VOnM+If70voQV2abUfphkg2WEMUZjjMQC?=
 =?us-ascii?Q?eR1QgnKFDxVNzEtOoEiGz1sWIMq8yebg0x0yDjCZSLphE2UK24vps9+FVB8k?=
 =?us-ascii?Q?75AuqcvcelSrczPR/t0W5fJhCmP4WB7v+K4SxI3pELFRp0jnU3jnvdORG/Ad?=
 =?us-ascii?Q?TRuobM1ot9F93xVdfbF/Qdb1WQMdn/9r/jbaB7/azw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpyL+ruMkaj1C5O/CsHsmAqFt0cpbFVCopLskZYujbsUmKULQu19z9Dcy5WS?=
 =?us-ascii?Q?FC28x+cm7BYjv0Hv2Cp4OwdhTDP8zxU9DfnTzDJ71ST39pvaVLv1P3nQGc6x?=
 =?us-ascii?Q?ZPO85GQpz4UZK2xzLu256uJ7AVp7QY2PCpmdOYaTANrbdjLNIgXBFhK0EogG?=
 =?us-ascii?Q?69lw8F/BcvmchomVuf5qGXz/tXGF7OkEILaKW1TSkcSkicPvuLAolUE7KVe+?=
 =?us-ascii?Q?2sGxRBgGsHw00Yemwkth6/3etBiIQTW6wAuIPe9AhlF+2mEhGC0cNmCnr3iK?=
 =?us-ascii?Q?4OO++jxK8qpQi5c4NbXHFPpCPMAJDjuchpO54Yic2DiSxBg6g5MMDZhlfLDQ?=
 =?us-ascii?Q?9z2d/yqG8bAQyfAlUEyhlj1w0EB0/XwKDU1ZASHWSAq3dZnry2+OABEjsWTi?=
 =?us-ascii?Q?kA/7iSwM7n9ih2xQ5rpMkuaJybjpr/d6Hft2FEE5f2YSPLivgmSi8EeFbfAc?=
 =?us-ascii?Q?7mGCv5pWApDzCt85lFrLsN1EI+Iw1OuEAGIEBK6wohCyll347s5VprTwEtdP?=
 =?us-ascii?Q?dIYapGMnp335KVz1WsZxCcyIjwz0OWtHwccXucXjaWIdLm1Do4H89eLKmbyu?=
 =?us-ascii?Q?seMOUVy4eKyNGA5tM26jrszKYxGTHG2eJ06A/+rNR8XPWiQ8hBzN0rXAXdxB?=
 =?us-ascii?Q?HiEwEf+/7jMJJAGCg9TcsIccDGtJbVqg8pGhhK6f6wuxauQ0IiMzfWHZUHxP?=
 =?us-ascii?Q?/PsueZe8lyksCW8wXdpDEpZa/nQ1PA/B/8JjwqDbIrcYdV+eqSXnYaH4GmcP?=
 =?us-ascii?Q?RfePSv95nhGkceu2icbd1RrvA2Ie86n9++Vt15PivmKckou41q7u3FVBH3yF?=
 =?us-ascii?Q?EZnJ5bqlw4XGRtobvDkRj9qj6Lgee6j92zopqkl2n6YoDRUcG5SAD9hwA+xR?=
 =?us-ascii?Q?RN9gSZex4OstRo5jvuubQUNjWYSkU8c4kxFHwhdxZb3TxVzbJMe9fztJTBEH?=
 =?us-ascii?Q?bdiQxOzNaqvhvEeGE1sebjf1r9W1+5volVeOjaWpFTOypAq1gfewB+48AX6t?=
 =?us-ascii?Q?peeqXCw9MqI7bBXByRrHud6vVSRhXpvk8Ae0UtV0UzNBqRl8qx9goc5/PcjT?=
 =?us-ascii?Q?5DARqPv4AUgOhyAtim0dZntbnrwu+M3hx8Li+R9YrfSa+bs39dubXO1L8u2d?=
 =?us-ascii?Q?JsMOD4ICHSR1HXtkPgm9XS03PzQBwSOfvItKLsVzaqVluRJFDFjxCxepSRzw?=
 =?us-ascii?Q?bAeiDLrTcGYBHdUGFbrtnlYIircMJEYsfkTnOjXiJ8vAmuku5D1aG77VPUzD?=
 =?us-ascii?Q?s4nnbrH1/pxds90m9bBrSHdY+gB7IYyGf+T/ZKdXO+Po6bDG5GAgh8RGOr0a?=
 =?us-ascii?Q?BFV3VgPeS3cVaKudzWD8rkq4fYGYfUQ5DdLrY03hqagC+kzPkQhgbDnyTN0V?=
 =?us-ascii?Q?RhRUDWG+55X7fAj9R//03+1WIiehIVLQ08ouYU3ToNWu40jUEhMm5IPLnLwy?=
 =?us-ascii?Q?r+AeTk87X8epU2lKh4Oixrb37IonTstsO1Wv30ZGJCspadh/ZoXDI5vBB7DF?=
 =?us-ascii?Q?4BUw4Vy2Pai1ik6BwHPwpprm1HrpG0yFiAoPW/3DS/z4koUqwEfYTYCi0Wla?=
 =?us-ascii?Q?7tMDdRiKWD8SrlT1Yfp/3hrTKnYrXmlgHlMmM1Ag?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f5c14a-136e-4b54-41b5-08dc728fb86d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:27:58.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VcOBtM/1n5D3Gl3H7HkUP0oGtdWWoNNp4yO+9ML+cKD+9UGBY9Sk0kKO9xjGqH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Fri, Apr 12, 2024 at 08:47:01PM -0700, Nicolin Chen wrote:
> Add a new iommufd_viommu core structure to represent a vIOMMU instance in
> the user space, typically backed by a HW-accelerated feature of an IOMMU,
> e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and AMD Hardware
> Accelerated Virtualized IOMMU (vIOMMU).

I expect this will also be the only way to pass in an associated KVM,
userspace would supply the kvm when creating the viommu.

The tricky bit of this flow is how to manage the S2. It is necessary
that the S2 be linked to the viommu:

 1) ARM BTM requires the VMID to be shared with KVM
 2) AMD and others need the S2 translation because some of the HW
    acceleration is done inside the guest address space

I haven't looked closely at AMD but presumably the VIOMMU create will
have to install the S2 into a DID or something?

So we need the S2 to exist before the VIOMMU is created, but the
drivers are going to need some more fixing before that will fully
work.

Does the nesting domain create need the viommu as well (in place of
the S2 hwpt)? That feels sort of natural.

There is still a lot of fixing before everything can work fully, but
do we need to make some preperations here in the uapi? Like starting
to thread the S2 through it as I described?

Kevin, does Intel forsee any viommu needs on current/future Intel HW?
I assume you are thinking about invalidation queue bypass like
everyone else. I think it is an essential feature for vSVA.

> A driver should embed this core structure in its driver viommu structure
> and call the new iommufd_viommu_alloc() helper to allocate a core/driver
> structure bundle and fill its core viommu->ops:
>     struct my_driver_viommu {
>         struct iommufd_viommu core;
> 	....
>     };
> 
>     static const struct iommufd_viommu_ops my_driver_viommu_ops = {
>         .free = my_driver_viommu_free,
>     };
> 
>     struct my_driver_viommu *my_viommu =
>             iommufd_viommu_alloc(my_driver_viommu, core);

Why don't we have an ictx here anyhow? The caller has it? Just pass it
down and then it is normal:

my_viommu = iommufd_object_alloc_elm(ictx, my_viommu, IOMMUFD_OBJ_HWPT_VIOMMU, core.obj);

And abort works properly for error handling.

Jason
