Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66C3AC0E6
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224831; cv=pass; b=oneK90E4QlhmM0E05sUNZBXEFbe3oFKNKtdXAiE/iqmJe7Wjgrl7FV0s/2Bd9p4m/vNeirtdukvvWB6ctGja6UHVnJxc92vcmjmSfEQtqX91/0yxEPTmy0GQcHXb7f0BzNOyC5pikmIFU8OE316oHrSK6Ezwe5+uFPTY0Q7zUvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224831; c=relaxed/simple;
	bh=ICrRvlzJ7grzfWZQnrb2ZUVpkcjJ8wGbkxRLDrmId8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz6btDgY93O/TF/bTgSWOieESyZU4uli2gXGt8iqQ62RLXkp8+fji9WLXb00vKgWAHhPYFvxYQFdB048iYac5mKezxSd7FH3ew04syKewcgDgomRWDbpBqmN+DI1h1hRNblt8zf3xNUOu67UMKkPmtVpVMKJy86eT48vtvpTWJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nut3tVH2; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nut3tVH2"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b2f6e983bso3174217a12.0
        for <iommu@lists.linux.dev>; Fri, 03 Apr 2026 07:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775224822; cv=none;
        d=google.com; s=arc-20240605;
        b=VcFzgXLtUqyygNjd9o4OWAh2nq4bfG4XgfQQaWRwHAjEOWBXQg8zsQcV/Axs9GmRJE
         6El0mKrjRcCVIpUjuWkqeFMSIhoeECg3fU29UJXOuBUXjsPyk/86dHc/d5SaccTet9aF
         vI70rKZquhVYfspr2iRxMhVoUSejDFEQssVlp3V2iUzOrZFIp/FLTrsqSsR+jjYpgdYe
         J/hjkuJvD8o8YLGSfucMxwjN+Q0v52CuCn0jUfg46tjpkkuFO412f4j2biuAOVdRFBYM
         AAYukiBEOrDIsUk/U9I5ixLjjeP4BkI3+gPFpFx1/FwxO882aMIA/vgvP1Shasxs8tDX
         w53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GZJMb8BpsQsC5OCqpX0KvnetYnrUPrII+wbhqXuacG4=;
        fh=YE1ACRN3YlpN5XYbBvGT02V9J4yShCDiYrRFJHTpkDw=;
        b=kVQ4v97ADAaqJpUEp6GBmn0rQpsPCv+c7yrzALZpRJIHojv3g7E6OwIHQx5fXkhdUX
         0QLWiUPNy307R92c5TJM1IPuzmFIyXu8aoUUXdq+2J2l8AIVIIADW2a7Wf04zLZ5YtbR
         tqpWAP5RblERBXEGYAXp5SxHtK9g2QmYpYwyDGe9Cqh+QOq/LLgGsbcj3h7dmXI+8EeN
         PUptmSQ5SwWBS98M3zhZCy7ELIv+XJYcz1vpNNJ1ol65YJMc42MplRZwko9vJnohFmMx
         JSJPuAYUZ2ITs0ONDXuP/dXYaAVmUXT0Hk4fVZNT5EwIYJaGV6Sa+tQT66ndUXDUl1Jq
         ytCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775224822; x=1775829622; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZJMb8BpsQsC5OCqpX0KvnetYnrUPrII+wbhqXuacG4=;
        b=nut3tVH2umMfE6eWMhO1V/lJ6VkZP3bWYXJL21uWmmxhbYfVJrTlOxwVOxguUXAhU7
         y40rrYkQMSypCSL7qB9PrWZ+SQOiCf1R54MJU29c9HohH1jZChqDelkV7rIen8M5w66s
         MIf9GLddIypjBfz1O/rn/tJvQ5a6FVJN+gmnf+b3LkjxB7g33tlwiOV2x2ICnJaCeLJj
         FDdlXs2+btDet6/ugAr+joF08JWtGVdlRObKYLnnUfy4uKWbp2L30kpAuLg3Fes//6ep
         x4ipdqSrvUE9veq8g9g1P4x2kvjeOi5ONQd+ivg+7RTx4Fgzrnfgcmt0b7nLJjmcPXLh
         4HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224822; x=1775829622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZJMb8BpsQsC5OCqpX0KvnetYnrUPrII+wbhqXuacG4=;
        b=k26Dv6MXuYgsQv9/Id5vSu5xTw4rGxqEXdNij2ZN2VTWBLmQ0IlTXbH29DM0Ccdn2C
         behsMGlNo4FYZDQZr2oGcEt6iBeuoXiSTY0SJ8FnK+IMpCAERaAkajNrJ1D6lcgVkwT5
         UQUgjypPaWXakBX8B8xjocUK7AYFhRyqQ5O3DjY1PK4QV5/5a8jA2v717oQHWuKqct4T
         Qbn8vBvsldlFhVa6YwiePRQQDk+FiZDMUZF3FaTat0JvImBlKnocy/ob6D5v9b+KZ/Hk
         1njCE+miDyYQJMuek9ZvHPiPzmuSncBDu16PmCYEdzjiSYk2rE3FmQ5z+IAkPlp4yHMV
         ATZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkE7v4RWKL9j3EA+SH0dZLxg4bwyprbljezViJeJedHtPuHVajblX1GDvMcY4QmHt1xWKc2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YypAud3XeYUuJfOPjEWObvK4rUptS2TqgqfLOlUQ5ZZ9V6qdWaP
	FslN/Tm1Mdrpcq/k/sJ8IZNuPhikl3VEcnLsTzvK/i8sEHgiofqzBffhVaixtqK2va4nPgHjJuz
	A7ufjPNu+B1L+sT0dci63OGHaUqsvvaE=
