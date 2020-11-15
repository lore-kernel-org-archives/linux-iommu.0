Return-Path: <SRS0=8b8q=EV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07892C2D0E4
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 21:00:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A035223FB
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 21:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H57uoI27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A035223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 147B7863D9;
	Sun, 15 Nov 2020 21:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NyHBTRyqfu6m; Sun, 15 Nov 2020 21:00:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 58E2E8675A;
	Sun, 15 Nov 2020 21:00:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 236B7C0891;
	Sun, 15 Nov 2020 21:00:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A379C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 21:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7A3D8203C7
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 21:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2zhYaozBwUPL for <iommu@lists.linux-foundation.org>;
 Sun, 15 Nov 2020 21:00:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 58BF520360
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 21:00:01 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id k2so16672994wrx.2
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 13:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=dLbdlp0c1Ky6bbcCd24/KxFE5FORT9BDtA7PPhpTLOo=;
 b=H57uoI271DVrV5SOv66p1juq12QoiklfYiJ2DppioVUMislwiPtIMyWpnVgqwa1/EV
 RHbSIN363vSAOIgYjofzLMINtndhGBOrWZIc5vc7moMGOcstRRKC/vF2ub84anqgGV0w
 W4zKkqlg6I0povJE3Ai5WJCSJ5K56NDM8SVusJdseqg5CeqbwE/7Kfukh7babvJ6JZK3
 MnIrHD7VZnct1j9NqsqJp/uMV4NLzLY/oP9VThux85SIbk3yX91NPadjcKyylxTdzvDm
 0PNOCjiakgy+aPvzmsJP46f5d9spQL6SBzEvc8P/Tr80HlwJuftvjLjY833172Ox9TAd
 Q3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dLbdlp0c1Ky6bbcCd24/KxFE5FORT9BDtA7PPhpTLOo=;
 b=jZK+1etP+uEahknjZG0FTQ9nqjYIrVsKNmYZ8tnyopX35iqKYIpaXfQ9N+lUXLJ4Nt
 C07E1ThYppTECITdygBwpWDyvw1Z9RLvKlkg1vgD8X+BxHMfpyXF4oWkxhcolhBJAQQx
 XK90Za4sU8QWy90df/K9uZzGaq8THTZzkkqVnY+dZ2v6hO+766Mq+dkpN/eoqq9MwHEa
 ZYJ9u0BUzXMz3RUxL0uCOAM3QQKyEc+Rw7WcjcQL8LJqsFA6AbM+1G+/rzCG3qXS0Ewx
 nuN5MwvqLSrqa6adhjIKIilcoYnb6IdUEBUKjMnh5rrxKCzmEJIeuJ/Vf2I9WDQaNXJH
 eyyg==
X-Gm-Message-State: AOAM532U1LWdIpTLEdKKNuod6CxLQHS49y/KReR1KuV3Z3uFXoPVhmJP
 Jr8+Al7JwFEdOV3kZnKd+e0=
X-Google-Smtp-Source: ABdhPJymqYAPnQftYmMxIKdNayAHJvCUYEkaHGB07m5wX9ik0olWdfP8ekTGsX8ar28q89N9UBSaVw==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr15984730wrl.415.1605473999601; 
 Sun, 15 Nov 2020 12:59:59 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d94:6d00:d052:40da:8fc9:54db])
 by smtp.gmail.com with ESMTPSA id d16sm19845364wrw.17.2020.11.15.12.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2020 12:59:58 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Liu Yi L <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: include conditionally on CONFIG_INTEL_IOMMU_SVM
Date: Sun, 15 Nov 2020 21:59:51 +0100
Message-Id: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Tom Rix <trix@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>
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

Commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
introduced intel_iommu_sva_invalidate() when CONFIG_INTEL_IOMMU_SVM.
This function uses the dedicated static variable inv_type_granu_table
and functions to_vtd_granularity() and to_vtd_size().

These parts are unused when !CONFIG_INTEL_IOMMU_SVM, and hence,
make CC=clang W=1 warns with an -Wunused-function warning.

Include these parts conditionally on CONFIG_INTEL_IOMMU_SVM.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201113

Liu Yi L, Jakob Pan, Lu Baolu, please ack.

Joerg, please pick this minor non-urgent clean-up patch.

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c6622011d493..7b32703c0b47 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5386,6 +5386,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
 	aux_domain_remove_dev(to_dmar_domain(domain), dev);
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
 /*
  * 2D array for converting and sanitizing IOMMU generic TLB granularity to
  * VT-d granularity. Invalidation is typically included in the unmap operation
@@ -5432,7 +5433,6 @@ static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
 	return order_base_2(nr_pages);
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 static int
 intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			   struct iommu_cache_invalidate_info *inv_info)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
