Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03624C433F5
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 00:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FBA460636;
	Fri,  3 Dec 2021 00:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5nZobUdcANs; Fri,  3 Dec 2021 00:52:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81C62605C4;
	Fri,  3 Dec 2021 00:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40A67C0012;
	Fri,  3 Dec 2021 00:52:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29771C000A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 00:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CAC140477
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 00:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5PMms1sBftLp for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 00:52:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78290405AE
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 00:52:30 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id b68so1223826pfg.11
 for <iommu@lists.linux-foundation.org>; Thu, 02 Dec 2021 16:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KcgckVJBk609C9n8WlYPxKWxBCCyIgqINt/uZGi6A0Y=;
 b=Ctf7ofl9Xke/PvNfOa+Vrw+j8ZBmzqUrFn63JewI2pdb1XRMsZgcYJ6ssqVhQpeDjA
 ya/eT9D/t9b86F/AArvhA/u4vb7Q466qgo9KzGmBFPZijZkkoSob/z+47kRcGLqgoLcX
 bsKy2XDc+XW2Z3hJyPDbt5ekMsag8vEQ2CepLHEGWHzbT4FUP8ejDg9HntELO6U/kHXv
 0lfZVQR7cTvYiPYD9S0BPTPNA7HKN4I5EniGd53Riw/4BkWX0Rzro4VxzMSJ2yNh1zWV
 Ss04cFrELxmFNzr+xgR2eQO2siyrMfdD3g7WfN8Jk6hkDnUt2W+67yQTSa55mAdVQ+Wq
 eSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KcgckVJBk609C9n8WlYPxKWxBCCyIgqINt/uZGi6A0Y=;
 b=NC5T6hkSl/4IP6G2TnBxEiNe5eZgDO2HjefSW6HaUDsX+lEYljTa2xck3ZwB2rsdgY
 tuCusJmnw9mLKTZXOhiIykDLs2K6zsmHkIjhfecrjLUK1VU+iVTqHZdKQZqbfokkmZPB
 P/ZR8Qw+eKT1zKH01SY6tV+0pU1nbeyX520I8bJaCAXpUiy/dWDJVslK4to50WeGQshK
 7/uVhtYAQ1belzpQlUMa3XMgZaspQGA/YzfhocTieFywoeArfyYpWgKu4AmxWgiCppD+
 LeXEh3n42Rtq5vRkuOQUWoxdqTimwO/4yoi4Y2jexd6opOD8zR+mr3B/h0e6gfRbACNM
 9hrQ==
X-Gm-Message-State: AOAM532GyglkZmS3kL70JDihXcvJCRtm+u0qjX8md7QVQPomGmz3Z5Eq
 JKfgkWdSmFi2y94CS/kVBEE=
X-Google-Smtp-Source: ABdhPJy0wAKaq2tyZW6eEKVEZ01mPalVC9neiDt4H5evhXCCzzA5axCTHMxBIQfQZL4+VtxXQMlS3g==
X-Received: by 2002:a05:6a00:15ca:b0:49f:d22b:afff with SMTP id
 o10-20020a056a0015ca00b0049fd22bafffmr15996509pfu.35.1638492749937; 
 Thu, 02 Dec 2021 16:52:29 -0800 (PST)
Received: from localhost ([103.99.179.247])
 by smtp.gmail.com with ESMTPSA id h26sm652480pgm.68.2021.12.02.16.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 16:52:29 -0800 (PST)
Date: Fri, 3 Dec 2021 08:52:24 +0800
From: Calvin Zhang <calvinzhang.cool@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-ID: <YalqSC0FdhEMpCQH@debian>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
 <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
 <YaLgfYzxFRVamvdI@debian> <YakMQA1A75ZADeHi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YakMQA1A75ZADeHi@arm.com>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>
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

On Thu, Dec 02, 2021 at 06:11:12PM +0000, Catalin Marinas wrote:
>On Sun, Nov 28, 2021 at 09:50:53AM +0800, Calvin Zhang wrote:
>> On Sat, Nov 27, 2021 at 04:07:18PM -0800, Andrew Morton wrote:
>> >On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
>> >> Just like this:
>> >> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
>> >> 
>> >> Add kmemleak_ignore_phys() for CMA created from of reserved node.
>[...]
>> >The 620951e27457 changelog says "Without this, the kernel crashes...". 
>> >Does your patch also fix a crash?  If so under what circumstances and
>> >should we backport this fix into -stable kernels?
>> 
>> No crash occurred. 620951e27457 avoids crashes caused by accessing
>> highmem and it was fixed later. Now kmemleak_alloc_phys() and
>> kmemleak_ignore_phys() skip highmem. This patch is based on the
>> point that CMA regions don't contain pointers to other kmemleak
>> objects, and ignores CMA regions from reserved memory as what
>> 620951e27457 did.
>
>Note that kmemleak_ignore() only works if there was a prior
>kmemleak_alloc() on that address range. With the previous commit we get
>this via the memblock_alloc_range() but I fail to see one on the
>rmem_cma_setup() path.

rmem is from memblock_reserve() or early_init_dt_alloc_reserved_memory_arch()
kmemleak_alloc() is not called in the first case. And It's bad to add one.

I think all the reserved regions should be allocated from memblock without
kmemleak_alloc() and let rmem handler choose to add it as kmemleak object
by kmemleak_alloc(). Because MEMBLOCK_ALLOC_NOLEAKTRACE conflicts with range
parameter in memlbock_alloc_* series, all reserved regions and default CMA
region are allocated with kmemleak_alloc().

I think it's better to add memblock_alloc_* series a spearate flag paramter
(like "NOLEAKTRACE") instead of encoding MEMBLOCK_ALLOC_NOLEAKTRACE in `end`
parameter.

--
Calvin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
