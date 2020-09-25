Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD6BC4727E
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 16:31:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B0421D7A
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 16:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEyhJR/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B0421D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 73CA686E54;
	Fri, 25 Sep 2020 16:31:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9tQYEPGAPX1; Fri, 25 Sep 2020 16:31:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FEA286E4A;
	Fri, 25 Sep 2020 16:31:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BAB4C0890;
	Fri, 25 Sep 2020 16:31:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5107CC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 16:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B21220474
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 16:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UPLneUHkeTTP for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 16:30:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 5C5E72E178
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 16:30:58 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id mm21so2088336pjb.4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cd/kUvj/qKVGHAwJBYWnGQx2hf0aCQ0hRurRYYSX7es=;
 b=mEyhJR/g4bpYOqOqLHkx9hTMsIrcV6XsQQ/dluoM6FLGbRiEfjlPj0muZL7l2KG8Gf
 URx8O7SWHcoO8Y0I/TMqbENKaJrrnl1bTjdrXcFhtIkCgqUQzePd+p8iuZokm0aSD4FD
 2DJNX3cgR6/IfzNH9LD9b2MVOuynLyzPT1jZP46wrpuYM+/LLjgzMtRWOH5vqroBzT39
 XYXchQ/SGD5KCIzXPJw3TY6qvoMRlVvKibgxFbL03s6guKi+k7ThyK+ItHATLlJlGF2J
 B/PmW4gM1xl/V6sBs5qCdnTr758rZvivvb50bS8CQzxwTKfn5y4tw5fo70JG/HTBNyQa
 XCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cd/kUvj/qKVGHAwJBYWnGQx2hf0aCQ0hRurRYYSX7es=;
 b=FvG7K02PeWdz1enNH7UuR43S2p+WV5COXe0zcjF7ReBIgQJ8/IEId3uNUYoU4C3emu
 n9yW4z4FFECHVz0pp8EEfg5+AXvRzrMbx48r7eaNdLQvk5rmAKcCfiNxV8SWBZrBJWk4
 16/KdjguzFAQjICujbiDCHngQty6ug7+keHUTlXIAwdDcidEgzVNk40631SxMoibAaKn
 9RihW7XpKa288UF1MTsqfMm9kSeb1EJFIVgPhlrpPiX+mbelc6yoCnAxOMXbB2T4jsqN
 pUFqi9GaUKNCMWLxBgw0hbPEq3lno6mKUVzBK+BJPwDXFNQMCbcFZED6W2NwTEWJd3ui
 /y1A==
X-Gm-Message-State: AOAM533x7swQ+sGsXn0Rxh07BwE2//yDh/T9px2Plp40lJDAREbnv/6d
 ZywnnEO3dWZvHxRSsxAtvrzbLB9UDgE=
X-Google-Smtp-Source: ABdhPJw6UL9hmqrnjlCDvc41ADveJVcPkXo6NCtVnPBZg+wXnaqQrixGC7KcCICoC/T3BvUmunFr0A==
X-Received: by 2002:a17:90b:fc4:: with SMTP id
 gd4mr376733pjb.129.1601051457680; 
 Fri, 25 Sep 2020 09:30:57 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id j19sm3197039pfe.108.2020.09.25.09.30.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Sep 2020 09:30:57 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v12 4/6] iommu/uapi: Rename uapi functions
Date: Fri, 25 Sep 2020 09:32:45 -0700
Message-Id: <1601051567-54787-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Yi Sun <yi.y.sun@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Wu Hao <hao.wu@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

User APIs such as iommu_sva_unbind_gpasid() may also be used by the
kernel. Since we introduced user pointer to the UAPI functions,
in-kernel callers cannot share the same APIs. In-kernel callers are also
trusted, there is no need to validate the data.

We plan to have two flavors of the same API functions, one called
through ioctls, carrying a user pointer and one called directly with
valid IOMMU UAPI structs. To differentiate both, let's rename existing
functions with an iommu_uapi_ prefix.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 18 +++++++++---------
 include/linux/iommu.h | 31 ++++++++++++++++---------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..4ae02291ccc2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1961,35 +1961,35 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
-int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-			   struct iommu_cache_invalidate_info *inv_info)
+int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+				struct iommu_cache_invalidate_info *inv_info)
 {
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
 	return domain->ops->cache_invalidate(domain, dev, inv_info);
 }
-EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
+EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-			   struct device *dev, struct iommu_gpasid_bind_data *data)
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+			       struct device *dev, struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_bind_gpasid(domain, dev, data);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 ioasid_t pasid)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_unbind_gpasid(dev, pasid);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..710d5d2691eb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -424,13 +424,13 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_cache_invalidate(struct iommu_domain *domain,
-				  struct device *dev,
-				  struct iommu_cache_invalidate_info *inv_info);
-extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-		struct device *dev, struct iommu_gpasid_bind_data *data);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+				       struct device *dev,
+				       struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+				      struct device *dev, struct iommu_gpasid_bind_data *data);
+extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1032,21 +1032,22 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int
-iommu_cache_invalidate(struct iommu_domain *domain,
-		       struct device *dev,
-		       struct iommu_cache_invalidate_info *inv_info)
+static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+					      struct device *dev,
+					      struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
-static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-				struct device *dev, struct iommu_gpasid_bind_data *data)
+
+static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+					     struct device *dev,
+					     struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
 
-static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					       struct device *dev, int pasid)
 {
 	return -ENODEV;
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
