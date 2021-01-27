Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C8C433E6
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 23:44:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC2D64DD1
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 23:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC2D64DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 765698737C;
	Wed, 27 Jan 2021 23:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-PFulZ23kUq; Wed, 27 Jan 2021 23:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0808087366;
	Wed, 27 Jan 2021 23:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5AD8C0FA7;
	Wed, 27 Jan 2021 23:44:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1C91C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 23:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B8A4A86C39
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 23:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v+ae4ZpdzPET for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 23:44:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 15CC186AF0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 23:44:22 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id p15so2472423pjv.3
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=Mxms3zmarGgtqLSA2knr9DFUQbJNpMaXiC1Rwt/vXfQ=;
 b=Rk78kGbTRTMsJht7TyBKfA+4NY6T9q1+B9xyRJPxErypmxzfFg1Nv607eX/zhWOilm
 xIF2iZKJNNs0OizLmf5xQchxGNztXdG+MejWZt4vq9jUdoGE3p13+Ow2gj+UnyxxLMZh
 820dcly26qnDHkf+TMfpinOCa5mKEnv3EoTWeuKmPOAvBVp5douEF2TFDaFVJX8O7Aqa
 LcCdL+M1mXHI1pP2L6BrJGNIOAtJvb/1syYMNQ758u8UN2y9var1hizA1oYqPNmZo61S
 0CFz4y8J5l+Bepx+5SfQ3rwd+HCH5CXiUK0kK8LHvswJ70Tr3B7u0ognkccOZsO5ruRp
 /QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=Mxms3zmarGgtqLSA2knr9DFUQbJNpMaXiC1Rwt/vXfQ=;
 b=Px/DBGgWGOQKXi+JUI1SDlP52HeWymy1vLgT1aHh9BHUE4zlp40+w8FZ+JWmnHO6MQ
 /Mue/V5ITlo9cOrXhx/1sIVTaCh2L32/7XNGKk7HKRZyvg3qw0m3XbvoRKObT1jQZ6SB
 j60F0hCua/OIuy6yLz55N+npwxqQQ+pqlQ8huRG0zzNiDZrpPuLON+MiGc1zOEHpx8y0
 i/3Jj/XLQS5CRxjp1wM3F9SF+mVihPCkLZ5BTefswRLTzUY+MXmswYclBojS4f3sHef8
 KB3UvbK+EyV9NXqpds7yNYymqhABzkvR8AKBZQil9RE3WnRHCv2YSChAlUkbDu+5bRTT
 dj9w==
X-Gm-Message-State: AOAM533fz/0GZ0I9pQ5HfbfvE0Xm64W+ALz3hhr6xVVoA93b2KGQIETN
 woLM3cfNLpHqpkzqFVwhlec=
X-Google-Smtp-Source: ABdhPJy973JY/GinSGJtf5a+0PiKQqWLhevqbbKoXQxFTvmud+BGNyTfcj6DSK6CkRQf8lc4vFUuNw==
X-Received: by 2002:a17:90b:1004:: with SMTP id
 gm4mr8190388pjb.97.1611791061723; 
 Wed, 27 Jan 2021 15:44:21 -0800 (PST)
Received: from localhost
 (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au.
 [203.221.156.192])
 by smtp.gmail.com with ESMTPSA id r14sm3828769pgi.27.2021.01.27.15.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 15:44:21 -0800 (PST)
Date: Thu, 28 Jan 2021 09:44:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
To: Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
 <20210126045404.2492588-3-npiggin@gmail.com>
 <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local> <20210127071059.GA21133@lst.de>
In-Reply-To: <20210127071059.GA21133@lst.de>
MIME-Version: 1.0
Message-Id: <1611790740.civn6atbwp.astroid@bobo.none>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Excerpts from Christoph Hellwig's message of January 27, 2021 5:10 pm:
> On Tue, Jan 26, 2021 at 05:08:46PM -0500, Konrad Rzeszutek Wilk wrote:
>> On Tue, Jan 26, 2021 at 02:54:01PM +1000, Nicholas Piggin wrote:
>> > vunmap will remove ptes.
>> 
>> Should there be some ASSERT after the vunmap to make sure that is the
>> case? 
> 
> Not really.  removing the PTEs is the whole point of vunmap.  Everything
> else is just house keeping.

Agree. I did double check this and wrote a quick test to check ptes were 
there before the vunmap and cleared after, just to make sure I didn't 
make a silly mistake with the patch. But in general drivers should be 
able to trust code behind the API call will do the right thing. Such 
assertions should go in the vunmap() implementation as appropriate.

Thanks,
Nick
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
