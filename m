Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99E29AB05
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461878; cv=none; b=pl7b8epW29q+EqZ0BH0O9NmgD20Nygkid8hICZH0wo3N7zXL+CRxsocGXDOXoekAM9rBs/TWb78lj5C4qNpTfHBZSCBtMrxpYZwI0JKliQmwnK0RHWaAOUh2Rx64b6RNTUf3SF5kPIJx6f50KI+DAKHw4w+ldLOYIZ4IkF0vykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461878; c=relaxed/simple;
	bh=SKx2m1YCAFTmy3Li1bzVsBhlBB06YKzCs12SQ6XOmxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwfzY39DIpwbP8ZRjBd9/Mz9kg7fd+BUEKm6Nkzkzo9K4ykT9hrEccuOskTz2lzAVI+xVSEttxKycu9QzXuIgNJwnjE0Cln9pbh/zh51e6Z4Dxju5Fo1r1F877t5A85BtjHA8MaeFyD2pZ7Zjb/hdAhFFigZGD/jfuiGB8dAVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjaBT+vt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjaBT+vt"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8af121588d9so6156085a.2
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762461876; x=1763066676; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5Wim2l7yHGi/WuR+a4P3f7TIA6US21JyW18qkpxH38=;
        b=NjaBT+vt2buvfqMvmGdwNgXvLCL2P4q1hcZ4noUOCNgxA6CCdUkVfr5RLvDrzWuBYX
         17Qox9IDPD9L0AJTyNX0n89qc8a2PSkA+014ycFuRCP8MixMgK/2IeWRtAs5KBF6NwEm
         +VrYvWBv902ihPTXUtI+bXkLf0n/8vPI/100uwCdZ5DPcEohS/4pT22plw7vD0YOiW0/
         5qK0BhQB00w4uh0FEjmpQzOU+GgaQC6MmvR8MFxICENzzgypoqhbFAUgg5NywAEg7joq
         qeMEAG9L2aoSq7vvKfb4vhlo3B8G93AXS2DKNcWYKBOkpq0xhFMAVdSi9uJA31aKWoSu
         O+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762461876; x=1763066676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5Wim2l7yHGi/WuR+a4P3f7TIA6US21JyW18qkpxH38=;
        b=kBZqbIZmO3cH4lNMtxtxQMwDGI5MTJ51xkN0Brj/et6ezgDaXob/GrviebdEqnKYi5
         9HLFNJOx2EudSOdqWz3nSZLlEX6Araj4h7xpNuiJQ7wQN4OtewBvBmkIwSn3F1X/qHHY
         gxmVAIy8f6EepU+uqbOBv9lDJ2ft0B8c/XnNA2NnFTrU9jc754f5SI6oppGEE4o1Oz6W
         gwPhAHOr6iU9+ri6/EnqRTFDgeBJf5x4YNaeB8gufDz/Z78o0266ITrmp/q1v3ScRY6I
         HHTWVi8vaN3gx2FoUdhd7chTHpTj6llWpJunukSBrOlaAalhFSt9W+7Av++/jyARWz3O
         N20w==
X-Forwarded-Encrypted: i=1; AJvYcCXXmtnF91WMstx5wYY7v4/j/m20CHiDrlDDceZSxR1t4hTqXPGU/yjOivs0lqCHedQOe8nF9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSCz8/DgkPB5A0zhgiGcdYtfi31tp6dWMNW5AoJMfhHsFcvoBA
	IQk3eM7PpVcg+GRfN0lSn1O8IisJqQGelyPc9hKOW/GhbXX7BbC0r7DcEu8r1bosl97oA+8d4Ha
	pi0ePqsyn0JzrdJLz+hIAk3F3K3yw9f8=
X-Gm-Gg: ASbGnctViXAkIAuPNVODRMJAY4UmM+IatzyIMnaBURSC5y/FA457XWXuNphhgWwYaDe
	mOg5X8XUpAf9+1V10PcRTLAz+e2pFxGpwZpzvPkk4Tyz5HpiB1T7GfloxBGHjFdGeo1zrnWXSFv
	kWr0B73NceOsJk1X+oZw/ZXRChJYMnmyQ6QZQpEmhjpELVgjJ2KGxa0qnc1iXnYVNVyIKqfi0OK
	A+6UwTgZhyC8EAagJ6F6+W6yEjEf1w35WCmLY3xuJZ++gzoNEFtva0FXCTPuVnJhKuq+H4VT+mH
	+QD/omJEPWW10H+kopMuj6fC6JdjiV6nJ7h++Q==
X-Google-Smtp-Source: AGHT+IGz8Y08GiIKkx5vY35Pamqy5/QXc0dcKCzhllhnUKHhV1vYYvBZag4ViRF1b6CAEtb+2wXa1fOPMaLoDa+5/MI=
X-Received: by 2002:a05:620a:4081:b0:7e8:3fbd:4190 with SMTP id
 af79cd13be357-8b245274f77mr136213385a.2.1762461876060; Thu, 06 Nov 2025
 12:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029023115.22809-1-21cnbao@gmail.com>
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Nov 2025 04:44:24 +0800
X-Gm-Features: AWmQ_bn8KiJSqK3-zGdnXEadv5DAIhjUO-bmMe5yIKhizW75xMm4dJ2q8wKSyoI
Message-ID: <CAGsJ_4wy6ZPhCvMqODy6W6Why34Lfn5WXf1bUwJh+Qmd2X2rCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] dma-mapping: arm64: support batched cache sync
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:31=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Many embedded ARM64 SoCs still lack hardware cache coherency support, whi=
ch
> causes DMA mapping operations to appear as hotspots in on-CPU flame graph=
s.
>
> For an SG list with *nents* entries, the current dma_map/unmap_sg() and D=
MA
> sync APIs perform cache maintenance one entry at a time. After each entry=
,
> the implementation synchronously waits for the corresponding region=E2=80=
=99s
> D-cache operations to complete. On architectures like arm64, efficiency c=
an
> be improved by issuing all entries=E2=80=99 operations first and then per=
forming a
> single batched wait for completion.
>
> Tangquan's initial results show that batched synchronization can reduce
> dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
> phone platform (MediaTek Dimensity 9500). The tests were performed by
> pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
> running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
> sg entries per buffer) for 200 iterations and then averaging the
> results.
>
> Barry Song (5):
>   arm64: Provide dcache_by_myline_op_nosync helper
>   arm64: Provide dcache_clean_poc_nosync helper
>   arm64: Provide dcache_inval_poc_nosync helper
>   arm64: Provide arch_sync_dma_ batched helpers
>   dma-mapping: Allow batched DMA sync operations if supported by the
>     arch
>

Hi Catalin, Will, Marek, Robin, and all,
Do you have any feedback on this before I send the formal
patchset (dropping the RFC tag)?

Thanks
Barry
