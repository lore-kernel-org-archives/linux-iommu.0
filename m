Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E346C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 10:07:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E39A20708
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNl6gBuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E39A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E8895279B5;
	Tue,  7 Jul 2020 10:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0w13zBZ05cBv; Tue,  7 Jul 2020 10:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2FBDE263A6;
	Tue,  7 Jul 2020 10:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21294C0893;
	Tue,  7 Jul 2020 10:07:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30565C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 10:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A688897E8
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 10:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id roe6FUSU2TNg for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 10:07:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15A0A89416
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 10:07:32 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id l12so45935429ejn.10
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wCpbv62+yMX4FJ0XBvHSc2iFIW/4H9k7XcVu4j2lc2o=;
 b=KNl6gBuoNX73MjSLFPMc0QM7l/lhtDaulibDM9BzuunxngKwiuzf3FRwoOHIwVXv9Q
 VSk49wzl2oQ5WJUoICsGXUjx2nKniy0/wA06hfDKTHl7RewJJWFc/fARHFeuebs6544w
 Y6z/jPE9OhoEAkwMT4Ev6bHKR6W7CWMqxGIQpO7GM9I2rSB7X5OwzGAgbcetdD0P/4mT
 /dWs9/AxU+dHhiArzBng9A4o8QtSiTf3ze5HfGmxRrfmsNC7D45LEqymQoXvcjDzleFu
 C67YaGtA+yjFb6uUbshC1Xya09k9OACc6FQ3HVCJIaQIbfzrZSUli0QeMzz8mHKdiGDT
 oV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wCpbv62+yMX4FJ0XBvHSc2iFIW/4H9k7XcVu4j2lc2o=;
 b=pb6AdFKxTELAEpt1uiX7+0N5u4mFeCAbrUkawTvGOsjK5g0jKXoWxM1oT4GzJ8kh9u
 DSkPC+cN6agha2nvY8mme1T7ARP2Ik+CjzPk6Ah+JoWoG4QWnyQ3oBNly07yhIy8BT76
 3J0byUvosSVRDespnQdro45DsioR6rOlX048zX3RSeAXgv7hlgjSJAQ/gHQTrMbw8UBS
 WGCFHnEgtVcG2hYeYoXNhjxfzlU8zt45NqHbvVo/vHQvDSAY9xoO+OWldD2uINrQFtUh
 SbBKZ1UK9naLEFUE1oh8AJf44uG1aTXmHmCSOPTg+5ScBRPgC5+DHI2OjnzJuyAe0G3A
 6Ezg==
X-Gm-Message-State: AOAM532rdZeT8OwwhaxOxx1Wc/Fk/f3SS+dK8DXjARJWX6ADCOaAOlyW
 5k6He34rK8ZKiNYwyQCoinR9Og==
X-Google-Smtp-Source: ABdhPJxg2TXTMvFYCqyoD9XbQeofiRcL6Z9waiBmyCDeDEbgDnWxczCOAlJmpkXgOahwAFfpIHvA7A==
X-Received: by 2002:a17:906:4d4c:: with SMTP id
 b12mr45785790ejv.506.1594116450219; 
 Tue, 07 Jul 2020 03:07:30 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b18sm127945ejl.52.2020.07.07.03.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:07:29 -0700 (PDT)
Date: Tue, 7 Jul 2020 12:07:18 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: IOASID set token
Message-ID: <20200707100718.GA151594@myrica>
References: <20200701232916.38fd7908@jacob-builder>
 <20200702064825.20f9d2b1@jacob-builder>
 <20200706103041.GA3214@myrica>
 <20200706135137.26979271@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706135137.26979271@jacob-builder>
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

