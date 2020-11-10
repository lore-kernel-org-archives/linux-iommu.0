Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9BC5517A
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 07:20:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A01520781
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 07:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzfiMPb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A01520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD0CC86477;
	Tue, 10 Nov 2020 07:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UU2HDB5Ctvix; Tue, 10 Nov 2020 07:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DAF4E86365;
	Tue, 10 Nov 2020 07:20:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0367C0889;
	Tue, 10 Nov 2020 07:20:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B52DC016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 07:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4715E87071
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 07:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GPaocJdibNjq for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 07:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3021287059
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 07:20:10 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id i13so4604543pgm.9
 for <iommu@lists.linux-foundation.org>; Mon, 09 Nov 2020 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i6nP9JdNbvB32WvH3g9vlgcvuC9Z9huJ+Sj31cT5K9U=;
 b=mzfiMPb0952EhsBRXCBhANIHZUUVzD+DJ7SWwYeXLAfPahkfmqZ76+tD6RINHgSjux
 BjIaNAkQls5BsPHiiwfOg3RUP/U1l0MdZbYeZhMSuxyhD3LraHbdN4bnG9/PkQwfRTbJ
 /0TCQ55iA0i5+hiV64uDBRrYEqwN2Lrfgge2q5Hztu41rCZaSe9OzRAhZ36ckNQ9D1S6
 LZwOK58ye6H8y5tgSs1A4DmGMagGP7uyp5m8bUXfVIaKQtpSU5BwO7KTNvMwtFOH2b9k
 xevsT5MJnCtjv2pk0StlIXWCXS0Tg6pVnwYnsd0ZWh52p77iJQJDymiEw98Gvbq/3xoO
 Lr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i6nP9JdNbvB32WvH3g9vlgcvuC9Z9huJ+Sj31cT5K9U=;
 b=OZBVvmRTaKLJSVuBV6XcJbJY/2ksapvGLmPADvdcKCi5ZfwCKEonmAYB35+lpm6Ja3
 AzKxtBucmSPvTii771eKDjkuYZk56bDaO2t+lfi1M6ZeFpcMHJWKGkmiNITHJi92RCWe
 sF0yUMb96wyYyWAUTpJoGTVG3o3gXa39/ayMvaPPa+kTDHyVX+mgPlOfTRibxelDQhsE
 Li0Imx2BAgNiURa8MdYgF654RAgd8RGEuuEA1t+hfof9EAx39yi5Xf/9ApE8VXxzlQXx
 cLumedEuFW2T0ni2WtnSTDjwnppdXjYP1F0Ga6GNuBfkUGkxkVzcG7GF0Uymj5rg8OSc
 oFoQ==
X-Gm-Message-State: AOAM530g23fGAlCIzoQ679QjLDsQncSLmtJC4Q84Uu8XtjfnGT10vqXi
 rftrZG7fxhcqU0jdVwjOE+U=
X-Google-Smtp-Source: ABdhPJygL/bvlUm3EQiP4+xf7MRcSwyrR18UTDKygf+vM0MyMNltVMw/5wtlEOk7efvGOhhJccDmuQ==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr16092820pgd.433.1604992809793; 
 Mon, 09 Nov 2020 23:20:09 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
 by smtp.gmail.com with ESMTPSA id n27sm13552401pfq.59.2020.11.09.23.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 23:20:09 -0800 (PST)
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail in
 tboot system
Date: Tue, 10 Nov 2020 15:19:08 +0800
Message-Id: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: x86@kernel.org, tboot-devel@lists.sourceforge.net, ning.sun@intel.com,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 tglx@linutronix.de, dwmw2@infradead.org,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>
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

"intel_iommu=off" command line is used to disable iommu but iommu is force
enabled in a tboot system for security reason.

However for better performance on high speed network device, a new option
"intel_iommu=tboot_noforce" is introduced to disable the force on.

By default kernel should panic if iommu init fail in tboot for security
reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".

Fix the code setting force_on and move intel_iommu_tboot_noforce
from tboot code to intel iommu code.

Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.

 arch/x86/kernel/tboot.c     | 3 ---
 drivers/iommu/intel/iommu.c | 5 +++--
 include/linux/intel-iommu.h | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb14..420be87 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,9 +514,6 @@ int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
-	if (intel_iommu_tboot_noforce)
-		return 1;
-
 	if (no_iommu || swiotlb || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1b1ca63..4d9b298 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -179,7 +179,7 @@ static inline unsigned long virt_to_dma_pfn(void *p)
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-int intel_iommu_tboot_noforce;
+static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
@@ -4885,7 +4885,8 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	force_on = tboot_force_iommu() || platform_optin_force_iommu();
+	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
+		    platform_optin_force_iommu();
 
 	if (iommu_init_mempool()) {
 		if (force_on)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fbf5b3e..d956987 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -798,7 +798,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
-extern int intel_iommu_tboot_noforce;
 extern int intel_iommu_gfx_mapped;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
