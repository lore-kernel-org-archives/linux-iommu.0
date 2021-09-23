Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D986C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 11:45:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A9460F44
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 11:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45A9460F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08B67400C5;
	Thu, 23 Sep 2021 11:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fa_MUMkUjn-y; Thu, 23 Sep 2021 11:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85501400C8;
	Thu, 23 Sep 2021 11:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D021C0011;
	Thu, 23 Sep 2021 11:45:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB186C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1D8541630
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:45:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKdScSW_EkJI for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 11:45:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 001B2415A0
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 11:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjno6xLew9u3SG5O7sVLNOIUAcrtOdyC0EZ+0UYrrtva3toQauokjHI+LGQYvdRO7Pe90TEZtDwiok2IyeCpTI0S1tGzuC2a3DvxTMCefTjJ2/GIWufBcFSetnoLYmAWGc/5CIwU85uRamcD9dtuV/GHKwaKjMJS11AEz3bQw7hYJ6FsDh7Lwqx6FiU/G2AO/7ywpo8QfZo5O+EwMV7spsZpt6lOX4cVahtsvHD+7tZq+sG58firfA1BLga1SkBr0P1366Ce/H8RT1/wrFCOclhfDtjplWC7bBYEqMe0/9161Mjop3p9tmTkGlUgKt9LNFogwZ6NwRJvmYmYCgduxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=XkfIjQb2hAJjGoZSnA7Z2PiDOezal5SQ0vleZfSNTOI=;
 b=UztHhq9pXkpaTTUHiZ79fPblupVWCu0r7sW8cud7BQtaih0k2dd/j6rMhzG94RClH4Z9l/DCIp6e26sNYmQg31GFu12ufoUrvZHhWjU/vaBERlhCYMm12ktyR4HTxgyURtat4bsSqPAGBFqfmUud7NNlFvg+OAMJPgAq0ZnXy/aEVZ3EdD8V6LbyuyKsZYyiOxWXR30ZEpH4c6IXpbrt0X0CvPi6QFYDcaJWmiTPguDBWUg8r8m6KkMRT3pvgAC6EBDjsRBBtrM1wtXt3XEy6cYh7Nxk5nmO2cfI0ne+ixuuFudUXuwzGyT49OmmDL/cX+Z6DrIzNfUcH57ZgaLo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkfIjQb2hAJjGoZSnA7Z2PiDOezal5SQ0vleZfSNTOI=;
 b=Mn+7Yu0rXn8Q9G1Colno1qVhlnuSRXSLhpfqbCEVpVGAHKpaGtMtlZUTZPvxY9EWoGzmcNyEI6bR6oL+SroVKTXyCPNTDZqW+wJB7ys7FVyIKKVTU2Hcti4+x4X8LItVd/vhO6Dl6SUis4sx5+A791r/W9VlD8ve09hj6nBuL31WVGfyMXeynG9tuFyRvWw+gdO7hXJEoo44CWfpcwhatjQMEyxN6JlB8wmX81MmfkCB5Y2ud9fk6A+xRJIT7SlSJ1hMcxN6dJNyD1POCTegWTuAH4WM0KxkzLOe4l2azRYtXSv/b5cqcOtlSOiXFVDN1cZ1fIx8VEYhnrdkTKTf7Q==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 11:45:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 11:45:00 +0000
Date: Thu, 23 Sep 2021 08:44:59 -0300
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210923114459.GH964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922010014.GE327412@nvidia.com>
 <7d717ad0-fb9b-2af0-7818-147dc5d21373@redhat.com>
