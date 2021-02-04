Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87864C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 07:14:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006F560295
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 07:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006F560295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 88E8620416;
	Thu,  4 Feb 2021 07:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIsCpk8OjWmP; Thu,  4 Feb 2021 07:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8D82B20341;
	Thu,  4 Feb 2021 07:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83203C08A1;
	Thu,  4 Feb 2021 07:14:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D689C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3E3C820349
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BxlV8kod6nzC for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 07:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by silver.osuosl.org (Postfix) with ESMTPS id 403A120341
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:14:18 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id a16so1265525plh.8
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 23:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cITwC79ldFMQgyusgEuHXGzdOsMzB7KooQOa1cAsbsI=;
 b=e3Lx4YFecALYTc75eXFh0jJT2hLv/Ecj8VjgNwcJqJlk7r/Ibtsq4muJXPwemL2DaH
 aPznsk5ijZg6NTjCW31k7YCfokLRHxii24uVWm35lN9hqROee0DQX8hpZRTrmp07i3Iy
 OAy7J5TrebcmL0zLvQLVKtExkXUwUIW7p+JKSbdvyRzZDrSCFP0zJGzJ4ZETTc+I86R0
 xMj+r3VDQ+THnMS8Y/+wZHjDSDMh7wO2Ygxi6d3ww0El7SwntaHvFxAWDtKUhj+XRKbw
 cKGncdr3fSNv8cIVz+E2IkL+Xhk4W5YRAQNwPLJFvBLm7plzqum1w9DkcWke5spNhhzg
 rjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cITwC79ldFMQgyusgEuHXGzdOsMzB7KooQOa1cAsbsI=;
 b=tV605YH5dsHhX8ixwXFbnyIjQ4ULxic9DCwfF8rLhMBE+N/n6b9uHWkl2USzv/Sv4w
 ngy2OJ7jwafA1tqmkOLrFXRDuiVc+d46rEU3SC/SUqyp01ifhcXIr1V3z/9Z1zsLWK8W
 X8xEhD9kydJ39v8E7bAdO8YdrWjJ5x2tmRhNYr7CBkcG+Vd9KTYQNpe3RfOpvMNHCoA9
 5HdmgJuKu5bQV+Z3SBsDuVrpMgxGGeOBQje08fAzCJHrx/ErL5Slag2kR4a3rc+cWIWu
 6WlD25CRtewXjlP5mBtvE6IUk77D47h+0qqGqnOX1flXHp3ABpn9PSunVL3dMc6KoUmI
 zovQ==
X-Gm-Message-State: AOAM531lG/8sV/OVI3KqF5X15NK030PQ+YC09usvDMgwi5o9YrZNZ5BS
 igxyV3hdujytbKXTLQhkMUk=
X-Google-Smtp-Source: ABdhPJxfYQJ5QrlYlB4H/jE8kCSwX4bQXMNS5VhU1kvbCqCw53ncVd7SVkgYhkKa7g2RZEUJ3hMWkQ==
X-Received: by 2002:a17:902:bf07:b029:e1:763e:b3a3 with SMTP id
 bi7-20020a170902bf07b02900e1763eb3a3mr7112363plb.39.1612422857763; 
 Wed, 03 Feb 2021 23:14:17 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id h4sm4578855pfo.187.2021.02.03.23.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 23:14:16 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/2] Add Unisoc IOMMU basic driver
Date: Thu,  4 Feb 2021 15:14:02 +0800
Message-Id: <20210204071404.891098-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

Changes since v3:
* Rebased on iommu/next, and fixed compile error reported by kernel test robot <lkp@intel.com>;
* %s/iommu/IOMMU/ properly in the whole patchset.

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
  dt-bindings: iommu: add bindings for sprd IOMMU
  iommu: add Unisoc IOMMU basic driver

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  72 +++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 599 ++++++++++++++++++
 4 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
