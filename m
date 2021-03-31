Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55246C433B4
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 12:38:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD4D61585
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 12:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD4D61585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 521F060AC8;
	Wed, 31 Mar 2021 12:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYv7F4mYTpyA; Wed, 31 Mar 2021 12:38:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23300607B0;
	Wed, 31 Mar 2021 12:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E77FEC000C;
	Wed, 31 Mar 2021 12:38:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC9DC000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 12:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C8F140E5A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 12:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id smAqB6oox9du for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 12:38:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD2244048E
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 12:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ85JlSnyT/ndxMqwykj8TW2auAyJaR2YHGNI+jrtP1EsoVLM+b7ybmrKPBlYZtg/QhKT9CyhuKcUzVFTIdfx5RMI8BkOTiLoSjVVCNQbhxACuxPoOiqPAb6igX5M32jTwY4bJ+h70ciDbGzAAbnJ6NAccDAK8M94ODqPpZAQESKp63q9xgzvTyiyNHETcMQhX6QHKb/9rm49ovIjdSPngXrk9xIDE8qvHS2WpYqgwmAlUAeu8CWvljST9vX8vUwbfxfQ9ao5ixypQ0DjlUfa+O8q410KK+lyVpJxYQRdWpJ5BEjUU5X4zm0D+wzL6FLszD2sgK6xdXQYfOuihBykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1qBHeqbqDUWGAnx/XsR6oQqvBRfPdQZlzErc5vGx/g=;
 b=UdUigHOVBgCd7wzG9RFsFUwH9kb8XmU4YG7tiP0Wz5cDnBTnZ8OgUzMNBCKDl9BsK6RPzVxPHBjk/520b6BG82o1U9cygA5VW7QdocuMROxDqGBYPg3yiq6/pjUtIcRm41VRqtwHZZP1nEEsXI1qGt0e2iyvWAdZ3W6WZv9CJH+YO5FxIJijthlDL+QN6dgkxAOS0LikI7RK5I01OgFkKP98nbCQqu7x0RY+kS/cIc9Yy82R/pXEFNLsZ2z7kX6whNOdpLA04sNPC4sDqQakK+XpBrXSB0ZEWzPMP4h9z8P+jvV+bMdjujocWTxWVEFLIH/d9BrVCXddB0ic3wU2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1qBHeqbqDUWGAnx/XsR6oQqvBRfPdQZlzErc5vGx/g=;
 b=EEixU/TW1BAfC4fPy8y/dFDD7KOs2wyTr1dSF2b1Q8mD0321Jx4F7LjCh56WCHSEGbdBpCKyWPUOAF6kfv4FiBBqkfftwrBEMb1U1HmLkT0uchXq2tNgQfqSJggscwASeCzHD/+FdhwX9ZPNMTRlrytrLbo5BNLYPzToRYo54DNphiWv2AYWSRH6fv2B4uS1CAJTzZClc182y+HMOvbLCwXF90Fb340OfKHsoRJciUa7uGXeQdgQ5U3Uo8mankXRUV1LRsZB3nDKidefINo0GZlCV2qKjoztyVuBmjTFLku7rAvBSldoDHdn663dy2T/mAWa+DjBQ2a517XwqSmXoA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 12:38:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 12:38:03 +0000
