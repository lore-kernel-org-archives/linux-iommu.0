Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1250FC6379F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5C12224F
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 13:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+UnK8b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5C12224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B9A486E28;
	Thu, 12 Nov 2020 13:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gVYDhBPQHGK; Thu, 12 Nov 2020 13:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 978F086DF7;
	Thu, 12 Nov 2020 13:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F0B9C0889;
	Thu, 12 Nov 2020 13:03:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCB1C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0C21386F0C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NuSbggxY4Q8P for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:03:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2F9CF86DF8
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 13:03:23 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id k2so5934646wrx.2
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 05:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4JGD+U5wzrPrHuAbcShPgq/7SS7eVhaJGMY13GukQwc=;
 b=L+UnK8b6jHlxkKjKLGZ2KBHb9UiCE2bYESXAd9FIJCk+MSUtGNGNYYhyKKC6RRifPQ
 PgL5pNXsAPyMWO+HtY1Gz8tYhOV7PCazvQjyezuUbsHfk2M9AaPxMotgauVMZKLo3hiQ
 M9zO8+yMql5b+8b9cbMFbwaUXk+eUu0753EmMvk7l1HFsWM70OEcQW79vBJFUlgt+5VM
 KTrz/bb1p5Gfk+J3GZ0/zY9ErMbza+/lZXbPnTQ6Y0oHv+Z0tDMeL6+cldPYswOsQVrL
 O6uN/kZ4gFKC9yygejnVCUVwrluiILl9XVtVOe0uMkP8IGro9CIcUykOaW84nVGNiLuD
 7kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4JGD+U5wzrPrHuAbcShPgq/7SS7eVhaJGMY13GukQwc=;
 b=ON6+MlPc75J3+qpO8fmoNCoRIwNS0vrOWlLYFBELipWA2enmloed4/jqABn68FfhAL
 KY8CUqBAyOrwHp+yokKOrp0YbupFtGUGUJlQi2zRC63tRaV4tYuJcK1f1KtZreTE6uM7
 dMu1W6N92l5geTaP/Gk3A877Bt6qeU7Rk0MI4SkzphQ6kqIukL61P3gpx/RP5LAqWymp
 a2114w8AGgKFuZih11wDj9elb2yNv0WADHzh3e8ZSiHes7N7A/yjhIq1KzPiZdieU8fP
 vY2+RxZcEHGe0zgIuBqEHuW011ulkVB+JM+IVo5tMUq+ILNP1JHr+paHNDiuSdnqvmVj
 w8Ag==
X-Gm-Message-State: AOAM533yYN0WGrOFkPX8AnW0p9ZAuoSxRjPMDt6l8oAMAhRmsk6ElviI
 zPuanQIs3xkRTLjXvCXMgXSYdQ==
X-Google-Smtp-Source: ABdhPJxo3CkbVLQBJt0LU+udw0kuJH0eA8lhV+b7zpBZqVmuSk9IILiYnXCbLaDmkxe9gZqnDT5qGA==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr24594639wre.370.1605186201700; 
 Thu, 12 Nov 2020 05:03:21 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 05:03:20 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
 robh+dt@kernel.org
Subject: [PATCH v8 5/9] ACPI/IORT: Enable stall support for platform devices
Date: Thu, 12 Nov 2020 13:55:17 +0100
Message-Id: <20201112125519.3987595-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, vivek.gautam@arm.com, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Copy the "Stall supported" bit, that tells whether a platform device
supports stall, into the fwspec struct.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/iort.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70df1ecba7fe..3e39b2212388 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,6 +968,7 @@ static void iort_named_component_init(struct device *dev,
 	nc = (struct acpi_iort_named_component *)node->node_data;
 	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 					   nc->node_flags);
+	fwspec->can_stall = (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED);
 }
 
 static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
