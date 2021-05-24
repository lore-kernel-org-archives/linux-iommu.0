Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4952C2B9F7
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 23:37:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85369613D8
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 23:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85369613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B0383C27;
	Mon, 24 May 2021 23:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IyfJ7jLDJE7b; Mon, 24 May 2021 23:37:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D0DD83A57;
	Mon, 24 May 2021 23:37:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9ECAC000E;
	Mon, 24 May 2021 23:37:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45027C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 23:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33AD940168
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 23:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNkMR_TQb_gf for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 23:37:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C34C64010D
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 23:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvbpkXL5UYKynpHkIhJkO/Nz5y/kfqg6VJdC/Cy/6hhLFflUofkVBiIeXDaxJ34iDIzEysuiiPJx0LDB4QsmyDSvWxxr2wF8P1HBFrg24ltjgj1JIweqK+hcRGepSpTac3ARAWy9swJJYzzu7KtZ3a2BfgmdLHtB1yL7C5n/KDgR0NjD70TACsgul5oGDLvapiWdn92Y6IaT248cYrok5mFMQbOZJv7iCWmEJ70bX5p7TgEIncOo8IjEu1tQ4dg2PyC/7CiqKZpklt6WbqmhE891nEc9X87PEwzOxtyS6vCtC3E8+X7u3P5F3ZoRxGFgECFE0z2oefgX8Tl/BuzVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR6laYgpF9b95HZa9CNu+FrgxJqikDB0LQ7EyvD1SXA=;
 b=XcOwb2RziXX0PVtCkqlq2uUgI6yWLLKcyAW5R1PgojeZyHEP68PVkGdZXxqLzjtrgY9cT8i3yUk+HzbT7iuQlX/K1WA2c212vMi35dKdZwgvlZSFyfrlRjZcslfV/uGs83NMdVDgdhnwr15Gd/Fjqlsj+UL3pYBoKzU7AMhkdzy0yboNDuYN4W/rfo8UmKjAmRE1mw7CngpogZQOi5NoL01ZmUBPUgx6BP7QRGyRz9/NPXiKGvD/mWyKBBkLq+bEfDKhZgeBKvpuUy3Xx6dTlT6L9KPiGymcdSGTiKACA/+em4zsVBqNQQK6X+Uk7N+UB6jcetgWi7NoHkm82fjLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR6laYgpF9b95HZa9CNu+FrgxJqikDB0LQ7EyvD1SXA=;
 b=WioYrFyq6TDd0rJSB/lufkSLX4cBRO7UpPGYeEKYR41MY3irwINBc4DkMKQddsir47D0w756SKEJmSgTrTnmRVMf1HYNuT4SUz5aYLAKcR8zD/5/aP+/rBJWqP83YrpSqe/ncz48QcZH2Nbhb3yYHElXj5g3jU+R3JeIY2DQ4V7TAE3KB6aJZEuxSTVm7NcY22N2Kf0ae/4yk3jWAy/Jbo4671QI6sbtdHKNs+HceCilxErwvgyV6Ynlhay0dRNnvWXKjtc+Br8TTN+fKs3pXvQz0gqXwEqz+z8c2/GuRvDZKd+7FBBkH2RwqFUHeeO2ECqQXhMzPsiN4FXU/F7whQ==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 23:37:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 23:37:47 +0000
