Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8DC31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 22:05:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253CF21473
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="Mo5DuFV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253CF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DA038EAF;
	Thu, 13 Jun 2019 22:05:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 26770EAE
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 22:05:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F085A711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 22:05:15 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id p15so384985eds.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+8FvL87Ik+dUxncoVW6eXP+WAOS+Kbo5uxd7wggC77c=;
	b=Mo5DuFV4W+iqjVJHcaknEsCoQX+9r9R3zkQZn92xWa05rjFhhkC0HtClNh4vf71yy8
	nby6fhcDhR8VsAd7ZPwydTtJgdbnXiLYbbfT0JM9g7Ntp8qz9yxbZ+cjEvktrR/9ErsF
	rr7cbJqNEqC0GZ2uv7Msi0fwVmBsGgXqZsDHKF3V7RWq1znSnzINiITvElO9BaXA4J5m
	MCv9yuVn+IUyfIeZJCmorxS8maTflpd2d7t8VKW4MQmd8b7JR2sYDUP3+zVuetFaTg0y
	+SGBQ7RyKF3YQFlqsD+HhU5gAssHvs6O2yPrAEhkMKNkV/QGhXxhznwljopC2Sgbaax/
	I+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=+8FvL87Ik+dUxncoVW6eXP+WAOS+Kbo5uxd7wggC77c=;
	b=etIlUJY/Gs80dSsm5SCPS+QWFr+G2pH/RpDdQJUUifvsEL7McJH36pn5XLP1aG1Mgc
	b26iYwz6N3AN4i/N6J1S0H7SY8jolx+4kBhmmLlE4/f2GUQTzqn2tZ58eTYe6n5a3qfI
	vBEwjaU8aDDwSCSxZMkbI7jqhMXjVbTszmbLfPNIX1OU21XhIAw+lBi5zWOXPo3jFKTI
	XIfdbA4ijSLFnc8ZqxSdMY0dqRa9PSNTgd4b+o4hSWIgDVv5MMrb6bS5iHBFIEPSfQdz
	4ScQCCwEWVgGUFUlV/mtOsTfXxjvmL2ef+lB1Iyg4RV5O4Unnf8cSqJBUR5EdWLDnmRJ
	8A/g==
X-Gm-Message-State: APjAAAX5XnMaNbPynBpv5/gtMemnUAM/fjBYyn2K6HiYo8pFSGNQyBlV
	VXZoexylDdZVS+oxsh23xqXM59tZnu+OhQ==
X-Google-Smtp-Source: APXvYqzRh8XRpIEzGGrVqaF3sGuE8RkE68bfw601NWT0H/WwJBa9FMPJcilB7GxE0YJ1BE/C6buV5g==
X-Received: by 2002:a17:906:2641:: with SMTP id i1mr1020153ejc.9.1560463514055;
	Thu, 13 Jun 2019 15:05:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:8042:d435:a754:1f22])
	by smtp.googlemail.com with ESMTPSA id
	c26sm272089edb.40.2019.06.13.15.05.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 13 Jun 2019 15:05:13 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3] iommu/amd: Flush not present cache in iommu_map_page
Date: Thu, 13 Jun 2019 23:04:55 +0100
Message-Id: <20190613220455.6599-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
v3:
--applied Qian Cai's "iommu/amd: fix a null-ptr-deref in map_sg()" fix

 drivers/iommu/amd_iommu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f5d4a0011d25..73740b969e62 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1295,6 +1295,16 @@ static void domain_flush_complete(struct protection_domain *domain)
 	}
 }
 
+/* Flush the not present cache if it exists */
+static void domain_flush_np_cache(struct protection_domain *domain,
+		dma_addr_t iova, size_t size)
+{
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(domain, iova, size);
+		domain_flush_complete(domain);
+	}
+}
+
 
 /*
  * This function flushes the DTEs for all devices in domain
@@ -2377,10 +2387,7 @@ static dma_addr_t __map_single(struct device *dev,
 	}
 	address += offset;
 
-	if (unlikely(amd_iommu_np_cache)) {
-		domain_flush_pages(&dma_dom->domain, address, size);
-		domain_flush_complete(&dma_dom->domain);
-	}
+	domain_flush_np_cache(&dma_dom->domain, address, size);
 
 out:
 	return address;
@@ -2559,6 +2566,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		s->dma_length   = s->length;
 	}
 
+	if (s)
+		domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+
 	return nelems;
 
 out_unmap:
@@ -3039,6 +3049,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
 	mutex_unlock(&domain->api_lock);
 
+	domain_flush_np_cache(domain, iova, page_size);
+
 	return ret;
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
