Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAECC4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 23:24:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2733F613E3
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 23:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2733F613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C86F260071;
	Wed,  2 Jun 2021 23:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0LdsUWjGvrr; Wed,  2 Jun 2021 23:24:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A7B860798;
	Wed,  2 Jun 2021 23:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70957C000D;
	Wed,  2 Jun 2021 23:24:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36FF8C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 23:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D49C83D6F
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 23:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id atGUb_AzSpKZ for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 23:23:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0156E83D5D
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 23:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efAh6Czpc1hFV+/Ej1WqkM8bm9NRmrQ8+mjtLrrpr5QPFylPLn4hvtI9WddsEhwC9ETCTFCZlK5JTr6FDJvZK9aA0+5+h6bOtbNTuW+FDhvDS4UMJWcRo4Jm5b4+6mGT1xH+sj5ZyrMogSlQMh6MUhfPkJhBwZY04F3pPyF5y25I03soo+QLwDjHdfgtMbAPQDHBJceiQVgbkVYku8kszOkR/60v3BFbyuVlCeVJ+u5qUFEZXJ7wj5o3NpyW/Jl3WwS7vSMEw/kuLdh00hCimZTX3FBzSo+5ceV0qjUDHzP61LJtnuF+RSORV1fexbRqvgToGh6NG05D2AmNQRpcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZaDDAdTIzcqX3vYzk3vYCL48Z52p8sQ7SSTU8OvbW4=;
 b=WyPWvJrDavH7vWpEV1XnHrcAXNM4n0yb/CfmHiyenk4gCZxYsDFKkG6OpZlLzQMGi5aKD9ah7EOneaY2u28vs7b03YYwI7Ttu5EDoCcCv+HfuTVNMK++xElgSSluqrOnSHDBr4L7QbFx4U+ubjCYBWqreqHPoZfnICPVsaw9YQ54gOd8X83b7m1iEIiUFu9kTHheYI0zAAbN/w/KHfo8bp7WbblUbHCCXJ5RbHfWP7CmDnjNH/yv6eiwwg0+CiOjee0vgtlRlJFsvdTuDl5U8r8LYULniU+6bwtmu1bz5xOFmnmXR/QlCB3fVxufgwA72DP9YsNAptQr3y6SiS10kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZaDDAdTIzcqX3vYzk3vYCL48Z52p8sQ7SSTU8OvbW4=;
 b=kPmG4fyoTebeLJquVQp1QxPyet5IXHExGqTpaQIWCUzrLAWed3xy0WdOtGdZiT9NYoSC6144Jr/mAoWl5hW1bjaGq1xECYZlTt9w0FCeEEO0AY98iRE6+56FA+11fvI7+O1YRr3k4K6NReViP11TBzEiFqxad5XDZUfXwyAeksvplBROT/ymi+/t/50ELh+KOzS4OqNl+byREENBHuH5ruKMAPOdSS5BMhydrsIQo70rVR6tEzF1hv5l8OFmvUfx6V8t8jQO5cYlHNE5jgjeHgiri+EJs0RHWvq8KfA82XShYIsLKYkqwKEisXKgrISln/7Vpu5eoviryjDnvxUp6Q==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 23:23:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 23:23:54 +0000
