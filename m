Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883ECC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 18:00:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1282A6522F
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 18:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1282A6522F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDED84C51B;
	Tue,  9 Mar 2021 18:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cq6KpZDZdzk4; Tue,  9 Mar 2021 18:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B7A44A061;
	Tue,  9 Mar 2021 18:00:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2261AC000B;
	Tue,  9 Mar 2021 18:00:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DBBFC0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 18:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F5FD430FD
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 18:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbHPDuxXvXlY for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 17:59:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A431D4308F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 17:59:59 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id j22so7849779otp.2
 for <iommu@lists.linux-foundation.org>; Tue, 09 Mar 2021 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yDPCYluFrdjMuzSEcawbKVQhqqsYOAVXybwEkOdxycU=;
 b=fQQzGb/jC1+8DjdcNxsptTS92WplKKRFklYa26EweJxZelK+27rO4Dk3Z+c0CcoG0i
 ex6lvP02F6oP23QRdP1abDLhXK+leEIvngG7dxSPifhRUVltVm0o/jlN4lgIbZQMSGfC
 +Q1rQe9M8OUTe+Jfi28FRJZ9Kro9wwNnlntZekOUY38dTsiRA1vPTiL5fXNkSVVyh8K+
 t3IJjkXzGkhvzgm40JVKnCLUJezdQUyyK7kR2BsDjle84ERuGhTM1b5v7WGGrcWhVLsv
 FJdeLG2DUkH9/8Iqp4xXALIgFo1/j5y+60UcIzb/pOS7MShzZtw17n3lj6Ue2wmRdsga
 4Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDPCYluFrdjMuzSEcawbKVQhqqsYOAVXybwEkOdxycU=;
 b=gmsBDT+gLQrC4bxy3e0BLVTiPI+1Gljy4KkJR65jEhywGefsba56MUnLSxjuX81ypT
 VCuX3pFbK7J33sag2WErXxrclVk1ynwaXLsPM87KCHlhl/g28r786qiJVxPUEdk9fP/y
 9VQdx18z58DdPLUNj7UqI0hBF79sIRzRiEyGLEKx8NMRiChEBwZBkW0nLFXAP8wIeMRE
 EXaXPWbmbkNeYdu4B6VZTPM0oh/1df9eBEcLqjTgy/osnMYsRR4NLqUq95wcstF4o8+P
 loPgwEXwuy3YO1BRBRmS6idFR8fS1vft86Vf/o4/VMNpyS4A7U0pxlg7sL3YCYoLZGKb
 vm8A==
X-Gm-Message-State: AOAM531S1JgwAzvDB93NxURFkAB5l93U1y8JZzFxx3Xp4ABognMa2CY9
 mZm58qGI3EweHeIvOyHzFn4H70ndhW+BgX0bI60=
X-Google-Smtp-Source: ABdhPJwEwsQ2caBdS22GuC0IAzNDOpvTy7t2RPblLIObbiLdaz9uhek4Vj9BBKsWFEIVLdwuEa4xRZ7j1/P0+lG9We8=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr25146289otl.23.1615312798691; 
 Tue, 09 Mar 2021 09:59:58 -0800 (PST)
MIME-Version: 1.0
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
 <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com> <YEexf0/V/YF394bf@myrica>
In-Reply-To: <YEexf0/V/YF394bf@myrica>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Mar 2021 12:59:47 -0500
Message-ID: <CADnq5_OTeK7-nN57+F+WE+Hdg86uiuTN8c_n0bmCtx40N_wraQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@linux.ie>,
 Felix Kuehling <felix.kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Mar 9, 2021 at 12:55 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Hi Felix,
>
> On Tue, Mar 09, 2021 at 11:30:19AM -0500, Felix Kuehling wrote:
> > > I think the proper fix would be to not rely on custom hooks into a particular
> > > IOMMU driver, but to instead ensure that the amdgpu driver can do everything
> > > it needs through the regular linux/iommu.h interfaces. I realize this
> > > is more work,
> > > but I wonder if you've tried that, and why it didn't work out.
> >
> > As far as I know this hasn't been tried. I see that intel-iommu has its
> > own SVM thing, which seems to be similar to what our IOMMUv2 does. I
> > guess we'd have to abstract that into a common API.
>
> The common API was added in 26b25a2b98e4 and implemented by the Intel
> driver in 064a57d7ddfc. To support it an IOMMU driver implements new IOMMU
> ops:
>         .dev_has_feat()
>         .dev_feat_enabled()
>         .dev_enable_feat()
>         .dev_disable_feat()
>         .sva_bind()
>         .sva_unbind()
>         .sva_get_pasid()
>
> And a device driver calls iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA)
> followed by iommu_sva_bind_device().
>
> If I remember correctly the biggest obstacle for KFD is the PASID
> allocation, done by the GPU driver instead of the IOMMU driver, but there
> may be others.

IIRC, we tried to make the original IOMMUv2 functionality generic but
other vendors were not interested at the time, so it ended up being
AMD specific and since nothing else was using the pasid allocations we
put them in the GPU driver.  I guess if this is generic now, it could
be moved to a common API and taken out of the driver.

Alex
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
