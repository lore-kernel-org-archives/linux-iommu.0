Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45D7C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 09:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23913409C1;
	Wed,  6 Jul 2022 09:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23913409C1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tz7RGCpu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9KcICzqhQ-fq; Wed,  6 Jul 2022 09:03:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE1DC4016A;
	Wed,  6 Jul 2022 09:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE1DC4016A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDDF2C0033;
	Wed,  6 Jul 2022 09:03:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EC6C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 09:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB7CD404F8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 09:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB7CD404F8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tz7RGCpu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10VkL8UEuV_s for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 09:03:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20FBC4048F
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20FBC4048F
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MQARnlMToRVEqeLEMG+9wozanL3J51GC/4ROL/yqQsA=; b=tz7RGCpugBXvVFqz6jl03wLVUe
 OomVJj7+GmEelW2X4/5m9U1uYUtNL4A7HoDzyvoZZw9LUwgoC+hmtVGU0FXZEuqkn0obaHtMeKwcu
 M9unWnQmfP02x9t+LJukCtXvxQ1XRcHdQaBaU+a9NC4I3YvGujXJR/NiIfJHu1MuItdCfuhUf88xo
 lAsVQzRv7DRGqszQ6R5CqSkPoDI+uj3qnuDsmUWOD+4hYuMZ9Y9k4SE3ARyz/BR/PZs7geQ3pe5HY
 UEt/C04JWGAUB/rKxaguwIb1tbE/Te0IMAFutJM8/MlDt+TNuTYBS9gs7JGMnbWr6zfFaclgfQv4P
 YgEsPKeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o90vx-007ayM-Oy; Wed, 06 Jul 2022 09:02:57 +0000
Date: Wed, 6 Jul 2022 02:02:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number
 of lapic entry in MADT
Message-ID: <YsVPwYGHUoctAKjs@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
 <YsVBKgxiQKfnCjvn@infradead.org>
 <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, rafael@kernel.org,
 dave.hansen@linux.intel.com, pavel@ucw.cz, hpa@zytor.com, kys@microsoft.com,
 Christoph Hellwig <hch@infradead.org>, wei.liu@kernel.org,
 Andi Kleen <ak@linux.intel.com>, corbet@lwn.net,
 damien.lemoal@opensource.wdc.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, andi.kleen@intel.com,
 parri.andrea@gmail.com, len.brown@intel.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org,
 paulmck@kernel.org, linux-pm@vger.kernel.org, kirill.shutemov@intel.com,
 bp@alien8.de, songmuchun@bytedance.com, tglx@linutronix.de,
 vkuznets@redhat.com, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thomas.lendacky@amd.com, akpm@linux-foundation.org, robin.murphy@arm.com
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

On Wed, Jul 06, 2022 at 04:57:33PM +0800, Tianyu Lan wrote:
> Swiotlb_init() is called in the mem_init() of different architects and
> memblock free pages are released to the buddy allocator just after
> calling swiotlb_init() via memblock_free_all().

Yes.

> The mem_init() is called before smp_init().

But why would that matter?  cpu_possible_map is set up from
setup_arch(), which is called before that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
