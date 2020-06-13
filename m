Return-Path: <SRS0=B8VN=72=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00080C433E0
	for <iommu@archiver.kernel.org>; Sat, 13 Jun 2020 00:42:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1C62078E
	for <iommu@archiver.kernel.org>; Sat, 13 Jun 2020 00:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1C62078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B42E888C98;
	Sat, 13 Jun 2020 00:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQE8aX6vdTmf; Sat, 13 Jun 2020 00:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A79B988CA6;
	Sat, 13 Jun 2020 00:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91A35C089E;
	Sat, 13 Jun 2020 00:42:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8DF1C016F
 for <iommu@lists.linux-foundation.org>; Sat, 13 Jun 2020 00:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B0D7A20466
 for <iommu@lists.linux-foundation.org>; Sat, 13 Jun 2020 00:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCHL88HSYj0O for <iommu@lists.linux-foundation.org>;
 Sat, 13 Jun 2020 00:41:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id CB479231A1
 for <iommu@lists.linux-foundation.org>; Sat, 13 Jun 2020 00:41:52 +0000 (UTC)
IronPort-SDR: SJ9vtwf57kLK9n9p547Ji0Ct32sOK8NWRAyAE2NovbQqzvEiWfPzpJZUbDA6ZgrayUzzBLxNuR
 K2k+V04AN4hA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 17:41:52 -0700
IronPort-SDR: BiFZdLQU/2ZsAJaAhFSUIxQzESoPLxP778H5G1z+nD1VLagLl5+itUKiQIO/7L5DmXTImtazEQ
 f+Sqx7eaG2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; d="scan'208";a="261011226"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 17:41:52 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H Peter Anvin" <hpa@zytor.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Frederic Barrat" <fbarrat@linux.ibm.com>,
 "Andrew Donnellan" <ajd@linux.ibm.com>,
 "Felix Kuehling" <Felix.Kuehling@amd.com>,
 "Joerg Roedel" <joro@8bytes.org>, "Dave Hansen" <dave.hansen@intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v2 08/12] mm: Define pasid in mm
Date: Fri, 12 Jun 2020 17:41:29 -0700
Message-Id: <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, iommu@lists.linux-foundation.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PASID is shared by all threads in a process. So the logical place to keep
track of it is in the "mm". Both ARM and X86 need to use the PASID in the
"mm".

Suggested-by: Christoph Hellwig <hch@infradeed.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- This new patch moves "pasid" from x86 specific mm_context_t to generic
  struct mm_struct per Christopher's comment: https://lore.kernel.org/linux-iommu/20200414170252.714402-1-jean-philippe@linaro.org/T/#mb57110ffe1aaa24750eeea4f93b611f0d1913911
- Jean-Philippe Brucker released a virtually same patch. I still put this
  patch in the series for better review. The upstream kernel only needs one
  of the two patches eventually.
https://lore.kernel.org/linux-iommu/20200519175502.2504091-2-jean-philippe@linaro.org/
- Change CONFIG_IOASID to CONFIG_PCI_PASID (Ashok)

 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64ede5f150dc..5778db3aa42d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -538,6 +538,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+#ifdef CONFIG_PCI_PASID
+		unsigned int pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
