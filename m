Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F133C433EF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 15:56:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AF561B6F
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 15:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4AF561B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96968605F9;
	Mon, 15 Nov 2021 15:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gwZSHjfgRAz; Mon, 15 Nov 2021 15:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79D66605E4;
	Mon, 15 Nov 2021 15:56:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38FB2C002E;
	Mon, 15 Nov 2021 15:56:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C85D6C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 15:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B51D5605F9
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 15:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id myabUeOdYWfY for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 15:56:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::613])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A78B605E4
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 15:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEP7GFlu+7z6QRnIAzYokNNqah+3VbIADpMirpIXoVOL9B8HRpAnNqK0sHU/TXLLfjkApixbd1m6ykBKfzqqRyAqDPzRI6nupN8a/sQnxrxUTVeWqfjtuaCQS2Wj1JSDl0BZrQGiY1GZuHldC192MNvZJURRZdoZzB0FoTmhHL/BBqeDpI8RYk3NQDv6Mq35R3T2FgwEZrYfJWg+3NzFUn6QRSqsWsb1eDXw4u1gv5U2+Jfpigf9oeo65pPkm95Eu+KYqulheXKvT1atY6knOcXohsMovH6h3Gdv/85yiirgSZPg9HQt7K5IEnRYQt12DHD7xgsENcpCdWCysoe2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFZJtEjnKR6qfJuM/zBxbX24725jMBR8AeEZgJ4vfcY=;
 b=ZEi60iRiBbAngr5t6FUwtaBYPSMTIkADHwMz47RpJjl8cXlgRirR0c9aHTwVjDvchneB9GHX/iMIV+LX/gG1/okDRFTeAA0ci1BtWXenTwCiLO94H8jm0bW/xn5J32mxrSpD0DZOSxZw/NOvZXCsbZiELlbaun9bbZdb4zrd4kXV2d8ZAUVfUvGrPcFOF0dGBKYRamBfD1Hzsjz5lUz3Ph/cO5q9orLpqXiq49RK1OFxZ+SCfvta4OjjdY268Rq/qyQ+9DSFNV/dEv4IPzDc1nRTOipkzxC9ac0U/BFstQYWCqYBk446KohntFRKLtke8DXojYE+EScAp4o1rKpXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFZJtEjnKR6qfJuM/zBxbX24725jMBR8AeEZgJ4vfcY=;
 b=YiFjlzu/2rjodEalkimzCAW92hQTO+sI4vkCNxRgOlf22F16+JlSWVynnv2oNaMnofYSVrgyF8sGIj4S8Bxgs+pKNemZFoCASTNzA8XxG7gB1LiXfuC7v0qj0UYieTDDk5gXWF7nTe/H7S1bmvd5AjGhC4lD63ZBLDslF8lBT8I7LO4siA4hTY4HNKENNJHmesCX8rRYAdxM7Y4KgkqFwKtCBky+3Rm+YxZp9J9SOMbFBjFWcxFlOuiKAyC0YeO+x/9LAbI/110DCgYwT4VrK/1NH/TpMqghieV4E52byRFDKukb9CMTfoKmBqE2qtNsVaN46WOGaUVjL+/4LihJSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 15:56:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 15:56:15 +0000
Date: Mon, 15 Nov 2021 11:56:13 -0400
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <20211115155613.GA2388278@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZJeRomcJjDqDv9q@infradead.org>
 <20211115132442.GA2379906@nvidia.com>
 <8499f0ab-9701-2ca2-ac7a-842c36c54f8a@arm.com>
