Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE75C433DF
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADB3208B8
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JW/LxFcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADB3208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C324F88906;
	Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iz9Vsc+4wgzs; Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06B63888D3;
	Thu, 18 Jun 2020 15:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC84DC088C;
	Thu, 18 Jun 2020 15:52:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 854D3C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 81A7A876DA
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ziWWgi2blxfI for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:52:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 96E7687171
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:52:41 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id d15so5225342edm.10
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yTcZ/yCb5ZAy6PQyVCfw2AueTEndBOUdt4lrv7Qejz4=;
 b=JW/LxFcIwVMI0FUMp2Hp5J9IV4CbwtAZdbhqoRMEX3idf6gsNu+wnpKU+K3PCkEzT8
 Z3hEEF3Lg+SzSDaBz8tcAqxQjhy71Hu/Nh7PPuiPBeASjeLBJqrfF5i7bXMkwYa+eigH
 8+Y0YMlZi4ZiOEFSBA3y9zy+M2LQWPS8nlsoOCRjNS4B97KfnIBhcC8uZYIvrZkmkCXZ
 fy4O/KVuDHT8KFgHZkRQkJ1/cOE6bXgfZT9ug04N9mAHyTmklDntEvl1BaNCOX6gnZO9
 laYmc4vN5AFc+ATfGfVf5zHp5iPGL+9By9clhNoZNcyQO2BWBFKRiJtia49h75bNu6W8
 +pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yTcZ/yCb5ZAy6PQyVCfw2AueTEndBOUdt4lrv7Qejz4=;
 b=OyuNs7OpYHn75TGdR5+E3hMKrnCSrDcv+uoaif1eQgaArVm/D5jCbJh3rc4HeJknYF
 qjr/+RRHkeQl8sibdjlSnLD/oTdDbMafGoF08s5N8GdB/NjeIZmpfh9beSsZz3xvZwxb
 G0mnkAMKvPXvcDBUdW1P5ORYa/IL4fGfZ/OJyrGMJjFwtUe1fqowJ8h6jXKhe8YVdW03
 KW4iQGlYgjwG58loybZ5a2Rp9OweSTi7sprHHzXUtwZjQgZGPQHEbrsXhyrO4QS9uJnX
 bIx+O1YtaaIqA0a5blTVEHB09oyEQ/Kvuj4/MQpUhq1x89LW6Eb9v9feR8cCFqEfXJjU
 usYg==
X-Gm-Message-State: AOAM530wOpua+ej19q6V0UphQCWCBtC0dQwrmXqujsk7F9+HC5iM1Bbs
 QRQJOPmZxsqI5e98mQhlw1hTj5I2B2cMwA==
X-Google-Smtp-Source: ABdhPJyr+YsmKXyyVo8ML8+oCnbztzhK2ZSjk0S597/jP9A5VGpW8hFIgvZu6EuzmCv59bIsyCybEw==
X-Received: by 2002:aa7:c908:: with SMTP id b8mr4725695edt.76.1592495559755;
 Thu, 18 Jun 2020 08:52:39 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 63sm2402267edy.8.2020.06.18.08.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 08:52:39 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v8 01/12] mm: Define pasid in mm
Date: Thu, 18 Jun 2020 17:51:14 +0200
Message-Id: <20200618155125.1548969-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618155125.1548969-1-jean-philippe@linaro.org>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 hch@infradead.org, zhengxiang9@huawei.com, Tony Luck <tony.luck@intel.com>,
 Christoph Hellwig <hch@infradeed.org>, zhangfei.gao@linaro.org,
 will@kernel.org
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

Suggested-by: Christoph Hellwig <hch@infradeed.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
https://lore.kernel.org/linux-iommu/1592418233-17762-9-git-send-email-fenghua.yu@intel.com/
---
 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64ede5f150dc5..1ad0e54ebbbaa 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -538,6 +538,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+#ifdef CONFIG_IOMMU_SUPPORT
+		unsigned int pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
