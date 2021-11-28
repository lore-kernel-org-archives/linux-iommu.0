Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5417AC433EF
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 01:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3F878175A;
	Sun, 28 Nov 2021 01:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fynW3U0093GP; Sun, 28 Nov 2021 01:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6B6E8174F;
	Sun, 28 Nov 2021 01:51:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62846C0012;
	Sun, 28 Nov 2021 01:51:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24BB4C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 01:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F38D76073C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 01:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZsNBwW31cvIH for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 01:50:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 036C86071B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 01:50:58 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id v23so9746125pjr.5
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ys5xSp8TMHje4lkwagfboQK99rlmdyclUqc40aH5Xfc=;
 b=JJOISWgIQ7wesuYZIUyZ8YTvD93vtYYWCXpfoY5Xjiptsb/c/6A8Qt0ghl68FPzuuW
 RcHn3i6d+k+aYpTNzHFoicSvQWW1IaZ/fNNkcM0PpOn2zy/M9mFyuhc8vIeDm9liWaCt
 H16c8kzlw5FLBZaGYeNosXob9TEcToUUr/mHUnmdiFCbaeCoiQuyTQjYV5GdrTasP7II
 bw60jyoMg6YcXpFUW5X7r1FzNUeZmQszk455JFn+kbjr2shcdZVhqayQwih2uqXXwuzc
 JIA2RCCN0BqI59sdeGLuAwHBkfAMzPAdR7xh2WEB5stJk1x6S/XlLMQpQ9UuxV1xRNYO
 N1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ys5xSp8TMHje4lkwagfboQK99rlmdyclUqc40aH5Xfc=;
 b=kckFGHfAYvsRQqAftNw6T+bX5pHtNTYXDITU+9feELZtvdPgiLwb08dW15bkfH4RcU
 lznufGAHeL5pDRX7CxAgLSte1TlB0d7hZKbAh3WXLe47LK3q6Qbvjm6E98hNL+VxhcNC
 OZEFkxec2k1RqOcVQ4WRa4Um/9qCvAtzLEfo9IUNKfyRIBfD03tvl1KPhMUJovZeiAXI
 hIgp3pah1H/PfQacsKa0hzf+n+AhHofyoIDvNu0Y0YFE54c0pkl4eyvp3d4xdePqSF1a
 fJcUY63sFbo52Ke33GL8nC8l7G95HCBJPN7SDzRxt+45U/c+9eJqVMep4y7jaJATd3dR
 /GVw==
X-Gm-Message-State: AOAM530U3OgIOyJjEeph++ZHyzSBe0plzfBnjkBG3A/PLFuyz7I5ee7s
 ySSF0EDbTSSXDvzIrrnvYsU=
X-Google-Smtp-Source: ABdhPJwRmBN5bgq7gesTKrXdzGhmnX4TF8GBRT5ARwRzCP8r0GrmW5VR1rkYDfo3JlQIN/mpfZD2Ow==
X-Received: by 2002:a17:903:245:b0:143:c5ba:8bd8 with SMTP id
 j5-20020a170903024500b00143c5ba8bd8mr50486892plh.64.1638064258317; 
 Sat, 27 Nov 2021 17:50:58 -0800 (PST)
Received: from localhost ([103.99.179.247])
 by smtp.gmail.com with ESMTPSA id f21sm12503537pfe.69.2021.11.27.17.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Nov 2021 17:50:57 -0800 (PST)
Date: Sun, 28 Nov 2021 09:50:53 +0800
From: Calvin Zhang <calvinzhang.cool@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-ID: <YaLgfYzxFRVamvdI@debian>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
 <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
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

On Sat, Nov 27, 2021 at 04:07:18PM -0800, Andrew Morton wrote:
>On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
>
>> Just like this:
>> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
>> 
>> Add kmemleak_ignore_phys() for CMA created from of reserved node.
>
>Could we please have a full, standalone changelog for this patch?

Yes, I will add.

>
>The 620951e27457 changelog says "Without this, the kernel crashes...". 
>Does your patch also fix a crash?  If so under what circumstances and
>should we backport this fix into -stable kernels?

No crash occurred. 620951e27457 avoids crashes caused by accessing
highmem and it was fixed later. Now kmemleak_alloc_phys() and
kmemleak_ignore_phys() skip highmem. This patch is based on the
point that CMA regions don't contain pointers to other kmemleak
objects, and ignores CMA regions from reserved memory as what
620951e27457 did.

--
Thanks
Calvin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
