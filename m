Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C55C282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 14:37:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909BD20721
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 14:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909BD20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FF4686AB6;
	Thu,  9 Jan 2020 14:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWAS-Sa6ZucB; Thu,  9 Jan 2020 14:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD630868CA;
	Thu,  9 Jan 2020 14:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAD8CC18DC;
	Thu,  9 Jan 2020 14:37:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB137C0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9A5F485AFF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XbeD43QD7rdk for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 14:37:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 224AF85ACC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:37:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 25B8D68BFE; Thu,  9 Jan 2020 15:37:01 +0100 (CET)
Date: Thu, 9 Jan 2020 15:37:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [RFC 5/5] x86/PCI: Remove unused X86_DEV_DMA_OPS
Message-ID: <20200109143700.GD22656@lst.de>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
 <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Tue, Dec 31, 2019 at 01:24:23PM -0700, Jon Derrick wrote:
> VMD was the only user of device dma operations. Now that the IOMMU has
> been made aware of direct DMA aliases, VMD domain devices can reference
> the VMD endpoint directly and the VMD device dma operations has been
> made obsolete.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

This seems to be a 1:1 copy of my patch from August?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
