Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315B9C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1779964F19
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779964F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B160A430C8;
	Tue,  2 Mar 2021 09:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0jsTVoywABTF; Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F63F43096;
	Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89E45C000B;
	Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1B28C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B297560606
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6J49RgHd7Cw for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:35:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EE636F549
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:33 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id v15so19102429wrx.4
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 01:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q1dBU0HCqaN2oBJe9EmSK9n4bOZOtCnnbOc1d9k2Lwk=;
 b=TjiGWaeH01qGoIEQwfZkE7Z5JsNayNoEh2k+bi13tJXonskCNhseJfQymh+UJSVBGY
 tQhTKXwiAJn4JRbC70qRUg+BSzt/tKIZ8YkjJks/LvKxcsxcuHVlkitDHLBeh1PxJrXj
 c5ASycut8M9NUDlB3StAbfCtaLJROK1bLKvUDQ8ryVV6skmVutS2tX0BSi6dRM1JAkMv
 sOl1UtbRJV55dRe5eIEov7WsPcStFJaoR7bTretXUc/lbGCZo11gafb+W2so/0XiRYJn
 HSZQEGVLwYQupOMz68Urbcq9FOu3bfPvFhIUo4eZRraVMDxVR7y1Nf4tpC+Sz8OpsrKh
 8c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q1dBU0HCqaN2oBJe9EmSK9n4bOZOtCnnbOc1d9k2Lwk=;
 b=JnnJ3+daX6aNYkUEhlqUiGama/pzcciHrJLXBWlUL5EF5tHHGnurOmDRuitS1NBpsc
 r1PfxViXsldtxdPoJ4fj2xeFBHCrfdHFam82rU++38zu2s6C5n3oFS2f7Jruy8ALl4l6
 XAdtYUuvRTgctv6eUALnC1uJzIoZ0nr5WtrIIWkw86hubnAT5K4vapIDezlw50QUmDdy
 i/Fuoo5i+PzKj9JrnYEhXfxjPXVtFYp4FMILU2NwUTnTNPcd6ots62d1p6XsCrHlaFb6
 GMlf3eD2/Xdcq6h1HjyZFgfndasJN7P+MG4Yukl5/1nIC1Tucx6FnK0YSGSIleKkehTM
 ZqOQ==
X-Gm-Message-State: AOAM531lbJjd7mQOY8ikKzZcXPH92HQAZqidjdRASJGdbnKK8QcQ1ggr
 F26exx0TAzMGzOuBqytkce6KOA==
X-Google-Smtp-Source: ABdhPJw0xjkmPSp0mtZPb6X4Nd58+owZ0dVYxXm8u5GKEjL3scy/QYMFqL4xdWND/ojmSq+WV9cIEA==
X-Received: by 2002:a5d:6103:: with SMTP id v3mr10571422wrt.375.1614677731470; 
 Tue, 02 Mar 2021 01:35:31 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:35:31 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v13 01/10] iommu: Fix comment for struct iommu_fwspec
Date: Tue,  2 Mar 2021 10:26:37 +0100
Message-Id: <20210302092644.2553014-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
dev_iommu") removed iommu_priv from fwspec and commit 5702ee24182f
("ACPI/IORT: Check ATS capability in root complex nodes") added @flags.
Update the struct doc.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..1d422bf722a1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -571,7 +571,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * struct iommu_fwspec - per-device IOMMU instance data
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
- * @iommu_priv: IOMMU driver private data for this device
+ * @flags: IOMMU_FWSPEC_* flags
  * @num_pasid_bits: number of PASID bits supported by this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
