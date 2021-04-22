Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADFC433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 23:40:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FA76121E
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 23:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FA76121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 377D3405E3;
	Thu, 22 Apr 2021 23:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cTUrlqJo6tDL; Thu, 22 Apr 2021 23:39:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D028405D5;
	Thu, 22 Apr 2021 23:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C224BC000E;
	Thu, 22 Apr 2021 23:39:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCEBC000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 23:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18AF360DAE
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 23:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8Dua6PqWZB4 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 23:39:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B956060D9A
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 23:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnEHmTef0Kz1cIwynRZKQk9F4zz4P+Y7fBbgcP+p1777hjrQiR4x+BNrHeJ/jnn1oXO0uVV/sCxXxLZtwLgBy2KgGH4qmEHazWIhLjGpvFAxUQLZN8QI6Z56KE22D34EjibA4KcAOUwlU/F3MGhfvV9qhTUkWy18Y2UXIMLQqTBDAnYz9Li6tlQTx2nDDOwPvoNKqvJIlH+rfQbajc6wnJ3ExA4Q8A8oUWtBbIO3vk7QRqPolE3TitvHCR6HryTOxXup16QOLG5LnFy3sFt+r5jyTg3kGoQ7HN5GEXdKy23D15lwnhpHYuj6gT9Q19umYla0EbeUZojDYxihvzrVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB5Kt4p6bg0a+d63wgL5lVG55BdNhOWkIwQ+H4WNsMc=;
 b=nc2C6UcPMxp7loA84tB/M2Ks/vnNvdgRJnDfu0OkX5fPii0o5XbBsHEBz22M6C2tOPs35J/1XPzuKFP+q6SYEuTKlC0gABYczC3TAC3kX8jX0SKRo9L8dwr7oFchgRwbCCT5STgv43Tf/Lc/rSK0z/q6BHUzcQbR4GqjK3A4mAztlJfvh4kuvOfQqUlp0ebHJJswqAMqRfxyw7CeRTH87J7lrVDC0YoCrFLGM6oLozkXjfd7Cfgml6kypcUGnDzB6z89Mslc02ca5JS1/HdR02mbN0eJgmJncEpmRgEbkkPq38fyiNImMtsxbiBopIhoeLhVQVRnCNgj8rUGsgZjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB5Kt4p6bg0a+d63wgL5lVG55BdNhOWkIwQ+H4WNsMc=;
 b=XWklfpTHcLlF5BwnQvIeisNAt6eEt/JQ45aP+xXb/JuyJalCHbbXTS0pFS4J+6BGaXtcO5BMIyiEpAoKDTeF9ft6cNRE9DpdsZxuvXg+ValLaJxLIy/kDrsure+AlK5tVg+NcTCZptlpL/L9919IhhqKltmTbu0Yzz8yiB5Rlx0WqDXmVoo3rWoCxmKELUH4dpJtS5/1AkuzneHla2Cg/qlqoh6zcXJ/hcwW1BVkP2RsFDcYSvtIKWqGmblluOSSvQ9NKc0xzgv3s3gzgkCaRlcBUQWE5KmpKM4qXXh6UzFRwo5nOO6/IG8Lp8MXI1OQQ/u1bmq6QB7oH13i7lqUBg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 23:39:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 23:39:52 +0000
