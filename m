Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C7C433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 21:56:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D4422207
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1vRnfsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D4422207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4774A87B19;
	Fri, 11 Sep 2020 21:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7o6XS5NTnQqF; Fri, 11 Sep 2020 21:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 60BDC87AF9;
	Fri, 11 Sep 2020 21:56:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BBF0C0890;
	Fri, 11 Sep 2020 21:56:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB52C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 21:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B5A587465
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 21:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SVSD3jWd13qI for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 21:56:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EBDAE8744A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 21:56:09 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id m15so1505104pls.8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
 b=g1vRnfsD8m7ueG53tsKNPKs4doB1uhmhM7jbV2CqIGbxPPCi7tPSxcP5cbXOim2MFy
 xD0QUmCyC73y8wCetTdiRq4SQiifXwpUHBl84uIygpRLDQtIUCGC5fNYCB0jyJ78fdp0
 YbHk9M7AvrgRUsyQ5OHvPnBnYX/dHvO+/R73GkXalTZQWr6YPETDJFfi8e9mnyVVd2XR
 OlMSLAJ9kuywPDhxxSnUSpUG+IduMOvBaZEC/jaipqBuyhLqaleeCvbh8ZMkXRm4LVtC
 UrkDDxr8Toy5UefFzqLAZludBpWeukRxXLtyFwCsjkVRWrgTQDbGRIEFmp5wqn55ksis
 5ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
 b=im3/U4nxTJKyL8Qj8oAWo0Ah6dX7ViVcnINH+63Wj8EJiW++cB5kYYzQLXfUlf43QW
 FIpVIWoez7D6Mxh2XhxLlFGmKzXW0WmvGQ25ymq36O+VnkWEFQC6RJvQhpjRYJDhDnEq
 w6ReybVpwtALmslw1uJ8bg61aUEtIpHY5L/H8bW0Y4vTlglFDp5Mkv169kNDL0Ab/KOr
 EdvUkKQ6X77jcrQYekj8ClmzczPCPgs6kSml+/wo1WbhKpp1hyqIwuNh2FV+O/xwmsXI
 4dWi8YXVLhzA3TS1E4I/T+wTILFK9tj57AQMIP4Sp+FXH4m6A8FRg3Vjp4pxrzprwT8v
 M5RA==
X-Gm-Message-State: AOAM533XmjCSjtau6rxFdZ4hN9K5xGKaA6oA8nTgZec6K2n4xTPH51W9
 Jw7rVQIlkishprOujFKP93bbGU8igD4=
X-Google-Smtp-Source: ABdhPJz/myLbsxkV+GFYo/DtWNDDBhvmWiZ1v6vmj0NRM4A2phEIn6ULCgp+8t6sfozt71jNC488Yw==
X-Received: by 2002:a17:902:ab92:: with SMTP id
 f18mr4064017plr.12.1599861369317; 
 Fri, 11 Sep 2020 14:56:09 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id e62sm3171586pfh.76.2020.09.11.14.56.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Sep 2020 14:56:08 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v9 2/7] iommu/uapi: Add argsz for user filled data
Date: Fri, 11 Sep 2020 14:57:51 -0700
Message-Id: <1599861476-53416-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
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

As IOMMU UAPI gets extended, user data size may increase. To support
backward compatibiliy, this patch introduces a size field to each UAPI
data structures. It is *always* the responsibility for the user to fill in
the correct size. Padding fields are adjusted to ensure 8 byte alignment.

Specific scenarios for user data handling are documented in:
Documentation/userspace-api/iommu.rst

As there is no current users of the API, struct version is not
incremented.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index c2b2caf9ed41..b42acc8fe007 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -139,6 +139,7 @@ enum iommu_page_response_code {
 
 /**
  * struct iommu_page_response - Generic page response information
+ * @argsz: User filled size of this data
  * @version: API version of this structure
  * @flags: encodes whether the corresponding fields are valid
  *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
@@ -147,6 +148,7 @@ enum iommu_page_response_code {
  * @code: response code from &enum iommu_page_response_code
  */
 struct iommu_page_response {
+	__u32	argsz;
 #define IOMMU_PAGE_RESP_VERSION_1	1
 	__u32	version;
 #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
@@ -222,6 +224,7 @@ struct iommu_inv_pasid_info {
 /**
  * struct iommu_cache_invalidate_info - First level/stage invalidation
  *     information
+ * @argsz: User filled size of this data
  * @version: API version of this structure
  * @cache: bitfield that allows to select which caches to invalidate
  * @granularity: defines the lowest granularity used for the invalidation:
@@ -250,6 +253,7 @@ struct iommu_inv_pasid_info {
  * must support the used granularity.
  */
 struct iommu_cache_invalidate_info {
+	__u32	argsz;
 #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
 	__u32	version;
 /* IOMMU paging structure cache */
@@ -259,7 +263,7 @@ struct iommu_cache_invalidate_info {
 #define IOMMU_CACHE_INV_TYPE_NR		(3)
 	__u8	cache;
 	__u8	granularity;
-	__u8	padding[2];
+	__u8	padding[6];
 	union {
 		struct iommu_inv_pasid_info pasid_info;
 		struct iommu_inv_addr_info addr_info;
@@ -296,6 +300,7 @@ struct iommu_gpasid_bind_data_vtd {
 
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
+ * @argsz:	User filled size of this data
  * @version:	Version of this data structure
  * @format:	PASID table entry format
  * @flags:	Additional information on guest bind request
@@ -313,17 +318,18 @@ struct iommu_gpasid_bind_data_vtd {
  * PASID to host PASID based on this bind data.
  */
 struct iommu_gpasid_bind_data {
+	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
+	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
 	__u64 flags;
 	__u64 gpgd;
 	__u64 hpasid;
 	__u64 gpasid;
-	__u32 addr_width;
-	__u8  padding[12];
+	__u8  padding[8];
 	/* Vendor specific data */
 	union {
 		struct iommu_gpasid_bind_data_vtd vtd;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
