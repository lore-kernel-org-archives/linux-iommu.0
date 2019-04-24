Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C10C282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EAC218FE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MZCe//Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EAC218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9C66B137D;
	Wed, 24 Apr 2019 14:20:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DAF961378
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:20:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 578CAF4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:20:04 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id k45so16091837edb.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id;
	bh=GEXaBMD3U4sWuwXoHlsxPa0R20Q7P10dRF3KDQL2tvo=;
	b=MZCe//Am5X21XLFVYlr3pytX7fCBJ/q1M912/aF3gzt4UqSFUTgrB26DmfRZYqceQg
	ygy/yVUZWBxf8ANuZE1PuNElLSzIaZbCIEpWYbP06zULQ4fX5tKg2wOTL0a1fwJ3qUW3
	ok/Zr+2hDDlnIP+y1tFT51fKLh1DCYiw59PETX6diQDrGd8nKeveMN016v/vbZFXqWML
	BSTQVwx0kDW7Ma0T9wVtKm7GiNxNScSDGYfHxZVm1U6aqFLgbIqYoayPy66QFWxaMc2j
	I0r0NSmw29K0e7nY06nyM0Ja5ZATnurmdkCgnNWs/gn32j3oOqpIXitKVpuU+EF1xZmc
	t63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GEXaBMD3U4sWuwXoHlsxPa0R20Q7P10dRF3KDQL2tvo=;
	b=IDIDwkbnD00CL6tfQMUA3c9xANxFhZfN7f2Yz84NtmqwqftG55dhaakZqgfhLkMANe
	BWgwwbr6SzIO1pSj44OYBhlnKXWfn70MR0tsgWyV6ttlfilY7FwV62hXY2YoQDkXMFbC
	ZkGx9H3upYrOhmOvcy8kRSXstLztZ8nPrL56fnRh5tH6E9j1ABr0mNBrWGw0Hv3DVDeJ
	gkjVQxZk1eqaTqGB7l2X2vLsSCEpnpMWkYoQgWEXyRbmcRPS1aBROsuH4KAQkn3F+/w3
	wzxsLuZ+qej8gfbo7XxuSviZsTOJ4uzmfq95/7VFBBofyLq2q4vitybxJPZ8Z3EN76Uq
	z0ew==
X-Gm-Message-State: APjAAAUEQkFz2FPULYQA5pe5ONfQQBz36Ukkl2EjWC7Z5uG5h8dgexTS
	D4CKo+TwSld+IRkQdKWsRmGhqzxy+bGbig==
X-Google-Smtp-Source: APXvYqxQoWkEWkvX0AnpeUvXGVH2qnp8HAFlWH0AjCbnHDYypkrpxh2W0ZiM0+baEcssjpVT7UdWEA==
X-Received: by 2002:aa7:d50a:: with SMTP id y10mr20113750edq.261.1556115602709;
	Wed, 24 Apr 2019 07:20:02 -0700 (PDT)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([89.100.89.87])
	by smtp.gmail.com with ESMTPSA id
	r24sm1582159ejo.84.2019.04.24.07.20.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 07:20:02 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Date: Wed, 24 Apr 2019 15:18:59 +0100
Message-Id: <20190424141900.8883-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Cc: Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424141859.vdbFTNvRrwzEkOUqV1gtm0OocC0ojeoatkxJbpnVU84@z>

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..8ef43224aae0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
 		pte[i] = __pte;
 
 	update_domain(dom);
+	if (!dom->updated) {
+		if (unlikely(amd_iommu_np_cache)) {
+			domain_flush_pages(dom, bus_addr, page_size);
+			domain_flush_complete(dom);
+		}
+	}
 
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
