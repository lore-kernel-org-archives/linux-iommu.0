Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF9C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADA064F29
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADA064F29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pensando.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D991B43422;
	Fri, 26 Feb 2021 21:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LHr-rtEEEOS2; Fri, 26 Feb 2021 21:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A123743421;
	Fri, 26 Feb 2021 21:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87B85C000A;
	Fri, 26 Feb 2021 21:30:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C08C8C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A50B3433D8
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:13:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CnQFccq3MMTd for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 21:13:22 +0000 (UTC)
X-Greylist: delayed 00:23:10 by SQLgrey-1.8.0
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05ACC431C4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 21:13:21 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id q186so11136103oig.12
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pensando.io; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=DjkABc/OrXr8QjcZaprFmzWxTwEQ/zHy8u2omy8POmg=;
 b=zowYW6nU870PkXyJEWKxYwMkVXvCQmERBSR7yQEzP3x4YmDyeE+D+PUHwLd0tBzJUO
 csllc0+dw4DKDJckvgn4ZJE8GE4b++qwxtFnuDE6YBElc1SExvk4zj3cpHIGig3ov4Xr
 DedJtacOjIJb/pG34eSKpVt8K+3ZGH9EvjEjyD2DHQ/oVCdEXJLen12Z4n8d3USbJR3M
 /J7qtBxHf9O7miy5E7pfVEXDS/gIgR8a5PLxtwC/RDaq0V28YSvOd2I1NH3YzvmxSFmo
 uUJlab8Ch+6CFRxSndFLXCRJSCCORT66WJbRlr2vu9krmkCRJo3/6DZWjH+FKRsi9isu
 ul6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DjkABc/OrXr8QjcZaprFmzWxTwEQ/zHy8u2omy8POmg=;
 b=lVZNwx30GBnxk5+frXgn1HoumXp6myZMejwoP4mhJCYVlpj31UHJ+rQsRR/eQ9Kogm
 UZNo1CeVp1Ta1Rmz4XVg4G5UpUZ0JrM3TqQpI2WaeIbGe0JmFYMdCqv+UKfMrWiISFQ0
 sT2Xwqk2YWV0tsZQeE862oW1OCAnO3bAIQl4WgcXwUVUNDlbogBxDzLGYQIzIGzjqmEp
 PGfnZ/ar7r/gQho/++s5U2FvV5o4pk3fDNoFDwoG2JxmH94P+6wZokRD3RVvLwTTv65k
 4MtuQjjsZYssoZnwA+BVKU6fVYhXBC2blo0Qhb7fl4rAQwI3K1Uzc2NYFTTdoPsTjzNw
 OkaA==
X-Gm-Message-State: AOAM533SZcld7RiEbL2L8RyrPAQvxd4fEBkYOkrgMrJiU2ospwAxGjm9
 ELBUWHmgBzJ7+Uv5Vu5xJFv+OsteBHd6ggQO
X-Google-Smtp-Source: ABdhPJzjzqiHIv4+yUWP+WA0WN/MTXBOLzoRuGrZRv7N77mEeO4AUum/AX28N3PrfSWigvvHfUqBmw==
X-Received: by 2002:a17:90a:3d47:: with SMTP id
 o7mr5108364pjf.149.1614372195936; 
 Fri, 26 Feb 2021 12:43:15 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
 by smtp.gmail.com with ESMTPSA id s196sm8576588pfc.185.2021.02.26.12.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 12:43:15 -0800 (PST)
From: Brad Larson <brad@pensando.io>
To: hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: swiotlb_tbl_map_single() kernel BUG in
 iommu-helper.h:30
Date: Fri, 26 Feb 2021 12:43:07 -0800
Message-Id: <20210226204307.50413-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 26 Feb 2021 21:30:03 +0000
Cc: Brad Larson <brad@pensando.io>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Kernel Oops introduced in next-20210222 due to get_max_slots return arg size.
In the function find_slots() variable max_slots is zero when boundary_mask is
0xffffffffffffffff.

[    0.242119] kernel BUG at ./include/linux/iommu-helper.h:30!
[    0.247793] Internal error: Oops - BUG: 0 [#1] SMP
[    0.252595] Modules linked in:
[    0.255657] CPU: 0 PID: 93 Comm: kworker/0:1 Not tainted 5.11.0-next-20210224+ #25
[    0.263245] Hardware name: Elba ASIC Board (DT)
[    0.267784] Workqueue: events_freezable mmc_rescan
[    0.272592] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[    0.278612] pc : swiotlb_tbl_map_single+0x2b0/0x6a0
[    0.283505] lr : swiotlb_tbl_map_single+0x440/0x6a0
[    0.288395] sp : ffffffc0122736b0
[    0.291713] x29: ffffffc0122736b0 x28: ffffffc010e30000
[    0.297039] x27: 00000000bbf58000 x26: 0000000000000000
[    0.302364] x25: 0000000000000000 x24: 0000000000000001
[    0.307689] x23: 0000000000000000 x22: 0000000000000000
[    0.313013] x21: 0000000000000000 x20: 0000000000000000
[    0.318338] x19: 0000001241fd4600 x18: ffffffc010d288c8
[    0.323662] x17: 0000000000000007 x16: 0000000000000001
[    0.328987] x15: ffffffc092273367 x14: 3a424c54204f4920
[    0.334311] x13: 6572617774666f73 x12: 20726e2030207865
[    0.339636] x11: 646e692078787820 x10: 3062653737317830
[    0.344960] x9 : 2074666968732031 x8 : ffffff977cf82368
[    0.350285] x7 : 0000000000000001 x6 : c0000000ffffefff
[    0.355609] x5 : 0000000000017fe8 x4 : 0000000000000000
[    0.360934] x3 : 0000000000000000 x2 : 18b0d50da009d000
[    0.366258] x1 : 0000000000000000 x0 : 0000000000000042
[    0.371583] Call trace:
[    0.374032]  swiotlb_tbl_map_single+0x2b0/0x6a0
[    0.378573]  swiotlb_map+0xa8/0x2b0

Signed-off-by: Brad Larson <brad@pensando.io>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 369e4c3a0f2b..c10e855a03bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
-	unsigned int max_slots = get_max_slots(boundary_mask);
+	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
