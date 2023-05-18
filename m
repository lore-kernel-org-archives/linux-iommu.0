Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE523C8A
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 13:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW6EiHKt7OMM2K+uC0IcYDbBHOqXYIZP/oBL/q6XkIYKOUxjKXdV5msBoDcPXYGDwYS9+YsAezp205il4b2zB7efhA2vJSAgI9qPcpfuaE+roV9uOl1jcLv0zt2QEQ3/EjAjgQ0t40thtaNL8Hu1dioNCi8J9R9klGu961Hvm9p3IHzs9EGcLEnbdIfXez1oiaVrigPM+0G1ZSuxkkXLx0yXjxTpv2xwKBWDE7DJtHyM4EcUtCE5cqP5UFOYVPiGx3TVUvVet/hXPxQFflMO93+VNluPKxHCIXMlV39EcYwZcvrPHvX46lua0mmVNHY/6LVMAsox7eKnuC2VLrRVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlt9bPgpWMR9UXW7D1z5+QCqugZbFHadqtmva/0VUag=;
 b=SDJfwR4xDrFTapWF2DpJWMsWwf3iyuYjK7uiy2VFxSfv594crQsDnpPCeJjeM9DK+RPh0yoOX8U37B/Jn/FjXRSzRvA9ANjN6DDak7xlWfIsBMmlIoHftx8FO/vKVMlDwr+sG++Uq/yz918oV2X6U/RX8eC555QMRKFW1HUVoMGOX90qu6TnBWQFZootWKVKZ2qGIEDCojovK2ZzHU/EZCNVWMUqH8gGDxfKT7yWaMkZ6aYWIpR4c7T6bLIP+/2sMkRdQJrrHNBnlZNex4ciIdDNWLXX1yW329PVrCtYdTSiUfRIjG//J4ywpMZ5AlM8GFKTqaxWYEBkNVqStSiOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlt9bPgpWMR9UXW7D1z5+QCqugZbFHadqtmva/0VUag=;
 b=lHaLkk+8tybgJ/SsTCsaUF2XuGAbaLi/G5HeN6vk0B2ECLFHtaqBdCXH4rL1u5snvjmHGRwsntp3G/Il58GGlaAbaS+w9j/Wp/LUWgj1IgXgp5RbKyaauB7aOtXc0eTmvsI6lytcAUuq8Yvhzi/n9zoNs/cZMBC3DZOT+2S+1+ZiK+CKYNtqK8ph2BlckBN4Ob8h3WvkbM6u3ctUccLCmHdVH7O8LZE6vjMB9SI2fQMBqw9qLLP6Hn64jBG4XWkio6OnoAlsHkKuzcW4S791lOdGZBknDrbqsu1B4fQ7MimHf/LBfxFQaE4nFzokT8LHZ8vC4eVn1UX3hkpN1OWBDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 13:59:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 13:59:14 +0000
