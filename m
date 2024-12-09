Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892C19343B
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771717; cv=none; b=GEmNRU5t/JiVKV7DK1utmJ1sKfFNLNCW6Rxsuoil059Zs3WXytRGmm7wRC9MchtfdL0Y3SNIGfqODZ96a9vI7lbob6OTpjjE27kLGmVWI/hyUr+qElFZeKb8+QYj6ggRmCx8qjw0lF/jWXPyI8oxJRdEZS8JqFsqeqc0/EZbIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771717; c=relaxed/simple;
	bh=V3Lot97r1vXyev3SYHCUBIR8IfuPtsIyk6738RhXCsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DisNEbR10pKkt/YmDPeLB1g2/JPYvg/jbvOvxEymdK7Y5Bs1sUEGgCA2/0ynd0SR/YWtqku1xex5VdBbNDDEy54GemZPtrcP2bui4K/pb1Tpimp3q9HVDyAqBHtD6mgOlrVBFlefwSgdBWZqPmJrofeQo1JTpFGAs1ZR61XZvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=mQaKAKWI; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="mQaKAKWI"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e398273d6ffso3659981276.0
        for <iommu@lists.linux.dev>; Mon, 09 Dec 2024 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1733771714; x=1734376514; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kLjgnxaHMn5y0gTT+3dvOLNzEd5yWQ0Er4eRA/5e+Q=;
        b=mQaKAKWIYNc+kmnnA667xMEEiEVxgFLc3kTNaUIZpV3kcln2LYqE6QJzus03K7HkTp
         QmHuolUgi7DgSfXuvmOov+OpnB4x2NeRGx0pOQ85yt03R4Ptqo8oVN9HiNoBmLDfiouf
         Sa7AqtrAGyObRdi2Fd422oN3MJjVn1/OKGGJVceHAbHVmyFzdiruyi+z100mhcREsT6p
         ev8txfOsC8hAZo6o700p7G3G21MPRVEkrE5WBTmhMO5ktvA0wYvztiNW7oATZnXnxu0L
         M4Q9wx6z8JwAd+4BCcBtcszzeEA1k56QL1JfD3TWIr49iElh5N7b3QN4q9hUL73P7RAU
         o3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733771714; x=1734376514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kLjgnxaHMn5y0gTT+3dvOLNzEd5yWQ0Er4eRA/5e+Q=;
        b=SqvreZrB4gU7B2WAJjv0v1mo2uch5pc7XJxeRgBRYTItok5HRrh/bh75qalSlGxXBk
         XHJqj6EHd90E4q2Vns8ouBf0otyY4YTauQ9Gaw6n3T+0YGbtizoKPEG5edtzQTnnpTVN
         zhyOznbm8mWt6M+ZMs0b6k1/UnvMEaUJLRGw57/IydZ+lGW/u58ahY5hS/6Scxa9dqB9
         w3Y+gMn/PkDVM6TU9ANjWqXOlFtj4sypuZrpopw4h4cXzxgW1zqhHV292D7/M8iXdDvZ
         S1U6lgSiJaiKN6HfHC4nrR+AdtWV+ahADAxys9JJkSBrFlHyfAKwZctKLVktA4XfAoEB
         u0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkEcqmBy+xpyctQMOdlMHHCNelEksjEEpkza4Xh1I4VnVaWVmW9LZWhAtl8sOka+uVfkBUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6ahQdDBu5GOKArQ3El7qG87U9/fs8jkLRNSDU4lk+ozIEWBAN
	fSx26SbsviPNb8oNwhrt9CTYCwQTjoCrdHoNsTe8TLwFsrbD8aI1QWPhuQeUH87aLdDbgew4nqA
	mwUk//BDMSf29p1KqHlYLzZ6tXfynPtlXhzsQxA==
X-Gm-Gg: ASbGncvhlBf8JVEtMfBd43iBQztono8t0TpdDYfLRg8zVUumJAxnb5P8ijDJuKs2e1l
	dOVRsWRsx2h1K9gp3lXhlVZxEkUL86bw=
