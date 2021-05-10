Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719BCC433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:41:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7884613CA
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7884613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D71E401D5;
	Mon, 10 May 2021 09:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M35Y6pp65jl2; Mon, 10 May 2021 09:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53C85400C9;
	Mon, 10 May 2021 09:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 444A2C000E;
	Mon, 10 May 2021 09:41:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61B19C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 503CB40191
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v42EpcSSDCn0 for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 08:41:06 +0000 (UTC)
X-Greylist: delayed 00:09:18 by SQLgrey-1.8.0
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 867B5400C9
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:41:06 +0000 (UTC)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210510083145epoutp01f22cf584ded954965a0629f0cbda68f8~9p2fRqRo51109411094epoutp01b
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 08:31:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210510083145epoutp01f22cf584ded954965a0629f0cbda68f8~9p2fRqRo51109411094epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1620635505;
 bh=+FtN8Qg2E3DJyloZaR29LDKNlo4cw2mybAyOLLGFY1M=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Myt++ZLt1ic0jHzsC0MTHzL77lZB2PNZcoXxV03XVK0kCLpmUQV4vPSfsnB+Uanoe
 DAL6cr0lK30O62+Am1xhMtAPspaKEJcClCLzQZKoZ5GkAB8k+0fqIEr3EOOM8YoqYa
 nsk1Gw/eWExR860dX9TsbtQkz/4we70KtsHD+iVA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20210510083144epcas2p2292fd8fe2465d6ff3b1cf1c2d8721197~9p2evo_H93143631436epcas2p2c;
 Mon, 10 May 2021 08:31:44 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.183]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4FdvRM2GRFz4x9QB; Mon, 10 May
 2021 08:31:43 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 AF.01.09433.C6FE8906; Mon, 10 May 2021 17:31:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55~9p2aGkLxH0395303953epcas2p24;
 Mon, 10 May 2021 08:31:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210510083139epsmtrp168988c06dd3c981f1a6ea6b519db0370~9p2aFxfyF1230012300epsmtrp1j;
 Mon, 10 May 2021 08:31:39 +0000 (GMT)
X-AuditID: b6c32a47-f4bff700000024d9-89-6098ef6c451f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 37.C6.08163.B6FE8906; Mon, 10 May 2021 17:31:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210510083139epsmtip260ae4ea25a2f318bb3947e6edefd4c34~9p2Z2Iu140654006540epsmtip2t;
 Mon, 10 May 2021 08:31:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig
 <hch@lst.de>
