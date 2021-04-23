Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F65AC433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:49:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6687613CB
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6687613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C3494060B;
	Fri, 23 Apr 2021 11:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zqD0Mq45KhBw; Fri, 23 Apr 2021 11:49:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B07B403F8;
	Fri, 23 Apr 2021 11:49:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11706C000F;
	Fri, 23 Apr 2021 11:49:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDD3AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3BB160DAE
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G34ELi-x4Sek for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:49:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BED7460650
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWoe22lRH7X2DCpIvs0nuAK4Enmm/7W6rB59BGjVZq4MNu7SKCjMNWE8u9gFHYhevwXCm8DR7oEQb2DbnKmynR2/XhZWAX76CsHIZPRJy+c0Sh/rDrv0w0oo8dc4exduFIE5TK8fczV+/oejAVyQ+4ERoRoyR9O21V53rTjSTBjwLw+343a3MjaWezowfjQ2TVCvMsh88xC0HTHxHIVzayJl57+kTrN9GrYCkduvhhEuooO01fBbquvwXj57wRrznoTtFrDC87X+p0/3CpFpoTKsh9BHQN5X1tJxPikysNjzrADV8HgHHDo80wDHyHWcy/KladElaUsSHtKf71XkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjqj8DFTUQYaP+5cPIjgpWdEnqBxZ3mnBWfTOtXUvNw=;
 b=K0hAUmQowzzFX/1elIu47k0PM21W8LVopRvEfJrWn546qsLAxkH7OJxTmQgzuGgEPgCdBuXhsQ85EJRaD5yK+n14ePBO3vHMe2+GGNu2PsMEc42NBqJWxkRyGOUIcVuryZtgHmzHsybYEwQtEp1NMQ/k3WYe6BJ0o3bzyN0N/tN4MVQTFW9m/v7EzHF3zoFCSAkcKJ5YkV5EXo52PM80YIUC2cgYt6ht4WtR2gmTGe9brWNAXbukVn/3zhyRzVW1zueFDzycLqHr/eLHc+xHvejO7mESH3CpIXEJZUL23nCBv/V+xsTIAjZTJj87u5pMGmp26uua+MDQXuCp0HY1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjqj8DFTUQYaP+5cPIjgpWdEnqBxZ3mnBWfTOtXUvNw=;
 b=baPgaxSLOnl16tLJs1ZJCsGnEbqts+n7rWFKZiE/LlYRWFEcRcse0qjr55aaqxgdXs9WmH+BrY8PJjgi5go/eIhOGemIsvTOZCrX2Tht+bWJHvHUeh++W9i/hA2AVdeGIyCcEHTpw4nLaQ3Ayxf/0mQfLlALKrcdJmwAantzD7IBYhjExQyWTZaatZST4egXuHH4hzZD/J1AvwtV+s6/BVodsg7uYmKUtvAU8wPne7phLYTec7f395/FA90yJ7TQzfCDgrMZSVbFJgN0HNyI6/x1+MGsz04jQqZxGecB/qf8c6B+/pSkgEj/KlvA5+edHKdwypkeDOr4qqx5E5gE6A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 11:49:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 11:49:45 +0000
