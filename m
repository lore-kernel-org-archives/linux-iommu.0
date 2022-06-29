Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B660C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 14:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8BD9612C6;
	Wed, 29 Jun 2022 14:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8BD9612C6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qmpdXauj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n2-AI8NUgHJo; Wed, 29 Jun 2022 14:05:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2146607AA;
	Wed, 29 Jun 2022 14:05:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2146607AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA6FAC0032;
	Wed, 29 Jun 2022 14:05:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E333C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 14:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76A0D607F5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 14:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76A0D607F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ui-EpINYmipf for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 14:05:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51DC8607AA
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51DC8607AA
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AdnOUixFaogrIHpTOlzBgm/evJyLH1AoH6sNGHs7rbw=; b=qmpdXaujtrOzhGFxHHFi13Bm1J
 gCSK8vuAHJjN+MEZ6dknO6RyA2A4rowbq52NOjL0ixWi6EHF5CcNomLJsrvDzy070xpeb+dLUwAuX
 anrkbObQPDTcRpTvJOHClFyrhy2O565MHOyNkUP5BioQ9ARaoqZQv9fKUFcHtkW5KBxDvGw01suxN
 WSl2EXInD8ayYEhgbP5c8hLQ6eIHaqkqkdary0J2Y5WrQW5kV1Ag7B27ckzI6ENiq18aRzSPvM8iJ
 ik4F+h1SzY475L2QXGEW+6hMSgDDsaIOdTEsHACLzHLCMY2M5X+9UKfDYKkRuMriM1IgWHbeQGbO3
 LZ96O5AA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o6YJN-00CNma-5V; Wed, 29 Jun 2022 14:04:57 +0000
Date: Wed, 29 Jun 2022 07:04:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number
 of lapic entry in MADT
Message-ID: <YrxcCZKvFYjxLf9n@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220627153150.106995-3-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, rafael@kernel.org,
 dave.hansen@linux.intel.com, pavel@ucw.cz, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
 corbet@lwn.net, damien.lemoal@opensource.wdc.com, x86@kernel.org,
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

On Mon, Jun 27, 2022 at 11:31:50AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> When initialize swiotlb bounce buffer, smp_init() has not been
> called and cpu number can not be got from num_online_cpus().
> Use the number of lapic entry to set swiotlb area number and
> keep swiotlb area number equal to cpu number on the x86 platform.

Can we reorder that initialization?  Because I really hate having
to have an arch hook in every architecture.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
