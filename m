Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A0DC433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 14:42:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D596108E
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 14:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04D596108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF1C6404AD;
	Tue, 28 Sep 2021 14:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFS7TRVDxWk0; Tue, 28 Sep 2021 14:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A44D403C0;
	Tue, 28 Sep 2021 14:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7518CC0011;
	Tue, 28 Sep 2021 14:42:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27ADEC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 14:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09F90401CB
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 14:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAt8KSMNUpY5 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 14:42:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1B4D400C5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 14:42:13 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 k11-20020a4abd8b000000b002b5c622a4ddso1900810oop.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EhyfaFfmpYzLgiWiMX1s0Z67f4LnrHK0KizRdjLnqJw=;
 b=chZAM6VPfyeAr8nqg4SrTVeBKQVNy32nK0MCL9hXLqYHkCSaBIuCY4L9340PwMXY81
 oX7KSMtTXh9aMON1lHCK0x3P5EwD2uawm9OkvBX4/0RXdgLlydme/qvFUvgvv9WA9Sv/
 Yz21N3KSQUS2EZKolBII/gB4UKw+N3eLKo52na8cVvsAJ+Qc2SeaGzdn8hRPrSmtLUIP
 aRpX80YJRQ8nBCKprXegn9SXbCfxmYUl3oIwG6UYYMLCsBzmBW5xMWFkV25U8SWzllts
 kIxnMRI6kDbq5RYBmMNwi7Wlv9DpyqfjkDB7DdGDvHHixU/+azKq4y+P+1z9W+Dxdw1N
 bQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EhyfaFfmpYzLgiWiMX1s0Z67f4LnrHK0KizRdjLnqJw=;
 b=xvakYAk80zNk/4QjKM3OmGqvZFPZbcP84cYXQGrvFLSfAu+C+kDy7aHZ/i84hoV0oV
 IWvbv5FYDi2ZIL0TETF+syo8CSjTubRvRMoJsO+pP+rarrlyZs1y9S+wvlNaDRHC6ads
 Rza+jL53XLi6N033C0jguLbS/mORrKZxWYdRsmeepJ7gCUroFvSi8MWnlGmACRyLsAmm
 um1Ms1SYdoGXUxO3CDCt6SjV+2b92SZK2ZT8AyeC12Ndx7CzWUvFHOsN5I9lX19rQHyj
 oGxM/zsdNSxaX5NhLVyEcNRUb6lahAnvO4SQ71O/Z3IaLzVieBmLXUxv94p5glS1bjnX
 /Lpg==
X-Gm-Message-State: AOAM531Gednh188dWlGaIbDIkjVVNdhoyElfmC8FZcg/4y1h811IDJiY
 9fIDoK6kr3ZgOHf17BofZYu8elrFDQY/wNF79WDAqQ==
X-Google-Smtp-Source: ABdhPJxsyNViSzziMqVNWC0HCL2fNBAjJtzRxqsLj/BUr+opO/6Yx5+T1yeJwLyWxMocosrCzkw74g3ptylH1JuvRA0=
X-Received: by 2002:a4a:88e2:: with SMTP id q31mr5127880ooh.91.1632840132764; 
 Tue, 28 Sep 2021 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-4-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-4-ben.widawsky@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 Sep 2021 07:42:00 -0700
Message-ID: <CAPcyv4jZUiwqGrYGX3Mmj9XqUvZwZwh79wAQTFxf5g+wZOohtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] cxl/pci: Remove pci request/release regions
To: Ben Widawsky <ben.widawsky@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-cxl@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Kan Liang <kan.liang@linux.intel.com>
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

On Thu, Sep 23, 2021 at 10:26 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Quoting Dan, "... the request + release regions should probably just be
> dropped. It's not like any of the register enumeration would collide
> with someone else who already has the registers mapped. The collision
> only comes when the registers are mapped for their final usage, and that
> will have more precision in the request."

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Recommended-by: Dan Williams <dan.j.williams@intel.com>

This isn't one of the canonical tags:
Documentation/process/submitting-patches.rst

I'll change this to Suggested-by:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccc7c2573ddc..7256c236fdb3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -453,9 +453,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 return -ENXIO;
>         }
>
> -       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> -               return -ENODEV;
> -
>         /* Get the size of the Register Locator DVSEC */
>         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> @@ -499,8 +496,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 n_maps++;
>         }
>
> -       pci_release_mem_regions(pdev);
> -
>         for (i = 0; i < n_maps; i++) {
>                 ret = cxl_map_regs(cxlm, &maps[i]);
>                 if (ret)
> --
> 2.33.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
