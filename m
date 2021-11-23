Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF1EC433FE
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ACDB80DA0;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Osoeaw3Zd6Bv; Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EEB680D99;
	Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D3A9C002E;
	Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6C77C0031
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C51EE40385
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vizg4wEoZBog for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10F9D4036D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id u18so39806071wrg.5
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dQEeEtqyWMKpnKijDTiwXcpp3sArP6LYVWQBTfTX5pw=;
 b=DnORQJb151Y68o1Xq5C1bs+ehBs7egIy8Zf7m9EhobNyNkNltfk9nluQfV6vg+k3af
 erkLDX0T5xUVEXpH5SfY9woZiSaofhLW0KKmsf7S8dCOShjjBwlIh6h9Bg86OM/t9Ys2
 7KUoC8jlteZiEN7JG6PwBNNBv2kBubdv54mskqFP3aA+VlWWZdD6X6xfK3ziJBrOzf0t
 AeMXqPvmhpfwNLuKdrBsRd47bmijs+HtSCPQEjXA5wim33MpmaEy/KwNonOhWvaobqmC
 mNIW0gMTfppFjFp4NdzmviZQSrLvoLeRsA6LvAwHRrHmKIjCkLaG2rk4ezXrAMi6fj7M
 1COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dQEeEtqyWMKpnKijDTiwXcpp3sArP6LYVWQBTfTX5pw=;
 b=H4f49ZIe3EVBBoUcdklaNGZnqrV8MNwbbqw1ADUMck29a8phId0CWCinRW2Kzn+MTO
 gZbLYCYTTzCVofjYYi7v+8+i3MEWic9INimrkS/0KPT+4Cp9Z2xFDq6yqErHbT2U7+cT
 yPWMTtEJIwKoWrdBDL3UCSk4L5tSn4qUE4aEJp7Lr+xddUm1jTO9bUQvZ764adI1kz6l
 FLWj0bSn/Ksg8np5z2ic3AMmVRXd5A0hFb+VcTTYXKIzaeFNDCiJCS+H3N2bhudtz3aS
 Fl6QTJmTKNXRLjCTOQMXCJCE1xIwgtgA5jBfxCUquwY9Ht08VhEW4ohvnNio+xQgP7cJ
 pphA==
X-Gm-Message-State: AOAM533mbjqw+Wgxnd/iHVAkTgLnC49d9dej+a2n3mavmXxTZdIzy3le
 U8O3Wz7suFL6TgJHBOEtLk8yDQ==
X-Google-Smtp-Source: ABdhPJxT/I0BtNdu9fjPi/ENgWGb2FgYhYgcB+hKaYupajDlliAWaWM2yGA2SVIFcUq31yQZKtvE0Q==
X-Received: by 2002:a05:6000:120a:: with SMTP id
 e10mr8639359wrx.156.1637683000160; 
 Tue, 23 Nov 2021 07:56:40 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 3/5] iommu/virtio: Sort reserved regions
Date: Tue, 23 Nov 2021 15:53:00 +0000
Message-Id: <20211123155301.1047943-4-jean-philippe@linaro.org>
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

To ease identity mapping support, keep the list of reserved regions
sorted.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index ee8a7afd667b..d63ec4d11b00 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -423,7 +423,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
-	struct iommu_resv_region *region = NULL;
+	struct iommu_resv_region *region = NULL, *next;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	start = start64 = le64_to_cpu(mem->start);
@@ -454,7 +454,12 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (!region)
 		return -ENOMEM;
 
-	list_add(&region->list, &vdev->resv_regions);
+	/* Keep the list sorted */
+	list_for_each_entry(next, &vdev->resv_regions, list) {
+		if (next->start > region->start)
+			break;
+	}
+	list_add_tail(&region->list, &next->list);
 	return 0;
 }
 
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
