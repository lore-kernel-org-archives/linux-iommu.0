Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C47C433FE
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC7B382438;
	Mon, 14 Mar 2022 19:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y6Mlf4US8s7t; Mon, 14 Mar 2022 19:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B89E381911;
	Mon, 14 Mar 2022 19:47:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9234DC001D;
	Mon, 14 Mar 2022 19:47:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11C97C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BF8740602
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FAmU7RHjpEu for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:47:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B7DE405CD
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:47:16 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EHeGtL004107; 
 Mon, 14 Mar 2022 19:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ebvnXc/LVkIRCFIJy5fYs9U35v9NkWwTGRod9yTfngc=;
 b=Jka0VNOiNOfWFg9jweTFmWzjYVKxOVXzzn4nqs9loLmJG7E/HHQ5d9i98ezgkcnWI/Xg
 oroHJA1xN9/uqA/hJQrzPPaoNKsj8/2FN6h7QbPhukPTuCFQANEGm8J1tRe9G5otKPaV
 merOPFwLZs+EXjo+TWVATFnljYCL+JmitNlBx6dBpMFOTqVaHoAHLvTzSzC/hpGTf1sX
 zYuzJ9hI6QW1Xs9bAiq2PIIJBZaonN2TTj9lr3LG0fD2JjGaf4A5EUGevLUlzcFKCg7P
 75WInwVoArnRpizBnLACj+Sl5vw1jE6AceYMP5jgLcUjiR6kuvUoWeafSlqo+oF0qNAA ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6a714hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:47:09 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJRoqm002548;
 Mon, 14 Mar 2022 19:47:09 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6a714gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:47:09 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJl7O4014273;
 Mon, 14 Mar 2022 19:47:07 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 3erk59g7vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:47:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJl6Sq48562486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:47:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BE7E112063;
 Mon, 14 Mar 2022 19:47:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9679E112064;
 Mon, 14 Mar 2022 19:46:56 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:46:56 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 12/32] s390/pci: get SHM information from list pci
Date: Mon, 14 Mar 2022 15:44:31 -0400
Message-Id: <20220314194451.58266-13-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lf5BTqB_yYxhwqdCekbHBxZNYS04n_Y0
X-Proofpoint-ORIG-GUID: _lRlT4AF9cB3zz3nwpaB73t-ubUS3D9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxlogscore=999
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

KVM will need information on the special handle mask used to indicate
emulated devices.  In order to obtain this, a new type of list pci call
must be made to gather the information.  Extend clp_list_pci_req to
also fetch the model-dependent-data field that holds this mask.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci.h     |  1 +
 arch/s390/include/asm/pci_clp.h |  2 +-
 arch/s390/pci/pci_clp.c         | 25 ++++++++++++++++++++++---
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 3c0b9986dcdc..e8a3fd5bc169 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -227,6 +227,7 @@ int clp_enable_fh(struct zpci_dev *zdev, u32 *fh, u8 nr_dma_as);
 int clp_disable_fh(struct zpci_dev *zdev, u32 *fh);
 int clp_get_state(u32 fid, enum zpci_state *state);
 int clp_refresh_fh(u32 fid, u32 *fh);
+int zpci_get_mdd(u32 *mdd);
 
 /* UID */
 void update_uid_checking(bool new);
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index d6189ed14f84..dc2041e97de4 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -76,7 +76,7 @@ struct clp_req_list_pci {
 struct clp_rsp_list_pci {
 	struct clp_rsp_hdr hdr;
 	u64 resume_token;
-	u32 reserved2;
+	u32 mdd;
 	u16 max_fn;
 	u8			: 7;
 	u8 uid_checking		: 1;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index dc733b58e74f..7477956be632 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -328,7 +328,7 @@ int clp_disable_fh(struct zpci_dev *zdev, u32 *fh)
 }
 
 static int clp_list_pci_req(struct clp_req_rsp_list_pci *rrb,
-			    u64 *resume_token, int *nentries)
+			    u64 *resume_token, int *nentries, u32 *mdd)
 {
 	int rc;
 
@@ -354,6 +354,8 @@ static int clp_list_pci_req(struct clp_req_rsp_list_pci *rrb,
 	*nentries = (rrb->response.hdr.len - LIST_PCI_HDR_LEN) /
 		rrb->response.entry_size;
 	*resume_token = rrb->response.resume_token;
+	if (mdd)
+		*mdd = rrb->response.mdd;
 
 	return rc;
 }
@@ -365,7 +367,7 @@ static int clp_list_pci(struct clp_req_rsp_list_pci *rrb, void *data,
 	int nentries, i, rc;
 
 	do {
-		rc = clp_list_pci_req(rrb, &resume_token, &nentries);
+		rc = clp_list_pci_req(rrb, &resume_token, &nentries, NULL);
 		if (rc)
 			return rc;
 		for (i = 0; i < nentries; i++)
@@ -383,7 +385,7 @@ static int clp_find_pci(struct clp_req_rsp_list_pci *rrb, u32 fid,
 	int nentries, i, rc;
 
 	do {
-		rc = clp_list_pci_req(rrb, &resume_token, &nentries);
+		rc = clp_list_pci_req(rrb, &resume_token, &nentries, NULL);
 		if (rc)
 			return rc;
 		fh_list = rrb->response.fh_list;
@@ -468,6 +470,23 @@ int clp_get_state(u32 fid, enum zpci_state *state)
 	return rc;
 }
 
+int zpci_get_mdd(u32 *mdd)
+{
+	struct clp_req_rsp_list_pci *rrb;
+	u64 resume_token = 0;
+	int nentries, rc;
+
+	rrb = clp_alloc_block(GFP_KERNEL);
+	if (!rrb)
+		return -ENOMEM;
+
+	rc = clp_list_pci_req(rrb, &resume_token, &nentries, mdd);
+
+	clp_free_block(rrb);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(zpci_get_mdd);
+
 static int clp_base_slpc(struct clp_req *req, struct clp_req_rsp_slpc *lpcb)
 {
 	unsigned long limit = PAGE_SIZE - sizeof(lpcb->request);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
