Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A05BC2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 19:20:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A4A20663
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3LUaTo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A4A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB1AF87061;
	Mon, 23 Nov 2020 19:20:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tw7-iGTeX8ei; Mon, 23 Nov 2020 19:20:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B6BB87040;
	Mon, 23 Nov 2020 19:20:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31450C0891;
	Mon, 23 Nov 2020 19:20:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD02C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 19:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 391BB85815
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 19:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dkEj2Z7vJsLb for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 19:20:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 30804857F8
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 19:20:46 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id t4so6773490wrr.12
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 11:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qywik7ZeoNLjOI/OiRzyEWbv5L3UmV1jd3xo8upxDsg=;
 b=D3LUaTo9sjQT2psf9iOfR5Q+w/hWOKbYJIrGkOwrSKId0+dXBhN2JbAKZrdU51cvlB
 2TH/BH6AH3DKIlQMdVT/V8i+l/yJ0ztIDwjnuj5ekXsttMcEx45j51pC0OifHlxSPhYg
 Vk+onO+4dhk/KXF75P7ZKjh+voUOJ9oSQjQwUJDgxbPMNzzW/mCkzUromNJl14ewjTbQ
 hnFhD+OP+mQd1nGunov0a3cqO2Ge91PFnaB9BUbjoIR7Xh+5gqsSdXq8Qw6VGchsGoGF
 0vJhoOfb411RYFqRARv8q6FJ4UVj/X+YELsIA4bt6jG6BaYQDZlj6Yq4zmlmJcnYBMzK
 BWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qywik7ZeoNLjOI/OiRzyEWbv5L3UmV1jd3xo8upxDsg=;
 b=ZOQJu87eQierqtV8pRbYXnr4p4XQm4YBt6yTwT/ANIkjdZBV3w347gfgU50m6+cTqS
 qpuTCiXHQlevM9oSTRQhpjMBgN2KhY8Jz64z9hfREIGjaDKFEkSla6Ns3vbswjTyN/Uf
 8zpLcBMDOUN3WAotOozOPdo8lBLIWP/2+A5J/MtHLPnqQjJg3lPt1B4jvM1SjXcp+J25
 OFFMLLEmWcduCCHSpPQ+crL06VJq3WKOqkQ/KSeIoYNbe9u+KaBX+CKDTQHGgDUey+i+
 XsDnSPyXnzJzOnZwrFVm+YogDg1si7tH3TMifY2U4QaG4Xl8Zht08SjLcvoKB/0mtdzf
 y5dA==
X-Gm-Message-State: AOAM532EGR4hDDa1cIVRmIU84GXqCM0y2JdhFntyF08sLCMRhBKMXwDD
 4Z0RZrF4AnRnSVVxkynIs+h9yzEHJnrCy4Z3O+c=
X-Google-Smtp-Source: ABdhPJy8N53HXm9IuUy+KZQkqOt4/pj9ITZPgRIZbKk5Hw32UENtsWfsI7ELNiEQlwY8TBRX7HEq8kOv+802Ag6uHEw=
X-Received: by 2002:adf:a54d:: with SMTP id j13mr1337431wrb.132.1606159244462; 
 Mon, 23 Nov 2020 11:20:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123152146.GE11033@willie-the-truck>
 <50b68f2bdf9413b896fbe816ba4ddbc9@codeaurora.org>
In-Reply-To: <50b68f2bdf9413b896fbe816ba4ddbc9@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 23 Nov 2020 11:22:31 -0800
Message-ID: <CAF6AEGse=WBAC1WbTi6aD5_m1_NBg91f=veYm-7V=Uds7NA0Lw@mail.gmail.com>
Subject: Re: [PATCHv8 0/8] System Cache support for GPU and required SMMU
 support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, freedreno <freedreno@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

On Mon, Nov 23, 2020 at 9:01 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 2020-11-23 20:51, Will Deacon wrote:
> > On Tue, Nov 17, 2020 at 08:00:39PM +0530, Sai Prakash Ranjan wrote:
> >> Some hardware variants contain a system cache or the last level
> >> cache(llc). This cache is typically a large block which is shared
> >> by multiple clients on the SOC. GPU uses the system cache to cache
> >> both the GPU data buffers(like textures) as well the SMMU pagetables.
> >> This helps with improved render performance as well as lower power
> >> consumption by reducing the bus traffic to the system memory.
> >>
> >> The system cache architecture allows the cache to be split into slices
> >> which then be used by multiple SOC clients. This patch series is an
> >> effort to enable and use two of those slices preallocated for the GPU,
> >> one for the GPU data buffers and another for the GPU SMMU hardware
> >> pagetables.
> >>
> >> Patch 1 - Patch 6 adds system cache support in SMMU and GPU driver.
> >> Patch 7 and 8 are minor cleanups for arm-smmu impl.
> >>
> >> Changes in v8:
> >>  * Introduce a generic domain attribute for pagetable config (Will)
> >>  * Rename quirk to more generic IO_PGTABLE_QUIRK_ARM_OUTER_WBWA (Will)
> >>  * Move non-strict mode to use new struct domain_attr_io_pgtbl_config
> >> (Will)
> >
> > Modulo some minor comments I've made, this looks good to me. What is
> > the
> > plan for merging it? I can take the IOMMU parts, but patches 4-6 touch
> > the
> > MSM GPU driver and I'd like to avoid conflicts with that.
> >
>
> SMMU bits are pretty much independent and GPU relies on the domain
> attribute
> and the quirk exposed, so as long as SMMU changes go in first it should
> be good.
> Rob?

I suppose one option would be to split out the patch that adds the
attribute into it's own patch, and merge that both thru drm and iommu?

If Will/Robin dislike that approach, I'll pick up the parts of the drm
patches which don't depend on the new attribute for v5.11 and the rest
for v5.12.. or possibly a second late v5.11 pull req if airlied
doesn't hate me too much for it.

Going forward, I think we will have one or two more co-dependent
series, like the smmu iova fault handler improvements that Jordan
posted.  So I would like to hear how Will and Robin prefer to handle
those.

BR,
-R


> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member
> of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
