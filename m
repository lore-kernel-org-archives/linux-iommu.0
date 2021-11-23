Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28A0C433EF
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69FF0403DA;
	Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o34ddfaHkjKz; Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35D90403B9;
	Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1930C002E;
	Tue, 23 Nov 2021 15:56:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07EE9C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBC3A40385
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9f2sybq4u3oQ for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EA014036D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 15:56:39 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id o13so4905802wrs.12
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2h9+eOusicYcP8DCFAdl+7wpFRmfX7bffRGLqx4D/2Q=;
 b=FxlITfJ6MxJai1qOMwtzZY1Mwr0qrN2jCa8ZGdbpEEgJ98AYpdKbApJl6Go9hfgqcE
 8YCA6vjP0mfMhtcMfQl95tUkxhKMNEAzTPFDzr6K/zvKHiSzPS+D5pOa1UKhqXtYKewN
 H+a/GM55YSlJ1L+PaDc33vw9yxogKe8+INGI9DqIDELEyBxd+XAQ4w+y9kl+cF2InX6Q
 lOuKRqFJPA6ONElBqRiD7xFGouZ1+uwKQqRnzqzbBHMw/G8C2E4Jt8bEZohWa+OMEIUH
 hx5qNERj9+3fm8uMfMC+d5Hmy0CLcNq9QluVI+wx3ev7HDrK26FawZQGUjA6UPhxE99+
 LsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2h9+eOusicYcP8DCFAdl+7wpFRmfX7bffRGLqx4D/2Q=;
 b=NErzh+bg3r9BSymhUz+LTKdyEhtVJ6e95GVvaZobKXWSZtjnjyl3w6Ez2/sZQD9RHt
 66BwNVqEaTzDV8A6adTAQKlU7Uf6ROFCTYlNTW7mniyO3c9rCOdWROgtNA+UUGdE9Lil
 +QpNBewrU95f4rOBD8BbzyVN0u6DrsqIds0gtHpwovcbmeK/0BU6RqIP8JcAnstVecUh
 ouSlyra8zSyD1tIdtIbVDgSOBu9jmrU8kWDtR1rtRoMxswCTNMfcTDO94Pr/B1jiJDK6
 lsaRKI8MHNF80QLHlRn+RsngeBweg5uYiufq45IQe7u/6n9+XeHVLyf47ypGYkwum9oU
 fS+w==
X-Gm-Message-State: AOAM530Y8/iJyevOB5LRbaBBjN2X4Hx5qRQYozLqll/MFmXrAFcqN90I
 IOe0nrLi3rcgL5mvkgbd/+py3Q==
X-Google-Smtp-Source: ABdhPJxE/ueRhpKmoEAe0x7ByieCf1bstJi80kJ8JOsohjcAgrt5vQZPfOlTM4IpVq/jmmdrlS7A9g==
X-Received: by 2002:a05:6000:15c6:: with SMTP id
 y6mr8371349wry.422.1637682997211; 
 Tue, 23 Nov 2021 07:56:37 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 0/5] iommu/virtio: Add identity domains
Date: Tue, 23 Nov 2021 15:52:57 +0000
Message-Id: <20211123155301.1047943-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
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

Support identity domains, allowing to only enable IOMMU protection for a
subset of endpoints (those assigned to userspace, for example). Users
may enable identity domains at compile time
(CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
runtime (/sys/kernel/iommu_groups/*/type = identity).

Since v1 [1] I rebased onto v5.16-rc and added Kevin's review tag.
The specification update for the new feature has now been accepted [2].

Patches 1-2 support identity domains using the optional
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, and patches 3-5 add a fallback to
identity mappings, when the feature is not supported.

QEMU patches are on my virtio-iommu/bypass branch [3], and depend on the
UAPI update.

[1] https://lore.kernel.org/linux-iommu/20211013121052.518113-1-jean-philippe@linaro.org/
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
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