Date: Thu, 22 Apr 2021 20:39:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422233950.GD1370958@nvidia.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210422163808.2d173225@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0360.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1PR13CA0360.namprd13.prod.outlook.com (2603:10b6:208:2c6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend
 Transport; Thu, 22 Apr 2021 23:39:52 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lZivG-00ANLN-Ub; Thu, 22 Apr 2021 20:39:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03d5e57-cf1e-4aa4-e1c1-08d905e7ed24
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491F3E8D270BA736F057E32C2469@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVQazVw30qCPBkmAAvsINJdKkVfUDFl64alS05LCLRblcs831Mjj4vJkiL5iq56Nv0eSFN5dz2fBsd5kjsrQPm05WIvXzSeRJvSHHzdWmUaD+BFcyMvHCLc3ZfXchX7xzsdkt2MyZnwR3/K2ZPBX3rCoB3Ilp/0zDRTLkSepIPQxdsQurYGofLTyNYVFu2UqIvm97jnEy2LQTIb8xjGtNpgDBPjQmyBUPRQzg2r6HOUlLAGo7ef0fhZcmgDP6/5F0Yw1vl77IZXV5gfbMO+WRY2+GPy/oStDcCUIw4vnL+sgOjUxJmOCJ+FalLxIQJwB6mC0CxSJuahrJGaZoqqqveR31UVbN/zmBdMNBDHSr5Vv8fhxxG9on8r9zHmgD3b/mg2f1xco+4O0I3PzJ/7fe/0gg6f8Ch7AtMfT3zzSiZ0mBaDIvJUln63vz8x/wZTxp641dvYMmSf+bEZI+RQOaaQAMS8mh9izHgyNl2r6CVeZhhgkHRni3C1l3KWfn9Z4FG00wSZTkIaxG8wyWmaiQQShXx5MwJacGc9U3180zhwM7x4R7EXfZtXvgXFzUN1jQMpx1u9Q+zB+sMJAo3DEHOSTNNSbTxqqKeuNAgB1zGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(2906002)(8936002)(86362001)(2616005)(33656002)(9786002)(36756003)(66476007)(9746002)(66946007)(38100700002)(26005)(8676002)(6916009)(426003)(1076003)(186003)(66556008)(4326008)(5660300002)(478600001)(7416002)(54906003)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PXkvCR7GU7rll3TBpWVS8tml7C+2xuOMZeap8Q7hJ/ubq/KMxXlfutUzrKNh?=
 =?us-ascii?Q?H7T6ZSl7Ui8yk/r+ozEzX5N9qRZXHQLYORLEca82sineZZPkfKUs8Ps/rG2Y?=
 =?us-ascii?Q?z+moBm0LOvMr36ShEI+etdu581bL4VaoPu9lLQuLUp+xvpVQ7xuNVF4qPseI?=
 =?us-ascii?Q?ZT6uzAevPLZce1PQargaj+VmgvlINpWmTm7Xbfv/GSXeYmfoKuN/G2Yeh4k+?=
 =?us-ascii?Q?OgDYIFhePBPXdai+HoBoaVRNg6XY6uBO4mLa+YbyFdVrxCVQsIPfRC7MeKXR?=
 =?us-ascii?Q?//lZlHMdqTNX1mQlC1pHhY5bXHlwxRljcyyw4DueOLq/uv770I8cfZuEnKUE?=
 =?us-ascii?Q?1SfllZCa+/mxckHwJjl92/FA4nE0h8RH6R6SWzeyNLs7ee5idfizaR2I3zHC?=
 =?us-ascii?Q?U7AKE/dCGGrl1Hx33LmTL6KOU+nCsJIvDoC3pNFguJwICee8gCbkgWYlZ8Ck?=
 =?us-ascii?Q?6dy50UfA8gtP8VjM9RgevNCWRbrTSutyNrU5BohsXYFksNlqAYSbd1Lsganm?=
 =?us-ascii?Q?7Fdq7NcW619b/t1DRBWvv1DLeAPE3vcyXiCJCpQz73HE0kB6uXbnWG3Tixy1?=
 =?us-ascii?Q?iP3PmbU9Rn3+pz3LvXz8YzFvyw9KLKxKIRgPVYw/zEoq0bxmzfZkELg00HRJ?=
 =?us-ascii?Q?43uMbupeuN8IEBjcNqPIuayM9sEjQOUsT2bu4vDKQY3/KMmGtBoPaco9MxqR?=
 =?us-ascii?Q?NkuKqoX/7Er5gVacsp/sceJZRcJZLwYetQh1MSoeT24Z4BWQzOf+uUDfMZPg?=
 =?us-ascii?Q?kk0DbgsLpIxXvnIInqsooXFD4ImXhQopDgnRT/Tk8PRUfZaw10sTQ4ncL2XJ?=
 =?us-ascii?Q?gtmFU0OqRQf2zgi8WKZw1iaAVwuaULYudmkSe0gVV0pK3tIKgk0bXo2QnziJ?=
 =?us-ascii?Q?G7L1DVSsnuWAfF68gBygAz9qI+aJR/FpS/tfqdkQBhcz+MEggsIB5p9ygQEV?=
 =?us-ascii?Q?lyhEy//pmcrCmvfKBi1Ub+dEqexwrKMb8RLbhOmc+QIui9B/RiTRY0u+Q7UI?=
 =?us-ascii?Q?7sMMe1R95ODs1GNkBLLH5dohJNE5mdeJAMVguAqhr5MFMHBUET0vSn8j9G19?=
 =?us-ascii?Q?aoZkMoZgoEa7hNftu967FAjh1IxgmltbzedQ9e11Qoi0MsC/HCIxfyrqP4tO?=
 =?us-ascii?Q?hLqe6qhsl/oZwhjURz2r/m0vylb/GRSGYDBwZkRHiySseYVnuAA7oZDfKPA2?=
 =?us-ascii?Q?DJJ1Tqw0RMytuXC2NZ0vDqymB5WMXcsZjfTFSVYB88P2ntG8pl/jL1CTjTIf?=
 =?us-ascii?Q?JqYcR0etoP+XhR+Z4LF0ASU1wBmz8y5TriSsgPSRH3dkhHLDFEdYESdyXKjI?=
 =?us-ascii?Q?gxMUpMPdXXSukneDJVjR5STf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d5e57-cf1e-4aa4-e1c1-08d905e7ed24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 23:39:52.7425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMBCxL9PkEGUxeWiVigIwmpMbG7PNmoRk72iQbDWrMaSw8SH5EucLPBF4NWwlErD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>,
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

On Thu, Apr 22, 2021 at 04:38:08PM -0600, Alex Williamson wrote:

> Because it's fundamental to the isolation of the device?  What you're
> proposing doesn't get around the group issue, it just makes it implicit
> rather than explicit in the uapi.

I'm not even sure it makes it explicit or implicit, it just takes away
the FD.

There are four group IOCTLs, I see them mapping to /dev/ioasid follows:
 VFIO_GROUP_GET_STATUS - 
   + VFIO_GROUP_FLAGS_CONTAINER_SET is fairly redundant
   + VFIO_GROUP_FLAGS_VIABLE could be in a new sysfs under
     kernel/iomm_groups, or could be an IOCTL on /dev/ioasid
       IOASID_ALL_DEVICES_VIABLE

 VFIO_GROUP_SET_CONTAINER -
   + This happens implicitly when the device joins the IOASID
     so it gets moved to the vfio_device FD:
      ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)

 VFIO_GROUP_UNSET_CONTAINER -
   + Also moved to the vfio_device FD, opposite of JOIN_IOASID_FD

 VFIO_GROUP_GET_DEVICE_FD -
   + Replaced by opening /dev/vfio/deviceX
     Learn the deviceX which will be the cdev sysfs shows as:
      /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/vfio/deviceX/dev
    Open /dev/vfio/deviceX

