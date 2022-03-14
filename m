Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A60CC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2948560BEA;
	Mon, 14 Mar 2022 19:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APGkYXntbLBe; Mon, 14 Mar 2022 19:45:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B6FD60C21;
	Mon, 14 Mar 2022 19:45:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC82EC001D;
	Mon, 14 Mar 2022 19:45:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3697C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 920C3823DD
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wQpzKav63cKy for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:45:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECE2781911
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:45:54 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EHMVBT003427; 
 Mon, 14 Mar 2022 19:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tHpyg0lf5dv+bNJqi732xFzvwsPLsdw4+g52/oHOOkw=;
 b=H0EtEVUSwPPruc0byg7vw8iUzkHHwFXgeOC7/QypoQeRycJ4HNsldrxIVpzEX/Sj3w2T
 w8/YC3WGsegWsnIMWHhk5eRlmANDgNqa1gTG3VS1bALDweBesZo0ZDvVDJyuxgs/7QML
 AYpdTati3dzYlrPiIEPJpYq2aUYJ2gq3dU+13uNkPBkdnE33ndS5LXVoGihRbBl1EAMM
 2wEc8kYPoRGv4E+vLFEJ8nIrRR0IS7mAP00KWO8yW3Eo0007iXLwQIkV3fgXtfxlagHc
 Zd04uVDvgy6LdG/3Y18psXTAzVYay9QB3iVjzl+neUCkLS82ZBp0zIAIRfzXb/OtdADK SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d7rn7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:45:50 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJIslO002981;
 Mon, 14 Mar 2022 19:45:50 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d7rn75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:45:50 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJN9qr005084;
 Mon, 14 Mar 2022 19:45:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma05wdc.us.ibm.com with ESMTP id 3erk59ra28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:45:49 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJjm7649676640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:45:48 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F765112065;
 Mon, 14 Mar 2022 19:45:48 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8125112064;
 Mon, 14 Mar 2022 19:45:39 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:45:39 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 04/32] s390/sclp: detect the AISI facility
Date: Mon, 14 Mar 2022 15:44:23 -0400
Message-Id: <20220314194451.58266-5-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fLNr14K33AkXqdo1RUh2J-iCOXnBYl-g
X-Proofpoint-ORIG-GUID: 0ZON3t_RRAmwtnpL0OdDqYZVXwJt_-HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=748 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203140116
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

Detect the Adapter Interruption Suppression Interpretation facility.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 8c2e142000d4..33b174007848 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -91,6 +91,7 @@ struct sclp_info {
 	unsigned char has_zpci_lsi : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
+	unsigned char has_aisi : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index e9af01b4c97a..c13e55cc4a5d 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -47,6 +47,7 @@ static void __init sclp_early_facilities_detect(void)
 	sclp.has_kss = !!(sccb->fac98 & 0x01);
 	sclp.has_aisii = !!(sccb->fac118 & 0x40);
 	sclp.has_aeni = !!(sccb->fac118 & 0x20);
+	sclp.has_aisi = !!(sccb->fac118 & 0x10);
 	sclp.has_zpci_lsi = !!(sccb->fac118 & 0x01);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
