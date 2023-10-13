Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A21C6A4
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G5bVAuFG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4HxtR57SyyUz4qZCpAEnTs/DAY4xoooewBG5x1IYKe7OxlVEPV+bOF1FULJGDnGOmsYUeSXOFNrquzED5NnuVnEdG8qK6a9LoJsxpFUbc82WVQvvm+E+v4/AI9j5n3RoiX0dIus4X+UBDDxScouV6Qo/yG7ZpE3y+l8cq7jlrpcC+3RGIJIs3le9OdVIa4eYGqMsvW2wvoH5z1B8jsfdwh0UzmkEdx/q/SBrBlCFrUBisHKEMAmPVvJW3AKFh9Vb6WbIEC8NbVfvZb8yWrqObOPtnMeNIye0QE1q1Z7S46c6+Xj/oBfTjbm/Otpxoy016ItevNMOzoGZZH93ug3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NfJelzGPZTRCZo23RzHrIm5tzQq22cZm5FdY+45Y2g=;
 b=bw0q7aK/y8LjkdJNOtEPppwNRqFO4ghZi2AxQcZMcF6mO2j5NkuOfpXkTFKPhqBDwIeGgSWRUOAvTgyo/jTdW3Dc0DULJfZ89M7jpY039LKv+5N6vdH40OZRMx4JPub3jqOs4cSAwjUxGh8w3e0VY4YAjra6rQGafyzdhTqpEKC6THP90M8FGN8rkAr8sBE8SlBOhABiaAsgB+gcyimk+xb5Y4ieC5322crc0Xk2U3aU5I0bfHZxw8QlDZ5R3DOAq8Y/tDUGE/d9Txthe9DUIJgdT6hcRAAP+1nALGQsGOkvOp+STzX0MvUWlR7yYpVh4iIh5pnWu2FXIFwOXF4imQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NfJelzGPZTRCZo23RzHrIm5tzQq22cZm5FdY+45Y2g=;
 b=G5bVAuFGJgRTjGnsq81UEKxBMUcd03SexzGEJ6eXGsjQI4rwheG+yJwuFP8iY6nhRqMwwBP39M6IZ70isuqzYdEUNabnRy+SkkcXBTwyPeGcy9/+Bw3iq2bLueFXj4L7dyPc7lZa+S9js6wPCdqFsGFckSzfg1bB2gqAE12B/NAsMgOhYsxdEiz+2Hr4/1B/nNnU8sqL4Z4o6j9an2Rse+njKEXDUAlkIfJPVGrkdAUgEe26BVGOxVfUWbLu+LvKQcBXNx16VX9QbAv8Mu22bCjcWi1KnZ42fuMlRJV997ZrM5smdzN1PZDOvvLNYEuy2vB+PYGMC0KhE5JuXTbK1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 16:05:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:05:34 +0000
