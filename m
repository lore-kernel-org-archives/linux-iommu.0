Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2DCC433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 21:00:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC8A20756
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 21:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UzmCAWI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 06674882BB;
	Mon, 18 May 2020 21:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FAQ9ci1lD7hq; Mon, 18 May 2020 21:00:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 52B5E885E0;
	Mon, 18 May 2020 21:00:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38104C0881;
	Mon, 18 May 2020 21:00:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDA4EC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 21:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A67A587781
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 21:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1EO7HbjtOqgZ for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 21:00:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1579987775
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 21:00:05 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id w65so3837024vsw.11
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4vQAvXs8YebqJQNpvsgx+YOpDZkNHLr4/g7pen09M+Y=;
 b=UzmCAWI3Et1k/ZetXQXo8P7q5FAsHXBwwnFSCGgtDVWBYyDfVAPaFJFOP+/jbBxQPZ
 x63KZMFIM/dDJIh3QlTuH2yECcrZwYZCpiYH9MFtMCDOG8n18NeS6lZ7oPGMpcTGWu85
 xnn+GfXK8uB79yIF6irfWr1brh/7UoNiSPDHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4vQAvXs8YebqJQNpvsgx+YOpDZkNHLr4/g7pen09M+Y=;
 b=rtdu4Bza0x6n80jVToe2IYIejHdbcaaeDo9ySnB1dIa7gtgdSyZTp9CDe4Kc+9UH2D
 mmSvhOcqUrvAGVso8AEAmtso+k5OcnFefPNC1BIGN7PB3YYyGIf6H+25Qj00kAuzxc9O
 X956oRpzQpDJ7Z5PEq8QPWXdldvsCPqS2tX7FEYyPgDLQLy8fgNADXz4N6N7O6Iuw4UO
 kcZahHkL2RCw9npsOVtGyJJaKnIXkxnxLVRo/uzI1Bv7Uu9SGm0RFIWpPvBjsmgpn7Pm
 E/cm4uweANy7rSTDwRL/hBiVC5UZOvAwf+m/i6coIkGwCy8k3i41GnSJDzhHm70+STiV
 tCyg==
X-Gm-Message-State: AOAM532McMciYvhHlRo/mA0X2bXtOHQK5Wbho7wd5lVYfrSC397kG81T
 b17lvgWvje8rKKSOiOXC3sGNO7KBsE0=
X-Google-Smtp-Source: ABdhPJy9Sb6hsD4LuZa3YQyvhe9tiYxuRT0VPoba5Z+wv738SK7+3bJiwhBhfemEnVe+sV7wZI4iXA==
X-Received: by 2002:a67:6383:: with SMTP id
 x125mr13109581vsb.197.1589835602155; 
 Mon, 18 May 2020 14:00:02 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com.
 [209.85.222.51])
 by smtp.gmail.com with ESMTPSA id u136sm686784vke.36.2020.05.18.14.00.00
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 14:00:01 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a37so1068896uad.0
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 14:00:00 -0700 (PDT)
X-Received: by 2002:ab0:b13:: with SMTP id b19mr12713480uak.91.1589835600274; 
 Mon, 18 May 2020 14:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
 <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
 <CAD=FV=WXv9DYf7LWoFBvro=7Bzeb1_0bXAvRH-suzxnrCu+V2A@mail.gmail.com>
 <20200518143920.GJ32394@willie-the-truck>
In-Reply-To: <20200518143920.GJ32394@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 May 2020 13:59:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=We2+5QHimzr+ukit9qkDKQaaTHYEZGkVbOwsNuy11k9A@mail.gmail.com>
Message-ID: <CAD=FV=We2+5QHimzr+ukit9qkDKQaaTHYEZGkVbOwsNuy11k9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add sc7180 compatible string
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Sharat Masetty <smasetty@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, dri-devel@freedesktop.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

Hi,

On Mon, May 18, 2020 at 7:39 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 12:05:39PM -0700, Doug Anderson wrote:
> > On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
> > >
> > > This patch simply adds a new compatible string for SC7180 platform.
> > >
> > > Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> > > ---
> > >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > index 6515dbe..986098b 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > > @@ -28,6 +28,7 @@ properties:
> > >            - enum:
> > >                - qcom,msm8996-smmu-v2
> > >                - qcom,msm8998-smmu-v2
> > > +              - qcom,sc7180-smmu-v2
> > >                - qcom,sdm845-smmu-v2
> > >            - const: qcom,smmu-v2
> >
> > Is anything blocking this patch from landing now?
>
> I thought updates to the bindings usually went via Rob and the device-tree
> tree, but neither of those are on cc.
>
> Perhaps resend with that fixed?

Ah, I guess I wasn't familiar with how things worked for this file, or
maybe things have changed recently?  I'm used to most bindings going
through the same tree as the drivers that use them.  Usually if things
are at all complicated maintainers wait for an Ack from Rob (so he
should have been CCed for sure) and then land.

In this case it actually looks like Bjorn landed it in the Qualcomm
and I just didn't realize it.  That seems like it should be fine since
it's in the middle of a clause that's all Qualcomm and the change
shouldn't be controversial in any way.  :-)

Thanks!

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
