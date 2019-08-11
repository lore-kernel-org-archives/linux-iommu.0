Return-Path: <SRS0=3qkl=WH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BAC433FF
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 19:00:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490462173C
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKH6a5rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490462173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 183FDAE0;
	Sun, 11 Aug 2019 19:00:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 951CDAD0
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 19:00:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2C13989D
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 19:00:23 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id bj8so9781plb.4
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=g4HRffWR5sTfOdPb8n2H2gBlNEK3O7QkgVCtkSjBUGc=;
	b=NKH6a5rKubvrnRjIiAagMdwN7DNFvpDIxEUxLYf+kcaaRrXUD4LXVeEaPzEwnv51Qn
	7QZtgmEqhK5E4pjO/rrk1i6VlM2ljoxMczTY2s0GmrCxGCEIRTRvwfm2eZyvt5gl2ail
	i4BetvPir8rZaPCg6FdYaMlO7QhhsOWiFl05YooTM8FK+qi+aGZytl2RfGMDZccqWYcH
	c7A1ri271xLpFxZkPBYu7DbHUIaK8beRCewn28rCUTsX9GjAB64fyF3nlcG1issWWlne
	M1MeftR3HX7ZBV69FKtlbTP5HTcIxgTIQFwFvS9sWY9tl+c2q40uABiEoYtg7El1O0aC
	FcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=g4HRffWR5sTfOdPb8n2H2gBlNEK3O7QkgVCtkSjBUGc=;
	b=RAZEOQZ0CrpfO+GKTJN8BMYRoV04HadrvcdC4w1WwuppvEkKIz0GVvKqZoprP0awLD
	/6cOyB2f8gKeKkBSbWJlMk9tLpPlHf1PnJa7sbEMMp8CUv5lsLypGaaMlx+ioUepaG6A
	D16pxDxjhVTvMVN54moLmECp8LCmybrMjomb47pL3y/h+v/bFyUbIKm9O/9S6u7T5OoL
	KhXi9V6Ii28FWbCzD9iSos28qFFqe30EWbYoytGIqX977mueO6IJa3q+YuQQE3hxJVW5
	+Q0WtdRfLpRF0fbSA/R4/NKFBfx9WDumtb5AyDkBEGDSp2CHxJBRSStDFnzjhi6RKocB
	3k3w==
X-Gm-Message-State: APjAAAVZab8QCstWRcKv+ihSDuyGdH2G9Sl+ieOGtX7XVZBM2KP3ZYSt
	zSROOAXEOIEAKdxdpiAEiaBN1w==
X-Google-Smtp-Source: APXvYqzc4Bn9ATOCQYg7LsJf9jLHX1jrV/wEcEKA0Dzyd51K6OZ8vz1CVcwhFwEFMJTVX7DrRrXbdA==
X-Received: by 2002:a17:902:e4:: with SMTP id
	a91mr29498761pla.150.1565550022586; 
	Sun, 11 Aug 2019 12:00:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28])
	by smtp.gmail.com with ESMTPSA id 5sm41932620pgh.93.2019.08.11.12.00.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 11 Aug 2019 12:00:21 -0700 (PDT)
Date: Sun, 11 Aug 2019 12:01:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 4/4] arm64: dts/sdm845: Enable FW implemented safe
	sequence handler on MTP
Message-ID: <20190811190159.GQ26807@tuxbook-pro>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-5-vivek.gautam@codeaurora.org>
	<20190805222627.GA2634@builder>
	<CAFp+6iHGrXAJ2Y1ewxaePGYEcbnprjScUnGyR61qvOv03HVZhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iHGrXAJ2Y1ewxaePGYEcbnprjScUnGyR61qvOv03HVZhQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	David Brown <david.brown@linaro.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	robh+dt <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sun 11 Aug 09:08 PDT 2019, Vivek Gautam wrote:

> On Tue, Aug 6, 2019 at 3:56 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:
> >
> > > Indicate on MTP SDM845 that firmware implements handler to
> > > TLB invalidate erratum SCM call where SAFE sequence is toggled
> > > to achieve optimum performance on real-time clients, such as
> > > display and camera.
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 78ec373a2b18..6a73d9744a71 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -2368,6 +2368,7 @@
> > >                       compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> > >                       reg = <0 0x15000000 0 0x80000>;
> > >                       #iommu-cells = <2>;
> > > +                     qcom,smmu-500-fw-impl-safe-errata;
> >
> > Looked back at this series and started to wonder if there there is a
> > case where this should not be set? I mean we're after all adding this to
> > the top 845 dtsi...
> 
> My bad.
> This is not valid in case of cheza. Cheza firmware doesn't implement
> the safe errata handling hook.
> On cheza we just have the liberty of accessing the secure registers
> through scm calls - this is what
> we were doing in earlier patch series handling this errata.
> So, a property like this should go to mtp board's dts file.
> 

It would have been nice if the common case was just selected by default,
but afaict no safe workaround is needed on Cheza? You mention here that
it should (could?) use the scm write based approach instead, would an
introduction of that come with another flag?


PS. In it's current form it's correct that this should be moved to the
device dts files - all but one of them...

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
