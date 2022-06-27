Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215C5C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 15:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C122441529;
	Mon, 27 Jun 2022 15:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C122441529
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dI9T0VKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWjRfqh6JrjU; Mon, 27 Jun 2022 15:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 512674196C;
	Mon, 27 Jun 2022 15:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 512674196C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A899C007A;
	Mon, 27 Jun 2022 15:32:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D321CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 15:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADFAB610B6
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 15:31:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADFAB610B6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=dI9T0VKs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sam8On4FmOkx for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 15:31:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D8D6610A2
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D8D6610A2
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 15:31:57 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id h192so9454872pgc.4
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LCgfBJhENgb3ojrVqpq/GHPBaWKu1KifC83EuVi6Y6g=;
 b=dI9T0VKsh98NfrTIu4AWRJ/2IXmjraWq+1P1LN/hLe29wRLZaR5rvvsVpTVGGWRsLM
 oRPcmybL+9qjIg6JEHoGAgGOFL/kGAFCsWLK7WCM0XkUuNwWOox1ThAs8KlnRPUzQcWt
 lLXhKF+E22CnMCpYiFyIF3YJPLw2bIZpNYTTkS1OfiFBIkhO+xMuQ3FTM2eDbKtI6xTk
 1g/RosEGWW+aSKl566bZiWTywkleIjLQbsyLbh6bujMdhFvi6SkuXCgqzDnInJkA6X9V
 jxbkwdw0mafLIfRF2n+cmdU+c4npLFqnyiJ5MPEI7fj+2r7UycP6rBI7HtPEscl+zfdY
 9fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LCgfBJhENgb3ojrVqpq/GHPBaWKu1KifC83EuVi6Y6g=;
 b=TtvWMq/FipcYqfsZLmq9zuzeq3l+R2vEafsDFItWV4arrHRJ5C9VvAGIvnNPy4RRwJ
 b7p3x/xxt1V5AjnBv9ehliy3gItABfmor1scHIp5YGhNBJ95Iu+UKf2ZizGmSi/1k3T4
 5DHc6DqVaLPO1gIypx5OUII3I/CAYOR4xW9w7JVOcf9DK+MsOP+rTLf7Nic3U5KvkTnP
 2kR3cF3rjECESCQW+BK6RpQAYYe51NYeHHv5deawDtaUchBRf+LqS1XJXh/U3/TcU+aK
 1utVvYy83L7210bNBvf82ReI9onnzU32y4jkjiYB3GJ0dx46Lr7zSzcOO9EEpQIA5n2A
 bCog==
X-Gm-Message-State: AJIora98TmRNwevthmvtFRx/sKrbwTdRKDN3xojA62Q/yA44wdyFTSRE
 IIkHNSEl+l3SWcZJr0W0Xmo=
X-Google-Smtp-Source: AGRyM1u5LW9AITaIesZzlz5OplsMuM7fKSzm3w1NSzCcIsHcbNdQtjNjluJWhAENtSD4tzySP2ykWA==
X-Received: by 2002:a05:6a00:17a8:b0:525:537a:b0df with SMTP id
 s40-20020a056a0017a800b00525537ab0dfmr15547134pfg.71.1656343916526; 
 Mon, 27 Jun 2022 08:31:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:f0eb:a18:55d7:977b])
 by smtp.gmail.com with ESMTPSA id
 y6-20020aa78f26000000b005251ec8bb5bsm7595705pfr.199.2022.06.27.08.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 08:31:55 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: corbet@lwn.net, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 paulmck@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
 songmuchun@bytedance.com, rdunlap@infradead.org,
 damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
 kys@microsoft.com
Subject: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of
 lapic entry in MADT
Date: Mon, 27 Jun 2022 11:31:50 -0400
Message-Id: <20220627153150.106995-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627153150.106995-1-ltykernel@gmail.com>
References: <20220627153150.106995-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 andi.kleen@intel.com, vkuznets@redhat.com
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

When initialize swiotlb bounce buffer, smp_init() has not been
called and cpu number can not be got from num_online_cpus().
Use the number of lapic entry to set swiotlb area number and
keep swiotlb area number equal to cpu number on the x86 platform.

Based-on-idea-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/acpi/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..7e13499f2c10 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -22,6 +22,7 @@
 #include <linux/efi-bgrt.h>
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
+#include <linux/swiotlb.h>
 
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
@@ -1131,6 +1132,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		return count;
 	}
 
+	swiotlb_adjust_nareas(max(count, x2count));
+
 	x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC_NMI,
 					acpi_parse_x2apic_nmi, 0);
 	count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC_NMI,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
