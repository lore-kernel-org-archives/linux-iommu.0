Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D5C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:34:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D6F613E9
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6F613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14396401D0;
	Thu,  3 Jun 2021 12:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSyRwjf43rXk; Thu,  3 Jun 2021 12:34:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B75D3400B6;
	Thu,  3 Jun 2021 12:34:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56F4CC000D;
	Thu,  3 Jun 2021 12:34:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00998C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E09E5401FE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8QIadUcvpJgb for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 12:34:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC88F400B6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGEF1PVz/SFhDDPVH42eGUildS2tscnmezS3spsoTpAdiT8KeDf12XVK2Zs6q3wXwSKtoraZvRnUnjsxV+K6y8eIsjB4VbG44zliEB7w5CdeF8aI5houFBla/TK6Kfok/HmU0e/TpFsjKhMprwzl5CnJ9qVX0Inzt/jtH8IYdS+Rk5Skg0gWH/t96hooHKxqijq7WuMXvbElGatkI0h2VWsS9NdV51pd6c7Hlj5h99Ea9ULlxyLQKxPdjvYG+bEsAwWeoIVP9VOOU7EwNmwS4f7GSYmQrlTBXfHadWpeDOC7Ak7NYK95p8dMNTz9C/MRCGUVvcgGDENVmDy8tHGC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNbPehNfSCymfId4XnkPkE8oIlGF59oRmSNqoNesBjU=;
 b=O8F2WDg1XKmk/u+cIaw96XEqohOrnRKAcFx5JFkzyc0A8BCDMcaBUiWhKL1Bq5Eup/7bQPGKFBxuc1vMdueF+KErnE+I6vvwP68LBRwOFYNsXcuHWQLCtmg3edXte+ipo4DvglhFB3RA2370cBvP0FuZFNfqtK7FcpcAJoHB/py/vSIS3EIxbQSnC1vxPPUsbGGUTQHH4+yCwTj+YgS+fd6rSyKS5nJYmKzeGaYV0nBNMc0Qhio5dSmXuvK1g+RBQ0yyHY6QeYmCmUZ3W7zv361VZGdi7n7Ng0juTqLN8GIHoMcn0mJAKFGNfyWYQcbqG/4IwsMV7/kol+I8WL3i/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNbPehNfSCymfId4XnkPkE8oIlGF59oRmSNqoNesBjU=;
 b=OxZLSbOAs10JW189nH+Ad//IcimXxU8e6KCCTdQwdENovmzEWS0t9E3bXTzJcw+k4YfDVbeJSuTqY1YOTALSTaw4Lsmy3NkSq/4dGAsQH5DsayRUf2ceBplS9qScaggo2yw5bVutjr7ft1VFABJv2nCOc7wygRUTkPxrvWNQ2YrF2DXkROyV6c04QKY/2ulEAVam0d3+gwwB21IgoJ1EGjZoCBC+BGO5anJCP5W/ufjRzeMlLf66jqx8MRsS7sJ0p/bRBf+tuAw/bOrwCxH1GxTpnz6xjMyTVxZCerHszz+AGfyx0G190b26LySMXTDaZVDs6a5u//Saocx8MCcqUQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 3 Jun
 2021 12:34:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 12:34:02 +0000
