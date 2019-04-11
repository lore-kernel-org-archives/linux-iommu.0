Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90CBC10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB662184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Kz0209+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB662184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C95CA2CF4;
	Fri, 12 Apr 2019 00:03:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 165492A5D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8FF3163D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:08 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id s39so6160305edb.2
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=0ptM0TW5MEf0wZjhcNVg+kVepdW4r8Z6tyROfJJShQo=;
	b=Kz0209+sKNZfmB0yWwNPjjrMA+GYb4rsz3YQ+7qzCBKV0K8VKU+rELf+Zl1rDwGfGG
	UDqhVf2LzXA6K1Mp+V7RE4dqFrJsHX5w+JbTNVOgDNMqnsvq1/Svzxa1O30Nwx4bNza7
	xhOejAKAbe35ytPwR0TZVkNIacGaIechwtfh4zN2DCFIKQ4M9BguB3dgKppQ9rukI4fk
	jwu4Kh6E1Kp4KE4cvVyzWTm9dLB+7BauhZN2nsIMnKgsjVX0U/GpqN2Ak+4MJtwQ7Rct
	vag21Of0Bv8JJEz+PXrI7LQkFSMnYl4wWcIJZDQCt3rzHh/G7O3Wjvfv8J/dr1KSZ6iE
	ULLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=0ptM0TW5MEf0wZjhcNVg+kVepdW4r8Z6tyROfJJShQo=;
	b=LXs1hUtajvCt6aYscHZCinNpIWVgtsIVmM/GvLN+zwZwQ4ZwhifUF5j0iBQ24HnC7u
	0VxjkANg7eTUCaC+Rrnk+qudrd5LvrITyeRwr/WFiLy0GRSjOl8uEfNSv0qSzqFxuvXN
	qmzBPGYxsmotwPd8wSHSPMXWKJMpkt2FPbaGDFkbgRxGhNAxr3g5SjOKWhz8Bx9X/XlH
	UEmY1fkAcED6EjQe2D593WFIOTc5ZO8Vbim0cWWF/qGhNrOsZaahLNyv6pyK79L2OLIg
	3aNUPXQkbUeE3qzCwNNFGzwWHQ43PiEqq/AbILsdGCTO8OjjQSao9nvhsrZNu1Iu/7OH
	uFXA==
X-Gm-Message-State: APjAAAXzmKiolzK8l966WUy76NdRc4oUveF5lPiySHbWeT+WlgJw2mrr
	iqi27tzl4NJkW6P1QEjPB6drBmxAk3+aj1oM
X-Google-Smtp-Source: APXvYqxPgBo+MMzWroNLnpmi2H77XJDBCOGidMozjjYD68K8alQvz4uZiMPtc7ZU8Kl0PrPPn+MeYg==
X-Received: by 2002:a05:6402:558:: with SMTP id
	i24mr26522920edx.51.1555008547040; 
	Thu, 11 Apr 2019 11:49:07 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.49.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:49:06 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
Date: Thu, 11 Apr 2019 19:47:34 +0100
Message-Id: <20190411184741.27540-6-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
X-Mailman-Approved-At: Fri, 12 Apr 2019 00:02:45 +0000
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	linux-samsung-soc@vger.kernel.org, dima@arista.com,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <20190411184734.RY0KQtn5t0rhtAspZ92vaUI6cmYLvEUlqHSNdDr8JVI@z>

Implement flush_np_cache for the AMD iommu driver. This allows the amd
iommu non present cache to be flushed if amd_iommu_np_cache is set.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b319e51c379b..2d4ee10626b4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1319,6 +1319,18 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
+static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
+		unsigned long iova, size_t size)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(dom, iova, size);
+		domain_flush_complete(dom);
+	}
+}
+
+
 /****************************************************************************
  *
  * The functions below are used the create the page table mappings for
@@ -3263,6 +3275,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_range_add = amd_iommu_iotlb_range_add,
 	.iotlb_sync = amd_iommu_flush_iotlb_all,
+	.flush_np_cache = amd_iommu_flush_np_cache,
 };
 
 /*****************************************************************************
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
