Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576124FECCC
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634481; cv=none; b=ffQsTyBszGm84LS3qOnfzIL8DfnLxqkEekTjKlWr0vkbkJA1ehQT5+D01UGY9v6QZsHKstJCk9crF4T9Lz+fXI4oUAZq0vCUyVXG8p9B9ATeQwMIXULlAsSgsDlLjtO4PcQkfOo3mVQRSzHzjJm5OnDoHrpKd0sW28Af9LW5vGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634481; c=relaxed/simple;
	bh=KPJfbyNYAXvzZq8m4TBWqxbvwNJkc2YnMnWqXeFStFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOty9Xd7dmUjSrPUlOhgDFlSVfVPP1SLcrx3bqZnlv2tXZgEsFI9Hyrf6skNx7+o+EiX1EOvLRJqlz4GZMNkLxC1o1vCDLRxG+nb9Sd5Jki27plBnkiXKNfD+BuEvLOwoB6QMi4GMvyB8hUk5UhRs1owe/2sgyybzZvDrmmZteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da+Vf+79; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da+Vf+79"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d8fd3b729dso17852195ad.1
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788634478; x=1789239278; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xc1v+zjRGhQEiAXJQs4wYpDjz/6EzrVoXejIOIFfbFo=;
        b=da+Vf+79dpywuMUNLcANQDhqavHCvgpxcuiP4KMgVPrW2IfEbsedqFU2GsdlwU4nef
         DIQAbKtiptWzUkbsH6jnurHyx5ihWbEnZdNNRFXLpaq6mLFlmI9tmCOHRQ43stuMLJmf
         F4mVCkhpw0zN512zwKw+QTiPnHiNIPlG3NxNVraUpCco/wapMVcA6VhFO+GsYGcq6tL+
         er/D9zlcsBsEgXWsg7FVeV3CNH3tDcjWf09SYdSrwk4By+1faYROZBo5zcZ21C60vqWs
         8eAd4hKT27CIEEoMS7HwL/Yxc+WfTAirlLwDLgScypeFvLnh+1VKqhlnw3Z3Ue2btnX2
         n4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788634478; x=1789239278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xc1v+zjRGhQEiAXJQs4wYpDjz/6EzrVoXejIOIFfbFo=;
        b=f2YiHEX819I8HnTu+82kaoNGxIhq2rUm1B7hAI6Uw3YqqITdSHvCKUMCxN0SWBxR1l
         PlPeoE6iag3iDvZ8DO8PidkdsEWv4wW+FrBssxZB59nGf7bQDWsNkc/g0ga/6gkSu0CT
         caG/5FYhgh9Rwc2liqz9j7pKyP4K1IBujt9tz/uCGwZNj21PJwjbG/lUSDhN+IW3+/Gd
         I1nzcHuxCngMq3w9T2M6Sw7P4CClg4FT7so0hMQdKLYMeFDtLCkK3JjtzsOVGFz9o9BM
         XPAt7D4T5p0u6zxbudVL1QSdxHNlQH+EnZCzY573ZtZqyoY/oVJDalGM05PukUeTucMu
         6/8w==
X-Forwarded-Encrypted: i=1; AKwUvBzysLM7h8gDW27QFumJHoaQXqYwA3JWlSzn6oBh6E0lVFPiC6Ic7S+UXG06uYHZJDP4F2eWow==@lists.linux.dev
X-Gm-Message-State: AFuF++nBOzfdj+oDqFM+y8saBj6MF3auvii6bmulmGnDlbP/5C/vt1tC
	Pf9rGrjWtP1NAl04mnOlgcsV6FZQv3Fk4wuPA2NdNpSqzy081GSkWfg=
