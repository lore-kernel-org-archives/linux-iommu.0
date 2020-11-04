Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA40C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 08:20:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9DF2074F
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 08:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLVcedig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9DF2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0160F86463;
	Wed,  4 Nov 2020 08:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muKl9TnWZqgQ; Wed,  4 Nov 2020 08:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D5A286456;
	Wed,  4 Nov 2020 08:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66A53C088B;
	Wed,  4 Nov 2020 08:20:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD9C6C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D88F686C8F
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id klvlJ7DRtdMP for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 08:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9473D86BD5
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 08:20:10 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id f38so15963782pgm.2
 for <iommu@lists.linux-foundation.org>; Wed, 04 Nov 2020 00:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YMC7KT98x49skg9kEqjdGQnBbZ+1J2nc85cU6FlABV4=;
 b=eLVcedigA819LViJREK7rebAOBPi5ZCiK03S5hHPFCnzm1u4bNfUTbOa92j03VozK5
 fkJ7YQ+a9VhsMKkQ9GIq1PsApy8JtSxSRq6KVKM9tTK3/PvAJnZB0gwIViVjWxqMomjT
 euxnpguLCL6KBMCKbOL8Cg4i/cuFnYMROPD9/LPV7KkjLL2Jh3fEgY2uXtcL2fWGDaRa
 AGxB4wnaeIEph80WAEBaT8EjvsqoYuuICAY+4NfgKA9rFCkFlwLaYcP70Z52dBcJcg6O
 uQtIsPClTEpcFW51LPax5mPQXc3/cliK//GZWVIEcwAtEGDKAIWm4xK/bX46mRa9GFTK
 Vgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YMC7KT98x49skg9kEqjdGQnBbZ+1J2nc85cU6FlABV4=;
 b=LGLH92k8LsZr5vWXX4mcNQ2XzspiE478cK83vbJ+6DZ7fEQTn8dl2PMVLV9WNpAoSC
 tcN6XZNgjjoBtKlN2++eiL4vOSQNBnlvk8gUgHD/503tFg74Yi6xbImniSVaPbUZ2guo
 JLFfew+91TqSd4J1HIPHJNJqVkFcW7X3jyL3CqgqTl2n+3mQ+pGNCShDlTn5TpW9+6u7
 aC9FLD1reo60TSx6J3H4nTrAnkTYUYqTX69WC9VNsR3juX3BmMvxlYwmZo6CPrpPnehq
 hWjFcv2SbZ0RswGtQOw+c2dh1gMWeWk+yeYXeuq+Q5itXTJpwuWkEHHJBh9NicHJUefh
 B++g==
X-Gm-Message-State: AOAM531Kjac5LNlzRra6XqBABx1hmKOZUmia7v6TbZD8WlN/ryTVIClv
 /lCFINHaHQk2/SNnSodWYXU=
X-Google-Smtp-Source: ABdhPJyaqqhYVEHLX70GURN6fXuYYZkMaC6LaYP2ytjcoN7jI9Mzeac0pK0nVMni9MdSllxt28O+Dw==
X-Received: by 2002:a17:90b:1218:: with SMTP id
 gl24mr3174291pjb.131.1604478010174; 
 Wed, 04 Nov 2020 00:20:10 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
 by smtp.gmail.com with ESMTPSA id z7sm969322pjc.41.2020.11.04.00.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 00:20:09 -0800 (PST)
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: remove redundant variable no_platform_optin
Date: Wed,  4 Nov 2020 16:19:36 +0800
Message-Id: <20201104081936.2128-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Zhenzhong Duan <zhenzhong.duan@gmail.com>, dwmw2@infradead.org,
 iommu@lists.linux-foundation.org
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

no_platform_optin is redundant with dmar_disabled and it's only used in
platform_optin_force_iommu(), remove it and use dmar_disabled instead.

Meanwhile remove all the dead code in platform_optin_force_iommu().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/iommu/intel/iommu.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8651f6d4dfa0..a011d1ed63ef 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -180,7 +180,6 @@ static int rwbf_quirk;
  */
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
-static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
@@ -440,7 +439,6 @@ static int __init intel_iommu_setup(char *str)
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_disabled = 1;
-			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			dmar_map_gfx = 0;
@@ -4810,20 +4808,12 @@ static inline bool has_external_pci(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
+	if (!dmar_platform_optin() || dmar_disabled || !has_external_pci())
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (no_iommu)
 		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
 
-	/*
-	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
-	 */
-	if (dmar_disabled)
-		iommu_set_default_passthrough(false);
-
-	dmar_disabled = 0;
 	no_iommu = 0;
 
 	return 1;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
