Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CFEC433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 16:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90D50607F0;
	Tue, 23 Nov 2021 16:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCI8hU3Kw3nV; Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E504606D6;
	Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63658C001E;
	Tue, 23 Nov 2021 16:11:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57BCEC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E2C780D80
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3J6KadzZ-G8 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 16:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8117C80D35
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637683860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E71mUjFY3RjWM0HIP3/hcl3zs2J0xxW42+7wzc1Wnwo=;
 b=KBTJu/GxHHlkgF8XMSpJc87Uz8TUJXw/HQ1LM0+/KNxk76wUm0VaQOJrdPXxxjO+D3JA9F
 58yNqxgTk6ky6ix0xJdy6gI/Qxy1eRFqIbZ3Y/TxDCUGzWvsRd4tu8hXyN4ciK8JNlsvYd
 LlVKWT7bEo4+fYQT0OWBnm/aeemqzWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-jDM9JcWvOpS_pGRmvPtOxA-1; Tue, 23 Nov 2021 11:10:59 -0500
X-MC-Unique: jDM9JcWvOpS_pGRmvPtOxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 081808799EB;
 Tue, 23 Nov 2021 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8C5560843;
 Tue, 23 Nov 2021 16:10:55 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu/amd: remove useless irq affinity notifier
Date: Tue, 23 Nov 2021 18:10:38 +0200
Message-Id: <20211123161038.48009-6-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
 "open list:AMD IOMMU AMD-VI" <iommu@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
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

iommu->intcapxt_notify field is no longer used
after a switch to a separate domain was done

Fixes: d1adcfbb520c ("iommu/amd: Fix IOMMU interrupt generation in X2APIC mode")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 867535eb0ce97..ffc89c4fb1205 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -645,8 +645,6 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 #endif
-	/* IRQ notifier for IntCapXT interrupt */
-	struct irq_affinity_notify intcapxt_notify;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
