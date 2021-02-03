Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF090C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 21:39:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AC664F5F
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 21:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AC664F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F0C4A862D4;
	Wed,  3 Feb 2021 21:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfSDFjGEvDlW; Wed,  3 Feb 2021 21:38:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 61528862BC;
	Wed,  3 Feb 2021 21:38:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 442F3C0FA8;
	Wed,  3 Feb 2021 21:38:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84086C0174
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 21:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 643D38632F
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 21:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RgvvS-vGrHXo for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 21:38:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A703D862E6
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 21:38:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F076364E4E;
 Wed,  3 Feb 2021 21:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612388336;
 bh=5xUxBDW4OR/X+ihgK7OEkPyP7BNmZM0B6O6DiRot4ys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oYM8JsucRMsrFPkfKzm/QzqiNMbkJUnEDxYSkP4i6Mm8C66zH+v4SijauYtf+kxxH
 0SIIg/HvpvVsrqoTrKlc0PsxeXZjCm96/1LjvmkyPKaSk7q/OX1GfdpB5AKvCAWiV4
 0ExInEg1jJhIoliUrKI5T2plImsi+xYvgYbRui/6Nps2HKHmUyjUcZqN6lTV+PljEa
 cX2JJgXYg78mElVhKVPwzRsWkLu7HjP5b9EYXsBSVmWhqsDJs/YhX66aXD+p0xoxiV
 mSLc6+YksnErlPhxUAG38oa7K9SumjJjiPQOhCrqdezlpTFn7AbsgAjabOk3SBU0Vu
 Wvy9rtpfzeEPg==
Date: Wed, 3 Feb 2021 21:38:51 +0000
From: Will Deacon <will@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add debug interfaces for SMMUv3
Message-ID: <20210203213851.GA19847@willie-the-truck>
References: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
 <5001d8b3-ed2c-f3e3-80c5-d0b6b5df634c@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5001d8b3-ed2c-f3e3-80c5-d0b6b5df634c@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, iommu@lists.linux-foundation.org,
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

On Wed, Feb 03, 2021 at 11:15:18AM +0800, Zhou Wang wrote:
> On 2021/1/29 17:06, Zhou Wang wrote:
> > This RFC series is the followed patch of this discussion:
> > https://www.spinics.net/lists/arm-kernel/msg866187.html. 
> > 
> > Currently there is no debug interface about SMMUv3 driver, which makes it
> > not convenient when we want to dump some information, like the value of
> > CD/STE, S1/S2 page table, SMMU registers or cmd/event/pri queues.
> > 
> > This series tries to add support of dumping CD/STE and page table. The
> > interface design is that user sets device/pasid firstly by sysfs files
> > and then read related sysfs file to get information:
> > 
> >  (currently only support PCI device)
> >  echo <domain>:<bus>:<dev>.<fun> > /sys/kernel/debug/iommu/smmuv3/pci_dev
> >  echo <pasid> > /sys/kernel/debug/iommu/smmuv3/pasid
> >  
> >  Then value in CD and STE can be got by:
> >  cat /sys/kernel/debug/iommu/smmuv3/ste
> >  cat /sys/kernel/debug/iommu/smmuv3/cd
> >  
> >  S1 and S2 page tables can be got by:
> >  cat /sys/kernel/debug/iommu/smmuv3/pt_dump_s1
> >  cat /sys/kernel/debug/iommu/smmuv3/pt_dump_s2
> > 
> > For STE, CD and page table, related device and pasid are set in pci_dev
> > and pasid files as above.
> > 
> > First and second patch export some help functions or macros in arm-smmu-v3
> > and io-pgtable-arm codes, so we can reuse them in debugfs.c. As a RFC, this
> > series does not go further to dump SMMU registers and cmd/event/pri queues.
> > I am not sure this series is in the right way, so let's post it out and have a
> > discussion. Looking forward to any feedback.
> > 
> > Zhou Wang (3):
> >   iommu/arm-smmu-v3: Export cd/ste get functions
> >   iommu/io-pgtable: Export page table walk needed functions and macros
> >   iommu/arm-smmu-v3: Add debug interfaces for SMMUv3
> > 
> >  drivers/iommu/Kconfig                       |  11 +
> >  drivers/iommu/arm/arm-smmu-v3/Makefile      |   1 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  10 +-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  10 +
> >  drivers/iommu/arm/arm-smmu-v3/debugfs.c     | 398 ++++++++++++++++++++++++++++
> >  drivers/iommu/io-pgtable-arm.c              |  47 +---
> >  drivers/iommu/io-pgtable-arm.h              |  43 +++
> >  7 files changed, 475 insertions(+), 45 deletions(-)
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/debugfs.c
> > 
> 
> Any comments about this series?

Truthfully, I don't really see the use in dumping the state of the SMMU
data structures. They're not especially dynamic, and there are higher level
ways to determine how devices map to groups etc.

However, I can see some utility in dumping the page-tables. We have that
functionality for the CPU side via /sys/kernel/debug/kernel_page_tables,
so something similar in the io-pgtable code could be quite neat. In
particular, the logic to expose things in debugfs and drive the dumping
could be agnostic of the page-table format, while the formats themselves
coule implement optional callback(s) to return the data.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
