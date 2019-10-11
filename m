Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C2C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 12:23:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EBD2190F
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 12:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EBD2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5B4B61749;
	Fri, 11 Oct 2019 12:23:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3896E173C
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 12:11:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 82B975D3
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 12:11:08 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id o44so7722088ota.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 05:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KD7hNkPmgU5eUkr6kzafk4QUrOtUh97tOslZtesF6xM=;
	b=OEsU4m5Itje7u/kk5A4wsIASJ8Z8qP6rC22aK+mGk5fxZ9vDRRAfPk50JvgylHJHlJ
	FBOw+rJ4HiWJcFmf37toTsPhQu6yAKOuimFClHhENSvi1JrZFcsZdPtURDg/TRc6Wapi
	nY9n73OPL4ENm9Wq4vYrsmzeJMc4mS7wHdWtDjsb1BMtpOTQqB/yeMRKRbWn3H+o3EFV
	UI/lRhc7KxuHeIqhxDUwJ5JIDCFrqkn7OUaI0mUDfFuhDojBO+5u9UCDVtvYcVJdYW/C
	SHwEqP/98OsSC/yGtqRrgiZhEtU0hOXF9O1rEhLsl+EKLZ6z1WM80r/CMNfg67ETt2FB
	ZPPA==
X-Gm-Message-State: APjAAAUku5laBwYKpAlaZxbNKJJJrMcIr5uE0F1pU0ZPESDzEaV5Ptib
	cqMahbh/ayLxxDoW+9mVtYkfzys+e/9gxxYhjgw=
X-Google-Smtp-Source: APXvYqwqkXmQ/JOh7OmTQ74bEvuK6xdpGsfpFjkRVQGiKI1Xo9EifsVApogi+Cz1sCGR5grPdjnz267Voy6EZ6+290g=
X-Received: by 2002:a05:6830:1685:: with SMTP id
	k5mr12047997otr.250.1570795867699; 
	Fri, 11 Oct 2019 05:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1570609609-1332-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Oct 2019 14:10:56 +0200
Message-ID: <CAMuHMdWfHYDOKSJBUCVLG6yNKxbv=jUd9E1B_fiBOQajwi_wEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu/ipmmu-vmsa: Remove some unused register
	declarations
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

Thanks for your patch!

On Wed, Oct 9, 2019 at 10:27 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> To support different registers memory mapping hardware easily
> in the future, this patch removes some unused register
> declarations.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

While I can confirm the removed definitions are unused, they were
still valid (but see comments below).
Perhaps it would be better to add comments, to state clearly to which
SoCs or SoC families they apply?  Or do you think this would be futile,
and would add too much clutter to the source file in the near future?

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -104,8 +104,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>  #define IMCTR                          0x0000
>  #define IMCTR_TRE                      (1 << 17)
>  #define IMCTR_AFE                      (1 << 16)
> -#define IMCTR_RTSEL_MASK               (3 << 4)

FWIW, this is valid for R-Car Gen2 only.  On R-Car Gen3, the field
contains 3 bits.

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
