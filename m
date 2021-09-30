Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B39C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 22:24:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA65261A54
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 22:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA65261A54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B02C340478;
	Thu, 30 Sep 2021 22:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-Vm9b0wOVnL; Thu, 30 Sep 2021 22:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 803CE4039D;
	Thu, 30 Sep 2021 22:24:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EAA7C000F;
	Thu, 30 Sep 2021 22:24:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5976C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 22:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 920B44035B
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 22:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rO-4dBwMNWx for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 22:24:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF87D4016E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 22:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZdo4Sbgm1QfBvexvLngKcY1Kfruzd7/x1N3oF3XYiPdVYz1Gn/FB7siPX5vXiK8m5M7qqrlFH+WjNIlOzx6OT6SCwPU1p5kTkCeFh3+LVu6gPDBv7IIUPXqIcAqUd81H0fzK2hMWVfF4aMrdhI83Q8bmJKHRwgwQIcZUpIEvajV2GvQEjqW8+v7xshlqeWXu8DxHGGp1+nMD8tRsOeYzYCxjR67520iHpo7bsiRXfHnybCkxRJJkzFMv88cKQyjM98q4YEnwR3xg1rQyJq5sg9qOlBQ77DAT2PF82Un9ULuFmVeV/8tzRoUjY3b2WAocOeqx/0ap/82Wc1JFd8spQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8rYvPryZQKrIM8tEkD4vvVoNxAafaUuLd5XFu4X+ZA=;
 b=f0uZ13GQdcHvWFDCHZGiXxbG496999RkLJzTdYkU8ePdHMHKt3xRyDjh7JgEiGzK86/SVjQUbwWqdQmfQjW6MkOkallx+sEIGA6B6yIqkyd6Xm6PpI0IPx3a0dmA9+Kf4nzGnbjuyj8OYwuJw1cG44FYSoTusyw6dXkD6yJb53I65i5JCKFZaXU7D9u/fds7cd1a3N+AuOx1JDaewDTm7qimx7aT3zIfjrWk+UV8VPnbGmwsHr3/pZcgyKR/89HFvyYb7OwjfCvGhaDTkQMFhIg3sjqMm0FA6zhr5WhCETiReKOxt891oxK151804tcgCFnL3vHCppSYOWCdU76mLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8rYvPryZQKrIM8tEkD4vvVoNxAafaUuLd5XFu4X+ZA=;
 b=oGeP9TP85U+ilU/nal3YOr1kf5Vn7uDTSjXQ3TuMLoNOfpw8jxD48yh7/q5xscCtBg4uyIX+fRu+911QSEMBkeSjKL5kRisjBm8nG0j1OE0vt7aMeApu5MTdlY0+PHWjokaCAgkykjTIMLClH5581aNhqFHNJEi9b4Luh7nHpyJUM2oxoE3bI3B9bkn6eFCEfPIsQ7npbuMEhhUwjAV432jEYaqh2oWQBeD9Xwgpa1el7eV5YMFTyPuVO4Y63vHwQW5VzJDF847uCeY6AtKavp82XVWOAJ/zPgp6gDqYA5RCHAb8segVXXh9EoHsT4nfQ6b4h5Hc/V3+/pY2lvFTJA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 22:23:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.017; Thu, 30 Sep 2021
 22:23:57 +0000
