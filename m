Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E4C7618B
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 08:17:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED03223BB
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="b7Csj3G5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED03223BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E84FB79;
	Tue, 23 Jul 2019 08:17:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C4F3A2C
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 08:17:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1938FF1
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 08:17:43 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id c9so28646868lfh.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=kG+OzI+z87Zf3fJp+hPCemews8fd4ihzvjTAjUmHLho=;
	b=b7Csj3G55G/5GJnEP82ndC4wvbhEB82fiHfvbh8iXu0JtNiwVid5uIw7S+TQuJUzm4
	Yxpk4Gq5jUXw1glHWI4hD0vNOhj9cdmiT1MDpzVICccDPJX5+zxEAFCVb57tzZjdvUhD
	bx+PKItfq/g9p42xn81XB9RkIF/28h4Gr3LNQickg7Sf/9T8MIFfxQqrX18J8gFQsdYQ
	EgljPUkfkjB8nUs+BiclkxXD2wvhU9UOjXjGMJmxS65H0XRyWZwazKc/Ed8O9Vidt1dX
	eN5WwDPC3PU6iD3rWQLJ2il8joK1WEE2VlSgcME5V08cZqjcyEi0Om1Zmms7LVOKDREH
	vcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kG+OzI+z87Zf3fJp+hPCemews8fd4ihzvjTAjUmHLho=;
	b=ZrJmYRJ0z278jDjFoBIK/4mq50voOhQ+ZTD4nmmnVpmUpp1/7Ayl7DDzs89xxI9NTC
	5PyRnyzPTffC0ukwlmibOr4u/j+G5py2Xb3jIrRQuVqVW9R6R0HpDeebLGCBN4JN1VvY
	pJGJHoKc+3O15UjTU8nfye+XB/ly2FUeQbvOqERgwYQZimofqS/UFG7LILb53xx5R/4J
	A/60YWZR0lKjADkVIzdIlBd9UU+ToHduhCKk8G0Z/EWJc3OBQ/XjVca/YNOlEggRZrCq
	8OwEPT7FSLJ8WDv7LYy/KsRIm0iNs7j7w9jcXoijzOAWCdfk6S+iekNxyWvbLW2Zuaxh
	12LQ==
X-Gm-Message-State: APjAAAWQvphjjVqx+8oOMtn1oHeaiKr02U6W6E2IIwVJ9C58XFNmYVtr
	TS+zRbn3V6/BWvatncmvIBtM8Q==
X-Google-Smtp-Source: APXvYqxGSeEsBpTjFz56E331Sz1Uf1zr152A+X0wCTd9x1epLW3KOc4iQknOO6i0QucClN2gWuZziw==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr33684786lff.81.1563869861549; 
	Tue, 23 Jul 2019 01:17:41 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:643:1083:8131:627b:cb64:c17a?
	([2a00:1fa0:643:1083:8131:627b:cb64:c17a])
	by smtp.gmail.com with ESMTPSA id
	m21sm7770031ljj.48.2019.07.23.01.17.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Jul 2019 01:17:40 -0700 (PDT)
Subject: Re: [PATCH v8 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, joro@8bytes.org, axboe@kernel.dk
References: <1563859608-19456-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1563859608-19456-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ae95cc2e-38b4-0ed9-744a-67f03f220a3f@cogentembedded.com>
Date: Tue, 23 Jul 2019 11:17:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563859608-19456-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
Cc: linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hello!

On 23.07.2019 8:26, Yoshihiro Shimoda wrote:

> This patch adds a new dma_map_ops of get_merge_boundary() to
> expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/iommu/dma-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a7f9c3e..f3e5f2b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	return ret;
>   }
>   
> +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA)
> +		return 0;	/* can't merge */
> +
> +	return (1 << __ffs(domain->pgsize_bitmap)) - 1;

    Not 1UL?

> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
[...]

MBR, Sergei
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
