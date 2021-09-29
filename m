Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CCDC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:22:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39BE6134F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B39BE6134F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BED860B3F;
	Wed, 29 Sep 2021 12:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uh8MiGmovUtu; Wed, 29 Sep 2021 12:22:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 305F260595;
	Wed, 29 Sep 2021 12:22:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B9D9C000F;
	Wed, 29 Sep 2021 12:22:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF31AC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95D0A6070F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWkFCbENDduT for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:22:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C037C60595
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGtCxxFn5yznuRw5LGCm8je11Kepf4NumGUhyXO3xDFl0m6WjO8/C4FeAM0Jg8C7+f/xnywI2Rf/7FmAow8NPugCvzskewDR/J7tEMqjJ+lC0SOlc2zrbcnS0HEQHYuNT+VidbI8PupR5BpPNYCwYN7rA2RgtYrAvl15KG6yy1DsUMUHNhERh00kRs2nebDEBadm6l2pOdr7xFK+mnBLAoP1EA1fMDRDKQ4E05l0ofbAb2fjdVUcuftsL8RH0kkCCnHNRg2uAgbrUCL8up2BlEXRL1h1L5P+OqydxO6zB1cYLUQ16MoYbRRTre8EXAerk3ypqatfLvWHET8zEi6/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DD2KhMu8iUWMeLlHMXQBhDvMZrGbT7MYY7pBvBwtVzg=;
 b=LVA5MmRZFolthocj336hWSBkbhp9bObLZ6t53kv7CmGwSTJg6Iglfw/uXR8iLvis+pU2zoiwf1xD5uChIFYsmxVz43m3areR/TjrCYxH4LG4MZRxLd1NB0YXEQFEsDXU2mZpuMRjSDOvgHulRZoLRk5aqBseuq7hr1dzltunQqiO9DmCftZCN0NH01L4vuLknIvLf36GrFLUgYvvn7m1NkI+/yhJ2BbM1dbox/56jW2b8Pwem2A+q9zGgKHSIDEhiyJx5L3KaabwC2ZJPvYMCVVx1NmebI9mgsmKWPVs6NVh1gjANHB74VRZ5snx7EjCZ34S4pH/ddgz2/hQbr93UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD2KhMu8iUWMeLlHMXQBhDvMZrGbT7MYY7pBvBwtVzg=;
 b=FYYzq1UB1cxE258cD+7U2PQrDuIBYtj9HpWFzDI3M6e5CUwY0tJo5WbwAhnjbUNz0swm8s+I1L+UfJi+yTG53z1QpYV4XIGVjRSHPa61JDgXl8Y8RRAgvqq/6vq/RqWMWAJOGY3Y744majQng1LShASNVTkgxvabspaRoeMJJXLp8taXNxibm3OBhRjkDKwBhujmNcfMg5r86LNAkDbnR8h+XC9hSQ4DgQSjI6ASPsvfpR8vkoXjhDUoLkr5oUxqB2RtSgWnxZMIoQ9ZN+IIZVrT9Q1NT8dkL/ImTpmUgDQWqr52nwIHhTwzLYYEe5TWCHBMReSUBw49oGb/Hq5euw==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 29 Sep
 2021 12:22:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 12:22:31 +0000
