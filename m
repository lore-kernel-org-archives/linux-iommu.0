Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88C2C10F13
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:04:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91ADE2184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KrxWIEik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91ADE2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3E192CF5;
	Fri, 12 Apr 2019 00:03:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6FA192491
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DFAC7F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:29 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id x61so6125589edc.9
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
	b=KrxWIEikxDdZvLu8UnFVjW0EcG/PU1SormZHDInUdtOAg+J8UeRfz2zXDqrYBYevOn
	JwyWhZgYwU6QtoPuE0mXZ1Oe5eYGnMUIagbCpUNbdwOBGj5GuTN3H7Op5ODJ3yxVBy4a
	HJv3vGEEQWldc4EKVLOm7+5le7P2BEiIWuDF1OhwdjSym2xlj9kWG98u6Ge2wHvP8QAZ
	tWipMQtzFYHT0eFwweBjtWhr2X29dn3Z6GXvM4PStsLb8BJAl2VsSyrgiCcO2JqfpiLQ
	mZIfb9bKl4Awxr45GpXcPVoobD3hUoYj2Adz7S2v77C2kyg4y/sYDgRpJl/SvI0brDXa
	u9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
	b=qblQ5AmZak9rCjq+6UpDKwzAinOvmTST5hT/FBWyD8sSk4MZxHjoRmLErOhgYg3oRD
	2xfZyCDWGZT+C4HrcMVkDsuIllV3ObuI/B08tGsGqz14XBaRQ2pMnZFlCJFCDeN568AN
	+dmqLO8ustdqQ8ZY5DC/73laHktTEgQ/uyh82gzCVsbTZMoab54oIM9ZxDbPIyz1Kp1j
	kauB/iXQhtebqnlKK15VnuekY5XVnj0GtUjW0QkUpU7Tdjc/HtZlgp/c+c2qhbqhhc0f
	8Qa/2Yc6XIByq3+ntUOjXz/csTm9QBmeQOvGgQzRbOMKDVwqV0fzRkf6cv4JkMQJ+pE5
	8Bfg==
X-Gm-Message-State: APjAAAWkfFJCG4s87yABODZ+Srx87hoBsIk5SV85bDMQbo262kLNHJX9
	5VPyiWvL3ekqeBxuCYgYc5ppbre+HGt0bjY1
X-Google-Smtp-Source: APXvYqxGXfYCaCRlvVgksxX9b5Eab0yr+jZV0UQmnyepRxSCDJinf+ClgjALBi9ceksiejLlB/1QXw==
X-Received: by 2002:a17:906:e285:: with SMTP id
	gg5mr27392064ejb.229.1555008568161; 
	Thu, 11 Apr 2019 11:49:28 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.49.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:49:27 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 9/9] iommu/amd: Add allocated domain to global list earlier
Date: Thu, 11 Apr 2019 19:47:38 +0100
Message-Id: <20190411184741.27540-10-tmurphy@arista.com>
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
Message-ID: <20190411184738.aGNKqN8KYPEaPjJcfBpQQO-SVy0GdsOLW_S8nIeYz3c@z>

dma_ops_domain_free() expects domain to be in a global list.
Arguably, could be called before protection_domain_init().

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 02b351834a3b..bfb021d656aa 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1801,8 +1801,12 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
+	if (protection_domain_init(domain)) {
+		kfree(domain);
+		return NULL;
+	}
+
+	add_domain_to_list(domain);
 
 	domain->mode = PAGE_MODE_3_LEVEL;
 	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1824,8 +1828,6 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 free_cookie:
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
