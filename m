Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD057C433E9
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:28:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC58206C0
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="wecxpxww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC58206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FE3C86C8A;
	Thu,  3 Sep 2020 20:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kryGraoWlPZ7; Thu,  3 Sep 2020 20:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 029BF86C7C;
	Thu,  3 Sep 2020 20:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFEA8C07FF;
	Thu,  3 Sep 2020 20:28:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F640C0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0E715873C1
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MSCJ+x6Qy1Sl for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:27:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 352E587275
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:27:56 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id 31so3006785pgy.13
 for <iommu@lists.linux-foundation.org>; Thu, 03 Sep 2020 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N5xig/eTqVrazs7e7noSaKBykCte9+bRmMrk95HOd24=;
 b=wecxpxwwyD4RACE8f0yMWLaLTMryAoXTP9h88/wYvuUBUm80bCYV+6ZiYhUIbjqLLE
 TigkzxOwLmWyZ/1vLfLLeAUiFuE3vLPiKMLZ6eXOqmCbWjPH+w2xoknPPrzWsciA9a6A
 i7TwS1XR8fMZ4e5Wwqq22coetU+ufEPNJh+c9+cDIS1nKLMhVJmM2FzX60EbkuT2tsLK
 u5l0PPrGgVdnEFbXyWqzrlAWK4SzmshJ0qoyDZ1zJ2bGR6GJd9y7WgG3nMwPGLs+XQLL
 wkZ5sEExMHJfvjYDX2qFsm1ucLLrIf6ASBAaXrhD2kKAQUzmiapoZVvcJreUNP5GQw6p
 hWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N5xig/eTqVrazs7e7noSaKBykCte9+bRmMrk95HOd24=;
 b=cfa2hfW8sZKzC5ayIaTwfmYKVppRrZRK4SXUGInwnlgt5+YrN9gfqzOxl+th3fmjmE
 5D1PYjfpp2gvtSlWtO/r2n5ooU/efW4FLIE6o7lfbLdWA14C1+o89izPKbfwIfc8CX82
 PK4iiPfjfZAeuKumnr6zW0+VpaVZZW3Z6dASAQoogJiaAec9l5Uk2A60lxO7HyrK1Vmq
 CuH0j14vCENoEdg5DUD4t5AU/4b5wr2DrlabVhdCw5iOplfRGy5aU95YnxaBvAB/K5pt
 gKRFhTQS4h2pi79gvmAdx3SAbayQ0da1SSo4spGEb6HSwW0TQNyuFkrj/pfpmkOgEBte
 LDUg==
X-Gm-Message-State: AOAM531SU9UciKlSSzQ9UmvwPztYC2uV86i86gjZHzXCehqLy14vPYeV
 GxRZz69kGEpI3UlyI9dWnpY00mmSqHSz/Q==
X-Google-Smtp-Source: ABdhPJwiVInAfEsPvAgHLbKg3L1qPZ9rU80DohPCbod5K6Hz/NSBEO+ccupDTKR20VfP+qt2/IonUw==
X-Received: by 2002:a0c:dc90:: with SMTP id n16mr4670097qvk.168.1599164385283; 
 Thu, 03 Sep 2020 13:19:45 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home
 (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
 by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:19:44 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2 2/5] iommu: Add iommu_dma_free_cpu_cached_iovas function
Date: Thu,  3 Sep 2020 21:18:34 +0100
Message-Id: <20200903201839.7327-3-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

to dma-iommu ops

Add a iommu_dma_free_cpu_cached_iovas function to allow drivers which
use the dma-iommu ops to free cached cpu iovas.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 include/linux/dma-iommu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f69dc9467d71..33f3f4f5edc5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,15 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+
+	free_cpu_cached_iovas(cpu, iovad);
+}
+
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21f73d8..316d22a4a860 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
