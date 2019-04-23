Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B0BC10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18F820674
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 14:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 82C48C2C;
	Tue, 23 Apr 2019 14:57:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2F59AF7
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 14:57:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C3B61F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 14:57:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 7EDB328C; Tue, 23 Apr 2019 16:57:21 +0200 (CEST)
Date: Tue, 23 Apr 2019 16:57:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190423145721.GH29810@8bytes.org>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<20190418234828.GG126710@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190418234828.GG126710@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: poza@codeaurora.org, Scott Branden <sbranden@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Srinath Mannam <srinath.mannam@broadcom.com>,
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
Message-ID: <20190423145721.a4TxjilnDnoMuXFPlzW7aScxcDAO0vZ6qyLX-X9guis@z>

On Thu, Apr 18, 2019 at 06:48:28PM -0500, Bjorn Helgaas wrote:
> To make progress on this, I think we need an ack from Joerg for the
> dma-iommu.c part, an ack from Ray or Scott for the pcie-iproc.c part,
> and an ack from Robin for the thing as a whole.

I wait for Robin to review the dma-iommu change. If he is okay with it,
I am too.


	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
