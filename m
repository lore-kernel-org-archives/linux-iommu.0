Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F48BC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B345A40157;
	Mon, 14 Mar 2022 19:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UkYy24g_ttZj; Mon, 14 Mar 2022 19:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 359D7405CD;
	Mon, 14 Mar 2022 19:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F19EC001D;
	Mon, 14 Mar 2022 19:47:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FCC3C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F204B60D54
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tEI64Yo52uPK for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E5C360C21
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:40 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlYt7025603; 
 Mon, 14 Mar 2022 19:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jmXiDoamZ6A/nz+QAIB6MB8dJ9r4Q11uaUeMfJF8JPU=;
 b=IldFFzQgbT6fNkUKutnp3O9KlS2hiTV+3TR6ERfR7Mdb7oJnGc+Z5xW66dxQI1TKX/aH
 Kr9J7DuSeD1py3KWkxFmgoj+TgvrXazHl46WayDQRZPa544kdztx9NFxk4d2vaFvP3/4
 TpuWiGynvoaffuTP4uOJWKmDwPV08hGiBwciPr1WmioviN1qGWgMRsi6nNo9aMQ9T8vw
 u785gyA8/6FXabXKYht7n9aOnN1u2wprpc5dTyZfKPPdWi9AcWH+JSDDqvHln7jsae2t
 4fgJolmcGlGHWLBOw+IH9EloCfIVm9RijaX7MQwdHYjKdkKFeouRTrW6X46W2sK2hp2o 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ag0xhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:47:35 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJlY8E025676;
 Mon, 14 Mar 2022 19:47:34 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ag0xdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:47:34 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJNuuX001686;
 Mon, 14 Mar 2022 19:47:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 3erk594csc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:47:18 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJlGEo6292066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:47:16 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47A11112061;
 Mon, 14 Mar 2022 19:47:16 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76E3B112063;
 Mon, 14 Mar 2022 19:47:06 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:47:06 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 13/32] s390/pci: return status from zpci_refresh_trans
Date: Mon, 14 Mar 2022 15:44:32 -0400
Message-Id: <20220314194451.58266-14-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0-tL8yOiMEZcG7wASO7AAaz0xhmgkZFl
X-Proofpoint-GUID: IpE5ClWXoe_7Hq2DlizJsNA3x50FpKyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=850
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140116
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, frankja@linux.ibm.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, pasic@linux.ibm.com, jgg@nvidia.com,
 gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 gor@linux.ibm.com, schnelle@linux.ibm.com, hca@linux.ibm.com,
 alex.williamson@redhat.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
 cohuck@redhat.com, oberpar@linux.ibm.com, iommu@lists.linux-foundation.org,
 svens@linux.ibm.com, pbonzini@redhat.com
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

Current callers of zpci_refresh_trans don't need to interrogate the status
returned from the underlying instructions.  However, a subsequent patch
will add a KVM caller that needs this information.  Add a new argument to
zpci_refresh_trans to pass the address of a status byte and update
existing call sites to provide it.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_insn.h |  2 +-
 arch/s390/pci/pci_dma.c          |  6 ++++--
 arch/s390/pci/pci_insn.c         | 10 +++++-----
 drivers/iommu/s390-iommu.c       |  4 +++-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pci_insn.h b/arch/s390/include/asm/pci_insn.h
index 5331082fa516..32759c407b8f 100644
--- a/arch/s390/include/asm/pci_insn.h
+++ b/arch/s390/include/asm/pci_insn.h
@@ -135,7 +135,7 @@ union zpci_sic_iib {
 DECLARE_STATIC_KEY_FALSE(have_mio);
 
 u8 zpci_mod_fc(u64 req, struct zpci_fib *fib, u8 *status);
-int zpci_refresh_trans(u64 fn, u64 addr, u64 range);
+int zpci_refresh_trans(u64 fn, u64 addr, u64 range, u8 *status);
 int __zpci_load(u64 *data, u64 req, u64 offset);
 int zpci_load(u64 *data, const volatile void __iomem *addr, unsigned long len);
 int __zpci_store(u64 data, u64 req, u64 offset);
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index a81de48d5ea7..b0a2380bcad8 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -23,8 +23,9 @@ static u32 s390_iommu_aperture_factor = 1;
 
 static int zpci_refresh_global(struct zpci_dev *zdev)
 {
+	u8 status;
 	return zpci_refresh_trans((u64) zdev->fh << 32, zdev->start_dma,
-				  zdev->iommu_pages * PAGE_SIZE);
+				  zdev->iommu_pages * PAGE_SIZE, &status);
 }
 
 unsigned long *dma_alloc_cpu_table(void)
@@ -183,6 +184,7 @@ static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 			   size_t size, int flags)
 {
 	unsigned long irqflags;
+	u8 status;
 	int ret;
 
 	/*
@@ -201,7 +203,7 @@ static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 	}
 
 	ret = zpci_refresh_trans((u64) zdev->fh << 32, dma_addr,
-				 PAGE_ALIGN(size));
+				 PAGE_ALIGN(size), &status);
 	if (ret == -ENOMEM && !s390_iommu_strict) {
 		/* enable the hypervisor to free some resources */
 		if (zpci_refresh_global(zdev))
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 0509554301c7..ca6399d52767 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -77,20 +77,20 @@ static inline u8 __rpcit(u64 fn, u64 addr, u64 range, u8 *status)
 	return cc;
 }
 
-int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
+int zpci_refresh_trans(u64 fn, u64 addr, u64 range, u8 *status)
 {
-	u8 cc, status;
+	u8 cc;
 
 	do {
-		cc = __rpcit(fn, addr, range, &status);
+		cc = __rpcit(fn, addr, range, status);
 		if (cc == 2)
 			udelay(ZPCI_INSN_BUSY_DELAY);
 	} while (cc == 2);
 
 	if (cc)
-		zpci_err_insn(cc, status, addr, range);
+		zpci_err_insn(cc, *status, addr, range);
 
-	if (cc == 1 && (status == 4 || status == 16))
+	if (cc == 1 && (*status == 4 || *status == 16))
 		return -ENOMEM;
 
 	return (cc) ? -EIO : 0;
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 3833e86c6e7b..73a85c599dc2 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -214,6 +214,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	unsigned long irq_flags, nr_pages, i;
 	unsigned long *entry;
 	int rc = 0;
+	u8 status;
 
 	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
 	    dma_addr + size > s390_domain->domain.geometry.aperture_end)
@@ -238,7 +239,8 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	spin_lock(&s390_domain->list_lock);
 	list_for_each_entry(domain_device, &s390_domain->devices, list) {
 		rc = zpci_refresh_trans((u64) domain_device->zdev->fh << 32,
-					start_dma_addr, nr_pages * PAGE_SIZE);
+					start_dma_addr, nr_pages * PAGE_SIZE,
+					&status);
 		if (rc)
 			break;
 	}
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
