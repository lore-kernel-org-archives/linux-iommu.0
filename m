Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C6C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:23:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158CA61164
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158CA61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AEB440515;
	Tue, 20 Apr 2021 09:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0j-bmK-HZArZ; Tue, 20 Apr 2021 09:23:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4124F4040D;
	Tue, 20 Apr 2021 09:23:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0FC2C000E;
	Tue, 20 Apr 2021 09:23:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F8FFC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D93E40215
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5KMgqUGkRuQ for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:23:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38E1D4020D
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:23:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 59ECA68C4E; Tue, 20 Apr 2021 11:23:12 +0200 (CEST)
Date: Tue, 20 Apr 2021 11:23:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: swiotlb cleanups v3
Message-ID: <20210420092312.GB26092@lst.de>
References: <20210318161424.489045-1-hch@lst.de>
 <0349082c-59c5-20d7-f324-279981c3f6ea@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0349082c-59c5-20d7-f324-279981c3f6ea@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, mpe@ellerman.id.au,
 iommu@lists.linux-foundation.org, dongli.zhang@oracle.com,
 tientzu@chromium.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de
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

On Sat, Apr 17, 2021 at 11:39:22AM -0500, Tom Lendacky wrote:
> Somewhere between the 1st and 2nd patch, specifying a specific swiotlb
> for an SEV guest is no longer honored. For example, if I start an SEV
> guest with 16GB of memory and specify swiotlb=131072 I used to get a
> 256MB SWIOTLB. However, after the 2nd patch, the swiotlb=131072 is no
> longer honored and I get a 982MB SWIOTLB (as set via sev_setup_arch() in
> arch/x86/mm/mem_encrypt.c).
> 
> I can't be sure which patch caused the issue since an SEV guest fails to
> boot with the 1st patch but can boot with the 2nd patch, at which point
> the SWIOTLB comes in at 982MB (I haven't had a chance to debug it and so
> I'm hoping you might be able to quickly spot what's going on).

Can you try this patch?

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0a5b6f7e75bce6..ac81ef97df32f5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -71,15 +71,17 @@ struct io_tlb_mem *io_tlb_default_mem;
  */
 static unsigned int max_segment;
 
-static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+static unsigned long swiotlb_cmdline_size;
 
 static int __init
 setup_io_tlb_npages(char *str)
 {
 	if (isdigit(*str)) {
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-		default_nslabs =
-			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		unsigned long nslabs = simple_strtoul(str, &str, 0);
+
+		swiotlb_cmdline_size =
+			ALIGN(nslabs, IO_TLB_SEGSIZE) << IO_TLB_SHIFT;
 	}
 	if (*str == ',')
 		++str;
@@ -108,7 +110,9 @@ void swiotlb_set_max_segment(unsigned int val)
 
 unsigned long swiotlb_size_or_default(void)
 {
-	return default_nslabs << IO_TLB_SHIFT;
+	if (swiotlb_cmdline_size)
+		return swiotlb_cmdline_size;
+	return IO_TLB_DEFAULT_SIZE;
 }
 
 void __init swiotlb_adjust_size(unsigned long size)
@@ -118,9 +122,10 @@ void __init swiotlb_adjust_size(unsigned long size)
 	 * architectures such as those supporting memory encryption to
 	 * adjust/expand SWIOTLB size for their use.
 	 */
-	size = ALIGN(size, IO_TLB_SIZE);
-	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
-	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
+	if (!swiotlb_cmdline_size)
+		swiotlb_cmdline_size = ALIGN(size, IO_TLB_SIZE);
+	pr_info("SWIOTLB bounce buffer size adjusted to %luMB",
+		swiotlb_cmdline_size >> 20);
 }
 
 void swiotlb_print_info(void)
@@ -209,7 +214,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 void  __init
 swiotlb_init(int verbose)
 {
-	size_t bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
+	size_t bytes = PAGE_ALIGN(swiotlb_size_or_default());
 	void *tlb;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
@@ -219,7 +224,7 @@ swiotlb_init(int verbose)
 	tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb)
 		goto fail;
-	if (swiotlb_init_with_tbl(tlb, default_nslabs, verbose))
+	if (swiotlb_init_with_tbl(tlb, bytes >> IO_TLB_SHIFT, verbose))
 		goto fail_free_mem;
 	return;
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