Date: Thu, 30 Sep 2021 19:23:55 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20210930222355.GH964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:208:257::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0041.namprd13.prod.outlook.com (2603:10b6:208:257::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.8 via Frontend
 Transport; Thu, 30 Sep 2021 22:23:56 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mW4T5-008DTq-Rv; Thu, 30 Sep 2021 19:23:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660659d2-9d2f-4e8b-8ea8-08d98460fe49
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5364EA843231E93F4B9B2BC8C2AA9@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlCSvIhLy3PdGWTrMrMDSwohRiYaSuvQ7OP/2UKrWz8Dm+7y4gQSS1W2MlJGJnOoxLtzD+DRb/q62LCoxxmY9MPQUby8sJIqKQ+zbbP5bs1Kdc66XScNJchJKYWtb72+R71pHILQmguflmZEW2B9TaQfUK/amWaLtdfJSPopqNqESsbDYflhwdAEwY4jijhqpfnkxnXMPwE21X4J9tHeGEJZSMkTVShV9wt2XGy9/y9RTQg9oe0EL0yIAClCKjgQ9jME5eiAuV8ax7EjUsFuVZ5dUyYpAMhBOcyn9AdgfR5qE5CMT11he3VcHwKHyQWUOUDWpom3OIH0RWqAyWSRBc13MjT71DMNKDgP2zF8nItO3AwEa8Q1udRMUBqkB4xFtcPRv5B5omv418zyAjEegl+bhBwBEgig3uzlZX3kw7o/l931jcRI0q/3x/AiriDaP4Ur/Y1aiuswjT4QmVcpKcsgDEXFcrmd0SNKG3d3BNQGoAthS0Ww8Xhh8nq4p3QWXv4UYkjo9kBmsFvp7mcXbJ8PlU7Dof4VqHdgnAeGuirhcdFme3yJSZgAnnjaNuGLpWXhhH1JNaLETRXjc2MtHHepEZGKuXpj8piqhMHftOzUUv5nCTd9x/2xYycqQBA+vG/6j4iJS5cLG9pdQmAB3g7PTIxlvalOA4fqEC9mljDcYD0DqnjYduzVMqpalGZRvmYzZHTF1XhRXlz9XmAMiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(2616005)(4326008)(36756003)(38100700002)(66946007)(7416002)(6916009)(8936002)(2906002)(1076003)(66556008)(316002)(54906003)(83380400001)(8676002)(9786002)(186003)(26005)(5660300002)(86362001)(508600001)(426003)(33656002)(9746002)(107886003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79NX4HWYP2dXDjiTOUCq5N1UCjFmRGk+GYjd1eTzU8ii/evP4zWAAH20KVwZ?=
 =?us-ascii?Q?okqL+KXgkuhEwj0rTYrBLyb8RkKc8rP3yeyf1PGPEVXZxPXtaupyUqf8/RPa?=
 =?us-ascii?Q?fIPNhbuCLtgL9EybbcFSvcTXvapEmroVEDkDKgf2ojwBCarSNGjB4DDQIVsQ?=
 =?us-ascii?Q?1+Fm+ofBAyDwSBX3xc5KTa/0cm5JDKRcnDrQimpVXNrbHF/P5A2139f2LaaN?=
 =?us-ascii?Q?YF8XrGo9kNZ+Zv3wTjadqLKolyiWD1ITeLea5MYnHzLfPc1mMZNWs8Pzyk8g?=
 =?us-ascii?Q?7QZsDDjibxC0Qn4KbppHvD4uzZoujrEjLrinlOoHEZJpD4yeFZmwVWWXf9uk?=
 =?us-ascii?Q?VSWXbZnRez5e8uiUoweedGxq93FXg+lNDBSvxTW+a2wxGSdzpRWX618r1GLn?=
 =?us-ascii?Q?u2w2+cDWsvAOJMJ5RtnutXHfJ5/zDN+PRZm74d49Xq4kMPNXFVi1lKFZ2hIY?=
 =?us-ascii?Q?1NjriIFRdEIJe0PYyNH5FnJjOK+tlCvu+W7wxT/rcwtMllfAsyfDcLWP+D4M?=
 =?us-ascii?Q?67pAUs2HtkN/WLjIrpHCt3f28BS/xZd+Qcp7F6xhIMbHp6MGdypbI5InzdFq?=
 =?us-ascii?Q?MXRevGtvM+b9eCPyxcnLBGONEUGQ6J+7eB6kKTHDYNbtKQOd+tWPch8iulKI?=
 =?us-ascii?Q?Okck62rmgj7SPG05PEj/wCwJC0MVyaOiayCOZkGy/lE3OJe/ULyL41RLJXlR?=
 =?us-ascii?Q?kNXeF2ry9XOIgfRG3kTwd19vU0zijoeGYBQlmZQHT5ZonJ0jtGeqd9IPD2SN?=
 =?us-ascii?Q?B7kj6inx+hFSAYH2bWAfq9nmoXhcmK0rWPVAGYWBUi/177w1bCS4On3ess7j?=
 =?us-ascii?Q?lnseJZTKOn2F+FKgTwT5/v/mFQpQIIXbm+IVz48Q0Y2Tnv/UU5lL9BYbYORM?=
 =?us-ascii?Q?kj9tSokhl03vgKZCCP6j9welweeE0xiHI1gAyADOoDw9mh/b3pCLJjEFE5p9?=
 =?us-ascii?Q?antJn149I3ocnfPLopCaHzpf9Bi+5y+mcb+7VbS1ggluXQ7cjK8br/HFWdSV?=
 =?us-ascii?Q?dXCy0N8kIJLPL4OoOVwpgqRg+mNFsVzlOBMjkbFcM6F3qEsvnGmOVVuTu5mH?=
 =?us-ascii?Q?GvuSUCM87U0LJ2zDMRM6zu0JFHVdS3CwtYPTM/iZ3qEVH9V1Wm6gMh8OTaB/?=
 =?us-ascii?Q?Bz0XH6e5lMiJNjMZ8oM5DtkhKqhb+COg332Dfj9cqmMs0y16ouS6Ros+CzVK?=
 =?us-ascii?Q?+GK01CK8+CgSZzQ5bU4xur6+YkTovBnw217T9NGKxAa5q7x0TWcMmy5Frsuy?=
 =?us-ascii?Q?KUA4aWTOR6xT7JQhNVN3fLZVxXqRnwXmhXyCdeiYjcOHB/LsA/saCRHu+w41?=
 =?us-ascii?Q?1Ju0BcgWxa3dFvvFDL7MRMFJhvqjj8ODtTdGa8Ha/+Lo6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660659d2-9d2f-4e8b-8ea8-08d98460fe49
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 22:23:57.2444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg24VqEsfKxnMglP6ZEfidJAgmWXRJzvAQsfCem0GIp4qdPMeQu2sMwoWlDVDZaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Thu, Sep 30, 2021 at 09:35:45AM +0000, Tian, Kevin wrote:

> > The Intel functional issue is that Intel blocks the cache maintaince
> > ops from the VM and the VM has no way to self-discover that the cache
> > maintaince ops don't work.
> 
> the VM doesn't need to know whether the maintenance ops 
> actually works.

Which is the whole problem.

Intel has a design where the device driver tells the device to issue
non-cachable TLPs.

The driver is supposed to know if it can issue the cache maintaince
instructions - if it can then it should ask the device to issue
no-snoop TLPs.

For instance the same PCI driver on non-x86 should never ask the
device to issue no-snoop TLPs because it has no idea how to restore
cache coherence on eg ARM.

Do you see the issue? This configuration where the hypervisor silently
make wbsync a NOP breaks the x86 architecture because the guest has no
idea it can no longer use no-snoop features.

Using the IOMMU to forcibly prevent the device from issuing no-snoop
makes this whole issue of the broken wbsync moot.

It is important to be really clear on what this is about - this is not
some idealized nice iommu feature - it is working around alot of
backwards compatability baggage that is probably completely unique to
x86.

> > Other arches don't seem to have this specific problem...
> 
> I think the key is whether other archs allow driver to decide DMA
> coherency and indirectly the underlying I/O page table format. 
> If yes, then I don't see a reason why such decision should not be 
> given to userspace for passthrough case.

The choice all comes down to if the other arches have cache
maintenance instructions in the VM that *don't work*

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
