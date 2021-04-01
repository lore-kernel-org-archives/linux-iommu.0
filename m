Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C34CC433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 12:12:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC63061006
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 12:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC63061006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9669F60BB6;
	Thu,  1 Apr 2021 12:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GT8X-Rj4YwxL; Thu,  1 Apr 2021 12:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AF83605AA;
	Thu,  1 Apr 2021 12:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53587C000C;
	Thu,  1 Apr 2021 12:12:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BAB3C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14E3A60B9E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9WHfuqpd2wiq for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 12:12:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B839C605AA
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 12:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvDs3QXa8a1zoydwkor8odOczssULk0libcFWSZ2godi9B0qaT+dk8MyoWvZwYL2KAO0PrfaGOWEepG4jQ923F3GVDiU4vWGP8ju/dnTwkYeYUt1Vly86A2L4eWQIoceVF9BvTV73+3OUTj6oBwy6fjyyfLf3n9DC55Z6UNULuuibPNFi3ipaYJWQbyCUsawHWHdcj29WZTS9FCMKl+Piq1tZqWSBHha9v+lqrcKYFgqF+JWW2b2tPjfzvy4FWYLIgAB1jzq5AVWKdXlLI2Vi4LyTiVKlBsc2BgBhzxIs1vOJCXgyb5PfaZ6miPoC4sfpa/sCeER7DriBsrTUMgKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SxDW66bzJySId9P/AAnAjijo99XEGeaWorQyE7VnhE=;
 b=FsDUkcFQhR6AZaysM03mXAP9kKrMsMsz/8OKbdtCGlo9M1WSmpPCwqt6zwxyVSrYQ+gNWiCK3jEkm+d9c9MdkVqTZVWAFypx9fAutCCxO2hPqC2/RVHOXTEW4IA6PNakVPB+VPHLj3ax0Xuc2clfu7nbK4k81Q6E9bwZtahI7igZOmvoA1xFDGIWH39cxbQEm31OvpwALzaMgd3tzSruEG/wsbn3oxj7P9ezfpLBUMpw7REWsOxb+FO0bY4+Dx47VYBZ/sp1uF2zDu3G6c8PAd75p+Fatflp3gYWVdFpfNrE6JCnJLOfZBqVNTbNapowOaEpS8GsoArW0AorBzQdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SxDW66bzJySId9P/AAnAjijo99XEGeaWorQyE7VnhE=;
 b=ovKIIBBWR753aRzH9COKDHr4d771vCi+CfgK6ryiK9xRjit9rFnvntefNPw8oI8TSWtWGysQUhIBNx7MbeBSW3Ba3/xeDK0ICPL0OKeIihRVHiThxwSGPUJCMYMho/5t64Pm697aIxSKb3nhBIG1NUXEtYD9mGNk0AOgtHQOXnt8iYa0MjxkKbwqq5bXZg2Xqn7uZVPzp7+7hkJ8Y0p2L7tGPR4p80gmZoLCsFY5etwC/lrp63BjkHvhOJTUAbrz58Xn8pJCcnG70ACtUEG5+Wf561cx1DvNEjUwa01MsLR7nqW9+uJxNNSMOdCJ2EQ1w3klbOnrA4GNJoLgSr5mWw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Thu, 1 Apr 2021 12:12:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 12:12:41 +0000
