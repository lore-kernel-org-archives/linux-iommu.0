Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E44C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D1634157B;
	Mon, 14 Mar 2022 19:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8cW5CTOgvKv; Mon, 14 Mar 2022 19:50:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEA02408CB;
	Mon, 14 Mar 2022 19:50:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A679DC001D;
	Mon, 14 Mar 2022 19:50:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F28C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FFA84064B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwmSooUgWxNJ for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:50:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67773405CD
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:50:07 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlWhx002808; 
 Mon, 14 Mar 2022 19:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NtvaafqQawGeW536gL8Hl+D6uOSeQNQSIU3t8O8kAGo=;
 b=U+Q8AXbREqKtoBSy1OfYbPcKMqlf/LZ5J8MN4imLZOcjfcZpfO2i6d803VjHFvAW1OQ6
 IZoRL/DBhS+yQYPffMj0jGXkqzGYKKTj3MJyK7WgVdmo9lsoJPKr9TtFI9cnnCAeoHiE
 TzLaPd9m8x6lYhXhA3HdmxRO2TmW9j4+zPHdQCZckN8LeuRAlWCHokD1oXGqGX8qQSuV
 VyVqIXwvJIwwHWEP2zHo35hyPi0zNZ/ZYLiJUNMsnyTTW0wSeYafLB6qhjQ7eByMyX/1
 FyT1EvRdDjdj3VJqaX1dJg/HtUm/pwlS2kIpxFuNOCdPZOotj/XIKRWYTjiRz+CFl56Y Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ah92hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:50:03 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJlXF3002902;
 Mon, 14 Mar 2022 19:50:03 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ah92gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:50:02 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJm5XG002536;
 Mon, 14 Mar 2022 19:50:01 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03wdc.us.ibm.com with ESMTP id 3erk58r9an-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:50:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJo0lT52232548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:50:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25108112062;
 Mon, 14 Mar 2022 19:50:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3195D11206D;
 Mon, 14 Mar 2022 19:49:51 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:49:50 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 30/32] KVM: s390: introduce CPU feature for zPCI
 Interpretation
Date: Mon, 14 Mar 2022 15:44:49 -0400
Message-Id: <20220314194451.58266-31-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qe627T8D3VOl9Qp75zzIwElIOid11C8C
X-Proofpoint-ORIG-GUID: irMXp6E0xak-vS7Ir70D8fq3nQLZJrBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=972 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

KVM_S390_VM_CPU_FEAT_ZPCI_INTERP relays whether zPCI interpretive
execution is possible based on the available hardware facilities.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 7a6b14874d65..ed06458a871f 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ZPCI_INTERP 14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 613101ba29be..137ab8c09b82 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -434,6 +434,12 @@ static void kvm_s390_cpu_feat_init(void)
 	if (test_facility(151)) /* DFLTCC */
 		__insn32_query(INSN_DFLTCC, kvm_s390_available_subfunc.dfltcc);
 
+	/* zPCI Interpretation */
+	if (IS_ENABLED(CONFIG_VFIO_PCI) && IS_ENABLED(CONFIG_S390_KVM_IOMMU) &&
+	    test_facility(69) && test_facility(70) && test_facility(71) &&
+	    test_facility(72))
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ZPCI_INTERP);
+
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
 	/*
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
