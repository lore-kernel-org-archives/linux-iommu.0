Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB855C43460
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:41:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEC4613CA
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEC4613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70E78401B8;
	Mon, 10 May 2021 09:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78Z02Ms-ANVs; Mon, 10 May 2021 09:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEF75401D1;
	Mon, 10 May 2021 09:41:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00422C002B;
	Mon, 10 May 2021 09:41:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED9F7C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB19383D37
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 875hbqdahZTE for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 09:10:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24D5283D21
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:10:54 +0000 (UTC)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210510091049epoutp04c9b091a2704b6018c21656cadd8f4508~9qYm6p8P32431324313epoutp04M
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:10:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210510091049epoutp04c9b091a2704b6018c21656cadd8f4508~9qYm6p8P32431324313epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1620637849;
 bh=GMn3aZrI8h3341gCjcxN3nNrBS7ob/Hc4IFsTK7DRzw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=RchK4is9+bhXMw8KSq37MwHDH8ZE2Xz5QsNuuO0pUzDUUHNVGxn/nuToczij/Kteu
 Pd78xKJ2fo8Bi7F63WLpfyl0xf6pGyxFAzGZd4v5ZbcyioWftIDl+1/MxIuB/LMI9u
 a/neUwmuZKgU8B3RLUxb6wlaVEc553uNEBCpz90k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20210510091049epcas2p377dcf7f7e037ae16cbf79b3b37746bf1~9qYmbAFl71160311603epcas2p3N;
 Mon, 10 May 2021 09:10:49 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.185]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4FdwJS1HZ1z4x9Q7; Mon, 10 May
 2021 09:10:48 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.2A.09717.798F8906; Mon, 10 May 2021 18:10:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20210510091047epcas2p46daccaa59f30e7444be0ff2b5955228c~9qYkpUZmX1940819408epcas2p4a;
 Mon, 10 May 2021 09:10:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210510091047epsmtrp25a37150d26ccb5006a8414add6fb0328~9qYkoNBmQ2932429324epsmtrp2g;
 Mon, 10 May 2021 09:10:47 +0000 (GMT)
X-AuditID: b6c32a48-4fbff700000025f5-56-6098f897919a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C4.4D.08637.798F8906; Mon, 10 May 2021 18:10:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210510091047epsmtip2a8d66ac12d0f5850603cffebf8fb3f91~9qYkc1rYg2463124631epsmtip2G;
 Mon, 10 May 2021 09:10:47 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig
 <hch@lst.de>
Subject: [PATCH v2] swiotlb: manipulate orig_addr when tlb_addr has offset
Date: Mon, 10 May 2021 18:10:04 +0900
Message-Id: <20210510091004.111006-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQnf6jxkJBh+2W1nsPW1hcXm/tsXK
 1UeZLBbst7ZYtvgpo8XlXXPYLNYeuctucfDDE1YHDo8189Yweky+sZzRY/fNBjaPj09vsXj0
 bVnF6PF5k1wAW1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotP
 gK5bZg7QNUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAkPDAr3ixNzi0rx0veT8
 XCtDAwMjU6DKhJyMxrkP2As2Klc8fvuAqYFxonQXIyeHhICJxIWzC1lAbCGBHYwSn17YdTFy
 AdmfGCXutO1ih3C+MUrs/dzADtMx6fgjqMReRolZZ15CtX9klJh5iRvEZhPQldjy/BUjiC0i
 ECIxo/kRWDOzwCtGiW8rDLsYOTiEBbwkNl8sAwmzCKhKXL1/FKycV8Be4veDDWwQu+QlTp+4
 BhUXlDg58wkLxBh5ieats5kham6xS0x8AnWbi8SKjgNQvcISr45vgYpLSXx+t5cN5GYJgW5G
 idZH/6ESqxklOht9IGx7iV/Tt7CC3MYsoCmxfpc+iCkhoCxx5BbUWj6JjsN/2SHCvBIdbUIQ
 jeoSB7ZPZ4GwZSW653xmhbA9JA4+38kICZxYiWUXlzBPYJSfheSZWUiemYWwdwEj8ypGsdSC
 4tz01GKjAhPkGN3ECE6OWh47GGe//aB3iJGJg/EQowQHs5IIr2jHtAQh3pTEyqrUovz4otKc
 1OJDjKbA4J3ILCWanA9Mz3kl8YamRmZmBpamFqZmRhZK4rw/U+sShATSE0tSs1NTC1KLYPqY
 ODilGpiMtb/qlFw5/vbFaUbjvkBFbg+zi1ksi3NeLHKUXx7cviFag6cqlCE54beIvXy/U/t/
 SfX8VTFct5vrn2SuTmWwnpApvCsh2fDsMtXLbZKGlpv+H83/s3Om/T9t6RWizXNXnaiML3Py
 ZTkQ4f184cGsG5t+7dqjrucuuFgtz3Cm1N9Oy8yUWIdFr3gXcYryuV+3UdsfbyYk4t1/3LzN
 Zvb1lWVMAocsXFS3/5/L2C2d+atStitZqjXqiPC/ycbP5X9yMVda351bpr2g9lNrg1109Lwl
 4qtOzPh/dY7orPNTzxy61LSH5UFimU7omY/1Uquk8ydEdbhtFzXodv9m2aF7X/jk5t6Mj418
 YstVlViKMxINtZiLihMB162d1BcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvO70HzMSDL4eEbfYe9rC4vJ+bYuV
 q48yWSzYb22xbPFTRovLu+awWaw9cpfd4uCHJ6wOHB5r5q1h9Jh8Yzmjx+6bDWweH5/eYvHo
 27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujMa5D9gLNipXPH77gKmBcaJ0FyMnh4SAicSk44/Y
 QWwhgd2MEvenWELEZSWevdvBDmELS9xvOcLaxcgFVPOeUWLL4X5mkASbgK7EluevGLsYOThE
 BEIkfm4UBalhFnjHKHF90xlmkLiwgJfE5otlIOUsAqoSV+8fZQSxeQXsJX4/2MAGMV9e4vSJ
 a1BxQYmTM5+wgNjMQPHmrbOZJzDyzUKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWle
 ul5yfu4mRnDAamnuYNy+6oPeIUYmDsZDjBIczEoivKId0xKEeFMSK6tSi/Lji0pzUosPMUpz
 sCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYHJyUOx6LMuUMz//xYqjfbrH/Kzv5xX3F+8p
 Tjv0UGGb730xtrfzdhhzV+3/POPvet3vG3guHTZa+8HIeEK17KPWtE5Z/jrXpx4plofPcmgt
 +fG7cf+1I8I35y/eW6YrIVi9ZOmR/UVTJrX2f3V5fyrPO1hwtkz/E/Zpqza3r60IYvLLOKlc
 9krM+fPGdu8MbdsK99/t5XYSj14tqzNze61373G3YvAkzl2fp9jOecjrrtBXKH0ss39W6+56
 6WsqhZduc1qo5V01KmufcNKiyvLJbiGGym15R6UikkyZZKfEJMq9Pcd8NC1FVFCzODtjq+HK
 Vf5HFZ/XtP9asTVEUCw4rV62OPmJ026zvtc2SizFGYmGWsxFxYkA5MY7EccCAAA=
