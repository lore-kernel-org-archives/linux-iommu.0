Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A0C433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 12:10:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACB361164
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 12:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACB361164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBD0E60651;
	Thu, 22 Apr 2021 12:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VnRsNSgSg7bO; Thu, 22 Apr 2021 12:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACE6A60605;
	Thu, 22 Apr 2021 12:10:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66CC0C000F;
	Thu, 22 Apr 2021 12:10:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED526C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 12:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDF9360605
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 12:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBBHuL23ZMAI for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 12:10:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B9DE6089C
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 12:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bezNjf6t1YZiQOXFw1k/r2H5eBeDCTLAOGDjkcj3kBoA/hDiuD73QbB3ie7t/xn+XDxeEG/sR3tuFDXd54E4vGEe2N2IdMAgJmv9F8HX+K3NQhbSEEog425RlX70HXnQacz3FYYKw97k95dIRaq/X1Lz2Lcu65qFeJBT9pfuPGbYhsvM86iHLaL+isQ3xtpJLBQ+SG33aIVB4bOdr5vHhYngATlPKnbtvcmEF+dfGqQUOUN7eHzWVRkhCa+xFayBuqQuW1XlfzD7GPX2OoP9mAVcPNeIiTWuY69wStPhKtEQSUmPG+BYYfQzrsqynEs1ubi1M/L8UZ2hiMAb4QIPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeZlekQPQn37lMdede0eVSjq/MRzoRbjxrpbSDohj7s=;
 b=XAsX1JXyS8L/t4gQiVLrokjieaR9bf7GeLdehj2L5YgKNA3BKjTejmiWCpy/FtcJBkaFDciGWbvUmrTo+rfrMvyFLCS6y/AB1vSVJOQw17hoQMdoWMnk5cKvQjGI9a1udPuor6svoTThI2K8+sRDuT2ObHgyQRy24g0XTfP4t9ZrJWzCeEGrLazr+JPdyXzKxB0b92tOKZ+tdv4zdSXUQd1isHBS+NbteCC9ObMPTEOjUdexxPxQmlpV6MXLuX40T6mORyEOYMzgSpOVicqfARniHMm7LErAGSDJ8DnRS3vyH6iixS+n7jGL6SfikUD30iq3koCfHI2/qgSaQSaq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeZlekQPQn37lMdede0eVSjq/MRzoRbjxrpbSDohj7s=;
 b=lraMJk8/2sgD9Vt3FhmJKC3pKQyeqZiFR/iPJ/XBvtK8kU7uwDo8ncLi3QKGrKaEz8vNCUTbPZ/fI+C1qpaobJ0i22ZqnD1gdyRtspKRYNw4bYuiLhw+roZSAjpQZ/9JkkAJR51RLdH4iRYW7tETi99Q5BRVn0u4oFCv7gQlxX2SCnr49auoITokGfkj5EtTri/tCYTlBqTfZotLFWN5lQrEOv+uI6KIgVBVxc+kMeE/jCGr6E2qj47jDQHr3rBwlr5nIQqG9nPtNScKTn9TdlZqqtzkrIH6vY3Zvjc35qPBF9CbHBCL272fFQ0psU7cancn2blPW4OcmrTaFIYrPw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 12:10:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 12:10:22 +0000
