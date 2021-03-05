Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2AC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 09:32:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D5164FE2
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 09:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D5164FE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D56743095;
	Fri,  5 Mar 2021 09:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyhm6QEw17yD; Fri,  5 Mar 2021 09:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1864743150;
	Fri,  5 Mar 2021 09:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E170BC000A;
	Fri,  5 Mar 2021 09:32:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B58EC0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 09:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2957084511
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 09:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1o0Lh2Qq3NLn for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:32:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F8EC8451F
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 09:32:36 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id l18so1617304pji.3
 for <iommu@lists.linux-foundation.org>; Fri, 05 Mar 2021 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qlaOlPxH8Zhtxoq9sQT2kqVDB3VTC2lAkFE3uKaCSs0=;
 b=l9zC5NxXiCZPKfyavKoqgPEuKb/8RgMHLiiAPqENWvDj50ekCI9sFM2AsQ7c+sFMJX
 sfEJ9qY5Y/C7xKhzqObiw4eK3jZfm5eWM1FjxWBUOJZLAvYaAmkvdeq2NBMHLywUHtVY
 7dIfvcnXm3X8okewZuBqUyYWDLSRymOMlILXQqlOFv7w/A0jcB0zc43is/HZTwVnPnf5
 ygAC2dz52JSQrAkTAA7X8Ir59b3te3tesx7DTl8EDItlrbd3f1C4HVkPvJZtaL+t+6EF
 nwk72iDQ7ajE4ujKe3TUBAPUmVNjl7OhJa1aRWWVIpDuDV2EEtvStyaDhPfOz3nXaTPd
 HOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qlaOlPxH8Zhtxoq9sQT2kqVDB3VTC2lAkFE3uKaCSs0=;
 b=cBOWutRPohBvmttyq3q28wmH+/IjSBQydERemcXMu649+lXXZs/+PAqtMFHVa23rcY
 mGSXvHCYdaZVQbmAzgKJThAXj4Guob4WsBYelirqlDfipiZx6SIp10r6mHXsSK2e7TPG
 CojtvmFvnbbEsTcdvws0/Z3BVBa4FD2a07oMosVkn4Hfr6+mft3pg0zWTeI9A8dDRnor
 pT/dt1ZGhDG27fL66ONOnqSo64mZa7pBRVeBNip2D0DMTPT3OsQZ+WnXRCY0ilCbrEee
 Ze5CbKAUNqCUadFV4MmDDyh0Dfv0pqC5/OGaiY6OOm8qpKtfdWgQVB6gL3Uqept7yQC7
 DR7Q==
X-Gm-Message-State: AOAM530Ik4jZS7lhsdUGEI+eI7CQwa+YXDKw3eGT6RQO29TsaDUVCqJy
 qbLh5fSI7xbRpZfxuLGcEik=
X-Google-Smtp-Source: ABdhPJxwaZiAt9xWzko57VylfxIb4L8IF71cfnxEDaKk95zKhLLEFv/627CqdtqbrJaREDsl3Ylv+Q==
X-Received: by 2002:a17:90a:34cc:: with SMTP id
 m12mr9128555pjf.232.1614936755648; 
 Fri, 05 Mar 2021 01:32:35 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id f3sm1873967pfe.25.2021.03.05.01.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 01:32:35 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 0/2] Add Unisoc IOMMU basic driver
Date: Fri,  5 Mar 2021 17:32:14 +0800
Message-Id: <20210305093216.201897-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Kevin Tang <kevin.tang@unisoc.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Changes since v4 (https://lkml.org/lkml/2021/2/4/85):
* Rebased on v5.12-rc1;
* Dropped using syscon node for mapping registers according to Rob's comments.

Changes since v3 (https://lkml.org/lkml/2021/2/3/161):
* Rebased on iommu/next, and fixed compile error reported by kernel test robot <lkp@intel.com>;
* %s/iommu/IOMMU/ properly in the whole patchset.

Changes since v2 (https://lkml.org/lkml/2021/2/2/106):
* Added a WARN and return 0 if an invalid iova was passed to sprd_iommu_iova_to_phys();
* Changed the name of sprd_iommu_write();
* Revised CONFIG_SPRD_IOMMU help graph in Kconfig.
* Revised comments for the struct sprd_iommu_device;
* Converted to use "GPL" instread of "GPL v2", they are same as license-rules.rst shows.

Changes since v1 (https://lkml.org/lkml/2021/1/21/563):
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

Changes since RFC v2 (https://lkml.org/lkml/2021/1/8/277):
* Addressed Robin's comments:
- Add COMPILE_TEST support;
- Use DMA allocator for PTE;
- Revised to avoid resource leak issue;
- Added ->iotlb_sync implemented;
- Moved iommu group allocation to probe;
- Changed some function names to make them sprd specific;
* Added support for more iommu instance;

Changes since RFC v1 (https://lkml.org/lkml/2020/12/23/209):
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

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  57 ++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 577 ++++++++++++++++++
 4 files changed, 647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
