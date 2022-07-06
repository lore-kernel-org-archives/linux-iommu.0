Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426C3C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 08:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B075883372;
	Wed,  6 Jul 2022 08:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B075883372
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TBk29vbi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fp6xqv8wos8R; Wed,  6 Jul 2022 08:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7A706812D2;
	Wed,  6 Jul 2022 08:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A706812D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41759C0071;
	Wed,  6 Jul 2022 08:01:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFC1FC0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9D6360F99
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:01:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9D6360F99
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TBk29vbi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTkW6svowVi1 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 08:01:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E8C460F97
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E8C460F97
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HiFeALskotGpN1iZvBw/0D0ZUKVzZ82kmtWfVdYRxfo=; b=TBk29vbiT7YIhM59E+b8lJL1BC
 s9vDVB+cyngWjY1b9etW2yvGet4ZQgwoKvRt/ddj4PMRpNbW2LPTnRfGMNShRZjgyI5b9D5NTssWW
 Yu1wqoef9iBvueGmVwFeekNliQ2w0m5K8tkKJWr67ZpzzE7hx9kaZwy88tLY4tywyOoy3XQgBEI04
 TlVDVkPR5vGctLPt5wbI5wowzkBAdMCMrXaamBoHdesrny/Uz+BoTzZVMRtjZIFe8DXbPGUJRNERs
 wqDEy8+Iqv4G8BTU73KHJAd+ryiZ5SkzgGvmpUNnL9qjAb1Qi2rwfVvt/l9s5A+uHzkdMNY+rQwGy
 J16yPRvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o8zxi-007FVc-S9; Wed, 06 Jul 2022 08:00:42 +0000
Date: Wed, 6 Jul 2022 01:00:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number
 of lapic entry in MADT
Message-ID: <YsVBKgxiQKfnCjvn@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
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

On Fri, Jul 01, 2022 at 01:02:21AM +0800, Tianyu Lan wrote:
> > Can we reorder that initialization?  Because I really hate having
> > to have an arch hook in every architecture.
> 
> How about using "flags" parameter of swiotlb_init() to pass area number
> or add new parameter for area number?
> 
> I just reposted patch 1 since there is just some coding style issue and area
> number may also set via swiotlb kernel parameter. We still need figure out a
> good solution to pass area number from architecture code.

What is the problem with calling swiotlb_init after nr_possible_cpus()
works?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
