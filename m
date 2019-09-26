Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC06C352AA
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 14:36:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CD521D56
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 14:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CD521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 76CBB1262;
	Thu, 26 Sep 2019 14:36:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E3A4CF6D
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 14:36:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
	[209.85.210.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7132E7C
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 14:36:33 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id c10so2178108otd.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 07:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=r6BGhU4EXVK5n3VD4pcG+aWyPXN6jJubAx4zLWxZOJY=;
	b=h28NTAXbLSPR7eTO7ioSQxh8nAkyDBEbXs4x5Fx1CKDq2UBgsiEIlzMUCl7WxTsEbp
	IyTCxWva7pYK5fnaNfasFSsEmeDnqXyt6Je9RbpgWUIPrWq6qNe3qUzLBOb5JDccgpvI
	rZ6qZFyb9RLQVKi2LXiLEuokWZ7gad4J4WlEb6Oaz0/7Mp1R3IyRcNgl2QNyR1ms3ZSb
	my7oQSOGhoZe2A7RZccbty7K1vyUJMW+E5G+ez/VtIOb2fJ9AADlUFlR3+Mpxcphjmi4
	eXFPbIs8JS439UVaUgtaUy/f3WCnql3PMDZIZ5COpnh8KZccPU4ijici2wArgnu5xO8p
	uIyQ==
X-Gm-Message-State: APjAAAWWoKlABtZXqELpIphE2QwgDn7W9ftOyEV2XA5H9uWDRN09Q6r7
	tF0mF/jwAmCwuy/dVdqdjeIzYPi3LklHugWVx58=
X-Google-Smtp-Source: APXvYqztl4LGorHGu4rFc+y0XehitI6BHSIs7nO6sAk/FpfHnYArgqll2ABw8lmuQN4vUIE81uEujiR7PeHHq8WAQ/c=
X-Received: by 2002:a9d:193:: with SMTP id e19mr2728162ote.107.1569508592688; 
	Thu, 26 Sep 2019 07:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1569310988-40746-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1569310988-40746-1-git-send-email-biju.das@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Sep 2019 16:36:21 +0200
Message-ID: <CAMuHMdWw=hkgXe_79s_zhxSQP2crtUNTpMjFeGDBbULwrDPpVg@mail.gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code
To: Biju Das <biju.das@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Simon Horman <horms@verge.net.au>
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

Hi Biju,

On Tue, Sep 24, 2019 at 9:43 AM Biju Das <biju.das@bp.renesas.com> wrote:
> Support RZ/G2N (R8A774B1) IPMMU.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c

>  static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
>         { .soc_id = "r8a774c0", },
> +       { .soc_id = "r8a774b1", },

Please preserve alphabetical sort order.

>         { .soc_id = "r8a7795", .revision = "ES3.*" },
>         { .soc_id = "r8a77965", },
>         { .soc_id = "r8a77990", },

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
