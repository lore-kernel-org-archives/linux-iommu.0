Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5973EC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 17:16:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A9D22CE3
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 17:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIs9UEkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9D22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1456ABDC;
	Tue, 20 Aug 2019 17:16:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E16D2B1F
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:16:55 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A4AE987
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:16:55 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
	[209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 63B3F233A1
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566321415;
	bh=36RoA+pZe09a0o8vSPVqwWADJLZpVfbMeIU9BV28nPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XIs9UEkSMvPxBnsd53e7jkN5NEI5/C7h8Ir8aLbuMxhu90HRaE3Sc6lc/xzj2MrL1
	xUG8N1AvPqsw4DNAuxtwFWd/cIXDpfFE4tkp1UYhSdi86yw4x7vtkpqKGbI3cr0Q2O
	KYpy6aYY3wEO3cToKeoOX0ItD4JzAtZeq59NctvU=
Received: by mail-qk1-f171.google.com with SMTP id d23so5147158qko.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 10:16:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUVc5sr2+MlJlmCKQYTyDOZFWDadLACsxWQn474KlXZhbcRIMqW
	P26WkWeeBx/HLnl9qggcP/turhGpoSWc7fv/ng==
X-Google-Smtp-Source: APXvYqwuF+PJndb+CroZT1MS5j54H47bxzE6ji7aLqlNUTkFV6I2ExfzQp8zw3/DWgp/8UNkiC1AWu81liXi+Rz7vJg=
X-Received: by 2002:a37:6944:: with SMTP id e65mr24769246qkc.119.1566321414471;
	Tue, 20 Aug 2019 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
	<20190820145821.27214-4-nsaenzjulienne@suse.de>
In-Reply-To: <20190820145821.27214-4-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 20 Aug 2019 12:16:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Message-ID: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible function
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
	devicetree@vger.kernel.org,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frank Rowand <frowand.list@gmail.com>, Eric Anholt <eric@anholt.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
	Matthias Brugger <mbrugger@suse.com>, Stefan Wahren <wahrenst@gmx.net>,
	linux-riscv@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, phill@raspberryi.org
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

On Tue, Aug 20, 2019 at 9:58 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Provides the same functionality as of_machine_is_compatible.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> Changes in v2: None
>
>  drivers/of/fdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9cdf14b9aaab..06ffbd39d9af 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -802,6 +802,13 @@ const char * __init of_flat_dt_get_machine_name(void)
>         return name;
>  }
>
> +static const int __init of_fdt_machine_is_compatible(char *name)

No point in const return (though name could possibly be const), and
the return could be bool instead.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +{
> +       unsigned long dt_root = of_get_flat_dt_root();
> +
> +       return of_flat_dt_is_compatible(dt_root, name);
> +}
> +
>  /**
>   * of_flat_dt_match_machine - Iterate match tables to find matching machine.
>   *
> --
> 2.22.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
