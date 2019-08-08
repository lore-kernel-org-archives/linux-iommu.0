Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D27C433FF
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 11:35:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FC4217F4
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 11:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mqb7vvjz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZbrI0B4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FC4217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFB8AF1E;
	Thu,  8 Aug 2019 11:35:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5B0CBDBB
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 11:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B594182F
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 11:35:35 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F54F60795; Thu,  8 Aug 2019 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565264135;
	bh=sH6nUxZ8Y5dNhEx5LOsnBwv7hqu3JssLmT67GtkYFO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mqb7vvjzx+MKfzAMS8jEz1fTkI4H9bPpTOCk+imcRQkezG9Yp2E+E45/nhpmGZQei
	pBirMUA6XrO/Ht5xpyR9XJ/KaYs42L/b1ivVHV1CgYRhHdhPeAC+V5PPpEvsbpjWwX
	srYIPa2q0ySeKGkshNuudBF2AsrzdJ65bO0R/VZQ=
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
	[209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B01E6074C
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1565264134;
	bh=sH6nUxZ8Y5dNhEx5LOsnBwv7hqu3JssLmT67GtkYFO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZbrI0B4S6yZ9W8DkXTkRKrtxZxIGwqY+/MXPYB0o2rmzwggw0xkXrqFe8/EQqk3qx
	CEiE0e7ulfOwRuC4cCZk5zRsj+IjxTMkazmUE1W++Hhtf2TrNtbW8Zj1X5IqmRAqkF
	eR+XXmlBx8cVE9RFQgP2+XxaVevY5NI/aexva7a0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B01E6074C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f54.google.com with SMTP id s49so55580991edb.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 08 Aug 2019 04:35:34 -0700 (PDT)
X-Gm-Message-State: APjAAAVPb5QkF2W49o0IGlQUKdmniVCaM4gZbqauyCDF/vPzitYbaHwF
	46QEv97qhPxa9IiQvP3UgBGCebs2mmqvimWa6Yo=
X-Google-Smtp-Source: APXvYqzXmB+VRV0h6DczJ86/gi4VfVSVgaDq6lvQZ78xCiCfDaAmWfeWWRuyx/bhq49Zbz7Hw0FKWVka+rpz4IhZsdg=
X-Received: by 2002:a17:906:7013:: with SMTP id
	n19mr12879575ejj.65.1565264132964; 
	Thu, 08 Aug 2019 04:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-2-vivek.gautam@codeaurora.org>
	<20190618175536.GI4270@fuggles.cambridge.arm.com>
	<CAFp+6iEwN6jeEGNxKVU5_i5NxdEbuF2ZggegEJZ1Rq6F=H34jg@mail.gmail.com>
	<20190805222755.GB2634@builder>
In-Reply-To: <20190805222755.GB2634@builder>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 8 Aug 2019 17:05:21 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHhh9749dAV4YDeE_0w1nCiftecTBedW4Rf0aiaOJsN2A@mail.gmail.com>
Message-ID: <CAFp+6iHhh9749dAV4YDeE_0w1nCiftecTBedW4Rf0aiaOJsN2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
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

On Tue, Aug 6, 2019 at 3:58 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 19 Jun 04:34 PDT 2019, Vivek Gautam wrote:
>
> > On Tue, Jun 18, 2019 at 11:25 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > On Wed, Jun 12, 2019 at 12:45:51PM +0530, Vivek Gautam wrote:
> > > > There are scnenarios where drivers are required to make a
> > > > scm call in atomic context, such as in one of the qcom's
> > > > arm-smmu-500 errata [1].
> > > >
> > > > [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/
> > > >       drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/
> > > >       msm-4.9&id=da765c6c75266b38191b38ef086274943f353ea7")
> > > >
> > > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >  drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------------
> > > >  1 file changed, 92 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> > > > index 91d5ad7cf58b..b6dca32c5ac4 100644
> > > > --- a/drivers/firmware/qcom_scm-64.c
> > > > +++ b/drivers/firmware/qcom_scm-64.c
> >
> > [snip]
> >
> > > > +
> > > > +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
> > > > +                          struct arm_smccc_res *res, u32 fn_id,
> > > > +                          u64 x5, bool atomic)
> > > > +{
> > >
> > > Maybe pass in the call type (ARM_SMCCC_FAST_CALL vs ARM_SMCCC_STD_CALL)
> > > instead of "bool atomic"? Would certainly make the callsites easier to
> > > understand.
> >
> > Sure, will do that.
> >
> > >
> > > > +     int retry_count = 0;
> > > > +
> > > > +     if (!atomic) {
> > > > +             do {
> > > > +                     mutex_lock(&qcom_scm_lock);
> > > > +
> > > > +                     __qcom_scm_call_do(desc, res, fn_id, x5,
> > > > +                                        ARM_SMCCC_STD_CALL);
> > > > +
> > > > +                     mutex_unlock(&qcom_scm_lock);
> > > > +
> > > > +                     if (res->a0 == QCOM_SCM_V2_EBUSY) {
> > > > +                             if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> > > > +                                     break;
> > > > +                             msleep(QCOM_SCM_EBUSY_WAIT_MS);
> > > > +                     }
> > > > +             }  while (res->a0 == QCOM_SCM_V2_EBUSY);
> > > > +     } else {
> > > > +             __qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
> > > > +     }
> > >
> > > Is it safe to make concurrent FAST calls?
> >
> > I better add a spinlock here.
> >
>
> Hi Vivek,
>
> Would you be able to respin this patch, so that we could unblock the
> introduction of the display nodes in the various device?

Will pointed [1] to the restructuring of arm-smmu to support
implementation specific details.
That hasn't been posted yet, and I haven't yet been able to work on that either.
I will be happy to respin this series with the comments addressed if
Will is okay to pull changes to unblock sdm845 devices. :)

[1] https://lore.kernel.org/patchwork/patch/1087457/

Thanks & Regards
Vivek

>
> Regards,
> Bjorn
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
