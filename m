Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72652C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 12:42:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A9C214E0
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 12:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A9C214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E657915CE;
	Fri, 11 Oct 2019 12:42:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3A06E1749
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 12:29:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
	[209.85.167.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3CD80709
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 12:29:39 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id i16so7843440oie.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 05:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Mk/S55Za5w2S7LoyGIF9nU8j8q3VT+OJmghbM1EQWNA=;
	b=JFzJYI53+NokzM1NWA1Dz9RzU3cHZXDvfwqUYFRT/nwgofvw26S8JAIprAA+rLD1jQ
	UhJwLD6jVHxUbP5FouMheqqShLH8bjwQdQELT94wHnk8F4gE7QbNiZ+x2UzcUxUUG4la
	Y/4RUaSbQggwZp508msXhokqFMDlR1gZdB9fUz2ySSNe7kd/wmAKUaM+YCFJvhHy/Vbt
	pnJUu7KTJisZAJYCMyZQiizYEfAVQQTPphhzn1Y43SSVb5nS0bLXoc/U0L1HqJEeLqIO
	yRP4pSSlTjz9z1x5S8Y/JIPcjwWIrPgP0xIyg6t7Xm3EsTjOeFkc9vdgVZEB7sgYjP89
	KSXQ==
X-Gm-Message-State: APjAAAVAK7lyvQlO/dbMhg1AgQ1qxneg6eCuoTvc7WxBuM3MT/QDJcKP
	ohoFOa/aNu0AeZIXAWlpFXv16lPs0BxRgE7nUM4=
X-Google-Smtp-Source: APXvYqxJmNl+fmcMRc0/CWf4te3uXy2EMOFxzF+6nsYW0TqU97sEgQ/AWhrgDvvXNMI8dXF8hcwql+nR3WX5jjp8T8w=
X-Received: by 2002:aca:882:: with SMTP id 124mr11980630oii.54.1570796978363; 
	Fri, 11 Oct 2019 05:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1570609609-1332-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Oct 2019 14:29:27 +0200
Message-ID: <CAMuHMdXv3ChOHO7RyOjQ0mL+9ugRFWnMUw7MfYD-9aU+ZZMSTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/ipmmu-vmsa: Calculate context registers' offset
	instead of a macro
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
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

Hi Shimoda-san,

On Wed, Oct 9, 2019 at 10:27 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since we will have changed memory mapping of the IPMMU in the future,
> this patch uses ipmmu_features values instead of a macro to
> calculate context registers offset. No behavior change.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -50,6 +50,8 @@ struct ipmmu_features {
>         bool twobit_imttbcr_sl0;
>         bool reserved_context;
>         bool cache_snoop;
> +       u32 ctx_offset_base;
> +       u32 ctx_offset_stride;
>  };
>
>  struct ipmmu_vmsa_device {
> @@ -99,8 +101,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>
>  #define IM_NS_ALIAS_OFFSET             0x800
>
> -#define IM_CTX_SIZE                    0x40
> -
>  #define IMCTR                          0x0000
>  #define IMCTR_TRE                      (1 << 17)
>  #define IMCTR_AFE                      (1 << 16)
> @@ -253,18 +253,25 @@ static void ipmmu_write(struct ipmmu_vmsa_device *mmu, unsigned int offset,
>         iowrite32(data, mmu->base + offset);
>  }
>
> +static u32 ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu, unsigned int context_id,
> +                        unsigned int reg)
> +{
> +       return mmu->features->ctx_offset_base +
> +              context_id * mmu->features->ctx_offset_stride + reg;
> +}
> +
>  static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
>                                unsigned int reg)
>  {
>         return ipmmu_read(domain->mmu->root,
> -                         domain->context_id * IM_CTX_SIZE + reg);
> +                         ipmmu_ctx_reg(domain->mmu, domain->context_id, reg));

For consistency:

    ipmmu_ctx_reg(domain->mmu->root, ...)

but in practice the features for domain->mmu and domain->mmu->root are
identical anyway.

>  }
>
>  static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
>                                  unsigned int reg, u32 data)
>  {
>         ipmmu_write(domain->mmu->root,
> -                   domain->context_id * IM_CTX_SIZE + reg, data);
> +                   ipmmu_ctx_reg(domain->mmu, domain->context_id, reg), data);

Likewise:

    ipmmu_ctx_reg(domain->mmu->root, ...)?

I find these ipmmu_{read,write}() a bit hard too read, with passing the
mmu to both ipmmu_{read,write}() and ipmmu_ctx_reg().

What do you think about providing two helpers ipmmu_ctx_{read,write}(),
so all users can just use e.g.

    ipmmu_ctx_write(mmu, context_id, reg, data);

instead of

    ipmmu_write(mmu, ipmmu_ctx_reg(mmu, context_id, reg), data);

?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