Date: Wed, 31 Mar 2021 09:38:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210331123801.GD1463678@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
 <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 12:38:03 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lRa6j-006KCM-My; Wed, 31 Mar 2021 09:38:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003266af-db2b-4af3-d25c-08d8f441d383
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3116D4539F8E81D9D6BE4274C27C9@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPGlD9BYYyxtdT1KRc/J5BlIFVBKuv9PWaA17CqRd6bIHhxaHQB+6K2j0ZtnmZfaapPNy8AfhZhA2hTezJZK/TqgWRSBPTjCz7IuFc4D3tTpPjXZNakU5bh1h1Z0Mx6ji+pkitXpfdDneleWqWAjc0Lpm8lkHxrwAncTDSGR2aMw7+JPfQI0RJ6dXPQMhEc7tnn7wBuRHZ00XSGOrG07doOPDD8gB2LYx1HbSDMqOdKWCTCs6UhR3cepJ9HZBPonqZWbVTZJJLgizokXChJ+2KaOHTCWR8g6AEdJN9t+LlGFXJQQvLbAOyW8D8m29Ad6v0yKcNeCzkOnScEHbyQtZpVhXZmrSQVLizcLyF0yFDslAieIuHYddI8gB0HhsEn1qKFu93TO5a7kG2jnQZxZjXDMHbrdN9H2AGU6kaTsFrPxR5mZwl+kT7fNZeVzZTKwddt+lcVVCll2kaOHOZfzPUTE5n3qh3leveVwg0GDbe4LQToKPrzzxPebA6MK5VSjgfxrUUsf/Gsehm4HvAUoYl+A2GqmSUkNftDBHs36czA7wSCh314cIZnbQCC3wde5BrgMxiavFYFij1rVbPVZxmrpqVPMlik5+0tpglpdqQUrTroLAuvITIYAiwnvnptmVGffvspk2pm63Cc0Nou5mIJ02u3kYBTz4TQVtNJPjgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(66476007)(66946007)(478600001)(66556008)(83380400001)(9786002)(6916009)(86362001)(186003)(2616005)(54906003)(33656002)(9746002)(7416002)(316002)(426003)(4326008)(5660300002)(26005)(2906002)(8936002)(36756003)(38100700001)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C4Gp9CufShbSjWRdS2m7Ja8oqAiMenMiHcFHRRE2nX23or8vChNIl/vn7Ewq?=
 =?us-ascii?Q?7C9t29Ph5+DeKd3U2EfQBz8nAaEWzoypOBGZ7Dc8pzV7b1UMn5yG6cZf8od9?=
 =?us-ascii?Q?fICbRLzYrR+eH6HH9kePUwE3oJ7li7XBCdopXmB6F9aC+l9nqmiCWKdT7Zn2?=
 =?us-ascii?Q?zdh/Qwf6ReiMfA9tVV+ySkM4UgSeFvdvPmMNsYffbUvr19wNCgJROmjL1W64?=
 =?us-ascii?Q?iGyorakNWHtJV27/aNJBQM5tQXRlryhxE+IJZE38VDsAvXTZMWCYk+8NMZIU?=
 =?us-ascii?Q?QW1ZnJjHRtXue4mW5hsSXMHl3R3/OiwBN4T+Sdx0Ln5btEKXK5kRWJR0qenh?=
 =?us-ascii?Q?2grV0jCjuLhB9Q9XI0Bxjm4RbjvuQxqmZV8CqeAflJCp11HDJXn9lSgp5QcJ?=
 =?us-ascii?Q?j54AzmIZYDFGp9j9wr70ItTm/bM0c2O7+qPchnjOwEIAhnYkM8uiV3TYQTY8?=
 =?us-ascii?Q?5HOu1uxbaqmJQfULvGf1Uig9/4ZyIgg8Hr0XA9TuCh1tH2C+z4GxFR5vQqrF?=
 =?us-ascii?Q?ewSXZgvhoN/dF2xAOYUw5KPV7mCq/75I240hIl+ZCh1ao1GWTrmiLPlZRkAP?=
 =?us-ascii?Q?h5D9sX3pBNuwo/KIn+SxuLC3RKTDgdsi8UXoT7EFYdjTjk6h9VcGCTSTyXm+?=
 =?us-ascii?Q?Xq/XMAGP5gBp70qhdRBCL4WWGcul1PrZvl/UYtPsX2uAXnXgx0ctEFI92G7D?=
 =?us-ascii?Q?B94mA4ZeZQh9hLNDtFc0zHCpk4cQOR4VuPWh37ChWgRBsyURy8Oz40FdWGDK?=
 =?us-ascii?Q?Ctxnwz2fB21yoXMbH1IGvCYRmgS3O2t+YuKvcYcsScyfwTmPek9VoAl4Q4y0?=
 =?us-ascii?Q?AiXdrkkbBrdka4ptayrTwrM/q13GN1nXaePJ3bwO6nr1ruNEgT+L3eZg5sgR?=
 =?us-ascii?Q?YYKHBwj7lnVYye2AJNpv4ewrmnuvMykFfBJoCUYIVE4qMBr5CR6/SMkb8J02?=
 =?us-ascii?Q?8zViUKcKWYOYMXJxFq3ig6bcnrXhIcdseV45cnDRSZfE+XsfDDbZ5qCn/5r/?=
 =?us-ascii?Q?Ncf4RxX8zPVVs4oH/K191Sv0W/PN7/+RsCTekf2l0ubfK4rPnnS8KeXp7D79?=
 =?us-ascii?Q?3frNcpU8GbPzE7AYQmvXzK3jMDTvrAn8We+yx3QxiTfAyXfU39PCgSXlqrua?=
 =?us-ascii?Q?xZWANMStXgnXr1PczazeDircSZwlus6JiwT6tMRFaO8i0/0aWtsuKaMErL91?=
 =?us-ascii?Q?8GwjRWN9kYY9tFdT41lTxO/bpLToId5bmE7oR/txX/kjoaBtwsxgoIefCkpe?=
 =?us-ascii?Q?fwYMMHAlqGCdJt8BpHMR7CAujezFWhUwgcqDuTuMiD2KyJvL/1srwK+0zXOR?=
 =?us-ascii?Q?NBPXWAZhhr6y4e67kqYq3tNyc2sljILEG4QL5Hr0bIycnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003266af-db2b-4af3-d25c-08d8f441d383
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 12:38:03.6376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rkmEDnoCPhUTbDRXbEmT1L9iI5oMYWWK1LKLM+in5SHzy8JQljNsybQboFKiW9K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Mar 31, 2021 at 07:41:40AM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 30, 2021 9:28 PM
> > 
> > On Tue, Mar 30, 2021 at 04:14:58AM +0000, Tian, Kevin wrote:
> > 
> > > One correction. The mdev should still construct the list of allowed PASID's
> > as
> > > you said (by listening to IOASID_BIND/UNBIND event), in addition to the
> > ioasid
> > > set maintained per VM (updated when a PASID is allocated/freed). The
> > per-VM
> > > set is required for inter-VM isolation (verified when a pgtable is bound to
> > the
> > > mdev/PASID), while the mdev's own list is necessary for intra-VM isolation
> > when
> > > multiple mdevs are assigned to the same VM (verified before loading a
> > PASID
> > > to the mdev). This series just handles the general part i.e. per-VM ioasid
> > set and
> > > leaves the mdev's own list to be managed by specific mdev driver which
> > listens
> > > to various IOASID events).
> > 
> > This is better, but I don't understand why we need such a convoluted
> > design.
> > 
> > Get rid of the ioasid set.
> >
> > Each driver has its own list of allowed ioasids.
> 
> First, I agree with you it's necessary to have a per-device allowed ioasid
> list. But besides it, I think we still need to ensure the ioasid used by a
> VM is really allocated to this VM. A VM should not use an ioasid allocated
> to another VM. right? Actually, this is the major intention for introducing
> ioasid_set.

