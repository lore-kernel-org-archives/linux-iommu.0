Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE1C2B9F8
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 03:28:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283CB61423
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 03:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283CB61423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E196D83BF5;
	Tue, 25 May 2021 03:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oN2Yv5lHWxAk; Tue, 25 May 2021 03:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DABAC83B76;
	Tue, 25 May 2021 03:28:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2D6CC000D;
	Tue, 25 May 2021 03:28:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D282FC0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B951160617
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zkwvSGvwo-Qy for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 03:28:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C248B6059E
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 03:28:13 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id d21so28990904oic.11
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 20:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yd7WNrW5RgCRq69GG/t641RhzJb1+O9rCNuKEDYZ+UQ=;
 b=Qihz9q4ulhPC5+jW95HZeqBMuDCzCUu5BXI2aHGC/4iIT85jOP8Merwq+BoCPrrNFl
 MlvM+x81c5n+TIyIs8D1H+nQNU4q7QNzAI9dT25HByHl0DudUzzbP+m5k87rrr5Q9E2V
 v5XqwFV+m63TDEQPDv/hWb6ymRQnjJEmWX8UxwOq4fEA9/YflwcPI6/SYvL1XfI9wKyu
 MX7xrQyiZQxJU57vhRcGOGin7qf+2ErXPVy3Bvl/TmpmCk08rHdDvK3HHWdT5SKcFbKm
 Ngd5FveLSInfBtCMCRZDjCg1lBKeJGBrXkut5dcay1LhdzWu9x3oZnPqKeQ4HaT3Jee2
 3LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yd7WNrW5RgCRq69GG/t641RhzJb1+O9rCNuKEDYZ+UQ=;
 b=LV8cg2J+apCWeG8NrYvPPP08Ou2WE4xfKIgJuiDAMN3b9A0Qa/DAskjrymNv5ZI3D/
 J2KHBm+kC6FEMCB2vuOWKt6Mbcg/e07mRk0o24OAwHtn6543uIOZ+kO3UMHa+tNXKFhk
 cOr65G786PrRP9v1SO3xkoaQjnHll68Kas9vMajN9LWIzMPPfdDN2Fp4BOXTB0cqiQuz
 +dxrEsUhVstKoXwZ/dBZ8GG58Yx7pbd4ZioD/pfIFp9ySZC7xPpuAvFMbqFyA1CkwxT8
 9vjY+XLuhxq0DqOI5xtJxMxNNl2WeMQWLjo3O8m39x3v3WabqVSXVOXlgtWrDZ+wK778
 JEWw==
X-Gm-Message-State: AOAM530myUZDDDyaakv9DpwZWoORIc/KG2KQM0HR7skgPT8Tr+uUNsa0
 /+UTObm0sIbuRZxFmP1+6qawzw==
X-Google-Smtp-Source: ABdhPJwKviMyrxlplBS0akvECPGFTv+lWWT2whiGwA05wk4Af21kzQrXyzWmMbn4Mo/QH1n2F7KL+Q==
X-Received: by 2002:aca:4e8c:: with SMTP id c134mr1436989oib.169.1621913292614; 
 Mon, 24 May 2021 20:28:12 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id c19sm2990438oiw.7.2021.05.24.20.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 20:28:12 -0700 (PDT)
Date: Mon, 24 May 2021 22:28:10 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
Message-ID: <YKxuynamQBTrNksO@yoga>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
 <20200108091641.GA15147@willie-the-truck>
 <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
Cc: Patrick Daly <pdaly@codeaurora.org>, Will Deacon <will@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Pratik Patel <pratikp@codeaurora.org>
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

On Mon 24 May 07:03 CDT 2021, Lee Jones wrote:

> On Wed, 8 Jan 2020 at 09:16, Will Deacon <will@kernel.org> wrote:
> 
> > On Thu, Dec 26, 2019 at 02:17:06PM -0800, Bjorn Andersson wrote:
> > > These patches implements the stream mapping inheritance that's necessary
> > in
> > > order to not hit a security violation as the display hardware looses its
> > stream
> > > mapping during initialization of arm-smmu in various Qualcomm platforms.
> > >
> > > This was previously posted as an RFC [1], changes since then involves the
> > > rebase and migration of the read-back code to the Qualcomm specific
> > > implementation, the mapping is maintained indefinitely - to handle probe
> > > deferring clients - and rewritten commit messages.
> >
> > I don't think we should solve this in a Qualcomm-specific manner. Please
> > can
> > you take a look at the proposal from Thierry [1] and see whether or not it
> > works for you?
> >
> 
> Did this or Thierry's solution ever gain traction?
> 

There was a few pieces that landed in the common code which allowed us
to deal with the quirks of the Qualcomm platform (turned out that just
reading back the settings wasn't the only piece necessary).

The "generic" solution is essentially the second half of
qcom_smmu_cfg_probe(), which ensures that as the SMMU is reset it will
do so with bypass mappings for all stream mappings the boot loader left
us.

> Or are all the parties still 'solving' this downstream?
> 

I believe that Qualcomm has adopted the upstream solution in their
downstream kernel.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
