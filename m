Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABDDAA0
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 19:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8RBhia6UcPDJ6A2NCkQDXgS43zrAIEDnKItTuRQW6lyEZXN0Q9JnsLAs5YkJuZm7OmR13SOpQspqfmBBYamyZJwA5rBIYFxFml9up9RJOXh+/8NbBzguRBStI/v24bFDJIfdXeS/dphkQWq2hjTpnJDCQILw5//r7QLugLQiks+iAkrc/bBvk1hX/adGmlNxBKH927DUKlr/EJQfxdHc8Vm+i7xMNOZSfh4JSiv7ImsvGD7L1Z/uZFIITxTAYt//IQ/KYm2uhzNKidZEb9cAsqcsD0Bac9bYAKCY+CHyUN415lwfWUVdjZMF0M++gTDDuZT5f/hzCN49+gXN85FLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sSY1wFeA3d/+dwg7/et2NuD8QfIqRKQtJ1E+kKy3Kg=;
 b=c+QPaAFCX9LLdJKGicOyL+c9Vtcq1z/Xf2G3huNsMZ8GqHNwY7Zq2O/Q0YXkqdjqQy6Vg+2L5W3s42TGAF7+mNH+U+HhiczjGUDhv+NEdqKJUkQamqCCCR/Sv/GXJSBjMlBELm/kgzSHqBDWbG03g6bdeCHHBZTvRAsTGycE7RW3bLbp6areOcfD3kcPTU8ozhssZeZvGVbcnESc7OjW+YxVGhYzqB4UgTH6t2kyer/lezseG1aVXGkrZ9W4XHNZxvARl0DAnXEtislk1bw/Ymzu4PSg+P8zAiwkDGJq7Cg2j+K2IwdHJ/aUM/nDl7icYcVynUUka218SpHw43Y1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sSY1wFeA3d/+dwg7/et2NuD8QfIqRKQtJ1E+kKy3Kg=;
 b=FXocqdJBiyxxx+nOQR/6V2v+tTcREAk+rN8DzdBZyc7cOZ13unsLzWItyanPlkIUo4aTs/Wym1GzpTopMbqzEUg8jWv2gl1y1eXSjJixEL6/4bMV7STuYb3mN8JH1O7YihDOFbqZ/80gviewwYtqNJkCk7oV6LA/t+8pI8Qez4jHuiJKlRa4cglyu7nNKPEYqY+g/asy6R2Qld5D8hYwc6iVt3NuymVBN5DFBWAA3o788MTbHASpnGSjF1ILrkPLOv1HNAd0dUAwHotYN6tret8xWUXQgyVryg9moG4tN4099B+iAUYkaOvRvuTnM7K4+VoXHAILY4NJ2+gekgjVDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 19:46:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 19:46:17 +0000