X-CMS-MailID: 20210510091047epcas2p46daccaa59f30e7444be0ff2b5955228c
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510091047epcas2p46daccaa59f30e7444be0ff2b5955228c
References: <CGME20210510091047epcas2p46daccaa59f30e7444be0ff2b5955228c@epcas2p4.samsung.com>
X-Mailman-Approved-At: Mon, 10 May 2021 09:41:45 +0000
Cc: linux-kernel@vger.kernel.org, Bumyong Lee <bumyong.lee@samsung.com>,
 iommu@lists.linux-foundation.org, Chanho Park <chanho61.park@samsung.com>,
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

From: Bumyong Lee <bumyong.lee@samsung.com>

in case of driver wants to sync part of ranges with offset,
swiotlb_tbl_sync_single() copies from orig_addr base to tlb_addr with
offset it makes data mismatch

it removed from
- "swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single",
but it have to be recovered due to below case.

1. Get dma_addr_t from dma_map_single()
dma_addr_t tlb_addr = dma_map_single(dev, vaddr, vsize, DMA_TO_DEVICE);

    |<---------------vsize------------->|
    +-----------------------------------+
    |                                   | original buffer
    +-----------------------------------+
  vaddr

 swiotlb_align_offset
     |<----->|<---------------vsize------------->|
     +-------+-----------------------------------+
     |       |                                   | swiotlb buffer
     +-------+-----------------------------------+
          tlb_addr

2. Do something
3. Sync dma_addr_t through dma_sync_single_for_device(..)
dma_sync_single_for_device(dev, tlb_addr + offset, size, DMA_TO_DEVICE);

  Error case.
    copy data to original buffer.
    but it is from base addr in original buffer

     |<----->|<- offset ->|<- size ->|
     +-------+-----------------------------------+
     |       |            |##########|           | swiotlb buffer
     +-------+-----------------------------------+
          tlb_addr

 swiotlb_align_offset
     |<----->|<- offset ->|<- size ->|
     +-------+-----------------------------------+
     |       |            |##########|           | swiotlb buffer
     +-------+-----------------------------------+
          tlb_addr

    |<- size ->|
    +-----------------------------------+
    |##########|                        | original buffer
    +-----------------------------------+
  vaddr

  FIX. copy data to original buffer.
  but it is from base addr in original buffer

 swiotlb_align_offset
     |<----->|<- offset ->|<- size ->|
     +-------+-----------------------------------+
     |       |            |##########|           | swiotlb buffer
     +-------+-----------------------------------+
          tlb_addr

    |<- offset ->|<- size ->|
    +-----------------------------------+
    |            |##########|           | original buffer
    +-----------------------------------+
  vaddr

Fixes: 16fc3cef33a0 ("swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single")
Signed-off-by: Bumyong Lee <bumyong.lee@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes since v1:
- Move swiotlb_align_offset to avoid forward declaration
- Make tlb_offset calculation as single assignment

 kernel/dma/swiotlb.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..e50df8d8f87e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -334,6 +334,14 @@ void __init swiotlb_exit(void)
 	io_tlb_default_mem = NULL;
 }
 
+/*
+ * Return the offset into a iotlb slot required to keep the device happy.
+ */
+static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+{
+	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
+}
+
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -346,10 +354,17 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned int tlb_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
+	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
+		     swiotlb_align_offset(dev, orig_addr);
+
+	orig_addr += tlb_offset;
+	alloc_size -= tlb_offset;
+
 	if (size > alloc_size) {
 		dev_WARN_ONCE(dev, 1,
 			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
@@ -390,14 +405,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 
 #define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
 
-/*
- * Return the offset into a iotlb slot required to keep the device happy.
- */
-static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
-{
-	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
-}
-
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
  */
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
