Return-Path: <SRS0=Oi6h=23=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12535C33C8C
	for <iommu@archiver.kernel.org>; Mon,  6 Jan 2020 15:27:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA0B207FD
	for <iommu@archiver.kernel.org>; Mon,  6 Jan 2020 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DsPu+SD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA0B207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8DC11204D3;
	Mon,  6 Jan 2020 15:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dR9wUGdDK4fo; Mon,  6 Jan 2020 15:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CC3A620119;
	Mon,  6 Jan 2020 15:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD721C1D84;
	Mon,  6 Jan 2020 15:27:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01CF2C0881
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 15:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F270384854
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 15:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k3etQ+ZW-cn5 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jan 2020 15:27:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4F82F847D9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jan 2020 15:27:39 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id w127so39705921qkb.11
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jan 2020 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EFnpNY+6QaoLE3QL0daZSOcFms2OzGtmAouUn+Z/oVc=;
 b=DsPu+SD2lOfczXptpS0IMN16HQIFVV9+QMxOZ2iDWyHPWcgFyZKhupGFKDnYdPvKb/
 GI7aEfCS5r8YkNaHLaIKjfRsDE9rCssKskjnqtp3UnpFGqcFnIdYvLTWHs1vUkBTVjG6
 yG8I9Kl9AjqqOyaf+IAS+EINi61EBVwEk6Xj8n3tT1XneH7pk2sQ5qFkvB73YFiVr3jO
 +nLBfK/p4Fv12xb+MjV2H0c231T6yGyeowOVhN4Fg8kSHukx4iHJd6+wfxZPzscCXrtv
 qoSSuWXOHxaare3odrncmLp1/Ub4QJ+qBLaMAg4e8ztbRfsuCGDDSDyg0lYJUqWhGxh5
 xPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EFnpNY+6QaoLE3QL0daZSOcFms2OzGtmAouUn+Z/oVc=;
 b=W88mEpBo7N/avWg/XAtqeQfuAli9P1TTAkDo1zRp5qB6wRJrJUd1naxKuBss2fIvg6
 1aLescFEPrKUAkUoRkEG7rVKdhj49cgI1JD7e3SLI9zvWBDqBjycT0yLTFl7Ay32p69d
 hvTkyI9LoRj9jKokQauqUJBQ1eDSoBhwwiuhGwOw4rdlTSOi1C1e84YDgxiNuwuiZaGb
 4g7Jdjif40zgPZ09Q0V/K8qCbzh/6enKTlvvHAJzDaIJYLNch6STVhIscd5x7vJZQs2d
 RVRfa9xWHuavY17ILuaSyYjvqgq/VITKU/QtReKOzSwd5Ka2SIPtcrUHbcqPpYyC5n3s
 533g==
X-Gm-Message-State: APjAAAWNsx1LMFBzyPlJtca3Ha5JF4S22gNJBw6bn+y6HiMvwpOsZ0IU
 Sq6CWlK8NXRaCAj4LMBWFkIFDg==
X-Google-Smtp-Source: APXvYqzfojOxjHxLFLBXN8zM7+ZD66O2Wx2gD4w5lRbMNdGv7OEevDWI5WnfDzJwZBY8yMi2hNt69A==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr77776178qkg.489.1578324458269; 
 Mon, 06 Jan 2020 07:27:38 -0800 (PST)
Received: from ovpn-121-70.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id f23sm20757695qke.104.2020.01.06.07.27.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jan 2020 07:27:37 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu/dma: fix variable 'cookie' set but not used
Date: Mon,  6 Jan 2020 10:27:27 -0500
Message-Id: <20200106152727.1589-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
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

The commit c18647900ec8 ("iommu/dma: Relax locking in
iommu_dma_prepare_msi()") introduced a compliation warning,

drivers/iommu/dma-iommu.c: In function 'iommu_dma_prepare_msi':
drivers/iommu/dma-iommu.c:1206:27: warning: variable 'cookie' set but
not used [-Wunused-but-set-variable]
  struct iommu_dma_cookie *cookie;
                           ^~~~~~

Fixes: c18647900ec8 ("iommu/dma: Relax locking in iommu_dma_prepare_msi()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/dma-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c363294b3bb9..a2e96a5fd9a7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1203,7 +1203,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_dma_cookie *cookie;
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1212,8 +1211,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 	}
 
-	cookie = domain->iova_cookie;
-
 	/*
 	 * In fact the whole prepare operation should already be serialised by
 	 * irq_domain_mutex further up the callchain, but that's pretty subtle
-- 
2.21.0 (Apple Git-122.2)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
