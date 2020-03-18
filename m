Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23665C4332D
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 23:43:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D889520768
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 23:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3FPub1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D889520768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A958187767;
	Wed, 18 Mar 2020 23:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8JxqGm+Qvf7; Wed, 18 Mar 2020 23:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8276187750;
	Wed, 18 Mar 2020 23:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D193C1799;
	Wed, 18 Mar 2020 23:43:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1F01C087F
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 23:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF3C7882F6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 23:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tunGIjiSE6fD for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 23:43:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB44087CC9
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 23:43:19 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id b21so326982edy.9
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 16:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T6rxV8z4faDRzhqK467Xv2a7dOy/TE520C3YV3WjV8c=;
 b=i3FPub1DIHkvCD+yi/2Y0pX69MrTIvO1RmbzVf6wk00DV0ApmY13YfnnFpks/NVTLs
 G1QplMy/+0w+GsFrwD1fV1STvoKneEr8NQlSW0vIhii6MAK+xDn8ddbmfxyIfh+bWkPE
 NEeRdRZ2QE6MO1YpPwSPzXvQKexEK5sr8Dox9C9jyfSyvqP6X6trr48Ms86RoFLn9dAG
 92zK1vRSIdLYDibQabEa5foOn7Ajn4QGZfbFS6XCk1yr6R/d+WaM4jqJ31uE4ljyQmMb
 YiomgNSyyErYriEW6Abwe6sruyYqTy62RHKzpwUnN7Vinym7R/FBnsL8LzowJAa3l8q2
 3Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T6rxV8z4faDRzhqK467Xv2a7dOy/TE520C3YV3WjV8c=;
 b=t7JOCVxir1YDvWpuzePISXRJKtrpuPs0iN3FO2pmdgGMTPk2e/Xvq95elyL9SJLLOc
 rRzQ0fYETw7HeHNtjsfdj2tAK3PmzzVewsysbB/kesyK68wKRp5mzk/XMYEpB0rzel+o
 Bini/Jirc2N97SmE3fsXkmES09OxrcjaGTwSNJslcWrSGOKg/KEEfLYMTU5uzb4WLI3g
 CGZ66JzSP1a46wgE8IstgfVl9db1IyF2EfEtJtDUu1nbAejjiW4U4PJ6LBf/dhVFXXmX
 Y0n6ivqBysmxoTCTlUr7g2tyG6dp5S7Xvy30BLDBhmU2yoMLtUFAHQI1HA51i611PcKC
 pUOA==
X-Gm-Message-State: ANhLgQ1oa02/zcO+1ZhJUA33Cl3Hah6yUQZfY3AWrlk9m/FhmK2okj0+
 n32ByNJXwNB8UxcHLnJ/x+8oaDGHncV7dp/B+no=
X-Google-Smtp-Source: ADFU+vunbg/mabJAoT4ECckSo9VlWXEI7Tk7MCM2NEIzGX//dTyumqWFksHG62C18XwPsVHwF/wqELk+aHHpZR6UYqI=
X-Received: by 2002:a17:906:b888:: with SMTP id
 hb8mr686525ejb.166.1584574997823; 
 Wed, 18 Mar 2020 16:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
In-Reply-To: <20200318224840.GA10796@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 18 Mar 2020 16:43:07 -0700
Message-ID: <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
To: Will Deacon <will@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, Mar 18, 2020 at 3:48 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jan 28, 2020 at 03:16:06PM -0700, Jordan Crouse wrote:
> > Support auxiliary domains for arm-smmu-v2 to initialize and support
> > multiple pagetables for a single SMMU context bank. Since the smmu-v2
> > hardware doesn't have any built in support for switching the pagetable
> > base it is left as an exercise to the caller to actually use the pagetable.
> >
> > Aux domains are supported if split pagetable (TTBR1) support has been
> > enabled on the master domain.  Each auxiliary domain will reuse the
> > configuration of the master domain. By default the a domain with TTBR1
> > support will have the TTBR0 region disabled so the first attached aux
> > domain will enable the TTBR0 region in the hardware and conversely the
> > last domain to be detached will disable TTBR0 translations.  All subsequent
> > auxiliary domains create a pagetable but not touch the hardware.
> >
> > The leaf driver will be able to query the physical address of the
> > pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> > address with whatever means it has to switch the pagetable base.
> >
> > Following is a pseudo code example of how a domain can be created
> >
> >  /* Check to see if aux domains are supported */
> >  if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> >        iommu = iommu_domain_alloc(...);
> >
> >        if (iommu_aux_attach_device(domain, dev))
> >                return FAIL;
> >
> >       /* Save the base address of the pagetable for use by the driver
> >       iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
> >  }
>
> I'm not really understanding what the pagetable base gets used for here and,
> to be honest with you, the whole thing feels like a huge layering violation
> with the way things are structured today. Why doesn't the caller just
> interface with io-pgtable directly?
>
> Finally, if we need to support context-switching TTBR0 for a live domain
> then that code really needs to live inside the SMMU driver because the
> ASID and TLB management necessary to do that safely doesn't belong anywhere
> else.

Hi Will,

We do in fact need live domain switching, that is really the whole
point.  The GPU CP (command processor/parser) is directly updating
TTBR0 and triggering TLB flush, asynchronously from the CPU.

And I think the answer about ASID is easy (on current hw).. it must be zero[*].

BR,
-R

[*] my rough theory/plan there, and to solve the issue with drm/msm
getting dma-iommu ops when it really would rather not (since
blacklisting idea wasn't popular and I couldn't figure out a way to
deal with case where device gets attached before driver shows up) is
to invent some API that drm/msm can call to unhook the dma-iommu ops
and detatch the DMA domain.  Hopefully that at least gets us closer to
the point where, when drm/msm attaches it's UNMANAGED domain, we get
cbidx/asid zero.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