Date: Fri, 13 Oct 2023 13:05:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Yi Y Sun <yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 03/19] iommu: Add iommu_domain ops for dirty tracking
Message-ID: <20231013160533.GC3952@nvidia.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923012511.10379-4-joao.m.martins@oracle.com>
X-ClientProxiedBy: BLAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:32d::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1430c18a-59b4-41b6-1f60-08dbcc063b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SLaznC0c8xKybefxgS0Cb9yHAKh99D2kvJ9HoHOgBiRgxAFnOhxp85pMg7gFu0Pqq01tstr4EKqve4i8tU2hp/SzG6tS076JZhb8j/AbaCBmNIcvqHOJ6wX4LG2/Y7OqZc3+f47/eQu/KSvkZdrOCsRDZ1QEzV9kgGWvG013a1Pjk0tYB8o84zBEo2TBhCXM11W0+ZxrFTj94ETOABFwc4IBCGeNtWcZQeoLAsRupsLFvnUKlDDx8s/Co/NFvhOQb99yXAY1KfJy63nwnrifYEO+SwcnQXzhWdiML9Hc74u489Q2Yp/8anRrfs7A8prLEm7dkDHBQ7QygEpOqLD966fHR/F4JJ8ItFE7X/Q5/Chk2TdB+qpgl4alEc9ox1MSMEtS5qbiJvRUkBAueoRx50D+Z+P9FnmH31XK1tXuWRCJe6u1A95dO0udbErWn9drFbiEaHZkvzg4mJRAfc5CHgF1jEhKzC7mxD0IiLd/Q5DrgwK9E9qEBJadUtTLFSZJZ9RAhTJ6aaHS5Oei58bXJJW6QZ0FfhxuQWsC3F6bDc1KJXCaSVMIamP/AE6xuu6ABlKia5Bp3rnPzyTyI4nwcqm1MHMfvLBN8CqHIKixsno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(54906003)(6486002)(6512007)(7416002)(4326008)(8676002)(8936002)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(5660300002)(6506007)(38100700002)(86362001)(2906002)(26005)(36756003)(41300700001)(1076003)(33656002)(2616005)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXK6FI9g2XakUPMmIqjKNhy+uVjDkDF5PEzu0OlcB3TZBrlOcq4jQrrmziJ4?=
 =?us-ascii?Q?4ucsYFEfZL0XNBUsbbuqlIruQTXRi6+fD7Ht23157sStenAbL91XXhZoWkb9?=
 =?us-ascii?Q?sq+wbbG47ziXZuWFuIzDcym3cPl+UFgPA2Pn01IdYTjqSPj8y+5nJ4aA6Pga?=
 =?us-ascii?Q?YWL+DfHvsAXHYm3x4NOxl+7pybFn0/h3kqX7559sgd7qGJV6SkN++s5BzgbE?=
 =?us-ascii?Q?8v0hbkontp71hAzqkBr7rwQucAHemeKmWgBgx1uHec+9t2bDUqUEIvma+8yN?=
 =?us-ascii?Q?rXdWzFKW54TzKY6I11i48vxCc1KZgER9EodiLFZjvuPra5uBsDsXxfDalz2+?=
 =?us-ascii?Q?JH/gzrLgHfO+m8xi3BofRDVh5hsr1OTTj2tdN9M9d0xjq2IpgN1S1dRF2aiA?=
 =?us-ascii?Q?XdYiEtR6s3JqRJKzw9aILKXT6oNof9TaKtVcJRfff10/2JcejEm/Cg1ZBQ77?=
 =?us-ascii?Q?UXLB9Dk9eH8OEjDOwXfM+SWVnEj2TWZle4iONn0YEqaE4dV4XhbFjN92isVF?=
 =?us-ascii?Q?6nw7C2QQ+vco9HKmM14CyYK5DiFVVoguHfIlUOMdhLwLqmtQBVtlavp1YlN3?=
 =?us-ascii?Q?r+D5ZpT86ky7teOQY2xruxOz/9EhxbB61coSAH08VMJwOovNPzhLbWt5BN8a?=
 =?us-ascii?Q?LNSTWywAuG6I6z7oF89Wz4lcZt6CHfdFCG//qFt2/dkYo1jMOOKOgGfeThO+?=
 =?us-ascii?Q?kIma7pkCQdxxbJkeP8Z8LCrPjm5xjS3tGOmxnkUvSFRbQJwMqO5yLoIDECUY?=
 =?us-ascii?Q?HJ0wAa62LQYhjuFN6D6CsRpA3FkeV2peGO0wKPkO1EWLOdcWY3jWXDPEhDD5?=
 =?us-ascii?Q?UAvq7ijicHRWYgq6Nqer2Yer1k4V56qDaFg9YZufBAf9zAHI3X9tiOyM+2xh?=
 =?us-ascii?Q?TtWRH01gOGQkNQ923biyTMD10NErYtR36am61ROXJlKwYuxeXYrMs1p8YpP9?=
 =?us-ascii?Q?D2uBP0laQhYfCnypakmMCunpzKkzYZao4Wg1LDB9vJbLt15TnQiLVn0xNssC?=
 =?us-ascii?Q?Dct5bZ2Gk9lKiZQ67vybXTYhBa1Ie6T/33m/0DYBFnCKZGlcHXD7YNlgCCbL?=
 =?us-ascii?Q?V+ekkH9sPVMk0HtRKoGcp6pYtHXEHOlwlvUwAO/x46tpMIZdQU06++/hiGFw?=
 =?us-ascii?Q?CNpIuhRiIEt3i8SJgtzyCbxJv2/UfGbvcfv+fiDs/T61FkRDpwhkMqsNa5RU?=
 =?us-ascii?Q?Ux8w2ch7gwVkWsHEasUjK0f9mZRfypreDDnYtqkVgifWrBN3VRW4CUMFaMWQ?=
 =?us-ascii?Q?zVxZUO84OQ886+P00+N9zP0HjtTs9n5KBvKTEpNFgupvjfTW/Row1gfXJlk0?=
 =?us-ascii?Q?udOkJE+LC8RzEx1peeZJvbNgOaPQo6ZglXJVCE5Ej8bcNBeicBDgsYFcgpsO?=
 =?us-ascii?Q?ycFz5GFvUphnPfSUzGwrvUUFxcFImdsoyDFp+LGcutN3ToEYnGBC0y4ANdR0?=
 =?us-ascii?Q?pTsEfokK4gte94ysZQFZA8d5ka13xfn9JwPVdZeTCcePFMFYCFP2YDsdsv1i?=
 =?us-ascii?Q?6CxofRglweaGT/OI9mqliAuizCe/eQbGhH/Te3/k61aX3fSSteWWnOmxhvJE?=
 =?us-ascii?Q?rXhM0Ot6qGu4h+8GQbpCO7TwLzBpkI94MUPyMQcp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1430c18a-59b4-41b6-1f60-08dbcc063b45
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:05:34.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJe44Ti8m3eRCFnSd6n3MHhHfCXUr4gte/DlmJvhOj3bdH8T1bdg9yFQQ2XIJrYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212

On Sat, Sep 23, 2023 at 02:24:55AM +0100, Joao Martins wrote:

> +/**
> + * struct iommu_dirty_bitmap - Dirty IOVA bitmap state
> + * @bitmap: IOVA bitmap
> + * @gather: Range information for a pending IOTLB flush
> + */
> +struct iommu_dirty_bitmap {
> +	struct iova_bitmap *bitmap;
> +	struct iommu_iotlb_gather *gather;
> +};

Why the struct ?

> +
> +/**
> + * struct iommu_dirty_ops - domain specific dirty tracking operations
> + * @set_dirty_tracking: Enable or Disable dirty tracking on the iommu domain
> + * @read_and_clear_dirty: Walk IOMMU page tables for dirtied PTEs marshalled
> + *                        into a bitmap, with a bit represented as a page.
> + *                        Reads the dirty PTE bits and clears it from IO
> + *                        pagetables.
> + */
> +struct iommu_dirty_ops {
> +	int (*set_dirty_tracking)(struct iommu_domain *domain, bool enabled);
> +	int (*read_and_clear_dirty)(struct iommu_domain *domain,
> +				    unsigned long iova, size_t size,
> +				    unsigned long flags,
> +				    struct iommu_dirty_bitmap *dirty);
> +};

vs 1 more parameter here?

vs putting more stuff in the struct?

Jason