Date: Thu, 1 Apr 2021 09:12:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401121239.GB1463678@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
Content-Disposition: inline
In-Reply-To: <YGW27KFt9eQB9X2z@myrica>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:91::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:91::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 12:12:40 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lRwBj-006jUr-Ks; Thu, 01 Apr 2021 09:12:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fa07cc1-34b0-4a1e-f53a-08d8f5077294
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15168BB5999819A6AC97B6D4C27B9@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3acGTIX8GUl4aNPtUDmPGRLa6jnLoqEpj92ltOQh4PDukxBXT/EjHrtLWNa0mcBwut+SsENQcQ2DpcSF+xJ0IaZqfe0jnuWqBWRka4++G/qe8CywxslLZ6PGB7jVH4zZzLngAK2bTwVECaSbiSDdFEIjxZBisU3rH02kGsUH3MCyTPwZpBnguEHNFOJCNkKIkiwvcRE/EHEnnq70PgmwXbTOjvU9FzWJ2bhdXAr/X7TVFGAfp9zPr/cIHYnaJ3QQeMRoKSRiHxTedtm8Td+o4RiX/8WXuKRUmMDtvWVYbta0ad7iHPS6bT44oPeEtZCdr6wx19ML8rIAIRDdMKe5UsmI2WKKvjRFUclC9OmQGgT1QPHAS/FwcU+9ovDI7EQlAGeMSqdpz3RDOOdGPOmGotFWtdIuHQXDFd0Ys6NXFaIltoYq0heJaLi3SrqNQzSlVIyR6SxhaiCmTxLS60lVzdElXMhQncH/lvPCmIIrzJybaZ1ZC8C4bXoq9vfzMi3sbcWQkddJc+22qluIkcEIL+GanIYZ8t+zVMo6vUKBQ0t4IiafzLTh/HP94ALUV/cYg3bPeJvbHVgU/MfJbi7Yr3rvmJztYs9RFuV0/oKqNGgfkqiAB6QsgOlLmAM6mM91JvRPuElmU6TLXoIatiD+mjk6t8Hlw0CfeOa/VyfjCe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(8676002)(9786002)(5660300002)(4326008)(2616005)(66476007)(8936002)(83380400001)(38100700001)(2906002)(66556008)(26005)(6916009)(1076003)(9746002)(66946007)(316002)(54906003)(86362001)(7416002)(186003)(33656002)(36756003)(478600001)(426003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NencFyqbGIkYxdLCDFv9iUpsfgYd1CZEtGK60bWpDo+YASf/CtjAh68C//rV?=
 =?us-ascii?Q?ePaCA1G9x9dP6Gdbd4bh9Y2EEgsrT2lBdxdpqDl0wc5QXcD98rJ0/vFnChKW?=
 =?us-ascii?Q?LDaZfG0UO1kmTlqlKNsBiDEKm8OfycmOD2BFSiFSmO++sG+3CwcBcveO3+gk?=
 =?us-ascii?Q?BT0phGjBfVtmyK2+qdjFrOL5jCKShMxLrOX18tbiP8Wc9Rx/4dNUwtrTMnjA?=
 =?us-ascii?Q?efu0r+u3nBFoZmEAMHV0ZiWJ8twziLUF+/to5N1ko2pGdEcjUVMdFDVti6gU?=
 =?us-ascii?Q?eLBDtn4v7UaM4Qgwh2SuyDsLGfFJ4amVZqRjdJgCv/vIBeX+Lz25r9Z+XKgF?=
 =?us-ascii?Q?4HUIcTrHOYwvVfRVyqMmPNhK1kjEuP41xVXzqsvjEiQng9qtH4A7JfwY/Eja?=
 =?us-ascii?Q?VQ3Sds+YAcagAeUBNbPXf6dfGACVdU03xlj4V8CslgBTIEooRhAycDUCGDQ5?=
 =?us-ascii?Q?AyBuzotAoE8v6nSHnN2cNRUahC2cUTmKYvQp3vraki3sq4XWhRM64eyJeMhY?=
 =?us-ascii?Q?ImXGzSm10kDy1aDGOkDb2qLSEUXk9oZuRoCf/27E+IT4Wokfmo1OXryMT7GZ?=
 =?us-ascii?Q?SVCAFyNVzg0VWvBck00vgB6RNHG2hh3eTwhjMXuY7T7pch+uO2RU+x/3TFJl?=
 =?us-ascii?Q?it9xXpmQ8+s5v5KNfhefsrlR2mk985OUCXKAkLiGVrXwVSpJ75wJETnF1JvT?=
 =?us-ascii?Q?YBSQN8KLaS7l3qQpB+iQz3bkifwrUD2SSADJ/RFH/SiAAgzom82D3XtzDLzw?=
 =?us-ascii?Q?fu1UU/oKVoS6S0eJYuU13TnNNJnqNxwaXuH5PZ+x7LATIpJXO2Vg2JUix0ga?=
 =?us-ascii?Q?gH8P1bNJESGXkhArMy3GagEZVM6En0HbFHTvTzak55bwzgNigtgffTkC7zWS?=
 =?us-ascii?Q?3sw2Fa8oUUkmwcljuzmG+xLbdvPIiyV0jHR21P2veO8NPQMgAEYKIgrHEwqb?=
 =?us-ascii?Q?lzEBDsD3rRoV3i+zjVKFWnLlIIvhsJXHu+3B0vh4vPZOAMCAxrQw1woCHNXV?=
 =?us-ascii?Q?997jcDFbAe+yZG+H+sm6wQqPoqmGpockkm30Oc43dgagzm51IUpB3C1qB165?=
 =?us-ascii?Q?vt+fBV3d0H2dv9t7g6UB+JreKDOTkFvvilJ2BMsnkJXW54FrN25XYLJzg561?=
 =?us-ascii?Q?ndwoiZfu1KD5gD82SvtuJe8qGNHZOoitb0iq/OJhSSWaCS3kiDB69xy6JcTu?=
 =?us-ascii?Q?sL3cS5ovnkgtAxcid0yHVAjBunkUy0JDjNYZzh1E3Biey8QK3pudtH3PpKYe?=
 =?us-ascii?Q?o3d8OsXghpYIrKDdMFxVMWPDNhbLcfUs/XxpSXGKszK5ZvRIngUHr5ozb8LN?=
 =?us-ascii?Q?hJrs/cZF7QWrmBhbd7cJE3O28VGMma4IuwTGc53QOm+kZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa07cc1-34b0-4a1e-f53a-08d8f5077294
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 12:12:41.0265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaIdcim7hrhO/Ib2vAEKMOG64SWisq5pHEyHD18CQjYJwoJKevs+3+jLo7eY7bRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On Thu, Apr 01, 2021 at 02:05:00PM +0200, Jean-Philippe Brucker wrote:
> On Thu, Apr 01, 2021 at 07:04:01AM +0000, Liu, Yi L wrote:
> > > - how about AMD and ARM's vSVA support? Their PASID allocation and page
> > > table
> > >   happens within guest. They only need to bind the guest PASID table to
> > > host.
> 
> In this case each VM has its own IOASID space, and the host IOASID
> allocator doesn't participate. Plus this only makes sense when assigning a
> whole VF to a guest, and VFIO is the tool for this. So I wouldn't shoehorn
> those ops into /dev/ioasid, though we do need a transport for invalidate
> commands.

How does security work? Devices still have to be authorized to use the
PASID and this approach seems like it completely excludes mdev/vdpa
from ever using a PASID, and those are the most logical users.

> > >   Above model seems unable to fit them. (Jean, Eric, Jacob please feel free
> > >   to correct me)
> > > - this per-ioasid SVA operations is not aligned with the native SVA usage
> > >   model. Native SVA bind is per-device.
> 
> Bare-metal SVA doesn't need /dev/ioasid either. 

It depends what you are doing. /dev/ioasid would provide fine grained
control over the memory mapping. It is not strict SVA, but I can see
applications where using a GPU with a pre-configured optimized mapping
could be interesting.

> A program uses a device handle to either ask whether SVA is enabled,
> or to enable it explicitly.  With or without /dev/ioasid, that step
> is required. OpenCL uses the first method - automatically enable
> "fine-grain system SVM" if available, and provide a flag to
> userspace.

SVA can be done with ioasid, we can decide if it makes sense to have
shortcuts in every driver

> So userspace does not need to know about PASID. It's only one method for
> doing SVA (some GPUs are context-switching page tables instead).

Sure, there are lots of approaches. Here we are only talking about
PASID enablement. PASID has more options.
 
> * Page faults, page response. From and to devices, and don't necessarily
>   have a PASID. But needed by vdpa as well, so that's also going through
>   /dev/ioasid?

Only real PASID's should use this interface. All the not-PASID stuff
is on its own.

VPDA should accept a PASID from here and configure&authorize the real
HW to attach the PASID to all DMA's connected to the virtio queues.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