Content-Disposition: inline
In-Reply-To: <8499f0ab-9701-2ca2-ac7a-842c36c54f8a@arm.com>
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 15:56:15 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mmeL7-00A1b2-Eb; Mon, 15 Nov 2021 11:56:13 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7249c31a-d1d6-4723-5603-08d9a8507439
X-MS-TrafficTypeDiagnostic: BL1PR12MB5239:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52398CC010118352FB425F30C2989@BL1PR12MB5239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pccnaMTbzyH4dAVOTz9ahPcyyUc+kX7BJOlnwQy1KKrXvdvHGP3wA1obA/0FUJsnWvqf0iL/Vh0sqr9FCape2wvJGZG/lhb/5OgR700rROPycQDbHIKqsa07ab5ob2aic4J/hGQ+petcFSQlMV43AkSVTjBPjLiHjho6c0d1pS9CtvxlbDKL7+xQZP1RLIU8V/smL+yWUHjC2YnsSKxqvQhnqvi9QtcOLqBMrtmKM+yRazz1DP47JpUoecDeGCBMlKF/N4nvs3Ep1Svr9YDUeE6z+C6c6WXPgxSyX5sJSVIzlG04sdVSFPX2Jixdd1xag9T+BK0sFEXHT5NgPCLQ6FMHEstvXX0mkXV/IOcsITsfe8tqJnipj3sWTbRLMeJuKzs+IFc7yzQdJ6YM3Jv8V2i82cZIXZUkUxp01lPQ9GuSd0kHyRx3Bn4+lUb7uSVHbFjtZxKtHjHWsMbsV3D8F68LVHlqG1AwGaOnIZUgaZmRrxpixIw3ff4QLuubcfdwNsjpH8o2re2bm0i/ioxFAyLao7s9uouycnOR2rXPsTLlBpR3oViKyOr2/4tIXFKHEu0EPsl6Q5re6uLU7MWKnEQN+KFpZmDo0USWAd83UpSx10+98ELh2ZMkVzUnlt3TbNbXTzl8jInrXdcO0XFfKGjzAt4tsax0X7QBdl+71b4pZRrQqm2eR+vcPmlxKxAmGqsV97V2gJIC/c5y8gRrIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9746002)(9786002)(186003)(2906002)(66946007)(54906003)(66476007)(66556008)(38100700002)(316002)(26005)(5660300002)(2616005)(86362001)(508600001)(4326008)(33656002)(7416002)(426003)(83380400001)(8936002)(8676002)(36756003)(1076003)(6916009)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NprIDv/0Kw1wnVQuQOUc7Id3VeCuc0K6wkvFXCyNGHf8/fLngn7kxc9gFIMM?=
 =?us-ascii?Q?TrTfy9M637GC06wwdAzrG4V1uHrOixu8cAXBZeecMiJTpHJ3KucZx5ESgon3?=
 =?us-ascii?Q?ZMljNCQAdMz3I87AlvqCaRQzcnZsqxpfTdlhaMVpdjbtuvG2648ZsSOIVm+G?=
 =?us-ascii?Q?vthxipW1K14sgm/14oVfD38DPlhrPLMkeB4MuYrOyfJeyPmiQLCp5EbCkIxL?=
 =?us-ascii?Q?fkH8S7LuB/hFyQeO5BMR7DS8pdSp6U3+Jt8fQVYQtXun1zW5ROQEY0I+moFL?=
 =?us-ascii?Q?ho5XtkOZaVCcUKTOPj7lc9uMeueIlrRxdiNN5n3NfdVepK9S6sDK34ze8GW6?=
 =?us-ascii?Q?kAKNhyZ0V55EQ84zLRbJ1sKyZTicqFrNTT7mrI0HaHHBJoomwV5rimikWsku?=
 =?us-ascii?Q?X1eyaY1bafILGe+lWmANpIaO9rWgQBF5GGy1DdfY5648zDaFpFbzjvRoGsKf?=
 =?us-ascii?Q?1F4/vW8u6OZ/cnBxtIu1Q239+gPWhy+XIuUoq0CQ4sX8aOwUysHfMXSNKst/?=
 =?us-ascii?Q?Cw94ZWx7aggLLQrm577Lt+/qpN9R05faziNVL+XY88E2mGlU6MYLw8J/0DuT?=
 =?us-ascii?Q?ckqHNaANFR0SmQIc94jBUdhgS9KWqy5oTgXqTnInVGO81L9er4tziCGcPj/3?=
 =?us-ascii?Q?5kVQrOWNOuin1IbSTfNDa3VhmXFIcf0bQiQRD+YSvoB3zwnOad14seCrtRRr?=
 =?us-ascii?Q?aRHTph5fdm4khMW58/u57GFXIeSgSiEGLwhB9zCCExMe3aW0UNH1EOp+r6Ya?=
 =?us-ascii?Q?+DNkz9X94HPvqJPxGBgIWGGjtkG5xXLOykQAkGhNdDwv30/Fm0OtKZeTYxny?=
 =?us-ascii?Q?hKYnyKmfKp0AO5ImGpIFd6OQeiyXx7OfqfcFnNVvg5L5fsKJPMbhPqjcMa8k?=
 =?us-ascii?Q?PPGcAQ8OJhN6BgqeGIwTOFec3H3Xi3HZkfqkvIwQWz0oqP7BAYzGJLzz2rDY?=
 =?us-ascii?Q?V4kzmccaGANR17h96PplkW2wYybBcT1o/5J61SW0XVRhAdrM9tav56Ph8INg?=
 =?us-ascii?Q?sgPFK++5ET0kd8LxLW8fpKEQjtHaxE5GOIkFMxenDuMZ5IHvkWpLsD63JCnU?=
 =?us-ascii?Q?dzpKYS7T8N8yl3+/ENh5SOmTNvrJX6ZhNHJ41ZcseYXyxC/tBKJ4tGFQZxsN?=
 =?us-ascii?Q?OixmEKw9wnoL0g38DETNBPLYxvTde3ihY4HL2u8pycjPX73c7uamfOeZ/1SC?=
 =?us-ascii?Q?6wyDl25bDtQfslZstTjgbFkXheUIt9p/PPHzwCvdbZlO18HilAQ8EvozO8vC?=
 =?us-ascii?Q?vGVT4DHd9ucm4rPq3bZREGcB+A4st8l6G8I5Qf7nlEEQKMSPDII+Lc2JHLIo?=
 =?us-ascii?Q?grsWJOq9gA8oi4c109sRAX9K3KATkfi1XuUNN56FzSo5fxGULTg2c8GCLJBF?=
 =?us-ascii?Q?XqqnnSsPcGWntkCnK4jpR3Vb6jk4QgM8PL/E4kPB1qtIcsFDgH9BHqIwvAY+?=
 =?us-ascii?Q?A1pKWE5syY/Tb65Pz09r3omPuBr53USQ5WcTw0ceAAXG9bvVkXgPJPXs2H5K?=
 =?us-ascii?Q?TUqjfNxpwyseOxUQo/K+n6emn6JbvyCLIDiZH5VUuPgs7FpyJIjYvpIHuKLB?=
 =?us-ascii?Q?9Szc4TgbRItLMam3uOk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7249c31a-d1d6-4723-5603-08d9a8507439
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 15:56:15.2461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZNf1RcNxKJlMaRpGpYefu2+mpd52h6Zr3n81DyXGhohWP22ok1zDonlggD1I5N+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

