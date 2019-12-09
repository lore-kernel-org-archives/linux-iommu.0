Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AB6C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297C62068E
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u91aLh+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297C62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DA1B62041C;
	Mon,  9 Dec 2019 14:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lfYu+fsGKFj5; Mon,  9 Dec 2019 14:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7D1D2203F4;
	Mon,  9 Dec 2019 14:50:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6264AC1D7F;
	Mon,  9 Dec 2019 14:50:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C34DC0881;
 Mon,  9 Dec 2019 14:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2762087DDE;
 Mon,  9 Dec 2019 14:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPxlYZKqXo9R; Mon,  9 Dec 2019 14:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DA1F887F52;
 Mon,  9 Dec 2019 14:50:11 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id d16so16478837wre.10;
 Mon, 09 Dec 2019 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7g3wSCUkuYWHZsY797oGKzqOQQtMHGZXYj3iutCpVxs=;
 b=u91aLh+YeBCHC44kayet3YM2AUntkYXMMX1pB/CSCzoAIFP+uLAcMwnJdsc7rbnQ+U
 En/u38xmp/ZaSrMelXHGaVP52bkx1ZHf6fa0G31V+GUhQS0AaFSn7ys+h8RO1NV7WwV8
 ymTsoKVUUeJQKGShJcXhRTy2EGqLJh6aGXWYBXpnjQEUtLbQuGVBa6A2YqkH5uprWm/d
 vExxTU69ZDydrFyUChrYMXLctHuRAFns98Wcf6gFerjB0lv8isbF6NZZB1yfy5BvtY8n
 PFFHY7dkbo8v2ddCOwEwVVHdCIfhIVbhWl9DBEzdztx/PK8tsG39arQVINGlMjwc9u28
 QbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7g3wSCUkuYWHZsY797oGKzqOQQtMHGZXYj3iutCpVxs=;
 b=gtBfHQ1hhhpKsVtMg9skkWz5bOfRMVkxJxSbxTjrwqpWeZAbvRGUsnPhGGAGmN8jea
 +KCbKMW/ZBd6tThzRqDXuvqwuR8fIZslfr3FVFujFM4ZS4RFSfImnyu72o0VurHpBtD/
 vzZj7HlKEc2UgK2YN5R/wPM1MZq9M9oQl0iC0SyyUvZUbWOnUB3TOeSI3BybbFQZDLLo
 TuhNluYGG8rA728gUTnJXjvqpDARgSF4S1X3w9gJBtDEPEufamF3H534l6A66ojG3lFk
 EfMyZvAmMByrT9ZeFnDa899MbYdUpLVX/mCySzQbRtgoemb7b4cQVeuJ5I+zcwH/3qjY
 ILVg==
X-Gm-Message-State: APjAAAVzMRBhJY3EhgoMyjpt8tTDqu/TQaJFkfofc3bI6EBxCOF526eD
 AoUi+5C2qXa4qQ7Tb85ff+c=
X-Google-Smtp-Source: APXvYqwgHRCIfDFUwn/zmwWNRl9/DgRU5Wwz5H2iHGf8TX85hbSYzSKuX7Aal6o+CbkISCPQgbBhvQ==
X-Received: by 2002:adf:e984:: with SMTP id h4mr2512872wrm.275.1575903009994; 
 Mon, 09 Dec 2019 06:50:09 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id s82sm13863411wms.28.2019.12.09.06.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 06:50:08 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 0/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Mon,  9 Dec 2019 15:50:02 +0100
Message-Id: <20191209145007.2433144-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Most IOMMU drivers only need to free the memory allocated for each
reserved region. Instead of open-coding the loop to do this in each
driver, extract the code into a common function that can be used by
all these drivers.

Changes in v2:
- change subject prefix to "iommu: virtio: " for virtio-iommu.c driver

Thierry

Thierry Reding (5):
  iommu: Implement iommu_put_resv_regions_simple()
  iommu: arm: Use iommu_put_resv_regions_simple()
  iommu: amd: Use iommu_put_resv_regions_simple()
  iommu: intel: Use iommu_put_resv_regions_simple()
  iommu: virtio: Use iommu_put_resv_regions_simple()

 drivers/iommu/amd_iommu.c    | 11 +----------
 drivers/iommu/arm-smmu-v3.c  | 11 +----------
 drivers/iommu/arm-smmu.c     | 11 +----------
 drivers/iommu/intel-iommu.c  | 11 +----------
 drivers/iommu/iommu.c        | 19 +++++++++++++++++++
 drivers/iommu/virtio-iommu.c | 14 +++-----------
 include/linux/iommu.h        |  2 ++
 7 files changed, 28 insertions(+), 51 deletions(-)

-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
