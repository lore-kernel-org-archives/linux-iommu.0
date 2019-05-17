Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A201C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:06:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DA72087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AToqaOcX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SOz/6r03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DA72087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 907ADC8E;
	Fri, 17 May 2019 19:05:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 11EEBAA5
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A8A4E5E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:48:14 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E7CE361791; Fri, 17 May 2019 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558118894;
	bh=35zZ5q4uMp/3q4Z0JDCSvFDAAIE0REjNe04GsZlSd9s=;
	h=From:To:Cc:Subject:Date:From;
	b=AToqaOcX8yhF5Pu1zyFgoyQExBnfvS098MchxW86H4i/BZqZzg2Jh6mS6ZqcuBc1c
	Yy4koWO1Gtt/+RBCFY0vJl683Nm2jcvG6bWGCnklDCmQ9zX7SknI3PT23qLBEHU4tq
	SgBarHAMsAv+Upe5RTn8qIT6g86n3aT5cXDxTytM=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: isaacm@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 736716179C;
	Fri, 17 May 2019 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1558118891;
	bh=35zZ5q4uMp/3q4Z0JDCSvFDAAIE0REjNe04GsZlSd9s=;
	h=From:To:Cc:Subject:Date:From;
	b=SOz/6r03g7SCcJGbSThbJKQnFy/ydy//GRaazg08v/2nnzbeA2kfwt+7DU/h5VOl4
	xXmNB0yQSIchcnRZzMOY3UoRMEbtrWtzv2tggQZPxIPf3+VznmC4rVcRLPMToj7grj
	pn7Xia0PvsazfTd/chmiqRi5k+mz1Ap3FJqYLL18=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 736716179C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC/PATCH 0/4] Initial support for modular IOMMU drivers
Date: Fri, 17 May 2019 11:47:33 -0700
Message-Id: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Fri, 17 May 2019 19:05:24 +0000
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
	robin.murphy@arm.com, will.deacon@arm.com, lmark@codeaurora.org,
	robh+dt@kernel.org, bhelgaas@google.com, frowand.list@gmail.com,
	pratikp@codeaurora.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This series adds initial support for being able to use the ARM
SMMU driver as a loadable kernel module. The series also adds
to the IOMMU framework, so that it can defer probing for devices
that depend on an IOMMU driver that may be a loadable module.

The primary reason behind these changes is that having the ARM
SMMU driver as a module allows for the same kernel image to be
used across different platforms. For example, if one platform
contains an IOMMU that implements one version of the ARM SMMU
specification, and another platform simply does not have an
IOMMU, the only way that these platforms can share the same
kernel image is if the ARM SMMU driver is compiled into the
kernel image.

This solution is not scalable, as it will lead to bloating the
kernel image with support for several future versions of the
SMMU specification to maintain a common kernel image that works
across all platforms. Having the ARM SMMU driver as a module allows
for a common kernel image to be supported across all platforms,
while yielding a smaller kernel image size, since the correct
SMMU driver can be loaded at runtime, if necessary.

Patchset Summary:

1. Since the ARM SMMU driver depends on symbols being exported from
several subsystems, the first three patches are dedicated to exporting
the necessary symbols.

2. Similar to how the pinctrl framework handles deferring probes,
the subsequent patch makes it so that the IOMMU framework will defer
probes indefinitely if there is a chance that the IOMMU driver that a
device is waiting for is a module. Otherwise, it upholds the current
behavior of stopping probe deferrals once all of the builtin drivers
have finished probing.

The ARM SMMU driver currently has support for the deprecated
"mmu-masters" binding, which relies on the notion of initcall
ordering for setting the bus ops to ensure that all SMMU devices
have been bound to the driver. This poses a problem with
making the driver a module, as there is no such notion with
loadable modules. Will support for this be completely deprecated?
If not, might it be useful to leverage the device tree ordering,
and assign a property to the last SMMU device, and set the bus ops
at that point? Or perhaps have some deferred timer based approach
to know when to set the bus ops? 

Thanks,
Isaac

Isaac J. Manjarres (4):
  of: Export of_phandle_iterator_args() to modules
  PCI: Export PCI ACS and DMA searching functions to modules
  iommu: Export core IOMMU functions to kernel modules
  iommu: Add probe deferral support for IOMMU kernel modules

 drivers/iommu/iommu-sysfs.c | 3 +++
 drivers/iommu/iommu.c       | 6 ++++++
 drivers/iommu/of_iommu.c    | 8 ++++++--
 drivers/of/base.c           | 1 +
 drivers/pci/pci.c           | 1 +
 drivers/pci/search.c        | 1 +
 6 files changed, 18 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
