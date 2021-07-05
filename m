Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01107C07E99
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 13:47:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E9F61447
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 13:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E9F61447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5998A60869;
	Mon,  5 Jul 2021 13:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSm5uJnV9GKS; Mon,  5 Jul 2021 13:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A0F96086E;
	Mon,  5 Jul 2021 13:47:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 008E4C0010;
	Mon,  5 Jul 2021 13:47:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C98F1C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 13:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA246403B7
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 13:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8uEmUD-6ILc for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 13:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E9A2403B6
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 13:47:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6294ED6E;
 Mon,  5 Jul 2021 06:47:41 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A04CC3F694;
 Mon,  5 Jul 2021 06:47:40 -0700 (PDT)
Subject: Re: [bug report] IB/usnic: Add Cisco VIC low-level hardware driver
To: Dan Carpenter <dan.carpenter@oracle.com>, umalhi@cisco.com
References: <YOLdvTe4MJ4kS01z@mwanda>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0b8a876b-f71d-24a2-1826-07aa54248f40@arm.com>
Date: Mon, 5 Jul 2021 14:47:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOLdvTe4MJ4kS01z@mwanda>
Content-Language: en-GB
Cc: linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-07-05 11:23, Dan Carpenter wrote:
> [ Ancient code, but the bug seems real enough still.  -dan ]
> 
> Hello Upinder Malhi,
> 
> The patch e3cf00d0a87f: "IB/usnic: Add Cisco VIC low-level hardware
> driver" from Sep 10, 2013, leads to the following static checker
> warning:
> 
> 	drivers/iommu/iommu.c:2482 iommu_map()
> 	warn: sleeping in atomic context
> 
> drivers/infiniband/hw/usnic/usnic_uiom.c
>     244  static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
>     245                                                  struct usnic_uiom_reg *uiomr)
> 
> This function is always called from usnic_uiom_reg_get() which is holding
> spin_lock(&pd->lock); so it can't sleep.

FWIW back in those days it wasn't really well defined whether 
iommu_map() was callable from non-sleeping contexts (the arch/arm DMA 
API code relied on it, for instance). It was only formalised 2 years ago 
by 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map") which 
introduced the might_sleep() check that's firing there. I guess these 
calls want to be updated to iommu_map_atomic() now.

Robin.

>     246  {
>     247          int i, err;
>     248          size_t size;
>     249          struct usnic_uiom_chunk *chunk;
>     250          struct usnic_uiom_interval_node *interval_node;
>     251          dma_addr_t pa;
>     252          dma_addr_t pa_start = 0;
>     253          dma_addr_t pa_end = 0;
>     254          long int va_start = -EINVAL;
>     255          struct usnic_uiom_pd *pd = uiomr->pd;
>     256          long int va = uiomr->va & PAGE_MASK;
>     257          int flags = IOMMU_READ | IOMMU_CACHE;
>     258
>     259          flags |= (uiomr->writable) ? IOMMU_WRITE : 0;
>     260          chunk = list_first_entry(&uiomr->chunk_list, struct usnic_uiom_chunk,
>     261                                                                          list);
>     262          list_for_each_entry(interval_node, intervals, link) {
>     263  iter_chunk:
>     264                  for (i = 0; i < chunk->nents; i++, va += PAGE_SIZE) {
>     265                          pa = sg_phys(&chunk->page_list[i]);
>     266                          if ((va >> PAGE_SHIFT) < interval_node->start)
>     267                                  continue;
>     268
>     269                          if ((va >> PAGE_SHIFT) == interval_node->start) {
>     270                                  /* First page of the interval */
>     271                                  va_start = va;
>     272                                  pa_start = pa;
>     273                                  pa_end = pa;
>     274                          }
>     275
>     276                          WARN_ON(va_start == -EINVAL);
>     277
>     278                          if ((pa_end + PAGE_SIZE != pa) &&
>     279                                          (pa != pa_start)) {
>     280                                  /* PAs are not contiguous */
>     281                                  size = pa_end - pa_start + PAGE_SIZE;
>     282                                  usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x",
>     283                                          va_start, &pa_start, size, flags);
>     284                                  err = iommu_map(pd->domain, va_start, pa_start,
>     285                                                          size, flags);
> 
> The iommu_map() function sleeps.
> 
>     286                                  if (err) {
>     287                                          usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
>     288                                                  va_start, &pa_start, size, err);
>     289                                          goto err_out;
>     290                                  }
>     291                                  va_start = va;
>     292                                  pa_start = pa;
>     293                                  pa_end = pa;
>     294                          }
>     295
>     296                          if ((va >> PAGE_SHIFT) == interval_node->last) {
>     297                                  /* Last page of the interval */
>     298                                  size = pa - pa_start + PAGE_SIZE;
>     299                                  usnic_dbg("va 0x%lx pa %pa size 0x%zx flags 0x%x\n",
>     300                                          va_start, &pa_start, size, flags);
>     301                                  err = iommu_map(pd->domain, va_start, pa_start,
>     302                                                  size, flags);
> 
> iommu_map() again.
> 
>     303                                  if (err) {
>     304                                          usnic_err("Failed to map va 0x%lx pa %pa size 0x%zx with err %d\n",
>     305                                                  va_start, &pa_start, size, err);
>     306                                          goto err_out;
>     307                                  }
>     308                                  break;
>     309                          }
>     310
>     311                          if (pa != pa_start)
>     312                                  pa_end += PAGE_SIZE;
>     313                  }
>     314
>     315                  if (i == chunk->nents) {
>     316                          /*
>     317                           * Hit last entry of the chunk,
>     318                           * hence advance to next chunk
>     319                           */
>     320                          chunk = list_first_entry(&chunk->list,
>     321                                                          struct usnic_uiom_chunk,
>     322                                                          list);
>     323                          goto iter_chunk;
>     324                  }
>     325          }
>     326
>     327          return 0;
>     328
>     329  err_out:
>     330          usnic_uiom_unmap_sorted_intervals(intervals, pd);
>     331          return err;
>     332  }
> 
> regards,
> dan carpenter
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
