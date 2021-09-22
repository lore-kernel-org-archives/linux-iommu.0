Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7427C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 00:53:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC6D60F43
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 00:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EC6D60F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E5378191E;
	Wed, 22 Sep 2021 00:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Qm0FqCRTsGB; Wed, 22 Sep 2021 00:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2028C819BE;
	Wed, 22 Sep 2021 00:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4063C000F;
	Wed, 22 Sep 2021 00:53:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A75E0C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88C0360814
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03TzLvzS4HYw for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 00:53:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40B78607BD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPrpfei5k7T5jpZ5INP1BzUUcwH4j5iwR8qvYCwkYHayPQSlBP2FNtMeeauhesFZHAhh5I/qGCYilUl47GVNJsvpIiI3RWxqdbFwR9ZjkTa4QlZhZsv45CeyKfjfgwYGrniqn7rHaTZsTJAR1Cs32Vf+WLqOz01Cl54luePoj62Bvfs0sHRyMJ4dRu5VpZbKkVOTdlg6AuN/AEgeTNabpXT6QKhGmx/V6BrrugeBgABkhmEkciI4/4jCTY5WMh6q7soVyAUUOTtAehbFtwyy4xdlQaqWdE3flBeVXiFwftp5aE54/2vt9kFj6wKstgib66tOiKtjyzMGvr4wZXn46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6n9XgMZNvsJrEjGwT3gt/HNzBwmAosFDBmFRk/M9ibw=;
 b=CELFVb9DhQyNKi008qlg829rqw2naH+6WPcIxkSWLsiRsY92Ods/Mn9fYJflXWQ39Nfp2hla9nWH/rTb8+iigbzqC0viIKq7tzLF+6UqGwBAbHvKbwV05SHS/S0VaItr872uo4bwMnAnxD1yNmuLlKL1uj+NDrWjz9hkKm8/h/RNwzMMxqPKk5CEaGK1IdWbvl5qUaN4yx8uS/SYJJV7+VNOVzrcud2xpaKsVW+7a+oizynpngd+jLg6R0hZcCC3buvZFdih1vzkK3Rwz9szIEx2CQsH8VGgJzINV3A0e/Ey5OoIelHLDvYJxiglpadL08LBKgaQDMPVGxNZh3DeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n9XgMZNvsJrEjGwT3gt/HNzBwmAosFDBmFRk/M9ibw=;
 b=O2wp2Qxrmas/BG6PvRYucV/a75i/zW2S6wSvemWDXRhbXW8kyFy/XUaoU7t86ZkR2G+j2JNgW3QUuybUC+VUyapyUj03u0x/cTrc0+6JwFIh53CzcTf62yeJFfWCX4RX6d15lX3ZSGGyHXlL3szJb5tuobrmxUmRNM1DTkhAI6cB8f4hW5TZnZV3rIhw0WkB2GuRNLhYfim8ZZa0qQCRdLjOAfgzWzrEBDdLHlmF1DsqM67w29GHMozn+X+z4/vKj0vYgpUEv4zd78Gk4KNmQlWec/3dlabv1KgJNQXTUMgm5g2/dlLunE65JQCdXI6OHbjqbh/Nn+95xImwUD9d3Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 00:53:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 00:53:38 +0000
