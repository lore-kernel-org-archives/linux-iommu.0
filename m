Return-Path: <SRS0=3qkl=WH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC5C32757
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 16:08:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B21520880
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 16:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NVnQZNVU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hjMIY34S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B21520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF94572A;
	Sun, 11 Aug 2019 16:08:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E2348481
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 16:08:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F3F287D
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 16:08:38 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 454506047C; Sun, 11 Aug 2019 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565539718;
	bh=q2Eye4K2ziKCFlT1foS+S6HSiy4LOooGYEQTduuBmiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NVnQZNVUOiK3K7aKCxetRqBpEoBkNBU05iW86thPa5J/aTc8I2/mi88U78JdckLbV
	9EiUZ2juRkXB4OJMjH2Di2MajNay0ZFOUQ2qJOA3j05+Lo3cmdVvptj1iE1cbHsnLu
	3Oxn2V4CFyAhZ4D8kt0SuP+FnKMRIaPc49YBLTkk=
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
	[209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F063605A2
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565539717;
	bh=q2Eye4K2ziKCFlT1foS+S6HSiy4LOooGYEQTduuBmiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hjMIY34Sv2YtANfBFfitDJXajAadIYCdQPemtCzJ9iq2adSonaPKN2fsL7dH+tIcc
	9lYwvg7BEHZkh2nAAIDeB3081lx0jOOeYgTT3M0K7Nkeb+1LNi4flA4d/yMWXYYPjK
	YhN/5/MnQwuWKPsyiOZCC7HkOZw7OnkEvV5HNjgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F063605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f48.google.com with SMTP id h13so3308915edq.10
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 09:08:37 -0700 (PDT)
X-Gm-Message-State: APjAAAXeOEheDR7n4G4R2PZuKUwMA0iGRWiFo3IrTOL9xxRFD7gUuqSx
	OVrHZ35cSLPdBryvR5uTIjfBg7O4D336jeVfZDY=
X-Google-Smtp-Source: APXvYqyFFJCaGAq46SyTCzjuDhcbBv3wmxf8bN+ADhcvIt95E7RRnkwHNH6sBTe8oSgzL5kbHeNmbVUaK3aBr0qGTKk=
X-Received: by 2002:a17:906:2544:: with SMTP id
	j4mr27620572ejb.221.1565539715693; 
	Sun, 11 Aug 2019 09:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-5-vivek.gautam@codeaurora.org>
	<20190805222627.GA2634@builder>
In-Reply-To: <20190805222627.GA2634@builder>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Sun, 11 Aug 2019 21:38:24 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHGrXAJ2Y1ewxaePGYEcbnprjScUnGyR61qvOv03HVZhQ@mail.gmail.com>
Message-ID: <CAFp+6iHGrXAJ2Y1ewxaePGYEcbnprjScUnGyR61qvOv03HVZhQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts/sdm845: Enable FW implemented safe
	sequence handler on MTP
To: Bjorn Andersson <bjorn.andersson@linaro.org>
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

On Tue, Aug 6, 2019 at 3:56 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:
>
> > Indicate on MTP SDM845 that firmware implements handler to
> > TLB invalidate erratum SCM call where SAFE sequence is toggled
> > to achieve optimum performance on real-time clients, such as
> > display and camera.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 78ec373a2b18..6a73d9744a71 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2368,6 +2368,7 @@
> >                       compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> >                       reg = <0 0x15000000 0 0x80000>;
> >                       #iommu-cells = <2>;
> > +                     qcom,smmu-500-fw-impl-safe-errata;
>
> Looked back at this series and started to wonder if there there is a
> case where this should not be set? I mean we're after all adding this to
> the top 845 dtsi...

My bad.
This is not valid in case of cheza. Cheza firmware doesn't implement
the safe errata handling hook.
On cheza we just have the liberty of accessing the secure registers
through scm calls - this is what
we were doing in earlier patch series handling this errata.
So, a property like this should go to mtp board's dts file.

Thanks

Vivek

>
> How about making it the default in the driver and opt out of the errata
> once there is a need?
>
> Regards,
> Bjorn
>
> >                       #global-interrupts = <1>;
> >                       interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> >                                    <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
