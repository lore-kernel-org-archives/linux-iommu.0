Return-Path: <SRS0=Rrtl=2Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B1DC2D0C0
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 22:40:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28BC2080D
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 22:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vy0udCBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28BC2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B64758659B;
	Thu, 26 Dec 2019 22:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1iLRi6F+0eB5; Thu, 26 Dec 2019 22:40:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D2C386450;
	Thu, 26 Dec 2019 22:40:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3083C18DD;
	Thu, 26 Dec 2019 22:40:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB712C0881
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D1BCA85239
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nc-gobVh9HX1 for <iommu@lists.linux-foundation.org>;
 Thu, 26 Dec 2019 22:39:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A083A848ED
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:39:58 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id x17so10978496pln.1
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P7ESk9eQMRZr+kEQuMK0Z8FaJecR+BKoIpQxePhdF6o=;
 b=Vy0udCBfVuzARF9m0mc/Z7ONkkt6IwY8DJpXMCucBLV7TsxIK5bJ8eO+LLIwhAcreh
 CkGkrzG9pykpqkkC/iNQkJrXOTJJzLxzLV2Af/tFrnzxwp0qxTioh5LFMW+8Qa/ptf8o
 GvOs519X10lPwvXPESozI0QrNaX466/0LxX4ZzyLb2JEiPJbe/6z0MBezOrlDr7xPNgR
 2jQYAUfXVZDB8eexJKD56ciO+LezslNbzyWDQHcJi4/bSTbbK05iRhwJT63FtAgIJDnn
 nza9W86KONxRz8DtZsKb3Yj3k2PFTrn5o2z/X3XQmu3ZvTxV3fi4qyFLvI72CP4p/Uzr
 wXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P7ESk9eQMRZr+kEQuMK0Z8FaJecR+BKoIpQxePhdF6o=;
 b=CKgTMnL9CZspS+blVdP/juXH8I5HR93TBS2zZ0quzZyZT+1rI+qwmrok/crOft4k09
 XF/8z4xQe4y62WwL6aAyejaslvBXNV13eI7LMGSGl/bT4+31148+Z1tSbMDw8Q1RXJa3
 VnUgGr179+xCmEuiQwneQfee3LaSzP9CXEU49nCm7kHJTwgl1Ba2hLfS47Zz5FxBetZD
 pSh8OVJni3ftx2UGayOQnXkIrH6O8auYO6qcfN2Oa0tyN+J0/pbcTn3S4KTOlWMt040l
 6FwFnQbBmZHi0YZxCp/6vb7JAVPsb1PfX8AEg2kwApO9hk4kTGws0VdNyKMRrj+HaO5T
 lLlg==
X-Gm-Message-State: APjAAAW0kcIRPwv4fYegbyCk/3YOPkvZs52edbxlem4Mx7/v5PtNd/Y6
 Vwj7vLNHBTZt5tZHCEZBIsw3IsByHak=
X-Google-Smtp-Source: APXvYqzeKxoKEB96j5hPs7KlRto6hP0WKGq35P+5NZsItv40vaoBcyhUle3i4Zaj9vYVjTLZejXkWA==
X-Received: by 2002:a17:90a:1a0d:: with SMTP id
 13mr22096750pjk.129.1577398664714; 
 Thu, 26 Dec 2019 14:17:44 -0800 (PST)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 2sm11779409pjh.19.2019.12.26.14.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2019 14:17:44 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
Date: Thu, 26 Dec 2019 14:17:06 -0800
Message-Id: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: Patrick Daly <pdaly@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Pratik Patel <pratikp@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

These patches implements the stream mapping inheritance that's necessary in
order to not hit a security violation as the display hardware looses its stream
mapping during initialization of arm-smmu in various Qualcomm platforms.

This was previously posted as an RFC [1], changes since then involves the
rebase and migration of the read-back code to the Qualcomm specific
implementation, the mapping is maintained indefinitely - to handle probe
deferring clients - and rewritten commit messages.

[1] https://lore.kernel.org/linux-arm-msm/20190605210856.20677-1-bjorn.andersson@linaro.org/

Bjorn Andersson (3):
  iommu/arm-smmu: Don't blindly use first SMR to calculate mask
  iommu/arm-smmu: Expose s2cr and smr structs to impl
  iommu/arm-smmu: Allow inherting stream mapping from bootloader

 drivers/iommu/arm-smmu-qcom.c | 35 ++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 70 +++++++++++++++++++++++------------
 drivers/iommu/arm-smmu.h      | 15 ++++++++
 3 files changed, 96 insertions(+), 24 deletions(-)

-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