Subject: [PATCH] swiotlb: manipulate orig_addr when tlb_addr has offset
Date: Mon, 10 May 2021 17:30:57 +0900
Message-Id: <20210510083057.46476-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVDfn/YwEg59rBCz2nrawuLxf22Ll
 6qNMFgv2W1ssW/yU0eLyrjlsFmuP3GW3OPjhCasDh8eaeWsYPSbfWM7osftmA5vHx6e3WDz6
 tqxi9Pi8SS6ALSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUn
 QNctMwfoGiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFhgV5xYm5xaV66XnJ+
 rpWhgYGRKVBlQk7GiRWL2AteyVS8/jybrYHxs2gXIyeHhICJxIpd11i7GLk4hAR2MEocufCa
 CcL5xChxa8klRgjnM6PE/B9r2GBann6ZBNWyi1Hi1aR1bBDOR0aJmf0HmUGq2AR0JbY8f8UI
 YosIhEjMaH7EDmIzC7xilPi2whDEFhZwlzh79xNYDYuAqsT01s1gNq+AncT831MZIbbJS5w+
 cQ0qLihxcuYTFog58hLNW2czgyyWELjHLnHv4HQWiAYXiU07vrNC2MISr45vYYewpSRe9rex
 QzR0M0q0PvoPlVjNKNHZ6ANh20v8mr4FqJkDaIOmxPpd+iCmhICyxJFbUHv5JDoO/2WHCPNK
 dLQJQTSqSxzYDnOBrET3nM9QF3hI/L3bzgRiCwnESjyb84plAqP8LCTfzELyzSyEvQsYmVcx
 iqUWFOempxYbFRgjx+omRnCS1HLfwTjj7Qe9Q4xMHIyHGCU4mJVEeEU7piUI8aYkVlalFuXH
 F5XmpBYfYjQFhu9EZinR5Hxgms4riTc0NTIzM7A0tTA1M7JQEuf9mVqXICSQnliSmp2aWpBa
 BNPHxMEp1cDU+FErR2Z+auBqA2Pv2DXaXrky7NOVVwg0x+1OPfvg3tTVttf3Pz+5eqWjM9uZ
 q78uXfVRvvdnczf3hCeVJ44bbbflCL7TxmtRJMVQ9WXXzFMxTJErfzYVlM5i2j5Hr05Keqnz
 tYNGgi9P1adduvX66ykBzdtSO0XCrS7v6pD/OeEm5++mgNecOqp8rS6/Dj86wvp5Wd2DfBmF
 R681vnf5MPu69z8+NO9m/FKuw8fXn9ZLnGc1xfjCuknXDZ38wqquch08fZZp2qQ639X93ws8
 bt0t7r7wqLr9e5NRn7alOPcv3nOTPb7Mjvl4WbxjS3ja67Lz1Ys9v0fO+hSv/rdT69xUJtaO
 pfOF/0hPlRO/pcRSnJFoqMVcVJwIALnOOBobBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvG72+xkJBqe/KljsPW1hcXm/tsXK
 1UeZLBbst7ZYtvgpo8XlXXPYLNYeuctucfDDE1YHDo8189Yweky+sZzRY/fNBjaPj09vsXj0
 bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxokVi9gLXslUvP48m62B8bNoFyMnh4SAicTTL5NY
 uxi5OIQEdjBKHH/TwgaRkJV49m4HO4QtLHG/5QhU0XtGiX/N/UwgCTYBXYktz18xdjFycIgI
 hEj83CgKUsMs8I5R4vqmM8wgNcIC7hJn735iBLFZBFQlprduBrN5Bewk5v+eygixQF7i9Ilr
 UHFBiZMzn7CA2MxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66
 XnJ+7iZGcNBqae1g3LPqg94hRiYOxkOMEhzMSiK8oh3TEoR4UxIrq1KL8uOLSnNSiw8xSnOw
 KInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgmmVRK7I7ZnFA22Sb5V80Of/WzNqQcMEvvE15
 rpLFudLlX2feKzn7f8It74vxb0TOb208Ln3rzKOW+Zcc9z2SkjJZOP2xYRbvg+C8iOyZxuxc
 m88lTJwuzPWw0V3xRchU9kmS0hv9u97bzJgxxV38r8SVhOlvO0/tfGu28Qu7vFLeO7lPVwTm
 nMor9JJNv73o6l2NnTUxNy7fs5U9Uv6KITdi8tYgK4udqwMulnzSsTlrNOkWcy7LldWMMtdu
 XX2ZGJs58bm+U9TkAz9/tC3gyWM3Wao0+XjEusd5dgFM1ye+ZpCI/K11rKnhx9kS9miGmWzJ
 f7/yrPNJ6LiTbFgU4jL3gti260/nRdnfr9Gcl6DEUpyRaKjFXFScCAAzU3uEyQIAAA==
X-CMS-MailID: 20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55
References: <CGME20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55@epcas2p2.samsung.com>
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
swiotlb_tbl_sync_single() copies from orig_addr base to tlb_addr with offset
it makes data mismatch

it removed from "swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single",
but it have to be recovered

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
 kernel/dma/swiotlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..e8243725e298 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -334,6 +334,7 @@ void __init swiotlb_exit(void)
 	io_tlb_default_mem = NULL;
 }
 
+static unsigned int swiotlb_align_offset(struct device *dev, u64 addr);
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -346,10 +347,17 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned int tlb_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
+	tlb_offset = (unsigned int)tlb_addr & (IO_TLB_SIZE - 1);
+	tlb_offset -= swiotlb_align_offset(dev, orig_addr);
+
+	orig_addr += tlb_offset;
+	alloc_size -= tlb_offset;
+
 	if (size > alloc_size) {
 		dev_WARN_ONCE(dev, 1,
 			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
