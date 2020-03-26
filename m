Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D5C2D0E8
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 09:36:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5314F20714
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 09:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOIe/ldE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5314F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2158187145;
	Thu, 26 Mar 2020 09:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ykuuXbl7SBu; Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9564A870EB;
	Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82D01C1831;
	Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC48FC0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D847388425
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jBe6V5JQXK7G for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 09:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E6B8988406
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:48 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id l20so6152816wmi.3
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lajplBTzvlJjjyB5d/rvr6mxgKf8jthOYH/0XMGJYKc=;
 b=tOIe/ldEqwY7T6oVRKLcieqlVoTJFQkrCmcTbJk+TxNDsbi+/4ULDAsTPtyGctvpZt
 k+Mfq15KYEGUaGb1yPlI/2X9Do/QAAoOSoDC/MBpJjyYZCDZspvOSNt+SvI8WtEZC4M0
 dmZ8AmrE1QMSd0xjwzV0YgmGcPhqw5MTmbokWBJe5IeKyRC4BOxF3oWWuC1QgSASzeTe
 cf9+pF8ml8319t/sb7LzZq2qfWB01xvbILuRMyVK5yy3uJMiBQ1CGnrTqWU2jCjmilxt
 AKDXUFW5E49gP1SKVe2+NGdu8wF73AyujQSlbM424IcJuas67XJXrbtpWA1ow3F109Ch
 eU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lajplBTzvlJjjyB5d/rvr6mxgKf8jthOYH/0XMGJYKc=;
 b=FXolZCymJ+UcHKxAOoigFOa2N4ni19L2Jcm4lRyjETFzxAM3ZOlWYO1oHkEz9Fc6i3
 /ERQwGAqYEA19sjhwVyD63xhmvtIeBEmq3FafH/VvP/lrGUrU0+GPr8dAR3UFg5Mr4i0
 Cct2M8NFd52MOg9IO7G9901u5zsxSZhtSbjCz+646n15Qk0gAu5ZZSZtgFn/FKWmPU/w
 HOI50I0dDFtGHDvzl7NEQUQbPySjBFpwrnGZd2Oa1D8a/ilCOfLvcLn35wua8jTtkYQI
 zxUOVw5yPXblmQiThrfyomFZ8V7CT7B25fZx160UGChoV28vKGvXv7LFSI/3ThklheVd
 85nw==
X-Gm-Message-State: ANhLgQ3eth0K6VdDeKSt6dFWM5tZvKv3ofEt5B6VER+85/4Ypg/s5R8P
 X9HS997Y5Cvp1ElXge8r5/kRIanOoNmDEA==
X-Google-Smtp-Source: ADFU+vuY5MSZKCaL767WyqQNnptmDlZTfCQ4OZLTDBCvjrh4sKIYXa7lO+bG4W5+EiJ2BtAlIInK5g==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr2182434wmi.139.1585215407015; 
 Thu, 26 Mar 2020 02:36:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u8sm2670165wrn.69.2020.03.26.02.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 02:36:46 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/3] iommu/virtio: Fix sparse warning
Date: Thu, 26 Mar 2020 10:35:56 +0100
Message-Id: <20200326093558.2641019-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326093558.2641019-1-jean-philippe@linaro.org>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kbuild test robot <lkp@intel.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bbhushan2@marvell.com,
 jasowang@redhat.com
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

We copied the virtio_iommu_config from the virtio-iommu specification,
which declares the fields using little-endian annotations (for example
le32). Unfortunately this causes sparse to warn about comparison between
little- and cpu-endian, because of the typecheck() in virtio_cread():

drivers/iommu/virtio-iommu.c:1024:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1024:9: sparse:    restricted __le64 *
drivers/iommu/virtio-iommu.c:1024:9: sparse:    unsigned long long *
drivers/iommu/virtio-iommu.c:1036:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1036:9: sparse:    restricted __le64 *
drivers/iommu/virtio-iommu.c:1036:9: sparse:    unsigned long long *
drivers/iommu/virtio-iommu.c:1040:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1040:9: sparse:    restricted __le64 *
drivers/iommu/virtio-iommu.c:1040:9: sparse:    unsigned long long *
drivers/iommu/virtio-iommu.c:1044:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1044:9: sparse:    restricted __le32 *
drivers/iommu/virtio-iommu.c:1044:9: sparse:    unsigned int *
drivers/iommu/virtio-iommu.c:1048:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1048:9: sparse:    restricted __le32 *
drivers/iommu/virtio-iommu.c:1048:9: sparse:    unsigned int *
drivers/iommu/virtio-iommu.c:1052:9: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/iommu/virtio-iommu.c:1052:9: sparse:    restricted __le32 *
drivers/iommu/virtio-iommu.c:1052:9: sparse:    unsigned int *

Although virtio_cread() does convert virtio-endian (in our case
little-endian) to cpu-endian, the typecheck() needs the two arguments to
have the same endianness. Do as UAPI headers of other virtio devices do,
and remove the endian annotation from the device config.

Even though we change the UAPI this shouldn't cause any regression since
QEMU, the existing implementation of virtio-iommu that uses this header,
already removes the annotations when importing headers.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..48e3c29223b5 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -18,24 +18,24 @@
 #define VIRTIO_IOMMU_F_MMIO			5
 
 struct virtio_iommu_range_64 {
-	__le64					start;
-	__le64					end;
+	__u64					start;
+	__u64					end;
 };
 
 struct virtio_iommu_range_32 {
-	__le32					start;
-	__le32					end;
+	__u32					start;
+	__u32					end;
 };
 
 struct virtio_iommu_config {
 	/* Supported page sizes */
-	__le64					page_size_mask;
+	__u64					page_size_mask;
 	/* Supported IOVA range */
 	struct virtio_iommu_range_64		input_range;
 	/* Max domain ID size */
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
-	__le32					probe_size;
+	__u32					probe_size;
 };
 
 /* Request types */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
