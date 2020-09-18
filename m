Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A4C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06082075E
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="An2RGosn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06082075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA4E6872FD;
	Fri, 18 Sep 2020 10:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83HlxOo8xx-W; Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A21FF872DD;
	Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8185FC0888;
	Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6851EC0888
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4A14E87683
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MW0JloHCvo0K for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:19:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5625E87672
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:57 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id g4so5607747edk.0
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2gh2U/OQRDlfxCtYoS0doxF26o80NSyyKwHk1RFsbXk=;
 b=An2RGosn33WkwrKn91f2hcynPhO0aguQcKdHhB2LUthuXwojJqnDpiGkJsPrYipiDA
 pBgHZMUkueqCEe2uGK/BQfNvSQljRhhsrTdgUWEHCQflnsC1YN6klyAzU0ViKd5+vM9j
 XkqhgBI7f1kR26cFqbzkHrCeJaK6C3OilUnnnp5ImWI20wcvVgomBFVP5gGMfa+DzjlS
 Zisu/ODl7eC3QiRm5h43VRGkMqyahZfMOwNiASorDsh6TdAVQJpCdhjLvRpsORdHhhLq
 n32un+szGBkhCKxnv6Rs5rFm8usvoAtLjxfXziCFDqbp7uGBXaQlU3CldYPAjvBR3noy
 T7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2gh2U/OQRDlfxCtYoS0doxF26o80NSyyKwHk1RFsbXk=;
 b=czcjyUX/BmcIYY5Cwyi1A55oxynJeww75/s/T/X9NsdmT/JBmpDnKAqL3rwdT7A7cc
 3EZXF3fN8krFg4dVqd6rWL6SBmZOXfHLTWxpo1Ap7VQ3uaCFiM2707GGutwYQHFetnA3
 dK2uAlOzALXcXMLION7U5FwnwVU2yEufL/Y2qf6Owqwn1fKKYm8nmdSuWxGQD5Bg6XDF
 7Th/1FWSJbsDBhma+lS5y42nvdy0ZyCBkSCt6ddGm9B+TpfofdB9RB7hfTrkXgs7Rx/d
 ebsUT13BSPEMaDzeUuCka9SatN2cjjvWXqTNK0pqwqc7OlWxDFMZZa4HtuK4ZazPZImA
 8fwQ==
X-Gm-Message-State: AOAM5310pGU4lOX/XdrUyYZYgDWnsxtxD0XC3rIn0UbDPatHiGXzFyF1
 HobErsbHMARxzTI0OsyIgJCYo3eondhJhVvy
X-Google-Smtp-Source: ABdhPJwCf8UyHhQnUAUKzshX9fTYq/59eQXnaDMxaWJg5DmcPX6/b+kkPryQE6Uc4EgCXvl5fGzAuQ==
X-Received: by 2002:a05:6402:176c:: with SMTP id
 da12mr38578214edb.386.1600424395283; 
 Fri, 18 Sep 2020 03:19:55 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:19:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 01/13] mm: Define pasid in mm
Date: Fri, 18 Sep 2020 12:18:41 +0200
Message-Id: <20200918101852.582559-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 Christoph Hellwig <hch@infradead.org>, Tony Luck <tony.luck@intel.com>,
 zhangfei.gao@linaro.org, will@kernel.org
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

From: Fenghua Yu <fenghua.yu@intel.com>

PASID is shared by all threads in a process. So the logical place to keep
track of it is in the "mm". Both ARM and X86 need to use the PASID in the
"mm".

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
https://lore.kernel.org/linux-iommu/1600187413-163670-8-git-send-email-fenghua.yu@intel.com/
---
 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..1ff0615ef19f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -542,6 +542,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+#ifdef CONFIG_IOMMU_SUPPORT
+		u32 pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
