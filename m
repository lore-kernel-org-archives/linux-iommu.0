Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BCAC4332F
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 01:00:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F80611AD
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 01:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0F80611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5AEF818EC;
	Wed, 22 Sep 2021 01:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y6r4CJLqin7Y; Wed, 22 Sep 2021 01:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9802981916;
	Wed, 22 Sep 2021 01:00:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75010C000F;
	Wed, 22 Sep 2021 01:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD29C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 01:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D3F681916
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 01:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3phFdhm8pUKn for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 01:00:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 408D0818EC
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 01:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxxPZpawSpxRw4mlW+wdkrWzwrUWxnYVDEI2LQ9veW8O0iSXsZmqy0T/0i4hyHRoF0Xb/2urObBIOYzEyjKZQ7CmJQlHkxhpLIZACP0+3Y49AZ7Gb1S2dS583Ie57rbe55WVUMwJAN/Pv906E1IGxL34TU7b6ax3QaSRLgOVL7+3bGHgQuqTQcMbb5h88BYrGsDveXYECiSZvIMp05uIKhQ9FROpfoixbwYOeeGkVC+mBoCkLfcNIwV93Hh5/KN+xvSDqDlJBsW3O8GWb6cQLW4ky4N9cXafwAiIHStcDwpkQ9LmjYqyS3YG9CK5LCOlkb3Zxo3ZkhnApiJ4TqPrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=o+a+edFqbp4EnpMhTO0QIN+pLqeo4gQSNSXbuU0dO9g=;
 b=B/YvcW9EOUJZCBlR15Nm69rBZySKPegnOSxf6IvpRAod02R7pn7T7uNPfgavdOIL7TvO0ZjNxtmPew7D0cl1DD+uIiPZTy2D5YW1AjuN/7zr6BGBzz+I/lYKVkv3r7L3ugftEKXsx5WyrFpKb/CCn8FBuzLfuxhpAXVyId0Lk1Ft122wgGu8YUARkkEkKpBOsP1i8Fpye0pCJx2OL6FJAMYVYafHxRLvYTRw0XJ1RZE12rvpMNbVi0a2JrhiN5/13k3I1X0bbbJXNjN9u20z720fx3qe0qb+FLPqh3Ufm70SyeDfG0EKis4Etg+Pn7ATXOmx4WbWLqjG+kdVqE5fMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+a+edFqbp4EnpMhTO0QIN+pLqeo4gQSNSXbuU0dO9g=;
 b=M0VqKycfHhlu9fwcyLVzzG/GIxHmsgFrAGrcct/Ge8PX8qLcAlDu3TK4/aouaiRgfkMrsrFLXx9f8m67ubVAXEAG9Mvj2DhMtX1LJ5kwyUbfnM3A48eYVid2AVwea7nxVvtBf+88LO2obOLWlU/4eRaQ9iOIRo9dc+a9m8oLCHYRzbLBz8I8zJJFQXzFSbWV/nwLQ8wnEE5e+v4s5aXvg7Hzaa5o3Kr+MmRaAwgubSc/T/MTXyF19/AKAZJy0Ehe/93XJ9GOla5ve+DJSiq/+Ak7a7fXrmQX4u/swz/UzBR84BUjl5z4KTK6ZjXfYLIfFvGslrMDAwZYXBkmtilZGA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 01:00:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 01:00:16 +0000