Date: Fri, 23 Apr 2021 08:49:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210423114944.GF1370958@nvidia.com>
References: <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:208:234::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR16CA0066.namprd16.prod.outlook.com (2603:10b6:208:234::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 11:49:45 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lZuJc-00AYC9-3F; Fri, 23 Apr 2021 08:49:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 128ad481-7a63-4bc8-e80d-08d9064de3ad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491E8805E8E428B7A98362FC2459@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WprJtdnuvXZhTnt9OvMfMVK/f/KHoqK/VuRiOOdRboq1wJNSaC8Gl9fwh0AV/5aaxNYHjKjJJ5mysuxSdsaw4n2aXipKVSQyjnB0cbIIaQxbRETT7om5YP82swjJDmXZ4VIJbHdR6qi3o8wXP5uDufNPJs7GKiN1ESSOpMrw7TvrDOLe1OrG0ELJJ2H71urRWbUeQ44n9zIx7EgNRryQWZ2lygCl5Skt3hIyhCW4ju3CDivjhueuwwnSTK37r0ZQiTHvuPo7ygKB17OxmzZbmNsQMawKeByRIGNzKz9QSze8wTZcKLM4ljCwO8kebg6vms2c8qIqN0PUKjlTRvpMKwDwwR+Odwphz2GgkXMzGCvWAL0MA1M5X4JOaTzZFzI+XaTHjP+mDuPFlG3U+yP/vg3NvwAj1DyRSSM12y/qX5mYmAf7khDhtk7sIVYIkvlc0+i6B5la2q4jkIirluv29o4ZhQFF8zrn/y5we0uh6xyUzdv6vHII4vg1Dyfo2kyhu15Ow9QlP8CHu6uAlyGLGruRm8if1DWEgfFpfCycBhR1HtexWfxdSuhgeTuTzca/tYZqjeFy9YXLfr3RXMEOWQ4VDWB+2VaBDngqgam+BlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8936002)(2616005)(2906002)(86362001)(33656002)(9786002)(36756003)(66946007)(9746002)(66476007)(5660300002)(26005)(6916009)(38100700002)(66556008)(4326008)(1076003)(8676002)(186003)(426003)(478600001)(54906003)(316002)(7416002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4vC4ja0aBV4MJoZWAMsyvE2WjHlKH24JGoibu2Yf72FvaHHI+UVV+L8TVV5O?=
 =?us-ascii?Q?Vuj08GBltUaPqwGeG9yjtyql6ionJG/L6O/ouWRpNAI03akLWD2nZXIZwMbw?=
 =?us-ascii?Q?FTEavADNZuowmv+almEI5sXqW0TAu6B6nhaXdLQ/ulQSlbpMFDQBgCqtvXBq?=
 =?us-ascii?Q?qYEwu2wvsYIJ+0pCI7vumMfzkD8aWxf3J059XdD7TPrkHoL8jZ8oXVdsmAAT?=
 =?us-ascii?Q?dDfqsVDAoPadED4Um5iiN/pcB+bMvfyuzCNFXgupZ3AYuDcxvzLdcsE/l57D?=
 =?us-ascii?Q?9K5JfnkBsLa8bOadvDs90FFIWOzYAXfePXwGHyWETTegeaCcXJ+TZ7EvoMlH?=
 =?us-ascii?Q?Zo4sD+IsD3Ps2EzBwHrRfZVUHhkx7+P5x6bIKPSaBI49MHPu9905mHWWjOcL?=
 =?us-ascii?Q?gkPY/8Uc/5VnjOiGA9y+5nmsF+mbCG/3+BYQsTSQ4IGVi4xFRz8MwfJH07vi?=
 =?us-ascii?Q?w49Jnca/6licAssKru+dH8noOxifTMaHDG/wHW3ixpr5etywbPInPchProSO?=
 =?us-ascii?Q?IRjlTQD/NHe0ViGezVTgXkWN2RmNA/m5C9u8bxqf9QI8mw5Mlqel8W2da7Bh?=
 =?us-ascii?Q?YVmKi76Zz1UpX9lAgcrBfycNVQvZreTw5bbNM7JaPshra0P6NaUxbP2VIN9I?=
 =?us-ascii?Q?Xnecsby2WV8O/HCvPG8XjlZPjFE+Hjzemd8RKUaEim5KIoTQvl8B3ciBSdwr?=
 =?us-ascii?Q?Ymkp7sAtlXTxtg7GRq0QMqrraW6udcgMlMRcfV+chnDqUFbRLG3pqonGCJ7k?=
 =?us-ascii?Q?6ehK1RdPfLDKXOW24IBpz/B8fGNuYsOEqG7jnkxNgWMMdy+hEwh9oYkwUc/R?=
 =?us-ascii?Q?zX94b+1lvJ6WFy7x/3K1BrI5olCJGQj+Q96H53dZsfcuixdyMNB4wVn3vDNd?=
 =?us-ascii?Q?JftQQ1Vwr9KU0mwrrYCL4fv7ydmivudgU/BwA3VORP0LxpoPRSvBqOfTM7ap?=
 =?us-ascii?Q?oOrtWI3sRz7JPUozZSaYiSfiiXFA+j/hA7mZSkESFgKGwKfC0B0sdaBAfzq7?=
 =?us-ascii?Q?neUXwQZ1/NcgIbEVLHBogAGtitpF+nZhTSYOS6x5VRdrSATtX8FDq9bDEDt9?=
 =?us-ascii?Q?JeiixqIXIzi45E9YqU19oBFsUneSJE9Qpxulop0XZUXkoBEOI6tKwbrd+F8R?=
 =?us-ascii?Q?jw663tFSG69AAcyQ8UIPODHueENEdWbbY0fbc4eGkTdZrmnSp45rm1WPNpQd?=
 =?us-ascii?Q?rPfJ+ZBbHTqip3fR7Q6zUKtCiklxPUtmPQEEuRipkKCFzj/EJOJ9QSndixZr?=
 =?us-ascii?Q?jjd835rjWsFWeVChqNgC/SHigyGwSu95fUsE45bh7dPQrJTRvf88ICUp/2LZ?=
 =?us-ascii?Q?vn0cfJ137DDR82tzj9QbmhYw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128ad481-7a63-4bc8-e80d-08d9064de3ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:49:45.5407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E892v6RIF2GomasQlJsJ5zadLj08uZyMJsQOWtwdqI7864QvVd+dbag60zOoTq67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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

On Fri, Apr 23, 2021 at 09:06:44AM +0000, Tian, Kevin wrote:

> Or could we still have just one /dev/ioasid but allow userspace to create
> multiple gpa_ioasid_id's each associated to a different iommu domain? 
> Then the compatibility check will be done at ATTACH_IOASID instead of 
> JOIN_IOASID_FD.

To my mind what makes sense that that /dev/ioasid presents a single
IOMMU behavior that is basically the same. This may ultimately not be
what we call a domain today.

We may end up with a middle object which is a group of domains that
all have the same capabilities, and we define capabilities in a way
that most platforms have a single group of domains.

The key capability of a group of domains is they can all share the HW
page table representation, so if an IOASID instantiates a page table
it can be assigned to any device on any domain in the gruop of domains.

If you try to say that /dev/ioasid has many domains and they can't
have their HW page tables shared then I think the implementation
complexity will explode.

> This does impose one burden to userspace though, to understand the 
> IOMMU compatibilities and figure out which incompatible features may
> affect the page table management (while such knowledge is IOMMU
> vendor specific) and then explicitly manage multiple /dev/ioasid's or 
> multiple gpa_ioasid_id's.

Right, this seems very hard in the general case..
 
> Alternatively is it a good design by having the kernel return error at
> attach/join time to indicate that incompatibility is detected then the 
> userspace should open a new /dev/ioasid or creates a new gpa_ioasid_id
> for the failing device upon such failure, w/o constructing its own 
> compatibility knowledge?

Yes, this feels workable too

> > This means qemue might have multiple /dev/ioasid's if the system has
> > multiple incompatible IOMMUs (is this actually a thing?) The platform
> 
> One example is Intel platform with igd. Typically there is one IOMMU
> dedicated for igd and the other IOMMU serving all the remaining devices.
> The igd IOMMU may not support IOMMU_CACHE while the other one
> does.

If we can do as above the two domains may be in the same group of
domains and the IOMMU_CACHE is not exposed at the /dev/ioasid level.

For instance the API could specifiy IOMMU_CACHE during attach, not
during IOASID creation.

Getting all the data model right in the API is going to be trickiest
part of this.

> yes, e.g. in vSVA both devices (behind divergence IOMMUs) are bound
> to a single guest process which has an unique PASID and 1st-level page
> table. Earlier incompatibility example is only for 2nd-level.

Because when we get to here, things become inscrutable as an API if
you are trying to say two different IOMMU presentations can actually
be nested.

> > Sure.. The tricky bit will be to define both of the common nested
> > operating modes.
> > 
> >   nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
> >   ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)
> > 
> >    // IOMMU will match on the device RID, no PASID:
> >   ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);
> > 
> >    // IOMMU will match on the device RID and PASID:
> >   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
> 
> I'm a bit confused here why we have both pasid and ioasid notations together.
> Why not use nested_ioasid as pasid directly (i.e. every pasid in nested mode
> is created by CREATE_NESTED_IOASID)?

