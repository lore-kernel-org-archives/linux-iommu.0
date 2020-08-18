Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A63FC433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 22:11:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A5E20786
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 22:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGIsWT+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A5E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4F2B86BB9;
	Tue, 18 Aug 2020 22:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YqGoTYkwRID; Tue, 18 Aug 2020 22:11:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BFEE8666F;
	Tue, 18 Aug 2020 22:11:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7F8BC088B;
	Tue, 18 Aug 2020 22:11:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DCB1C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 22:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3D4E1815FA
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 22:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxnwuDDh628b for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 22:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0B10F87B08
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 22:11:51 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07IM2e6M117975; Tue, 18 Aug 2020 18:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UtNXnoPsOjscFTkbhxjmseTZ2dxM8ncEn7IWYIO6opA=;
 b=sGIsWT+SExHnhfEnQnakW67QRlkpHGIfcjEMPTTVOXyEMXSIEADQ/GmXm9WqSnHBE3ma
 125fHGQJW34u+Hq2LJxWvejczl2IEbrljzRuFt7/VNKn4Xw4m8tk3OA9L0Xk7AZlj4Im
 TA7j1aZZDcXiAaYidNxlsDsQnNGZGcR3/yIYmh2PkDW6Ur+qhPrrYJd5cLAHEGqlsU0B
 UbjRdIQRD1RknQVJoPN56lXxy8uPuWwcyCXtWDMzFQWWcVLeh+kpodhnUWpeT+Uvr2ku
 IV67nkX4Z+BOKnJxFsiKEhtWDlEX794yZqzkohsCPa7TQKdaEE1s5+DHnn5EXyXTSbki yA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3304t20phf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 18:11:43 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07IM9Yue019412;
 Tue, 18 Aug 2020 22:11:43 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02dal.us.ibm.com with ESMTP id 3304cch4sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 22:11:43 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07IMBbJa19398974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 22:11:37 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69A38C607D;
 Tue, 18 Aug 2020 22:11:40 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E94C7C6087;
 Tue, 18 Aug 2020 22:11:37 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.163.41.251])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2020 22:11:37 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in
 memory
Date: Tue, 18 Aug 2020 19:11:26 -0300
Message-Id: <20200818221126.391073-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-18_14:2020-08-18,
 2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 suspectscore=3 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180154
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linuxppc-dev@lists.ozlabs.org, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

POWER secure guests (i.e., guests which use the Protection Execution
Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
they don't need the SWIOTLB memory to be in low addresses since the
hypervisor doesn't have any addressing limitation.

This solves a SWIOTLB initialization problem we are seeing in secure guests
with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
memory, which leaves no space for SWIOTLB in low addresses.

To do this, we use mostly the same code as swiotlb_init(), but allocate the
buffer using memblock_alloc() instead of memblock_alloc_low().

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/svm.h       |  4 ++++
 arch/powerpc/mm/mem.c                |  6 +++++-
 arch/powerpc/platforms/pseries/svm.c | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

Changes from v2:
- Panic if unable to allocate buffer, as suggested by Christoph.

Changes from v1:
- Open-code swiotlb_init() in arch-specific code, as suggested by
  Christoph.

diff --git a/arch/powerpc/include/asm/svm.h b/arch/powerpc/include/asm/svm.h
index 85580b30aba4..7546402d796a 100644
--- a/arch/powerpc/include/asm/svm.h
+++ b/arch/powerpc/include/asm/svm.h
@@ -15,6 +15,8 @@ static inline bool is_secure_guest(void)
 	return mfmsr() & MSR_S;
 }
 
+void __init svm_swiotlb_init(void);
+
 void dtl_cache_ctor(void *addr);
 #define get_dtl_cache_ctor()	(is_secure_guest() ? dtl_cache_ctor : NULL)
 
@@ -25,6 +27,8 @@ static inline bool is_secure_guest(void)
 	return false;
 }
 
+static inline void svm_swiotlb_init(void) {}
+
 #define get_dtl_cache_ctor() NULL
 
 #endif /* CONFIG_PPC_SVM */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c2c11eb8dcfc..0f21bcb16405 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -50,6 +50,7 @@
 #include <asm/swiotlb.h>
 #include <asm/rtas.h>
 #include <asm/kasan.h>
+#include <asm/svm.h>
 
 #include <mm/mmu_decl.h>
 
@@ -290,7 +291,10 @@ void __init mem_init(void)
 	 * back to to-down.
 	 */
 	memblock_set_bottom_up(true);
-	swiotlb_init(0);
+	if (is_secure_guest())
+		svm_swiotlb_init();
+	else
+		swiotlb_init(0);
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 40c0637203d5..81085eb8f225 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/memblock.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
@@ -34,6 +35,31 @@ static int __init init_svm(void)
 }
 machine_early_initcall(pseries, init_svm);
 
+/*
+ * Initialize SWIOTLB. Essentially the same as swiotlb_init(), except that it
+ * can allocate the buffer anywhere in memory. Since the hypervisor doesn't have
+ * any addressing limitation, we don't need to allocate it in low addresses.
+ */
+void __init svm_swiotlb_init(void)
+{
+	unsigned char *vstart;
+	unsigned long bytes, io_tlb_nslabs;
+
+	io_tlb_nslabs = (swiotlb_size_or_default() >> IO_TLB_SHIFT);
+	io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+
+	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
+
+	vstart = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
+	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
+		return;
+
+	if (io_tlb_start)
+		memblock_free_early(io_tlb_start,
+				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	panic("SVM: Cannot allocate SWIOTLB buffer");
+}
+
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	if (!PAGE_ALIGNED(addr))
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
