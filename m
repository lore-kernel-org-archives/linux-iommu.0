Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E363C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 17:34:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B357861CC9
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 17:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B357861CC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 778AD83B01;
	Wed,  7 Jul 2021 17:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38rbQooACxVz; Wed,  7 Jul 2021 17:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7EA3583AF3;
	Wed,  7 Jul 2021 17:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 578A9C001A;
	Wed,  7 Jul 2021 17:34:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75EE7C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 17:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63DAB83AF3
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 17:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxSRbiaHCdtT for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 17:34:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8ADDB83AF6
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 17:34:36 +0000 (UTC)
Received: by mail-il1-x136.google.com with SMTP id o10so3707918ils.6
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sD13z85XVgoLdSGSEXdyjIhfF8nDl4He7AW/wdIYAPE=;
 b=GMyUr6TlJ9VJExoTQpjFfBsLf6J01HTyZta3543eDwhlqbYEzWxs8GoDpUc1UsSTw4
 l1VVQLqIkdx353vwBODZcBzPc+/pWN2sN4WUmOL2Q2pzqXNGKMgaACFtiLtqRBNiBa9g
 MO2krDbX2BQp90Nsue1zk7vA6Wepr7RZf2O7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sD13z85XVgoLdSGSEXdyjIhfF8nDl4He7AW/wdIYAPE=;
 b=h0w1Ik1Sn0/wUKbPTNVw94NNMTAonUchcQDRDTqYUCxULC9UkxgUD80fUeF37qgQXW
 p9UD3fZyvWF8OpTKG9ZrxqkUWfSBYZAvmkS3SSgMhNG6uXQItD83cVzJDXvKpdKKI4ZY
 gnmLlg4xxL5TyF1bx6msJKEIf8k2CssxMUKVnuck6g9DTIHUJSGIDJis46XMdcNF9rxa
 DielEs0l3LjtZf0hMk5qHMZe9AJoNRK/SMoRqhf59k3DYoN0qeKj90C35HZNfRBzQgT0
 B881u6i+QF5ZMZbipnAAPK30s8yj/0f9ty8k1V3mbA8vO33H/VmIS2bOwfpNrsJpdwF0
 BUNg==
X-Gm-Message-State: AOAM533ibutQM/HTNlhG+/nPSk7RGcRAEMRqG4cMWRL/UuV1ydflsu1P
 G0u63gYRUD2QBUv1szZuU1Sn5p2MF7ZaMg0l+JDK5A==
X-Google-Smtp-Source: ABdhPJxjcG9AfhjNI0K88JMDlGt/CX21XaqIJd0EGqm1e9KWBmc9XPZNa/mXbdXJb612yvG28vh3Q4PQfEPrvTUr3HA=
X-Received: by 2002:a92:6f0a:: with SMTP id k10mr18648951ilc.105.1625679275706; 
 Wed, 07 Jul 2021 10:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210610214431.539029-1-robdclark@gmail.com>
 <2016473f-2b38-f049-1e8d-04bdf5af6cea@linaro.org>
 <CAF6AEGu6Wt+FDh_Kp8GrZB9TV7ufTuidmqBfkzA9rcCJc7zSQQ@mail.gmail.com>
 <CALAqxLWDqQeD-eieHXtePuXpxN1s3=jCNJP2pJD-YswsLP-mJw@mail.gmail.com>
In-Reply-To: <CALAqxLWDqQeD-eieHXtePuXpxN1s3=jCNJP2pJD-YswsLP-mJw@mail.gmail.com>
From: Rob Clark <robdclark@chromium.org>
Date: Wed, 7 Jul 2021 10:38:38 -0700
Message-ID: <CAJs_Fx4n07yuksL+kmjyKRuqPnFuE1m5PmeqCsoF7Xah=kWxvA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] iommu/arm-smmu: adreno-smmu page fault handling
To: John Stultz <john.stultz@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lee Jones <lee.jones@linaro.org>, Jonathan Marek <jonathan@marek.ca>,
 Will Deacon <will@kernel.org>, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Joerg Roedel <jroedel@suse.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Douglas Anderson <dianders@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>
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

On Tue, Jul 6, 2021 at 10:12 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Sun, Jul 4, 2021 at 11:16 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > I suspect you are getting a dpu fault, and need:
> >
> > https://lore.kernel.org/linux-arm-msm/CAF6AEGvTjTUQXqom-xhdh456tdLscbVFPQ+iud1H1gHc8A2=hA@mail.gmail.com/
> >
> > I suppose Bjorn was expecting me to send that patch
>
> If it's helpful, I applied that and it got the db845c booting mainline
> again for me (along with some reverts for a separate ext4 shrinker
> crash).
> Tested-by: John Stultz <john.stultz@linaro.org>
>

Thanks, I'll send a patch shortly

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
