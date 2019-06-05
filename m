Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA5C28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 16:17:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78302206B8
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="AUPZGFVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78302206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 49CDECA6;
	Wed,  5 Jun 2019 16:17:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0BE69CA5
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 16:17:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 92EEF879
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 16:17:46 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id q26so19553016lfc.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 05 Jun 2019 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:organization:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=INpfTRXsx/ERh1DGBQzxYmwH3X7MJEUMkIUVZyxdfjI=;
	b=AUPZGFVJuGGoWX4JkXEWzQ4Ca5JpLMAYEQlnWcEOrLpLWVi8BCDdjz4H+V9svJ3zM8
	d7p8N9WzKRzG6tgEl8OFj2OEKsneuHpCcgk3lBv9eL1IE+fhLYBo5f98rv/bJ1mB9noh
	mZ3zywdBQgeARjzYDviYLHZ0EURs4p6H5gsnEGx2gPEtlg6HxYz9HmRjxPI8a8+5zcej
	9sYJrfG+ay8XIcUJ73tInI5Nkz9CIP10gaOhIwXP1gTQvozIjS62KJuBGlg6poc4w7rh
	qvy1j84u3uMQb9QrEehh7EovRZVGqXJF0ZgYk1CXrNZuTPd+euKUlze/zkKiIuUFyUJl
	oNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:organization
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=INpfTRXsx/ERh1DGBQzxYmwH3X7MJEUMkIUVZyxdfjI=;
	b=jLywlEVeZU8RtSA5nw8Oz9/2f3atIMRDaetrpLZ4EkAikj6xI8Orth5ApP9ZA5hxFX
	dJoeEsT0vQcpyl4H90YZO5GooVc/UQuUn2XZSzS0sBg2I57Yi0IMy4pLl4qgMb8LtfFb
	Kw0G94tfpKmttzfDRFsqXABs5SV2GzfAu4S/Iar/uPUnC1Kug2SLSlnSmEC2GMzztanu
	hdBL+XeNAMS1f7hZHazRJBOklbIpFBNDCIjwbJqBJrGQiVx3LXM19n31NmBa4tvF0HHK
	opbmoC/z3YmsQYHc5CPAzzJ+jkU0qgzE6fURtRmuIkTIFJUzXjPmglwa03hLwWcb+3ks
	HVKA==
X-Gm-Message-State: APjAAAWCDXiu9FmujrfF7KCcMmgUFNuE+1kMN+kWhtevoXQYY3UoT7T4
	jAC5vvKCaPLuHDJWQ0ybj7pEtA==
X-Google-Smtp-Source: APXvYqw5hdVCwy5gFQZPJeHntxyHuMeSYJHFFKduDzX2eKKxfZUS7DZaah4XpCwx9LGzEtiN4fKfQw==
X-Received: by 2002:ac2:4202:: with SMTP id y2mr3595252lfh.178.1559751464942; 
	Wed, 05 Jun 2019 09:17:44 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.82])
	by smtp.gmail.com with ESMTPSA id k17sm352187ljk.5.2019.06.05.09.17.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:17:44 -0700 (PDT)
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <35f63f36-ea4d-850f-8a59-805e67c06b68@cogentembedded.com>
Date: Wed, 5 Jun 2019 19:17:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-MW
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-mmc@vger.kernel.org
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

On 06/05/2019 02:11 PM, Yoshihiro Shimoda wrote:

> This patch adds a new capable IOMMU_CAP_MERGING to check whether
> the IOVA would be contiguous strictly if a device requires and
> the IOMMU driver has the capable.

   s/has/is/? Or capable what?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++--
>  include/linux/iommu.h     |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 034caae..ecf1a04 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[...]
> @@ -867,6 +872,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  		sg_dma_len(s) = s_length;
>  		s->offset -= s_iova_off;
>  		s_length = iova_align(iovad, s_length + s_iova_off);
> +		/*
> +		 * Check whether the IOVA would be contiguous strictly if
> +		 * a device requires and the IOMMU driver has the capable.

   Same question here...

> +		 */
> +		if (iova_contiguous && i > 0 &&
> +		    (s_iova_off || s->length != s_length))
> +			return 0;
>  		s->length = s_length;
>  
>  		/*
> @@ -902,8 +914,18 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
>  		goto out_free_iova;
>  
> -	return __finalise_sg(dev, sg, nents, iova);
> +	ret = __finalise_sg(dev, sg, nents, iova);
> +	/*
> +	 * Check whether the sg entry is single if a device requires and
> +	 * the IOMMU driver has the capable.

   You  meant capability perhaps?

[...]

MBR, Sergei
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
