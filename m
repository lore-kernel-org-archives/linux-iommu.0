Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECA8C433E9
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231F2207B7
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F2207B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9FF972288E;
	Wed, 27 Jan 2021 15:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NMC3w6Ct7mF; Wed, 27 Jan 2021 15:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 68286226F3;
	Wed, 27 Jan 2021 15:44:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54AF6C08A1;
	Wed, 27 Jan 2021 15:44:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF46FC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE01A871DB
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4SdYgQ2nqI4 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 15:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6AC8C871DE
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:36 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id u14so2071566wmq.4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
 b=BQJC3HuzpSzPBhYU8dAoIE4ZFOsaKvTTyDozAsFM/UlXGrWhBWsG1EBwunnAFsQ7fi
 Cx6syUteFUWRkMbIUgIP/7mUtZnmYFakuGW4SsO2HYY8yC3V29+hRjP6BBmROUg7LaQI
 aqsoQl5WG6wx9FDljC24Hkkr2MSU5/DJAJ6zVS02cIGN54trZqTVDl7jf2gKnTFxcFsR
 brLgpNCFXSoX9613SmJxNT49S2bJcbAxoyN26EEtgxLXXUnadPwjEgY/e506opSx3820
 uNXoF0qCGnGL5/tkm1T76snDHbiUJrhNkBBpAuFEKzUgjQ+DiexDYpHVV90v9UMZ47Il
 uBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0PBUJkI6WkOQ4c7ebH11XhAeKbkF/R51HzjghE20E74=;
 b=ggz7xDZnQpZf7ogKACvddvGkKuShvjIES5k4gWyNaxjuExIsHfw+OYw9uPy12BrT85
 Nrx7gUmvML51qNWcfCwUdHu+7OfUbStHpY0ph1wpGd0jRareSqXWBfxoDnzYJ8Rvji28
 a/fYs0aBczdRbl25R99g1ixVcxUw+2NX9RdSTQ8H10pZO5YdgnQPVjJBJQ6aljlTIHbw
 DE1BZI1xKv8g/CWQLe5eeVMRwnZ/kC0TTtvcV3XHWoht21SWyF59NNteoOqMyG8xQRID
 jJB0n0lJEy3g9JD4VPerAAhj8BeB0bj0n3jHIJ1itshxi4nOce/rMCYI1gsx4cF9Zhij
 dDiQ==
X-Gm-Message-State: AOAM532UWQq5LLgGBQx0pwzfZsQtdZwQWeLwVm3biQZ9/rOhRRMKzCW8
 LW+OWiT1AQOwwmRD/LHDpRc4fg==
X-Google-Smtp-Source: ABdhPJy7KRFJ7NFIkxsBzkZIFHw9c+dEAyELqQZaTxwXlNuad0dlgQbMzSL7a36FagOJol78uVNV6w==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr4755144wmb.180.1611762274755; 
 Wed, 27 Jan 2021 07:44:34 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 07:44:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v12 01/10] iommu: Fix comment for struct iommu_fwspec
Date: Wed, 27 Jan 2021 16:43:14 +0100
Message-Id: <20210127154322.3959196-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
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
