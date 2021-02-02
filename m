Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E4C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 01:37:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1D664E8D
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 01:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1D664E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F3E5720020;
	Tue,  2 Feb 2021 01:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-IAEppGax90; Tue,  2 Feb 2021 01:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ABC08214EB;
	Tue,  2 Feb 2021 01:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96517C0FA7;
	Tue,  2 Feb 2021 01:37:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83F4FC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 672EB8703C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J8pEkepPfLze for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 01:37:02 +0000 (UTC)
X-Greylist: delayed 00:21:41 by SQLgrey-1.7.6
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9BEB787038
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:37:02 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id v126so18396726qkd.11
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 17:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NszN4D5jzxy6frT0PN3aEj0vwxxqCzqxTFC21xlKA2c=;
 b=mzPpODks3Hz/c3k7qugw9y9nTN+2ETWrIEmwpYHyI23BXj3J6N2CmbedBCmDvne9e2
 uWBUZXHVTmVsGahn5gvR3D5CEcMo2U8XoFLapZ7aC00EzXj/poCNx4CLsMN4pKHclSGK
 JVb6OfBikmgd2t++YwljcC1c0B6Oz0kJHd01E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NszN4D5jzxy6frT0PN3aEj0vwxxqCzqxTFC21xlKA2c=;
 b=WlRdUWRYPM/rqvPMsymNrhyr+p/H/chyTQNk6/ZAvmY53O2jSoenyI0t9/gUv346Ik
 Ug8mbEqApoqoQmO8Dq2Vjc/OVzFqHp3t0i4NeVQpkZuBc3ToxXlGvnAo+D9jXYf9a+kw
 b4+Vkp0TAbPyxDbIgjgKWgrV5kzAT3xe5lNtQvbWsJDziZ0Ro425HGt+AUFtSdmTcgL4
 7BRooA4UiPNE4oeak0LOMlTlzqr/tUxeeKS81c4IGfILETjM5RpcyppXRA5ok9CstLMT
 Cvmg3UOUlmbptdpgi+uq6/Avf9cm80RZeBzmgvNedCHEgamIwsW4mrNQB+DYNQIvI9Gs
 jd8A==
X-Gm-Message-State: AOAM533YWGPVjGSHnNDeWjxYVMH/tH/kqotgxCCjmic/lilJ4RcA1duV
 2x/qHpdWk2B2Lc8qhdTKfkbMRacqxevorA==
X-Google-Smtp-Source: ABdhPJyR9mwVatP6MYa7vEfoOFVi0xFJvPcOlb29maWtsY7I6PPl1E3bQvNUoFTAMUPzJ2N9Lgltrw==
X-Received: by 2002:ac8:1247:: with SMTP id g7mr17786437qtj.261.1612228054017; 
 Mon, 01 Feb 2021 17:07:34 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com.
 [209.85.219.171])
 by smtp.gmail.com with ESMTPSA id c1sm16001389qke.2.2021.02.01.17.07.31
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Feb 2021 17:07:32 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id s61so15541283ybi.4
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 17:07:31 -0800 (PST)
X-Received: by 2002:a25:c683:: with SMTP id k125mr30638749ybf.32.1612228051259; 
 Mon, 01 Feb 2021 17:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20210107122909.16317-1-yong.wu@mediatek.com>
 <20210107122909.16317-2-yong.wu@mediatek.com>
In-Reply-To: <20210107122909.16317-2-yong.wu@mediatek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 1 Feb 2021 17:07:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xkn0pVGP5R7-xKjrDUTsrWRcy3L-D_qg8_hgV=noRhxA@mail.gmail.com>
Message-ID: <CAD=FV=Xkn0pVGP5R7-xKjrDUTsrWRcy3L-D_qg8_hgV=noRhxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] iommu: Move iotlb_sync_map out from __iommu_map
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Tomasz Figa <tfiga@google.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 David Laight <David.Laight@aculab.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel-team@android.com,
 Greg Kroah-Hartman <gregkh@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Thu, Jan 7, 2021 at 4:31 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> @@ -2438,18 +2435,31 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>         return ret;
>  }
>
> +static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
> +                     phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +       const struct iommu_ops *ops = domain->ops;
> +       int ret;
> +
> +       ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);

The above is broken.  Instead of GFP_KERNEL it should be passing "gfp".


> +       if (ret == 0 && ops->iotlb_sync_map)
> +               ops->iotlb_sync_map(domain);
> +
> +       return ret;
> +}
> +
>  int iommu_map(struct iommu_domain *domain, unsigned long iova,
>               phys_addr_t paddr, size_t size, int prot)
>  {
>         might_sleep();
> -       return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +       return _iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(iommu_map);
>
>  int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>               phys_addr_t paddr, size_t size, int prot)
>  {
> -       return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +       return _iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);

Specifically the above bug means we drop the "GFP_ATOMIC" here.

It means we trigger a warning, like this (on a downstream kernel with
the patch backported):

 BUG: sleeping function called from invalid context at mm/page_alloc.c:4726
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: ksoftirqd/0
 CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.93-12508-gc10c93e28e39 #1
 Call trace:
  dump_backtrace+0x0/0x154
  show_stack+0x20/0x2c
  dump_stack+0xa0/0xfc
  ___might_sleep+0x11c/0x12c
  __might_sleep+0x50/0x84
  __alloc_pages_nodemask+0xf8/0x2bc
  __arm_lpae_alloc_pages+0x48/0x1b4
  __arm_lpae_map+0x124/0x274
  __arm_lpae_map+0x1cc/0x274
  arm_lpae_map+0x140/0x170
  arm_smmu_map+0x78/0xbc
  __iommu_map+0xd4/0x210
  _iommu_map+0x4c/0x84
  iommu_map_atomic+0x44/0x58
  __iommu_dma_map+0x8c/0xc4
  iommu_dma_map_page+0xac/0xf0

---

A quick (but not very tested) fix at:

https://lore.kernel.org/r/20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid/


-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
