Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FCC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:31:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FEA60F4C
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68FEA60F4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3968060771;
	Thu, 23 Sep 2021 12:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLMMUe0N8hSB; Thu, 23 Sep 2021 12:31:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E3B706081C;
	Thu, 23 Sep 2021 12:31:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4E70C000F;
	Thu, 23 Sep 2021 12:31:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97725C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7512041626
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qIkB4td1j9MF for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 12:31:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::61f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 466B440338
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMd/H1V3iWFSmkVjkRB4ZdBa4L6x+uwjHBwkjeWEWh+frbwcOBe6NyLBigjo+7I29nQ99xuE85fZFNWjiNfFghnR6qdzHl+19KjEHLEqv7hwd88HZeOgjUdbgbpra0gXh2uuNyO4DW5pM6r2/GTL5cNWqul3uk+L+P8ZWuZqs/pMW8Tut0EHBfti7BfJH0sfUL+1fmpB/2pTbgx1b8LRLtgGRCEl9N87PtsDBJThdp6i4Ft03ylKViLexAgtNq8RGjDk0/woW8mZO9TiJnDG/v8vKpqQTQCCLp+lpsOwu4tyA1I/6Ht2FLh4w99kTK0zyTmhdJlQx9BDozgrb7vfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=64yYZFfTw/PpT9iv8UbhperxLkjzQ9b0pK3AyJA7MZA=;
 b=WeM2GVRaP7//GBdqn88hlKxQkoAtsDUpu/tnh6QY4XuZtMttKS8FWLkdG15AVEe+Of0fO3u0JXOIIlXr8naPuoCIGtLLDYXkQ4V7QtceBh9A5zoVAyidPdywnhmUfQR7MyzU+IN5nQBIEUh686NSu4nCDsPdZEQGiRqUdLJkTSQabr6WBqLxT6Z8K2dMqdfoF63Ys/uZ5WL2ezIck80UMA2+rYhiX7ADoSJss1WCPtr2YpafoV9ZBwPgpRwa67lbxvJ8bLO33AMFRY201uDuQrucun68eK5tunouti+Xio05O6G3Hf1srBqA3XUpZHA3+NqT47SBVN+dm0R4Rl6LuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64yYZFfTw/PpT9iv8UbhperxLkjzQ9b0pK3AyJA7MZA=;
 b=j8a5nNqBm6pFJxU4+JJ8kB88h3XAAgpGCD6YhRP7sA+ZO7xVnuWyzG64YfqGaRXga3BwI8Xu065W6+eywG8GMI47mQUhk4B8KCPFN3p3qtoJrr2BmQmo0n33pYRxD/ANLp0PsyViCQgjPmoxgRzQoG7roaoTBq2IW5OpToA+nff6ytCxQm0LM5Jkqrb6sn0MDCho9G+xFte9MQ/Fs7GtCuxsPXwJQYJ5X3rE7alMEB38rCv6FmdR1PRfLat2wtyzID/fFcj4AH5VWTK4RrYordZtbWjGLcrxBAb7c9FpxO4eT6eHR9ERD5eZYZ2jANfWBTcmK773tAOW9AtLUhV6ew==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 12:31:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:31:19 +0000
