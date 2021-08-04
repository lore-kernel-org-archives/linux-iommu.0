Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23EC4338F
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:45:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0620B60F58
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0620B60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D627660A50;
	Wed,  4 Aug 2021 18:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j8vRQtRfv4xV; Wed,  4 Aug 2021 18:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CADBC60A38;
	Wed,  4 Aug 2021 18:45:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6AD1C001A;
	Wed,  4 Aug 2021 18:45:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D118C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F077F60612
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WA0XGDKtmrro for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:45:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EDE560A50
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:31 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 cl16-20020a17090af690b02901782c35c4ccso1106898pjb.5
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FdFAudmr1+kygb9VLkJoTvdwIA9Vg/qvV4n+6/T0PLM=;
 b=olNy8x8y7DV61QBkuXuMrjl8xyjVV6qI92ML9lui5gV9yaNd+g2yRo8+GAjxd8Shaw
 k/aTAARZG99hTkIBKMYA8AGviCdjwdKUj9zvrSsMRj3YRUG5xnaWS/4qsbqpqwqCDxVq
 thDtttD8qDBBwUgnHLZDfNa4in8fDL5BO/rbvDTdpiDuDEU1/QpqHcaG2k2j/JzClxiS
 J14sR1WMiTvZ9mb8KqscgmQf9kA0OfiyX4uR9IOjwyzY85SR5/dpYBVyd2yQ7Rbd9F94
 JCAgvx+khF5I5ToQJpXoaocqMVIQHlMGBh2ExwSjPQVaypIrNzCxPp5ZbaCkrafC015M
 zj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FdFAudmr1+kygb9VLkJoTvdwIA9Vg/qvV4n+6/T0PLM=;
 b=gngzn0Z/obA1z/XwYxjl2gx1UCUdtZtrE37OX1GOiCROnijnkX+SdhG5SB14waaviG
 skkok283/b1OH49TPWM8WZlxB+X5ut3MnjYKjEERqwQlCgCcibbbNHeEjgR3HgzI62BV
 7GOo9fGog/dw7VveVPjkdIaoxUf9Zx5LSTpm5gtXmx9jxgxx3Nxui5LC9hQfmAjUopNQ
 SESB9NTv99OxPDMiFFTau4lWu1gCFrsWDJLHxldRDcKSXAwxW74E8uPbFBoVdvEjQBpk
 qfZBk6Wm0Z5GQjYGbPRb33ylE3VzxUDz8UKWWTpmYk8jFU6F9WYQ0Mq/MtKF1uncGLPQ
 qr+A==
X-Gm-Message-State: AOAM5302SNzdq1a1Ws0Y16oUt/TMl5Ucb3tGrCY0HTyVZv3EycL+oR0g
 PVz1cLCrySpWeuRP9BLnzuI=
X-Google-Smtp-Source: ABdhPJwPmTFefX7A/J1jN8u3n99CGRipE6kjwRUWfraZOYkn2XRufM5MD06moIp1hWSu/z++9TU7ow==
X-Received: by 2002:a17:902:c651:b029:12c:1ec0:a8b8 with SMTP id
 s17-20020a170902c651b029012c1ec0a8b8mr486766pls.40.1628102730835; 
 Wed, 04 Aug 2021 11:45:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:f:1947:6842:b8a8:6f83])
 by smtp.gmail.com with ESMTPSA id f5sm3325647pjo.23.2021.08.04.11.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 11:45:30 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 akpm@linux-foundation.org, brijesh.singh@amd.com, thomas.lendacky@amd.com,
 pgonda@google.com, david@redhat.com, krish.sadhukhan@oracle.com,
 saravanand@fb.com, aneesh.kumar@linux.ibm.com,
 xen-devel@lists.xenproject.org, martin.b.radev@gmail.com, ardb@kernel.org,
 rientjes@google.com, tj@kernel.org, keescook@chromium.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V2 03/14] x86/set_memory: Add x86_set_memory_enc static call
 support
Date: Wed,  4 Aug 2021 14:44:59 -0400
Message-Id: <20210804184513.512888-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804184513.512888-1-ltykernel@gmail.com>
References: <20210804184513.512888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V and other platforms(e.g Intel and AMD) want to override
the __set_memory_enc_dec(). Add x86_set_memory_enc static
call here and platforms can hook their implementation.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/set_memory.h | 4 ++++
 arch/x86/mm/pat/set_memory.c      | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 43fa081a1adb..490f2cfc00fa 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -4,6 +4,7 @@
 
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
+#include <linux/static_call.h>
 
 /*
  * The set_memory_* API can be used to change various attributes of a virtual
@@ -84,6 +85,9 @@ int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
 
+int dummy_set_memory_enc(unsigned long addr, int numpages, bool enc);
+DECLARE_STATIC_CALL(x86_set_memory_enc, dummy_set_memory_enc);
+
 extern int kernel_set_to_readonly;
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c586a35..68e9ab522cea 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -18,6 +18,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/vmstat.h>
 #include <linux/kernel.h>
+#include <linux/static_call.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -66,6 +67,9 @@ static const int cpa_warn_level = CPA_PROTECT;
  */
 static DEFINE_SPINLOCK(cpa_lock);
 
+static int default_set_memory_enc(unsigned long addr, int numpages, bool enc);
+DEFINE_STATIC_CALL(x86_set_memory_enc, default_set_memory_enc);
+
 #define CPA_FLUSHTLB 1
 #define CPA_ARRAY 2
 #define CPA_PAGES_ARRAY 4
@@ -1981,6 +1985,11 @@ int set_memory_global(unsigned long addr, int numpages)
 }
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
+{
+	return static_call(x86_set_memory_enc)(addr, numpages, enc);
+}
+
+static int default_set_memory_enc(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
 	int ret;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
