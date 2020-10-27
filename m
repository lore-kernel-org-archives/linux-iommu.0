Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244FBC55178
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 19:25:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A59821D7B
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 19:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNpuOKow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A59821D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1DBD586448;
	Tue, 27 Oct 2020 19:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEs-5KEwKAWC; Tue, 27 Oct 2020 19:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3F43186444;
	Tue, 27 Oct 2020 19:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27AF4C088B;
	Tue, 27 Oct 2020 19:25:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5B04C0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 19:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D00B3869B9
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 19:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKyaUcvH1sup for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 19:25:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0E856869AC
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 19:25:48 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RJP21A164536;
 Tue, 27 Oct 2020 19:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WWBVSyjATfqcuJQT+Yh6z4CCuAVHsOU2pwiB2KA9sbQ=;
 b=oNpuOKowZ1S862d6HWXEpBF6XqOjSjkj7XINwdr3XhrVVUdwCe0i0DOho17D9z8Sg05U
 acLF8fHnANx0ayghZdiDrEd+f1qcwfMFFWVCuNDgx2etJMa992mU03XWv+iLd5SHHkJg
 dgLwmAaLRANLtQiU/G7FIKEYp5NrNLWuAjFVPq5hQgbdYNZIQvwVgVtDLB2VrP8l89xY
 ADl0KBMePGoYDy7bLoY7+A5Odim6oCuVb72T1DXy+oCRUA9aG5yJuKHNw/uJ7jox/Di9
 I81V/kb0jh3z4LbGrig8E9z7KewsPBuORax86jP+PrHvghqqOXKeppF15dYGuZqqmQk5 AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 34cc7kuye1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Oct 2020 19:25:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RJPKpI106279;
 Tue, 27 Oct 2020 19:25:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 34cx6wc87t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2020 19:25:44 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RJPgg2007991;
 Tue, 27 Oct 2020 19:25:42 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 27 Oct 2020 12:25:42 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 373186A0121; Tue, 27 Oct 2020 15:27:27 -0400 (EDT)
Date: Tue, 27 Oct 2020 15:27:27 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Elliott Mitchell <ehem+undef@m5p.com>
Subject: Re: [PATCH] fix swiotlb panic on Xen
Message-ID: <20201027192726.GA13396@char.us.oracle.com>
References: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s>
 <20201027175114.GA32110@mattapan.m5p.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201027175114.GA32110@mattapan.m5p.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270112
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>, linux-kernel@vger.kernel.org,
 hch@lst.de
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

> As the person who first found this and then confirmed this fixes a bug:
> 
> Tested-by: Elliott Mitchell <ehem+xen@m5p.com>

Thank you!!

I changed the title and added the various tags and will put it in
linux-next later this week.

From a1eb2768bf5954d25aa0f0136b38f0aa5d92d984 Mon Sep 17 00:00:00 2001
From: Stefano Stabellini <stefano.stabellini@xilinx.com>
Date: Mon, 26 Oct 2020 17:02:14 -0700
Subject: [PATCH] swiotlb: fix "x86: Don't panic if can not alloc buffer for
 swiotlb"

kernel/dma/swiotlb.c:swiotlb_init gets called first and tries to
allocate a buffer for the swiotlb. It does so by calling

  memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);

If the allocation must fail, no_iotlb_memory is set.

Later during initialization swiotlb-xen comes in
(drivers/xen/swiotlb-xen.c:xen_swiotlb_init) and given that io_tlb_start
is != 0, it thinks the memory is ready to use when actually it is not.

When the swiotlb is actually needed, swiotlb_tbl_map_single gets called
and since no_iotlb_memory is set the kernel panics.

Instead, if swiotlb-xen.c:xen_swiotlb_init knew the swiotlb hadn't been
initialized, it would do the initialization itself, which might still
succeed.

Fix the panic by setting io_tlb_start to 0 on swiotlb initialization
failure, and also by setting no_iotlb_memory to false on swiotlb
initialization success.

Fixes: ac2cbab21f31 ("x86: Don't panic if can not alloc buffer for swiotlb")

Reported-by: Elliott Mitchell <ehem+xen@m5p.com>
Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
CC: stable@vger.kernel.org
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 kernel/dma/swiotlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 465a567678d9..e08cac39c0ba 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -229,6 +229,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	io_tlb_index = 0;
+	no_iotlb_memory = false;
 
 	if (verbose)
 		swiotlb_print_info();
@@ -260,9 +261,11 @@ swiotlb_init(int verbose)
 	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
 		return;
 
-	if (io_tlb_start)
+	if (io_tlb_start) {
 		memblock_free_early(io_tlb_start,
 				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+		io_tlb_start = 0;
+	}
 	pr_warn("Cannot allocate buffer");
 	no_iotlb_memory = true;
 }
@@ -360,6 +363,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	io_tlb_index = 0;
+	no_iotlb_memory = false;
 
 	swiotlb_print_info();
 
-- 
2.13.6

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