Content-Disposition: inline
In-Reply-To: <7d717ad0-fb9b-2af0-7818-147dc5d21373@redhat.com>
X-ClientProxiedBy: MN2PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:c0::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:c0::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.7 via Frontend Transport; Thu, 23 Sep 2021 11:45:00 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mTN9v-004OS8-HV; Thu, 23 Sep 2021 08:44:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47aa95b5-40f6-40eb-1f50-08d97e87932a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51283CB6089AF68E10BC2FCAC2A39@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbhI/JgZ+Lrgnwr4G2jkXlHaL9op488P1AenmEz3d25cB/27MrAlpdFpUvJTnS/vmTZswUQn0NMu88/oAnKlydj925KmpuJFypPcEQGCBqEIQwbvYWxSI99uGUoWlQ1AwqTDoeCYHz1Y+BoqAKAyoWURKem5v9sWpnsfqrZESXAkE1pUL1iBNcXQvXgWVXkaUWZtewI0t+/8KcZOBYNbjfYf9LXSV60NeiPN5H+gAM4oESPdW5GgG95LikGTv/eM+3Yrm6Y74NRr7MBQ7+SpdrqequiJNld1xvIbtYVTYBVHaxC4z94Y+T8m/bctDP/Iuy0uTxCGKuRHOrVG7hU9Mbx0qbMnBCEXZvPij+zr/VubM68UqKOG52SH7MYmtTeY5ABCUkYc+ADCZhpMIkYIYgjZf+56llvjHK4n0AqhWwVWSmAZIDOlnIt+l4ooCifhZb7299ncro8/RXcq2lcJUwMRtKMIc3JbJnLxvwrCYdgHgmjBHJubKU9PyzVWUyW/u1I71PCR3TbQ2PuOsFXp2JL/oIg9hJZrdn6EjWqV2pgUlJlH4Y3CuM98jwLc8/HSzlTXYLJ8nHskLqpS3oYdmkm3VXFScsSVKwwYvwGPlAs6mqqVQjYO/KDM8Rh7zhNJAvp0h0NQf3PYKIT9bZOqcjLCTgv0U63ERhMnWTNBSE9BOmK2nQyprXJ6bM6eiI+1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(84040400005)(6916009)(8676002)(33656002)(316002)(107886003)(5660300002)(8936002)(86362001)(54906003)(9746002)(2616005)(4326008)(426003)(7416002)(9786002)(66556008)(1076003)(83380400001)(38100700002)(2906002)(186003)(53546011)(66946007)(66476007)(26005)(36756003)(508600001)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYmHH8mOQXcy8S9MP8pxXyIp9mOM5EKTe9X85pixhO+IEBu3GVw1m4ULgZf7?=
 =?us-ascii?Q?JikV5aSIy6uqv7gzNT0Ei03qkorJqJAddXeWJz4STKGg/qoQmIHCD/7hL781?=
 =?us-ascii?Q?n1yUM16RAzyTmINJreQ00Ks3c//oL2WLPd5iydeJVwTw6bowBW34qF7kp0f6?=
 =?us-ascii?Q?S9/b0nxIzNYnlS5MfQyfJk0WvTBmujmbTr60g+Mcf5+VmuEI+O7u+q32UYaI?=
 =?us-ascii?Q?G6MKnqe7XQMu4PnJbIyA+179QIsoOfV5FTdEFJ7iF0OZ5WwvuhbZGHYYZEnS?=
 =?us-ascii?Q?+PXwpApjRmX3wbDWIGYEOpOBzQvKD+ySco9EcRjSgSqjuSdAHq/Xzvw6LdMA?=
 =?us-ascii?Q?uVeYXah1aLAdKbMTWQgzPu/lKvCZP/erY/VrMfODVeNkZFdOgUU6cOmW8EkU?=
 =?us-ascii?Q?rWMJJrMxps9XVSnbNiaeZ649h/zm9QcEW1Rn6uOJCyYFC7GiJst0GaR1JTnt?=
 =?us-ascii?Q?YmGiqyx+4X4hr752BHCyA77nE/tajzl2Mw57mnVR+CIc5zaFYOzEJ4rcmjo/?=
 =?us-ascii?Q?opExy9ySp4Soq2kxnpZHOViEWJSnzjYR/WQ93lVd/jKSyHFczYKb6rBOQVUO?=
 =?us-ascii?Q?P/s7KWfk8AVyDOxe1Dop3i2ArR6I4QMRcJTOo+thEH5starYcqPTOqXEZwO4?=
 =?us-ascii?Q?Mqr6/iyywTaCaorNWfFhNO7XK+QNEY765mNV89BOcezP9BwzGc1YyswtfI2i?=
 =?us-ascii?Q?gP+FlHr9EZfSm3/IJxW2BkFRyb0TtilFiLIrJlZdJr795Yx7ywhTqW+3/Cnv?=
 =?us-ascii?Q?KEQv0GKLmBhGb3wkLoPWktFlYdCTBFEMPrM9UnZuFBvHq+0CCGcbFkJI+aob?=
 =?us-ascii?Q?vB6tfUrDCVY8pomaBOojDO9wVFWD2XIY5/FeCTufznT4HeemDPoKVOdLK11b?=
 =?us-ascii?Q?sUpL74lCxkb/3S0bKiFpIMsj4sk5Yqolr4rvIozv7el4mrpdiVjiOqoYwnkF?=
 =?us-ascii?Q?ooiBjYbit30oArI8URxn1LqExSUDy1Ye7mCzAMvPsDdN9NYJWnZd1q4K8xhu?=
 =?us-ascii?Q?84GbOiWsyzPSxiqhAdkc393ZQTPcCwBnvXztJencStJqT4y57VyNIi1vIgbW?=
 =?us-ascii?Q?crPw9SkyALdwQXSLQq1LK9f7bT0YLCIVysDQuIxJWe1Gaw6KddL/ZwHuienY?=
 =?us-ascii?Q?iL5fYv0Chjiogp2e2/uBNRjWUpZZ9OzAdhJylnwjsHFyWNGnpmQZan6NScu8?=
 =?us-ascii?Q?/e/tSpECTj/atY18OPs7ky/0XEKfcBTsXDYPXnweUjjC5XyTcNqA9ZRFTfHx?=
 =?us-ascii?Q?BAo14OrR9nXxEKF1SAhSG2tR7VBCOgBz9LsVYYTNzNGuxSdni7kMm1swEvju?=
 =?us-ascii?Q?Ro/2n2QWC+3L18aD/TL5OUBw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aa95b5-40f6-40eb-1f50-08d97e87932a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:45:00.6850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8HqDX6nFvYYZf6n/Z6jGQztjd77Ijm7e9Hj0mrBUqJDY1iw2Q8ab6dRMWMzLfo2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
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

