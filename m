Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2798EC07E9C
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 20:13:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9805361987
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 20:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9805361987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57B7783A6C;
	Mon,  5 Jul 2021 20:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ny-uLHcaF7J7; Mon,  5 Jul 2021 20:13:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 348F383A6D;
	Mon,  5 Jul 2021 20:13:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDC33C0023;
	Mon,  5 Jul 2021 20:13:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF42C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 19:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F319E40324
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 19:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f_CHRu_vXkfZ for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:19:43 +0000 (UTC)
X-Greylist: delayed 00:26:38 by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05F53402AE
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 19:19:42 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 165IZAxO082841; Mon, 5 Jul 2021 14:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tBLhHqmv8Xr1QxendNUR/DvIJZUmas2B18j2RZcJe90=;
 b=VNCxy8+JCw6kjy+bxizvOMve0X8Ha6lplJrGJoRB8hxmSpv2nm4NFRKPgSKvflnxggpN
 RMxvgIc46dgqUVTO2iu57KSrvx6xxJTi/7Pwat0FrGPIlogo+YA1rwnW01aK3eVowqO9
 XZ18Cvm6iN58JbDDB/ynkCTHvMO4svQirFDlhNf3AL1dKCE6TPs3XQ7tb8/O1fklsSDI
 iQsXlALN/hTLpKJqifZcatRzYGVMAv2pUNMc1bI40JrVp4OC8iddckmx2r+wWZno6ZD4
 JtnzHPReXrFtBG60HyJyRe3lwaYqUUzDPTrvvdyh/YMZNnEvjbE/j/j0UeQd94EI3P8l uA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 39m6k01j6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jul 2021 14:53:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165IoBnc015081;
 Mon, 5 Jul 2021 18:53:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 39jf5h8ww8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jul 2021 18:53:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 165Iqwge33423678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jul 2021 18:52:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42ED742042;
 Mon,  5 Jul 2021 18:52:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02EEB4203F;
 Mon,  5 Jul 2021 18:52:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jul 2021 18:52:57 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
Subject: [RFC PATCH 1/1] dma-debug: fix check_for_illegal_area() in
 debug_dma_map_sg()
Date: Mon,  5 Jul 2021 20:52:52 +0200
Message-Id: <20210705185252.4074653-2-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
References: <20210705185252.4074653-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gV9b_hflviYi124sNTpneb2U3SZKbgLQ
X-Proofpoint-ORIG-GUID: gV9b_hflviYi124sNTpneb2U3SZKbgLQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-05_10:2021-07-02,
 2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050099
X-Mailman-Approved-At: Mon, 05 Jul 2021 20:13:02 +0000
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>
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

The following warning occurred sporadically on s390:
DMA-API: nvme 0006:00:00.0: device driver maps memory from kernel text or rodata [addr=0000000048cc5e2f] [len=131072]
WARNING: CPU: 4 PID: 825 at kernel/dma/debug.c:1083 check_for_illegal_area+0xa8/0x138

It is a false-positive warning, due to a broken logic in debug_dma_map_sg().
check_for_illegal_area() should check for overlay of sg elements with kernel
text or rodata. It is called with sg_dma_len(s) instead of s->length as
parameter. After the call to ->map_sg(), sg_dma_len() contains the length
of possibly combined sg elements in the DMA address space, and not the
individual sg element length, which would be s->length.

The check will then use the kernel start address of an sg element, and add
the DMA length for overlap check, which can result in the false-positive
warning because the DMA length can be larger than the actual single sg
element length in kernel address space.

In addition, the call to check_for_illegal_area() happens in the iteration
over mapped_ents, which will not include all individual sg elements if
any of them were combined in ->map_sg().

Fix this by using s->length instead of sg_dma_len(s). Also put the call to
check_for_illegal_area() in a separate loop, iterating over all the
individual sg elements ("nents" instead of "mapped_ents").

Fixes: 884d05970bfb ("dma-debug: use sg_dma_len accessor")
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 kernel/dma/debug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..d7d44b7fe7e2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1299,6 +1299,12 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (unlikely(dma_debug_disabled()))
 		return;
 
+	for_each_sg(sg, s, nents, i) {
+		if (!PageHighMem(sg_page(s))) {
+			check_for_illegal_area(dev, sg_virt(s), s->length);
+		}
+	}
+
 	for_each_sg(sg, s, mapped_ents, i) {
 		entry = dma_entry_alloc();
 		if (!entry)
@@ -1316,10 +1322,6 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		check_for_stack(dev, sg_page(s), s->offset);
 
-		if (!PageHighMem(sg_page(s))) {
-			check_for_illegal_area(dev, sg_virt(s), sg_dma_len(s));
-		}
-
 		check_sg_segment(dev, s);
 
 		add_dma_entry(entry);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
