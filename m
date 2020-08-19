Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C39C433E3
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:34:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4E720758
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cf6w4ypy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4E720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 82943857A4;
	Wed, 19 Aug 2020 17:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7as4ecD40DA; Wed, 19 Aug 2020 17:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E13F182476;
	Wed, 19 Aug 2020 17:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7948C0889;
	Wed, 19 Aug 2020 17:34:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 341CBC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 22D66850EA
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o7B-gJHMvlpK for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 17:34:05 +0000 (UTC)
X-Greylist: delayed 00:30:52 by SQLgrey-1.7.6
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BFFE382476
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 17:34:05 +0000 (UTC)
Received: by mail-qv1-f66.google.com with SMTP id cs12so11662707qvb.2
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ktYpsCxiLWJOQgFpjU6rm698Y/qLm2dIO8jCJsadEOU=;
 b=Cf6w4ypyePA72N9OwZ/X/gIqgQ3/Z2O3rsVEAnbMsPXxSteDXfBbrAJ2YKaLKzi+2G
 eJlNvZyKM6mcCsbB8rTNwjE0zNlCUOU27vLJyO1vH/Kf6P5hVdc0XLNeLzE0ilaNzTIL
 c/q/2eCUoXXxQCiuP4bqs7wWJmNaxuO94MGUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ktYpsCxiLWJOQgFpjU6rm698Y/qLm2dIO8jCJsadEOU=;
 b=tXPBKFr0NNu7R1VLIlDmsZ0tLPzLsTWv++nLB7tKHWs+os516tb19jNfNQweiqLlse
 goblJ0k7OmgXIQQBqDKXMksCxRarQN7q5gmJHOJ/Rcd6ez0TGDYF89awiBy+DSf872us
 o81f6IyrvF9VUX+SJIMDyu5JmRbOnXbPeiflGHzjxSNDpwNma6dkfQ7Rd/jCJ4OIdifx
 Z5pfbhb5IE5MC7JpffacCcbONfRstWuZex8eniulQyTQJ38GAMUSOpqvUfjmpXBL8Gyu
 xEj1FVbZuD+u8ElzvBB61uKNCfEb+u6vahHGmn4dK1xz+5UPaSyYrR8gkXCQJHzFGjqE
 +WMw==
X-Gm-Message-State: AOAM5317EmvgCCtDtxXA+3yaI0i7t+JvoIp3zLJLFbn/9VoIEWgWpG88
 xjEsvzxBMdT0a4YLPAA9qpnEXC7Ztd/vHw==
X-Google-Smtp-Source: ABdhPJy6GF8JiwQcx7BgPxn1S2ps9t72d1OUb8T4xXXFOMiJUgGyZiWL6iuPSNc9lU9ttt4p3K6xEw==
X-Received: by 2002:ad4:46e1:: with SMTP id h1mr24761404qvw.129.1597856592720; 
 Wed, 19 Aug 2020 10:03:12 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id k134sm24694651qke.60.2020.08.19.10.02.35
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 10:02:42 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id u6so7870689ybf.1
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 10:02:35 -0700 (PDT)
X-Received: by 2002:a25:d802:: with SMTP id p2mr37420399ybg.446.1597856554388; 
 Wed, 19 Aug 2020 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220238.603465-1-robdclark@gmail.com>
 <20200817220238.603465-11-robdclark@gmail.com>
In-Reply-To: <20200817220238.603465-11-robdclark@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Aug 2020 10:02:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VzYSL-3q0oFPPSP7FiEdLeTEN6Zy=kp-73B=8LAavmVw@mail.gmail.com>
Message-ID: <CAD=FV=VzYSL-3q0oFPPSP7FiEdLeTEN6Zy=kp-73B=8LAavmVw@mail.gmail.com>
Subject: Re: [PATCH 10/20] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Mon, Aug 17, 2020 at 3:03 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Jordan Crouse <jcrouse@codeaurora.org>
>
> Every Qcom Adreno GPU has an embedded SMMU for its own use. These
> devices depend on unique features such as split pagetables,
> different stall/halt requirements and other settings. Identify them
> with a compatible string so that they can be identified in the
> arm-smmu implementation specific code.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 503160a7b9a0..5ec5d0d691f6 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -40,6 +40,10 @@ properties:
>                - qcom,sm8150-smmu-500
>                - qcom,sm8250-smmu-500
>            - const: arm,mmu-500
> +      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
> +        items:
> +          - const: qcom,adreno-smmu
> +          - const: qcom,smmu-v2

I know I'm kinda late to the game, but this seems weird to me,
especially given the later patches in the series like:

https://lore.kernel.org/r/20200817220238.603465-19-robdclark@gmail.com

Specifically in that patch you can see that this IOMMU already had a
compatible string and we're changing it and throwing away the
model-specific string?  I'm guessing that you're just trying to make
it easier for code to identify the adreno iommu, but it seems like a
better way would have been to just add the adreno compatible in the
middle, like:

      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
        items:
          - enum:
              - qcom,msm8996-smmu-v2
              - qcom,msm8998-smmu-v2
              - qcom,sc7180-smmu-v2
              - qcom,sdm845-smmu-v2
        - const: qcom,adreno-smmu
        - const: qcom,smmu-v2

Then we still have the SoC-specific compatible string in case we need
it but we also have the generic one?  It also means that we're not
deleting the old compatible string...

-Doug


>        - description: Marvell SoCs implementing "arm,mmu-500"
>          items:
>            - const: marvell,ap806-smmu-500
> --
> 2.26.2
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