On Mon, Nov 15, 2021 at 03:37:18PM +0000, Robin Murphy wrote:

> IOMMUs, and possibly even fewer of them support VFIO, so I'm in full
> agreement with Greg and Christoph that this absolutely warrants being scoped
> per-bus. I mean, we literally already have infrastructure to prevent drivers
> binding if the IOMMU/DMA configuration is broken or not ready yet; why would
> we want a totally different mechanism to prevent driver binding when the
> only difference is that that configuration *is* ready and working to the
> point that someone's already claimed it for other purposes?

I see, that does make sense

I see these implementations:

drivers/amba/bus.c:     .dma_configure  = platform_dma_configure,
drivers/base/platform.c:        .dma_configure  = platform_dma_configure,
drivers/bus/fsl-mc/fsl-mc-bus.c:        .dma_configure  = fsl_mc_dma_configure,
drivers/pci/pci-driver.c:       .dma_configure  = pci_dma_configure,
drivers/gpu/host1x/bus.c:       .dma_configure = host1x_dma_configure,

Other than host1x they all work with VFIO.

Also, there is no bus->dma_unconfigure() which would be needed to
restore the device as well.

So, would you rather see duplicated code into the 4 drivers, and a new
bus op to 'unconfigure dma'

Or, a 'dev_configure_dma()' function that is roughly:

        if (dev->bus->dma_configure) {
                ret = dev->bus->dma_configure(dev);
                if (ret)
                        return ret;
                if (!drv->suppress_auto_claim_dma_owner) {
                       ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL,
                                                        NULL);
                       if (ret)
                               ret;
                }
         }

And a pair'd undo.

This is nice because we can enforce dev->bus->dma_configure when doing
a user bind so everything holds together safely without relying on
each bus_type to properly implement security.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
