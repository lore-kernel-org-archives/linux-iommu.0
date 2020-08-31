Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB25C433E6
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B604208DB
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHxzjZCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B604208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 346C786FE8;
	Mon, 31 Aug 2020 18:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTdZoO212kn3; Mon, 31 Aug 2020 18:18:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9F58486981;
	Mon, 31 Aug 2020 18:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89112C07FF;
	Mon, 31 Aug 2020 18:18:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DDF8C0891
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 49C5F85E0B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLMVZFh27W3e for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 18:18:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E822A85D61
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 18:18:13 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id t9so1029114pfq.8
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
 b=kHxzjZCXYMea/x9JBKFQZJIIwC4UW7+yFq2ErH/2JZTRVJ2TmrTNe/pu4woCCdontK
 e82K69jpQqFSzZyUF/UkHYaINhdKsGCxsYD2upc8oqhrc05eJJwQRV8urVNGrW+VEWk7
 86+qxT+PpRMsqo/3OGGS0Hd4tOkNMZROH48VnOw+NIsaJ+dtlJEFYlgKhe8j/NzVcZck
 Z0MlnPN5+3DHP7aTUbzq9NOFZEMq2MD3AN4YKUYEmJjN2CCAzvoKLPfJXki8muHw1lw6
 oxdPPmnmnX/cA0y+XbwHF/lRtJSCQuDi5vFg4Ww8TJ63E3Dj9nQcHRe7SU8eX6UQbkVG
 qQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
 b=Rzlv6EvDaVpru0lJT0ago3qRi8/9waVATKUbrYvnlO+xgWCrbaG8k71AKPF6wRRMrc
 N74P64jtbEfCwxsoTK22pHzE1hCsMPolENnfFt8Ck7Wjw/p5AGibj1E9d//2/LLtsiCo
 3wsc2wiXefAHKA5dhnYDc4KqdHMXxolU5kN2uWi5nin4JqhEV5HsyOoHsxuog5500nM6
 KX+g6fX/KI8nme1jznTVI0/TAQFblrrPBdZrPcSfuleQP6CPngh6zM9snqttB1e3izR/
 5mPiuhut9mvsy76RkxEQMss9zvDG+GmzyUPnqAyS3EIL3Jq9NsSU7/20i2OIB/vpD84j
 zMFQ==
X-Gm-Message-State: AOAM531eRkPUFfoGhSQlBRNpKULiEtbyZWwQVAuwQBYQi/6fqUvNv/m1
 RgHCq1G5Y+R+6tNIgnY0I5UuwCkOVFs=
X-Google-Smtp-Source: ABdhPJzw98e6rkgvWdKlzPsWEvv/ggTETFefarTuBRMnQ0LUNHhocpvZ9SXPPZNlI1aJCCx4nkJjFA==
X-Received: by 2002:a65:6882:: with SMTP id e2mr2214079pgt.290.1598897893362; 
 Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v8 3/7] iommu/uapi: Introduce enum type for PASID data format
Date: Mon, 31 Aug 2020 11:24:56 -0700
Message-Id: <1598898300-65475-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

There can be multiple vendor-specific PASID data formats used in UAPI
structures. This patch adds enum type with a last entry which makes
range checking much easier.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index b42acc8fe007..7cc6ee6c41f7 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
 					 IOMMU_SVA_VTD_GPASID_PCD |  \
 					 IOMMU_SVA_VTD_GPASID_PWT)
 
+enum iommu_pasid_data_format {
+	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
+	IOMMU_PASID_FORMAT_LAST,
+};
+
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
  * @argsz:	User filled size of this data
  * @version:	Version of this data structure
- * @format:	PASID table entry format
+ * @format:	PASID table entry format of enum iommu_pasid_data_format type
  * @flags:	Additional information on guest bind request
  * @gpgd:	Guest page directory base of the guest mm to bind
  * @hpasid:	Process address space ID used for the guest mm in host IOMMU
@@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
 	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
-#define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
 	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
