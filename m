Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538527706
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 21:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W00PEedwruCYSg4WtiXJqnJ0hmuw2+LRvJIumS9ustF6RaGbxAz6+2ELVhUv2BnI6ay9+nBZcjwHp+kP5y06mNga5EpLman5NKHZ+1HIoikRgqRtGFGe9d9kP1D2iAquS0hmVh04lwXJT67C9pfbcGiOKr1aj01WLJOD3lZEuNtJaOV3Yk9QrQCd3hSc3EvXRmDJt1dVLgx9srDdaweMRWpvKG9kb/uD4uGP8jIYPQxnOGVM1rGvVOIPxzjr7yP0KJAXpQ2z3FIylSutP8MMPi8cWBEQexBI/roj4ImR49jLMnf7d3GSRHp1QtEAxAhIDpcBGYmmvKv7mct4EtNodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRdODG7lJjz6w4++v66MMkBRIHA2y3jl9CRfS1OIf38=;
 b=U1QIjpUTXxCnEYrGEOJuqonEl1IMvXk4g09BFNEGfI99uEzVwD/wXbInolWNwYhBf1mXZFnwC7oDIpW/hmCbewkHWTFlm6fMQfrAMBQfa1RiMxX1GXuWEa96MVT7roZw0nc+G7NAKqYYiv6H9hoQzFPjju+aR0ZJwvptiTAKPvw90x9a4w8DDfgDZGF/OeFaQdlrU1kgihXeh2DHeFZAYZNI05YfV88Y5VwVbtAu4SbUvb4ziYr8gM/tuq144N199We+0mYiE89c3+TKwZiktBIwHkJUgnPYbBhPZU9NIJyOZqE9izo4l0q1hXMHkP9YDOU62FvAHlZPj0wlVOcm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRdODG7lJjz6w4++v66MMkBRIHA2y3jl9CRfS1OIf38=;
 b=tJoWkNgBoXVPE9+MZ3f9uxIX899WtV9aJmU+2ANwponquGbYZqTbw5bYeXQp6CZGrsxlbuBW8KeyhEZV/E0JdCoRlwbOUehtlEcaQpZpCXTrSnAlbu46Lv/Zyh3LU61hjn3E6U54RplL1OXEt7ec5Y+tCHplhn/l8ysWRv1XwVN/bBVHJ057V/hbzBpQAInEYxh/Ms1YTViK96aeCC5wHQ3W6SYJCLJ2XebUvWKA7sh9qSwNXmGavTRHGxD66e9NITl8BnjawKgPgaI9UquVcpLmL11u/S61qLIm+InOEmsAKfyKVXMf26bb+U6Qy6zeLKHSz6RiaZ5p+c0aFiL1fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 21:01:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 21:01:31 +0000
