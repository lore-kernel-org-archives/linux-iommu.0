Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFDCC43334
	for <iommu@archiver.kernel.org>; Sun, 12 Jun 2022 12:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2B244097A;
	Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wuPmBcNgiRis; Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95AE040931;
	Sun, 12 Jun 2022 12:29:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D78C8C0082;
	Sun, 12 Jun 2022 12:29:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 863D2C002D
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75D5F84492
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIpLSavdd76g for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 20:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B8B98415C
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654980545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPW8MJZeU1cQQOGf+k4czGCcsVXXmPCDagh2Sq6V6IM=;
 b=U31xVtKJ1X1MSTTgYnz9CB59bXvEtrceGynNihvu5SeI4nGZjQy7HnlBMAVgzuKYRXSmtH
 M5Es4Tp7lpq+UbMkLfWFQHm94axXrDqV1BAoPfEi0uPtB3zLW73m3NeObJPdaT5eXhgAmC
 2MAL61DmqgQBOAYhjfXDUQc+8hJvuuM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-KCG-Nf9DMMWO1-jQBxE2Ew-1; Sat, 11 Jun 2022 16:49:04 -0400
X-MC-Unique: KCG-Nf9DMMWO1-jQBxE2Ew-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay28-20020a05600c1e1c00b0039c5cbe76c1so3376100wmb.1
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 13:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RPW8MJZeU1cQQOGf+k4czGCcsVXXmPCDagh2Sq6V6IM=;
 b=Vl8uVFZ5hWdaKX7O0fD01QZTMD78nkM73MuA4YGNXJWwaKLQX8VVlpClvjP3LgUjKX
 teFQFT0L84VnBpHAFRuncL3PEfq/HpfDccxZz/0nn1kjOKgWl4LgQ7Of9Jru5nSi7aRV
 otG51CCo1wy4Y6mYo72SjusvfCZGK4ZZhIcAxOk5+uOOoPBn6l06c8hK8Q1wKapstrRe
 Tf3JivwFdvzO697ARe2TJPmIkW18SAMMqZnRmZ6tAEGSYucBbViknCeCRXFeYNsyiAcs
 e33Rd9V5EVeL0465A+8ucCLja6ykBZOucskNS6is3E20XXl3wronqfGHyRZ7dIrUZYro
 z9nw==
X-Gm-Message-State: AOAM531vHdrxxQFeHU41sXwL0Bh4FXHI/+nfWWjGdEJGVV16nv6EYoeQ
 ryc1Fg8NKbgXHJqyvnO+cVddeOJp/EDpOUH9p52eil64tRrfWFMYJVdE+mmsPI/wzHHrCcp8Iuk
 o5sVO+dYKQNn8j1HsAi896cuxkjKb
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id
 v16-20020a1cf710000000b003941960e8a1mr6365035wmh.154.1654980543005; 
 Sat, 11 Jun 2022 13:49:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0/vf4dqScx5mIF462WlkjbnsS1YIOrSwAvq/DIjRGKMRoNpUKnWJeKabDZIF1OiI5YyM06w==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id
 v16-20020a1cf710000000b003941960e8a1mr6365019wmh.154.1654980542848; 
 Sat, 11 Jun 2022 13:49:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net.
 [82.17.115.212]) by smtp.gmail.com with ESMTPSA id
 w17-20020a1cf611000000b0039c5a765388sm3518789wmc.28.2022.06.11.13.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jun 2022 13:49:01 -0700 (PDT)
From: Aaron Tomlin <atomlin@redhat.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Subject: [RFC PATCH 2/3] x86/boot/e820: Make e820_type_to_string() external
Date: Sat, 11 Jun 2022 21:48:58 +0100
Message-Id: <20220611204859.234975-2-atomlin@redhat.com>
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

No functional change.

This patch allows e820_type_to_string() to be available for
external use, in preparation to enhance the error message
generated by arch_rmrr_sanity_check().

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/x86/include/asm/e820/api.h | 1 +
 arch/x86/kernel/e820.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index bf78daa08897..ceb301e591de 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -43,6 +43,7 @@ extern void e820__reallocate_tables(void);
 extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
+const char *e820_type_to_string(struct e820_entry *entry);
 
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 09b1c863a766..95b994cf80cd 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1071,7 +1071,7 @@ void __init e820__finish_early_params(void)
 	}
 }
 
-static const char *__init e820_type_to_string(struct e820_entry *entry)
+const char *__init e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
