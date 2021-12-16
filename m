Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4CDC433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 13:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31BBF4172C;
	Thu, 16 Dec 2021 13:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bV7Zq8OHZbBX; Thu, 16 Dec 2021 13:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2C24441653;
	Thu, 16 Dec 2021 13:52:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B0E4C002F;
	Thu, 16 Dec 2021 13:52:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED3C3C0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 06:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6909416C9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 06:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9m-LTl6-cL0 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 06:41:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 396DB416C0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 06:41:15 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id r130so22865906pfc.1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 22:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ArBZty9F8manrgCKxo2XVUz8HSojtN8IjPyjuiPK50E=;
 b=Bu2ruXLj4/tHxkppDKDaPtP8Yj99YwwDFRpFRMWeIvWBbdE9ZxR8foipinySOJGntK
 asmrPte/BoFmm1SBWwrhsX/9DLi5mW9zS8/dFii7r487OoaY2MP0i8t/VR6A/LsXaOx0
 gBDiBOD43gKHhGB1jIv3CIgf8zm5jJ19bjOdXhhQwARURYtwf/6XAIbwnlh105N9m9SS
 BBVnn0Nn8p6wBpi/5OWGP7ExEqbXLBz58zszxbzq7EHtk2aoCB1F2JtBJX4v6YSTVfmN
 4Anhnmg6V+ENC6TeiWoF5IleLcfWmNI4idCmTe9/gB7sBRsaQHXHhweUxBQpsr++d3MF
 /KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ArBZty9F8manrgCKxo2XVUz8HSojtN8IjPyjuiPK50E=;
 b=YwwVDAqGaGBm5gCVKyDnXAOXOrc4PYLHqmd1vFdClcQW1ZUVqyWaDl7m2c0nUXUPjL
 PaoZjZgkr9GdIk4gM/+vj+Zga2l4sP8XSOVNr+etF9TpA6V7uWuC2bGIu4PtwTM7ND2M
 V52QSTHeBwQFoM0l/DJW7a4v7NxhLy5WkoLXxZIZcj7iGy6uJXLiwOFZSJVV1pjgU3PB
 5WTXEAGqD4O/IhugPqTcHmSald108C1yM6zPC0idtHPquFSpcZMTmcvfPNdML+PVyvFs
 m5xxaKUYJKF/vLsGwubM9O1q9n8uRONJo+0ICGn8RWoWhggJB5FJC+J248z0HrmZCQci
 yKRw==
X-Gm-Message-State: AOAM530EUt0cRFrFZaJtMZl42/V9Cbp1n94OiUJRYKO3YOjyUhpSXsyB
 Jmiix72YDBdaUYMzcVr9x8lXWXJ33isSefhpxBw=
X-Google-Smtp-Source: ABdhPJz0EsLxdA66bhXO5hjCGuSToPtFicyMLgWAaL1gxxOAbM4QqdwTNyHfXIy3tmkY6y9BXpVF60sogkFf77Ql3TE=
X-Received: by 2002:a63:2a0d:: with SMTP id q13mr10954563pgq.513.1639636874555; 
 Wed, 15 Dec 2021 22:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20211215232432.2069605-1-keescook@chromium.org>
In-Reply-To: <20211215232432.2069605-1-keescook@chromium.org>
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 15 Dec 2021 22:41:04 -0800
Message-ID: <CAAH8bW9e_O_3DSjZvN3YENCkNB9oa63bMb93PaOCwZ6AxbfTHA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Use correctly sized arguments for bit field
To: Kees Cook <keescook@chromium.org>
X-Mailman-Approved-At: Thu, 16 Dec 2021 13:52:26 +0000
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

On Wed, Dec 15, 2021 at 3:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> The find.h APIs are designed to be used only on unsigned long arguments.
> This can technically result in a over-read, but it is harmless in this
> case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> which we'd like to enable globally:
>
> In file included from ./include/linux/bitmap.h:9,
>                  from drivers/iommu/intel/iommu.c:17:
> drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> ./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
>   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                                     ^~~~~
> drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
>  2115 |         int pds, max_pde;
>       |                  ^~~~~~~
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

For all patches in this (not a) series
Acked-by: Yury Norov <yury.norov@gmail.com>

But can you explain, what for did you split this change? The
Documentation/process says: "Solve only one problem per patch.",
but here one problem is solved per 4 patches with identical
description.

I think it would be more logical to move-in this change as a single
commitment rather than random scattered patches.

Thanks,
Yury

> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b6a8f3282411..99f9e8229384 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2112,10 +2112,10 @@ static void domain_exit(struct dmar_domain *domain)
>   */
>  static inline unsigned long context_get_sm_pds(struct pasid_table *table)
>  {
> -       int pds, max_pde;
> +       unsigned long pds, max_pde;
>
>         max_pde = table->max_pasid >> PASID_PDE_SHIFT;
> -       pds = find_first_bit((unsigned long *)&max_pde, MAX_NR_PASID_BITS);
> +       pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
>         if (pds < 7)
>                 return 0;
>
> --
> 2.30.2
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
