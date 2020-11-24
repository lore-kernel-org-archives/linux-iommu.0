Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA3C56201
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 22:06:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01031205ED
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc/+571z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01031205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 61EAF228CA;
	Tue, 24 Nov 2020 22:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKfvDPHcgLDH; Tue, 24 Nov 2020 22:06:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A78C2288E;
	Tue, 24 Nov 2020 22:06:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2A32C163C;
	Tue, 24 Nov 2020 22:06:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B352C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 22:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8BA0E82BFC
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 22:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2Sx7iRRwTy8 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 22:06:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 993DE86F98
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 22:06:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id h21so387417wmb.2
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 14:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Figoe8Zer72GbW0+hvjATZnj5NO6h5Raa/lqkNpArQ=;
 b=jc/+571ztrybLm+BOwSaoY7pl4esZi+3r3UODwY6Ge1iKKDOPYMx6lwyjDb88+QxAm
 YenolkYfmfPpLhA+w6f5e/1qbkphU0EepCGWU8xLQofles6qPv/nl1DVGk3z/O344be2
 xZ4VTY9dIj8j0z06kpnm6uvyCYG0fueUt3pqqxnOQZOhr0yQC2AGyWdPqSnRt2aIQ7AK
 Yl6yzAnF27oIa9mypy+3ntdIaN0uZyoNxQ4gsk6uBoeWwZDiwqmQTkTpVjAUR4RIRjew
 /P7O7b2lv+JiKkgOoyw+doXLWoWCzR0WMJ/OvmJBZhf0GMXiUMhm2cryo2QoYDH5qYKW
 q3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Figoe8Zer72GbW0+hvjATZnj5NO6h5Raa/lqkNpArQ=;
 b=eptBJXKWkxGxPiuKgeB/wqLoA4iHIs25djevSSoo9OMg3VDf82AgGgCujUzh/UqIBb
 /CGF+juxyknKuXJM+mxAX5ZeNTt3kTT3T9WXAowuRh3xR+gNVjk6E6tDpXZpFt9wkQSq
 NbuAJHSW+REa0KluLRkIbYk3E4dm6cIlNCCjRQspWGfPAm/45hde7FdugEynOApcLtSL
 2mhm9WTyOv79m2keA0kXjKM9YlTSRJFMuO6KBpldfofln6eEzgu7oQxeofZ9Ykf7fogb
 vnjiuVhXsmj76OzfmwIIl7OJJUjKrfWUmZGwynqtkpgHqX6003kRMYVZjHT45bI9y8oD
 nI7Q==
X-Gm-Message-State: AOAM531kD45HC34HzTQY4c0v1an9mg42f57CdCdeyTNb0VVtf4G1cn9a
 9KxM43DBviUW3yPsvAClCNy697YjnXa6uIEYKZ4=
X-Google-Smtp-Source: ABdhPJwxbj4hO3UhcOcUoC6jldq1SY0wj0dG1MEboORgvbHGRin3UXGunv67sZajYqm+JEM/JctmCGooiJvj2pLsGak=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr470472wmb.175.1606255591078; 
 Tue, 24 Nov 2020 14:06:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123152146.GE11033@willie-the-truck>
 <50b68f2bdf9413b896fbe816ba4ddbc9@codeaurora.org>
 <CAF6AEGse=WBAC1WbTi6aD5_m1_NBg91f=veYm-7V=Uds7NA0Lw@mail.gmail.com>
 <1c665e33d1d27263fb5056c16d30b827@codeaurora.org>
 <20201124111027.GA13151@willie-the-truck>
 <CAF6AEGuZ2YbY=ATFBX1KJw=LwhcpH8n+zzxckTHPwwopi6mOqw@mail.gmail.com>
 <20201124214332.GC14252@willie-the-truck>
In-Reply-To: <20201124214332.GC14252@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 24 Nov 2020 14:08:17 -0800
Message-ID: <CAF6AEGvu2Hdnw=ia8Ffmr1LPvkQNKpVVBM9xMNUKCn9uDcWWAg@mail.gmail.com>
Subject: Re: [PATCHv8 0/8] System Cache support for GPU and required SMMU
 support
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Dave Airlie <airlied@gmail.com>,
 freedreno <freedreno@lists.freedesktop.org>,
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

On Tue, Nov 24, 2020 at 1:43 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Nov 24, 2020 at 11:05:39AM -0800, Rob Clark wrote:
> > On Tue, Nov 24, 2020 at 3:10 AM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Nov 24, 2020 at 09:32:54AM +0530, Sai Prakash Ranjan wrote:
> > > > On 2020-11-24 00:52, Rob Clark wrote:
> > > > > On Mon, Nov 23, 2020 at 9:01 AM Sai Prakash Ranjan
> > > > > <saiprakash.ranjan@codeaurora.org> wrote:
> > > > > > On 2020-11-23 20:51, Will Deacon wrote:
> > > > > > > Modulo some minor comments I've made, this looks good to me. What is
> > > > > > > the
> > > > > > > plan for merging it? I can take the IOMMU parts, but patches 4-6 touch
> > > > > > > the
> > > > > > > MSM GPU driver and I'd like to avoid conflicts with that.
> > > > > > >
> > > > > >
> > > > > > SMMU bits are pretty much independent and GPU relies on the domain
> > > > > > attribute
> > > > > > and the quirk exposed, so as long as SMMU changes go in first it
> > > > > > should
> > > > > > be good.
> > > > > > Rob?
> > > > >
> > > > > I suppose one option would be to split out the patch that adds the
> > > > > attribute into it's own patch, and merge that both thru drm and iommu?
> > > > >
> > > >
> > > > Ok I can split out domain attr and quirk into its own patch if Will is
> > > > fine with that approach.
> > >
> > > Why don't I just queue the first two patches on their own branch and we
> > > both pull that?
> >
> > Ok, that works for me.  I normally base msm-next on -rc1 but I guess
> > as long as we base the branch on the older or our two -next branches,
> > that should work out nicely
>
> Turns out we're getting a v10 of Sai's stuff, so I've asked him to split
> patch two up anyway. Then I'll make a branch based on -rc1 that we can
> both pull.

Sounds good, thx

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