Date: Wed, 2 Jun 2021 20:23:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602232352.GL1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
 <20210601172652.GK1002214@nvidia.com>
 <99c765d2-5fd3-002c-7c7a-408a17433068@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <99c765d2-5fd3-002c-7c7a-408a17433068@linux.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Wed, 2 Jun 2021 23:23:53 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1loaDI-000nMR-H0; Wed, 02 Jun 2021 20:23:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 285d7757-0392-4b8b-f760-08d9261d7cc5
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5523F974DD0D635F8AEF7192C23D9@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irhB/EuFR5yeFeQTPTNUP7HapM+SdLs0QHDqJVpKQPdhbg8mRMxq5ZV6Nps0RtZYNnunJT07W0zzL2MKALqI3YuIszW8m5pPQ5D6B2/HO6dIixx5brqG7r/3iEVYKPaK2O3Ya4pidYcP6DNFwmB0FiJ+mbEdBiuO29/d6krHUXtDjziII3C9Z4H2NRdyjho5ylZMKpy3cKqPva6bvzPIhl/DaJnqkrUjI3mBaMbmR9o2QrzLuTYwK3heYW84qkAv0PolLYmI2NjjNHNcrv3l3wmZJm16fwfMd5VS+QcUnqyaJ8OuKHD4glZ/6A5jCgR/XWWYRVzAc9gd/m0lKhPQjOEOkY5HaryUiRu0Y9eU1w3TNFAPFh7gExEbszW1aa5I4iEQ0p3sFN9YPgHVfcK+R6k/tdtu/2o5Am5C/Zr/vpbf8LntGApfY+m8fj/5aylE45aZ/da6t0QSdTSGrU64T/a5wGZ6b6CI3BE2gkLXy8m06/3UGojuTw7nSwFv9wa7rAItkUPOBjK2UBmhnrDd617+cq2tuwSCzepkGpshDvfR5qejBi2MBg0tlE/IVFRRIBhjylOjHWQoeid/xpRhWp/16H2o2Hk0va91jwloIPOVDa4qG/JHm7xRtzt/pdlflKhbPQAZcFbWsAA6+xFmyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(2906002)(53546011)(186003)(316002)(426003)(26005)(5660300002)(38100700002)(66556008)(2616005)(6916009)(66476007)(33656002)(66946007)(54906003)(8676002)(8936002)(86362001)(478600001)(83380400001)(36756003)(7416002)(9746002)(4326008)(9786002)(1076003)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/WlIVQkj8fVHwy3VWIW2Kw4Zo33nylroz6g5TiaWctLVLek0YeM2SGeSaoc0?=
 =?us-ascii?Q?pAONsZFTQp83aEPMKxab0St2/eIuXL2keqH0crr4fG+NVCXw+XEPlzrswB6H?=
 =?us-ascii?Q?tf610Hua73ysbGcQGxH3cuo4HTzyfsp1p2fime5lY+O+K7EKt3lJqwUDjruA?=
 =?us-ascii?Q?ArZglkKT3RI3HUUwQcvI0+/qcvl6NT+s2ly3R6U6PKfTSESH2aS4AAlMBxVj?=
 =?us-ascii?Q?KsBS0wTWltV9iHx5iBKJuPy+x3XuCAeZ4/V32bazQ6MI3d3yvollwXiYSekQ?=
 =?us-ascii?Q?WYB4vaqqyjxe2aTbV9BrM+U0OF1aqetoyK/cVT7qvTNqOCrRXqV6NmKQae0Z?=
 =?us-ascii?Q?A65itbLsGLYoiDZc1zO/o75APNEM6cKOSFLJY4W9KA2pHCwlRSum7KiJIWSO?=
 =?us-ascii?Q?WT3H3fVNAgM4p7HiQYwmao3Zx9Nq9z/u5qscfEq2entfuPfkFZMc228gOlra?=
 =?us-ascii?Q?7YewaGJN1QPbFwlrg/62Wf6Jemlr2GzOxQOgF+k+0apJr7L3uDDnWc0xrlZf?=
 =?us-ascii?Q?7PjrzwqlG1lK/zk9Tyz29mThLIXyoFGDQy8NxtNN/E6aa18vjNdYVRJuPMzg?=
 =?us-ascii?Q?SBkbaF57gXymT2aSa9YH6VlyuHfcn6ByD8zaU2Ss/lJb4IR/S0B/EkGGMSVB?=
 =?us-ascii?Q?X/v7JzZt2pgp3K9wtkk5cF/va+FuJuLDPGSFMZz5PqFucFHM8p94H5KkKScc?=
 =?us-ascii?Q?hfxJLOfxG1JXn0nqVMRvA+9FAV6BzMshKlONqXeistT+7JnbmQV821pjZKJ/?=
 =?us-ascii?Q?kkRcOw06nYOuZKrhDjVeo36MLPTszZxhuerOUVBMvApRSfqntnWmuteKzttn?=
 =?us-ascii?Q?0bJBBECYvzDAvEsQuxyM5gw+PSIMIStd5AeKuwONAl0h/HqDbMXp7tiW7aPI?=
 =?us-ascii?Q?epNBxGDKaqFx+aemifBiJifF2kwvuCSck9sTr1hFmjTaXGPomZS8QXLyhl0n?=
 =?us-ascii?Q?l7RjVEUmpohzxnmPGYcJ2hix+WnV8ziHE9m2o5CqI99BddrN24OXN0BpnDV2?=
 =?us-ascii?Q?7FrHcxljWgDZc9ubd3mZYSA5MKp3SEjx6xIi3vx1nOwgR6Hefuz2ETlGc+Mm?=
 =?us-ascii?Q?jCHcfBmAr4LW5BRLnKQxfRV8Fd9//vPVo5Rapthxfru0IUtLhoZ+dDDXd9QD?=
 =?us-ascii?Q?cdmq6w2ykSlUh0TQJdFCYmgUKHuWuzIOS+FkwDi2Yzd2tN0wkpDNu/+OtVqx?=
 =?us-ascii?Q?bTcyc8i7Q7oxpF0HUpSTGxIkUPXmjqZaCNBHwmeBNUwksFl4B21HQmq79435?=
 =?us-ascii?Q?mIhaSCrdX8pA0Zg67xiUCwOyCa/ax+1TiocvBKzmXstkCUFAFY0W6uQ80pHs?=
 =?us-ascii?Q?lIlg/4JQ9eFJ1WwubXmCjfGc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285d7757-0392-4b8b-f760-08d9261d7cc5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 23:23:54.0952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDt/LmJf8p5SUBDqsu6j+oodrYpsD/LSd2jhvxVPYstiX86d9Ya0yepSR8cjpOD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Wed, Jun 02, 2021 at 12:01:57PM +0800, Lu Baolu wrote:
