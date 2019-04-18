Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96CAC10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 23:48:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4733206B6
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 23:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6uc45bH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4733206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 775552135;
	Thu, 18 Apr 2019 23:48:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 393DC212D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 23:48:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E595D828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 23:48:30 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 57DAE2171F;
	Thu, 18 Apr 2019 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555631310;
	bh=0BYxge2vHiinJrCTJtR2FiPW4myDFCQ17XL1+bP3YXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6uc45bHDbhcK0g052RfmkGM6XiHY0UASZ3UzJLylH7m/T90yErzvBRt4Yvj/z5UR
	V/WvbquJhzkKgEelY+1ROGTjzb7EibKqJ8WxN+b3oc52+KNcsQj/Hl5RqVNf+Ag967
	NmZyJVXnJePilIQgJVinTLnnU1atmSESp0fPfcZM=
Date: Thu, 18 Apr 2019 18:48:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190418234828.GG126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: poza@codeaurora.org, Scott Branden <sbranden@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418234828.rhRth69JGSv9zqPcN0ERxyeTS-LIuyGFHtg044TiCD0@z>

[+cc Scott]

On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
> 
> PCIe Host driver of those SOCs has to list resource entries of allowed
> address ranges given in dma-ranges DT property in sorted order. This
> sorted list of resources will be processed and reserve IOVA address for
> inaccessible address holes while initializing IOMMU domain.
> 
> This patch set is based on Linux-5.0-rc2.
> 
> Changes from v3:
>   - Addressed Robin Murphy review comments.
>     - pcie-iproc: parse dma-ranges and make sorted resource list.
>     - dma-iommu: process list and reserve gaps between entries
> 
> Changes from v2:
>   - Patch set rebased to Linux-5.0-rc2
> 
> Changes from v1:
>   - Addressed Oza review comments.
> 
> Srinath Mannam (3):
>   PCI: Add dma_ranges window list
>   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
>   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> 
>  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 66 insertions(+), 1 deletion(-)

To make progress on this, I think we need an ack from Joerg for the
dma-iommu.c part, an ack from Ray or Scott for the pcie-iproc.c part,
and an ack from Robin for the thing as a whole.

Then I would say Lorenzo should take a look and merge if he approves, since
pcie-iproc.c contains the most changes.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
