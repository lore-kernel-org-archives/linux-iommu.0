Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C112FE06C
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763767707; cv=none; b=Qb3CAJVSTRcZrqDe52jiIq75QY6qhnYvMiJ4SGl+9Q2/eaOBFE4n2j+IiE+mQm0QWbVdggtnu7KQB4VfzKgP+J0dBEaWBvuRt2pihOeck4P1vUn2znf/Q+rjkI1yYA3shVt8nbGiajb9LcjKx3XQY2Lt7yZUy1bPtW6106A2hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763767707; c=relaxed/simple;
	bh=hsdIHNHsZF9T1sX7+gGYutcVt+aySGlsfoBk3lYQa0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYjXp1gsSLFRHXO/RAsb2ATK8mnVbHptN5GspQCVY6YzdgR9INC08nOaoZqEQC7dxUt6cpLydzIEPl2B+2FrvYbiVxzJ6yIJbYJ10ymkFt/yYJDWDpwOYHYCAyrLngYGX2/ddfABDJV8iFOYV40GFNkv07lR6D2ZqP2meRTuBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD9n0J/K; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD9n0J/K"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo2914054b3a.2
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763767697; x=1764372497; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxtDpSmTs7mL/tjhVCGhuXCnOSYOMYknzMq2xwvzpN0=;
        b=cD9n0J/KwYap0GMseoKDKZdVK2B/PGoqxuwfKtJQtxBLMLMxO2yCyC84fQ68k9UcQW
         X5vvkTtFLuMbLbNJcjTLkY4W78fn2Jmq4Ve1yEs++8bjZOTlKJQ4+aukPZ6FqYEpGSRe
         gHicyL7/rgQPVBD534Eb82iTTPKtNdulDbujwFlugE0ImztcEK5V9Ml5dPXTenIqMicE
         Sv+Os5RPIa1afe/e15wutZ+fgeFeRrEm2N2QBe7mRFQaovHUqyfXaKNVYP8JzFsKaLBl
         pjsVmrtDO5YcnSX2DnCwua8+N4wpQRL0Qd5pmy0pBBTuY0kB49bPI3TUKAiSXS9l/3ym
         RwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763767697; x=1764372497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxtDpSmTs7mL/tjhVCGhuXCnOSYOMYknzMq2xwvzpN0=;
        b=wAVNwbq3IRSXTx1c1lbJMJQQgqwhtuZjmmaEJjKnrpOXAgzNyQV1tP5StEiWrlXzDZ
         S8c1+mn5TvJMWhzEiZeDhyuRMGdINR6dXT/A8MRkxEI1TH5NzaMkXbuGBsPu/TmvxCWZ
         VGVV+JwCKAiX0amca0xi0ABBnnHCfeD1gR2kyi1zT/00BCJoo3Thjm82RYzTDW5xVevB
         RqquedOjh9+bNh9ON+H+Zh434ufZ+nk4L0a9l3fd9ySA4h/azWpI/EbodWEBUEZibKxH
         yR8KrxeXYmGZi4o1y1I3acHonSgaLFu4REY9NeRjfyoLZ9YQA/zNNDeBf2fFyqnx/abe
         QBUA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sscfcST+lqKuZBvxvtJbp3HBRk2mVeneLjxxPlZhB8ybyueRy/boH2RPWZ8NJ6zPiTgInA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu1jBviUjsyNWwiwYw0+Dm7jcAr4RHFaq8dcGMqTbpfANDCe7P
	SdhJeK+URTOutb5z2gUwz/h8SOIOBXQkesPe7YXUoyp+GnlTAOllFE2R
X-Gm-Gg: ASbGncuxwSlBvsHltxeNG0h3r6u4WtF0YX55l5E0Oar8aq/LrJQzvT5c8XIQmFG4qh8
	14YxwW4J+0h14dLgTBxh9Blyb8LLoBRAZDi1WQbnC4lNRdCCH4UH0HBXagX39RWoYLeBDbTvvw8
	wQno+TpMQzU2D5Lb+LS2dlKtiVE07sok3xqzldkScP76phjf3gy3eYUzNd3RAHwvtcpvN16Nols
	UIoJlne5HtiYNYV50PnSu217eb8GaJgAULT+GIb1N4JToLSEzonI7reXpCh1eAmSoihh1A7wGYK
	pEpknsiLmEfXMDf8O/uroWRABEFffQlcP1h+M/lQNe4zAHaW5lvv1nUVZZ8sqAwtdIzaTFVv1n0
	UeWQk2SsMcDnBaZj2wbM2lsRgrXF8NKJQh41hR1BPHAan+k0F4HWOFwEX9MHvey9MMyge09udAB
	OsTx1CA8yC5HF0UeZI5AK/LOl+
X-Google-Smtp-Source: AGHT+IHQzwceccuSE+ynV0dbTPoBKwMThY8XryTam2V+oxreq4oB+F/urlJ+SII61jfTJsuQO/UmrQ==
X-Received: by 2002:a05:6a20:729a:b0:35e:d74:e4b6 with SMTP id adf61e73a8af0-36150e2be9amr4501844637.7.1763767696784;
        Fri, 21 Nov 2025 15:28:16 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f095c237sm7226947b3a.45.2025.11.21.15.28.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Nov 2025 15:28:16 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: m.szyprowski@samsung.com
Cc: 21cnbao@gmail.com,
	ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	robin.murphy@arm.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	will@kernel.org,
	zhengtangquan@oppo.com
Subject: Re: [RFC PATCH 5/5] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Sat, 22 Nov 2025 07:28:07 +0800
Message-Id: <20251121232807.40491-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <253c870f-770b-4102-be47-f8c06e9e6c31@samsung.com>
References: <253c870f-770b-4102-be47-f8c06e9e6c31@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Nov 22, 2025 at 12:09 AM Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Barry,
>
[...]
> This version looks a bit better to me. Similar batching could be added
> also to dma_iova_link()/dma_iova_sync() paths.

Thanks, Marek. I will respin a new version. For dma_iova, I assume you meant
something like the following?

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7944a3af4545..7bb6ed663236 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1837,7 +1837,7 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 
 	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_for_device_batch_add(phys, size, dir);
 
 	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
 			prot, GFP_ATOMIC);
@@ -1980,6 +1980,8 @@ int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
 	dma_addr_t addr = state->addr + offset;
 	size_t iova_start_pad = iova_offset(iovad, addr);
 
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
 	return iommu_sync_map(domain, addr - iova_start_pad,
 		      iova_align(iovad, size + iova_start_pad));
 }

If so, I don't really have such hardware to test. I wonder if I can make it as
patch 6/6 when respinning, and still mark it as RFC v2. Or should I leave it as
is and expect someone with the hardware to test and send it?

Thanks
Barry