X-Gm-Gg: AeBDiesCG3IGNcIi9bQ84hzcKHqUmKbXOBCkL6oUZ1gBdJKLnWcJcKEUyfWCemY1ohf
	l3F23YFmA/IKfXCHSo0RKwdEBBfmZ/bZA67fgis7ewymFNLDoCGCsSpMQBUtIqTyPrjHU2QZ1m9
	LOCcfWunXbB7VtZaNEb0yjaaMu1GSoyTG6TRhTbrjitM7arYuOwpd0OkdzgYqc3Sw4W+NNmd19W
	YX5B0c+L2RdzfmwPSrYRFeRfiDWYBuj3iS/8NIP9Ol3zEh6i9+bUrWVAjf+6foaA4L913cbirSy
	07YRUMMpdlxL6iG27A==
X-Received: by 2002:a05:6402:5241:b0:668:50ef:427d with SMTP id
 4fb4d7f45d1cf-66e3f70d42cmr1446085a12.21.1775224821948; Fri, 03 Apr 2026
 07:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260331075010.1463-1-midgy971@gmail.com> <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
 <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se> <89ed223d-1a2c-447d-9f21-76969e668855@rock-chips.com>
 <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
In-Reply-To: <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Fri, 3 Apr 2026 16:02:02 +0200
X-Gm-Features: AQROBzC2wzA0RbJXoNrMzE6k6aC5-WfVfCFoYB3Sb0oM_n_1ycoKvDZTyy5IIMA
Message-ID: <CA+GS1Y3K=N3emYYC-4KAZ27MO7W7ZPgczbk8xPtWC+cYm-5F1w@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2 IOMMU
To: Simon Xue <xxm@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, iommu@lists.linux.dev, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, Heiko Stuebner <heiko@sntech.de>, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 From: Midgy BALON <midgy971@gmail.com>
 To: Simon Xue <xxm@rock-chips.com>
 Cc: Jonas Karlman <jonas@kwiboo.se>, iommu@lists.linux.dev,
     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
     stable@vger.kernel.org
 In-Reply-To: <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
 References: <20260331075010.1463-1-midgy971@gmail.com>
             <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
             <e622cc9e-8fb0-454a-b88e-dc13cf2ff507@kwiboo.se>
             <89ed223d-1a2c-447d-9f21-76969e668855@rock-chips.com>
             <5663593b-2c53-4632-ad2c-db9efa8e9ab2@rock-chips.com>
 Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags
for v2 IOMMU

 On 4/3/2026, Simon Xue wrote:
 > We internally checked that the RK356x SoCs integrate two different
 > IOMMU versions (v1.0 and v2.0), like NPU and ISP use the v1.0 IOMMU.
 >
 > Both versions can map 40-bit physical pages, but v1.0 does not support
 > placing the first-level page table above 4 GB.
 >
 > To fix this, I think we need to land this patch first:
 > https://lore.kernel.org/all/20260310105303.128859-1-xxm@rock-chips.com/
 >
 > Then on top of that, we can add a new compatible string to distinguish
 > the IOMMU versions.

 Thank you Simon and Jonas for the internal investigation. This explains
 exactly what I observed.

 To answer Simon's earlier question: the IP block hitting both failure
 modes is the NPU IOMMU (rknpu_mmu, at 0xfde4b000), currently bound
 to "rockchip,rk3568-iommu" in rk356x-base.dtsi. Both the downstream
 rknpu driver and the upstream Rocket accel driver (drivers/accel/rocket/)
 use this IOMMU.

 The v1.0 first-level page table constraint explains both failure modes.
 On boards with more than 4 GB of RAM the DTE table can be allocated
 above 0x100000000, and the v1.0 hardware silently truncates or errors
 on that address. The SWIOTLB bounce-buffer path is a consequence of
 the same root cause: with DMA_BIT_MASK(32) on the NPU device, bounce
 buffers land below 4 GB, phys_to_virt() of the bounce address is then
 used as the PTE write target, and the subsequent
 dma_sync_single_for_device(DMA_TO_DEVICE) overwrites those PTEs with
 zeros from the original buffer.

 Please consider my original patch withdrawn. Modifying iommu_data_ops_v2
 was too broad and would have incorrectly constrained VOP2 MMU and all
 other v2 IOMMU users.

 I agree fully with the two-step approach. On top of your per-device-ops
 patch [1], I plan to send:

   [1/2] iommu/rockchip: Add "rockchip,rk3568-iommu-v1" compatible
         for IOMMU v1.0 blocks (NPU, ISP/VICAP) on RK3568
         =E2=80=94 ops with .gfp_flags =3D GFP_DMA32,
                .dma_bit_mask =3D DMA_BIT_MASK(40)
         (v1.0 can still map 40-bit physical pages; only the DTE
         table base must be below 4 GB)
   [2/2] arm64: dts: rockchip: rk356x: Use "rockchip,rk3568-iommu-v1"
         for rknpu_mmu (0xfde4b000) and vicap_mmu (0xfdfe0800)

 One note on the SWIOTLB issue: with GFP_DMA32 in the new ops, page
 table allocations never reach SWIOTLB, so the "track L2 base addresses"
 approach you suggested should not be necessary =E2=80=94 GFP_DMA32 prevent=
s the
 bounce-buffer poisoning at the source. Happy to be corrected if there
 is another path where it is still needed.

 I am happy to add Tested-by to your per-device-ops patch [1].

 [1] https://lore.kernel.org/all/20260310105303.128859-1-xxm@rock-chips.com=
/

 Regards,
 Midgy BALON