Date: Thu, 18 May 2023 10:59:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	eric.auger@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev, akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <ZGYvMDbkBN+2UgzG@nvidia.com>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica>
 <ZGT+44a6RYZ999kz@nvidia.com>
 <20230518135638.GB2587493@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518135638.GB2587493@myrica>
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7283ef86-9ae9-4daf-cb1f-08db57a8106c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p+78Ah3lA+YXziuoQuQwk5uAaK3bexp6+qlkyVZmDCigMGpuBzarstpT21iYKwCHqo7CdpfK+m1wKFDpNng79GZt+d1/X9W/0Lf8n7rzFuUO/JVlrMpDwvG74sqbq2rJpYPV46ub1qpnnz7xgsazx1lJ89NGvyeNScqOP2Q30+460aF9Q3rQ+i5Phocz8z5DvVFJZjOBvhTvot816vxox8gxFVGkau9DAGGdsFx/kShOELgpqPH8PqY3aXTuv3pjoW5DPbXRHI5scpN8RnD4rqRI+bFp0AvEz7G41GKuenzUqD1YwMgQxfVKe0THrkUbQVbKb+gCvVhCrXvsTBuB3Ek6+T61TT3xFiWz/dE9BqD4Syfb+n243Va+YN/9NucpwqqcANOFOTJTqM/J6XoQ11Xaq7XwseAEPmTpgsKcnM6HYhHS8NQ7Qz22vgoPWVXGKUqjwR+xgHbIa87B+1ZKZP+VZYUBlsEXKnv14XlIKabjIxI8p/r3tXkGH30MCEofKEQw0bWBwp/7x///rX+oSrKrgQQFPYQcn+YricUQE/5InLCMIpUox+Xy0vRVEgtTN28qS5Yya4nO+mDnAcQ1+i27Oeeh/lkBcncjZKPFc/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(478600001)(316002)(66556008)(66476007)(6916009)(66946007)(4326008)(6486002)(6506007)(186003)(8676002)(26005)(41300700001)(38100700002)(6512007)(86362001)(8936002)(5660300002)(36756003)(2906002)(4744005)(2616005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zjwns5imZytruC1eMyfU/u19+hWBMK5Z2TZX8MCL0ULdGgpFgkkCBDfcwymS?=
 =?us-ascii?Q?8hcdEvjlnhiNlJRZJzqF7vH0ZCgql1chzd3044IU0uZu7lITf2FjpctV1Kxy?=
 =?us-ascii?Q?WldUVaXo/VhIPoF780uk6d7PD3Roulw8JSvio6/wPAGaGtqKdpF+kMgDLp2X?=
 =?us-ascii?Q?7vxZ2Bjn+zHrlTGp3D5iBa44TisDoHJe7+aEROdFJPnSSkpoxHtxrZBBHsTb?=
 =?us-ascii?Q?/vFavDUFtgaRDvz1CVkpHP36i3THPIEpjDZnomjpCtE7IFUdcDErSR+1m2Xt?=
 =?us-ascii?Q?8UxIUBEM2ARdm34ZVQBGBYdGyGHtQx6ia4wnyHGQ/DhpWPyrZyFCEPc1s9zU?=
 =?us-ascii?Q?9J84X2FHaLo0412rssmB/YS6D9yGX+50BoFZ6NySYLsAKp/p9J0MbdlvaIRb?=
 =?us-ascii?Q?NDnBbJXxmNfvkWjkZ0MWU06eccp2pclKThtjtLLJTAVePErreYzh4j4Xaiq7?=
 =?us-ascii?Q?v/2CIllSCA3IODS587f1aqFnOW/MYdP/JUsY8DsUtgNIN7t/gJtPMLdHoPb6?=
 =?us-ascii?Q?a/gv45ziqtaPff8h6t4BavvYARcZPTBkPGOhPiX7Mv1CJe5G/GyXF4ZV24yj?=
 =?us-ascii?Q?j/giegzpHGNRo6UVe1xYsI+YrKscpH+rdYGKinemaTgQZBunk+UwTOy798nL?=
 =?us-ascii?Q?EH699qEPRMrzRppN7sLwgkuzN9hXJJrAqLUG7Loey1m9DLq9AN9UvEz24wh2?=
 =?us-ascii?Q?bTLJqZQrikAA/JYs0mwLl7Xg6L5iKP2dj4imCp5VzJPcK0tf/f1BxQPV4FWz?=
 =?us-ascii?Q?04qJhy1ScAKwnlRVZJJWdGSgllXF3DH3IiP2kuPdA/WxEh77YKVdmM+s5WQ/?=
 =?us-ascii?Q?Zig384qx1jqBTiYYdIwkUWoYUZvg8RgofjX6jb/2FtKdCKA/8Jq+kC5PSNfQ?=
 =?us-ascii?Q?qBkBK0Dr3CzLzrBSVL5C2xf5DvDNtNFRPIHUsWe84TibLl4yBQMqrbATFZ4M?=
 =?us-ascii?Q?Nik+KMuG7zCOEUq4N9tDoY1Bm0IWmiGknBrtp+tTL6aL7u115w52OTj8SQzr?=
 =?us-ascii?Q?iaqU01B1TwWigRRx48liNxi5vf4+Ft3MdWsxI3QtzqWu2reqKW+PF0d9YELa?=
 =?us-ascii?Q?GXQoPDppAQWkqyOCKjhweftiH8glGQDpYJ3Gvkrsu8y7j/RaDEQ4T/1d9/UX?=
 =?us-ascii?Q?NaJURFFz6cdH0uKlzTwKoJxw7UsEg1XIcq4ukxsQSkBJFboOw9a9plSo+ZYO?=
 =?us-ascii?Q?apSXkrg/Bax+n+E2khyIm3GtfdIKflcpHstfPmfJI679Sp4KE2neZBtD7bH1?=
 =?us-ascii?Q?mM/bxQTbN9UPm4dtaaADev0lKSI7IQOSjPxignBruIrvnlDNhj5vKs/4hRSH?=
 =?us-ascii?Q?xkxK2uY4PIlNvRyoOW4I85Cf7Oxnxd6VQfgY1HQPKjy4GKg9SFuWR5V+zF2s?=
 =?us-ascii?Q?jmXLXgZ0XTdS7aXi4k61Xw/JQ2J8mH5JJvF7IGOAj3cCP87777bGCoPkGMlU?=
 =?us-ascii?Q?ylzVUYBSA2CFK/IEz6mrL1IKWtHxswz5mSTPTo1tfffs1qbM4KdtJLw6LaD6?=
 =?us-ascii?Q?Ch6VnW5vGeIFQfpQFRjAwCszVOXYVA3wAcqkE23lj450vM8ziFnh1j8GzFDT?=
 =?us-ascii?Q?bnUYHa21FaIFtAlcdAEHLF9FmI7osWO7oWtjdgDb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7283ef86-9ae9-4daf-cb1f-08db57a8106c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 13:59:14.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btFdoxdc1XwaHOoyya53R+hbF5hjdmOuONAmnvpjwUT8GoGLzxlaIuXue2iShcDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932

On Thu, May 18, 2023 at 02:56:38PM +0100, Jean-Philippe Brucker wrote:
> > Can you wrapper this into a BLOCKED domain like we are moving drivers
> > toward, and then attach the blocked domain instead of introducing this
> > special case?
> 
> Yes, I think the way the virtio-iommu driver should implement BLOCKED
> domains is initially clearing the global-bypass bit, and then issuing
> DETACH requests when the core asks to attach a BLOCKED domain. This has
> the same effect as issuing an ATTACH request with an empty domain, but
> requires fewer resources in the VMM.

Does that exclude identity though?

It seems like the protocol should not have an implicit operation like
this, the desired translation mode should always be made
explicit. Having a boot time default makes sense, but there is little
reason for an OS to go back to the boot time default...

Jason
