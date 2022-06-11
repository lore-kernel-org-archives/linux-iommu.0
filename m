Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758DFC433EF
	for <iommu@archiver.kernel.org>; Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 092A883F02;
	Sun, 12 Jun 2022 12:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05-YDr0V0OQv; Sun, 12 Jun 2022 12:29:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA4DC82702;
	Sun, 12 Jun 2022 12:29:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94491C0032;
	Sun, 12 Jun 2022 12:29:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0068C002D
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C3DE60B17
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WjZxe4UAmvV9 for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 20:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D31260ACF
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654980543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KEbYtgeCY5d2A+34Js+u4oC9j4ydleTr8OH6QnelxU8=;
 b=Eug5Lnmu9T8iWiFXa9xZ6RVdQgo7eDLb+X75uSZbsOuUTTpJLKm4n0q4nVK86INA2aoFp0
 FWQF4LuOGwph6XAasnzjBK35RT4VDq0k0nKVam5JJBP+XY/3mCNXFCRA3PtS5q+4oCVYg0
 L9szOsKgiigvUCmciS9FaWTZYamIQMY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-kb63Mi6mN5Cnd4yE9cWbgg-1; Sat, 11 Jun 2022 16:49:02 -0400
X-MC-Unique: kb63Mi6mN5Cnd4yE9cWbgg-1
Received: by mail-wr1-f69.google.com with SMTP id
 w8-20020adfde88000000b00213b7fa3a37so196807wrl.2
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jun 2022 13:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KEbYtgeCY5d2A+34Js+u4oC9j4ydleTr8OH6QnelxU8=;
 b=2R+zfE2hGGcHjJKg02GH6u5zEVEIE/xRrDTrv/CftFhwjRI0e9nU+YNmnOv8w75lPf
 Y3Cmh2QbQHmTDElLE5BS1WIUnayNYvvLJgHO7a+LwYp/po+GhMMphp1PGM2DdaPt9r9g
 ipHuwNIvOGkTcA7LICYESj1jBJ0/H22oTxWa+IrTB/Rpx8RI0NAwVfWMWwCzeSBkjY7v
 u3bdGJvVxn7Je0fLJrSxz6eV0fZz2u5VRYK8Mag9sUrDF27F5QDkstMlGMhxewsnTIqD
 Fi8avfseIxk1yWzOyrTArPjQbUCualZ/K+eddNvDx3ZjlFzi/pv4iN2mA75jvhSuUR5z
 FCQA==
X-Gm-Message-State: AOAM530fJev8/C7q3wBl9HikLRtAEH6LNXNBAJOZGsrajjxz7xjKeY8W
 354JmgG7sxSJgCCrKdoUYuVhbdBRYokNniyOVziiMcz/l1q51tqPe0L2O4mWCubD1G+3/IA/hqz
 XNruNK6uYZoSV/sCcHbotPWrYeIw1
X-Received: by 2002:a5d:4845:0:b0:210:25fa:dc7c with SMTP id
 n5-20020a5d4845000000b0021025fadc7cmr49214324wrs.131.1654980541130; 
 Sat, 11 Jun 2022 13:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw48t8wKUPQYNAVF5n9sTc868ZFn15aSjSQu8D4WNlpoKkdHCO5/bj2xUhmGmbcBeQcf6rWaw==
X-Received: by 2002:a5d:4845:0:b0:210:25fa:dc7c with SMTP id
 n5-20020a5d4845000000b0021025fadc7cmr49214317wrs.131.1654980540940; 
 Sat, 11 Jun 2022 13:49:00 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net.
 [82.17.115.212]) by smtp.gmail.com with ESMTPSA id
 d4-20020adffbc4000000b00219b4c01712sm3506635wrs.92.2022.06.11.13.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jun 2022 13:49:00 -0700 (PDT)
From: Aaron Tomlin <atomlin@redhat.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Subject: [RFC PATCH 1/3] x86/boot/e820: Make __e820__mapped_all() external
Date: Sat, 11 Jun 2022 21:48:57 +0100
Message-Id: <20220611204859.234975-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
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

This patch allows __e820__mapped_all() to be available for
external use, in preparation to enhance the error message
generated by arch_rmrr_sanity_check().

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/x86/include/asm/e820/api.h | 1 +
 arch/x86/kernel/e820.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..bf78daa08897 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -13,6 +13,7 @@ extern unsigned long pci_mem_start;
 extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
+struct e820_entry *__e820__mapped_all(u64 start, u64 end, enum e820_type type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..09b1c863a766 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(e820__mapped_any);
  * Note: this function only works correctly once the E820 table is sorted and
  * not-overlapping (at least for the range specified), which is the case normally.
  */
-static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
+struct e820_entry *__e820__mapped_all(u64 start, u64 end,
 					     enum e820_type type)
 {
 	int i;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