Le ven. 3 avr. 2026 =C3=A0 06:40, Simon Xue <xxm@rock-chips.com> a =C3=A9cr=
it :
>
>
> =E5=9C=A8 2026/4/1 18:22, Simon Xue =E5=86=99=E9=81=93:
> > Hi Jonas,
> >
> > =E5=9C=A8 2026/4/1 16:41, Jonas Karlman =E5=86=99=E9=81=93:
> >> Hi Simon,
> >>
> >> On 4/1/2026 9:48 AM, Simon wrote:
> >>> Hi Midgy,
> >>>
> >>> =E5=9C=A8 2026/3/31 15:50, Midgy BALON =E5=86=99=E9=81=93:
> >>>> commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
> >>>> available memory for IOMMU v2") removed GFP_DMA32 from
> >>>> iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardwar=
e
> >>>> supports up to 40-bit physical addresses for page tables. However, t=
he
> >>>> RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot acce=
ss
> >>>> physical addresses above 4 GB regardless of the address encoding
> >>>> range.
> >>>>
> >>>> On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
> >>>> GFP_DMA32 causes two distinct failure modes:
> >>>>
> >>>> 1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
> >>>>      memory above 0x100000000.  The hardware page-table walker
> >>>> issues a
> >>>>      bus error trying to dereference those addresses, causing an IOM=
MU
> >>>>      fault on the first DMA transaction.
> >>> Which IP block is hitting this? We'd like to take a look on our end.
> >> I have seen reports that the NPU MMU on RK3568/RK3566 is having some
> >> issue using DTE/PTE with >32-bit addresses, maybe it uses a different
> >> MMU hw revision or has some hw errata?
> >>
> >>  From my own testing at least the VOP2 MMU on RK3568 (and RK3588) was
> >> able to handle 40-bit addressable DTE/PTE, hence the original commit
> >> 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available
> >> memory for IOMMU v2").
> >>
> >> As also mentioned in my reply at [1], maybe the NPU MMU has some hw
> >> limitation or errata and may need to use a different compatible.
> >
> > Yes,  We are checking internally whether different IOMMU versions
> > integrated.
> >
> > I will share what we find once we have results.
> >
> We internally checked that the RK356x SoCs integrate two different IOMMU
> versions (v1.0 and v2.0), like NPU and ISP use the v1.0 IOMMU.
>
> Both versions can map 40-bit physical pages, but v1.0 does not support
> placing the first-level page table above 4 GB.
>
> To fix this, I think we need to land this patch first:
> https://lore.kernel.org/all/20260310105303.128859-1-xxm@rock-chips.com/
>
> Then on top of that, we can add a new compatible string to distinguish
> the IOMMU versions.
>
> >> [1]
> >> https://lore.kernel.org/r/3cd63b3d-1c5e-4a11-856e-c4aeb5d97d55@kwiboo.=
se/
> >>
> >> Regards,
> >> Jonas
> >>
> >>>> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables
> >>>> land
> >>>>      above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(3=
2)
> >>>>      then bounces them into a buffer below 4 GB.
> >>>> rk_dte_get_page_table()
> >>>>      returns phys_to_virt() of the bounce buffer address; PTEs are
> >>>> written
> >>>>      there; the next dma_sync_single_for_device(DMA_TO_DEVICE)
> >>>> copies the
> >>>>      original (zero) data back over the bounce buffer, silently
> >>>> erasing the
> >>>>      freshly written PTEs.  The IOMMU faults because every PTE
> >>>> reads as zero.
> >>> This probably need a separate patch. One way to fix it would be to
> >>> track the
> >>> original L2 page table base addresses in struct rk_iommu_domain,
> >>> then have rk_dte_get_page_table() return the tracked address instead =
of
> >>> deriving it from the DTE.
> >>>
> >>>> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, whic=
h
> >>>> currently only serves "rockchip,rk3568-iommu" in mainline.
> >>>>
> >>>> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
> >>>>     - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
> >>>>     - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
> >>>>     - No IOMMU faults, correct inference results
> >>>>
> >>>> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
> >>>> available memory for IOMMU v2")
> >>>> Cc: stable@vger.kernel.org
> >>>> Cc: Jonas Karlman <jonas@kwiboo.se>
> >>>> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> >>>> ---
> >>>>    drivers/iommu/rockchip-iommu.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iommu/rockchip-iommu.c
> >>>> b/drivers/iommu/rockchip-iommu.c
> >>>> index 85f3667e797..8b45db29471 100644
> >>>> --- a/drivers/iommu/rockchip-iommu.c
> >>>> +++ b/drivers/iommu/rockchip-iommu.c
> >>>> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 =
=3D {
> >>>>        .pt_address =3D &rk_dte_pt_address_v2,
> >>>>        .mk_dtentries =3D &rk_mk_dte_v2,
> >>>>        .mk_ptentries =3D &rk_mk_pte_v2,
> >>>> -    .dma_bit_mask =3D DMA_BIT_MASK(40),
> >>>> -    .gfp_flags =3D 0,
> >>>> +    .dma_bit_mask =3D DMA_BIT_MASK(32),
> >>>> +    .gfp_flags =3D GFP_DMA32,
> >>>>    };
> >>>>       static const struct of_device_id rk_iommu_dt_ids[] =3D {
> >>
