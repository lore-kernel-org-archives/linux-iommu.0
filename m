Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD31C4167E
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 917F840894;
	Mon, 14 Mar 2022 19:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vijQt9rKbP5s; Mon, 14 Mar 2022 19:47:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 855084089B;
	Mon, 14 Mar 2022 19:47:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB9CC001D;
	Mon, 14 Mar 2022 19:47:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2D46C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 944FC60EA5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAyAi8r95tad for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:47:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A14460DFA
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:04 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EHfxqa000786; 
 Mon, 14 Mar 2022 19:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XmqMk+lEABYpM+9BV3uK0X5g2LK2Ku400QAKT44/diQ=;
 b=d15+uqmasu+2i7MEBXNmnuBLG7haM6SfdJ51yODU+s+aRR6s+0NtELMR50Ryn4DRdeau
 npi7qQrrXSYg4ghWEGj4zKERU0L5xkSjPezStjQBk/chJRQPqnPK3HjDxT1Y61vJp86z
 hLz9bKBDuLXybxZchgQF6hgQ9/glZqUcVyLzKpW8CtdBpjiSAyXJIVUHTDdt/l6PnqtU
 PlWwKdVRyt0PnU2t7fkxfgPJUdJpmY6aOxsCOawZRXJl+R8gG2+lO/4K/W8HmQvl3V+X
 rowK4+AhbQ80vbFcMp04fywYOuKE+DYNkIvwj0TPuxA5plJO9ocENdoO4BwHpEcC+99r fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6aj0txk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:46:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJeoks029436;
 Mon, 14 Mar 2022 19:46:59 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6aj0tx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:46:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJNB2m001535;
 Mon, 14 Mar 2022 19:46:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 3erk59cbth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:46:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJkujc20840858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:46:56 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C39311206B;
 Mon, 14 Mar 2022 19:46:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2E2B112061;
 Mon, 14 Mar 2022 19:46:45 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:46:45 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 11/32] s390/pci: add helper function to find device by
 handle
Date: Mon, 14 Mar 2022 15:44:30 -0400
Message-Id: <20220314194451.58266-12-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iSgqA6D3SAjVZXhxav5rqIX4iYDDxHsN
X-Proofpoint-ORIG-GUID: n2GLZzJDoa_sV7_98Ow15-2pW-clMNFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=680 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Intercepted zPCI instructions will specify the desired function via a
function handle.  Add a routine to find the device with the specified
handle.

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 7ee52a70a96f..3c0b9986dcdc 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -275,6 +275,7 @@ static inline struct zpci_dev *to_zpci_dev(struct device *dev)
 }
 
 struct zpci_dev *get_zdev_by_fid(u32);
+struct zpci_dev *get_zdev_by_fh(u32 fh);
 
 /* DMA */
 int zpci_dma_init(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index ca9c29386de6..04c16312ad54 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -76,6 +76,22 @@ struct zpci_dev *get_zdev_by_fid(u32 fid)
 	return zdev;
 }
 
+struct zpci_dev *get_zdev_by_fh(u32 fh)
+{
+	struct zpci_dev *tmp, *zdev = NULL;
+
+	spin_lock(&zpci_list_lock);
+	list_for_each_entry(tmp, &zpci_list, entry) {
+		if (tmp->fh == fh) {
+			zdev = tmp;
+			break;
+		}
+	}
+	spin_unlock(&zpci_list_lock);
+	return zdev;
+}
+EXPORT_SYMBOL_GPL(get_zdev_by_fh);
+
 void zpci_remove_reserved_devices(void)
 {
 	struct zpci_dev *tmp, *zdev;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
