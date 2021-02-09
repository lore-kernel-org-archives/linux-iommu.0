Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DEFC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:23:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F69D64EB9
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F69D64EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 570646F7F0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3p9Qki4DT5T6 for <iommu@archiver.kernel.org>;
	Tue,  9 Feb 2021 06:23:09 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 7F7B76F71C; Tue,  9 Feb 2021 06:23:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EC126F69F;
	Tue,  9 Feb 2021 06:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EECF2C0174;
	Tue,  9 Feb 2021 06:23:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6178BC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 508F387248
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1o+RlNFq0Qq for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:23:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B10CD87241
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:23:03 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id t11so8140801pgu.8
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6zQVHgfobPuQEWulcSd+ytGSNGCX6uxs4mC7Gt2kf+c=;
 b=ert+XkxphAdsHWZRYOV0Cfn/2U+Hq+bg6asziCHHt/7u8Vvc0xyaeiuaRHcJi9Q1Vz
 h0k512lAFo9/rmCIttSQjdSndXS7KAKpm476xzbqDMAPDG5a7mdNYtdhfGaun9yWGWmH
 a9iyECq63v2VApjt+BbXpHPW6ZsiyzSxuIc1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6zQVHgfobPuQEWulcSd+ytGSNGCX6uxs4mC7Gt2kf+c=;
 b=teKn9IDiG/+ixnyZtCATAJizIYG9Zb0bj8iNSVFcJ5k4Nwm43QjUxHBE1KRzVgK6nt
 2k9Opvzl24NkVNZFsCTGVBrg/Zh+vk8I6GcVpMlLp3zD1QVYeyfuZAUurLxc4VZ6lFW0
 WOfbfHEzCP1ObyakUFo5/Z4RP+zUmakwmeAy19yRCW96a4ezfSZY6DM8430MCm5pTaKA
 1FFEEH1jeOBNFTfGLbv8Q6VKXIKB8H/VRnEN/v6Vx8QeFASEE6fvXNDt7XAVYeyogsdi
 Sy6AiFCROYz+uDr4bEv47Gb0PibYD+LfYQdwxkexeG5aI/QEITEEJVBQ/9M4Wm1OCzED
 YEuA==
X-Gm-Message-State: AOAM5303EhugnbJgu5QVtTHCjl38uV+05HeFWenlPP2Xbe89xf3mVTOs
 r4lxODKvNT1SstaEQFM1EnGQKA==
X-Google-Smtp-Source: ABdhPJzmV9YXPB6hCsXZ7URzXPDB7/qCe304q7KRCHJSQjtn7qxPBetED2jKI5U7yWvekiJpr6hFzw==
X-Received: by 2002:a62:4e10:0:b029:1c9:9015:dc5b with SMTP id
 c16-20020a624e100000b02901c99015dc5bmr21533363pfb.30.1612851783406; 
 Mon, 08 Feb 2021 22:23:03 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
 by smtp.gmail.com with UTF8SMTPSA id gx22sm1155253pjb.49.2021.02.08.22.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:23:02 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 11/14] swiotlb: Add is_dev_swiotlb_force()
Date: Tue,  9 Feb 2021 14:21:28 +0800
Message-Id: <20210209062131.2300005-12-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

Add is_dev_swiotlb_force() which returns true if the device has
restricted DMA pool (e.g. dev->dev_swiotlb is set).

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 9 +++++++++
 kernel/dma/swiotlb.c    | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 76f86c684524..b9f2a250c8da 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -73,11 +73,16 @@ extern enum swiotlb_force swiotlb_force;
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 bool is_swiotlb_force(struct device *dev);
+bool is_dev_swiotlb_force(struct device *dev);
 #else
 static inline bool is_swiotlb_force(struct device *dev)
 {
 	return unlikely(swiotlb_force == SWIOTLB_FORCE);
 }
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
 
 bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr);
@@ -93,6 +98,10 @@ static inline bool is_swiotlb_force(struct device *dev)
 {
 	return false;
 }
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f64cbe6e84cc..fd9c1bd183ac 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -841,6 +841,11 @@ bool is_swiotlb_force(struct device *dev)
 	return unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dev_swiotlb;
 }
 
+bool is_dev_swiotlb_force(struct device *dev)
+{
+	return dev->dev_swiotlb;
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
