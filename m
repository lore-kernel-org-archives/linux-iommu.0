Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9283C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6641061BE7;
	Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KwSHXqgRmfc5; Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 639CD60603;
	Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB706C0040;
	Wed,  1 Dec 2021 17:34:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D784AC0012
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C582581C71
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IpKuzzUnTZKg for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D733B81BC2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:34:36 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 p27-20020a05600c1d9b00b0033bf8532855so1729631wms.3
 for <iommu@lists.linux-foundation.org>; Wed, 01 Dec 2021 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hUrXQwIfEJVWh6hdGtsCtY1XLEUSUBHNz/xuvNP25sA=;
 b=qBndB82iTaFzAh8I1/ZWCrjDRO0mKHRUdE0yCtmNAJd3t4bddB9qlIwuY3LtOlmQ/o
 b4ETIJGLSao+KPSG/LMVRS0BUIe2NNPO+g6UkpZHVlUW52tu6sjp3fmca6Gc/0cgBL4l
 rNOHIAQ7f/heKHl1nfW0gSZperjQRUnTnTIDq7MwJ3Q2o0cdrqA7BHxlQwlw0hKFn0mt
 XyFHCrDUHKUoZTe3ek5+//bxCfx5GK6+lCZufwPVDA8ipd+RVbIB6eUTRY9yGpMgKRI+
 CWEw7n6MUvzGzNtvXcRLsBhKa0wKnUMyZ9bvjxurpaUjCjaNG652k0UESWpmLJRDotUf
 wdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hUrXQwIfEJVWh6hdGtsCtY1XLEUSUBHNz/xuvNP25sA=;
 b=qxlmvqACmKhuoMl13tHEdHpZ81k1e1SGciFFuvRneRI/o2q/Z0azdo+Blby+HSt3s8
 Qth8ktBbO9dHNL7uuSExXBEj4abpF2wOD5JuNHBTckui4sX3HMcnKa73rNkKfRkwWOH7
 XqqeYZIc8N16x01I+JQ+i08iM/5T00VLT/NniUWGEa+1mpAYBI/hULi2HPTT0bC0jP6Y
 6d3twab4mahLoPXHP2Qs/dUzHxmB/fT7OdlGCLYg4iIMzLSL5vCPgn4bpECIhkGBod32
 rVcY7Mww4zEfH4oZ+sPUCi9VWBe4GKysxGm957WydysZYHpsPT8keSctfFF1w4Dm0O6h
 RhcA==
X-Gm-Message-State: AOAM531WXMEZm/+Mnpit5oHjRpofUHFdKp4XkS3+9LROtm2BNcsrM8YC
 oV8RnbGR3vG32waP8kMntb+Uew==
X-Google-Smtp-Source: ABdhPJwRYM3Ctiffulx14kVjAzQCuPr8zqmd2uDQdHGJ3qdq2CZIiqZXJaQ2EX52z0/BATyyGH1uDw==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr8754622wmc.110.1638380074883; 
 Wed, 01 Dec 2021 09:34:34 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q8sm360023wrx.71.2021.12.01.09.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 09:34:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 0/5] iommu/virtio: Add identity domains
Date: Wed,  1 Dec 2021 17:33:20 +0000
Message-Id: <20211201173323.1045819-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com
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

Support identity domains, allowing to only enable IOMMU protection for a
subset of endpoints (those assigned to userspace, for example). Users
may enable identity domains at compile time
(CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
runtime (/sys/kernel/iommu_groups/*/type = identity).

Since v2 [1] I fixed the padding in patch 1 and a rebase error in patch
5, reported by Eric.

Patches 1-2 support identity domains using the optional
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, which was accepted into the spec
[2]. Patches 3-5 add a fallback to identity mappings, when the feature
is not supported.

QEMU patches are on my virtio-iommu/bypass branch [3], and depend on the
UAPI update.

[1] https://lore.kernel.org/linux-iommu/20211123155301.1047943-1-jean-philippe@linaro.org/
[2] https://github.com/oasis-tcs/virtio-spec/issues/119
[3] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/bypass

Jean-Philippe Brucker (5):
  iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
  iommu/virtio: Support bypass domains
  iommu/virtio: Sort reserved regions
  iommu/virtio: Pass end address to viommu_add_mapping()
  iommu/virtio: Support identity-mapped domains

 include/uapi/linux/virtio_iommu.h |   8 ++-
 drivers/iommu/virtio-iommu.c      | 113 +++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 20 deletions(-)

-- 
2.34.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
