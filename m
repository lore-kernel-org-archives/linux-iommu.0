Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD6CCA47F
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 21:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5462F60ACA;
	Sat,  2 Jul 2022 21:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5462F60ACA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iHgIVjJ6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYOpPXIFsL6m; Sat,  2 Jul 2022 21:50:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F29C160A89;
	Sat,  2 Jul 2022 21:50:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F29C160A89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE955C0032;
	Sat,  2 Jul 2022 21:50:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB593C002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8756C82605
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:50:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8756C82605
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=iHgIVjJ6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWWlMLOQEH03 for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 21:50:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 271C3825B1
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 271C3825B1
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:50:22 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id n15so6613660ljg.8
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DsgRlOlQk9CwhHGV4ShnBQjDciUiTvVu2KrFtsUP2QE=;
 b=iHgIVjJ6tsmEQTaXwiUnbyprQ6kTlXSHFNFbP2VajQCV/JSloHmhlznAzHVP+LIksk
 kf4DWLS9WEbuQYkPzbQL8UJ02i25dGUxQcwwDGSjd4CyjnacI0+RT3lvgBxhgFea7xCN
 tzEM4P2v2PsBfoQii9r4HIcTknEgNU+aIUFDve19qhg7bF9NImKZ9a5kfpjaU2tNV4if
 84SqSpogm5hvr2tLQIBISeeh9I3i00LwOijlHRYulnhnwlLVnawP9oVXZZ8bFooJv7u6
 lImxJuTzH9ZMeUTSkVzU3yNKlkSi9JaCNY9LE/9R4tSjkhny8m1KCgdla1t4CNCjm3P2
 101w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DsgRlOlQk9CwhHGV4ShnBQjDciUiTvVu2KrFtsUP2QE=;
 b=GBSMkL0YVM8GP7m9fCuqV+YXG2V5cIwPWncS/UbWpo7LNIkyrek0aaBwEg50fudT57
 2w0wmf+Z/glMzaiaoYh8qDyU8MS6yFnsT8rXNxv5bMbVBySZbG1pbqvW2oEK8+DRmqlB
 He6G1KrwzG7xNQ4q5evvZnUX7iDojkvoNpgibu7nivUbL+ZBmGH58K2lzMZDbQZnF+FO
 R1zeR4zdQEDsjjCQ+zgi6uchEvJvSKn3yDI3rZb6YjIOvep0yV5V73kuNONymWSvRdle
 DFhWcDa0/pXv0cPBv3dZrwMapZGOelUPvt9Jei6DN0dlIaO6Np93nC3yE9Vvl4g6zvLu
 HS4Q==
X-Gm-Message-State: AJIora8APtUv0is/Z10zhqFOeNxMX35B+qQ7bIP0p0B+BK8NHvEH0bjQ
 dHErMImtVx94Y31PO9T6OXBGTd5+1pg1VHdoVov4UQ==
X-Google-Smtp-Source: AGRyM1vLXwqhz6BzpCK0xevUybI4ir5IKfjFa4+/fr/QmTio9FpicbapVRcLunnalpFIvKFmIcC0KUay7XBkKRfJ0Sg=
X-Received: by 2002:a2e:990:0:b0:25a:7c03:eb70 with SMTP id
 138-20020a2e0990000000b0025a7c03eb70mr12239290ljj.350.1656798619915; Sat, 02
 Jul 2022 14:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-3-semen.protsenko@linaro.org>
 <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
 <CGME20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977@eucas1p2.samsung.com>
 <CAPLW+4kKR+7hM-eZc8-v6Dzeaj+TPBRmCLDSVNEnfx2WmN2TJA@mail.gmail.com>
 <54b76143-dff3-8a19-7ab9-57fb80d59743@samsung.com>
 <CAPLW+4nxSDeGL-1hFzdDr3vYx+9ct8_YrXfVNgzwm1Gq2=Vh7A@mail.gmail.com>
 <47a0abcc-b3d6-a9a3-8d3a-5689bbf8767a@arm.com>
 <ec775e98-1164-1016-13c7-9247e751782a@samsung.com>
In-Reply-To: <ec775e98-1164-1016-13c7-9247e751782a@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 3 Jul 2022 00:50:08 +0300
Message-ID: <CAPLW+4=MG2HwySJwZe427aHVtykVA1KBWg6a5qFRnFrWbhb4=w@mail.gmail.com>
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Will McVicker <willmcvicker@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-samsung-soc@vger.kernel.org, Mark Salyzyn <salyzyn@google.com>,
 Jinkyu Yang <jinkyu1.yang@samsung.com>, Thierry Strudel <tstrudel@google.com>,
 Rob Herring <robh+dt@kernel.org>, Cho KyongHo <pullip.cho@samsung.com>,
 linux-arm-kernel@lists.infradead.org, Jonglin Lee <jonglin@google.com>,
 "J . Avila" <elavila@google.com>, Shawn Guo <shawnguo@kernel.org>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, 22 Jun 2022 at 12:57, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>
