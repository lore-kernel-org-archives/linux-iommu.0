Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BA0C433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 11:39:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCDA23A03
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 11:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCDA23A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6CA4F875B4;
	Fri,  8 Jan 2021 11:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNx8V59Esf3l; Fri,  8 Jan 2021 11:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8ED358752F;
	Fri,  8 Jan 2021 11:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B056C088B;
	Fri,  8 Jan 2021 11:39:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3CB3C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BB04F86DA6
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37w2I6xMbmCN for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 11:39:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E0C386D80
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:39:19 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id x12so5512901plr.10
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zqhNu7rpIl9rLybT73zELGUOuCv+WJC3uqUOvsWqqA0=;
 b=eqfwQ3Fp762qCIok60TM5s2O/Sr5NX1OOSHYUTd/Pn+A8pGLVj1V6pRRB2LXSVUJlr
 gU1bweZFHACXbd5FgP/+NndsOZW9eTeev4wiFC0cSzXGk8z+jFzY0mSbmseFZb/++Stn
 H05bgYKavXqxY2g+4mVVBdPDws4P8YEzevsSvlJUzRmlqn8He9k4a4X/T/ZRwwrMOPOA
 vVG6SdtiziVm/dVbB+goHJFPRybzlNpxwc+Q3jXZJRrvki3y7Ez7pcln05Id65JGau+i
 lXG4Ulf3qpfGNL+7N5HCRSXGJdhAsapzuxGU50XhpLeN7JSfbb2wx44YTqA6ua9j/wsm
 m6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zqhNu7rpIl9rLybT73zELGUOuCv+WJC3uqUOvsWqqA0=;
 b=SkIMm2VxLDVUbAjPdeZO39MQ61O/Wvq70qlx0PSFW767O2Al4Pgmr5H7/3aLpW5nVt
 aaiSwlSyKjDV38PEIo2+wZ/TVV7Pkd4wPcMgdlu3NbvF3krRVe+Xdi7L6w60g+UqgHKB
 pyTxEN+kWhHxdYjtHPP5anxuROfabCZYWbukUI5nUklMdwT/uAgyBKHS4OAN5pDClTLh
 Ve1SUZNa5cCmhwCbAryO27piAQCSuF3hb2bDKcBryDdgzuetHo4dlQ+LQAngBDQWa4m4
 A03gMijTKOrOC5yVbyce/UurQFhv+mGszzegI2o5CdkPHtQa0Alw70+0rQdu41TF/bTL
 rWig==
X-Gm-Message-State: AOAM533cQAki61009c6wms6ScnzjTWbYpzOvCVP5ffgYOhmHEITCAL5G
 eF42Qig32Xb+MZMSpkzyo+0=
X-Google-Smtp-Source: ABdhPJzrdL2ounVef6ajtJjfdM7Td6F/cZRbaDKql8n+e0SLpSuJYPUM19pG3R5DiYRHqBhjdpixCg==
X-Received: by 2002:a17:902:bf44:b029:da:d140:6f91 with SMTP id
 u4-20020a170902bf44b02900dad1406f91mr6594936pls.51.1610105959252; 
 Fri, 08 Jan 2021 03:39:19 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id gm18sm4589136pjb.55.2021.01.08.03.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 03:39:18 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH V2 0/2] Add Unisoc iommu basic driver
Date: Fri,  8 Jan 2021 19:38:49 +0800
Message-Id: <20210108113851.354947-1-zhang.lyra@gmail.com>
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

 .../devicetree/bindings/iommu/sprd,iommu.yaml |  44 ++
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/sprd-iommu.c                    | 546 ++++++++++++++++++
 4 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/sprd-iommu.c

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
