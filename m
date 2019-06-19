Return-Path: <SRS0=+KpI=US=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F5C31E49
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 11:34:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0BA2080C
	for <iommu@archiver.kernel.org>; Wed, 19 Jun 2019 11:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hB4pf4B4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="POTxE52t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0BA2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A40C114B;
	Wed, 19 Jun 2019 11:34:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 29E0D113F
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:34:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AE0417C
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:34:53 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76DF6602F2; Wed, 19 Jun 2019 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560944093;
	bh=+py4XI3i/cm9QGyA40QRB2rUzMIk0lUgUsy44TbCmWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hB4pf4B4OVpXEy8l93z1fgXcfIzXEaYqXqo/3dmAmjp1/zMY3f02pl3NA4yCo9ol1
	KZp5OOel0kSD3A6ZryQuKv9l/pvJd+0gy6G3OJ2FmBoGuhg/uP/oiF/A1sgztMJ/yu
	YiBctFwxPkSA+kzm7LASiX2qvMbN1yubpFLvAHcs=
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
	[209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 3726C608FC
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560944092;
	bh=+py4XI3i/cm9QGyA40QRB2rUzMIk0lUgUsy44TbCmWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=POTxE52tKhsJG+vjMMNQ2p5oRrP+rRaljcWwUC+A3JSkr2rvpJkYoNu7dQ5Rbcsht
	k4vLDVDs9rwMOBNIjUYJ0Lm6n5s7nZ1nC8Na0jAJIHFNwgQYjpc9a7DX0kd8qNNpGE
	tHQz0lokvIsUj+drqbfqt3Bs3FBPjsP8SyrLYI+c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3726C608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f54.google.com with SMTP id p15so26685816eds.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 19 Jun 2019 04:34:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVwuBCzaQL/OBgnxxwuqq5A8fzyhQ9US2PXicmXwcMTQUsqPhJE
	XXPvMppjx9fQbowxjtHfpVJfWqNaR1B53a8FQQg=
X-Google-Smtp-Source: APXvYqya/0GsL2StjgEiJLMyA9HmzxvSn4wjNxl+SCuHsa6xu0jYQ1AeSFdShTd/4VbcCeyO9S26gYnaP2uFrJFcOnE=
X-Received: by 2002:a50:b36e:: with SMTP id r43mr76818996edd.106.1560944091001;
	Wed, 19 Jun 2019 04:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-2-vivek.gautam@codeaurora.org>
	<20190618175536.GI4270@fuggles.cambridge.arm.com>
In-Reply-To: <20190618175536.GI4270@fuggles.cambridge.arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 19 Jun 2019 17:04:39 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEwN6jeEGNxKVU5_i5NxdEbuF2ZggegEJZ1Rq6F=H34jg@mail.gmail.com>
Message-ID: <CAFp+6iEwN6jeEGNxKVU5_i5NxdEbuF2ZggegEJZ1Rq6F=H34jg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
To: Will Deacon <will.deacon@arm.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
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

On Tue, Jun 18, 2019 at 11:25 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Jun 12, 2019 at 12:45:51PM +0530, Vivek Gautam wrote:
> > There are scnenarios where drivers are required to make a
> > scm call in atomic context, such as in one of the qcom's
> > arm-smmu-500 errata [1].
> >
> > [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/
> >       drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/
> >       msm-4.9&id=da765c6c75266b38191b38ef086274943f353ea7")
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 92 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> > index 91d5ad7cf58b..b6dca32c5ac4 100644
> > --- a/drivers/firmware/qcom_scm-64.c
> > +++ b/drivers/firmware/qcom_scm-64.c

[snip]

> > +
> > +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
> > +                          struct arm_smccc_res *res, u32 fn_id,
> > +                          u64 x5, bool atomic)
> > +{
>
> Maybe pass in the call type (ARM_SMCCC_FAST_CALL vs ARM_SMCCC_STD_CALL)
> instead of "bool atomic"? Would certainly make the callsites easier to
> understand.

Sure, will do that.

>
> > +     int retry_count = 0;
> > +
> > +     if (!atomic) {
> > +             do {
> > +                     mutex_lock(&qcom_scm_lock);
> > +
> > +                     __qcom_scm_call_do(desc, res, fn_id, x5,
> > +                                        ARM_SMCCC_STD_CALL);
> > +
> > +                     mutex_unlock(&qcom_scm_lock);
> > +
> > +                     if (res->a0 == QCOM_SCM_V2_EBUSY) {
> > +                             if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> > +                                     break;
> > +                             msleep(QCOM_SCM_EBUSY_WAIT_MS);
> > +                     }
> > +             }  while (res->a0 == QCOM_SCM_V2_EBUSY);
> > +     } else {
> > +             __qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_CALL);
> > +     }
>
> Is it safe to make concurrent FAST calls?

I better add a spinlock here.

Thanks & regards
Vivek

>
> Will
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