Date: Thu, 23 Sep 2021 09:31:18 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20210923123118.GN964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
 <BN9PR11MB5433A47FFA0A8C51643AA33C8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923120653.GK964074@nvidia.com>
 <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0378.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 BL1PR13CA0378.namprd13.prod.outlook.com (2603:10b6:208:2c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Thu, 23 Sep 2021 12:31:19 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mTNsk-004P9s-5s; Thu, 23 Sep 2021 09:31:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ff36600-b80f-40ae-ed2c-08d97e8e0ba1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB533575FD45FE3C4513F8FC97C2A39@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcV4fifJFyqIx2fPGo1u8YEZiP1MboeD1H5vXd5O5AhHdky/MchuffsN7YpgWNdNUk8/9snyyKa7D6QmnBvSW8Mg/jmrjzwcToHjhj86PKkh/oKtHZKa8lVbaESDyeLoz+cF+iPsgQ4FrJwXFgeBJiOv/lsw2FThw9yjTKLpoYjeqZ3yskVbQBPLIjULC+whNrJCMbniovrPX7jqyqITr65ein/UhWLHDsqTmLgTMwm8qT6sy+WhlKwVqSvZZNbC4sfc4lqVJRKMAuH04k7xGFjnzx+XTaZkcohM50v/ojv8XyDSMaCUdWLegWMb2LXAsxgS49eG1ZfzhGJAtzitakbCxEp2natOH7uTkDli4pxG7SecidABhor8Ayfu5NaqjZQRZrciyy47aJgIMXOiwDPBtPdH/+9XOAC5t19QgAx83Xe8bTuIvKhjTgIuE9lnjwIGMXKyIGtnGljXHy4KjgKt6ufT8zFZHqmiIo9GGkr0nQL9Y58WBzdpFekQ1QfQ0dpFeSBaZo8RLbWuMZScJJaa6oCt4qaCLgY8tVhvwYSqjmy9gHzgTExeeyFAoRYDrQqD6XH2s2D8tgVeLXbVkFdihPSe3ZtOx9u0EvY4ip0ONwsHMnAbVKaILHuA5TES5HMFlKE044vQ9/SrxUbud8TKrJa63hRLGINT9Qq6MG1LwIWygvVTLyC9IDnhpejWyZLhEd3ZDw/gYNsrjmXsonHnWJbdXLZ2dx/FJ4srZrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8936002)(54906003)(66476007)(66556008)(9746002)(83380400001)(9786002)(66946007)(2616005)(38100700002)(5660300002)(6916009)(2906002)(107886003)(8676002)(86362001)(33656002)(4326008)(26005)(426003)(508600001)(186003)(1076003)(7416002)(36756003)(27376004)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Saoe1IS62l4WSBZhDMuSGyqnIcJKKoWh5wC7XlYOu1+znXfwLjgViHBUTv2o?=
 =?us-ascii?Q?Dx58PzsIah8QsOzPxLyT+rahz5s3dRb4o83aeXzgQbhsB78o0qQz3G4oksps?=
 =?us-ascii?Q?T6aaprP1XSIeiXNIxhs/ZpA0vFDLKQZU16Qxi3c+0XjrJKaP+DFNTyBtgMid?=
 =?us-ascii?Q?UjPLATzmFM7/wZT4ENSS4EmOUC2IO+Jt92h6djiJaMUkPpBvjLHoV4xy0Eas?=
 =?us-ascii?Q?VKAQuLfCLtXI8N3yB9WZ0coTWNPTfh2CItyhT4ZG6NgAkakthRUKgBu6X8MV?=
 =?us-ascii?Q?bKPIOFJ8t8GgpwyzCbyISfMMlH7XKM0DmjNyNcLgr4WDsStTXdkh36uq+1E0?=
 =?us-ascii?Q?t33O9GXLojD34AFZGffYr6uU7j/qY6f8O8WvdU+bK3RsAntYbll/c8tsBJDY?=
 =?us-ascii?Q?CE/T8FR9SWyKZg51AlU6HdV+SWOLkDkqAHTumpJviUwAMI4ZITYDJtOg0rnt?=
 =?us-ascii?Q?AxV5Hzk8HSnukWLJh2R0wFIZmib/TuGIMyienKIQSL7afr9nC7sMRuVqHksm?=
 =?us-ascii?Q?l/gCXrZAClFeP2gC/gq0wRXfA7cVFlwwLTV0bozylXfSd1nQUJlAt7yJYAcO?=
 =?us-ascii?Q?nEiOKdKugr7BSQfzStQoZo1qE9Ds/w24SBBqgp/YT2P68mGaTrCflTrhkSrn?=
 =?us-ascii?Q?kq/JYJ1S37w5xFPmTxm8q4BWRf6gaTxdf7cl6SForkGs310Ov5ZxuHDhKW1n?=
 =?us-ascii?Q?Awk3ZRtyshosjnD+DHVmrAetfhM9AG4RzPUmb8yZC4Nzc5CHmbXjUmehorNr?=
 =?us-ascii?Q?Uyp1HcAxpA3A9hrUYRSNl7g8akaBf5E0FTzo71H1xTaWAy90lpaa2050eUfa?=
 =?us-ascii?Q?q7QoyAiSgPSh6ADvZLfNn2yb4agqvJ2z/x/u4+jotWPr8+ci3HyxI7d5OvbZ?=
 =?us-ascii?Q?Jx3wWhq0YfHE6vFk3r5ohic2Re2K3AXGjXTPO0UvlYL/jBnqluGezT536bMP?=
 =?us-ascii?Q?7BSZV0Lt3YbhR0yAd54h1gufkEJFv9xA6XDgVsfIa4wZY1iFtstY6rADJ+C3?=
 =?us-ascii?Q?Xxol1WALGs+c3zwOhbQ2+1rv8jPR6tYU2ooRpvKzC3J1af16qamLDL6zJRuZ?=
 =?us-ascii?Q?2kAPjiwdTJ1mA+0jCJujOtSOJ+OqLMHLQim508jyXoo18BqJ3YMUYGr56Fkk?=
 =?us-ascii?Q?ZLZS4CnH/hrwYhHvB5La4nWwlBFyiE3RTqI2w+l/UdC8n55eim1z3E/U2oRf?=
 =?us-ascii?Q?M9l8ign3EaCI1lKhzn0VZDxAdWBepSq+TAhd6CjjQ+O3c3kdQ2T1K4Uk0yui?=
 =?us-ascii?Q?Sgz6P+kCI5e/xHN9UtaQf45GW2BWe5FogiH3cFdwRNpTXqPtGPj++848i648?=
 =?us-ascii?Q?1rELwrcYUXoj6DU67Lz+PTqd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff36600-b80f-40ae-ed2c-08d97e8e0ba1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 12:31:19.6826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7CVSSkesEMhwWPW4UCufB84aRzCikea140O/jdUv+Unc9x/2rlykGWz+Gfk0HtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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