X-Gm-Gg: AYBFou07c3rL6lN5OoScD34FKycZBE3S4rpHE4LqEuKKLSUCleqRkDtcMb5NbPczevN
	G2YzavHPpPEcDwZTAoqXB8tNzwH2tCTxHGFaCAymWaWvdLebPfnDmcrElZ6E25uT+aoeye6yPJt
	VJpATL5h9elH+Att+H4dgBD2ZydmLpsVKytUG6HgeB9T8tRo7oVF0e1STWNoh5SAbjGdLCGffez
	A+xTXdOS6Wz1/zS50b80cbYaAW+YKtkg3jmMHJ4Lp3QMQtEFKATUCtro4wNeFi5jKJDWs2onoIU
	dR1A6l2R+n8Ez6WDVT8dNCooe5T2MWI0jvvHlXVcaIqrCRD6l9lPbuhhnaxDkE2g31AcjIQPOVC
	nWVyABhPtckIuo7ANIrchQsFqtEiijf+FOKN0eo4VlshVOxtfNVsJqa05VHm0HczM0qLEbVxfZ5
	mMo2rCQN9E3iGOldHFgXlmNM3zk82zrn1bCuQST+V7pktn2mpXN+fQu2wOfBXNmKlBIIqusjq9S
	Uo0Tcrm29QpTw==
X-Received: by 2002:a17:902:f546:b0:2d3:7c58:b0e1 with SMTP id d9443c01a7336-2db1212aa5bmr210215015ad.0.1788634478070;
        Sat, 05 Sep 2026 11:54:38 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db25ea9bdfsm14337015ad.75.2026.09.05.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:54:36 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Bumyong Lee <bumyong.lee@samsung.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: Re: [PATCH] swiotlb: use the adjusted address for the highmem page lookup
Date: Sun,  6 Sep 2026 03:54:31 +0900
Message-ID: <20260905185431.177766-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN6PR02MB41579A137BC1D48AFE93E27FD4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com> <SN6PR02MB41579A137BC1D48AFE93E27FD4B42@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 05, 2026 at 03:45:41PM +0000, Michael Kelley wrote:
> I don't understand this paragraph, but that may be because I'm not that
> familiar with highmem. Are all the slots making up a particular swiotlb
> mapping either highmem or lowmem? If a mixture is possible, then a
> partial sync could start somewhere in a lowmem page and cross over
> into a highmem page, which would break.

The slots are always lowmem: the pool comes from memblock_alloc_low() and
swiotlb holds one kernel address for it in mem->vaddr. PageHighMem() here
asks about the pages behind orig_addr, so the question is whether one
mapping's original buffer can span both. It can. ZONE_NORMAL ends at
max_low_pfn and ZONE_HIGHMEM starts there, and while the page allocator
will not hand out a run across that line, pages_are_mergeable() and
bvec_try_merge_page() merge on physical adjacency alone.

Your case is real, and this patch does not fix it. On a 32-bit ARM guest
(multi_v7_defconfig plus ARM_LPAE and HIGHMEM, 2G, swiotlb=force) with
lowmem ending at pfn 0x70000 and high_memory at f0000000:

  orig=6ffffe00 len=1024 last=700001ff
    mainline    PageHighMem(pfn_to_page(PFN_DOWN(orig))) = 0
    this patch  PhysHighMem(orig)                        = 0
    phys_to_virt(last) = f00001ff, past high_memory

  dma_map_page(pfn 0x6ffff, off 3584, len 1024, TO_DEVICE)
  Unable to handle kernel paging request at virtual address f0000000
  Internal error: Oops: 206 [#1] SMP ARM
  PC is at mmiocpy+0x4c/0x334
   dma_map_page_attrs from ...

The same oops with and without this patch, and no partial sync is needed
for it: the bounce at map time does it.

is_highmem() is monotonic in the pfn, since ZONE_HIGHMEM and a
ZONE_MOVABLE carved out of it are the highest zones, so testing the last
byte alone covers your case and this one, at the cost of the single test
already there. On top of this patch:

	-	if (PhysHighMem(orig_addr)) {
	+	if (PhysHighMem(orig_addr + size - 1)) {

The loop copies through kmap_local_page(), which is fine for a lowmem
page, so entering it for a range that only ends in highmem is correct.
That guest survives the map above with it.

The second one predates 5f89468e2f06, so I will send it separately.
