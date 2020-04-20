Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FC8C3815B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 09:26:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94F721473
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 09:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94F721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 90AFE8666D;
	Mon, 20 Apr 2020 09:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1hYTW85C58U; Mon, 20 Apr 2020 09:26:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4ADA5865EE;
	Mon, 20 Apr 2020 09:26:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE79C07FF;
	Mon, 20 Apr 2020 09:26:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 963B3C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 09:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 851E98666D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 09:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tik9wzZqRsyu for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 09:26:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4E403865EE
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 09:26:31 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id m13so7473106otf.6
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 02:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vNmHcf3myzOB2u9F8M3SMwCNsUNlPCLfd3zAQRCW16Q=;
 b=Q47XunH1Qvlvohs7lgEJ3tNb1d16HjazHSq0hOddrcJFSTIN1FzmMaCDh1H8u15LXw
 QpNY8zKl28EYlS2fJYpkbYXI29Z14Au8vVDNMXns5P+CpbpfYx1NcmdRCVSKpq/GJ4/f
 30m6Mbq67T4LMw5L2c0J2unWo1JSD9ACdSpfNG7upP/xAFYlW2zSw9DELyobITmM7m61
 Cy9ePmZNDrNf1lC4/pfCLELPUA0ljCNTj5LWfPPUsPy3Vhe11IazQzIKh6ldkGRhiSnQ
 TCiUxjh+0sJ20C9hDcXHLsc5EBWD04z55Igy8PuF6f0HryR4WcpGZdgCrqcXbnydPTrO
 jBWw==
X-Gm-Message-State: AGi0PuaEpnJvL5QHsibOY0ciXiiVchLnMAdbRZYrpa+gEkJT1MwqTpEr
 m0rPLICtqj6ORDXgEnj555zeodnsTmgPTvL61BQ=
X-Google-Smtp-Source: APiQypLK0nAWizIJ4tO6vPe5OvpMxqQr4fd7LV61E3+C9yzFgEDzCpkHgr7Sqg0Lx1T9RyK7Z05pBaDYg8OyPFQJ0Pw=
X-Received: by 2002:a05:6830:3104:: with SMTP id
 b4mr5221130ots.250.1587374790460; 
 Mon, 20 Apr 2020 02:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-27-hch@lst.de>
In-Reply-To: <20200414131348.444715-27-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 11:26:19 +0200
Message-ID: <CAMuHMdXO0TV09XYxyxjEA8YdvXVwg1u6Zs=z3PzCVb9Mw5boTQ@mail.gmail.com>
Subject: Re: [PATCH 26/29] mm: remove vmalloc_user_node_flags
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
 Johannes Weiner <hannes@cmpxchg.org>,
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

On Tue, Apr 14, 2020 at 3:22 PM Christoph Hellwig <hch@lst.de> wrote:
> Open code it in __bpf_map_area_alloc, which is the only caller.  Also
> clean up __bpf_map_area_alloc to have a single vmalloc call with
> slightly different flags instead of the current two different calls.
>
> For this to compile for the nommu case add a __vmalloc_node_range stub
> to nommu.c.

Apparently your nommu-cross-compilers are in quarantaine? ;-)

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -150,6 +150,14 @@ void *__vmalloc(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc);
>
> +void *__vmalloc_node_range(unsigned long size, unsigned long align,
> +               unsigned long start, unsigned long end, gfp_t gfp_mask,
> +               pgprot_t prot, unsigned long vm_flags, int node,
> +               const void *caller)
> +{
> +       return __vmalloc(size, flags);

On Mon, Apr 20, 2020 at 10:39 AM <noreply@ellerman.id.au> wrote:
> FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Mon Apr 20, 18:38
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14213623/
>
> mm/nommu.c:158:25: error: 'flags' undeclared (first use in this function); did you mean 'class'?

"return __vmalloc(size, gfp_mask);", I assume?

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
