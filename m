Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DC7C433F5
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 15:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4C8760BC6;
	Wed,  5 Jan 2022 15:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EgneyDAyd7Fk; Wed,  5 Jan 2022 15:58:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B5450605B5;
	Wed,  5 Jan 2022 15:58:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC59C0030;
	Wed,  5 Jan 2022 15:58:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61C18C001E
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 15:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E9444051B
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 15:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=shutemov-name.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08wioGjd1ab0 for <iommu@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 15:58:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4372140519
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 15:58:31 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id g13so54569973ljj.10
 for <iommu@lists.linux-foundation.org>; Wed, 05 Jan 2022 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wiI6XQzZPIKsgBJU59yNUo7XDWC6AOaI73DG/LrEbNc=;
 b=JEAt5CbOaPVnz9c1qxftdo0HLUKfXOy5keqP7LwtR8RQ93o4hVGk4NCHjEQ3gcCCks
 jU/Wa/24yaftusGPxzBoh2FwnVOlwNW9CuPE6X6GqB/gqe/3+OtLTNKMb44rbJs4VCsS
 9fRId+mOHNyK31euzv7hHZo9OgE/nfTTHKZ0mWV+h7IdLnAh4f5SNJsVmNufB5m1MwbD
 tK+ojNs8bHW1TvdLzCVRmstfzt/Wkbtecsp9dcuH+wsYC44/Fa229x3twclpkdfEUhd/
 JLMCIEOYJ+BYXVl0yijdbhbQQbwgkRpzzpBymVn0Jrn44bEW2L63/3ulTNLh09fyxy7i
 SSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wiI6XQzZPIKsgBJU59yNUo7XDWC6AOaI73DG/LrEbNc=;
 b=K5H4YxrNA7eDWnbTwkfmQS03ktfpZAYNmup6EaipHGGku0GIcWaT6tw59r722oduEm
 nPSkiFTHY7c9Lbq7F2GG7/pbe4AvH7Omo6H4Iy1kazcWGry/tc7Wq3Anc9JxNHWzAbff
 Jya1cUBaDunyzRRezLNu+uFkE6PePJi990oPJQwqG37Ni4IxlTCT46jloiekZuYmVhhY
 9jkmj5f1I0GTZR83JOyvOKLtSDdivhS3/7GCpIG9DB9cjIY/ZGfqThk2I2t+2DmMV2A2
 vp82O1SecKznJegRLGshLjMDw420js+NKtD0peMDRo+H44BuKfIaZIQmQxnjbNSmGjVl
 zyZQ==
X-Gm-Message-State: AOAM532Wg6oD8vk0+R4SedaglX55fMGlV41t2UfHPnVmx/oFk8E1mah3
 dp1B0+oFb1XFusnKKkP601zFhw==
X-Google-Smtp-Source: ABdhPJzL6AHZudebCYSLQypdGz4ryblk3JT0Ksy3qCQeS0L1AAVjheuCmSQxAJo/TxaPlhTwKnCo8g==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr35857378ljj.390.1641398309095; 
 Wed, 05 Jan 2022 07:58:29 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id f33sm4243477lfv.39.2022.01.05.07.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 07:58:28 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
 id AE79A10425A; Wed,  5 Jan 2022 18:58:47 +0300 (+03)
Date: Wed, 5 Jan 2022 18:58:47 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Memory clearing in swiotlb_update_mem_attributes()
Message-ID: <20220105155847.gcx443z7al3dbsdq@box.shutemov.name>
References: <20220104224939.yhpceiuzqqhb72ql@box.shutemov.name>
 <d16046ad-7828-a015-b6a3-3ed01ed15bac@amd.com>
 <YdWnUmJsjPUYiycV@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdWnUmJsjPUYiycV@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org
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

On Wed, Jan 05, 2022 at 06:12:34AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 05, 2022 at 08:06:10AM -0600, Tom Lendacky wrote:
> > On 1/4/22 4:49 PM, Kirill A. Shutemov wrote:
> > > Hi Tom,
> > > 
> > > For larger TDX VM, memset() after set_memory_decrypted() in
> > > swiotlb_update_mem_attributes() takes substantial portion of boot time.
> > > 
> > > It makes me wounder why do we need it there? Malicious VMM can mess with
> > > decrypted/shared buffer at any point and for normal use it will be
> > > populated with real data anyway.
> > > 
> > > Can we drop it?
> > 
> > Probably more a question for Christoph. Does SWIOTLB need to be initialized
> > to zeroes? If it does, then the memset after the set_memory_decrypted() is
> > required, otherwise it will appear as ciphertext to SWIOTLB.
> 
> While the traditional swiotlb initialization zeroes it I can't really
> see any reason why we would want to zero it.  If we really care about
> not leaking data to the device we'd need to zero the padding at mapping
> time.

Does the patch below look fine?

From ab1aa6abbdbba9e34ac7b86e5af1f9f488afaa07 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 5 Jan 2022 18:48:01 +0300
Subject: [PATCH] swiotlb: Do not zero buffer in set_memory_decrypted()

For larger TDX VM, memset() after set_memory_decrypted() in
swiotlb_update_mem_attributes() takes substantial portion of boot time.

Zeroing doesn't serve any functional purpose. Malicious VMM can mess
with decrypted/shared buffer at any point.

Remove the memset().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 kernel/dma/swiotlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8e840fbbed7c..4546c834accb 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -172,7 +172,6 @@ void __init swiotlb_update_mem_attributes(void)
 	vaddr = phys_to_virt(mem->start);
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
-	memset(vaddr, 0, bytes);
 }
 
 static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
-- 
 Kirill A. Shutemov
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
