Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87CC433E9
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 07:34:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2514764EE5
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 07:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2514764EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD6B384854;
	Tue,  2 Feb 2021 07:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8zm1ZEhtiVsK; Tue,  2 Feb 2021 07:34:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 024F48587C;
	Tue,  2 Feb 2021 07:34:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D994CC0174;
	Tue,  2 Feb 2021 07:34:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B417C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 07:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 299F784495
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 07:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WWLsdLrCH5gz for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 07:34:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2E04E844A8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 07:34:30 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id x9so6069886plb.5
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 23:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ompRf8cfDRH36F3caoFFYG+tYZCSg50YdpkIE/hyJMw=;
 b=Zy5ftunn/tYYdnM+XyFaEA+A377YXR8PS1iLHZH6WHb0yYO4I0Gb6BYTQhcSP25m2r
 8m3TP94MfEV/40+M+S7HQcYlXswNIovQo5uvDlPMFhwyt1sCDQrVKZA2wRdNtzznpfFu
 wvvKmJJ0WOgz1MKBFH3145anoQyDMcExERONt5cdXrkkT2ct5rGhxnCyQybGOqT8hiNW
 BQweVybRGrw6s4STZUnnlPAhjdXzV+1vXhyb7fxPwuBwB627tPvdURDTR3y6Oubsfq4M
 2ZpQSGaQeXhtFCrzzAcyGpeWj+ypkmS3daTd+u5ohrPaUW5RMvdYE/HvL7FkBCviI5UO
 xYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ompRf8cfDRH36F3caoFFYG+tYZCSg50YdpkIE/hyJMw=;
 b=RISF+tdhJpdWNRt9YINWo7OQTBpmM8a4t+i8C50GJvML5GVjk2YUcLS5CchJnYFf3+
 DJHgg7jS+rMKdtUZBKGTZYn5kDrjZXLZH2Z75KbCF99WH3wtLEybnbZQMe7ibiLT1RVh
 Yloj4iBC/BJenyy44AUtdEsc6p6ZSf9h5Vh/Sbb9rKeOny9t1K+Paon+B/KBz4gpPzFw
 QUfK7ujbal8+lcFmbBrkoMTJVL4SME/BRFZMts3fn9cmwzG/DmdDmC0uNQd29SXKeV44
 Had75NGUeSU7nTr9z15My12pL39xgIotYOSsSw+/UGdXoNl8UiSvcu3WREQepsOhhIWf
 uHXQ==
X-Gm-Message-State: AOAM53312C4uhiC9NdlCplCpoDLY5I7UF0lzuqpYAtwxmKvtTJq5S2wY
 jLIibczSk6SftNqxbYOxz/0=
X-Google-Smtp-Source: ABdhPJxubgvThdN3w0Do+rIfD5d52IfjQerNh2trcyjPIFIHaTiJs4qwGq8mCgL1ei0RSs7Y8awBNg==
X-Received: by 2002:a17:90a:1a0b:: with SMTP id
 11mr2922498pjk.58.1612251269773; 
 Mon, 01 Feb 2021 23:34:29 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id o4sm1752029pjs.57.2021.02.01.23.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 23:34:29 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 0/2] Add Unisoc iommu basic driver
Date: Tue,  2 Feb 2021 15:32:56 +0800
Message-Id: <20210202073258.559443-1-zhang.lyra@gmail.com>
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
 drivers/iommu/sprd-iommu.c                    | 581 ++++++++++++++++++
 4 files changed, 666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
