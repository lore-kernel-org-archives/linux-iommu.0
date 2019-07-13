Return-Path: <SRS0=UGLm=VK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D1C742A7
	for <iommu@archiver.kernel.org>; Sat, 13 Jul 2019 04:55:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8D4208E4
	for <iommu@archiver.kernel.org>; Sat, 13 Jul 2019 04:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8D4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 74BA569AA;
	Sat, 13 Jul 2019 04:54:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8C2D1432A
	for <iommu@lists.linux-foundation.org>;
	Sat, 13 Jul 2019 04:46:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 155F0DF
	for <iommu@lists.linux-foundation.org>;
	Sat, 13 Jul 2019 04:46:35 +0000 (UTC)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6D4fZp4026480; Sat, 13 Jul 2019 00:46:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2tq1q2u582-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 13 Jul 2019 00:46:21 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6D4ffCu026806;
	Sat, 13 Jul 2019 00:46:21 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
	[169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2tq1q2u57n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 13 Jul 2019 00:46:21 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x6D4iqn0000754; Sat, 13 Jul 2019 04:46:20 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
	(b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma04dal.us.ibm.com with ESMTP id 2tq6x68fyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 13 Jul 2019 04:46:20 +0000
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x6D4kIXr51118506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 13 Jul 2019 04:46:18 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12943BE054;
	Sat, 13 Jul 2019 04:46:18 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46E68BE04F;
	Sat, 13 Jul 2019 04:46:13 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.135.203])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2019 04:46:13 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: x86@kernel.org
Subject: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
Date: Sat, 13 Jul 2019 01:45:53 -0300
Message-Id: <20190713044554.28719-3-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190713044554.28719-1-bauerman@linux.ibm.com>
References: <20190713044554.28719-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-13_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907130055
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Secure Memory Encryption is an x86-specific feature, so it shouldn't appear
in generic kernel code.

In DMA mapping code, Christoph Hellwig mentioned that "There is no reason
why we should have a special debug printk just for one specific reason why
there is a requirement for a large DMA mask.", so we just remove
dma_check_mask().

In SWIOTLB code, there's no need to mention which memory encryption feature
is active, so just use a more generic warning. Besides, other architectures
will have different names for similar technology.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/s390/include/asm/mem_encrypt.h |  4 +---
 arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
 include/linux/mem_encrypt.h         | 14 +-------------
 kernel/dma/mapping.c                |  8 --------
 kernel/dma/swiotlb.c                |  3 +--
 5 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 3eb018508190..ff813a56bc30 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,9 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 extern bool sev_active(void);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 0c196c47d621..848ce43b9040 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -92,6 +92,16 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
+static inline bool mem_encrypt_active(void)
+{
+	return sme_me_mask;
+}
+
+static inline u64 sme_get_me_mask(void)
+{
+	return sme_me_mask;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 470bd53a89df..0c5b0ff9eb29 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -18,23 +18,11 @@
 
 #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-#define sme_me_mask	0ULL
-
-static inline bool sme_active(void) { return false; }
+static inline bool mem_encrypt_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * The __sme_set() and __sme_clr() macros are useful for adding or removing
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770..b53fc7ec4914 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -291,12 +291,6 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 }
 EXPORT_SYMBOL(dma_free_attrs);
 
-static inline void dma_check_mask(struct device *dev, u64 mask)
-{
-	if (sme_active() && (mask < (((u64)sme_get_me_mask() << 1) - 1)))
-		dev_warn(dev, "SME is active, device will require DMA bounce buffers\n");
-}
-
 int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -321,7 +315,6 @@ int dma_set_mask(struct device *dev, u64 mask)
 		return -EIO;
 
 	arch_dma_set_mask(dev, mask);
-	dma_check_mask(dev, mask);
 	*dev->dma_mask = mask;
 	return 0;
 }
@@ -333,7 +326,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 	if (!dma_supported(dev, mask))
 		return -EIO;
 
-	dma_check_mask(dev, mask);
 	dev->coherent_dma_mask = mask;
 	return 0;
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 62fa5a82a065..e52401f94e91 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -459,8 +459,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
-		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
-			     sme_active() ? "SME" : "SEV");
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
 	mask = dma_get_seg_boundary(hwdev);
 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
