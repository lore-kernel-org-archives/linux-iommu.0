Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D7CA9ECF
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 17:41:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0AB20869
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 17:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUu1FmB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0AB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 73DCECAC;
	Mon,  4 Nov 2019 17:41:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B26FB7A
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 17:41:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9481C5D0
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 17:41:34 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 29so466709pgm.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 04 Nov 2019 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=lPIDgQKTrSezXBvWSPccLapRG8yo6gcHIljKbjtAJu0=;
	b=CUu1FmB3LjsCLSEP705SvIqj35uHr2X5ys8TEcTirMe4Xm0h+XWqfzbWLbA/hhtDBw
	eBlTxyj2xuSt7s0M3YUzkirkkX9V7uBiKPkWbfNsrubIH3WrdU/9DABtq8wDPUrFQXkG
	7ibo3Z1mBB3nyR9Q4tDPS0IrWjhg5zGf+d0yp+PbZyYuez8PqSX81RKDIMG4OY6FkQ0/
	ml3xQhwX4iBRmcnHBGtOrWcysVepLJo7C8TxzAl3LFclFOH9MxW3uoDksButKbroYTKP
	DO6Mo6b1c/qIjgpNcBQx7oTHpiAiZXJf6ppiFLI8Bm25SiQMVIEKLEQE+58JBZg+pY2/
	YEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=lPIDgQKTrSezXBvWSPccLapRG8yo6gcHIljKbjtAJu0=;
	b=pKQHyeFDm5UsqGuMsZbkX5E/55Megr0AORD/8y/oG1IfERyDuozpOhprxgAOgnr+QX
	6LwpX1o3+xU7uaaVDKSeZ5lzCUEiQih1iFi01wC1L4lBzyHh7h8dx5EoAU2XVoj0fT73
	wEZsDGbsrQ79pVts6wFqBf3vXLelo9i0NYzT7nVuDd2xhuo77EVKStnAHOkOeA0Q3He+
	DYkx6AEOVuSWz2jP3mKoGTC4BukuUb80XNC3GciXVV6MCh5prs0w7vwhDOS2bvKQQFVP
	S+s66tVJwRrOoQ+fAj2kwSkpOfh+GwO4ZGloUiqVZQ90rqJX3R3c9wTfqXHkuYIGBuWi
	AzcQ==
X-Gm-Message-State: APjAAAU03PWgITHaZc185UyiJ5PeKZXH4U8eH+YxoabgvlrxlTxAVGmX
	J7dJfSykFGZ5ODgNGbC5NWvZow==
X-Google-Smtp-Source: APXvYqzzZ+dkZOr3JoygRmb96xE/xUJESRhqGzvY+WG7dsAngzbq/NLr5tF1PTBC6l38feevSQDYnQ==
X-Received: by 2002:a63:b62:: with SMTP id a34mr11473288pgl.123.1572889293842; 
	Mon, 04 Nov 2019 09:41:33 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	v14sm11345300pfm.51.2019.11.04.09.41.32
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 04 Nov 2019 09:41:33 -0800 (PST)
Date: Mon, 4 Nov 2019 09:41:30 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
Message-ID: <20191104174130.GA586@tuxbook-pro>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<20191101163136.GC3603@willie-the-truck>
	<af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
	<20191101172508.GB3983@willie-the-truck>
	<119d4bcf5989d1aa0686fd674c6a3370@codeaurora.org>
	<20191104051925.GC5299@hector.lan>
	<20191104151506.GB24909@willie-the-truck>
	<20191104162339.GD24909@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104162339.GD24909@willie-the-truck>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm-owner@vger.kernel.org
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

On Mon 04 Nov 08:23 PST 2019, Will Deacon wrote:

> On Mon, Nov 04, 2019 at 03:15:06PM +0000, Will Deacon wrote:
> > On Sun, Nov 03, 2019 at 11:19:25PM -0600, Andy Gross wrote:
> > > On Fri, Nov 01, 2019 at 11:01:59PM +0530, Sai Prakash Ranjan wrote:
> > > > >>> What's the plan for getting this merged? I'm not happy taking the
> > > > >>> firmware
> > > > >>> bits without Andy's ack, but I also think the SMMU changes should go via
> > > > >>> the IOMMU tree to avoid conflicts.
> > > > >>>
> > > > >>> Andy?
> > > > >>>
> > > > >>
> > > > >>Bjorn maintains QCOM stuff now if I am not wrong and he has already
> > > > >>reviewed
> > > > >>the firmware bits. So I'm hoping you could take all these through IOMMU
> > > > >>tree.
> > > > >
> > > > >Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
> > > > >run:
> > > > >
> > > > >$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c
> > > > >
> > > > >in linux-next, I get:
> > > > >
> > > > >Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> > > > >linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> > > > >linux-kernel@vger.kernel.org (open list)
> > > > >
> > > > 
> > > > It hasn't been updated yet then. I will leave it to Bjorn or Andy to comment
> > > > on this.
> > > 
> > > The rumors of my demise have been greatly exaggerated.  All kidding aside, I
> > > ack'ed both.  Bjorn will indeed be coming on as a co-maintener at some point.
> > > He has already done a lot of yeomans work in helping me out the past 3 months.
> > 
> > Cheers Andy, and I'm pleased to hear that you're still with us! I've queued
> > this lot for 5.5 and I'll send to Joerg this week.
> 
> Bah, in doing so I spotted that the existing code doesn't handle error codes
> properly because 'a0' is unsigned. I'll queue the patch below at the start
> of the series.
> 

Thanks, I've hit this a few times but missed this and assumed it was a
firmware issue...

In case you haven't published your branch:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Will
> 
> --->8
> 
> From a9a1047f08de0eff249fb65e2d5d6f6f8b2a87f0 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Mon, 4 Nov 2019 15:58:15 +0000
> Subject: [PATCH] firmware: qcom: scm: Ensure 'a0' status code is treated as
>  signed
> 
> The 'a0' member of 'struct arm_smccc_res' is declared as 'unsigned long',
> however the Qualcomm SCM firmware interface driver expects to receive
> negative error codes via this field, so ensure that it's cast to 'long'
> before comparing to see if it is less than 0.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/firmware/qcom_scm-64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> index 91d5ad7cf58b..25e0f60c759a 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -150,7 +150,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
>  		kfree(args_virt);
>  	}
>  
> -	if (res->a0 < 0)
> +	if ((long)res->a0 < 0)
>  		return qcom_scm_remap_error(res->a0);
>  
>  	return 0;
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
