Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66027C433ED
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 17:24:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7726113D
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 17:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7726113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 836B840324;
	Tue, 27 Apr 2021 17:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5E6oRf6d_4Fq; Tue, 27 Apr 2021 17:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B27F540318;
	Tue, 27 Apr 2021 17:24:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81994C0019;
	Tue, 27 Apr 2021 17:24:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7A1C000A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 17:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE888403CD
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 17:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N07rlWf9BlY7 for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 17:24:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::615])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F23BD403BB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 17:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5gs4OghKz9b/pDqR8XJxZMa4clFL3tvghNqQWWfYxcOd2fuecUNjxT7vCM6NnyJuQ5pBJPEGo3lIoibxvxEwWFVpQlsYfPQmeO0sukE/DANmqUhdDNxHKEacZP/wOGrJmBMRBDsg7drsrbz9o8ynNOnbb8wxgvW37enHceCKmTpV4oXCy1mQzl7yZJMIKyYB5JbJCjin84zMqWhnxHFPb9AJVQzZGziALszks3Za3L7FfAioiSszQAsAq+07ui+v/ztwbk2o7b14qr0kd8oFx6gECnOfKWYwE9xHbpEB+5pPQ8BQUCQscdaxQqV1Nw4t/9Zw6s8pmsqsdTpyXmA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPaU/gpgmZzFAGpL9QsBTvaL85w1xdy8IEqqRSYM6j8=;
 b=WSK5DLSU+/jgHRLy5hX2Ft0yBeIKD2CU0U+pUsRdpK4KLxLx8kOMPntwmkh8WbgKc0GJjWTx1hYmMMYvKFYvY9MB9vOwW5BYu9kwj3pg3UAY7rKmsS4NzhCbDj9WXY1gQvY3og+nKRfbZ6mxxJlNrtfYXvdkvsuiHG5LbdstNz7dLeAV/e6KMOU2LNaxNTffgfAhsaw29JRlR2bwyHC6rRlaD4T6TwEzZx7wVkDZ880vWvwAqyVJ2YwWrFMgb0xeZuwgnaI9oCzk1xwwOJbjYsCFdfSZWm5WMqlDtnFBMR3jmWtylEPFdM45tJUCxBxk0hg0BAPgiGwPJe2cT99V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPaU/gpgmZzFAGpL9QsBTvaL85w1xdy8IEqqRSYM6j8=;
 b=LunouMo1pzQL2MTKE5ZycHEfdkmgY0GM8+259xkP/6k0J4m0FUnw3h+uJTpontZFwmGIQioCTlgMlj9pYUj57+bRsm5mqjZhUS1Kk2EoqkDQepcVUcogzD1cuRuxyIYvL3iCCLrfZrvsjCnXdDlBEv/lnS1BTNR0s0nZIXUhfgId/BvHP77dPvf7rojLs3RgDKqE/XaWdA3K/1Mn6RlwTHQ9GJOIkT21Yd5IFqyD2bvYETj8peyHjz6R5Q4XfG89EvzO0t3+UcPDKLsS8DPigBCz686H2mYOJ3T3neyysRpS+E4tEJIX4b2WDNvUDPm5PemzuBXZssNsepbdOpHoLw==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 17:24:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 17:24:33 +0000
