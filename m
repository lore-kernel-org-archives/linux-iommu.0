Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C86C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE6E23A00
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE6E23A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45CA286241;
	Thu, 21 Jan 2021 12:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L2ZZZ3GBfrm4; Thu, 21 Jan 2021 12:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BEE8584536;
	Thu, 21 Jan 2021 12:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C4CC08A1;
	Thu, 21 Jan 2021 12:39:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFEAEC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B52E186030
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rg51jsEcpeQP for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 12:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D5E2885F6D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:33 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id l12so1602833wry.2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
 b=S6KAw6BFvy1u9gJvmutqIln16f2tlRmzrrTj88Jt8KD7XWgeUEfM6naKbWUTAAPUwB
 rZS7buyT/hDN9LnURR0KzikousqtLELsRIgdbWXldN/HbgqPED5ggw9DQI5xYMZBl4jO
 qOmCKvazJNe47iOE/IQhrlbYSbOJK6aqGhTDnurw+RTVmKI8OpKIy66mv0OjGTNemNq8
 D6H49liQT+jbQQWyu6qOoYUGwUjydvCbtSND5j/FWlQs4KpluWbrLop3s7y5psHv/qXI
 6JBpXe8GgGkHTb79wjro/Uc6XEb3UDtIFpKB4GgIjVT807gmpNW8hVcqSy/J775Tgktb
 Ek0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
 b=N6NJE7FpLc1SCdsreuj9P6Ub881MmT3r9BV+MzKtuY688ZmJuGnyhfD3r5BohuILvF
 6ODdBSLIjaXqle+puMyFa8euGM0TUHkhQVBJtg+/nnhrVWD05QDH2zSUaJyAZZuCWmt+
 seIwhCa9bmNSUYTyGYgoq3/THhoI3qTPmIvIXVCsizL89tkU8IPKs/1mG7mZE2PfMATL
 fTFEz8O9f4t+/MTEg7pCxPij2el20opASmhyxU+7b7r91RyxGMA6kE7t784fnq3egueo
 1gpqWxiOAj1gTAgs92sZaaN1sOUEDS7FZCRLZ1td+3+lZ8+jX0Bv9IuT2mneD5tCV177
 rpOw==
X-Gm-Message-State: AOAM531rfgIgtKAh8/2Bvotkig1AVWsHrGI1hzzg7gwuFBQNLs36FKqo
 bH7JAHk3n/ci4wEUnLIwLVfWcA==
X-Google-Smtp-Source: ABdhPJyfGOcKra/ylSEchuLporqovRSRrQIgsiDTRwFORMSbkkpu92YM/S/k4DpD7qDCmqHN7DeYZw==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr14080338wro.216.1611232772398; 
 Thu, 21 Jan 2021 04:39:32 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 04:39:31 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v10 01/10] iommu: Fix comment for struct iommu_fwspec
Date: Thu, 21 Jan 2021 13:36:15 +0100
Message-Id: <20210121123623.2060416-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
dev_iommu") removed iommu_priv from fwspec and commit 5702ee24182f
("ACPI/IORT: Check ATS capability in root complex nodes") added @flags.
Update the struct doc.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..bdf3f34a4457 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -570,7 +570,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
+ * @flags: IOMMU_FWSPEC_* flags
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