Date: Tue, 21 Sep 2021 21:53:37 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210922005337.GC327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 22 Sep 2021 00:53:38 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mSqW1-003nKt-IS; Tue, 21 Sep 2021 21:53:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4344f499-6605-41a7-f1c6-08d97d636a0d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173932973827DA92627D581C2A29@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1f9n4kiKV7a1Ph4FDKR0nBkyuQOS08KR7an8ZNw/yAAWl513NGVW1elmtSlUNu2evAITlOw9V2QRQP2uB3K93CXiWRmcShXug1Biz+l9xxeFU31iYcesxunRmJHI+hS0Fb5t2yDwGyzEk96COLqkfZHtsNd8tzUXK0u13LalUy0AmFA+t8fSbBw1dSta3mKBXlPmqPam3O77k3PJ26SLstXLNboI7e3NwJX/xSTDvnflZv+yoUsp6XbltHgR+CElLbUjodsdE0BwZU6KuFkXSv5ya/9Sd789Og5uFStttwjC2LBoLKpJnDwKCN9viRX1M2HbTH9MdOlKhXHyXYnwSHsPLJK3mYWxGH2x6frzRV6SvDO5IoM/Jkw2DFXJDd2OO5UyPd/uA2csGDDag0Tu7Pnt9nGKFJHIScNXlryxiSGes9/s+hzzd0I+DbVYcrPpfDjLknL2KYK4USNpbIs+BqI6xbGGoKcCu3RRheJq+qy9aAGmzN0sD15TeNzen7PEkv7nnDwrXd2wjOF2zvOeqs1Fs27w4250bcWzhZIrOOJIme84wMFNK8WiW9PzW8p/BgTRUhvzmikGvpUJmTfrmdiMM29bKQlVOq6dBSWfyREYsqMuN49um+Mn6VQy2Ii+WP9oQHEjN1w0JyBQBAjOyNXZ/LidXxzNpF1+q+TPEMiLaSYpm4JmMThqcrN+7OJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(2906002)(5660300002)(38100700002)(54906003)(66556008)(66476007)(316002)(6916009)(86362001)(186003)(2616005)(9786002)(26005)(1076003)(8676002)(4326008)(107886003)(9746002)(8936002)(66946007)(7416002)(426003)(36756003)(508600001)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0YaD16G7bIqSe15wJmrMlhGjbWXubS4h1bPmThzNmKU7sdMEdHkxUz2YB44x?=
 =?us-ascii?Q?vEhGB/f+/fyRT/466FP9GvCdTOOobi8DQkAg/uMSaQP6iwbRCtIG+cuprCu0?=
 =?us-ascii?Q?7xSbT1rZ8Ih28vcXX7jASExmZDlU7zrN2kHRBVwlLrgCecR8Da2rN82DNtLD?=
 =?us-ascii?Q?yrCnbfwqtLEf9WFqrfESPJVx2tHYuQhYds3s63CDmlktIof4YitMLqp1hDhu?=
 =?us-ascii?Q?AxJifYxcze+I2k9ECnxOLxDiwPvqpFvz55N3CkRNcevhp5iJyzouz9xCYd7o?=
 =?us-ascii?Q?EF2IyBMjZQTisuxjguYb6MWg5ZqSOVpwjgb6zgbAo5q/BuQHbr/TXZQEhsR8?=
 =?us-ascii?Q?4maitQIOPBD2D/O1wW0Q+WxgKZgwqjLtWdaq8Z4aMJx0gl8R4+Qyp7ktjBO+?=
 =?us-ascii?Q?hn5yDnl9Jda2vjnDT0jg4uW7luBB2XdAFFUatM/VBEuHQWeWOFFT1yA8DyxJ?=
 =?us-ascii?Q?8c5ZAXkArmkwbszmIHmq2iGM5+laGMDbcEqotvDWmOi3i9NWh38HUfsxhZ+Y?=
 =?us-ascii?Q?BrzSfpAAlpgslFxq0BROhaiY3inNxozvmgl/buPxluXaTZ3Pp4YQAwy78d/g?=
 =?us-ascii?Q?YsBQBXrBgTBn19XJ3uSY7FpT5x7smyjekk9iBAfQqLxFf8DpJfEdiLJfaC9T?=
 =?us-ascii?Q?OzWEuEgDMBJHIJCAxbl6wG59taUEHZRVlhqbPf/0Zi66ZlosadmphblsZtxW?=
 =?us-ascii?Q?KEsiVEWXI5ib6C913YdbZsJiGPREbO6gdDTHy22b4k/N+dZ2cFb0RpX+1RUj?=
 =?us-ascii?Q?0GoMRnow5xXfYLboVoqow6c85XitxH8mbXKc7IhaBlj1ZhMKPzccFVDhbt1D?=
 =?us-ascii?Q?+auegqw9doN+fDgu+mXSdu2feK05wBDeg6nAtLe5DEdndRdq6yzR0Ey/kotx?=
 =?us-ascii?Q?1keGYqdySYC2N8CEUk/ac4zzmwHi5yLlQu4CL4ICI2KlcpPA+ftin9nbwSEw?=
 =?us-ascii?Q?FSpvCkcZ/49+WlrU4Une6nyPRwfmZrCDM7b1CEsT0XPe0NMLEQTA88PpQSKo?=
 =?us-ascii?Q?seJ432cFc/apGH5SGA5GZq6eI61PjcYBMoXYsLMD+tNACsIJsHkHAW1fMOye?=
 =?us-ascii?Q?UfrWYCFcor+x17v7kYq/e5QvjCLLAE6Y5384/GNlfriW+dJ7LpoTgedWilGC?=
 =?us-ascii?Q?0nMmF47qADJxOkiahOnWj0/wiQ8x/8chZoXqVmLcFkNx672GFjFbumbpbPjU?=
 =?us-ascii?Q?EMlEyur5wIiaKDIjC5JuV7xEqQ6EPAduVt1IRxvlH1wJwp7uLhTGr6SfNLr8?=
 =?us-ascii?Q?GFFVeROHE3vUAcuCNKsGGfDdKefdVteJcxt7Neq0g2L8hobzYObx7h95mDEA?=
 =?us-ascii?Q?u+HISTx4qUSdCT8oPjII4LAP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4344f499-6605-41a7-f1c6-08d97d636a0d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 00:53:38.6229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geCUkfeU4HDR/DvD1KwfavGRNzk8YZ8eVKlEgDn8ApHajsEdl1iRyQCUsIWgziqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Tue, Sep 21, 2021 at 11:10:15PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, September 22, 2021 12:01 AM
> > 
> > On Sun, Sep 19, 2021 at 02:38:31PM +0800, Liu Yi L wrote:
> > > With /dev/vfio/devices introduced, now a vfio device driver has three
> > > options to expose its device to userspace:
> > >
> > > a)  only legacy group interface, for devices which haven't been moved to
> > >     iommufd (e.g. platform devices, sw mdev, etc.);
> > >
> > > b)  both legacy group interface and new device-centric interface, for
> > >     devices which supports iommufd but also wants to keep backward
> > >     compatibility (e.g. pci devices in this RFC);
> > >
> > > c)  only new device-centric interface, for new devices which don't carry
> > >     backward compatibility burden (e.g. hw mdev/subdev with pasid);
> > 
> > We shouldn't have 'b'? Where does it come from?
> 
> a vfio-pci device can be opened via the existing group interface. if no b) it 
> means legacy vfio userspace can never use vfio-pci device any more
> once the latter is moved to iommufd.

Sorry, I think I ment a, which I guess you will say is SW mdev devices

But even so, I think the way forward here is to still always expose
the device /dev/vfio/devices/X and some devices may not allow iommufd
usage initially.

Providing an ioctl to bind to a normal VFIO container or group might
allow a reasonable fallback in userspace..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