On Mon, Jul 06, 2020 at 01:51:37PM -0700, Jacob Pan wrote:
> Hi Jean,
> Thanks for the feedback, please see replies inline.
> 
> On Mon, 6 Jul 2020 12:30:41 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Hi Jacob,
> > 
> > On Thu, Jul 02, 2020 at 06:48:25AM -0700, Jacob Pan wrote:
> > > Hi Jean,
> > > 
> > > Just realized I should send this to your Linaro account instead of
> > > ARM. So Hi again :)
> > > 
> > > On Wed, 1 Jul 2020 23:29:16 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > >   
> > > > Hi Jean,
> > > > 
> > > > Have a question for you on whether we can have a fixed token type
> > > > for ioasid_set.
> > > > 
> > > > Currently, ioasid_set has an arbitrary token. For VT-d vSVA
> > > > usage, we choose mm as ioasid_set token to identify PASIDs within
> > > > a guest. We have multiple in-kernel users of PASIDs such as VFIO,
> > > > KVM, and VDCM. When an IOASID set is created, there is not a good
> > > > way to communicate about the token choices. So we have to let
> > > > VDCM and KVM *assume* mm is used as token, then retrieve
> > > > ioasid_set based on the token.
> > > > 
> > > > This assumption of "mm as token" is not a reliable SW
> > > > architecture.  
> > 
> > I don't see this as a problem. The token type is tied to the IOASID
> > set, so users that pass those IOASID sets to ioasid_find() can safely
> > assume that the returned pointer is an mm_struct. That said I'm not
> > opposed to consolidating the API with explicit types, it could
> > definitely be more elegant.
> > 
> In our use case, we need token to ioasid_set lookup. e.g. VFIO creates
> an ioasid_set with a token. KVM instance needs to know the
> ioasid_set based on its mm. So ioasid_find() does not know the set
> until it finds it based on the token and token type.

Right, I mixed up "token" with the private data associated with each
IOASID. I had mostly forgotten about the principles you introduced in the
"IOASID extensions for guest SVA" series, sorry for the confusion.

> > > > So
> > > > we are thinking if we can have an explicit ioasid_set token type
> > > > where mm is used. After all, PASID and mm are closely related.
> > > > 
> > > > The code change might be the following:
> > > > 1. add a flag to indicate token type when ioasid_set is allocated,
> > > > e.g. IOASID_SET_TYPE_MM
> > > > IOASID_SET_TYPE_ANY
> > > > 2. other users of the ioasid_set can query if an mm token exists
> > > > based on the flag IOASID_SET_TYPE_MM, then retrieve the
> > > > ioasid_set.
> > > > 
> > > > Existing ioasid_set user can still use arbitrary token under the
> > > > flag IOASID_SET_TYPE_ANY
> > > > 
> > > > Would this be an issue for ARM usage?  
> > 
> > In my current implementation of auxiliary domains for Arm SMMU (which
> > might never be useful enough to go upstream) I don't even use a token
> > for the private IOASID set. However I still think we should leave the
> > option to use a type different than mm_struct as token for some
> > IOASID sets because device drivers (e.g. AMD kfd) may also want to
> > dip into the IOASID space and use their own token type.
> > 
> > For the moment, though, we could actually specialize the IOASID API to
> > only take an mm_struct as token.
> That would be fine with VT-d. We can use init_mm for host PASID set,
> process mm for VM set.

I'm not fond of using init_mm for the host PASID set. Does it need a token
at all?

> 
> > For example the functions exported
> > by the IOASID lib would be:
> > 
> >   ioasid_t ioasid_alloc_mm(set, min, max, struct mm_struct *mm)
> what is the set argument used for? In my view, ioasid_set and mm are
> 1:1 mapped.

Please disregard this, it was replacing the void* argument of
ioasid_alloc() with an mm_struct.

> struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota)
> 
> 
> I was thinking we still have APIs for IOASID set alloc/free since we
> want to embed ioasid_set info in driver data structures for ownership
> check.
> 
> >   struct mm_struct *ioasid_find_mm(set, ioasid)
> I don't get why we need ioasid to find the set token. If we put
> mm_struct* inside ioasid_set, then we can get the token from the set
> directly.

Same here, this was replacing the void* returned by ioasid_find() with an
mm_struct.

> 
> >   ...
> > 
> > And ioasid_alloc(), ioasid_find(), etc would be internal to ioasid.c
> > and deal with IOASID_SET_TYPE_MM (or even be removed entirely for
> > now). New users that need different token types could then introduce
> > their own IOASID_SET_TYPE_* and use the lower-level functions.
> > 
> I will keep that in mind in my next set. I think it would be much
> easier to explain with code.
> 
> My takeaway is that we have a high-level agreement to have explicit mm
> as token in IOASID APIs. I think we can work out the details with
> patches.

Yes I think it would be easier to discuss with code.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
