Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE34C433FE
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 13:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B4B56113E;
	Fri,  6 May 2022 13:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gfbSegsI0ue; Fri,  6 May 2022 13:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 695FC61131;
	Fri,  6 May 2022 13:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F991C0039;
	Fri,  6 May 2022 13:21:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE936C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A015783FC8
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z93chaz3Fq3G for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::619])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9B2C83FEE
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 13:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaMe5SymzKzcU8eHiQ4CTzp0sicGESsyEeTvxuMv7th7AWVo1w3J1U5GIFK1ZEBZALslH150dzW2HaE8k0KW5XSPxktTsQQcl4QhesRF4MjoWoQZL69DbRZ4X7xEk0t0m911foGMxiImKsa4qL1BhQOMRhe/kVl7OtugjzsMnVQBl9gYs1gTwIZS28FHnjUOMRi74xeSgIWQBiKd7Adr5CgOwpOEaN6knrYOIc0bZ7KfXGVpD5WJxGfJEkMW7SwtmUuGOZspyoXaxNfB7pz+h12yKaZliaZSrfUaLoxNRLbp6MSd6H8nJPhDXczZbMGgH0z2XopKHiMQcVB+IXYTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB6blUZy5QQDSPF8SfJhxrkA+hasZXFUqL9DmV2ZH+I=;
 b=hiqlxh3HZfGI4bu2VS+BQq+/0YkwfeSRwN8P9mKY8a0bOPstiiLHE5z56TwJry6F7xjEF4NWvj7FeAxWIjKET1Fb3nA6vBIuBFPTeIkRNwsrIuzKueq71au2jEOdz17QhyMVh/R2T7PanjdB+y6C8QYRE9ppiEcJLK90FmDOkKRqUIZw+JCNqTpVkpC5ULwn39GWYHIP/DB9TYcqXqva7V7eVgPeDrjLA86ePqluNx2Ovb3OCby+kOCCZuPlQUWpKvcqxJpjaCnx2LJizULVncNYwVgsBqaBhv3Yt4gZTkwFWv82ACCRVz2ogQTFrehcv3qF/BKM7VzjfsFrnM3aSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB6blUZy5QQDSPF8SfJhxrkA+hasZXFUqL9DmV2ZH+I=;
 b=RUi6dszZPsW0TM9yKQMmAAL0yEmT8V8NWGe4AbcG3t+U+VWHRr82SmFJjv8uCEtdc8rmTc67qJtMNhXu16LUQTRiU+Sn/6TuR2NuYRDx1OLJhXhk2//C5qynlc07EG3yvlqUWR3ueAAQaxx4TAxULllsEHju5iVPOTD0ii/bPHxtAmtAsl4z9FyxIYy/cK2lKS899bvpr5nM6s9cICTPLNx25WJZ7m9WX95y5Bx1qb952biby7IVrnPvi/L5Eid+cPRdOyTINMz9XaHW9+ZpAEwmiUwJjVft1b41uF6OSQYEiar9BcJu8dcN8kp7K9qzopO03NRaSYlnXtAt57DjHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3797.namprd12.prod.outlook.com (2603:10b6:610:27::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 13:21:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 13:21:15 +0000
Date: Fri, 6 May 2022 10:21:13 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Reorganize __iommu_attach_group()
Message-ID: <20220506132113.GB522325@nvidia.com>
References: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
 <94ced5af-820d-8fe7-4bb1-3d552a45b80c@arm.com>
