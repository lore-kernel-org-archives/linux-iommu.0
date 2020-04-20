Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65992C54FCC
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 09:28:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF8A20CC7
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 09:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF8A20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1730C869C7;
	Mon, 20 Apr 2020 09:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BAIbxMKx9I5G; Mon, 20 Apr 2020 09:28:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF59A869BF;
	Mon, 20 Apr 2020 09:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFF1C07FF;
	Mon, 20 Apr 2020 09:28:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0569BC0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 09:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E85AB85BD1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 09:28:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wVLP_cBcSCEf for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 09:28:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 591A385BB5
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 09:28:08 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id j4so7465280otr.11
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 02:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XArWxGkJ+VyTPp7Wsn4dbWWlVRq/sh+tie0xFdY8Wzs=;
 b=o/oZalWKdLxJQiYukI1EsVxZJn6D/4f4qh1Xio1gj7fQTZ5qhWR0DVA98yR3sy4Rwh
 Kz6984yEqh/dSlTe+nwnZoAWicZCPh7DkIPWEW3zIzoNqPiA1Mj7qHiC+JT/yKv5fcqH
 4HKiuKrBp/VecEfGGDubANZNol0V1Uy58PrKYSe/5/k0rcuTpFSXlicwn5Qnryn31F4g
 zc1zxLQXDW07mwjVTHhCc/LcZcZJayJwShONc3jHTYGJbFGHMOOzFCR6b5gDEW5rEnvf
 /ppdjgtQqO45OC/38dJLOPPyTOgpGCLjhZesV8jBQxoeWDMrAjmlMO7Br6QeoD+pyPAu
 hGbg==
X-Gm-Message-State: AGi0Pua4pJ9TfHxNgXxmSZNLDk551YRCyl7q24epftbDM8rTBn6hCo3l
 okXUzC8pzp9m6L+qKvNUJc8VlD9eR2PRnMg/3xs=
X-Google-Smtp-Source: APiQypKjsC6EXYlE5GmPZ4cHorgIglv7peKg70tltLFRlUNMnXipnoVRB6R66Yu9R4xLAwziPHJaRnQ/4in6/miu0rc=
X-Received: by 2002:a05:6830:3104:: with SMTP id
 b4mr5224618ots.250.1587374887535; 
 Mon, 20 Apr 2020 02:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-25-hch@lst.de>
In-Reply-To: <20200414131348.444715-25-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 11:27:56 +0200
Message-ID: <CAMuHMdXktO=2n1tbE5RWRfE1CMd9bP-aHJQifO3J9HYxoQEuXQ@mail.gmail.com>
Subject: Re: [PATCH 24/29] mm: remove __vmalloc_node_flags_caller
To: Christoph Hellwig <hch@lst.de>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>,
 Nitin Gupta <ngupta@vflare.org>, Daniel Vetter <daniel@ffwll.ch>,
 Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org,
 bpf <bpf@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

Hi Christoph,

On Tue, Apr 14, 2020 at 3:21 PM Christoph Hellwig <hch@lst.de> wrote:
> Just use __vmalloc_node instead which gets and extra argument.  To be
> able to to use __vmalloc_node in all caller make it available outside
> of vmalloc and implement it in nommu.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

One more nommu failure below...

> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -150,8 +150,8 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>
> -void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t flags,
> -               void *caller)
> +void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
> +               int node, const void *caller)
>  {
>         return __vmalloc(size, flags);

On Mon, Apr 20, 2020 at 10:39 AM <noreply@ellerman.id.au> wrote:
> FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Mon Apr 20, 18:38
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14213623/
>
> mm/nommu.c:164:25: error: 'flags' undeclared (first use in this function); did you mean 'class'?

"return __vmalloc(size, gfp_mask);"

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
