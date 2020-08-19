Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78BC433DF
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 18:21:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E01520786
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 18:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJ511LjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E01520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC63120476;
	Wed, 19 Aug 2020 18:21:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohn4C7-RVkeM; Wed, 19 Aug 2020 18:21:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 120671FEDF;
	Wed, 19 Aug 2020 18:21:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5F48C07FF;
	Wed, 19 Aug 2020 18:21:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE09EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 18:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 86FEA20419
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 18:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5SQHSQfUG41e for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 18:21:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 by silver.osuosl.org (Postfix) with ESMTPS id C43551FEDF
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 18:20:59 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id y8so12445277vsq.8
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AacBmJ1F+/EQU2Ta6hd78j336wiWeooUogfDqt5vhVU=;
 b=MJ511LjL0Gf8T+5otwSMIHAYNGoOTa7oOz3vFzBU6AZJ6dAX+nI9cC7118htwG/ORX
 eBs8xHYraAXfTg3+3J/RFpfkMga9Cj17oTb4p/TBhXJhoh4jgceQywdVOQqMSK/JOJ3l
 PwBzJDQ8H04HrV4VQtbb6ovc5H+eRX5T4ho3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AacBmJ1F+/EQU2Ta6hd78j336wiWeooUogfDqt5vhVU=;
 b=dB/eXVTNHWiieh0zyVBe6EaewW9gdnWDn9uNC2rTEWgE+qLRwlAg9gMVN49XVOsClP
 0R1VOXEkxIg1CEp6UIe/oQhr2aLh+38/y/Sks/RYE4cCRrCeAyGpop1sNAhDvatVU31I
 L0UT74SQYUcDlDh6fQh6Aj1Iuba2vy/wM7Iu3e3j62yTGFDKr64bVsnDWrvhBpdiubJp
 /RPdJp1Zdkewt7RFEYeJ+NKmaQ5ldMHh3NgKY6gIlQkiTNPDKfHJsTQlwfCOvMr4nZ0c
 gTJ2WjgyZIK4B5+hofJkAgiGovF7V90RsuvY+/JLC2/80RwUgtlSLpQ/D5BarbuJglBS
 1Mvw==
X-Gm-Message-State: AOAM531DD05lLfPZ/kF/oeMLuSxtix3ohf7cNClGic57c7sxyfzjD/D/
 dANd48OYA6F5sd9Opk5xytOhxJy6L2sKnA==
X-Google-Smtp-Source: ABdhPJyKqAKu1tZOaGeiT1YdwWgS9ulJFBceI86G5Yt+aDgdlzyf/rBLyJBiTL8ZHFfddhpgu9wwEw==
X-Received: by 2002:a67:fb4e:: with SMTP id e14mr5316159vsr.98.1597861258522; 
 Wed, 19 Aug 2020 11:20:58 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com.
 [209.85.221.178])
 by smtp.gmail.com with ESMTPSA id a26sm844691uaq.19.2020.08.19.11.20.57
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 11:20:57 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id x187so5338811vkc.1
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 11:20:57 -0700 (PDT)
X-Received: by 2002:a1f:2fc1:: with SMTP id v184mr15612583vkv.42.1597861257099; 
 Wed, 19 Aug 2020 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220238.603465-1-robdclark@gmail.com>
 <20200817220238.603465-11-robdclark@gmail.com>
 <CAD=FV=VzYSL-3q0oFPPSP7FiEdLeTEN6Zy=kp-73B=8LAavmVw@mail.gmail.com>
 <CAF6AEGt=tGe3WQfyF_NuvJVXRbMH1=fnNK63MLpz0zxjZ9cwgQ@mail.gmail.com>
In-Reply-To: <CAF6AEGt=tGe3WQfyF_NuvJVXRbMH1=fnNK63MLpz0zxjZ9cwgQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Aug 2020 11:20:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxtA_1gp=gahjZiPkCJUy9ZgRoEnnE4apUQ1WVX_cs4A@mail.gmail.com>
Message-ID: <CAD=FV=XxtA_1gp=gahjZiPkCJUy9ZgRoEnnE4apUQ1WVX_cs4A@mail.gmail.com>
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

On Wed, Aug 19, 2020 at 10:36 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Aug 19, 2020 at 10:03 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Aug 17, 2020 at 3:03 PM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Jordan Crouse <jcrouse@codeaurora.org>
> > >
> > > Every Qcom Adreno GPU has an embedded SMMU for its own use. These
> > > devices depend on unique features such as split pagetables,
> > > different stall/halt requirements and other settings. Identify them
> > > with a compatible string so that they can be identified in the
> > > arm-smmu implementation specific code.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > index 503160a7b9a0..5ec5d0d691f6 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > @@ -40,6 +40,10 @@ properties:
> > >                - qcom,sm8150-smmu-500
> > >                - qcom,sm8250-smmu-500
> > >            - const: arm,mmu-500
> > > +      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
> > > +        items:
> > > +          - const: qcom,adreno-smmu
> > > +          - const: qcom,smmu-v2
> >
> > I know I'm kinda late to the game, but this seems weird to me,
> > especially given the later patches in the series like:
> >
> > https://lore.kernel.org/r/20200817220238.603465-19-robdclark@gmail.com
> >
> > Specifically in that patch you can see that this IOMMU already had a
> > compatible string and we're changing it and throwing away the
> > model-specific string?  I'm guessing that you're just trying to make
> > it easier for code to identify the adreno iommu, but it seems like a
> > better way would have been to just add the adreno compatible in the
> > middle, like:
> >
> >       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
> >         items:
> >           - enum:
> >               - qcom,msm8996-smmu-v2
> >               - qcom,msm8998-smmu-v2
> >               - qcom,sc7180-smmu-v2
> >               - qcom,sdm845-smmu-v2
> >         - const: qcom,adreno-smmu
> >         - const: qcom,smmu-v2
> >
> > Then we still have the SoC-specific compatible string in case we need
> > it but we also have the generic one?  It also means that we're not
> > deleting the old compatible string...
>
> I did bring up the thing about removing the compat string in an
> earlier revision of the series.. but then we realized that
> qcom,sc7180-smmu-v2 was never actually used anywhere.

Right, so at least there's not going to be weird issues where landing
the dts before the code change will break anything.


> But I guess we could:  compatible = "qcom,sc7180-smmu-v2",
> "qcom,adreno-smmu", "qcom,smmu-v2";

Yeah, that was what I was suggesting.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
