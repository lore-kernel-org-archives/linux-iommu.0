Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96FC433DF
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9021D20708
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hY9oaplV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9021D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 59F8088906;
	Wed, 20 May 2020 15:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HjY3kcR33iKl; Wed, 20 May 2020 15:32:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B5A5987E5B;
	Wed, 20 May 2020 15:32:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F980C07FF;
	Wed, 20 May 2020 15:32:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62BDDC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4CDD2881AC
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PR11jvxL5paI for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 15:32:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 629D888165
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:48 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id l11so3647872wru.0
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rS3MgHL31zdXvs2YX1XoxnJ/QACnY+W7BlrTCAAllU0=;
 b=hY9oaplVLKnDyaWbfEcx3s8I1dfHkZlzlOwiaJuO2n+epmAgtp1JTI4feeUEaBrJs3
 6/revPgKuLi9A6H2mT3sQu0jH/eDEBa09OwTcwN4EXCM/I8T6ZO+o6nWqfcqE0u2+d1r
 cAPVjWmGEKC8LCbZd72iUB+DM7p0cQR0Vm9qPKqeXHgGu4T93KwE47r4s7cXKfaHSUPk
 /hJ5ngY4U+iINK6ZhPrINbx7+l9uHPvnjLKZk7iamIRNVZ3qLpxEUhj1zF5hW2KQZiT4
 ZFuGhyhRQW1or7xs+BQYyLhbHQJyub1sUSRRYeYGlATkrd9gA4Ff5irEJAVfzafwzR72
 PA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rS3MgHL31zdXvs2YX1XoxnJ/QACnY+W7BlrTCAAllU0=;
 b=QJNbnGb4wozrRxEeSnureriq3ooCaIu9Pywrl6WBaBhOy7fVtLiNrtXdebZVz+BE3H
 5KPznjRP+7080WIgU7eHQJca31egHaXO4hAtFNTv4xvEP7QKwIaKjPzD24vxwf8slpzg
 5gJWjEsc6ojh/qowkoizy2gyJPnIPL1g5H+JqGATfj9k+AKnfZ5qzgS59C7zLk3S/sXK
 V4Bm05+mspvWIYY/jrgfgaGoF5T102RSnx3iDQHugUf7ucp1USWWrN30yRcO2cJrRcvs
 GfFWaaDarqVb8houvpSxbfdxQJMGPvgsi69s1QkyylqI5JPuc4pOM/GvfgWL3qEeXkSa
 0b1w==
X-Gm-Message-State: AOAM531vyqUI5AgoW8k74XBT1kJjdTSBpUw8WrJV8ELISds2TqlUbiJd
 V0B694tUaYWFNfiSaoJSwibCuQ==
X-Google-Smtp-Source: ABdhPJyH2SJWlWmAdD/I/XNWbNecG/p9BGtXgaK0Dlhtqu9Ep77NQ7dbbkvudTLDgN0b4pgGbvMpPg==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr4372203wrt.147.1589988766791; 
 Wed, 20 May 2020 08:32:46 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 08:32:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH v2 0/4] PCI,
 iommu: Factor 'untrusted' check for ATS enablement 
Date: Wed, 20 May 2020 17:21:59 +0200
Message-Id: <20200520152201.3309416-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, ashok.raj@intel.com,
 will@kernel.org, hch@infradead.org, alex.williamson@redhat.com,
 robin.murphy@arm.com, dwmw2@infradead.org
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

IOMMU drivers currently check themselves if a device is untrusted
(plugged into an external-facing port) before enabling ATS. Move the
check to drivers/pci. The only functional change should be to the AMD
IOMMU driver. With this change all IOMMU drivers block 'Translated' PCIe
transactions and Translation Requests from untrusted devices.

Since v1 [1] I added tags, addressed comments on patches 1 and 3, and
fixed a regression in patch 3.

[1] https://lore.kernel.org/linux-iommu/20200515104359.1178606-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (4):
  PCI/ATS: Only enable ATS for trusted devices
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()

 include/linux/pci-ats.h     |  3 +++
 drivers/iommu/amd_iommu.c   | 12 ++++--------
 drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
 drivers/iommu/intel-iommu.c |  9 +++------
 drivers/pci/ats.c           | 18 +++++++++++++++++-
 5 files changed, 34 insertions(+), 28 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
