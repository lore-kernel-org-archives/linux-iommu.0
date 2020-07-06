Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C5C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 20:45:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A460720663
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 20:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A460720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6A4C988CC9;
	Mon,  6 Jul 2020 20:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lfA503B0gfS7; Mon,  6 Jul 2020 20:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B83FF88C56;
	Mon,  6 Jul 2020 20:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4677C0891;
	Mon,  6 Jul 2020 20:45:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 173C1C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 20:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0661787700
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 20:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayQ-TyOw2f0y for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 20:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D174C876FF
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 20:45:33 +0000 (UTC)
IronPort-SDR: TfgHi4aSz/agfUtSHIlD4HG508hdnLP9cX821VGofSQ8v/S2QjbqVFTIo5Hqi9zgjFY7+tHUNt
 dVxgzsP1i3mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="232361342"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="232361342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 13:45:00 -0700
IronPort-SDR: HQ54mEMKCUzXtq6FROfHo3vaXufoIPMzRPsKg/rpfDrle+IpU136/OqxgQbpjZ8xi9avMS7PNv
 5eis0YU1APDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="357565889"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 06 Jul 2020 13:44:59 -0700
Date: Mon, 6 Jul 2020 13:51:37 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: IOASID set token
Message-ID: <20200706135137.26979271@jacob-builder>
In-Reply-To: <20200706103041.GA3214@myrica>
References: <20200701232916.38fd7908@jacob-builder>
 <20200702064825.20f9d2b1@jacob-builder>
 <20200706103041.GA3214@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Lu,
 Baolu" <baolu.lu@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
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

Hi Jean,
Thanks for the feedback, please see replies inline.

On Mon, 6 Jul 2020 12:30:41 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> On Thu, Jul 02, 2020 at 06:48:25AM -0700, Jacob Pan wrote:
> > Hi Jean,
> > 
> > Just realized I should send this to your Linaro account instead of
> > ARM. So Hi again :)
> > 
> > On Wed, 1 Jul 2020 23:29:16 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > Hi Jean,
> > > 
> > > Have a question for you on whether we can have a fixed token type
> > > for ioasid_set.
> > > 
> > > Currently, ioasid_set has an arbitrary token. For VT-d vSVA
> > > usage, we choose mm as ioasid_set token to identify PASIDs within
> > > a guest. We have multiple in-kernel users of PASIDs such as VFIO,
> > > KVM, and VDCM. When an IOASID set is created, there is not a good
> > > way to communicate about the token choices. So we have to let
> > > VDCM and KVM *assume* mm is used as token, then retrieve
> > > ioasid_set based on the token.
> > > 
> > > This assumption of "mm as token" is not a reliable SW
> > > architecture.  
> 
> I don't see this as a problem. The token type is tied to the IOASID
> set, so users that pass those IOASID sets to ioasid_find() can safely
> assume that the returned pointer is an mm_struct. That said I'm not
> opposed to consolidating the API with explicit types, it could
> definitely be more elegant.
> 
In our use case, we need token to ioasid_set lookup. e.g. VFIO creates
an ioasid_set with a token. KVM instance needs to know the
ioasid_set based on its mm. So ioasid_find() does not know the set
until it finds it based on the token and token type.
> > > So
> > > we are thinking if we can have an explicit ioasid_set token type
> > > where mm is used. After all, PASID and mm are closely related.
> > > 
> > > The code change might be the following:
> > > 1. add a flag to indicate token type when ioasid_set is allocated,
> > > e.g. IOASID_SET_TYPE_MM
> > > IOASID_SET_TYPE_ANY
> > > 2. other users of the ioasid_set can query if an mm token exists
> > > based on the flag IOASID_SET_TYPE_MM, then retrieve the
> > > ioasid_set.
> > > 
> > > Existing ioasid_set user can still use arbitrary token under the
> > > flag IOASID_SET_TYPE_ANY
> > > 
> > > Would this be an issue for ARM usage?  
> 
> In my current implementation of auxiliary domains for Arm SMMU (which
> might never be useful enough to go upstream) I don't even use a token
> for the private IOASID set. However I still think we should leave the
> option to use a type different than mm_struct as token for some
> IOASID sets because device drivers (e.g. AMD kfd) may also want to
> dip into the IOASID space and use their own token type.
> 
> For the moment, though, we could actually specialize the IOASID API to
> only take an mm_struct as token.
That would be fine with VT-d. We can use init_mm for host PASID set,
process mm for VM set.

> For example the functions exported
> by the IOASID lib would be:
> 
>   ioasid_t ioasid_alloc_mm(set, min, max, struct mm_struct *mm)
what is the set argument used for? In my view, ioasid_set and mm are
1:1 mapped.

struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota)


I was thinking we still have APIs for IOASID set alloc/free since we
want to embed ioasid_set info in driver data structures for ownership
check.

>   struct mm_struct *ioasid_find_mm(set, ioasid)
I don't get why we need ioasid to find the set token. If we put
mm_struct* inside ioasid_set, then we can get the token from the set
directly.

>   ...
> 
> And ioasid_alloc(), ioasid_find(), etc would be internal to ioasid.c
> and deal with IOASID_SET_TYPE_MM (or even be removed entirely for
> now). New users that need different token types could then introduce
> their own IOASID_SET_TYPE_* and use the lower-level functions.
> 
I will keep that in mind in my next set. I think it would be much
easier to explain with code.

My takeaway is that we have a high-level agreement to have explicit mm
as token in IOASID APIs. I think we can work out the details with
patches.

Jacob


> Thanks,
> Jean

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
