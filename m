Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF9C433E6
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 08:33:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BFC2078A
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F33cEkQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BFC2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ED817203CF;
	Fri, 28 Aug 2020 08:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yymeAB00LlUt; Fri, 28 Aug 2020 08:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 807502033E;
	Fri, 28 Aug 2020 08:33:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED5CC016F;
	Fri, 28 Aug 2020 08:33:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0ACAC0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 08:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9691085108
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 08:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SmmAGYwfxVYP for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 08:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ACF11850E9
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 08:33:44 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id si26so412025ejb.12
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aWZAytbmX0Vm3i5CPdD+jnsy7n2gqIJ4osAjPvZBaE0=;
 b=F33cEkQkRfT4GWOH831j1SLO974KU2Qk19Z5cppU8g6UQ736Ncx8i1BbmBvQvKIT30
 HBUBXGBQGGPT39+olnEp0xNW2l4DYQmS+N9hhGw8KVudm+A+lfEJcrKQiypZbXo21HcR
 zIxMFFpXhmC8YFO65TJMRs7ZwiG7xpBSiRBXlqsBTqqdhhDdrYKISEn6QT/af7CehVFf
 1LqsSDnZW30suRZ/9eLa7yAohIISXi8WFhKpTFAnwW58Bv9FqFePi0GbIdjbiNW7Y6gp
 PNgvlR51lAy0YWYUto/Pbh/CjkVRR9NNM7QeSjlWAzFEtJcODCvgiBArQ9W7XByluh4L
 iKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aWZAytbmX0Vm3i5CPdD+jnsy7n2gqIJ4osAjPvZBaE0=;
 b=DMNx+1Y2U1YhXKW1782RoEYxTFZihqTfel+TCsdpR7J/bCYBM+iKT4LSwn/ZlznfcN
 UvebShPPBWJ93mRlIYMT5gJlpBGuBUV7trqQFPyru8W2ciOYBQrktmUBEbr9jdBiGuGK
 tvREsmX5BVpU+jIwk7SWm/8ye6AnB5JVVAXGrApC7ZBs76aOui7CqFIMkGFkn9FeXTHo
 adA/LmrAzrrB+tRf77XMr6L9TM4dBIGeFLgCn+txFU4TjwVTLBmtJh3HZjH4XBQJbWWa
 8D1I7XH/v55bKU9BpW3IBEj2KRH6EjiMtUvltW7JWVoECqLsjl2inrMqzJ8VTDtTv6Cx
 fkWQ==
X-Gm-Message-State: AOAM530lhbCRuiSVAHlKwzLxQPpj/kvFBaAGizTN0zZ1pqBPW16J+kMs
 4s6PMvqamzC6XFPppf3psogb+Q==
X-Google-Smtp-Source: ABdhPJxVMLCYOpD/z5IxTq8PmxExD3cog9AnNXWCZAE7Kgc+uU+vxaRxHYZ5VXmKpSCyoYhFXwkWUg==
X-Received: by 2002:a17:906:7f0b:: with SMTP id
 d11mr730770ejr.116.1598603622909; 
 Fri, 28 Aug 2020 01:33:42 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id ci27sm308673ejc.23.2020.08.28.01.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 01:33:42 -0700 (PDT)
Date: Fri, 28 Aug 2020 10:33:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for cmdq_issue_cmdlist
Message-ID: <20200828083325.GC3825485@myrica>
References: <20200827093351.15244-1-song.bao.hua@hisilicon.com>
 <20200828074107.GB3825485@myrica>
 <f8f00caacc774c79b7c0c7a39abf795f@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8f00caacc774c79b7c0c7a39abf795f@hisilicon.com>
Cc: "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, Aug 28, 2020 at 07:55:18AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Jean-Philippe Brucker [mailto:jean-philippe@linaro.org]
> > Sent: Friday, August 28, 2020 7:41 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> > robin.murphy@arm.com; will@kernel.org; Linuxarm <linuxarm@huawei.com>
> > Subject: Re: [PATCH] iommu/arm-smmu-v3: add tracepoints for
> > cmdq_issue_cmdlist
> > 
> > Hi,
> > 
> > On Thu, Aug 27, 2020 at 09:33:51PM +1200, Barry Song wrote:
> > > cmdq_issue_cmdlist() is the hotspot that uses a lot of time. This
> > > patch adds tracepoints for it to help debug.
> > >
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > ---
> > >  * can furthermore develop an eBPF program to benchmark using this
> > > trace
> > 
> > Have you tried using kprobe and kretprobe instead of tracepoints?
> > Any noticeable performance drop?
> 
> Yes. Pls read this email.
> kprobe overhead and OPTPROBES implementation on ARM64
> https://www.spinics.net/lists/arm-kernel/msg828788.html

Thanks for the pointer. I'm asking because I've been working on BPF
trampolines (fentry/fexit) for arm64, which reduce the overhead of BPF
tracing, and am looking for confirmation that it's needed before spending
more time on it. Perhaps OPTPROBE would be a better first step, though, it
seems more generic.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
