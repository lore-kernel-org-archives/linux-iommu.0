Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5B1B7D1;
	Tue,  8 Aug 2023 16:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgzSQE080Oib5LXUdc2qCLUDcj8Ci4MuucSOcP5T1VkW/fD9jSdKfeqmVR0b1N0XwWpxzLGtWhw0KakA0WqFw3aDrIrrDe0pMDRCZuqkoFOTD2PmmqNmXeVNI8+M7qX+QUv5Zibucrbkg09lVDPaU0ywWz1GL5NSL3ZVO84xz/uXw+Sc/jkpVyRqAcvuluyID862/4axqInL0O2t1Cv+uE6eQ2FXfMUgUGY3OvVqF/vMKwG5xRa9Ot1f2RE+VyTgKjy9jSYcvH5Zju1qHVaXwGL+FUr9lIH0BFocrevLstDQ5eg72Qjez5ISdYNuXlpZxiiEmkKghlW7oKHO9lbtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++zvF+/Y4HE6PdmyxJWjgtz7gY7tcIfhAXcwcP7l9iE=;
 b=IILIqGvTpXiCjZvw/O55qb1tMMk3yj/pQ3GJ0vLQSBn760fGR+PA6nP6cwTBOrTDgGB3yShZr1+ZUGN0K8KobVQdEdRWA9FbLwHBWm4h+c028aVQUSnWHx5QKhLc/tAzSuxTYzVejU46O5zOKUq+yBMUmjtY1aXz0VwDnVe1YRkwZLfsZ2+CAiuGbJKZihC2rkL8ivWXTnDs1JIIhvfrQGx25fH8Ojjj+mHuL8idtr19zhKROO59k7XEqFk6FkVXtPxTE41QqYiomANIAF252A1pAiPlGAf4EZyapzR/aij1/PrIibIlOv24a1PheJDR01HcdAj1RrAt5Uw4G5eMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++zvF+/Y4HE6PdmyxJWjgtz7gY7tcIfhAXcwcP7l9iE=;
 b=bC3+HJW/KdSoUAF/oOBGVPNza7ike9vfGB7gaFQg5wN9iD2ebqnnhe9u7zVpki5U0W6Shja7MJTt8RyRvpbm1lGkHqrt8cmZBSlD1ouh2mYsMJxbdpg8qy+zTzACB+j/d/iJuPmN8kElq90vY2mXnoUw8fSGqW4SzFpCqRZI4dHEzeFdmbOTo5QSh7eBAoyr1NxxXgWkwAI5xNN6IKHW4o0pHf/cvQp28a7Lum9wUevW4QH4UWoQf5B/ZNdThEwFHebN3X+fguWoEp/xR7kSuJHktj97VQ4TA0AeoCW2c4H+mssqKwa4ZsyG5CWIl+yjDsjnzaUNNSra9+zZxOItdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:54:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:54:37 +0000
Date: Tue, 8 Aug 2023 13:54:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Add a lockdep assertion for remaining
 dev->iommu_group reads
