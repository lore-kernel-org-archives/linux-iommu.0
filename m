Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF662C8300B
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:03:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9698020838
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nG1oE4Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9698020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 565D1204F1;
	Thu, 30 Apr 2020 10:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeRem2dFDWJ7; Thu, 30 Apr 2020 10:03:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 34D5E204C2;
	Thu, 30 Apr 2020 10:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01766C0889;
	Thu, 30 Apr 2020 10:03:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DD84C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F1C8288683
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLyKdvf6z8Pf for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 10:03:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0F939885D3
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:03:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588240988; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=k6Jww9+9URymQ1brdiMyrmnMNV87/1Nh4t6HUYL74r0=;
 b=nG1oE4Fb40Ge8KiaqZkkqGp03rgHa9yN6nDJmq+diXxSTyEG23NB2E3GZop0C2M67V5HNuK9
 dIUoQn8cht6JdzZRpvkNhJrJkOYC0tW/cmhtU9p/ngIwM7xf79BrrqLOV0qtn3YZzxi/PDpj
 6oXB0ToaI0dPC967uG1qhpjSNGE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaa259.7f2983326a78-smtp-out-n04;
 Thu, 30 Apr 2020 10:03:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E7734C433CB; Thu, 30 Apr 2020 10:03:04 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id EEBF6C433BA;
 Thu, 30 Apr 2020 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEBF6C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for MMIO
Date: Thu, 30 Apr 2020 15:32:55 +0530
Message-Id: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 alex.bennee@linaro.org, vatsa@codeaurora.org, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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

The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 
[1] summarizes some of the problems we have in making virtio work on such
hypervisors. This patch proposes a solution for transport problem viz how we can
do config space IO on such a hypervisor. Hypervisor specific methods
introduced allows for seamless IO of config space.

This patch is meant to seek comments. If its considered to be in right
direction, will work on making it more complete and send the next version!

1. https://lkml.org/lkml/2020/4/28/427

Srivatsa Vaddagiri (1):
  virtio: Introduce MMIO ops

 drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
 include/linux/virtio.h       |  14 +++++
 2 files changed, 94 insertions(+), 51 deletions(-)

-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
