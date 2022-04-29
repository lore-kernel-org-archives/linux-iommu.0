Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82FBC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 12:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54A9941CCA;
	Fri, 29 Apr 2022 12:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9PxBnEsPSDmD; Fri, 29 Apr 2022 12:19:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D660D41CCB;
	Fri, 29 Apr 2022 12:19:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 832A5C0039;
	Fri, 29 Apr 2022 12:19:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D220C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6558B60D9D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h1muYGqeCUxZ for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 12:19:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96F5A60ACF
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 12:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA6eJWsmK2eewhs4ovFliH81M/sHRA/Zk045euqyXJFrWdgUR0CIP+Z8AlOiW2xYBlJri/jwzmjRlw0tvE29m8c+OEtXGzeCpNmshW0fW/zfsUM/VRjxhRCKqwD8j+NN2Q2LflAdMuQ1X+U9s0mBYU8I1TtD3DY/U+HXDxpRjjDO7AMO7SnY1Mdhl2Bw4WcE2V02EfXEVYtAH5TyHDOTuKj+dhU5dJBJMTuZntlefCki7aW/D1etnLZEZZ4Ch2P8qjLkcrh3nzdqOpkXo0gQ259579dOzsaK6S8xzhlfKvz2qY8so4CocB0fBpvM7asmKr2Xle5GD8MNOfnMpkvk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DDDVeUu5KKMlkmyA+govYzn/yFurmgJIWOpWCwDT6k=;
 b=gICqlqlzI6QYnvxN26z0Hp0cwT1xBoYqTUM+2nnFtcPj8MoNIeZj+Fh0RyLg7kNnqNLWBDll9RpicjlCn5x9WA6v0S3EAH1ZeGNTW4JDwbuaNa7cQdPsShVS4jUEVomm8YLXY46HmZnYQ7L3TcC2bGn7A7/PYfGdA6NDOzPlcWa3IAVDH7CSv2xalu+nFcqqTm2g+iGpm3WjR7qIWRXjdyYhiyMA3qrbCzORQdZ9/3hXXh/+xPpCFj9DfCwgfPC4xcCM96R4/INT9rwcJPxxLM1D0xeloJ9x+4zXoLIjkYIj1E0fZv6l6+ICLSYu5N7x+/8sSr5lHio4gBwqGjz1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DDDVeUu5KKMlkmyA+govYzn/yFurmgJIWOpWCwDT6k=;
 b=mM01GjtcGGRsHPXnhD0ZYLnGiLfgYGKRnK0mYHPZf128nx4JvpS2s9uMimIODepf8bckBR/Y56L33q2eUiia9yI2Saa57iiZSWL8ya8F8GrrVNCbppzbVvo7zwe14Eii/m8BTLrPjPjj4q+xaQXriunCWj6QGQtoL4lWctKNg5uJLjvtt/eyXS0c+ow8zeH8/xsPFHajVUqXAxHpgMG15lAgHmKDBInwEtHbvdMxQxO+trqWHQz2vLFRLfNll39g2NRTFIqhcEBtBlWLDzQC9T136ao+BnANA3r0FZYR2jppL1c4V14asNy9l2kZtrH22HCUP9u0dRRDOfW8MMCaeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3961.namprd12.prod.outlook.com (2603:10b6:5:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 12:19:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 12:19:11 +0000
Date: Fri, 29 Apr 2022 09:19:10 -0300
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 07/19] iommufd/vfio-compat: Dirty tracking IOCTLs
 compatibility