Message-ID: <ZNJzTIgaqimQ08tA@nvidia.com>
References: <2-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <a94abd4d-fb0a-8f72-7dee-82144c90187b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94abd4d-fb0a-8f72-7dee-82144c90187b@arm.com>
X-ClientProxiedBy: BL1PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: c113614b-1760-4cd3-87df-08db98302634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EWZu7RQOzmcD9GV+f1Xj9ehKTPPBFacpyWOG1yWjOJeHb9CbvKDjyeTpdyqhSL6pGKSZxro8XkuopIqkImmzCIkmcKmxPrycfirNCXBAvYvg6fqD8Vzc+R6L7w6/DRNxYJPojJXhVwcmmcdaUb6lOc+EK8nLkeKmHnqGV2rYvXNu+0yuioRfDi9Z4BKRhNxrklU932RG8HAnV7QgR95FGDCipXoIaBWXpTvnNqC5ABzxhYazwtj0wuJr17abgWaX8uvDwfdHPbGiX7a07ABn1gf6nrcl95VYN0Fgm8tyrAY4lQO25m/ZP7f+lA5JcxN5M4R4hg95vi8xz4z+fXEJ8kEwao71KhycLoYt7G73n8bzuHMC2nVrojYERrtUDLbmmg5bDg1AJATuq3CxQFK0Ka5yFk++g8G/xcFP+tW1NBHs7TCHeFN/5DPiZULTENrG3YeEBYHbbjk+NNgwUrwGLcB6Lke+Z23LX2vticIQ9HSBHKdAvwlnc7qWqxechgkBkheO7poZ+NbyJ15C7RtfgxH30wvTAwXaWDw8kPPbX+HWq+29mbfGBPWHsz9GTIna
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(1800799003)(186006)(451199021)(8936002)(7416002)(53546011)(6506007)(26005)(8676002)(5660300002)(66476007)(66556008)(66946007)(6916009)(4326008)(478600001)(38100700002)(36756003)(54906003)(6486002)(6512007)(316002)(41300700001)(2616005)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LURfX0YRlmAkf0JmT4zWAb9wzVFWu8+7jzS5KfugSx4L60/wse0G4tHSVjSZ?=
 =?us-ascii?Q?5erCS+FOUGJvY6IKrHtFPIoZ27TsUL6M1O4X8QyhbZ2kHZLZ79IJbVtMi/OH?=
 =?us-ascii?Q?p+X/QkSBBGUk1otHm0vynP0YODSZfQXisiukAfxrpwrACvgV3EsZaEhkf4Nq?=
 =?us-ascii?Q?TxYebWHxB8y3juizJKcWb0MfPywpAfB9K9QZcxQ6C8rWe9iZAexkIx/KLom0?=
 =?us-ascii?Q?WO+KJ3LBSRMAK5p90OWUSm51+3QBRZmvW+87BBBCzWUNxeMyDJ6kXnwlCYWu?=
 =?us-ascii?Q?ahpjyADrGcjpfYbODi9UkhZLGrsyBPW3OqJfTyxU+njgCWuBLhEh1hZZj340?=
 =?us-ascii?Q?IdUC4FJQ5/za0kH1ruGkj3+rkk7cKIVfrKnPiBpJANANw+6sPl3Ym9jeGuUl?=
 =?us-ascii?Q?hj3ne/3Y13EWht/hAzgUJFzf3f2JfA0YgS7HdHhvWkJenquYpnL21Q1BKX1U?=
 =?us-ascii?Q?6FnjRlzWRr7P6ClwX0hgUbIF1ACCO8Gmjnn5Q9tbQ2lR+FbqOhMBfaUq1ZgJ?=
 =?us-ascii?Q?66baFhnAQgtMxt94THVmd5tQuky5ckcZGKG9it+fpsnLFTJQVsdwHWLlPwyk?=
 =?us-ascii?Q?ADQbfwo/2AEChjp5yuW3PubP7FaeZj83TCYwcjLsgIjUri6Xq1fmRmJad/Fd?=
 =?us-ascii?Q?b221PhW0yY6j6mWfmybFGqnpcmjn0G14QN7GmeHxg9LW0nxp7I7jR0OXRdOG?=
 =?us-ascii?Q?qJwBdeqQmAEB2KTAJ5nd1GatATbWNECDbMhQmSL0lovP3rISBhHvnWKFAY7s?=
 =?us-ascii?Q?YzGxXZniwzNs+63Y9XEenlDbBXbbOS4NWszXnwueGUafkeQ3cvUq7ziU+j0S?=
 =?us-ascii?Q?iz5xdrE63p0roYpZerceAjQ56podYMT1jLXF7XPgDptXd9FoisleprQthV+8?=
 =?us-ascii?Q?22K1g3mNjOEMrHZq9FkZw5gnpyvU7fFl7ku3+KRpeIgqGTRRo3ZICiNWOIWz?=
 =?us-ascii?Q?fpmv2DevCbuyDwZ/M0c9Rh+1YyxbzZEBrkVxqgvSxZcpqbpdl6oHalAqK5Oo?=
 =?us-ascii?Q?86rJj5KP1LqgRur6G6iaDtqtS5TwsoMGuEy8RpuVnX4iCWVsCdOFKeoCPAkf?=
 =?us-ascii?Q?LWWOm0bLMyOxGga91scfQdViQetGjhJoF4lH5TNQ4eW36yjLHBqQEM+nI4sI?=
 =?us-ascii?Q?3tyf6ndKuVa+eglCl2pkISXa/D5zieJy8XBxKAOTmHUADOs1FFeB67zurkD6?=
 =?us-ascii?Q?8r7OxEuKinCoyXFBfM/6/f+XrJI2pNKptcqmIqgI/8jo526tVSy5G4H1yX5z?=
 =?us-ascii?Q?mdU5vqXKzS13+XxzaHc9X5LPG89wLfLAWdOVGOxMhfTaOqyFCHEf6YDjppsw?=
 =?us-ascii?Q?AgqCsb6SDRROgOa2acnYRcFzbwKt+10mpSPqGcrZusAOHuzg03Q5HBkcYNmr?=
 =?us-ascii?Q?9Yy1IVbNRPWhvfIRwizQU6jmAUjBP8+5Sa+Jm4hSVUN56phNMwpMUJHcL+Cz?=
 =?us-ascii?Q?iq56ZU7HDPCd4eJYTP6wyAvsuXAXFKCbta2ve7OLXrUpvc6D1IqXErJ/yp6W?=
 =?us-ascii?Q?VAHeLZIa3ZS1FgGCmUBBlHOKlv6fIcMg3B9PWzge50halRjmr3w5i+Sm4xCG?=
 =?us-ascii?Q?Y2go+m7vJEyIgGWiR7G0osVRn+R6h4ZlWa9eFDAv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c113614b-1760-4cd3-87df-08db98302634
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:54:37.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5UQB/b96sW28xO27OfVVuzV78PdFYdiXiB/yTAPlPXbAAHeTLQyFs/x1lSAIElC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596