Date: Thu, 22 Apr 2021 09:10:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422121020.GT1370958@nvidia.com>
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 12:10:21 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lZYA0-009wx4-4D; Thu, 22 Apr 2021 09:10:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 488f0d67-f463-431b-4365-08d905879a3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4009F4893DC3704092F19304C2469@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCX6oedk3+sK7R/Wrim5/3FbEetCmsC0ott4Rhs0xqnWliOgqFg9lJzkYT5gajhkWPNZ4HTaLcpkAhOyje+7QmQtaU11QTG2kNuws+WMGkUiN7I3Uv8LnrNpo6GKzuJz3M6d5IzntyBwXdTycgn8MwquXFePIbop6R4LU1YDvkUZhKpRPHe1pFo5PyAge3kvP6E5NgJGqCzH+hDH97IMjHN6E+fUKR2jZagsjOl+9ioTGhc7HoQ8G3QTglSNu51a0fiMwXIA0RJ5KiXhijWJefswsN1Wvw5T4/NcNtGk+uuGZp6HEesI7ymTmnnbl5YtybmoGX5uQ5qRxuKUfP+3GfYW2HHHtcKxXfKjrz+I12ReDfNrGwyj5Co4Wpp6CGKajDUVpyC5vbYiS86RWTEZMRClEAOZOVAoLVQ+OyZq/K2oRFbwxK4HvXuDodspfPAmsUMK60o/7h8m/HLC1U4xKVH5YV1QrPfoidkL/a9/CyNOZ2E7v0PjmWZm78PV/+4CAd7WgtzkntQBVSVDUZ/2STcbSEuxnNAOsxUEqGBQ3+69oyP9cZURRgTxoR4GwU2F+pqUsU4KNsuZ3jz5yyt5xsUVKl3+9mlArDcPv+E0o60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(26005)(186003)(5660300002)(86362001)(33656002)(426003)(2616005)(2906002)(38100700002)(316002)(54906003)(36756003)(66476007)(66556008)(1076003)(8936002)(83380400001)(9746002)(9786002)(66946007)(6916009)(8676002)(4326008)(7416002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yHh52nX8tRhwIJRyXBWdLU/9ziAH6wkkVlqbeSvppq4pIAwTMgT7a9eLQQf3?=
 =?us-ascii?Q?GUWp6yVR+Lwb8SwiNQvMpEkrKG/g19Lbfrs7g2D3FqbscvvrX+3AR7jhUk9V?=
 =?us-ascii?Q?H3vziad88N+2+DRfDn77E6YLmCdM694ta2aH6hfPTwRjbMuTPM4fuJgzYZE5?=
 =?us-ascii?Q?PcXeAumakzBf3B+RkaAeflYC3l+K79bgRut/78MeuwCcD07LNvAsFDRTQtZ2?=
 =?us-ascii?Q?0eOs4ADF26SEdtSq95OA/sSC8jFZPnXG4bBBN8nv7j9ZSo+y8nJ7+elZJFVl?=
 =?us-ascii?Q?A+SBwYy9xx31f4hmzcJXc8Qwlns38KJbm+3OSyDqgg02x8rXm3Wih4QGZGGW?=
 =?us-ascii?Q?eP33esFL3lVjRYJSqcYtvBoa0MzeMhB7iIKZU+AhtHN8iOR20u917voptbIH?=
 =?us-ascii?Q?QNIDnyWRVlq+NGIw3WLdNJM2n//qrIZ4yxmik41Zvb5jP51Qw+E//OEERvgZ?=
 =?us-ascii?Q?J2vLtSFXYqNNkzo24mbf8W7vLw5NFVhxoK/gxsIhYbf4RshpU42wrn9nNWJK?=
 =?us-ascii?Q?g3t2KeHhCms4wDL3gE8uMYbIqMexGZ2BvLD39m56H/66Tx+wL6beKkC970Fb?=
 =?us-ascii?Q?j6GfZtuHOnarVpsG0ph6TWjlEuBFzgGE3OPQtHzHTZq4FGw7A/nVjg0odg4D?=
 =?us-ascii?Q?P0Z0LVLeYGfhvuDDF5rsbFfx/DP+vQZTTffDlG6SDv/Pjc6LmftBs+WUCDMV?=
 =?us-ascii?Q?+CmnNjcn4DoVbbH2jVU/pg/IZZu/lOy7cghNmWL5HBr3qgHog9ouZJkv7Cfd?=
 =?us-ascii?Q?P4Iv2qJqHLV5kiUB71sEu1uAfWYXZIxmXR9WrIVB9YblqcSFC+4EBgildbuh?=
 =?us-ascii?Q?urVIfWtYGl3KHIUOPRbkFYrgY3jKzX0fHQkON0D/IbIp8BiluXDNoOHsADIp?=
 =?us-ascii?Q?dmiQj6rG/ntvcRs1uvLgMTjuMug4ZxhD3RpWbwIhzEBeq0JDrJFCJJ8a8oR2?=
 =?us-ascii?Q?VgAgT2QEK270DKb9Uyg6/JPPRXahQXc6plM+RMQq0gS6QCNBdOX4ZQOaN4V/?=
 =?us-ascii?Q?TmjODDzpK+WfloPZw+sifVmAodwwExbfXQS0k0yREdFi2woKWfR73CR9VJ1r?=
 =?us-ascii?Q?+3I896smVLtRMVwMub1rUuJkBxPfC1PMz5f2WuDFqsj8MOTfw2a8J6srnwOC?=
 =?us-ascii?Q?EiUS4O98UNJEOj9NB6urvAdf51WHhzjctAv0FjL6/SzzhS5IcCzncMexyjuJ?=
 =?us-ascii?Q?qU6OsRp5M4+M/l+qZ+F7HrGcb+VaeynvbAXmv+mqcKuOK6Bps/kZ/Ze65Qyp?=
 =?us-ascii?Q?beHbM1+imU9wNLkUj423uWlAXFoQqm2sCtvjZm4YLGBRylP45HH0BRYSiVmG?=
 =?us-ascii?Q?AoSfc8IHRsLl50pFKbqn4frJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488f0d67-f463-431b-4365-08d905879a3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:10:21.9289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zY55nDOE+S493esMBv9QHN3f2e3QIHASQUOSlUnWgN/ey69QwIzc3yx6yqjAvIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Apr 22, 2021 at 08:34:32AM +0000, Tian, Kevin wrote:

> The shim layer could be considered as a new iommu backend in VFIO,
> which connects VFIO iommu ops to the internal helpers in
> drivers/ioasid.

It may be the best we can do because of SPAPR, but the ideal outcome
should be to remove the entire pluggable IOMMU stuff from vfio
entirely and have it only use /dev/ioasid

We should never add another pluggable IOMMU type to vfio - everything
should be done through drives/iommu now that it is much more capable.

> Another tricky thing is that a container may be linked to multiple iommu
> domains in VFIO, as devices in the container may locate behind different
> IOMMUs with inconsistent capability (commit 1ef3e2bc). 

Frankly this sounds over complicated. I would think /dev/ioasid should
select the IOMMU when the first device is joined, and all future joins
must be compatible with the original IOMMU - ie there is only one set
of IOMMU capabilities in a /dev/ioasid.

This means qemue might have multiple /dev/ioasid's if the system has
multiple incompatible IOMMUs (is this actually a thing?) The platform
should design its IOMMU domains to minimize the number of
/dev/ioasid's required.

Is there a reason we need to share IOASID'd between completely
divergance IOMMU implementations? I don't expect the HW should be able
to physically share page tables??

That decision point alone might be the thing that just says we can't
ever have /dev/vfio/vfio == /dev/ioasid

> Just to confirm. Above flow is for current map/unmap flavor as what
> VFIO/vDPA do today. Later when nested translation is supported,
> there is no need to detach gpa_ioasid_fd. Instead, a new cmd will
> be introduced to nest rid_ioasid_fd on top of gpa_ioasid_fd:

Sure.. The tricky bit will be to define both of the common nested
operating modes.

  nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
  ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)

   // IOMMU will match on the device RID, no PASID:
  ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);

   // IOMMU will match on the device RID and PASID:
  ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);

Notice that ATTACH (or bind, whatever) is always done on the
vfio_device FD. ATTACH tells the IOMMU HW to link the PCI BDF&PASID to
a specific page table defined by an IOASID.

I expect we have many flavours of IOASID tables, eg we have normal,
and 'nested with table controlled by hypervisor'. ARM has 'nested with
table controlled by guest' right? So like this?

  nested_ioasid = ioctl(ioasid_fd, CREATE_DELGATED_IOASID,
                   gpa_ioasid_id, <some kind of viommu_id>)
  // PASID now goes to <viommu_id>
  ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);

Where <viommu_id> is some internal to the guest handle of the viommu
page table scoped within gpa_ioasid_id? Like maybe it is GPA of the
base of the page table?

The guest can't select its own PASIDs without telling the hypervisor,
right?

> I also feel hiding group from uAPI is a good thing and is interested in
> the rationale behind for explicitly managing group in vfio (which is
> essentially the same boundary as provided by iommu group), e.g. for 
> better user experience when group security is broken? 

Indeed, I can see how things might have just evolved into this, but if
it has a purpose it seems pretty hidden.
we need it or not seems pretty hidden.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