Date: Tue, 21 Sep 2021 22:00:14 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 03/20] vfio: Add vfio_[un]register_device()
Message-ID: <20210922010014.GE327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0160.namprd13.prod.outlook.com (2603:10b6:208:2bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend
 Transport; Wed, 22 Sep 2021 01:00:15 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mSqcQ-003nTW-Ms; Tue, 21 Sep 2021 22:00:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 518490ca-b6f9-43dd-e2e7-08d97d645704
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045E9C4954766045CD99425C2A29@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33Ws7K6Q7gEJxDqWt23lzwpGwItuO7gSG3dOsYuZQgFAua0Uhttqia1Y1r5ugo16AgN0ptSIOqKUsctaEIAIbzuxL/b0YuVhYLV3IxTNmoRsS0ZsSdyE5D/MGxMrnWy1yli4lriljtv9D63AS8YyXJE3rf2WoVzLzSkfjTYtqPtXNlZ4eanX86mjTgBtvlsoIlbg83g/1s11YHQ2GqoUoG5iKuCSrt5A+fEj+FXO0sDnG455gIvGAgfOZmRStK4JMJ0EUJn6AlRN5XDcpIxT9oiABbgxB+OSxgfjy1tyVMx4HHOuNPAvRuOziCObOM32KjpyaOuoexRogBBPly16EQza0KNZy1Qn2qh6fYbL2frOWYOuImnaXFjVSPjhpRQeiOOdV3dUHjIfqXPFVvr+Bcmzzt+fjqlOzrGzSa3OmJQTQMftbtyjQxZJYFWOrH6ZVlLpCu4x2WpD+ONlThpClJmNp+yQPkeurOuUnJqhiQCIykrdcu9cCZHajkWs9Sx7057GJCwD0IBOHq4nv2ZDB7wIFFUVU45ur66WdG7txFcmKBe5z/wkLoJ3jJu4fIeueH4ZfEjl469L0x0m9QULFwEnSsV9GNFgohIHCVL6uujYduEPQlIsuCLiSQ7sVlNfqbvil/OHfor692uITDwa4mH8sacyOCSVybXe0BYx9PoSV/tXSfA2lcQd+DSgb54U3ULZiNtCK3cgIJX3PX559wuMnRI8I+7WTk4dk326P9UNoZ/g83vgT9Zl8yxwfWJelV+JxbNBvGticuVb0fxRTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(84040400005)(33656002)(2906002)(7416002)(9746002)(66476007)(186003)(8676002)(9786002)(508600001)(54906003)(6916009)(966005)(1076003)(5660300002)(36756003)(8936002)(316002)(26005)(426003)(38100700002)(83380400001)(66946007)(86362001)(107886003)(4326008)(66556008)(2616005)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2kOsjlj/pfWOCQ5o4ajzbFl6WYNsLQgVcKDvS5g6ElvrNC+rvh8kkc3nsVq?=
 =?us-ascii?Q?I68RhP8DiZxRIQL3sfKX6yBpYtyIAhH44hiSbxYzo8KFEsntvUl5oISrmJLI?=
 =?us-ascii?Q?8ifylMOXDezw3t/eQj3G64tiN8qhXDpVl00IE6gQr3PBMulV/xQwdE7P87FX?=
 =?us-ascii?Q?PI74Bu1Nd4D/6tbopMX0Mhu2InWVt3Bu1qAPLF1ItnbE/ZpPo+KK1zkUspPw?=
 =?us-ascii?Q?0oE7xr44qSTZnJKrwWK2rCuHWeYXhKd4/ejNY4ifoUIONRw2DSvdwJPYuzD2?=
 =?us-ascii?Q?FquvQwc5PfjmebJihB6xwpRKujCwJ9dI9CzEYxOg245ZQ/p6PimCLkRBLFEd?=
 =?us-ascii?Q?cMcqiIgCxYEju8uBbth5MTvhcpwinsZqU1+Ou7W3pqpYU0M3AseftNNRaUw8?=
 =?us-ascii?Q?rezCGJhXNuZWiPs++HZXbSPT79iAEFa8D/CVSTc4ib8XuR5lQ/qe4UescoLs?=
 =?us-ascii?Q?vttvvg6gba3Bc9AStVXhNAWGbfXrITkWL7PkQaoVB8qCdON7/llsynRMGB2Q?=
 =?us-ascii?Q?V4PhCDZEwJC6QHw8HJj1gvwYJGVLlFq5rbkUk4M+8bY4YMx2ZXV7tP5rC0H5?=
 =?us-ascii?Q?XZtIlPQ2y+zR20MrsOk7MGg6POG/FeE1Axj9/pybJzC45rXSG4lwVX0vjZ4a?=
 =?us-ascii?Q?8umb4ctZXWRHmY114jylaDtgseTOSymsGM6OuKLoPXYVQU8xVMqG0sUK2Xkm?=
 =?us-ascii?Q?0H6h4EwPMsEJKRKayYd5vMk3R08cBu9j05/2GB8bcjPVFA2CfQZHHp9JIzgl?=
 =?us-ascii?Q?dJMIM7c5OXsFofWUC6bkquXLp7dpnUyiqentwguN1YtefEWzj4rQzj8Djgu/?=
 =?us-ascii?Q?GrU7h8KjsnmVHvET6iU1x4EZl5nWMM/8LN1FTYOjm7UMn2BrdDNNbesNkK1m?=
 =?us-ascii?Q?AK4d9qe7V1bTbs2+n62H/th1z9wAiDYp+rppVqomh2us+K7Dt0lFoqiqMYwT?=
 =?us-ascii?Q?UlCFXKKYq2mZdZmYMD1K630ly3pXQjEBBMcGZd1ZR40vZnogD4Xh8QnaWNHX?=
 =?us-ascii?Q?WDRRhsnAli1UFpcX4Z6SToBM7DK0r5VukDFkBBhkzwNqhnhP+x2fhPIS+0Lm?=
 =?us-ascii?Q?2QW31GwSlUgjLnpmc7E1/rHCQh8VhUCgVetE1KMTi1VHa7T171LsKcK+MdWE?=
 =?us-ascii?Q?EbTyKUKehXLQUB+WZHf4WC6HAxpGpfIOEE4TU1jNkixCBulUprgsNqCWYts2?=
 =?us-ascii?Q?fXaDPGgArdMYfxYNa0LoV2njW3JVCQY2UKxQbdqj6eYpr2jJnPx1oS8u64FU?=
 =?us-ascii?Q?ztj8HWeleTUmV9jDFRzbhk35stx9eCIjL/K0sZlGTjj8ObdzT54wNd65G1fA?=
 =?us-ascii?Q?L+G982X4/VN6cKEo6zsoNtA6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518490ca-b6f9-43dd-e2e7-08d97d645704
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:00:16.1159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beG9Ox6uWcIDl2UCiT24Ry3fdPCfE8R5qqMm+9Wzi4BfYbcCYXDu6HrF9O46PBin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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

On Wed, Sep 22, 2021 at 12:54:02AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, September 22, 2021 12:01 AM
> > 
> > >  One open about how to organize the device nodes under
> > /dev/vfio/devices/.
> > > This RFC adopts a simple policy by keeping a flat layout with mixed
> > devname
> > > from all kinds of devices. The prerequisite of this model is that devnames
> > > from different bus types are unique formats:
> > 
> > This isn't reliable, the devname should just be vfio0, vfio1, etc
> > 
> > The userspace can learn the correct major/minor by inspecting the
> > sysfs.
> > 
> > This whole concept should disappear into the prior patch that adds the
> > struct device in the first place, and I think most of the code here
> > can be deleted once the struct device is used properly.
> > 
> 
> Can you help elaborate above flow? This is one area where we need
> more guidance.
> 
> When Qemu accepts an option "-device vfio-pci,host=DDDD:BB:DD.F",
> how does Qemu identify which vifo0/1/... is associated with the specified 
> DDDD:BB:DD.F? 

When done properly in the kernel the file:

/sys/bus/pci/devices/DDDD:BB:DD.F/vfio/vfioX/dev

Will contain the major:minor of the VFIO device.

Userspace then opens the /dev/vfio/devices/vfioX and checks with fstat
that the major:minor matches.

in the above pattern "pci" and "DDDD:BB:DD.FF" are the arguments passed
to qemu.

You can look at this for some general over engineered code to handle
opening from a sysfs handle like above:

https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