Message-ID: <20220429121910.GT8364@nvidia.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-8-joao.m.martins@oracle.com>
Content-Disposition: inline
In-Reply-To: <20220428210933.3583-8-joao.m.martins@oracle.com>
X-ClientProxiedBy: BL1PR13CA0343.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5fb4c5-95af-4534-fbfa-08da29da77c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3961:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB396196AF60FFAC7241F0AF3EC2FC9@DM6PR12MB3961.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jHW4HDCYIK8FeDl5J9ZQ+9x6u7n5uwceDxq2s1Ffj334UEKlkYeCD6cpuwc6BIogdxAySIv52MDc36n9ZEcNeHp+MFtQvnxb7RsUlIORapGhazsGyabeArqMhMWN5ZKhZwyx1LwKQMKEjdP0tzW9fHY8mKNnsphLJqVKzRjgpwx6FBDSmatiKDydBW71FUxcujCxt+1ZMePt3kbeBu6Ct+LHZqxbqhkZ0GeBAAPT70/tet2aC8YmdGulrijcbkhmCB7pUc57E13AmH9BKFd/PoSFRwCQEtw/mOsn5HiG7uCK66RjMAZdKpuWQITix+Z+xkkTKahxD8rqzC0YVRAd6N7mjocxKbp1jBZw0o3Nzqok/CQlPzmCVYhQql20aAjKnFv48LtaKosHCVvQtvCPswmh26ddKJ6FKu189x59sc8OrHbSZ+P8pNgtP/GAWuV+RFVc07xn8gf2q7acimy3VBkal/AG4LwOqiUpQ6P2ix0QcmTObiQ86TIZ3ePTUKeHldSkj7eUJrvVMuVhDZsDaYjgNrDtQZjK3osJTSQlEm/YusQM8zoElmpDdAO0DrETuDASJEU+DlmNUOsPugn2MWwcvauO7Y1ByABoeGzd5cqN5VWQbaNrP/8O/sKGB8/1IHC+Xn62FM3i5u4Z4J8clIFl0sicVzZa3B/Z5NSKph8kWpUHTO9MQBCpTFRuw5RHhgjxUHqv6N4R/MsUFZBKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(66476007)(36756003)(6512007)(66556008)(38100700002)(6486002)(26005)(66946007)(7416002)(83380400001)(508600001)(54906003)(6916009)(5660300002)(4326008)(8676002)(2906002)(186003)(86362001)(33656002)(316002)(6506007)(2616005)(8936002)(14143004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMfNgbnw140SM1b4EQuvbXGTDW6LcWaOubyrVNh5HthNLDSymB4DMN8bpKXo?=
 =?us-ascii?Q?sAQLrQLnstbkYaowglKsP56d37cLC2o9ymJjuVT6l0PYFtM6HG9VQ12JI20O?=
 =?us-ascii?Q?X4ank5A+k/cva8JPFjbpFADJesj6tblVe9EJCMQLpwWfFpbSgeLjU8vi7WrM?=
 =?us-ascii?Q?LaN8Dbkz2qZmOgmm+Y9y+CYdQ0XiAOsRBDcjNJin3T+/JjtFQk/nHp7tMc8J?=
 =?us-ascii?Q?A8hqiLq3a6a44k74xEoDXo7y4ZKZD/FOMw6W4Tr7cPiVUAPHbq4Fw3QSnIND?=
 =?us-ascii?Q?CCwXQODv+KOYxLJIGo+xE2oJ5UNIT72D1WXwArFznkTAkwcrYhjQZ7mekmDu?=
 =?us-ascii?Q?LGBJvUjvZYzpLxuqkM6LWZmuPAV51VIklkrrv9LhsZgI6sg3G0USegdcyo9I?=
 =?us-ascii?Q?JsFELcLlDIfZF2mWMdS6qgNxBywH5ZXPUyrhFus+pA9hmb/TSbx1mhknTND7?=
 =?us-ascii?Q?+/eHvl/0tNlgrKjhb6a9a2EQXIE7K5yFerICYoQZFprsItEZ9WgXjHsuj1mZ?=
 =?us-ascii?Q?q5zRB35z8VagMnhJ6gpG8I6U3xW0e5iSGLau0IBigWcJYg+tnU/M9nWgIHb0?=
 =?us-ascii?Q?gjr2ryK22CNNPy7bcmpUX4ieK1H3mX9KP78Y3/VFizUeJDt7LfoC33CNcrU/?=
 =?us-ascii?Q?lZxV2DGjrtVTR+nRPtxnUTSuyuYi7BJYfOyizkp79HatevnyMKqW2DAzL7yT?=
 =?us-ascii?Q?3wT+RKsKfOXwvk5Y7hkW5f/S7J/0m0teRWdf7VORqo1fN2g7wP7yPbDKlFBT?=
 =?us-ascii?Q?8etP0oez+v2K22N0X2n2BI65xMDhB49hASeWFWZQyvlX1iqKYtKKxTcyo2BT?=
 =?us-ascii?Q?qnp61sgq8hLvEqGrzddTRbOvyfDQDaSZr93y6nIY3b/MUdld9Qo9e6bzegE3?=
 =?us-ascii?Q?s38kVVCgUL3E5U9wNbikQvpq5yXbf02nr8RABvgymEKK5s9Wc7xFUxXlYKeT?=
 =?us-ascii?Q?No0k/kaiZ7PTy2XyTQSVAZcbjDjRNLnMHHQN5091IGVYi4t1LrHD25ZryRpe?=
 =?us-ascii?Q?Qvm78VuqaOxWqcyzWTB/Er3cqgC4DG6FwIwstxdGeTs9wfy4Nf0NkZDlRPbS?=
 =?us-ascii?Q?xNYUX7xVUR3Hx8KCcY9RBZXy2UlNDSU/TmRbECTjsfPMiLJmzTcnaMx9jHgd?=
 =?us-ascii?Q?hoQtotld6YUkHft0/KnhN/TAdrpxfO1x3HZyUAp7IxPh3b15ro1QpJy6wxX6?=
 =?us-ascii?Q?p92NAomoeztPtRyWhq+jiTh87EhfQATQNRztffmTmxWs5YkZPqebOt+E9Dj5?=
 =?us-ascii?Q?rlzfgimd6T6RpsSmDDFkd4iLFxV/yesPeo0nk8OuGJUpaLpXgKHuhr/ENd75?=
 =?us-ascii?Q?ivAhcJ2nx6HTy3kvPfcyTheoCzK+nISQ87hkW+jS0xe8RAyN9010xN6pen0U?=
 =?us-ascii?Q?mKjjG8uLdU5O5EsKEeErou1vSZfEDbcM7Atk0m1u4JZ6+TZIefkBF6rwmNEM?=
 =?us-ascii?Q?NvEMnMOUyGgZKbHAbS7rLM8dE/zfin2Fd2VC76HvBQRdy/6MDvSvOynK2fWM?=
 =?us-ascii?Q?a4I2OSuRU4LZZBPzYiBRHyWfT5WUDqz2nnxX1lXHOfC3ZpVdGGcqFRIxeKJp?=
 =?us-ascii?Q?GATvolq0Jou3piDpHaVfuEkgq4Z7GeKPRrkT6jftVnisAuj1pmeFRSWjOF4F?=
 =?us-ascii?Q?eADJA+CIRSM1VybDRw0nqTyFLFxMeqYYuFmFqku5Qjj0tIv9TDsMUg7j+m5W?=
 =?us-ascii?Q?D5Yupp+idq31/4ig8tL344zOUjustS5lmo0VE9Ye+uT4a4Mml2F64qQ8JjXZ?=
 =?us-ascii?Q?TCdNQ1Y8OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5fb4c5-95af-4534-fbfa-08da29da77c1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 12:19:11.7032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIUkc0wsfl3kjzyH80jQ20nOhHDAAYcT8utGp6/rU63R7pDhYZPUzm7Raa+kx6/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3961
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 28, 2022 at 10:09:21PM +0100, Joao Martins wrote:
> Add the correspondent APIs for performing VFIO dirty tracking,
> particularly VFIO_IOMMU_DIRTY_PAGES ioctl subcmds:
> * VFIO_IOMMU_DIRTY_PAGES_FLAG_START: Start dirty tracking and allocates
> 				     the area @dirty_bitmap
> * VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP: Stop dirty tracking and frees
> 				    the area @dirty_bitmap
> * VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP: Fetch dirty bitmap while dirty
> tracking is active.
> 
> Advertise the VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION
> whereas it gets set the domain configured page size the same as
> iopt::iova_alignment and maximum dirty bitmap size same
> as VFIO. Compared to VFIO type1 iommu, the perpectual dirtying is
> not implemented and userspace gets -EOPNOTSUPP which is handled by
> today's userspace.
> 
> Move iommufd_get_pagesizes() definition prior to unmap for
> iommufd_vfio_unmap_dma() dirty support to validate the user bitmap page
> size against IOPT pagesize.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/iommufd/vfio_compat.c | 221 ++++++++++++++++++++++++++--
>  1 file changed, 209 insertions(+), 12 deletions(-)

I think I would probably not do this patch, it has behavior that is
quite different from the current vfio - ie the interaction with the
mdevs, and I don't intend to fix that. So, with this patch and a mdev
then vfio_compat will return all-not-dirty but current vfio will
return all-dirty - and that is significant enough to break qemu.

We've made a qemu patch to allow qemu to be happy if dirty tracking is
not supported in the vfio container for migration, which is part of
the v2 enablement series. That seems like the better direction.

I can see why this is useful to test with the current qemu however.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