On Thu, Sep 23, 2021 at 12:22:23PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 23, 2021 8:07 PM
> > 
> > On Thu, Sep 23, 2021 at 09:14:58AM +0000, Tian, Kevin wrote:
> > 
> > > currently the type is aimed to differentiate three usages:
> > >
> > > - kernel-managed I/O page table
> > > - user-managed I/O page table
> > > - shared I/O page table (e.g. with mm, or ept)
> > 
> > Creating a shared ios is something that should probably be a different
> > command.
> 
> why? I didn't understand the criteria here...

I suspect the input args will be very different, no?

> > > we can remove 'type', but is FORMAT_KENREL/USER/SHARED a good
> > > indicator? their difference is not about format.
> > 
> > Format should be
> > 
> > FORMAT_KERNEL/FORMAT_INTEL_PTE_V1/FORMAT_INTEL_PTE_V2/etc
> 
> INTEL_PTE_V1/V2 are formats. Why is kernel-managed called a format?

So long as we are using structs we need to have values then the field
isn't being used. FORMAT_KERNEL is a reasonable value to have when we
are not creating a userspace page table.

Alternatively a userspace page table could have a different API

> yes, the user can query the permitted range using DEVICE_GET_INFO.
> But in the end if the user wants two separate regions, I'm afraid that 
> the underlying iommu driver wants to know the exact info. iirc PPC
> has one global system address space shared by all devices. It is possible
> that the user may want to claim range-A and range-C, with range-B
> in-between but claimed by another user. Then simply using one hint
> range [A-lowend, C-highend] might not work.

I don't know, that sounds strange.. In any event hint is a hint, it
can be ignored, the only information the kernel needs to extract is
low/high bank?

> yes PPC can use different format, but I didn't understand why it is 
> related user-managed page table which further requires nesting. sound
> disconnected topics here...

It is just a way to feed through more information if we get stuck
someday.

> > ARM *does* need PASID! PASID is the label of the DMA on the PCI bus,
> > and it MUST be exposed in that format to be programmed into the PCI
> > device itself.
> 
> In the entire discussion in previous design RFC, I kept an impression that
> ARM-equivalent PASID is called SSID. If we can use PASID as a general
> term in iommufd context, definitely it's much better!

SSID is inside the chip and part of the IOMMU. PASID is part of the
PCI spec.

iommufd should keep these things distinct. 

If we are talking about a PCI TLP then the name to use is PASID.

> > All of this should be able to support a userspace, like DPDK, creating
> > a PASID on its own without any special VFIO drivers.
> > 
> > - Open iommufd
> > - Attach the vfio device FD
> > - Request a PASID device id
> > - Create an ios against the pasid device id
> > - Query the ios for the PCI PASID #
> > - Program the HW to issue TLPs with the PASID
> 
> this all makes me very confused, and completely different from what
> we agreed in previous v2 design proposal:
>
> - open iommufd
> - create an ioas
> - attach vfio device to ioasid, with vPASID info
> 	* vfio converts vPASID to pPASID and then call iommufd_device_attach_ioasid()
> 	* the latter then installs ioas to the IOMMU with RID/PASID

This was your flow for mdev's, I've always been talking about wanting
to see this supported for all use cases, including physical PCI
devices w/ PASID support.

A normal vfio_pci userspace should be able to create PASIDs unrelated
to the mdev stuff.

> > AFAICT I think it is the former in the Intel scheme as the "vPASID" is
> > really about presenting a consistent IOMMU handle to the guest across
> > migration, it is not the value that shows up on the PCI bus.
> 
> It's the former. But vfio driver needs to maintain vPASID->pPASID
> translation in the mediation path, since what guest programs is vPASID.

The pPASID definately is a PASID as it goes out on the PCIe wire

Suggest you come up with a more general name for vPASID?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