Date: Fri, 24 Mar 2023 18:01:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: Re: lockdep splat with intel iommu
Message-ID: <ZB4PqK6p64xuNxRn@nvidia.com>
References: <Y1qOqBXgll9qa7Hm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1qOqBXgll9qa7Hm@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 17933af4-8dc8-4e5c-d31c-08db2caaf181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aSQlk0YrhtcmcZar4L31VdNdvd3kcG3Aoa0j/kdl7DIcy0vbhG5oqFyAqsy8CptQOwoY5lPNzrPTJfy1xt4BN8pD3y603s+XYkPsFzfsIQh6ql0YNcdnrLQ1TFLgl11QNYBzD6NEhCEWUm+hNqoSq4srNyFphDLbGfQxTvrH9gH57Nhjbgj2YuPuUy6V9pP8GyB7rtBxrA8lShDBPmmqN0Kla2fjD+KYwjXOOm0LpGu7T80lgZbvPU10XTFV9l/Rh3MQimilUmwrV9khsuMFQnjfCmsXESqFM3SU8XNZU6YxFKCuAREwZKyaS8Nfpzdzg4Eukgvvnzah2HS2CQ9fWgmp4w1DrywHxw5+n/FH93szdFjEZ0gUUsCHF9di1CXtX8rxJdgbLhuDRhLeuwGBFO+fn0+mt8jW6BF5tHRfvbnCvpKwRGuKWlSL3ow6Eiaah/isjnKmNzZ6QBG2cO40PjQOh+iHptQ6ELE2W2bTEQDhksaT9IEMz2WJSLe9V92/3cqzGwbSPfYI7x8kHd+SfjJPt7ZQZGe5j3zkxprTmIyfZb8ETaFoNu8ojV79e8Kj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(2616005)(26005)(186003)(6512007)(478600001)(66476007)(6666004)(66556008)(66946007)(86362001)(83380400001)(8936002)(6506007)(41300700001)(5660300002)(6486002)(110136005)(2906002)(38100700002)(36756003)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ve+2ZcdU1px9uuySyTYmU74EsxcytfuPF6V1VX3YEt/WRD7PuuZs6Uv9v5W?=
 =?us-ascii?Q?4CQsDXaezYawspgbEiCSmie+xTr32+jmCAnejyoeWG2vTX7o7nHtOEkoP2vm?=
 =?us-ascii?Q?S42N3RGJroH8FiY5Wv9hZe1TgCsKq+SAfcFTOka3BaoQBaVjddQSKG1r/B8y?=
 =?us-ascii?Q?P3xthNv/3ZjQpMFspgD+XmuaatOp/uRzIbfoG22ryjEMNGhX/+3rNOYFFFmA?=
 =?us-ascii?Q?ZXKC6g65cvSqHk6ovg31vMmJ9RQQ4YZul6aM8qtwA3a5uvy16YL3Ksix68Lk?=
 =?us-ascii?Q?HN+So2f8fTjEtzuastOtTFAGnKeKfJ616KM06TlkYMDBwIuEGWlurEsb3jm7?=
 =?us-ascii?Q?iw/8R34HoFm4RTRlF0vCzw+ASdnY6S3YbUZYez8kF3jAzRWQjr60iNT48jXW?=
 =?us-ascii?Q?ZOd8lXgoW6BkhM6VXyCt2XRcv41jntBapwZZuLPjh7GAYFSTNt1apw/Nn1bi?=
 =?us-ascii?Q?5HP7hAQeh8OpAcvvUpfm73InmgVMl9PT+1AFhjmMrihNJrJQrasOmdPdNW69?=
 =?us-ascii?Q?uqgcFZLVn6NwlLuDd35AIV4bFWTGY8kQoW4hWrqLwJrMGJJtgGSfIsC3J4Xj?=
 =?us-ascii?Q?L5Aq2MEKW9IGZB8OoZSu3PSF5jJM0SuyFENAY9dqe/JphU03DZpsv3LX7Fv8?=
 =?us-ascii?Q?gZHRj43/zhTDvIjsSmmUAQC88yF7/82lvsywNkeBF3BF0uE442LA6Ox38lxl?=
 =?us-ascii?Q?U1iVOP3NaG8/+ox4rN2/dP06UwghrmTKBAM1a74GXja0Co8LCyJuRSo934Gq?=
 =?us-ascii?Q?o7OkXNF+dMrk9sSVtNk9yCjh5Ie0KF6HzmsGCSee89VcAXBkrU1ofUsUu34K?=
 =?us-ascii?Q?uQBojDwjGsCzNzF81exw27dcNWEDJldDlPnGCWNGJD/WU0VC30eU6Y6RthbB?=
 =?us-ascii?Q?ye/DrZ5+D5bvxe3J3ni4dURLHPNcsAFzBo7DwMTrjOrBuG3kA+MyFodYVHfr?=
 =?us-ascii?Q?yAfms7G0oIBd7laLZukTeZtpz2cv1wZ/yW4M8cU3QNvcattvR+DDNJtYTWcH?=
 =?us-ascii?Q?n7s4x0DDwny/zzYoTgwc6zJcWxUu/rAXIeVA4svWckgFdLEfhCwoJoHSy268?=
 =?us-ascii?Q?ikJRD2RCHSSaZYLntPjPvtQi5EZlN9jc2dze882l535pFtqXneIJd98QtRBJ?=
 =?us-ascii?Q?U9PsrnzQZMuuw54jNWrmqsquHrw/sBmacBmI2PVKcq04ug2ZsXwo+js5LYV2?=
 =?us-ascii?Q?c4RplzVz7ou4WWokQxvy8w7561HArYduNKzMjzGwqq6AnL95ycoWdWe9HWNL?=
 =?us-ascii?Q?BmWBWUhyTsn3ioF3Zm5tLuGJERuJ2b9Wi4z3VGqUjiL/qA+n+wlIiougHgHT?=
 =?us-ascii?Q?t70tbedlneWNQ6GMvVZatWTKfgVJr0kPlbN0dIrw4a6QbZjKAj5zL3ce4QE1?=
 =?us-ascii?Q?k7a1zKaPKzD4vzuf89QGHcAQQ1MM5lerxEj7rni5LLZdpeWL2cZAc9+R8JCh?=
 =?us-ascii?Q?C8QIFDZZgjQjCRM5H7a6fQS2D0hdxZqJefxnzDKjVGgW+ZmybkKt0K0Skcsm?=
 =?us-ascii?Q?WvsvT8DAYQ7clnRdGYCKyE4S2fio3kyvCmHEnVkYTGRtD3qEnof85UQnGCKc?=
 =?us-ascii?Q?X7q7DqmkyqtTXmYb1qNVhJ8R9hMWVUFx//k9sH8K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17933af4-8dc8-4e5c-d31c-08db2caaf181
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:01:31.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAXoWmYwF6qoJ4rYs5RUp19yGZ+Sodatqgn1ewTPsm8i7WjlGLoNQGTFNSEYvImJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

On Thu, Oct 27, 2022 at 10:59:04AM -0300, Jason Gunthorpe wrote:
> I'm seeing this at every boot, on v6.1-rc2
> 
> I've just realized it means lockdep is turned off for the actual
> testing I want to do. Very annoying
> 
> Lu, is there a solution yet? I saw some patches for a different
> lockdep splat but not this one.
> 
> [    0.604492] ======================================================
> [    0.604838] WARNING: possible circular locking dependency detected
> [    0.605221] 6.1.0-rc2+ #24 Not tainted
> [    0.605432] ------------------------------------------------------
> [    0.605734] swapper/0/1 is trying to acquire lock:
> [    0.605985] ffff8880069ab8a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x99/0x150
> [    0.606281] 
> [    0.606281] but task is already holding lock:
> [    0.606281] ffffffff82676890 (cpu_hotplug_lock){++++}-{0:0}, at: init_vqs+0x6db/0x940
> [    0.606281] 
> [    0.606281] which lock already depends on the new lock.

Lu, did you ever figure this out? It still happens.

It is because dmar_global_lock is held while calling
iommu_device_register() and also held during
intel_irq_remapping_alloc()

iommu_device_register() eventually obtains the cpu_hotplug_lock to
setup the DMA API

intel_irq_remapping_alloc() is called by drivers under the
cpu_hotplug_lock to setup their interrupts

To fix it you cannot use the same lock in both places

Jason