X-Google-Smtp-Source: AGHT+IGEl64T8fh4w41xF5QeO5D03WN4PRl4tWrD5C7XLi4pHuR/6CFrIf/3ED6k/l9Dz+t1Bywo3Kx6XChWXHllhco=
X-Received: by 2002:a05:6902:124b:b0:e3a:32a9:82cc with SMTP id
 3f1490d57ef6-e3a59bade21mr1582408276.36.1733771714002; Mon, 09 Dec 2024
 11:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com> <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de> <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
In-Reply-To: <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 9 Dec 2024 11:15:02 -0800
Message-ID: <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev, 
	P Praneesh <ppranees@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:49=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 09/12/2024 8:17 am, Christoph Hellwig wrote:
> > I scrolled three pages before giving up as it was just quotes over
> > quotas.  Can you please write an email that contains whatever you're
> > trying to tell instead of just quotes?  Same for the person replying.
>

Christoph,

Understood; there was a lot of back and forth and likely some
misinformation from my early replies. Let me recap here.

The issue I run into is that with Linux 6.9 and beyond on an IMX8M
Mini SoC (no IMOMMU) with >3GiB DRAM (which requires more than 32 bits
of address due to IMX8M's DRAM base being at 0x40000000) the ath11k
driver will fail to register a netdev and errors out with 'ath11k
swiotlb buffer is full':
[    8.057077] ath11k_pci 0000:04:00.0: BAR 0 [mem
0x18200000-0x183fffff 64bit]: assigned
[    8.057151] ath11k_pci 0000:04:00.0: enabling device (0000 -> 0002)
[    8.091920] ath11k_pci 0000:04:00.0: MSI vectors: 16
[    8.091960] ath11k_pci 0000:04:00.0: qcn9074 hw1.0
[    8.832924] ath11k_pci 0000:04:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[    8.832951] ath11k_pci 0000:04:00.0: fw_version 0x270206d0
fw_build_timestamp 2022-08-04 12:48 fw_build_id
WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
[   10.194343] ath11k_pci 0000:04:00.0: swiotlb buffer is full (sz:
1048583 bytes), total 32768 (slots), used 2529 (slots)
[   10.194406] ath11k_pci 0000:04:00.0: failed to set up tcl_comp ring (0) =
:-12
[   10.194781] ath11k_pci 0000:04:00.0: failed to init DP: -12

After a lot of back and forth and investigation this is due to the
IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
is requesting some buffers that are too large for swiotlb to provide.
There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
to cacheable memory that could be reverted to fix this but the concern
was that it would impact performance moving those buffers to
non-cacheable memory (there are three ~1MiB buffers being allocated):
commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
cacheable memory").

> TBH I'm hesitant to look too closely since everything those Atheros WiFi
> drivers do with DMA tends to be sketchy, but from what I could make out
> from skimming until I also gave up, I think it might be an attempt to
> reinvent dma_alloc_pages(), or possibly dma_alloc_noncoherent().

Robin,

Agreed - I'm not sure how much attention, review, or testing these
ath11k patches originally got due to the fact that there appears to be
breakage for a couple of years here.

The chain of events as best I can tell are:

commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
cacheable memory")
- Nov 12 2021 (made it into Linux 5.17)
- changes allocation of reo_dst rings to cacheable memory to allow
cached descriptor access to optimize CPU usage
- this is flawed because it uses virt_to_phys() to allocate cacheable
memory which does not work on systems with an IOMMU enabled or using
software IOMMU (swiotlb); this causes a kernel crash on client
association

commit d0e2523bfa9c ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
cacheable memory)
- Nov 12 2021 (made it into Linux Linux 5.17)
- furthers the previous patch by also including the WBM2SW buffers in
cacheable memory which are about 1MiB in size

commit aaf244141ed7 ("wifi: ath11k: fix IOMMU errors on buffer rings")
- Dec 20 2023 (made it into Linux 6.9)
- resolves the issue from commit 6452f0a3d565 (but missing a Fixes
tag) by changing the virt_to_phys calls to dma_map_single() but on
systems that need software IOMMUC (IMX8MM > 3GiB) this exposes the
'swiotlb buffer is full' limitation due to commit d0e2523bfa9c which
allocates buffers exceeding the 256KiB limit imposed by swiotlb

Therefore in the case of an IOMMU'less system with DMA address
limitations of 32bit and >3GiB DRAM (as many IMX8M boards have) the
ath11k driver has been broken since 5.17.

Best Regards,

Tim
