Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0507C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 19:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6476640BD1;
	Tue, 21 Jun 2022 19:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6476640BD1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FyH+MCco
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nttv7tKw4xJn; Tue, 21 Jun 2022 19:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7DF3402BC;
	Tue, 21 Jun 2022 19:58:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7DF3402BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C009AC0032;
	Tue, 21 Jun 2022 19:58:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 084C0C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 19:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D16124168D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 19:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D16124168D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FyH+MCco
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thg1HKs1kZdb for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 19:57:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 567A24167A
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 567A24167A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 19:57:58 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id g4so11784206lfv.9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fsdYQTaklxVpMVnF74Fwow7BM/BoXJFQmtaeoDmy2hs=;
 b=FyH+MCcoAhSukHTzzC9zO3eoVyRq1qpXmRCZl6t55YnB32nSo6Oc1s/51247/QscRJ
 OQ7ZrAGwgwDDFmvRFt6ZDpMXEkkpevwi8l4tnEa05kRFZU0pP3I4ftUjfRnoohZo91gi
 X0feNSv3mFlUlza65awMWNw5ONu1MZmSj9eiKXjkkqr9BNLasgk35JY6RcLgpQSxH3Am
 KttX8hoSjULEyvg7mPEWhloR5KHTvC6lE+U4RewNuLg/dmVBiNfYbUTDzWdiMCVppDW1
 AkMApZQxG9NR4tM1dF9tgXjY7OFKi46cFP0eq9FDf4RyId+GLzioAja0FhXzDuGzprtL
 O6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fsdYQTaklxVpMVnF74Fwow7BM/BoXJFQmtaeoDmy2hs=;
 b=itP3Y07hhK7sxuYvxGmSofTeKP65/OPv0BBUEyVAP886POx7QuRssz3XCBkm9qDPTH
 7DqnicSb3+FWuF5qYJmolBk7FNrQZ0KFLRH6DHfLziTTvU2ZqFxmGrniEv/oaF+QO3sT
 bkYmOzTTwm2x41Ry39hV/8CQ7EPiysCQqfN8s9OzRYX9DrpPyii62F8cZkasVW/RJ6ix
 TLNBd/OAW5DgeqAW9jWga5+ia24sfYyDLXn64Ld0lH0Q2e6Ow0X5xQ5jh04BxTeKaaUb
 Hn1ejnUXWa0usMrj2lULY9akHJ2nYZtuL+9Fe+XSFGAA8oweRfO0j2k4J9JxsTwEODPq
 /4+w==
X-Gm-Message-State: AJIora95xVpYJTopMrZZ+qrt4fsKKNpNV4n2uGkX49lXaNKJkTXvVJOj
 4RA7W9B5Oa62OLPj/WICQ+yh98VkiUAnSPCY9yZ1yA==
X-Google-Smtp-Source: AGRyM1tZti33hqtcfRWE9/wlPsix/FQKmBuC6bf9FCaquFQpjIj54ZeAiGqQxoPDRcXHWvdOZFxc6Xpd5l82usRX4h4=
X-Received: by 2002:a05:6512:1087:b0:479:4fb5:1cbb with SMTP id
 j7-20020a056512108700b004794fb51cbbmr17405991lfg.142.1655841476083; Tue, 21
 Jun 2022 12:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-3-semen.protsenko@linaro.org>
 <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
 <CGME20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977@eucas1p2.samsung.com>
 <CAPLW+4kKR+7hM-eZc8-v6Dzeaj+TPBRmCLDSVNEnfx2WmN2TJA@mail.gmail.com>
 <54b76143-dff3-8a19-7ab9-57fb80d59743@samsung.com>
In-Reply-To: <54b76143-dff3-8a19-7ab9-57fb80d59743@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 21 Jun 2022 22:57:44 +0300
Message-ID: <CAPLW+4nxSDeGL-1hFzdDr3vYx+9ct8_YrXfVNgzwm1Gq2=Vh7A@mail.gmail.com>
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-samsung-soc@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
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

Hi Marek,

On Fri, 21 Jan 2022 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

[snip]

>
> Well, for starting point the existing exynos-iommu driver is really
> enough. I've played a bit with newer Exyos SoCs some time ago. If I
> remember right, if you limit the iommu functionality to the essential
> things like mapping pages to IO-virtual space, the hardware differences
> between SYSMMU v5 (already supported by the exynos-iommu driver) and v7
> are just a matter of changing a one register during the initialization
> and different bits the page fault reason decoding. You must of course
> rely on the DMA-mapping framework and its implementation based on
> mainline DMA-IOMMU helpers. All the code for custom iommu group(s)
> handling or extended fault management are not needed for the initial
> version.
>

Thanks for the advice! Just implemented some testing driver, which
uses "Emulated Translation" registers available on SysMMU v7. That's
one way to verify the IOMMU driver with no actual users of it. It
works fine with vendor SysMMU driver I ported to mainline earlier, and
now I'm trying to use it with exynos-sysmmu driver (existing
upstream). If you're curious -- I can share the testing driver
somewhere on GitHub.

I believe the register you mentioned is PT_BASE one, so I used
REG_V7_FLPT_BASE_VM = 0x800C instead of REG_V5_PT_BASE_PFN. But I
didn't manage to get that far, unfortunately, as
exynos_iommu_domain_alloc() function fails in my case, with BUG_ON()
at this line:

    /* For mapping page table entries we rely on dma == phys */
    BUG_ON(handle != virt_to_phys(domain->pgtable));

One possible explanation for this BUG is that "dma-ranges" property is
not provided in DTS (which seems to be the case right now for all
users of "samsung,exynos-sysmmu" driver). Because of that the SWIOTLB
is used for dma_map_single() call (in exynos_iommu_domain_alloc()
function), which in turn leads to that BUG. At least that's what
happens in my case. The call chain looks like this:

    exynos_iommu_domain_alloc()
        v
    dma_map_single()
        v
    dma_map_single_attrs()
        v
    dma_map_page_attrs()
        v
    dma_direct_map_page()  // dma_capable() == false
        v
    swiotlb_map()
        v
    swiotlb_tbl_map_single()

And the last call of course always returns the address different than
the address for allocated pgtable. E.g. in my case I see this:

    handle = 0x00000000fbfff000
    virt_to_phys(domain->pgtable) = 0x0000000880d0c000

Do you know what might be the reason for that? I just wonder how the
SysMMU driver work for all existing Exynos platforms right now. I feel
I might be missing something, like some DMA option should be enabled
so that SWIOTLB is not used, or something like that. Please let me
know if you have any idea on possible cause. The vendor's SysMMU
driver is kinda different in that regard, as it doesn't use
dma_map_single(), so I don't see such issue there.

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