> On 22.06.2022 11:14, Robin Murphy wrote:
> > On 2022-06-21 20:57, Sam Protsenko wrote:
> >> Hi Marek,
> >>
> >> On Fri, 21 Jan 2022 at 14:31, Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >>
> >> [snip]
> >>
> >>>
> >>> Well, for starting point the existing exynos-iommu driver is really
> >>> enough. I've played a bit with newer Exyos SoCs some time ago. If I
> >>> remember right, if you limit the iommu functionality to the essential
> >>> things like mapping pages to IO-virtual space, the hardware differences
> >>> between SYSMMU v5 (already supported by the exynos-iommu driver) and v7
> >>> are just a matter of changing a one register during the initialization
> >>> and different bits the page fault reason decoding. You must of course
> >>> rely on the DMA-mapping framework and its implementation based on
> >>> mainline DMA-IOMMU helpers. All the code for custom iommu group(s)
> >>> handling or extended fault management are not needed for the initial
> >>> version.
> >>>
> >>
> >> Thanks for the advice! Just implemented some testing driver, which
> >> uses "Emulated Translation" registers available on SysMMU v7. That's
> >> one way to verify the IOMMU driver with no actual users of it. It
> >> works fine with vendor SysMMU driver I ported to mainline earlier, and
> >> now I'm trying to use it with exynos-sysmmu driver (existing
> >> upstream). If you're curious -- I can share the testing driver
> >> somewhere on GitHub.
> >>
> >> I believe the register you mentioned is PT_BASE one, so I used
> >> REG_V7_FLPT_BASE_VM = 0x800C instead of REG_V5_PT_BASE_PFN. But I
> >> didn't manage to get that far, unfortunately, as
> >> exynos_iommu_domain_alloc() function fails in my case, with BUG_ON()
> >> at this line:
> >>
> >>      /* For mapping page table entries we rely on dma == phys */
> >>      BUG_ON(handle != virt_to_phys(domain->pgtable));
> >>
> >> One possible explanation for this BUG is that "dma-ranges" property is
> >> not provided in DTS (which seems to be the case right now for all
> >> users of "samsung,exynos-sysmmu" driver). Because of that the SWIOTLB
> >> is used for dma_map_single() call (in exynos_iommu_domain_alloc()
> >> function), which in turn leads to that BUG. At least that's what
> >> happens in my case. The call chain looks like this:
> >>
> >>      exynos_iommu_domain_alloc()
> >>          v
> >>      dma_map_single()
> >>          v
> >>      dma_map_single_attrs()
> >>          v
> >>      dma_map_page_attrs()
> >>          v
> >>      dma_direct_map_page()  // dma_capable() == false
> >>          v
> >>      swiotlb_map()
> >>          v
> >>      swiotlb_tbl_map_single()
> >>
> >> And the last call of course always returns the address different than
> >> the address for allocated pgtable. E.g. in my case I see this:
> >>
> >>      handle = 0x00000000fbfff000
> >>      virt_to_phys(domain->pgtable) = 0x0000000880d0c000
> >>
> >> Do you know what might be the reason for that? I just wonder how the
> >> SysMMU driver work for all existing Exynos platforms right now. I feel
> >> I might be missing something, like some DMA option should be enabled
> >> so that SWIOTLB is not used, or something like that. Please let me
> >> know if you have any idea on possible cause. The vendor's SysMMU
> >> driver is kinda different in that regard, as it doesn't use
> >> dma_map_single(), so I don't see such issue there.
> >
> > If this SysMMU version is capable of addressing more than 32 bits,
> > then exynos_iommu_probe_device() should set its DMA masks appropriately.
>
> Well, Sam's question was about the Exynos SYSMMU own platform device,
> not the device for which Exynos SYSMMU manages the IO virtual address
> space.
>
> Simply add something like
>
> dma_set_mask(dev, DMA_BIT_MASK(36));
>

Yep, that one worked, thanks! Just submitted a patch, with a bit of
additions: [1].

[1] https://lkml.org/lkml/2022/7/2/269

> to the beginning of the exynos_sysmmu_probe(). This will disable SWIOTLB
> and switch to DMA-direct for the Exynos SYSMMU platform device.
>
>
> > (as a side note since I looked, the use of PAGE_SIZE/PAGE_SHIFT in the
> > driver looks wrong, since I can't imagine that the hardware knows
> > whether Linux is using 4KB, 16KB or 64KB and adjusts itself
> > accordingly...)
>
> Right, this has to be cleaned up. This driver was never used on systems
> with kernel configuration for non-4KB pages.
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
