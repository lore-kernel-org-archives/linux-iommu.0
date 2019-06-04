Return-Path: <SRS0=MUIX=UD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BABEC282CE
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 23:41:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F632070B
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 23:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k97nBHkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F632070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 11D48C97;
	Tue,  4 Jun 2019 23:41:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 411EB7A4
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 23:41:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D937A19B
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 23:41:06 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id g69so8968101plb.7
	for <iommu@lists.linux-foundation.org>;
	Tue, 04 Jun 2019 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=PEW0YI52v17ROAEu88+lgWes0aNQUTZHMT31ckUQV0Y=;
	b=k97nBHkWVfd4b6neMJHJ1ikRwOa0Dnrb283GaiQ9vr42eeTi4Bzx6eCgd+XwXVRSHQ
	+onY9F03ZXXkt961UHeohcEMV+3oVQjVMP8xX5A5k2iFczJ8DXypJQjgkI6Y0qM4JS/K
	X6xlrAgYcrnXayME8/5i7jtCSAS9PDoDxUXeIuPik6D3MpMv/zhxeVc2gd9oChlT0ywk
	WLa+Ici1IoaTqRUddVaU+Bo3ZPhwVoZEoTDhExOOelm9e4OIM3C7JYQ+uXAByKwZJAdQ
	j8E891XgJw6IGm1muVCiqTp+SlMuul/l0INLSkvimO8nHpLf8Va+JU3vk4R98MYNb2xr
	CbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=PEW0YI52v17ROAEu88+lgWes0aNQUTZHMT31ckUQV0Y=;
	b=hDXCyYrXPxdVvdlGIbn6y3uT5o00DQXzoHbhmhrONad7KQPdS2U9KUdCz+eDtRgGU3
	b/HxnZ1DhwcckjpOfokzwPMheJ10P2IP10PfBsWge80T6JPwGk/paPpj5eVmLKYGdUAp
	Cs7ZjfZa/I87NZyj+9fDjbtzcEBtl9k4+UTQWHlwWIaHxYoptVyYlWztz+RHlZruoZcx
	74eFsN93EfhXtD5/wt/lRSRRCSi887Z7/P8wm90vejx6kT3aO6cJIostRuGlNgv3s8Ri
	KwAf/GlzFkx9DsGgkgTtfHMuZIWn/lbzesLGVJvdTBgbpjN+Ncp8WeXnjlCWg/phFVf0
	/nqg==
X-Gm-Message-State: APjAAAVxNl0SGTxS9Dh6I0TuB4X2Yvi/UzumXrviob8EurWdtCLr6Bbh
	y9kFg9bEoVqfLkdH4o+veteq6Q==
X-Google-Smtp-Source: APXvYqwB9Rs6qdMKX9gf7PQIrUTJvFAVQlDRxbVsBIYlA6lXkdsejqKkUUFki/Do31p/eXmdrr7tew==
X-Received: by 2002:a17:902:d916:: with SMTP id
	c22mr14264492plz.195.1559691666284; 
	Tue, 04 Jun 2019 16:41:06 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	a9sm17192793pgw.72.2019.06.04.16.41.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 16:41:05 -0700 (PDT)
Date: Tue, 4 Jun 2019 16:41:03 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: io-pgtable: Support non-coherent page tables
Message-ID: <20190604234103.GH4814@minitux>
References: <20190515233234.22990-1-bjorn.andersson@linaro.org>
	<CAFp+6iEMQd1uAWdkLysYWt0et8eRojoivG6+e78y0DU+4=H+_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iEMQd1uAWdkLysYWt0et8eRojoivG6+e78y0DU+4=H+_g@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Vivek Gautam <vgautam@qti.qualcomm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed 15 May 23:47 PDT 2019, Vivek Gautam wrote:

> On Thu, May 16, 2019 at 5:03 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Describe the memory related to page table walks as non-cachable for iommu
> > instances that are not DMA coherent.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 4e21efbc4459..68ff22ffd2cb 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -803,9 +803,15 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> >                 return NULL;
> >
> >         /* TCR */
> > -       reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +       if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) {
> > +               reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +                     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > +                     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +       } else {
> > +               reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > +                     (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > +                     (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT);
> > +       }
> 
> This looks okay to me based on the discussion that we had on a similar
> patch that I
> posted. So,
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> [1] https://lore.kernel.org/patchwork/patch/1032939/
> 

Will, Robin, any input on this patch?

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
