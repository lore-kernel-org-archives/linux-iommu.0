Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95362C433E1
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:48:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2FE20759
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTrbu7ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2FE20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2D7858948A;
	Fri, 15 May 2020 10:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dPUVjXTM6x1O; Fri, 15 May 2020 10:48:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E4778872F;
	Fri, 15 May 2020 10:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DEB2C0178;
	Fri, 15 May 2020 10:48:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BA22C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8AE4C87BD3
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbGhej7PiS-W for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 10:48:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1416C87BCE
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:48:28 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z72so2141790wmc.2
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JpC2phLyyYKF8S2b2HVZs4m4/FDmGsrLmfDUKIq2+XU=;
 b=UTrbu7phaIKvcCKf/Ve9t6teHJmN3bXqWH26QoPA9XW9/eFXVzFMnJd7yXk/ufGYO6
 LG4QvKt9zY+sCvKwdmFzBcalHGa3Rbh1I1KJPJBZ2uxo7jWJ45R6JaMa6XWdcV/GOPKP
 tUYFz3NcWw50UGDz+eyN8vwJ441gSD7aTICtNuV9th4D1crstiW7bfxp9T2fVw7fQuVW
 zm6HtX5EFTwISIAY11pWVRaYj/uaKucP/T7x4kzyFwdv+lmzX80pD+xcYCNelol9g+bb
 h3RQo4K/F8AKExBgzpfQ36PTd1yfEVOKckHXo+e1DxxLcKzCzGN0U7DFyoS7T3y4oQTB
 GuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JpC2phLyyYKF8S2b2HVZs4m4/FDmGsrLmfDUKIq2+XU=;
 b=YC6Xly6y5INIHEwzbc0xlq8L5AmZPkRJ4UaG8bxXKtr1m7uA8R61CZKBlzBYRFHACL
 +MGk4dswxVKiHrMKHuGGZBv3ZHJQphMH+AkPRFtq3aCnz2yzTeUIrfPbG14dSqSZI90Y
 Ly7hUv8Mq0iJuUwkEra0mJ7KkNL4ZKAuzCAXY3YTa5UqZjcTx++2i8YRbGDUpswHDd2/
 EZXw1ws5YiUhe+5T8zwI4cqFNzlTZG3ij/ALhAEn/F/D9d98pRAM4nTFaLJAElqWoBxF
 tWE2vsDF7oixngZTxDkfYc7GoOHKcHeEWJtCW3iD3PmNt7gxo3fYQ3iC7HmUyuKCNYnd
 N8PQ==
X-Gm-Message-State: AOAM533/e2CUCRbuWLyC9xTjrogOzCYxQQmg2P/08+jF9yN8v+JJd+yJ
 xlWvuQ8TH1oZYOgdKjyPe+4mfw==
X-Google-Smtp-Source: ABdhPJzpE90JsHWFWmiq3DLTcslPe1cuELNW3ZN0iUxPcNk8zGAYa3lMkhSlVxo89SFkbP4lE1f/Ig==
X-Received: by 2002:a1c:6706:: with SMTP id b6mr3116259wmc.54.1589539706443;
 Fri, 15 May 2020 03:48:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 03:48:25 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS enablement
Date: Fri, 15 May 2020 12:43:58 +0200
Message-Id: <20200515104359.1178606-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, ashok.raj@intel.com,
 will@kernel.org, alex.williamson@redhat.com, robin.murphy@arm.com,
 dwmw2@infradead.org
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

I sent these in March as part of ATS enablement for device-tree [1], but
haven't found the time to address the largest comment on that series
about consolidating the root bridge ATS support between the different
ACPI tables.

I'm resending only the bits that consolidate the 'untrusted' check for
ATS, since there have been more discussions about this [2]. Patch 1
moves the 'untrusted' check to drivers/pci/ats.c and patches 2-4 modify
the ATS-capable IOMMU drivers.

The only functional change should be to the AMD IOMMU driver. With this
change all IOMMU drivers block 'Translated' PCIe transactions and
Translation Requests from untrusted devices.

[1] https://lore.kernel.org/linux-iommu/20200311124506.208376-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-pci/20200513151929.GA38418@bjorn-Precision-5520/

Jean-Philippe Brucker (4):
  PCI/ATS: Only enable ATS for trusted devices
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()

 include/linux/pci-ats.h     |  3 +++
 drivers/iommu/amd_iommu.c   | 12 ++++--------
 drivers/iommu/arm-smmu-v3.c | 20 +++++---------------
 drivers/iommu/intel-iommu.c |  9 +++------
 drivers/pci/ats.c           | 18 +++++++++++++++++-
 5 files changed, 32 insertions(+), 30 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
