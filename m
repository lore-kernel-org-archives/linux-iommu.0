Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A8C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 11:24:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EB6238E3
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 11:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EB6238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D0B9C21505;
	Thu, 21 Jan 2021 11:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D75i5sXEv1UP; Thu, 21 Jan 2021 11:24:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 250B920394;
	Thu, 21 Jan 2021 11:24:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14ADAC088B;
	Thu, 21 Jan 2021 11:24:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78BAAC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 11:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6086C871BE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 11:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cyU5UBIn-Ih3 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 11:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5709187047
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 11:23:58 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id c132so1173752pga.3
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 03:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+dwMNQdsfc0B7LWCmiGdKrYTGwJcjbW3qAIMxL6EDkE=;
 b=q9jliqX0dMzwvBGgUDzDXXX02OOF2J6ETLKf+2D117zd2EQCM0xKHsPdgQbGJdIF3S
 xurB7KwcC3hKDLUPoLKLKsZ0LIIxp/f6TYeOJ6YMrL9oBq64v9th31GYDwlx3H1xfEUD
 MJmALiKZdEOjxT1L82ebbAfpoJQ6O8i/njTe0p6slk6ELGVKqM1KiUjLy1IH1fFidNJf
 CpvqvP1TMQgvqfUsFF0RlCKgMfMn0FSIkgayW3hfXDUKRC/PndIv9+AhMp9iIAHW6cYA
 1EUhgwJWH+oEIe8g4niaNwqzfPpnlqvjKHwkFDyeuQulxuNbIoGXHRFQ7uLK/pUnzrgC
 jAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+dwMNQdsfc0B7LWCmiGdKrYTGwJcjbW3qAIMxL6EDkE=;
 b=mpQo+TYaOZVkQnj36bXy+NIm592Z7TT/SrUq69IfFiwAl1dcM1q9DfexEd7GT97+O8
 A/B6lEhsKTuMcdfuT6F7V8VpgypWrQS7s/eR0tafEXByLIuv05cCQT7YAn9mMky7tD8w
 fpETJA/09GGNWEfe9C0BxFin3hz+C6Zt7czW6j3hLDtfFoAWP1jfS44EEY4hv3TnOZf+
 4MowopLhqiJj2C3X/rypFUSufo9I/bZMwA2+AhGcKp1QRNabeni0qZntt+i+oFs6fipk
 yYQPuhoPREUHQblXVzcGBD5BnUBV0z8y80tKyOD2+95jQNAlo5eIjveOLqEIxSOu+/tJ
 AU1Q==
X-Gm-Message-State: AOAM530ZbgAEL1z1a01n0ppilTLftIjrxYIjGnTStn9R0A3mRb+VPdxf
 +RSWfQQjyZuPa1HEqgvwedA=
X-Google-Smtp-Source: ABdhPJzaNQk/PFHKh9VY/S1vQeP4i13jG0pKQ/8GVEMht4sAJP3A6JAJSTgKyUmaGUP05XtFcW4uLw==
X-Received: by 2002:a63:4851:: with SMTP id x17mr13776780pgk.451.1611228237897; 
 Thu, 21 Jan 2021 03:23:57 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id me5sm5404797pjb.19.2021.01.21.03.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 03:23:57 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v1 0/2] Add Unisoc iommu basic driver
Date: Thu, 21 Jan 2021 19:23:47 +0800
Message-Id: <20210121112349.421464-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  45 ++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 566 ++++++++++++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
