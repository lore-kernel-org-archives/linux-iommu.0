Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12041C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FBE2166E
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK7F3ESU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FBE2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 67B4D4712;
	Thu, 29 Aug 2019 11:18:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 749644692;
	Thu, 29 Aug 2019 11:17:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B73E23D0;
	Thu, 29 Aug 2019 11:17:57 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id s49so3675718edb.1;
	Thu, 29 Aug 2019 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fWFDdsSRIYNKrRBdDSN7KSj6FUeTwnbHluq8rixbTiU=;
	b=QK7F3ESU41SJHkKfAxVhUhnoObCMRcjDeVy8XBXAejYxpeOt+AeNnLB5DhxnGzPZTP
	2SVCtoiYV0imTE3QaoiCdK93Uwz0ghTmT7C4bje7vpBjSbEj461Af+y8MbSZYrnR6OJc
	90jH6lwG2R68n8P70gZi9ZMrBnrrvn3X/lr7gT8ZcpnVRJWvoUB3IsrVky/rmi5AEBSW
	uWKkPfVSMlrHQs78MPEAgySdqXX9uf6SRW4UXQWzrh58WYWx7THUHN3dpksbqXawdh+D
	SVcbZtPGdWRnNhIS7772iNUia2YtTK4d3vb0INvBEj7VNgQecAAkl7abEQ0zMCnH3ec2
	RGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fWFDdsSRIYNKrRBdDSN7KSj6FUeTwnbHluq8rixbTiU=;
	b=RpVGEXIaKMDzS4qW+LQU1919qBWFupvMk+Z/fUlqBJaUZnXm6WsEK//RWzLhr0CG1r
	HHiBMTQzSnIKKi29Fd2qzDN3v2wrGXuRxt2dFKpNdK2ZrdQ7EvikECd+XYNf08m2G3zq
	mhmYK3VQa7b94XXkdjuW0cjC9FnhHUESNdA5dXRCMmL2gzG0yDHWwFblTG22hBreZ0Oy
	bynNWTN3yeJZt3P6xW0kJjB+SSzzJRuDGTu1cVrVbUabyLmjG3MNzNHB67d2F5TdrQnV
	g+G3IuoXwMR3M1fqrvne2ASowVAG89zKOxwMJ07SITEqe8aLEEK0PdQb0JqQlZtUGke6
	eCww==
X-Gm-Message-State: APjAAAVpvOWzdlZ+JJFnsRAU0H77yer6HA5E+bo73i6TJyd2rxffIe0g
	uDVRCmrXbi+QMYVAkCPDM7Q=
X-Google-Smtp-Source: APXvYqwUQQWr7opeC82ffN614dN4qfpRwQm9wEqpQ2QRcIIdZGIO8kDGPJZeUP/x70eq+7DhXC+pxw==
X-Received: by 2002:a50:c19a:: with SMTP id m26mr9023066edf.184.1567077476308; 
	Thu, 29 Aug 2019 04:17:56 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
	by smtp.gmail.com with ESMTPSA id a16sm341890ejr.10.2019.08.29.04.17.54
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 29 Aug 2019 04:17:54 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Thu, 29 Aug 2019 13:17:48 +0200
Message-Id: <20190829111752.17513-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Implement a generic function for removing reserved regions. This can be
used by drivers that don't do anything fancy with these regions other
than allocating memory for them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0f585b614657..73a2a6b13507 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+/**
+ * iommu_put_resv_regions_simple - Reserved region driver helper
+ * @dev: device for which to free reserved regions
+ * @list: reserved region list for device
+ *
+ * IOMMU drivers can use this to implement their .put_resv_regions() callback
+ * for simple reservations. Memory allocated for each reserved region will be
+ * freed. If an IOMMU driver allocates additional resources per region, it is
+ * going to have to implement a custom callback.
+ */
+void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, list, list)
+		kfree(entry);
+}
+EXPORT_SYMBOL(iommu_put_resv_regions_simple);
+
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
 						  enum iommu_resv_type type)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29bac5345563..d9c91e37ac2e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -434,6 +434,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
+extern void iommu_put_resv_regions_simple(struct device *dev,
+					  struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern void iommu_set_default_passthrough(bool cmd_line);
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