The IOASID is not a PASID, it is just a page table.

A generic IOMMU matches on either RID or (RID,PASID), so you should
specify the PASID when establishing the match.

IOASID only specifies the page table.

So you read the above as configuring the path

  PCI_DEVICE -> (RID,PASID) -> nested_ioasid -> gpa_ioasid_id -> physical

Where (RID,PASID) indicate values taken from the PCI packet.

In principle the IOMMU could also be commanded to reuse the same
ioasid page table with a different PASID:

  PCI_DEVICE_B -> (RID_B,PASID_B) -> nested_ioasid -> gpa_ioasid_id -> physical

This is impossible if the ioasid == PASID in the API.

> Below I list different scenarios for ATTACH_IOASID in my view. Here 
> vfio_device could be a real PCI function (RID), or a subfunction device 
> (RID+def_ioasid). 

What is RID+def_ioasid? The IOMMU does not match on IOASID's.

A subfunction device always need to use PASID, or an internal IOMMU,
confused what you are trying to explain?

> If the whole PASID table is delegated to the guest in ARM case, the guest
> can select its own PASIDs w/o telling the hypervisor. 

The hypervisor has to route the PASID's to the guest at some point - a
guest can't just claim a PASID unilaterally, that would not be secure.

If it is not done with per-PASID hypercalls then the hypervisor has to
route all PASID's for a RID to the guest and /dev/ioasid needs to have
a nested IOASID object that represents this connection - ie it points
to the PASID table of the guest vIOMMU or something.

Remember this all has to be compatible with mdev's too and without
hypercalls to create PASIDs that will be hard: mdev sharing a RID and
slicing the physical PASIDs can't support a 'send all PASIDs to the
guest' model, or even a 'the guest gets to pick the PASID' option.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
