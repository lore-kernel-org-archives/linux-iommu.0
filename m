Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99DFCCA47F
	for <iommu@archiver.kernel.org>; Sun, 12 Jun 2022 12:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7407B83EDC;
	Sun, 12 Jun 2022 12:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kpf8w-HAfRu4; Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2323082702;
	Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16B7AC0086;
	Sun, 12 Jun 2022 12:29:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176FCC002D
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0657841773
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h7xXxFWS8uX6 for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 20:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D802041765
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654980548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcR0aKofOSCGCYosAm/fDhdf+hmatzPLZ0c9B4qN7K8=;
 b=YIHn/049y+D4a6+/qwJnd19Q1qAHEQ5+5Hg7xIVL/qetBh/+XTPNNYJh1J5RClY9m7j7Jf
 TCSqjcVs0q6hye9rSYN7GlD2QWKnfEhNvA/c/S8At6I4upvyfgeCeMBrzTsywwyc+6j/aV
 dMXlEDEQnsTso7MJj4p+RaEU9JNmQsU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-2L71WgfzNCKDgPhBZ7SW1Q-1; Sat, 11 Jun 2022 16:49:06 -0400
X-MC-Unique: 2L71WgfzNCKDgPhBZ7SW1Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 be12-20020a05600c1e8c00b0039c506b52a4so2402925wmb.1
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 13:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CcR0aKofOSCGCYosAm/fDhdf+hmatzPLZ0c9B4qN7K8=;
 b=mYhXftRL1xjcK1tvbhqbxXbtDVOO/E0JAM6FQFXWP2I8X2FAh/j6CCR69PeL3M6APi
 zlIEHu9sXherhkw4s2Q4Bw2iywtsOVtTCZAqrUuYU+6KPVhAkedgsCOlFJk0++Bh4o4u
 Uv79AJVAGV4A+C7i8eB6UsoiTBe9ut2hZTmBpDXvyQtb2H0Y3yTtFV55HgD+YYIEwD+T
 p8kKGg1//OoNcoQ7EeNewXMzluj2rmpa3KxbhN0EMWlmG0p/FjfuMA5bbDxZAlBhpAsg
 Ce4/ycGjVtaTpA5VAN2oLAwjXUfunFpOhTspEl5m1FJc/hRcbRJ2L2o/YFVoRVoNZ1m4
 +kLA==
X-Gm-Message-State: AOAM533YCZO74FyT01hD5Ksz6lI4RYNNAL+N/HV7sZEhLFBhWVX+P3Sb
 5MEvufPNzVywF9JiCVSfrk3VSpcfPIAVOcQBk/zSV4/pxHHK4kaS6Vt4z97h6rRNKT6MhgQbM9V
 LpnrWSc2Zp393Wt1Q1WtQLmxRjQHp
X-Received: by 2002:a05:6000:3c5:b0:219:d09:6fce with SMTP id
 b5-20020a05600003c500b002190d096fcemr18325878wrg.197.1654980545356; 
 Sat, 11 Jun 2022 13:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybNY6Mydqdoa+x8UT/rxgTAmWTiQ9yFznUm8N5Ot/sTlJOQwm2A9g83GLDT7qk18aCHmI54Q==
X-Received: by 2002:a05:6000:3c5:b0:219:d09:6fce with SMTP id
 b5-20020a05600003c500b002190d096fcemr18325860wrg.197.1654980545143; 
 Sat, 11 Jun 2022 13:49:05 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net.
 [82.17.115.212]) by smtp.gmail.com with ESMTPSA id
 h7-20020a05600016c700b0020c7ec0fdf4sm4082355wrf.117.2022.06.11.13.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jun 2022 13:49:04 -0700 (PDT)
From: Aaron Tomlin <atomlin@redhat.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Subject: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Date: Sat, 11 Jun 2022 21:48:59 +0100
Message-Id: <20220611204859.234975-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611204859.234975-1-atomlin@redhat.com>
References: <20220611204859.234975-1-atomlin@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=atomlin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Sun, 12 Jun 2022 12:29:06 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 atomlin@atomlin.com
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

This patch will attempt to describe the region type in the event
that a given RMRR entry is not within a reserved region.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/x86/include/asm/iommu.h | 9 ++++++---
 arch/x86/kernel/e820.c       | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..d21366644520 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -17,12 +17,15 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	u64 start = rmrr->base_address;
 	u64 end = rmrr->end_address + 1;
+	struct e820_entry *entry;
 
-	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
+	entry = __e820__mapped_all(start, end, 0);
+
+	if (entry && entry->type == E820_TYPE_RESERVED)
 		return 0;
 
-	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
-	       start, end - 1);
+	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%s: %#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
+	       e820_type_to_string(entry), start, end - 1);
 	return -EINVAL;
 }
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 95b994cf80cd..165e9a444bb9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1073,7 +1073,7 @@ void __init e820__finish_early_params(void)
 
 const char *__init e820_type_to_string(struct e820_entry *entry)
 {
-	switch (entry->type) {
+	switch (entry && entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		return "System RAM";
 	case E820_TYPE_ACPI:		return "ACPI Tables";
@@ -1083,8 +1083,9 @@ const char *__init e820_type_to_string(struct e820_entry *entry)
 	case E820_TYPE_PMEM:		return "Persistent Memory";
 	case E820_TYPE_RESERVED:	return "Reserved";
 	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
-	default:			return "Unknown E820 type";
+	default:			break;
 	}
+	return "Unknown E820 type";
 }
 
 static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
