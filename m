Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211C6C433EF
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 01:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC10761058;
	Mon, 23 May 2022 01:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0Q2uT7N75In; Mon, 23 May 2022 01:04:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9152E6106E;
	Mon, 23 May 2022 01:04:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 659BCC0032;
	Mon, 23 May 2022 01:04:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED389C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 01:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3883417B4
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 01:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IcUlYWBFRNUa for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 01:04:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A08C141755
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 01:04:53 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id h186so12366392pgc.3
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :mime-version; bh=yOqshecnhz24HCPFL8R9k+rQYjlgSiMh0TAar9utw7U=;
 b=c3kHhbCHF1+pOhGqIxGe425To7JHa/Jp//N2OIGPKEew8HwwngyI1IO0ViTFnN7Rz1
 iyxsHvjvdZXojQ3ZEbK3/6kczlqvoiDe8rhQ1inY1dZziYRUlj/Blo4kHEGakWVdr+KE
 pBnBANwBI2fE6fPzzTJYB/TPmXV2fKKizOixivB1BtjLOTvSk6Llxa4Cc0MyKZnogNrH
 ggw0R84eB6CxctpQNPT3n8LMNbPwDi15j5MhKRo3QllD0rOku3AjOYJj9JFbPBgETqdh
 2cOzFMuofNy2wXT/fWCC9h60Dia7gfk+1gmb3knzqbs7/CNVaFMr7oOXr9eWBuS5V8vm
 zbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:mime-version;
 bh=yOqshecnhz24HCPFL8R9k+rQYjlgSiMh0TAar9utw7U=;
 b=DsNiT7unIb3tyZqIIa1ml3iwOMbNRvaE8d7rKrvWdKEYM+5iD+x/PE7Mfm1qBy/Z9x
 JFjjdOZseoq/RvDY+RQ7tr803uDnUu4T8xr1TCay9z+e9OhhOE/8Mqbi7Ej9cVhvqQ7u
 BrzUGVGe/cBH3e2GXTSYQ4rkd00zAW0m+UoLCLMK5+RsuB+856N9r5UxcqTmDP4V0lpB
 ku6yAV2pCYKrCQvImTI6I2a4cIQt+Ism/M54Y+iXwMMR1JaKp83CAH9ZoFfz7dkP/smp
 UTBonZM4pCYqeH+kn+0vCF1i1bqLYIfJURwTDPYAbUTiNRWuO9/mUWvupaMId2XKHPa2
 /V7A==
X-Gm-Message-State: AOAM530k8SuceeMySVXlK5kHFZ1hUZRW2AcB9zTkZlZedW9bLQyyRwWR
 xizaQqrlhj+CgoRfm+raVk8EEw==
X-Google-Smtp-Source: ABdhPJy/Pe9GcQRNtkgNe7XJEsRhFmPKGUbP4E3sj0Z1g4bwfFHnHxEOftK0lWDSkInAUU5Q7dw6oQ==
X-Received: by 2002:a05:6a00:1348:b0:518:7a03:1682 with SMTP id
 k8-20020a056a00134800b005187a031682mr11290564pfu.6.1653267892703; 
 Sun, 22 May 2022 18:04:52 -0700 (PDT)
Received: from [2620:15c:29:204:fa22:6f61:557f:9cd2]
 ([2620:15c:29:204:fa22:6f61:557f:9cd2])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a170902d70200b0015e8d4eb2aesm3691018ply.248.2022.05.22.18.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 May 2022 18:04:52 -0700 (PDT)
Date: Sun, 22 May 2022 18:04:51 -0700 (PDT)
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-direct: Don't over-decrypt memory
In-Reply-To: <796ddc256b8a3054cb0b2f43363613463fcf0d61.1653066613.git.robin.murphy@arm.com>
Message-ID: <22439fa1-5f9b-1e54-3f39-649b116574e@google.com>
References: <796ddc256b8a3054cb0b2f43363613463fcf0d61.1653066613.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 20 May 2022, Robin Murphy wrote:

> The original x86 sev_alloc() only called set_memory_decrypted() on
> memory returned by alloc_pages_node(), so the page order calculation
> fell out of that logic. However, the common dma-direct code has several
> potential allocators, not all of which are guaranteed to round up the
> underlying allocation to a power-of-two size, so carrying over that
> calculation for the encryption/decryption size was a mistake. Fix it by
> rounding to a *number* of pages, rather than an order.
> 
> Until recently there was an even worse interaction with DMA_DIRECT_REMAP
> where we could have ended up decrypting part of the next adjacent
> vmalloc area, only averted by no architecture actually supporting both
> configs at once. Don't ask how I found that one out...
> 
> CC: stable@vger.kernel.org
> Fixes: c10f07aa27da ("dma/direct: Handle force decryption for DMA coherent buffers in common code")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: David Rientjes <rientjes@google.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