> On 6/2/21 1:26 AM, Jason Gunthorpe wrote:
> > On Tue, Jun 01, 2021 at 07:09:21PM +0800, Lu Baolu wrote:
> > 
> > > This version only covers 1) and 4). Do you think we need to support 2),
> > > 3) and beyond?
> > 
> > Yes aboslutely. The API should be flexable enough to specify the
> > creation of all future page table formats we'd want to have and all HW
> > specific details on those formats.
> 
> OK, stay in the same line.
> 
> > > If so, it seems that we need some in-kernel helpers and uAPIs to
> > > support pre-installing a page table to IOASID.
> > 
> > Not sure what this means..
> 
> Sorry that I didn't make this clear.
> 
> Let me bring back the page table types in my eyes.
> 
>  1) IOMMU format page table (a.k.a. iommu_domain)
>  2) user application CPU page table (SVA for example)
>  3) KVM EPT (future option)
>  4) VM guest managed page table (nesting mode)
> 
> Each type of page table should be able to be associated with its IOASID.
> We have BIND protocol for 4); We explicitly allocate an iommu_domain for
> 1). But we don't have a clear definition for 2) 3) and others. I think
> it's necessary to clearly define a time point and kAPI name between
> IOASID_ALLOC and IOASID_ATTACH, so that other modules have the
> opportunity to associate their page table with the allocated IOASID
> before attaching the page table to the real IOMMU hardware.

In my mind these are all actions of creation..

#1 is ALLOC_IOASID 'to be compatible with thes devices attached to
   this FD'
#2 is ALLOC_IOASID_SVA
#3 is some ALLOC_IOASID_KVM (and maybe the kvm fd has to issue this ioctl)
#4 is ALLOC_IOASID_USER_PAGE_TABLE w/ user VA address or
      ALLOC_IOASID_NESTED_PAGE_TABLE w/ IOVA address

Each allocation should have a set of operations that are allows
map/unmap is only legal on #1. invalidate is only legal on #4, etc.

How you want to split this up in the ioctl interface is a more
interesting question. I generally like more calls than giant unwieldly
multiplexer structs, but some things are naturally flags and optional
modifications of a single ioctl.

In any event they should have a similar naming 'ALLOC_IOASID_XXX' and
then a single 'DESTROY_IOASID' that works on all of them.

> I/O page fault handling is similar. The provider of the page table
> should take the responsibility to handle the possible page faults.

For the faultable types, yes #3 and #4 should hook in the fault
handler and deal with it.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