On Thu, Sep 23, 2021 at 09:25:27AM +0200, Eric Auger wrote:
> Hi,
> 
> On 9/22/21 3:00 AM, Jason Gunthorpe wrote:
> > On Wed, Sep 22, 2021 at 12:54:02AM +0000, Tian, Kevin wrote:
> >>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>> Sent: Wednesday, September 22, 2021 12:01 AM
> >>>
> >>>>  One open about how to organize the device nodes under
> >>> /dev/vfio/devices/.
> >>>> This RFC adopts a simple policy by keeping a flat layout with mixed
> >>> devname
> >>>> from all kinds of devices. The prerequisite of this model is that devnames
> >>>> from different bus types are unique formats:
> >>> This isn't reliable, the devname should just be vfio0, vfio1, etc
> >>>
> >>> The userspace can learn the correct major/minor by inspecting the
> >>> sysfs.
> >>>
> >>> This whole concept should disappear into the prior patch that adds the
> >>> struct device in the first place, and I think most of the code here
> >>> can be deleted once the struct device is used properly.
> >>>
> >> Can you help elaborate above flow? This is one area where we need
> >> more guidance.
> >>
> >> When Qemu accepts an option "-device vfio-pci,host=DDDD:BB:DD.F",
> >> how does Qemu identify which vifo0/1/... is associated with the specified 
> >> DDDD:BB:DD.F? 
> > When done properly in the kernel the file:
> >
> > /sys/bus/pci/devices/DDDD:BB:DD.F/vfio/vfioX/dev
> >
> > Will contain the major:minor of the VFIO device.
> >
> > Userspace then opens the /dev/vfio/devices/vfioX and checks with fstat
> > that the major:minor matches.
> >
> > in the above pattern "pci" and "DDDD:BB:DD.FF" are the arguments passed
> > to qemu.
> I guess this would be the same for platform devices, for instance
> /sys/bus/platform/devices/AMDI8001:01/vfio/vfioX/dev, right?

Yes, it is the general driver core pattern for creating cdevs below a
parent device

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
