Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E0C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:07:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAEE64F7E
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 09:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAEE64F7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D98785010;
	Wed,  3 Feb 2021 09:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVFuzrNxBf0S; Wed,  3 Feb 2021 09:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E24BD8440A;
	Wed,  3 Feb 2021 09:07:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C510DC0174;
	Wed,  3 Feb 2021 09:07:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7546C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BDDDB204C3
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vd67bl8EVV11 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 09:07:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by silver.osuosl.org (Postfix) with ESMTPS id B3218204C0
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 09:07:46 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id d2so4171205pjs.4
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 01:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZlWrFn/TSCs6U2fJNlgqQGt6rx/LlAU4ePBPMQXyuj4=;
 b=BoeBXegHPtpfm1J6JIqhLbXQZbMnDJ1K0LIEg6EmgpUPSVJoeW3bDSdHkMw08nBgnx
 CT/yT4PZAKKoKN/Rs9JZEe9UcYYW7agC3luIWAD5/NsyPLog1Vt9+WCVB4V3pAwio2yv
 pEZr5EqE3k26IKBPz0DrtcEh8fScLp1RHByEDFAXjW0q34BPj4zqZDA7hBsIquZ3w8f3
 r5ncp3g7cLOBaYymEIEStumGJ0KY8LycKgF4hLhJPdqcEZgW1bEp0vjSi41CZ8poeyvr
 7SsK+dB4FW1LtE0QoUbe1ZN+kB+Mxr6oBlySMxE7gdNSFBEhsZxqxFhO1HuqXoFkK196
 rkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZlWrFn/TSCs6U2fJNlgqQGt6rx/LlAU4ePBPMQXyuj4=;
 b=OgZ2AZh6B0Gv2VX8LlKrWAe7gCj/Gw9IE32mAOR481ZvSCTTkzknx4VTXcAn0hglaW
 eumKhradMaXXKJ6xc9XcYNAN6WKfxPOwnUhcHy1hrNWg9WkNXpXPNKyMp2YUMU5/6bMp
 kj4DCd/HSLipIl6YSwlwIogVfZ342TGv7KXbImdJhJ7i7cDAnHf+me26FFbKdU0Z8mrC
 Sjy4cniOhBVVnKOULqvEdS+WtWOmZWprUNCVpm90jhG5YrvALnLUI/sB5nW3f3J4cpWr
 BOXeevqRsyNVcGczZjO/XzOVQDdzn0Cx6v/O7U7RCdFH0UHq9HPgZvZTGe3Sk0+prE+9
 usAg==
X-Gm-Message-State: AOAM532DatS1ekqs1eqJbzvcZcUF5Bldxla7IP+Nd7qBC7+ykOkt33oM
 d9cekC18JoV7OJhv4uKnPxE=
X-Google-Smtp-Source: ABdhPJzk5sUgntpfAW2isz8JD3HlK8ruAhrrayyoG3um2jd4JvwT9MPXOJFEL2QSOLqYLaPD+bnTBQ==
X-Received: by 2002:a17:902:6b45:b029:e0:7a3:a8c with SMTP id
 g5-20020a1709026b45b02900e007a30a8cmr2303023plt.1.1612343266293; 
 Wed, 03 Feb 2021 01:07:46 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id y12sm1586403pfp.166.2021.02.03.01.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 01:07:45 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 0/2] Add Unisoc iommu basic driver
Date: Wed,  3 Feb 2021 17:07:25 +0800
Message-Id: <20210203090727.789939-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes since v2:
* Added a WARN and return 0 if an invalid iova was passed to sprd_iommu_iova_to_phys();
* Changed the name of sprd_iommu_write();
* Revised CONFIG_SPRD_IOMMU help graph in Kconfig.
* Revised comments for the struct sprd_iommu_device;
* Converted to use "GPL" instread of "GPL v2", they are same as license-rules.rst shows.

Changes since v1:
* Fixed compile errors reported by kernel test robot <lkp@intel.com>.
* Changed to use syscon to get mapped registers for iommu and media devices to avoid double map issue.
* Addressed Robin's comments:
- Added including offset in the returned physical address if the input virtual address isn't page-aligned;
- Added platform_device_put() after calling of_find_device_by_node();
- Removed iommu register offset from driver, it will be defined as the cell of DT reference to syscon phandle;
- Removed multi compatible strings which are not needed;
- Added comments for the function sprd_iommu_clk_enable();
- Added clocks property in bindings;
- Set device_driver.suppress_bind_attrs to disable unbind the devices via sysfs;
- A few trivial fixes.

Changes since RFC v2:
* Addressed Robin's comments:
- Add COMPILE_TEST support;
- Use DMA allocator for PTE;
- Revised to avoid resource leak issue;
- Added ->iotlb_sync implemented;
- Moved iommu group allocation to probe;
- Changed some function names to make them sprd specific;
* Added support for more iommu instance;

Changes since RFC v1:
* Rebased on v5.11-rc1;
* Changed sprd-iommu to tristate;
* Removed check for args_count of iommu OF node, since there's no args
  for sprd-iommu device node;
* Added another IP version (i.e. vau);
* Removed unnecessary configs selection from CONFIG_SPRD_IOMMU;
* Changed to get zeroed pages.

Chunyan Zhang (2):
  dt-bindings: iommu: add bindings for sprd iommu
  iommu: add Unisoc iommu basic driver

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  72 +++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 600 ++++++++++++++++++
 4 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