Content-Disposition: inline
In-Reply-To: <94ced5af-820d-8fe7-4bb1-3d552a45b80c@arm.com>
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5654e4b0-c8fd-4787-db20-08da2f634bda
X-MS-TrafficTypeDiagnostic: CH2PR12MB3797:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37976E51FBBC7D9A648B350AC2C59@CH2PR12MB3797.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdG2O5HCYryvkLKwA+edpKX0kl1LWXXOwW0JaBrF+GYOXzontSTnYGoTtPLsl+ZbSickE9UJRiifh07Q1mMKx8Yk/UdWSamN8eJ868rJHQJdsufQMOQCKMOn5zta0vukzcNBHkAurdPMZJnnDlvXePzmSeYOzSkhvMtyFUpruWhlbOlJ8RSCKx5WzmW5QFkAx8f3utix/Ae9UMwCbRzT7/OyiIl/hLcaobY2Qm6hF2DLk17+c382/hexLzRy0OVWbRNYdLcFGe+Cty23Zn4iiUuFf25AuUD7+Aa4BYaA429NI+m6uqN5msM/6od81LUmlKqVoY5m/LiXMovk7df/bGJwoMc3GSxG3mLbHzyqPPXun63Wodj/VXIA+H6Aeg6L2Gup4ew1AcD817atyfmFk44lWl4G3BrgFeSUIh1TwjHzd9ZUQrXlmLYU6Iuiv5AtBl7U1BARhVW4f6H96EGbJ15LUtwxCR7Szarkyhv9U7hzkPTbxc2/VaT7N18291n+jg10jBVqamHvIMeSjPs+piXtDevCrLVHbog3iD7h8+FkQ+vG2/K+RqC7dhF3n9uq0oYx6gcnkCDUCeWZIdz9B3UDSUvmtSaxMmSoQq9Dd1kOK12xGYQ7YPVnh8Q+oViCzzYIuPATMJHCHYzmtFywOSARnNE0GQ5LFV5NDRrdnKJWp7j903oJYK+t5Fj5N4Tw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(26005)(2906002)(33656002)(6506007)(6512007)(83380400001)(2616005)(4326008)(1076003)(186003)(5660300002)(36756003)(316002)(86362001)(508600001)(54906003)(6486002)(8936002)(6916009)(38100700002)(66476007)(66946007)(66556008)(8676002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0oYuAqC2v8zp01K9idaivnvICWc7GymBtZ7NWXAkrchGYd0CSXkrkHsaDJf?=
 =?us-ascii?Q?SOobuZAB7Hv6rBqRTkSUkF501Eh/KnUJlnW0Mdeco/OI9LASK7VT6hqYfpRq?=
 =?us-ascii?Q?AzBqCDc863f794Ylwk5WyDwKdaE3uXyfWe4XhCuPAKBHeB+IGVKHqvZd2vpd?=
 =?us-ascii?Q?EvAxRP5boDaiUUUpUpEnC5PKnsStsiwUsaDkguGmupO9ho04hLHH8uLcZFRu?=
 =?us-ascii?Q?4Fe5qUrLAjwNqP5MjnuDYL9r/YXgnx5lyUW9gGfbjxXzrttX/3Y0N3WloKjF?=
 =?us-ascii?Q?Bq4Dv5/L59nwJOYEPHIB3jagMf39JnGmevb9sYJMJryyHQa94cHRutpMMohK?=
 =?us-ascii?Q?f6oONcZRZdgkzInvnA4yc8cXmvs9OR5qaOCQq6CXZZAxncE5oxsMNtvTSKx6?=
 =?us-ascii?Q?44H17+eP4a47ISVyjYZXGRWJirgGyt3AFHKllygTSTTYe8A3RALP0P+1zm2t?=
 =?us-ascii?Q?cZJTdsK5BW7Csypf/lX2JG8+oH195AtTNkwKdQQHdnCQxdhQrHzQPdNPWFwD?=
 =?us-ascii?Q?fxvPCnd4ro2JQuZwW3aY+rkHUTZbGoDrYfVZHmdljHtt950gb1D4iqygjA7O?=
 =?us-ascii?Q?aR88a5iD+b0QAvmqPTntM4CkES0iEJBF58rw/KFHslvBx2L5KaE+9TsYkQJJ?=
 =?us-ascii?Q?v6EjL1egnb808StwkYS0EeXVq83dS74NtY4iWMByJz37Ok0d66aqgH+JGdQz?=
 =?us-ascii?Q?SAKfULcrHf+iu2VEToEOhHaZTP+UrfeWS8/c/kHRULn7GSRJVU+tySQcANNP?=
 =?us-ascii?Q?rHJSwopzCrVl//LrgCC4iD6l40g3EhRljLdfIYEUoiIeOlxgOwcaJ0avDsa5?=
 =?us-ascii?Q?mmr/jWzC1hUk/zet9tFBrsUqP3jKxAyB6jute2FdvlYkCFNk34XLIYw/SIo3?=
 =?us-ascii?Q?Yg6/on0EG3Xx4wl7XuhHGATicD50UNn0OqtdSehC+EMUWEUbg6woh8bYvJtV?=
 =?us-ascii?Q?EfQzo8kb5X6NK849X3mABGKTLrPjfNjG41j0W6lRnZIzox39pDFrGs+Wf4pa?=
 =?us-ascii?Q?Oa8KwaCUiwGWx5hlarRCaTPiBSGNDcfglz1fgZZIgrKBLnmRoOm/FbP+SFLB?=
 =?us-ascii?Q?IwXl8pUeofNMiHb3mragDWGc3ogsqPTRFIcM4mZLJu9J+/DFsQttgPj3hry7?=
 =?us-ascii?Q?l3ZwnsWnzSqeTgGtECHMPoa/uq9/FF92uVdLnfCGWLRcBz9N6LU+4TAlyA0q?=
 =?us-ascii?Q?Z6DabI+i7sjqfDYqLFMU1Nnt2PStnpERYspxNiI5qdR0RcLT4V6Ke7wW2my9?=
 =?us-ascii?Q?Q3HTWAU3B2c/Skk8jWcDEd0ICKHFEJL6MSRddevkkcNZq/LVR535CCqBzbiA?=
 =?us-ascii?Q?pneEMuvo6AS5GZtBEaQ52cl6yQlvEHoOJhrYNuVwakRBpvudbExW9fNlcZGb?=
 =?us-ascii?Q?gQ186EL6tk/Oms1LHEYEfYSkYQOtKg24k3wEyJmqpLAel93sEjxrSHkbSJuN?=
 =?us-ascii?Q?mYjqqyOQhgvkGcO41jSXgdNIrKFFAxidWYJ/f1RuPNJ12OLlPdFwfYiF8yeW?=
 =?us-ascii?Q?4xqx27Nww37w7kS+s3i6+IQll4IDXcvj+O8kdWKmjCsujXTUD1Wan1zVx+na?=
 =?us-ascii?Q?/5zT+ld4HoRJAfrWEAAg2r6yQAgk44s6APHZb4P22OcLUDhohhZiG1eZN08v?=
 =?us-ascii?Q?EhcMJD+tDWLtzPsxF3OFrkafXG0BRQnztjUNqbn7oXKfBwH84NmY6G2XMUPa?=
 =?us-ascii?Q?TC7JnR76YP5JMAqQpWdjv8FkvWvDG5EarHsYwJUtmFjB9Uwq5oKouX94zwzo?=
 =?us-ascii?Q?P/haCVloJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5654e4b0-c8fd-4787-db20-08da2f634bda
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 13:21:14.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+g3uHk/jx92TM/Yavq+tQwyQUt7ikCRlp3hKXIOhd1G49Ds6g21c6Is2hpO1g/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3797
Cc: "Tian, Kevin" <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Fri, May 06, 2022 at 10:12:29AM +0100, Robin Murphy wrote:
> On 2022-05-05 17:15, Jason Gunthorpe via iommu wrote:
> > Call iommu_group_do_attach_device() only from
> > __iommu_group_attach_domain() which should be used to attach any domain to
> > the group.
> > 
> > The only unique thing __iommu_attach_group() does is to check if the group
> > is already attached to some caller specified group. Put this test into
> > __iommu_group_is_core_domain(), matching the
> > __iommu_group_attach_core_domain() nomenclature.
> > 
> > Change the two callers to directly call __iommu_group_attach_domain() and
> > test __iommu_group_is_core_domain().
> > 
> > iommu_attach_device() should trigger a WARN_ON if the group is attached as
> > the caller is using the function wrong.
> 
> Nit: if that's true then it's equally true for iommu_attach_group() as well.

Is it? I didn't check this as closely..

> > @@ -2110,6 +2100,12 @@ static int __iommu_group_attach_domain(struct iommu_group *group,
> >   	return 0;
> >   }
> > +static bool __iommu_group_is_core_domain(struct iommu_group *group)
> 
> I can see the thought process behind it, but once we've had some time away
> from actively working on this area, this is clearly going to be a terrible
> name.

We don't have a name for the set of domains owned by the core code vs a
domain set externally.

If you don't like core how about internal/external?

__iommu_group_set_internal_domain()
__iommu_group_internal_domain_attached() / __iommu_group_external_domain_attached() ?

I wanted to use the word 'user' here (ie kernel user of the iommu
kAPI) for external domain but that felt confusing as well given we are
talking about introducing userspace domains for nesting.

> Even getting past that, does it make sense to say NULL
> is a core domain? I'm not convinced. 

NULL is not an externally imposed domain so it is definately a
core/internal domain in this logic.

> For the sake of future readability, I'd
> prefer to call this something more purpose-related like
> __iommu_group_can_attach() 

That is not the case - we can always attach any domain.

This is only used as a santity check to see if an externally imposed
domain is currently attached or not.

We could also just delete the check..

> (and also just define it earlier to avoid the forward-declaration).

I put it here deliberately because the function directly below is
__iommu_group_attach_core_domain() - which causes
__iommu_group_is_core_domain() to become true. The symmetry helps
explain how the two functions relate.

This whole file is out of order, it seems to be a style or something?

> In fact at that point I'd also be tempted to rename
> __iommu_group_attach_domain() to __iommu_group_set_domain(), to further
> clarify that attach/detach still reflects the external API, but the internal
> mechanism is really a bit different since default/core domains came in.

It make sense - weird that set_domain is the only way to call
attach_dev, but OK :) I'll do that in the prior patch

Please give me your thought on external/internal as naming instead I
can adjust the prior patch as well.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
