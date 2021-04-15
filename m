Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECAFC433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 15:15:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0C613BB
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 15:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0C613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B6D783B47;
	Thu, 15 Apr 2021 15:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQT9OD8ktLs2; Thu, 15 Apr 2021 15:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D93283B9C;
	Thu, 15 Apr 2021 15:15:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5D48C0014;
	Thu, 15 Apr 2021 15:15:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C3B8C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 15:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89E4040236
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 15:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TFnTFiRKwiYv for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 15:15:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A28EF40235
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 15:15:39 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id w23so21600259ejb.9
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QxiyvjJPiB2Y4EOeSIHNj8hpwn+sjnpoz3M6C8GXS3M=;
 b=O0nkOIGnpFaRAssZYNEIk81uAcj99Wr6/y7tBtzmDgplIx/bG+w0m5HpylOM7zKfbN
 uHn3xqBih8pNE6ArUg4Om7atp077ctzsa6CyhHJyhQiKgVR1YIyCqNZ2zJawoqZQknLM
 0YNfVLQZibhE9gFjjIVn7ofmIVksXMbNlN1Fy59tLK9s0qzJvzEq1AnF21zJi/qW1RJq
 RggL57CInaeyYR+eDcRv42ciOo3LqmEDz9yohXCxuqgNXmaPFpDM2lIf8DrKkSrdEaSX
 z6gagP0hCqZ6QwMu8Jq0c5d5WVXasijwcqUBZl5c5Xo2PkimylvP68S576x+mLVNFtkT
 dPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QxiyvjJPiB2Y4EOeSIHNj8hpwn+sjnpoz3M6C8GXS3M=;
 b=GbdwEVXsF/lclSNssUQGQfsGN/Q4CN2n4gsYBLbf2KE2pYor9Nk2sfF47aCUOUEAKr
 pqFV9usS0awLzP6pn2Z+YQCNFbHxZHimAF2R2vaJ98dqXuS5WyaFWLPv5l+Ah6IFrefu
 4AfB+Ki4tHRbhjvO39xUkeb3b9GRE3hNsbXOfowPQ1Fvs7XAV3UXl474c/22GF2dPNIj
 j1P0JHyapUmotHRuo061P12HnhVvQSsMoWWasWlIA50NHdjltSxWCEliOOgf1o1tfgvJ
 s45aHdwLsiK5zyBaLUVwyypuYUGaQrGBMQBYxogTQj22c2MRqrza1uxoumi3un+Nb7dc
 /c1Q==
X-Gm-Message-State: AOAM531Qj/PqoP63rsvy83gZ2lQIrfd4AmrURWSj3d7Hp3lafMJQBxio
 sxRQnseMVWJvcZm0Li0O8jG5ag==
X-Google-Smtp-Source: ABdhPJyfZaSsTEBlsYQzvBqBRq9S0zR0zrehiJ7ShidHNrcB2Rr4w/1VJiSlSEIhmoaqHLlfzben7g==
X-Received: by 2002:a17:906:944c:: with SMTP id
 z12mr3857507ejx.398.1618499738021; 
 Thu, 15 Apr 2021 08:15:38 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id bs10sm2854236edb.8.2021.04.15.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 08:15:37 -0700 (PDT)
Date: Thu, 15 Apr 2021 17:15:18 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <YHhYhoDn3zQ9MaGB@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
 <20210318142709-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318142709-mutt-send-email-mst@kernel.org>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, rjw@rjwysocki.net,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org,
 lenb@kernel.org
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

On Thu, Mar 18, 2021 at 02:28:02PM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 16, 2021 at 08:16:54PM +0100, Jean-Philippe Brucker wrote:
> > With the VIOT support in place, x86 platforms can now use the
> > virtio-iommu.
> > 
> > The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> > themselves.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > ---
> >  drivers/iommu/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 2819b5c8ec30..ccca83ef2f06 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -400,8 +400,9 @@ config HYPERV_IOMMU
> >  config VIRTIO_IOMMU
> >  	tristate "Virtio IOMMU driver"
> >  	depends on VIRTIO
> > -	depends on ARM64
> > +	depends on (ARM64 || X86)
> >  	select IOMMU_API
> > +	select IOMMU_DMA if X86
> 
> Would it hurt to just select unconditionally? Seems a bit cleaner
> ...

Yes I think I'll do this for the moment

Thanks,
Jean

> 
> >  	select INTERVAL_TREE
> >  	select ACPI_VIOT if ACPI
> >  	help
> > -- 
> > 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
