Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC1DC433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E35C180ED2;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JoUP0uMOoXMK; Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6A0180DA2;
	Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69CFAC0037;
	Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2B8C0037
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6679B4025E
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FXxWrAplPTxy for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E02540222
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:39 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id d24so39846117wra.0
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rh/v7U68tKyXyQ6b3jj07z0WH7Y+IG2IvCQMWCW7whk=;
 b=OWJhcdUegx2avyXwMP3MIkRdjcVNtiP8PgBrguw2/NCr+VtjzKfv7g8GAav9ZgRhE6
 hKKpKPhMfuaY4lk61j/OGm5E5n6zlvFjdoGnSjr1CC14jxukFm3U71ud9uVSM9cdYljo
 5mtxVVa0KxYQp4NMVLG9dq6AeM8FaNUVc/bOiPa2IXSsGLXyE7dtXdK13gUl75Y+Ojqf
 Yv21GwUjp36Ed7ZzaQySv2nBH1vBvKFJeW5+87GB4eiAneJTk4t3H9EayQ0d/ymqtC3B
 wramIJtFvEBI92p2bdZP+xXzJwh0qLSgjuWs4oJJKOu/LSGFkpyzl1eKygpkuyVY2bbw
 2kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rh/v7U68tKyXyQ6b3jj07z0WH7Y+IG2IvCQMWCW7whk=;
 b=2JJrQwML796wOUmW0MdyS60RNP8J3Bbyn+wiqkEa0DqpBSZ4h8Fz4zrKO3v88L9Hz2
 PMJ+xLn16rbfU1Rum7x+xBeUCNLbMWN4ENpES6eXONTGdLDvqQ/kdocrj7aL22+xRROc
 zeNBXd6/4LvT/CROl1Bu5oDcZKiTprqD37K1kaNdF65AQmzeMOn/mZ/cGgMpF5E3Rgp0
 BT3rPhfTC2jFWO0CiTwQvWVKTs8EO2Y5wWGU32IrcI7l1aIXAIe/Puh9MSfnDHG6Umjg
 ifXVqtwBZ7iLUPrEZa3IfJtvtMmUqU7PLbjc9X8ROKcag4W5oY/PkcDD/xKmg9S8ca18
 n8hA==
X-Gm-Message-State: AOAM5320jOTDisg9NtENLoX0hM5IjIqvCtTXf4URfSNxKGQ4IEB3zFF5
 82x71uF9d9CKCiK++D4AQ86CFg==
X-Google-Smtp-Source: ABdhPJyt669Qyl5fKNeC+DkjJd6fHbpPgxmbo2SgviMWvuorCu2JK0a7+FItJ+LvEAVdNOREgKXjZQ==
X-Received: by 2002:adf:f990:: with SMTP id f16mr8473053wrr.128.1637682998253; 
 Tue, 23 Nov 2021 07:56:38 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Date: Tue, 23 Nov 2021 15:52:58 +0000
Message-Id: <20211123155301.1047943-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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

Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
VIRTIO_IOMMU_F_BYPASS.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..cafd8cf7febf 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -36,6 +37,8 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	__u8					bypass;
+	__u8					reserved[7];
 };
 
 /* Request types */
@@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
 	__u8					reserved[3];
 };
 
+#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
+
 struct virtio_iommu_req_attach {
 	struct virtio_iommu_req_head		head;
 	__le32					domain;
 	__le32					endpoint;
-	__u8					reserved[8];
+	__le32					flags;
+	__u8					reserved[4];
 	struct virtio_iommu_req_tail		tail;
 };
 
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