Date: Thu, 3 Jun 2021 09:34:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603123401.GT1002214@nvidia.com>
References: <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20210602205054.3505c9c3.alex.williamson@redhat.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR04CA0031.namprd04.prod.outlook.com (2603:10b6:208:d4::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 12:34:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lomXx-0014mL-PB; Thu, 03 Jun 2021 09:34:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f2a8a0a-02ca-4817-741b-08d9268bdea2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55566D878B821914BABF2F13C23C9@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFIuvpFvOWdTNnsVF8pI+1s7SoghnMyEkf8XFe8hFnTBfPj+kfXSprKIZuLRxsqYCgp6M9lGUaAINtF/CWKC1d4Imvp6xmQQYGo/cIHW4syHSwgwe+bTSZEa/B6p8W5/eSDbHqlncrvDZOla1mzXYYp2d2xsPczX2RNF0IUXp8zWF7mFqDYRKXhvyLN3qhqeBu4R+0pkJTh8aYxPYdg8tsC8jlDsce+sEfkFYQv8rtGHcJHwwpZeGNS29BPZrawFtrWFGLXpG7abZ4l6fJeAojltEn0AiD9UcYqRI2LkghOeuj6FWVIF+cmDORQM72r+tJpZnwvgChuqbFq262QpYXBpLlQOAFy5caj3jh/vZ8sVAis/aRtoONDL22NdmXcVBCw5fiT0GzTICyYcF1muUeAGPSW5HorhWK4D0Psncznq8YDDi29fFvhU2KhLbPQHArkIW6unhpFOX9URHMIRdMR+xR4UipzDAFKk1VGpvqC0UdKd5yaoJ+tJjF6qM8gcQyH7trgzf4+hvYBVXzo36U4+vOR/qMuSJYkSOjS6yTZ4lEhwFJfrCd6+Cm/60UhPrJ+MAyePF0ZUuuyzptPVzPjl9DMxtvst7gMXHUWKVV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(54906003)(1076003)(9786002)(2616005)(9746002)(86362001)(316002)(33656002)(38100700002)(36756003)(83380400001)(478600001)(2906002)(8936002)(26005)(186003)(426003)(8676002)(4326008)(5660300002)(6916009)(66946007)(66556008)(7416002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oOinwhtsI4HHoMlUOdHyNkSDQGUHE9SIQ+q5xUBY+RS6sYQzr58+TqHlX9cW?=
 =?us-ascii?Q?hB+WHwAPbJ9CiSanw6hL8+mpf9QomHJbv59TjMPZA/2rrjzuF9/ZpRaB9+lJ?=
 =?us-ascii?Q?gNa2ukBXz0OgzeT8v8FDj+jepshd0msUwy3K0qNh4VceCSwENUmvKSaSQvJk?=
 =?us-ascii?Q?OjL4YtfchrkE061z4ys0oE2dpCiuT9Yrobr49Lm552zJ1vExXhM5letB2yQ7?=
 =?us-ascii?Q?4NheP7G+/GYegWm3m1jzQ5BYRhVjz/OzwaHd9svx1GNa0xWCFaecmK6i/YqG?=
 =?us-ascii?Q?Zx6wAJPJNmStqx3WIVYy6YEI7o4vQrHP00szz8tp1t1+kc+tbr9BQU65AM4S?=
 =?us-ascii?Q?5of39EgPETYv8Jz5BHSXVBNzPb8VqX+youqfXmto42Fayw4gnY8lv9lOvHox?=
 =?us-ascii?Q?vLyoxz7qgDnqUtEOnvZO9khuqhs8P4s/r9127p3LpqhKQJTEFZpQuysk+zW8?=
 =?us-ascii?Q?D2o4UauGr4Kp/3T8rer/49xy6nkyc6h0i8gti4u/cYs4OsK/8Hdbqdh2UVvj?=
 =?us-ascii?Q?bncYBp73aR9dbIbA7fLEpEmQYrXFT7CwU/YO0zv1/H1P4kIgYuyEAoyc29Bk?=
 =?us-ascii?Q?BovMMiHz3EcXmPd2frcBtheeb19X7CCNvC1G8KkxijAhPKhZtUJNFcuhfSsh?=
 =?us-ascii?Q?xALWlhqpKl+GYlZ9XdaiQuaQRr+aTCxJufwB07YsOzDySWdgCFwqLe9vDenj?=
 =?us-ascii?Q?RhfAw/ppegWlSpDwcbqXavjRTOAtUQaKlB53Kjy/RVaIdTPMRnMkM7ZAqfFs?=
 =?us-ascii?Q?D+jcn08wEmSomk2mRgaBHTWT4VCW0aiO/sMbIVoHgmoicDMbxdC91xniaSyo?=
 =?us-ascii?Q?u2e4uEqaA/YSMIvm2UOLPmYO9FPSaFtgd4XiGigJm+dCCEynOgQiZbBDXk5t?=
 =?us-ascii?Q?rJk0wEBCkqDIeuWR9ShedFfFNJyn5CN7ZyDpckw9zmXEQaFV1ognEaEk3St5?=
 =?us-ascii?Q?xmuVn3G5NJfAVJLDZefd8pMds/Exmfrn5/Ean6cXPQTGjo2UEH6DbeKE0Cfy?=
 =?us-ascii?Q?ifNqgaP0e4F+O/rQ1nTMgcVgSMm1WEaE19DWn0qeTdwZUvcqIMPU1xQnAKtQ?=
 =?us-ascii?Q?PN3hzqzqupqA3MbCHEAUkWlKIMsEPFBXSABWxKP8PAsJjDUw/haLRDbOwYOT?=
 =?us-ascii?Q?2laFGjM4fRGs3szRzmSCoING6wX7WqJOXJ9XW3e2AYVoA8Zn8P0o2fcxmcYe?=
 =?us-ascii?Q?p/pGqazI76FUkB7ri9pxvzB56ftzBoF7qTcl6XhDmYlGbFEJI86F3BeNdLDv?=
 =?us-ascii?Q?YOIA0R6qvNrKvCnNw6EACn4zTRErZnYvngpYGADaPHY6j7swYAuicMOfbfXP?=
 =?us-ascii?Q?7KolHWmloH5MtjEUDKG2ER2W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2a8a0a-02ca-4817-741b-08d9268bdea2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 12:34:02.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC0gA7EcHcrRAyZaO2aCir3/hgtCUXY2je2hsDgC4/XjPDif0sshPFW4QckMVoCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, Jun 02, 2021 at 08:50:54PM -0600, Alex Williamson wrote:
> On Wed, 2 Jun 2021 19:45:36 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Jun 02, 2021 at 02:37:34PM -0600, Alex Williamson wrote:
> > 
> > > Right.  I don't follow where you're jumping to relaying DMA_PTE_SNP
> > > from the guest page table... what page table?    
> > 
> > I see my confusion now, the phrasing in your earlier remark led me
> > think this was about allowing the no-snoop performance enhancement in
> > some restricted way.
> > 
> > It is really about blocking no-snoop 100% of the time and then
> > disabling the dangerous wbinvd when the block is successful.
> > 
> > Didn't closely read the kvm code :\
> > 
> > If it was about allowing the optimization then I'd expect the guest to
> > enable no-snoopable regions via it's vIOMMU and realize them to the
> > hypervisor and plumb the whole thing through. Hence my remark about
> > the guest page tables..
> > 
> > So really the test is just 'were we able to block it' ?
> 
> Yup.  Do we really still consider that there's some performance benefit
> to be had by enabling a device to use no-snoop?  This seems largely a
> legacy thing.

I've recently had some no-snoopy discussions lately.. The issue didn't
vanish, it is still expensive going through all that cache hardware.

> > But Ok, back the /dev/ioasid. This answers a few lingering questions I
> > had..
> > 
> > 1) Mixing IOMMU_CAP_CACHE_COHERENCY and !IOMMU_CAP_CACHE_COHERENCY
> >    domains.
> > 
> >    This doesn't actually matter. If you mix them together then kvm
> >    will turn on wbinvd anyhow, so we don't need to use the DMA_PTE_SNP
> >    anywhere in this VM.
> > 
> >    This if two IOMMU's are joined together into a single /dev/ioasid
> >    then we can just make them both pretend to be
> >    !IOMMU_CAP_CACHE_COHERENCY and both not set IOMMU_CACHE.
> 
> Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then we
> need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
> available based on the per domain support available.  That gives us the
> most consistent behavior, ie. we don't have VMs emulating wbinvd
> because they used to have a device attached where the domain required
> it and we can't atomically remap with new flags to perform the same as
> a VM that never had that device attached in the first place.

I think we are saying the same thing..
 
> > 2) How to fit this part of kvm in some new /dev/ioasid world
> > 
> >    What we want to do here is iterate over every ioasid associated
> >    with the group fd that is passed into kvm.
> 
> Yeah, we need some better names, binding a device to an ioasid (fd) but
> then attaching a device to an allocated ioasid (non-fd)... I assume
> you're talking about the latter ioasid.

Fingers crossed on RFCv2.. Here I mean the IOASID object inside the
/dev/iommu FD. The vfio_device would have some kref handle to the
in-kernel representation of it. So we can interact with it..

> >    Or perhaps more directly: an op attaching the vfio_device to the
> >    kvm and having some simple helper 
> >          '(un)register ioasid with kvm (kvm, ioasid)'
> >    that the vfio_device driver can call that just sorts this out.
>
> We could almost eliminate the device notion altogether here, use an
> ioasidfd_for_each_ioasid() but we really want a way to trigger on each
> change to the composition of the device set for the ioasid, which is
> why we currently do it on addition or removal of a group, where the
> group has a consistent set of IOMMU properties.

That is another quite good option, just forget about trying to be
highly specific and feed in the /dev/ioasid FD and have kvm ask "does
anything in here not enforce snoop?"

With something appropriate to track/block changing that answer.

It doesn't solve the problem to connect kvm to AP and kvmgt though

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