The /dev/ioasid FD replaces this security check. By becoming FD
centric you don't need additional kernel security objects.

Any process with access to the /dev/ioasid FD is allowed to control
those PASID. The seperation between VMs falls naturally from the
seperation of FDs without creating additional, complicated, security
infrastrucure in the kernel.

This is why all APIs must be FD focused, and you need to have a
logical layering of responsibility.

 Allocate a /dev/ioasid FD
 Allocate PASIDs inside the FD
 Assign memory to the PASIDS

 Open a device FD, eg from VFIO or VDP
 Instruct the device FD to authorize the device to access PASID A in
 an ioasid FD
   * Prior to being authorized the device will have NO access to any
     PASID
   * Presenting BOTH the device FD and the ioasid FD to the kernel
     is the security check. Any process with both FDs is allowed to
     make the connection. This is normal Unix FD centric thinking.

> > Register a ioasid in the driver's list by passing the fd and ioasid #
> 
> The fd here is a device fd. Am I right? 

It would be the vfio_device FD, for instance, and a VFIO IOCTL.

> If yes, your idea is ioasid is allocated via /dev/ioasid and
> associated with device fd via either VFIO or vDPA ioctl. right?
> sorry I may be asking silly questions but really need to ensure we
> are talking in the same page.

Yes, this is right

> > No listening to events. A simple understandable security model.
> 
> For this suggestion, I have a little bit concern if we may have A-B/B-A
> lock sequence issue since it requires the /dev/ioasid (if it supports)
> to call back into VFIO/VDPA to check if the ioasid has been registered to
> device FD and record it in the per-device list. right? Let's have more
> discussion based on the skeleton sent by Kevin.

Callbacks would be backwards.

User calls vfio with vfio_device fd and dev/ioasid fd

VFIO extracts some kernel representation of the ioasid from the ioasid
fd using an API

VFIO does some kernel call to IOMMU/IOASID layer that says 'tell the
IOMMU that this PCI device is allowed to use this PASID'

VFIO mdev drivers then record that the PASID is allowed in its own
device specific struct for later checking during other system calls.

No lock inversions. No callbacks. Why do we need callbacks?? Simplify.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