Date: Mon, 24 May 2021 20:37:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210524233744.GT1002214@nvidia.com>
References: <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
Content-Disposition: inline
In-Reply-To: <YKtbWo7PwIlXjFIV@yekko>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Mon, 24 May 2021 23:37:46 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1llK8m-00DpNv-QL; Mon, 24 May 2021 20:37:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6940fdd7-6132-4bac-35b7-08d91f0cef93
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-Microsoft-Antispam-PRVS: <BL1PR12MB514405CEA9DEAFD6D622E6ABC2269@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuyNxtBgGk0VW5ZjaaxrE0WrUYrK+elkJuJnCIODdojJJ9TXpR8MtjuPVcR2KVLUsJPiJzrCE6L2bppVK09yJRFHr8I3sYj+mhTcNf2+zX1zttJyCjU7js4rBC7aIe4r51kzdsyrtoVFC5j0MZSYonnuG74WMCXYT9IVxfwJYffO5/94tACZLxc/Yv1r0NXEGisKRiJ+HgAndgN+H27QPbXfA7dd0Tcpj+gn3X2z0cCUksp/bGrczNqtFKxPqDpaobEvBP8WhqnPu2XKqTumYDrJMfwOGYkmXBgTjOsjc9NhlbM9AkjC7ClEbIDJbmmawb6m6f9eH1XV1oEr3aHQlEwFbJL8h6rkcOx5w/o++awMLkkdjvbRd94vO46baAo9wVTKuW6m5fw5+s5f1YIzHKHMXZ6GkmaBs+sYgrc/v8EWmReRYSLBd8IIUX/b9dOlP2RL2SS9GCq0bpFSbTF4OdmjsMPyaDnkJp5AWnlG0Ollo9uVi+7zLH6o5HUnYNkFY0HCJgpLCUFqgqy4f4kehAszntuMSY1VNoagRC1XCFMTevczSqryKNosMOln2L9DiF1JzYBWMtQ8lEBUonP7aVu8mHfHHMccJNX53EvB2zI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(66556008)(66476007)(26005)(86362001)(2616005)(2906002)(66946007)(33656002)(426003)(5660300002)(7416002)(38100700002)(8936002)(9786002)(9746002)(36756003)(6916009)(316002)(186003)(8676002)(4326008)(83380400001)(478600001)(54906003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?doRDEVeVZrhbAim0a6B9O85Ca/hPSxBm4An8i6dxAGjpYEX1M+QviDHttk5o?=
 =?us-ascii?Q?VzYEwzqrwAJ7P2WcHV0rscn8gDKQDSh7eEseUX3DD0PhkK7IDoiT++qVj8Hj?=
 =?us-ascii?Q?Me6j0qw1wDsq7QIRDfiTGgUMpjM841uR6tObKRyRCQSXjIsyFAHV591G4uQd?=
 =?us-ascii?Q?zGe3C5JRfy9l/cHI9fHe07UUjPxNoGmCPkROmNuNb0t9kFeP0QmIkuxhbtog?=
 =?us-ascii?Q?JgzmWEdclfvGN3JYiGyu1W/uZZrv6Mi60qhEQnbNQsu0ojtSPgt5E8V857Em?=
 =?us-ascii?Q?eCTJ7h2p+LWT28h+U2iFwZFAmwysdh4mWZNTygORFl1tYZhHe3MLulN+AcSF?=
 =?us-ascii?Q?8DbpKZNDl7X7zm2cv+XuMaNWjtIEsLtVJli0mb1wBuMEbE4hv3NO/vzRLUiS?=
 =?us-ascii?Q?ps48vyJp1wzSVf8w2T+bqvXM4kC8iOVwNHjR++EuVQjUs+qTeV6MP099k6dn?=
 =?us-ascii?Q?kvD/GWexYABdh7F2lZc2845Um4U5a0g6jqrU3VI+YVLJ9NPJV/wuSu5PQGmR?=
 =?us-ascii?Q?H46FwhJM1ATn5govuu0zjQlGuec7N8u8DpMP04VjxdqOY03EUzZ58Dn7EZrh?=
 =?us-ascii?Q?sPv9x67MRaFF56FA7wbTwmehteif61Ko96mPqMvJozOkBJKH3jSzoDW+OOgU?=
 =?us-ascii?Q?tPDf0U0pcZ6W4Wj9DQiRRld/0KWdfGlt36VdRj8QxwQMkxpRvm5+1I5nQcFr?=
 =?us-ascii?Q?pRuqJMh0l2aw8xjHv4LcAtNQpeb2P9APrwm5dHkQy/8O9i8LSs3wAOnSPmRU?=
 =?us-ascii?Q?uFpwzUQ8roN7meXMAZoqAs0Y/3V8HJQ/Mk2/XaH0P47hnmAZ0kJTqU9uKGYe?=
 =?us-ascii?Q?o9oFd2Ki5jNXQRjNB0vCtquBMFYDiOr4QvDBmCKuJ3oLRvg+S3aOYd0oz3px?=
 =?us-ascii?Q?DNLS6V7diPn1Hh24Qg+FzGLe2GBMTZJqxOmuOoEBZI3QCMT+YSPYGmUfz8Ng?=
 =?us-ascii?Q?SUxrEOBNbXWC8Jcf1WCgsZWUp1+GMy18idl58KxZaX3AVIzeQiui9VrHduQj?=
 =?us-ascii?Q?bUaxE/nJKLG2caJGbuio9nqzFWpvGDePGZwZpPnWNQ4wvqHxw8scxQVvPzD2?=
 =?us-ascii?Q?5vM+TBTh3FAygMRHl8sHXfF6VRdZYN+G/t2RlMuMakvu/9F8L4frq5Cx6sG/?=
 =?us-ascii?Q?Uk4eSlf1hbmnp3JWsj8wamOQILkIvtwIIqYa5yTtpJH0ldbla1+oOTgtDnIw?=
 =?us-ascii?Q?BmQjhCD8OoS10vbO4ROKWO11xyhwfbZX1MyJuQkutsnEK+Xd+8J7RhzwGF8l?=
 =?us-ascii?Q?GyBijTvMk3e+rPu1/ye9I4JFWHY61EGUIvLigu/TpK97HH3RJiSOEk2i1yiv?=
 =?us-ascii?Q?r3j4dC7QiH8Jglg1rD+HohGO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6940fdd7-6132-4bac-35b7-08d91f0cef93
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 23:37:47.1725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvZixLmwktANf6m3hxxi1w325maEAj7Or6J13F6t3OjxNKZbFET7A0HyxJGKZvz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:

> > > I don't really see a semantic distinction between "always one-device
> > > groups" and "groups don't matter".  Really the only way you can afford
> > > to not care about groups is if they're singletons.
> > 
> > The kernel driver under the mdev may not be in an "always one-device"
> > group.
> 
> I don't really understand what you mean by that.

I mean the group of the mdev's actual DMA device may have multiple
things in it.
 
> > It is a kernel driver so the only thing we know and care about is that
> > all devices in the HW group are bound to kernel drivers.
> > 
> > The vfio device that spawns from this kernel driver is really a
> > "groups don't matter" vfio device because at the IOMMU layer it should
> > be riding on the physical group of the kernel driver.  At the VFIO
> > layer we no longer care about the group abstraction because the system
> > guarentees isolation in some other way.
> 
> Uh.. I don't really know how mdevs are isolated from each other.  I
> thought it was because the physical device providing the mdevs
> effectively had an internal IOMMU (or at least DMA permissioning) to
> isolate the mdevs, even though the physical device may not be fully
> isolated.
> 
> In that case the virtual mdev is effectively in a singleton group,
> which is different from the group of its parent device.

That is one way to view it, but it means creating a whole group
infrastructure and abusing the IOMMU stack just to create this
nonsense fiction. We also abuse the VFIO container stuff to hackily
create several different types pf IOMMU uAPIs for the mdev - all of
which are unrelated to drivers/iommu.

Basically, there is no drivers/iommu thing involved, thus is no really
iommu group, for mdev it is all a big hacky lie.

> If the physical device had a bug which meant the mdevs *weren't*
> properly isolated from each other, then those mdevs would share a
> group, and you *would* care about it.  Depending on how the isolation
> failed the mdevs might or might not also share a group with the parent
> physical device.

That isn't a real scenario.. mdevs that can't be isolated just
wouldn't be useful to exist

> > This is today's model, yes. When you run dpdk on a multi-group device
> > vfio already ensures that all the device groups remained parked and
> > inaccessible.
> 
> I'm not really following what you're saying there.
> 
> If you have a multi-device group, and dpdk is using one device in it,
> VFIO *does not* (and cannot) ensure that other devices in the group
> are parked and inaccessible.  

I mean in the sense that no other user space can open those devices
and no kernel driver can later be attached to them.

> It ensures that they're parked at the moment the group moves from
> kernel to userspace ownership, but it can't prevent dpdk from
> accessing and unparking those devices via peer to peer DMA.

Right, and adding all this group stuff did nothing to alert the poor
admin that is running DPDK to this risk.

> > If the administator configures the system with different security
> > labels for different VFIO devices then yes removing groups makes this
> > more tricky as all devices in the group should have the same label.
> 
> That seems a bigger problem than "more tricky".  How would you propose
> addressing this with your device-first model?

You put the same security labels you'd put on the group to the devices
that consitute the group. It is only more tricky in the sense that the
script that would have to do this will need to do more than ID the
group to label but also ID the device members of the group and label
their char nodes.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