Date: Tue, 27 Apr 2021 14:24:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210427172432.GE1370958@nvidia.com>
References: <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
Content-Disposition: inline
In-Reply-To: <YIeYJZOdgMN/orl0@yekko.fritz.box>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:610:4e::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:4e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25 via Frontend Transport; Tue, 27 Apr 2021 17:24:33 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lbRRo-00DaBI-3J; Tue, 27 Apr 2021 14:24:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be1d354d-6995-42f8-fdbe-08d909a152d2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0204CA058C9BD0A0FB35AA73C2419@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+d8mDSberz+e+JVcecNXFUAv9CPMYewJA1ftXZYBaa0u6qkmS21WvPeYkj5tYYTsqsYEwZi3S71tbxtb6RexJVZ+qwoxiyKEkaHVyvCCbU1FKCN7ag8RHZOk1oE6hxFeGvsV26wxWsLgedD1DOMROqa+7Y8M+/sQdxtxp+MYtcrL8vg78A+m3YrnNvnaia3ww1ugovxHpjTIDsQaCEBwJvjq80AQCC1lFZuBPCm0f41vMmQXOUj4Fg6PSpgMI3y0uewvur7QXjIW/dABQVGeGm7Zi36e37JBEvBmU2dgtICYSjfhhdgL4LqcIyuJlhnX5AIwaOCCmWxkumqR6HKtKXKBTGik5Ue+0fjpWpMfQDbUHIZLcVIAjR4f7LctK8tlQ/728NCKCFeNefrisD/03NQdcCn7navB+Ofcg7ztFLEGEUUpc4xD14RYB2z/M2V2Rkqg99Ha8OBdtRMb0LFK3WJaiNpRF1dnTgRmvj1UW/G2MqLw9kHQarJtkvv+oppJoLWE8WbieXBkbJw7h2BZ321jxaDeWZK1NeQ3Zf8ZK9KsbVKAbyXxgUpzPsyGShZnLPc7HSC/kCI7EoF+6szncI22owCMO9kX2npzNcrV0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(186003)(316002)(1076003)(33656002)(9746002)(5660300002)(2616005)(2906002)(9786002)(478600001)(66946007)(86362001)(26005)(38100700002)(7416002)(83380400001)(8676002)(54906003)(426003)(8936002)(66556008)(6916009)(66476007)(36756003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XO840h0DzJ9S14IwkTj6OEz9HhbHAstOVshwYTiZ8edIBSX+wTfFy1yfhM39?=
 =?us-ascii?Q?ZIhAphn+IBaFBGcqrGEhyFDMXJmJlL73wbcdrAAM8FTWU3OfUyMERrCP5S/Q?=
 =?us-ascii?Q?U+3fAnK6eA0/1oPXw0OIzJ+SWD1mrjU9c+YY0SMAmYYOexu/7y3C+yKR8nD6?=
 =?us-ascii?Q?hgJlQHDg9FQ2s3/Zc3jJClMn8Te4Aqq7GdErFdqXEPchVwuXBLRscZzGnupa?=
 =?us-ascii?Q?rNb7l7cV9bO53Yq7vnG3O2Q/D7df7IAsxM3IR1h6aR8uutkipo7lu8DJtl/j?=
 =?us-ascii?Q?Rh0uZXn+QoHfv39LAhf5W4lVUtjPvQgdjBNOQA0EfWhIMXqdZvQEJHC8gc8N?=
 =?us-ascii?Q?7U8OOx2U4tkUQv55GAoAclalbt1ZB6vVzkW7qLy18WAS4ReynWJEae5wBKfU?=
 =?us-ascii?Q?cjodmmfo5XMEKxRIcVFNdP14jeX6ozNzBFLxiXJvnDiFC7LWDeX1OAQx4Zyk?=
 =?us-ascii?Q?WiO46zM9ZiFAQiDw/CfEk39nikNiJ+KkX4PDzekbhc0gFQPFXd8U1ZCbXjs3?=
 =?us-ascii?Q?juDwxnjQ78awQovVOmdKrVnoxcSaU5QOrPQ5YyKqhC3TKwShCi6eEfCREf1d?=
 =?us-ascii?Q?N4CnwPeyxf8gySc5xGmzzYSnVpbQgrs3G83mFV2vImX6laNcxI/P7tubPcLQ?=
 =?us-ascii?Q?VmsfkPBr08r8u5aFdZ7ctEyPX0MGNA7Y/1UtMFehZRDcSbFM0O9/kYn6YksQ?=
 =?us-ascii?Q?GNm9ExTd4ZRiqMBfdi5Zet1NbzgfP14I5IQaK+VXBxPrWKvtaQmlsp4bg1oq?=
 =?us-ascii?Q?Lgh7m3Qk7lSzdF/5YMsmXWZ3HWBOZ47GRfniPFGYQ0Cav0lpWsPjJAtt3Jwb?=
 =?us-ascii?Q?2OHMtkj54hctR3Iu31tNG/nma7ycZM1RlmWP+JBebP6x2C2OTqP2SejTtYdu?=
 =?us-ascii?Q?6tNQu2KMjwoxvhka8/48yAYnlDdALw29OQtviBRzcGC3eNqhc0GJfAVbbcwm?=
 =?us-ascii?Q?+AEHSVgSf5Uf9qgH5TQMGqJIRp2P7oBLxF+ec5UeJgkNwdik/D/X9gOFCmLM?=
 =?us-ascii?Q?71SyZdNPaJT+eZXNRcxwBK+YTxNY5LtoCMYrBaBFNE3mGRoFqTetqnK+TS+P?=
 =?us-ascii?Q?ymDAI95MoOJ/QonGKeVzyP6aEPlYHVnkGteMRVdNf1vngKXHRcvWVpW1jqx7?=
 =?us-ascii?Q?GEQlT1jQMNDAGmh8/8AduZLJ5ZyHsq051pkIJlCorZPmbv7dfaitb7sNcG2n?=
 =?us-ascii?Q?6jPMMyJPquaSL0VefvVj+b0QUPiccGBO83FmuO9ycBZlKMEISWkhCm46Ij6Z?=
 =?us-ascii?Q?SI7eRe0TmH/aBi0AEa8JZ11SEBAVjecIifJC7BuV/APbXVf4WGyfMo03hjjX?=
 =?us-ascii?Q?PuDrXLFp+Lb4XH4FsvIsmzmF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1d354d-6995-42f8-fdbe-08d909a152d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 17:24:33.6498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOQc4XJzH5uFjaH7Bpc92D3HfyzIV4onGoX7m/8687OGVjmBaPj4eim2IX3mn0Fw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
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

On Tue, Apr 27, 2021 at 02:50:45PM +1000, David Gibson wrote:

> > > I say this because the SPAPR looks quite a lot like PASID when it has
> > > APIs for allocating multiple tables and other things. I would be
> > > interested to hear someone from IBM talk about what it is doing and
> > > how it doesn't fit into today's IOMMU API.
> 
> Hm.  I don't think it's really like PASID.  Just like Type1, the TCE
> backend represents a single DMA address space which all devices in the
> container will see at all times.  The difference is that there can be
> multiple (well, 2) "windows" of valid IOVAs within that address space.
> Each window can have a different TCE (page table) layout.  For kernel
> drivers, a smallish translated window at IOVA 0 is used for 32-bit
> devices, and a large direct mapped (no page table) window is created
> at a high IOVA for better performance with 64-bit DMA capable devices.
>
> With the VFIO backend we create (but don't populate) a similar
> smallish 32-bit window, userspace can create its own secondary window
> if it likes, though obvious for userspace use there will always be a
> page table.  Userspace can choose the total size (but not address),
> page size and to an extent the page table format of the created
> window.  Note that the TCE page table format is *not* the same as the
> POWER CPU core's page table format.  Userspace can also remove the
> default small window and create its own.

So what do you need from the generic API? I'd suggest if userspace
passes in the required IOVA range it would benefit all the IOMMU
drivers to setup properly sized page tables and PPC could use that to
drive a single window. I notice this is all DPDK did to support TCE.

> The second wrinkle is pre-registration.  That lets userspace register
> certain userspace VA ranges (*not* IOVA ranges) as being the only ones
> allowed to be mapped into the IOMMU.  This is a performance
> optimization, because on pre-registration we also pre-account memory
> that will be effectively locked by DMA mappings, rather than doing it
> at DMA map and unmap time.

This feels like nesting IOASIDs to me, much like a vPASID.

The pre-registered VA range would be the root of the tree and the
vIOMMU created ones would be children of the tree. This could allow
the map operations of the child to refer to already prepped physical
memory held in the root IOASID avoiding the GUP/etc cost.

Seems fairly genericish, though I'm not sure about the kvm linkage..

> I like the idea of a common DMA/IOMMU handling system across
> platforms.  However in order to be efficiently usable for POWER it
> will need to include multiple windows, allowing the user to change
> those windows and something like pre-registration to amortize
> accounting costs for heavy vIOMMU load.

I have a feeling /dev/ioasid is going to end up with some HW specific
escape hatch to create some HW specific IOASID types and operate on
them in a HW specific way.

However, what I would like to see is that something simple like DPDK
can have a single implementation - POWER should implement the standard
operations and map them to something that will work for it.

As an ideal, only things like the HW specific qemu vIOMMU driver
should be reaching for all the special stuff.

In this way the kernel IOMMU driver and the qemu user vIOMMU driver
would form something of a classical split user/kernel driver pattern.

Jason

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