Date: Wed, 29 Sep 2021 09:22:30 -0300
To: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210929122230.GO964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922010014.GE327412@nvidia.com> <YVPTdqWw6or3mK/h@yekko>
Content-Disposition: inline
In-Reply-To: <YVPTdqWw6or3mK/h@yekko>
X-ClientProxiedBy: MN2PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:208:178::47) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR19CA0034.namprd19.prod.outlook.com (2603:10b6:208:178::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 12:22:31 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mVYbW-007Yb2-7p; Wed, 29 Sep 2021 09:22:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fef11dd-b499-478b-f9da-08d98343cf34
X-MS-TrafficTypeDiagnostic: BL1PR12MB5094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50944289E3E5DE5D69D26AFEC2A99@BL1PR12MB5094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjjObPny53Yy2f3GEEZ4afsJLA3cHQUOa77YUOtlONE3IL34HxzaqZMKmvNsGU6f6dEy7cRcLTlTWWB+5fxUcTcBNZ9i4EoYTJnXx1xraZZur5VyeXIv9CLaZaa0CXrZPH6uVSw5pwde4qcft5QR/gC/hYNTAm712pyf3+NFqAjNXm6of2vOg5IgxiWzRhWHYLYtXXprDSfFe7lVN5MzlXBNUzDpSnaMBw3ywT6loPg7wDPQNUi7eoGDixXma0nuuEag/5Gj1+5gXs6M7al54HDaJdRyDJVs5PVEkROkIy2QNaxHibIlrQ/Rj3w6wCuLpaacffxQKhAbpcMQsScRnYyK2JXys+2JuHXMdRZhwijXQAFBb3wjImEYEf0LbGuak8F8lYT92Q1ydOCwL6TZHTg5adpC6W8jzRJHo35ghuq8ZSfeqdXQyyV7EIV87ZXSJuMxkAev0mxipot/O7S7eMUMfw25OhWF4HeScCOyLOr7mD2uIiOEDby5wPbyskQmD5QilOUjubuI1QXUKLqhHGtIt1o/PTksWRNsosbuBYnZadw47sFBiqsW6OFzfuLzSHrzDyGt6pTY1wJKL3bsUFB9YCyx9duxoDn1J+HAexUbQk1IR1TIc79+8fd64s2xjr/ZVBWeHzF7SbCOZloIltO9eG1ACOvxj6XXGuUqhknPAUQ+K7Q3zxLkUpC9WMCS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(84040400005)(8936002)(8676002)(9786002)(54906003)(316002)(1076003)(4326008)(86362001)(26005)(186003)(9746002)(2906002)(7416002)(5660300002)(2616005)(33656002)(36756003)(66556008)(107886003)(6916009)(83380400001)(66946007)(508600001)(66476007)(38100700002)(426003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RldODqm3evrOao4Ng+z3H4WNG7ouLfOVvEP2iAAI6o2jrsbPhFXxlEx2exId?=
 =?us-ascii?Q?Y1AQS1YmtWeisBB9oeoAd23jk+TajvIbd3zrmej6QR4NQXQHb49yXd60JbwZ?=
 =?us-ascii?Q?BLAivsJNmQHjWldmDoEyepNbgfwgD+09mb8FQqQzjGHbg0BuuJZGgUXqbnPV?=
 =?us-ascii?Q?WtGck/kTo4KMJPe8i2P6wUIB6/xEvovrygWkjnFRn1UtJS3KJIquahesO9TI?=
 =?us-ascii?Q?Mtc6RT7xawoVNGiEg58SMjsLbJvoqN9HE+CEkfQ5ogGKticYF+SiOPUKfkUT?=
 =?us-ascii?Q?E9aXxBNXFmgCTPrjORbhZJUgAXOv4eymOolQ1kHuK64O3z+Yk25rRWA36+gF?=
 =?us-ascii?Q?eTWdQfRL36R5LK7PmXqGO9LETBCjJFEy4WxNlE9Lm9YzYcYxygsNi+DA5SgR?=
 =?us-ascii?Q?tfd40EQOr1pEE/lKdxZctCNG/vVIN6Oe3wiKPHcuGUVYYWZPSW9cXMu5IY88?=
 =?us-ascii?Q?psmw3Tb9pxBh7cE92kDO4Oy1CBOkDRbMPNayVWCTFNbJsskjYQIZOAt7O/H5?=
 =?us-ascii?Q?3vppnM1UzmmL5ZWvSSia/fz/xg7hw2Sg71R8R5LAvOcQ+d3IjM1WT2qRIbCf?=
 =?us-ascii?Q?MQMAInVoBT44e72WlofrYPi9EezPvWbDura857JtAKXd58iOYlxlk7q2eKZt?=
 =?us-ascii?Q?ugADc0s4fuqHEUCXqKXryV9ndZw2pzxraTMhf2zfkvARWGcr5k1cXY2ufGac?=
 =?us-ascii?Q?Ik33wcqXpyDRsoK+gE9mVM1PFiVq912/raAs0o+8e26Jac3araAjpA7pCLjy?=
 =?us-ascii?Q?V9e/o/34RVbu5mY4jkPG9JWQPRi7xmyhz+3j9tZUaEcp6+slS0rSc5+ekc+D?=
 =?us-ascii?Q?4rx3gc6D9HjGB2kW1zZDn//SYaUy/spQcMcxobbrwhc07qnzN2rlGQep6uEz?=
 =?us-ascii?Q?TVgSEVcxgmeObjyx+hvhk9CcL8GtX3pvu16HGRUR6j/iiDAuDzXdtoWtfLe4?=
 =?us-ascii?Q?gHM3Vs7lOqDrPXJ9XZ2HIWMphuPxR7RyTtbFy6QMA78ZBMkgzQiiUlRFgYkM?=
 =?us-ascii?Q?ilCxJ7aVjIdc20Q0pfSpameMRt7NKlB6EY8n7cdtVqAJHmet/4zPiXnmkFZu?=
 =?us-ascii?Q?L043Da5yfLmPKIFcd+vU1ENuNlE5tKVn0qW9SoaEiwCLZzwn/rNI02fFNClQ?=
 =?us-ascii?Q?Roc/hQE4NgoXlLAdkB079ISSvHLMwFSZNnZ1tVRIIA3Gqmz2lfvbT12vEBjl?=
 =?us-ascii?Q?N7RD+hBEsvkLpjoD22URLcfUiYfTdX0S8r8a27bJi1OMPFSxbJaxkL+lYKwh?=
 =?us-ascii?Q?l26yrNH3XvDp1ce99tJDh1CsPwqFmBA1ciBz6Pjq8/Tt0RGrXR/JQKRP2pUf?=
 =?us-ascii?Q?+9iL4bDpvxxFx9yfSjBK9nyd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fef11dd-b499-478b-f9da-08d98343cf34
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:22:31.3801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13ho2SB2u+Y12PjafNnOBwHOtY0RMfx/vZz+AlWI9X1yKaGCgo4M0/YmvW3FaNh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
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

On Wed, Sep 29, 2021 at 12:46:14PM +1000, david@gibson.dropbear.id.au wrote:
> On Tue, Sep 21, 2021 at 10:00:14PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 22, 2021 at 12:54:02AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, September 22, 2021 12:01 AM
> > > > 
> > > > >  One open about how to organize the device nodes under
> > > > /dev/vfio/devices/.
> > > > > This RFC adopts a simple policy by keeping a flat layout with mixed
> > > > devname
> > > > > from all kinds of devices. The prerequisite of this model is that devnames
> > > > > from different bus types are unique formats:
> > > > 
> > > > This isn't reliable, the devname should just be vfio0, vfio1, etc
> > > > 
> > > > The userspace can learn the correct major/minor by inspecting the
> > > > sysfs.
> > > > 
> > > > This whole concept should disappear into the prior patch that adds the
> > > > struct device in the first place, and I think most of the code here
> > > > can be deleted once the struct device is used properly.
> > > > 
> > > 
> > > Can you help elaborate above flow? This is one area where we need
> > > more guidance.
> > > 
> > > When Qemu accepts an option "-device vfio-pci,host=DDDD:BB:DD.F",
> > > how does Qemu identify which vifo0/1/... is associated with the specified 
> > > DDDD:BB:DD.F? 
> > 
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
> 
> I thought part of the appeal of the device centric model was less
> grovelling around in sysfs for information.  Using type/address
> directly in /dev seems simpler than having to dig around matching
> things here.

I would say more regular grovelling. Starting from a sysfs device
directory and querying the VFIO cdev associated with it is much more
normal than what happens today, which also includes passing sysfs
information into an ioctl :\

> Note that this doesn't have to be done in kernel: you could have the
> kernel just call them /dev/vfio/devices/vfio0, ... but add udev rules
> that create symlinks from say /dev/vfio/pci/DDDD:BB:SS.F - >
> ../devices/vfioXX based on the sysfs information.

This is the right approach if people want to do this, but I'm not sure
it is worth it given backwards compat requires the sysfs path as
input. We may as well stick with sysfs as the command line interface
for userspace tools.

And I certainly don't want to see userspace tools trying to reverse a
sysfs path into a /dev/ symlink name when they can directly and
reliably learn the correct cdev from the sysfspath.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
