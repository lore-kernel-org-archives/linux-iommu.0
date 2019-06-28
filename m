Return-Path: <SRS0=07Ha=U3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D949C4321A
	for <iommu@archiver.kernel.org>; Fri, 28 Jun 2019 11:04:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED6720645
	for <iommu@archiver.kernel.org>; Fri, 28 Jun 2019 11:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zGXGM3Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED6720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3882ACAB;
	Fri, 28 Jun 2019 11:04:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7571DC9E
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 11:04:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 33A0882F
	for <iommu@lists.linux-foundation.org>;
	Fri, 28 Jun 2019 11:04:45 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A15F8208E3;
	Fri, 28 Jun 2019 11:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561719884;
	bh=StUx9PONOQCmZX0nAG2V/FqWNZznDR+tHYF35sxlupY=;
	h=Date:From:To:Cc:Subject:From;
	b=zGXGM3CsSPG8rNfZKBK+hI0oUX0Srt2iG3bKpubpstG79EChhiXX0vNyOqOCh4elU
	9CsLldWuDgRR1dDwFDGn0uMIPurfZrJq/OEtTkyt0pfdaOKWJlYHd0c6wAPHnOZ+it
	gg06ysEXhayOj5b5+T0iZkvolN3YABe2JhuT5H8Y=
Date: Fri, 28 Jun 2019 12:04:40 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.3
Message-ID: <20190628110440.piorghrmwrbitmtz@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: jean-philippe.brucker@arm.com, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
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

Hi Joerg,

Please pull this handful of arm-smmu updates for 5.3. These changes include
support for the system cache present in some Qualcomm SoCs, better support
for non-coherent page-table walkers and a larger command queue size for
SMMUv3 implementations in preparation for some optimisations I've been
working on.

Thanks,

Will

--->8

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 9e6ea59f3ff37192fd7aec7821dca6ece629b7d0:

  iommu/io-pgtable: Support non-coherent page tables (2019-06-25 13:26:47 +0100)

----------------------------------------------------------------
Bjorn Andersson (1):
      iommu/io-pgtable: Support non-coherent page tables

Vivek Gautam (1):
      iommu/io-pgtable-arm: Add support to use system cache

Will Deacon (2):
      iommu/arm-smmu-v3: Increase maximum size of queues
      iommu/io-pgtable: Replace IO_PGTABLE_QUIRK_NO_DMA with specific flag

 drivers/iommu/arm-smmu-v3.c        | 58 +++++++++++++++++++++++++-------------
 drivers/iommu/arm-smmu.c           |  4 +--
 drivers/iommu/io-pgtable-arm-v7s.c | 17 ++++++-----
 drivers/iommu/io-pgtable-arm.c     | 40 ++++++++++++++++----------
 drivers/iommu/ipmmu-vmsa.c         |  1 +
 include/linux/io-pgtable.h         | 11 +++-----
 include/linux/iommu.h              |  6 ++++
 7 files changed, 86 insertions(+), 51 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
