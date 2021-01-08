Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC1C433E9
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34B823A04
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B823A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E4D0875C7;
	Fri,  8 Jan 2021 15:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8mNxH+TdIboh; Fri,  8 Jan 2021 15:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2156487212;
	Fri,  8 Jan 2021 15:02:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB42C0891;
	Fri,  8 Jan 2021 15:02:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C84F5C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B4E1720412
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JyQuJNajmNjq for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 15:02:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by silver.osuosl.org (Postfix) with ESMTPS id 20B2120400
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:31 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id c124so8021128wma.5
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 07:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=41h/X6Gu0BzJgRbRM9QQpjc5Z6ZN0hh1kAZAdhlzV9w=;
 b=RlX7b6g0DkwZc+m95BXjRRb5yhQw1tW3eMWzBGsTi1W2i26GfA5VXP3Uj/nkoCrxkW
 9bFOAD2aNI17SaPaol5rAggXSOBjAoeyCwM9HlhYNr+EQ0VD8LNZ7jLs+mYhWLzf15gO
 0CNEYGbTvlsAhQt4CCecggdQZwsXkqOIoofNh0Tx53FkT0Musmi6ssFAwsJwWNRb75lY
 vV1qnqMnyY/YgvqETaA6tuvmbBl9VoisceSiPO4qOsHA1yqHP3bsH6ikQixKlZsF8c+V
 8B+WHadIiAk36NLpVS2bB2R727x+xOgIyC+eaCnMevGTm6s8CWTM7zK0WtOwuhZFGSVi
 QAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=41h/X6Gu0BzJgRbRM9QQpjc5Z6ZN0hh1kAZAdhlzV9w=;
 b=NZ5DGtFJTJJT4Ky3H6iwpRvfMXaYUTF8WSOAcBtnHU6Wr4YHBDYILOsDOq4CwojjWq
 c9IOsc+u1PkKJzlwUWDaYkkaZGEzYpGRW2zS0ebrO3mYKQD0uNOam8vLs5LEj38q3qKX
 eec7ZOZMvQ4NUWNZmelPDtb+vuWzWkaDR80DdM8t9FJFqYn/Jezjj8rPH/WMsYPtjuNv
 vm4z2LIIu9wx7rxqStqLORSQop2RDJ4T7vFE1OZ/bkvuANEW4YV1pDmpTOhmN0xbel3z
 IZZjiMtzMDm/nQFKaa4H2pz73whHFkxTxb1dxTz8HXqiJ6rLL6Np/CMyvvQOflu1dcQb
 1CcA==
X-Gm-Message-State: AOAM5304jbmkCLwJkNGmiBl4e796XQ1Z9Xad1/4/pRl8MtdOUh+AKtqP
 1SjC3ik4I8mNzEukn1f2AIGDNw==
X-Google-Smtp-Source: ABdhPJyvZ75UW2eHQKBLoStIviM99D9cMjiVtZ4n9hckO7Tk6QsCg3Df2ywgT7Ej7mDpRaNF07oKYQ==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr3405367wmb.144.1610118149405; 
 Fri, 08 Jan 2021 07:02:29 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 07:02:28 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v9 01/10] iommu: Remove obsolete comment
Date: Fri,  8 Jan 2021 15:52:09 +0100
Message-Id: <20210108145217.2254447-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
dev_iommu") removed iommu_priv from fwspec. Update the struct doc.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3f0e2018c62..26bcde5e7746 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -570,7 +570,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
