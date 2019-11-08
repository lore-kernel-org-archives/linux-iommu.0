Return-Path: <SRS0=V12C=ZA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F64FC6195
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACC5222C6
	for <iommu@archiver.kernel.org>; Fri,  8 Nov 2019 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Te5zDPiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACC5222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5ED13DDD;
	Fri,  8 Nov 2019 15:26:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 741E6D88
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D6889196
	for <iommu@lists.linux-foundation.org>;
	Fri,  8 Nov 2019 15:26:48 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id v3so7626298wmh.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 08 Nov 2019 07:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=hqa9TgNuEsO9HgZ/3pPJzfYS+V6XOeuR6AE+FRXhkjM=;
	b=Te5zDPiAYaK+KHbGAhgJd/VtE3mWigtsRKL7u1BcvwjwPNdPzg/7LxGWEzUdiw6dXG
	0n6LHlJwVqICWYVTAhKneYz1reVCfd5RDnICCLQUjQaVLq0fopoe2B9zFX9Ya9Is5JWr
	wlO/JqSUM9fgS4LmumnqeJQZ9HXrZv/qqI7rdOe48CKMysLzgB0XmL/tomAoqxsdKvO7
	294fV4mnYHPT5mXX3H5UjD0MqW0T35qmi5Mk5O6tScBxr6gHUOVU56nROPVnWXMYGGMZ
	v/8DuymoH2MBxeRSLytNh+PgngaRyrV8rzCbIHcUl2oXrSKCBEQZQqQUJnj8c0Ye8CMF
	ydDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=hqa9TgNuEsO9HgZ/3pPJzfYS+V6XOeuR6AE+FRXhkjM=;
	b=Qn/CJEKO6SuHlTf6ZvwqOqjXYQpG7CQgmSfeSXmGsx2qaY5O10KXiB58tRQS9cimtm
	wfWAt0vrfxvUfT17F9jWeKLX4BGRYU6SkfgvJ3Rbdg9CZQjAwslqVbTZU/F73uDN4V75
	0vkkec91SoD3vdyzGIawgSEyizKuydk7scFB3cdu5RbYrkspDfMi5eRF6ZuUpbpzisXQ
	S3qkY35roCOsl5SZchbWmOhAXBv/PKqha5zKPXVj+bG5xoEls4IqchaWzUx98021Zo/O
	gGne0lPLIcHJXTKtth75mxXFy6u4Vxm7ekaOfCqKMuxH0pthuqH8Rt5nqJM01VXiv6/m
	RHqw==
X-Gm-Message-State: APjAAAXmnQtDP8TTPILQPvur4isDGPtweyy1hKTSDrnFOCKB5OFIF6OZ
	U4O9MVIPmrIZhds7kaYrN079984H/hwxOg==
X-Google-Smtp-Source: APXvYqw8YKsdDQmEUDYrUgys0DnX/Dt+RkuFFT8rnX5yYW4C7boT37O9C9+aE+9pW0CQramrRe+NTA==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr8427282wma.2.1573226807102;
	Fri, 08 Nov 2019 07:26:47 -0800 (PST)
Received: from localhost.localdomain ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id
	w18sm6579232wrp.31.2019.11.08.07.26.45
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 08 Nov 2019 07:26:46 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/8] iommu: Add PASID support to Arm SMMUv3
Date: Fri,  8 Nov 2019 16:25:00 +0100
Message-Id: <20191108152508.4039168-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
	rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
	zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This is version 2 of the series I sent a while ago [1], adding PASID
support to the Arm SMMUv3 driver.

Changes since v1:
* Dropped the patch adding auxiliary domain support. It's an easy way to
  test PASID, by populating PASID contexts using iommu_map/unmap(), but
  I don't know if it will ever have real users. 

  Since v1 I changed my testing gear, and am using the zip accelerator
  [2] instead of a software model. It only uses SVA and testing
  auxiliary domains would require additional changes that would never go
  upstream. SVA requires another 20 patches (including I/O page faults)
  that I will send later, but at least I know that this will get used.

* ioasid patch has been carried by Jacob and should be merged for v5.5 [3]

* Split patch "Add support for Substream IDs" into patches 4 and 5.

* Added IORT support (patch 3) and addressed other comments.

[1] https://lore.kernel.org/linux-iommu/20190610184714.6786-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/linux-iommu/1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org/
[3] https://lore.kernel.org/linux-iommu/1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com/ 

Jean-Philippe Brucker (8):
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Support platform SSID
  ACPI/IORT: Support PASID for platform devices
  iommu/arm-smmu-v3: Prepare for SSID support
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Improve add_device() error handling
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/acpi/arm64/iort.c                     |  18 +
 drivers/iommu/arm-smmu-v3.c                   | 442 +++++++++++++++---
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/iommu.h                         |   2 +
 5 files changed, 419 insertions(+), 55 deletions(-)

-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
