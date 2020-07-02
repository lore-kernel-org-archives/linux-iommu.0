Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85A6C433E0
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:41:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B171207D4
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="SeQg6bRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B171207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 55F008976E;
	Thu,  2 Jul 2020 20:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id An2tLcL-ycix; Thu,  2 Jul 2020 20:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C922D89730;
	Thu,  2 Jul 2020 20:41:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD377C0890;
	Thu,  2 Jul 2020 20:41:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83DE3C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6DA4B87780
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaY+8xo9hAYt for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 20:41:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E1A1B87758
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:41:23 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id b25so30355915ljp.6
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jul 2020 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=89gsiA7+bVZ+IYsObbOq4QNYGioS8fOEnycohDBafRU=;
 b=SeQg6bRxsTjFsGcwQzWxB3XEisRTzLRjuA/ey7GHDgP74NdLIBJfhgpiwkuG8gxBi/
 SxnYxKq6ynMP6io4YDnNy600UZzu/Sa45BZSat9qzIe7XAt4ejdl0IH5y4zCBbsJlsVX
 OXIUx0SQmXiNInOWt5+pA4ItNwYlN0TFKGsyO11KkE8OcuwLXDAw8h35wvjv+zJ+2UTH
 RfWeuIdKRmTaki9jspbxz11H34agHKTuKmuB4a6HwoThOFqkAKkBgURdC2Ayk+xeecVB
 Tqa3upQVxqHI+BxZsMpjM71loT+buTuFxaVzjuei6+9apVYIH+pUeIj6csgvgEFozEzU
 SLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=89gsiA7+bVZ+IYsObbOq4QNYGioS8fOEnycohDBafRU=;
 b=U5ykGGEcnWluK1Pdaa7QU3H1yzsY+ZBqVsTYK1ZJawmPkEttzQvhJa/QYCNUrakrm0
 JKhLYTf/5cylSfKIeDA02n9lYrgHmsIHf1PWBdKX/4MgTm4AHvXdOvQDgsXg7m+Ilerh
 bNNjEViSiuloxtWHANoSwrNGIDQvMegQ6NLKOQX1Hgv7Ckh0quVrGybsmdLkTyND9HXP
 XnAFcXJM5QScUAmAJcixomcCLqGPEcme68Ps+anB9+aPrurDubthZmtrfeVgK5udPIwl
 qIvALj1j9jfpOD/rP8PW0Xrepj5GS3kt8/+APE0SPGHGsNGLodrhXlfthEK2Np/vwovc
 gENA==
X-Gm-Message-State: AOAM531QwWyC8AJeP8N5K0cZfh/+sTp7Mr+rlBFDJM7ZCYPJi1Q+qaX7
 V33q9pQQ+3EX7BcPnC9nNJIn+y0cz90=
X-Google-Smtp-Source: ABdhPJwDloDr2B+qvX8EPRVRO/2+akigxPEfLX/jJsPdos8x1RrqHbztjXXuOrcBB7+Bw8UKZx+ukg==
X-Received: by 2002:a19:8806:: with SMTP id k6mr19203409lfd.189.1593721017874; 
 Thu, 02 Jul 2020 13:16:57 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 13:16:57 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v3 0/4] Add system mmu support for Armada-806
Date: Thu,  2 Jul 2020 22:16:29 +0200
Message-Id: <20200702201633.22693-1-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

There were already two versions of series to support SMMU for AP806,
including workaround for accessing ARM SMMU 64bit registers.
First [1] by Hanna Hawa and second [2] by Gregory CLEMENT.
Since it got stuck this is yet another try. I incorporated the V2 comments,
mainly by moving workaround code to arm-smmu-impl.c as requested.

For the record, AP-806 can't access SMMU registers with 64bit width,
this patches split the readq/writeq into two 32bit accesses instead
and update DT bindings.

The series was successfully tested on a vanilla v5.8-rc3 kernel and
Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.

[1]: https://lkml.org/lkml/2018/10/15/373
[2]: https://lkml.org/lkml/2019/7/11/426

Hanna Hawa (1):
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743

Marcin Wojtas (1):
  arm64: dts: marvell: add SMMU support

Tomasz Nowicki (2):
  iommu/arm-smmu: Add SMMU ID2 register fixup hook
  dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806
    SMMU-500

 Documentation/arm64/silicon-errata.rst        |  3 ++
 .../devicetree/bindings/iommu/arm,smmu.yaml   |  5 ++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 36 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 17 ++++++
 drivers/iommu/arm-smmu-impl.c                 | 52 +++++++++++++++++++
 drivers/iommu/arm-smmu.c                      |  3 ++
 drivers/iommu/arm-smmu.h                      |  1 +
 7 files changed, 117 insertions(+)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