On Tue, Aug 08, 2023 at 05:22:55PM +0100, Robin Murphy wrote:
> Oh, the things that happen if I take holiday... :)
> 
> On 31/07/2023 6:50 pm, Jason Gunthorpe wrote:
> > The remaining reads are all in functions called under ops->device_group.
> > 
> > Broadly these functions are walking around the device tree (eg going up
> > the PCI bus tree) and are trying to de-duplicate group allocations
> > according to their logic.
> > 
> > Since these functions don't hold any particular per-device locks their
> > reads to dev->iommu_group are being locked by the caller's
> > iommu_probe_device_lock, and this explains why iommu_probe_device_lock
> > needs to be a global lock.
> 
> This confuzzles me. iommu_probe_device_lock is a global (but tightly-scoped)
> lock because its sole purpose is as a point hack to serialise calls to
> iommu_probe_device(), 

Well, that may have been the intention, but as a side effect it turns
out that it is the only thing that locks the access to the
dev->iommu_group as well. This is some other bug that I suppose nobody
noticed.

> concurrently for the same device, but due to the long-standing "replay"
> hacks, currently can. It is not meant to have anything to do with groups,
> and expanding its scope is a really really terrible idea.

Regardless, it does serialize the group stuff so what I did here is
recognize that as its main purpose and made the probe serialization a
secondary thing, which is eventually entirely removed.

I could have constructed this the other way and said that the group
locking is missing and added another global lock, but that seems
equally confusing since it isn't missing, it is just mis-named :)

> I finally now have some time to work on IOMMU gubbins again, so I'll be
> updating the bus ops removal series ASAP, then the next step after that is
> some bus_type callback surgery to pull the {of,acpi}_iommu_configure()
> parsing and ops->of_xlate calls to the proper point in the core
> iommu_probe_device() path, and all this mess finally goes away for good.

That is great, but it won't address the dev->group locking.

I'm not sure there is further value in trying to remove the
device_lock() around probe, but cleaning up the iommu_configure stuff
would be nice.

Jason