> > How do we model the VFIO group security concept to something like
> > VDPA?
> 
> Is it really a "VFIO group security concept"?  We're reflecting the
> reality of the hardware, not all devices are fully isolated.  

Well, exactly.

/dev/ioasid should understand the group concept somehow, otherwise it
is incomplete and maybe even security broken.

So, how do I add groups to, say, VDPA in a way that makes sense? The
only answer I come to is broadly what I outlined here - make
/dev/ioasid do all the group operations, and do them when we enjoin
the VDPA device to the ioasid.

Once I have solved all the groups problems with the non-VFIO users,
then where does that leave VFIO? Why does VFIO need a group FD if
everyone else doesn't?

> IOMMU group.  This is the reality that any userspace driver needs to
> play in, it doesn't magically go away because we drop the group file
> descriptor.  

I'm not saying it does, I'm saying it makes the uAPI more regular and
easier to fit into /dev/ioasid without the group FD.

> It only makes the uapi more difficult to use correctly because
> userspace drivers need to go outside of the uapi to have any idea
> that this restriction exists.  

I don't think it makes any substantive difference one way or the
other.

With the group FD: the userspace has to read sysfs, find the list of
devices in the group, open the group fd, create device FDs for each
device using the name from sysfs.

Starting from a BDF the general pseudo code is
 group_path = readlink("/sys/bus/pci/devices/BDF/iommu_group")
 group_name = basename(group_path)
 group_fd = open("/dev/vfio/"+group_name)
 device_fd = ioctl(VFIO_GROUP_GET_DEVICE_FD, BDF);

Without the group FD: the userspace has to read sysfs, find the list
of devices in the group and then open the device-specific cdev (found
via sysfs) and link them to a /dev/ioasid FD.

Starting from a BDF the general pseudo code is:
 device_name = first_directory_of("/sys/bus/pci/devices/BDF/vfio/")
 device_fd = open("/dev/vfio/"+device_name)
 ioasidfd = open("/dev/ioasid")
 ioctl(device_fd, JOIN_IOASID_FD, ioasidfd)

These two routes can have identical outcomes and identical security
checks.

In both cases if userspace wants a list of BDFs in the same group as
the BDF it is interested in:
   readdir("/sys/bus/pci/devices/BDF/iommu_group/devices")

It seems like a very small difference to me.

I still don't see how the group restriction gets surfaced to the
application through the group FD. The applications I looked through
just treat the group FD as a step on their way to get the device_fd.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
