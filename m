Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95D19440
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Er7JmLfT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5a7d1816bccso2230077b3.1
        for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697757946; x=1698362746; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxadM6dkbOYlTvs8yd6/RgRBOylyunzhgUiG5TSJo8s=;
        b=Er7JmLfTQ2uAEZzkliOZqQyMXKci7ngFaDeORlzbmRJCgChm6ZYd3iOnwDWk0y0saR
         7j4tXpIN2aPD0GsoB3lf8eYwWIFWg8HM7l0AsY2YAIbkHcscF5F1apHf3gWYW9qe9auf
         VVXd0QwbRep6i3sqtJJaHJMmrM4VmRq9wiVTDC7vL8bQApT4ZTQF+mge3eR3lnkq1SmR
         fNRfRt9KuFzmqfXtnq6k1+nOYS9lvbnyQme9iL9AcNoL6PtqRWpZY9uzscafBsLybC0E
         0DVIDtpTjut5/TVS5oEisZG7nctFUlnzWUGpwQe4uNRJt3wJKEo0yQb8soulsxV6PSlU
         aMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697757946; x=1698362746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxadM6dkbOYlTvs8yd6/RgRBOylyunzhgUiG5TSJo8s=;
        b=GYTyffzX7Vguoe0Wf5BPHyLOgkWMP1SPiC5esc3bzqYEcMI/S+DZjlfikDgT+HtI+K
         TBtZ7UAnEuydZ66YtSnODfI+lViZpWcuJFo80UTpavVKCdxZMEGS0Fhz9vQZWiwQYKmC
         BWw8JgbOx7iWCimNQcNJCpU8Pb1iXoAGSfAKtLplRFL5WxbEesU+G10nUOoZPFsaogqV
         O0Co5vOdA+7oGu9KSGAu98eKwX2+q9A3RF9XKcbi/uVSasYaMckyoJBQsDQNNQ39DkZ8
         dZ7/FHroyzfggyFRi0OG8Ti1dKQm04550M5vliWWwISkHu5yBccbqK1KxsaBrri6IAih
         OwxQ==
X-Gm-Message-State: AOJu0YwX+Es2lVoSVBKgKF6E/jY7iYWepn5viTyaLujU8QK6/tsitHAZ
	DAo7QfWORr1k2XMfRcsWo2ylvu3WQms=
X-Google-Smtp-Source: AGHT+IESFIEpog5mgYIynPrnCsSyXLSYX2fnHymO36oJ2DKvdCCno9OkUpLvvn9OEvYlySwvbQyyi0tSEdc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr10132ybu.7.1697757946202; Thu, 19 Oct
 2023 16:25:46 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:25:44 -0700
In-Reply-To: <85e332bf-decf-427c-a2e5-95ab872d4ea6@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231018173409.1871540-1-seanjc@google.com> <85e332bf-decf-427c-a2e5-95ab872d4ea6@arm.com>
Message-ID: <ZTG6-GalaSf2lMBq@google.com>
Subject: Re: [PATCH] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
From: Sean Christopherson <seanjc@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 18, 2023, Robin Murphy wrote:
> On 2023-10-18 18:34, Sean Christopherson wrote:
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 01637677736f..e071415a75dc 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -1296,11 +1296,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >   		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
> >   	tlb_addr = slot_addr(pool->start, index) + offset;
> >   	/*
> > -	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
> > -	 * to the tlb buffer, if we knew for sure the device will
> > -	 * overwrite the entire current content. But we don't. Thus
> > -	 * unconditional bounce may prevent leaking swiotlb content (i.e.
> > -	 * kernel memory) to user-space.
> > +	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
> > +	 * the original buffer to the TLB buffer before initiating DMA in order
> > +	 * to preserve the original's data if the device does a partial write,
> > +	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
> > +	 * the original data, even if it's garbage, is necessary to match
> > +	 * hardware behavior (use of swiotlb is supposed to be transparent) and
> 
> Super-nit: I think that last "and" is superfluous (i.e. unwritten memory not
> magically corrupting itself *is* the aforementioned hardware behaviour).

Ah yeah, agreed.  How about this?

	/*
	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
	 * the original buffer to the TLB buffer before initiating DMA in order
	 * to preserve the original's data if the device does a partial write,
	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
	 * the original data, even if it's garbage, is necessary to match
	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
	 */
