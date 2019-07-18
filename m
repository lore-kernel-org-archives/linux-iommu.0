Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77991C76192
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 03:29:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B202184E
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 03:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B202184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5DFFA13FD;
	Thu, 18 Jul 2019 03:29:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE41913FB
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 03:29:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 450FE25A
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 03:29:42 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x6I3S3k2020823; Wed, 17 Jul 2019 23:29:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ttd5fxwnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 17 Jul 2019 23:29:31 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6I3TVL6023563;
	Wed, 17 Jul 2019 23:29:31 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
	[169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ttd5fxwmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 17 Jul 2019 23:29:31 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x6I3Q8gY026039; Thu, 18 Jul 2019 03:29:30 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
	[9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 2tq6x7mhxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 18 Jul 2019 03:29:30 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x6I3TT2E14156636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Jul 2019 03:29:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767D3AE060;
	Thu, 18 Jul 2019 03:29:29 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 466E4AE05C;
	Thu, 18 Jul 2019 03:29:25 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.129.123])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2019 03:29:25 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: x86@kernel.org
Subject: [PATCH v3 3/6] dma-mapping: Remove dma_check_mask()
Date: Thu, 18 Jul 2019 00:28:55 -0300
Message-Id: <20190718032858.28744-4-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-07-18_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1907180037
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

sme_active() is an x86-specific function so it's better not to call it from
generic code. Christoph Hellwig mentioned that "There is no reason why we
should have a special debug printk just for one specific reason why there
is a requirement for a large DMA mask.", so just remove dma_check_mask().

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 kernel/dma/mapping.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 1f628e7ac709..61eeefbfcb36 100644
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
@@ -327,7 +321,6 @@ int dma_set_mask(struct device *dev, u64 mask)
 		return -EIO;
 
 	arch_dma_set_mask(dev, mask);
-	dma_check_mask(dev, mask);
 	*dev->dma_mask = mask;
 	return 0;
 }
@@ -345,7 +338,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 	if (!dma_supported(dev, mask))
 		return -EIO;
 
-	dma_check_mask(dev, mask);
 	dev->coherent_dma_mask = mask;
 	return 0;
 }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