Date: Fri, 10 Mar 2023 15:46:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Message-ID: <ZAuJB92z/6XIriZ1@nvidia.com>
References: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8d41d7-b029-47bd-9f38-08db21a01d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g+R9PNme3tQ9NC0Ouy+8JHtITODJF+gsGSQPT6LLMSUY8szsfWZquvwopnrnyp9wo2WftUbMBj0xYwtK2mfpco2vqZaNXLWYMojvz1VPO89zgkgLSYUUHf4MbM/EIlYe5waU0VmiU73Si3IGZFz+mfIiCksal29o1m7ioJhiS7xd/aicL2RkDNpEl8GjuefrKdwInVPrYML7fLTQLBf7FTWFLeIWX0TMXMefNkuJEVFuAGKbCv+A5jW5Cu3e50IAttwJXtux9mDGjAnfTOJ2wZtLMK9ba5fvL/UqPxRtjBQ3oelwthD+3K8QN0rAVJi0IQ2hLCZy8jzntorc8dANQsURukFCl96Oem8LUgfNFPkSwVJdvZaBSSNN/omWaCXX+8X9aLj1i1fhpXGOLJFoe1ynsJ4MBzRuBv7UXg2EvkzmkApE41mHnYRBc5KKKfAtPdS3ivrzLC2iTwdejzfDWifpoInjbtkEDxQoz9hIiO+OIROWfR0zpTh1zJOuP9tkqUzb7IiD854kNoEBADYYweOr1WJl4Hzz/SbBlKS5MNZjijHA7i5Y1bj4ETUf/0HVuIbUOz/Em1fB75yWEu58GMD1NqC3hsjDSmhFoxAhVKjfP1VHuX2wQXsA6ADC9/YB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(38100700002)(36756003)(86362001)(26005)(186003)(478600001)(6512007)(6506007)(83380400001)(2616005)(6916009)(45080400002)(316002)(966005)(6486002)(66476007)(5660300002)(4326008)(41300700001)(2906002)(8936002)(66556008)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?06Usgwrqitqo+gqrLJLiq5QLy9RXY7JLLVH/D7IdK7QNLVWLje6HeNSIj4OV?=
 =?us-ascii?Q?XD+NsgcVXqpkBhTdKtBo/SkzMZtt0ff1SesrM42ccCfQqSZi8ObaCJn7WapN?=
 =?us-ascii?Q?XFv07z0xQm/EbbplRizl9LLXxk5Xv7UjY3yt7w+ukUVx82HUX8oWGy7z07AZ?=
 =?us-ascii?Q?99X6tXoCEAGE9z2Bh2goM6Er3TLUUDx0ccKNma61R2bxvQYZbbrixzktGoMF?=
 =?us-ascii?Q?6opuLmXiQMBI4mjmP26yhCJ73g3ZUv34YndHgw1XcrXX7i3MJmrD2JZFXPA3?=
 =?us-ascii?Q?tHnXijCQYiwaL/DOqFhgZTjbjHTeLSrDK5Wjun8FRHOtRbh7K8apyTChxyc8?=
 =?us-ascii?Q?jKiXbQp5bObKe8zbv7sk/sMmXaIha+2u14TIw663BF3N9KkXo+KnB5OfFLYr?=
 =?us-ascii?Q?9w122wB4mMSPChl44B7geg+nkDePRZ8YzrcrKnXvnh9L3JVcfJCUwLhpqaza?=
 =?us-ascii?Q?DkzTHn+tLwaBEJUvZ3dD5Al77CKa57BUSkAAFFhPvPDJnstmMYWJbpmQdumS?=
 =?us-ascii?Q?gziq8q9tp6FibioeBE+fGPv6dgbdcpVpIxYI0wLVu4DAaItcZyH3aWCxKVC5?=
 =?us-ascii?Q?NBWvqQB8yPDIl816OE1Tx/cMwNssQR4Ju6v9PCEWUiDLiEC7vNoL+9IsMLa1?=
 =?us-ascii?Q?TxsHyzqXRMhWcqnUQHi3rFybFiyLZTfn7M0vsuO2CRqa6EbNnHAc8WjgZdiO?=
 =?us-ascii?Q?rV0mf0xH0Zzz5rgbhfKgkS3spSvkMFubBvn4YCHLSw4Xv3XSSzRo2Z9ImXSg?=
 =?us-ascii?Q?pXnTMsanDZGR4VbkSjswJVl0TkNeovn1xlr0km3CF+KYo3Z4w7gNhlvvD0PC?=
 =?us-ascii?Q?p5eMmjWLsO9pCU4OloUIyLKX2AT+T7T/b02kKZ1+m8i13fD2DvlOconncJ/S?=
 =?us-ascii?Q?qTa2MNgPmcSRPr/kl6wV9rSDsVTyXt+fiRjF1OSmklJoFoqOy4hGArs1u3Mt?=
 =?us-ascii?Q?ct395APNlo/ngDEynXAxm+OIsJFJ5MUDLm2N8eSofi3ATdMMwy4OM99umejW?=
 =?us-ascii?Q?BViwzUrrmrO4ee+VnFVufLNDiVgKPJQU8wQxSiSVw1uWJlv+F+ETVG9F24Lh?=
 =?us-ascii?Q?jmyx2EsdGYyj20A78aQa1hqELQadFC4f04fl1XfuyTPjdr5kuuux9OcFq45s?=
 =?us-ascii?Q?iatuyG/STYhjA7uN6njD7a1E0bA0FEZzWi8M5i0WXDFhMk7WHZ3a/rA4Mfzs?=
 =?us-ascii?Q?m2J1E6jH4mscbtzoB0yYvdw4KKXslJrUQYAxvBvu2ny5FrNOqhi8o8fdS+L8?=
 =?us-ascii?Q?e3H+jbCzTVsXkw67MkKRGKeV41BfHOIw7luyIuylup6JKod8FIDruPHMOrVP?=
 =?us-ascii?Q?saSqWw7qqEbz9noW08MsfsUW4itAv8C6Bj9XYgI4y6/8J9gqtHRwp+6Yrt0E?=
 =?us-ascii?Q?PBELSjgJc7hAQrBYhSqy2FJrn7fZ2MJJoLQqugnS0jJOHnJ+OUZ9dK90Lvjp?=
 =?us-ascii?Q?APznIu1VxkeR6Xwy6OBYaXgjw6eaZbe0fC7p0CiMeEBadXugeQehPjaAURpD?=
 =?us-ascii?Q?ZVbQn0nnku+zJuB0DTH3f2gV27eXBqlksEVl8WRHgHKKQmnyJHpg85HMMFtE?=
 =?us-ascii?Q?BOGIFS2EvF0IBFbVLjeAQXR7cndIAu4jiHWy5cwO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8d41d7-b029-47bd-9f38-08db21a01d7e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:46:17.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8SVT0ZMQPqXAZrrn0F0ViVFsqHyZe3E4uW1z2z4m/umwdq2Nx0FQuK6ckvwVtIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

On Mon, Mar 06, 2023 at 01:27:04PM -0400, Jason Gunthorpe wrote:
> syzkaller hits a WARN_ON when trying to have a uptr close to UINTPTR_MAX:
> 
>   WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
>   Modules linked in:
>   CPU: 1 PID: 393 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:iommufd_test+0xb19/0x16f0
>   Code: 94 c4 31 ff 44 89 e6 e8 a5 54 17 ff 45 84 e4 0f 85 bb 0b 00 00 41 be fb ff ff ff e8 31 53 17 ff e9 a0 f7 ff ff e8 27 53 17 ff <0f> 0b 41 be 8
>   RSP: 0018:ffffc90000eabdc0 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8214c487
>   RDX: 0000000000000000 RSI: ffff88800f5c8000 RDI: 0000000000000002
>   RBP: ffffc90000eabe48 R08: 0000000000000000 R09: 0000000000000001
>   R10: 0000000000000001 R11: 0000000000000000 R12: 00000000cd2b0000
>   R13: 00000000cd2af000 R14: 0000000000000000 R15: ffffc90000eabe68
>   FS:  00007f94d76d5740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000043 CR3: 0000000006880006 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? write_comp_data+0x2f/0x90
>    iommufd_fops_ioctl+0x1ef/0x310
>    __x64_sys_ioctl+0x10e/0x160
>    ? __pfx_iommufd_fops_ioctl+0x10/0x10
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Check that the user memory range doesn't overflow.
> 
> Fixes: f4b20bb34c83 ("iommufd: Add kernel support for testing iommufd")
> Link: https://lore.kernel.org/r/Y/hOiilV1wJvu/Hv@xpf.sh.intel.com
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied

Jason
