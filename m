Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD62C433E4
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783392065E
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="RuYIhyy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783392065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 26D338AB2A;
	Wed, 15 Jul 2020 07:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAkNf6v4YX41; Wed, 15 Jul 2020 07:07:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1615A8AB22;
	Wed, 15 Jul 2020 07:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECAC5C07FF;
	Wed, 15 Jul 2020 07:07:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89338C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 783DD8A7DF
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cDBVI0hFVKs for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 07:07:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 814238A7DE
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:01 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id j11so1367560ljo.7
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=f+OWOpfWyZI+F0HgW7n2hwhFXyMKZItWbfC1yFlsvCc=;
 b=RuYIhyy6Vun1cpT90eal+PKxa32bFtRJ4QJZsVJCnrgQX0fss6A3cp4kx135P7vbO5
 xBGcSD0hKkXa7L5uL2fhiOWgEreLdOaGpLZts88rFUhOIEMdeYo270DHzNNKWnse8pET
 s/r8obiibS+e9uTzvXbGYQN/5/l7eIlyeEpH0UPYC5875GyJm9FveAe4HGs+mlat90kk
 cQ5hxa7Io2yvoTRdrfQ6HOknyLICzTIWPiRaYctpISOCsalAuuLuOJALPhgNrb+tt0yh
 i6B9Cw7bk3T9eURK3leVgsUKSD1xmMuodu6Cdzc9Wgh1IWK1T0s8SL86N1QNdtksWTlA
 hT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=f+OWOpfWyZI+F0HgW7n2hwhFXyMKZItWbfC1yFlsvCc=;
 b=D0yDLlaW/RPpaFwwzLtQz4fI2SdSGoXjO7jk3wiceEOhDPxlohXDR54E2T5JAPvRSP
 doTh1QEDPULsT8wHrLzgQGfUC/dGJsjifrXeQwmiZO2HoIEWIzAmhdHdkaTkVQYBrHB+
 t/du9KKZH29EU1KrlXhx0Ht3/cHsJZDSVa+wOFasLcg59HAdV55K+V/xmbsJeBBxmtuq
 FoNjCaZckR9CwMqpqN/XStsEVW+8D1oyTHxkf/o/7hl/jgVCgqdZtCje/Y8JHKeHS2yR
 ZvGQRzfrkYIzs/ZuOavGgDh/BR4FGk8TjvDaUTZYmz5/zF4+nrbwMBAu4sRUHW+qKRPJ
 hjtw==
X-Gm-Message-State: AOAM532KsVYKiWbymLnpBlzl7LHKS1ZU6JqThf+XFduBnq35PTpievL+
 2BE1pEVtWagSYBzKl/bM1qDToA==
X-Google-Smtp-Source: ABdhPJySFX/Z8aMMJm+W1T7u3FGwHCXcNbKvVxMytXVqr0/sY0t9GCaz6iJJoGgIyrffm7iJaeHtDg==
X-Received: by 2002:a2e:9dd6:: with SMTP id x22mr4201166ljj.199.1594796819526; 
 Wed, 15 Jul 2020 00:06:59 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 00:06:58 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v4 0/4] Add system mmu support for Armada-806
Date: Wed, 15 Jul 2020 09:06:45 +0200
Message-Id: <20200715070649.18733-1-tn@semihalf.com>
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

The series is meant to support SMMU for AP806 and a workaround
for accessing ARM SMMU 64bit registers is the gist of it.

For the record, AP-806 can't access SMMU registers with 64bit width.
This patches split the readq/writeq into two 32bit accesses instead
and update DT bindings.

The series was successfully tested on a vanilla v5.8-rc3 kernel and
Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.

For reference, previous versions are listed below:
V1: https://lkml.org/lkml/2018/10/15/373
V2: https://lkml.org/lkml/2019/7/11/426
V3: https://lkml.org/lkml/2020/7/2/1114

v3 -> v4
- call cfg_probe() impl hook a bit earlier which simplifies errata handling
- use hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() for register accessors
- keep SMMU status disabled by default and enable where possible (DTS changes)
- commit logs improvements and other minor fixes

Hanna Hawa (1):
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743

Marcin Wojtas (1):
  arm64: dts: marvell: add SMMU support

Tomasz Nowicki (2):
  iommu/arm-smmu: Call configuration impl hook before consuming features
  dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806
    SMMU-500

 Documentation/arm64/silicon-errata.rst        |  3 ++
 .../devicetree/bindings/iommu/arm,smmu.yaml   |  4 ++
 arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 ++++++++
 drivers/iommu/arm-smmu-impl.c                 | 45 +++++++++++++++++++
 drivers/iommu/arm-smmu.c                      | 11 +++--
 7 files changed, 145 insertions(+), 4 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
