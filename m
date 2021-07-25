Return-Path: <SRS0=497D=MR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9109C432BE
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 16:50:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C1660C41
	for <iommu@archiver.kernel.org>; Sun, 25 Jul 2021 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37C1660C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFC9A40229;
	Sun, 25 Jul 2021 16:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDrbRXZTZJrx; Sun, 25 Jul 2021 16:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD9F1400EE;
	Sun, 25 Jul 2021 16:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AEBFC001A;
	Sun, 25 Jul 2021 16:50:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91069C000E
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 16:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C51E82AB6
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 16:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4_KibSA2l52G for <iommu@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 16:50:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAF5582A87
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 16:50:48 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id u3so10942371lff.9
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fP46kBmK7l501R1YlgJJGYbTTZbaO0NIkZ1qjp4LZ60=;
 b=SiPYq8BshaNp69OC9ySKBMA2IxqQDhtF/RXGRJeUBiB8DO+97ZjH9oULVf8h+kDJ6h
 oaGed8aMkjAmd/1pTV6PwGJCgRW9UXlaM0hnG7LTstlJtHaNNt3V0jnUtuVJ06mA7Ymg
 o803uHXDNoUWnPu1b+ZyfKPugux0T5/RT5H48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fP46kBmK7l501R1YlgJJGYbTTZbaO0NIkZ1qjp4LZ60=;
 b=fSLmm+vu4Y+WA2eBjJikWzrbFYsvOAEOkC0EsWn/8NsFc2xyQgZwMYcKKGSjmhTiTc
 7AOhAjhXQpaQlQ5NcqLXcsTFp/aeFTdu+NcEkjowIFnz5evm0DJIngvuOJuvM7VOwvOo
 DxKWEUhQNrvhb84f/DppBBcm4iwfH947Q7dviW1PQd+pts5t6BHoTvBIG3TITv69kYGn
 jWOTvqEAbTc5D/vpFTRV62iHrA+PfpUiPCfOT5jOaWv84B9dzXcSczQBjpkmpDYPcQBI
 G28oPDHw2bOHuVuhC7sThylAWSN42QRl021vp4x/f6nDgDEW84g/24ZuxWmQL8/LP8cL
 EtEQ==
X-Gm-Message-State: AOAM532vEHA8+tQtcZYYXER7FNEXu8CM5hVUngjpkno4HaUkEuY1qgQk
 Ex6AAWvlgQ2mFvfPWdtR6AEZzYYQtQWn/KyyDvM=
X-Google-Smtp-Source: ABdhPJzO3xXQ5kLeAhHUPexfhvGIct7pebl6i1rkhPolPUC9YEYisK3XLLFxTyKpTVAW7adM0nGiCQ==
X-Received: by 2002:a05:6512:3d21:: with SMTP id
 d33mr9735942lfv.352.1627231846350; 
 Sun, 25 Jul 2021 09:50:46 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id j21sm2793368lfg.56.2021.07.25.09.50.45
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jul 2021 09:50:46 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l17so8243650ljn.2
 for <iommu@lists.linux-foundation.org>; Sun, 25 Jul 2021 09:50:45 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr9389230ljj.411.1627231845716; 
 Sun, 25 Jul 2021 09:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <YPz+qQ6dbZVDbMwu@infradead.org>
In-Reply-To: <YPz+qQ6dbZVDbMwu@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Jul 2021 09:50:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
Message-ID: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> dma-mapping fix for Lonux 5.14

We're calling it "Lonux" now?

>   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
>     (Roman Skakun)

I've pulled this, but my reaction is that we've tried to avoid this in
the past. Why is Xen using vmalloc'ed addresses and passing those in
to the dma mapping routines?

It *smells* to me like a Xen-swiotlb bug, and it would have been
better to try to fix it there. Was that just too painful?

                  Lonus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
