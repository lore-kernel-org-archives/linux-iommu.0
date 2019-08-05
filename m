Return-Path: <SRS0=bWDR=WB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E98C32751
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 22:28:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437312070D
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 22:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj6hr5hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437312070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1C09313E4;
	Mon,  5 Aug 2019 22:28:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9458213DE
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 22:27:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 303BA5E4
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 22:27:59 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id g2so40351496pfq.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 05 Aug 2019 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=O7ol3Af3UOOFqacwpXB2Tkvb5T9+UO25EUzpB5YdSYk=;
	b=yj6hr5hxUJenkSZp1UcIBWxZj3uBMngG0g469BpTJOQyhnZXP4os/nIQjFlCi4nBfz
	BmQi7zHWfdgEQcyU2IoxT1TtoUQy2VEGrifPAPymP6nVJlvoowBiSMDNU7tTuW6U7P8t
	Ljvd48h3GMeSX4XMq5QvRDtvsfFM/s6fi0+inxDc3s3tIqKrvRJjMvyvd4EsQGLmg7AK
	XKyd/PMO6i5wrhTRy+5/w6cd1LHKXcDpudtK7EZcxJVVB+f99JoaDzQGznpXdjko0hPs
	4laB2/NlGZv487hyR6Iowl6ajy1SQiMhXKZKnNC6dqkySQWzX97V2x8QfcqVFF/FQD2f
	6+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=O7ol3Af3UOOFqacwpXB2Tkvb5T9+UO25EUzpB5YdSYk=;
	b=FPhgbAo29dhgooWNEFeyZqwQKvjOqoHx3ygf3J+Pbj4g3agx2PJgyR/jYaRZWprQlo
	YY5IAF+i9aLT2qTOcfG017mk3+TjQCb0hfe9sd5SNId7A306YSEZFwS6WsBXbbdX3erZ
	tcrkI5SczPh3A4opUwGs8xdDBNwsfMnGc2TORR17y0MtlN3Y63pbcAcn7NfLiEopXQm8
	qcFAN4/tSjtbV0MJD0Yq9N1Hk7/oy2p6hAOJ+gQsokHa3eE0thIOe7yL0buTcpcV+AWz
	BkT/zL7QVKXJk6TWu2m83TS7j26zGzFFj7weKXLa14s4mSkZmt7vhF4tAHL0ONd7fWMs
	ChxQ==
X-Gm-Message-State: APjAAAUS2n92EIArrx/yM3v2Q6ArK9Y6NoqTraSW3GsUopbUV/E+v4v3
	Ixs5fKcL4DDHA+VyjpLNlM5quA==
X-Google-Smtp-Source: APXvYqx3UxedQNr2C3bs2uHAldkFth/HQlaWKyEV0qOeCU3fPsEGSvQLw45fJ8MdFeTtVbj3iog84A==
X-Received: by 2002:a17:90a:2767:: with SMTP id o94mr9103pje.25.1565044078659; 
	Mon, 05 Aug 2019 15:27:58 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	a12sm20255316pje.3.2019.08.05.15.27.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 05 Aug 2019 15:27:58 -0700 (PDT)
Date: Mon, 5 Aug 2019 15:27:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 1/4] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
Message-ID: <20190805222755.GB2634@builder>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-2-vivek.gautam@codeaurora.org>
	<20190618175536.GI4270@fuggles.cambridge.arm.com>
	<CAFp+6iEwN6jeEGNxKVU5_i5NxdEbuF2ZggegEJZ1Rq6F=H34jg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iEwN6jeEGNxKVU5_i5NxdEbuF2ZggegEJZ1Rq6F=H34jg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
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

On Wed 19 Jun 04:34 PDT 2019, Vivek Gautam wrote:

> On Tue, Jun 18, 2019 at 11:25 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Wed, Jun 12, 2019 at 12:45:51PM +0530, Vivek Gautam wrote:
> > > There are scnenarios where drivers are required to make a
> > > scm call in atomic context, such as in one of the qcom's
> > > arm-smmu-500 errata [1].
> > >
> > > [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/
> > >       drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/
> > >       msm-4.9&id=da765c6c75266b38191b38ef086274943f353ea7")
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------------
> > >  1 file changed, 92 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> > > index 91d5ad7cf58b..b6dca32c5ac4 100644
> > > --- a/drivers/firmware/qcom_scm-64.c
> > > +++ b/drivers/firmware/qcom_scm-64.c
> 
> [snip]
> 
> > > +
> > > +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
> > > +                          struct arm_smccc_res *res, u32 fn_id,
> > > +                          u64 x5, bool atomic)
> > > +{
> >
> > Maybe pass in the call type (ARM_SMCCC_FAST_CALL vs ARM_SMCCC_STD_CALL)
> > instead of "bool atomic"? Would certainly make the callsites easier to
> > understand.
> 
> Sure, will do that.
> 
> >
> > > +     int retry_count = 0;
> > > +
> > > +     if (!atomic) {
> > > +             do {
> > > +                     mutex_lock(&qcom_scm_lock);
> > > +
> > > +                     __qcom_scm_call_do(desc, res, fn_id, x5,
> > > +                                        ARM_SMCCC_STD_CALL);
> > > +
> > > +                     mutex_unlock(&qcom_scm_lock);
> > > +
> > > +                     if (res->a0 == QCOM_SCM_V2_EBUSY) {
> > > +                             if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> > > +                                     break;
> > > +                             msleep(QCOM_SCM_EBUSY_WAIT_MS);
> > > +                     }
> > > +             }  while (res->a0 == QCOM_SCM_V2_EBUSY);
> > > +     } else {
> > > +             __qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
> > > +     }
> >
> > Is it safe to make concurrent FAST calls?
> 
> I better add a spinlock here.
> 

Hi Vivek,

Would you be able to respin this patch, so that we could unblock the
introduction of the display nodes in the various device?

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
