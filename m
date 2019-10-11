Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EA0C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 12:42:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725D8214E0
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 12:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725D8214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2005415D2;
	Fri, 11 Oct 2019 12:42:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1DBDE174E
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 12:32:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
	[209.85.167.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD0E95D3
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 12:32:40 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id k20so7842537oih.3
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 05:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ZHx6lowuusoqF0mM8TadgO/DWxUYO4dTHGf6Y3SGlqM=;
	b=cbrsLci6qzyGenEE2HJpOPNnjNgLvHmoQjLZGDH8Jx44cNEtcLfWZWTXVsxOS3HlNY
	LwA9MKO/NGwbVuW15Re57rNTKcijri6qfoQLMQEdeGnyYXh+ccNDmM8sqcTZ6vzPP2fa
	ZjVjJei8T/d0PVpXo7u1nBFYqgwYiymWbhPLZ/WM4nvkfPInnJgTQ/4onsowccPvx5R+
	AH+u5gUCSkOme28oZdIQvHUML7YPVWP7+XesT9X7Umgasg0JWyW00aZfXHjL0ClIG+RD
	oXqIiBYV6WFRhaRYEzCB04poNMzO7nFYmvdrT13uR1NtoV8hdvI8AzL5DFN8ENreMsmN
	jSXA==
X-Gm-Message-State: APjAAAXwTNPycr01x4hf2jRokgRfNFO9KYe3/avg2PjwBX5oYpyIsSPI
	0sTwA57WYJ39o//M7hMOKczxg5LdotkUZBZosOo=
X-Google-Smtp-Source: APXvYqw6H4qmpFYo9nZCloI4OSuEEUHL7c1Nggx+ZO9Ae4mJ6XWX2YvnZYXWeofnJuilO9W920F11WaiLiQGFB1ws3M=
X-Received: by 2002:aca:cf58:: with SMTP id f85mr11435247oig.153.1570797159776;
	Fri, 11 Oct 2019 05:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1570609609-1332-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Oct 2019 14:32:28 +0200
Message-ID: <CAMuHMdW-Z9xkE5Eh7rbgufHSDvqoPyRJgsFhp_Ne9uk2XfUnEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Add utlb_offset_base
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
> this patch adds a utlb_offset_base into struct ipmmu_features
> for IMUCTR and IMUASID registers.
> No behavior change.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -52,6 +52,7 @@ struct ipmmu_features {
>         bool cache_snoop;
>         u32 ctx_offset_base;
>         u32 ctx_offset_stride;
> +       u32 utlb_offset_base;
>  };
>
>  struct ipmmu_vmsa_device {
> @@ -285,6 +286,11 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
>         ipmmu_ctx_write_root(domain, reg, data);
>  }
>
> +static u32 ipmmu_utlb_reg(struct ipmmu_vmsa_device *mmu, unsigned int reg)
> +{
> +       return mmu->features->utlb_offset_base + reg;
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * TLB and microTLB Management
>   */
> @@ -330,9 +336,9 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
>          */
>
>         /* TODO: What should we set the ASID to ? */
> -       ipmmu_write(mmu, IMUASID(utlb), 0);
> +       ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUASID(utlb)), 0);
>         /* TODO: Do we need to flush the microTLB ? */
> -       ipmmu_write(mmu, IMUCTR(utlb),
> +       ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUCTR(utlb)),
>                     IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
>                     IMUCTR_MMUEN);

Like in [PATCH 2/3], I think providing two helpers would make this more
readable:

    ipmmu_imuasid_write(mmu, utlb, 0);
    ipmmu_imuctr_write(mmu, utlb, data);

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
