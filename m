Return-Path: <SRS0=bDbm=VH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F073C74A35
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 22:41:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E7B20665
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 22:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E7B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A54049D6;
	Wed, 10 Jul 2019 22:41:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6512C46DE
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 22:31:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
	[209.85.166.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D89FA883
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 22:31:21 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id g20so8212845ioc.12
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 15:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=hOG8zlfoxNbtpH6RpS4NKEtFxZJq0YZhVn4ElI+1I6E=;
	b=gd1Mtky4FV8MWis8f1o8XPEKNwg1rXesmml9pOwpOynEPOFQLul00dL9SMPFL5r+99
	2nmsVuvLirv9iq0+W2kfLTGDvFQ4USufApRVJXj95AjVv9ULKkRhQg16kGR4edVM337c
	214vidCb+wIYSizLmYPSWLW41ikm9e1rnh+nvVEcG1TPAQqDO2HrXBNIitzpDhSM+vrU
	WJEcx2vl+qzfMkqR0wRvzfLXHjto3d/vjNmFtOwryS/aZN4/2Npx75Eck6cL9UA2Y1k6
	oWE4UM7BocG6x1kwnvv78mXI68SJPPBrxpnnJRE8vszAX+ofBF+TEB68SEYuZyjAayeT
	jICA==
X-Gm-Message-State: APjAAAXyhCu0qRcCd47BUSM/68ohtZHR5h6/gTtHZDC0TqMScmjvRoyw
	WAmAlp0BGggTvb9PbSRpUw==
X-Google-Smtp-Source: APXvYqzHc8IGqtK8qwTQEGdiASgl2eUMIjgRvbQL2Qh2n/m2AHqfhQBym/p9gNm89vNXbzEz3CKSVw==
X-Received: by 2002:a6b:c98c:: with SMTP id z134mr562362iof.276.1562797881065; 
	Wed, 10 Jul 2019 15:31:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
	by smtp.googlemail.com with ESMTPSA id
	j25sm4997462ioj.67.2019.07.10.15.31.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 15:31:20 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH] iommu: io-pgtable: Drop WARN for empty PTEs on unmap
Date: Wed, 10 Jul 2019 16:31:19 -0600
Message-Id: <20190710223119.8151-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

If a region has been mapped sparsely (such as on page faults), the user
has to keep track of what was mapped or not in order to avoid warnings
when unmapping the entire region. Remove the WARN on empty PTEs to allow
unmapping sparsely mapped regions.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is needed for large (up to 1GB AIUI) scratch buffers on panfrost 
which are mapped on demand on GPU page faults and can be unmapped on 
memory pressure. Alternatively, I'd need to have a bitmap of mapped 
pages to track what is mapped or not. Dropping the WARN seems like a 
much simpler solution.

This will need to go thru the DRM tree once I've gotten the panfrost 
side finished, but wanted some early feedback.

Rob

 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e21efbc4459..43971638a5aa 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -611,7 +611,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
 	pte = READ_ONCE(*ptep);
-	if (WARN_ON(!pte))
+	if (!pte)
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
