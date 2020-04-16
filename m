Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE7DC2BA2B
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 07:01:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0A0206A2
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 07:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0A0206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C0079220C1;
	Thu, 16 Apr 2020 07:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVf1oYQGEHDM; Thu, 16 Apr 2020 07:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9658622049;
	Thu, 16 Apr 2020 07:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 754E3C1AE8;
	Thu, 16 Apr 2020 07:01:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46DEEC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 07:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3109A861BC
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 07:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbM6AHLTK5Tk for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 07:01:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 07EB28616A
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 07:01:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E33368C4E; Thu, 16 Apr 2020 09:01:03 +0200 (CEST)
Date: Thu, 16 Apr 2020 09:01:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 1/3] iommu/vt-d: Allow 32bit devices to uses DMA domain
Message-ID: <20200416070102.GA12588@lst.de>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com>
 <20200416062354.10307-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416062354.10307-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

On Thu, Apr 16, 2020 at 02:23:52PM +0800, Lu Baolu wrote:
> Currently, if a 32bit device initially uses an identity domain,
> Intel IOMMU driver will convert it forcibly to a DMA one if its
> address capability is not enough for the whole system memory.
> The motivation was to overcome the overhead caused by possible
> bounced buffer.
> 
> Unfortunately, this improvement has led to many problems. For
> example, some 32bit devices are required to use an identity
> domain, forcing them to use DMA domain will cause the device
> not to work anymore. On the other hand, the VMD sub-devices
> share a domain but each sub-device might have different address
> capability. Forcing a VMD sub-device to use DMA domain blindly
> will impact the operation of other sub-devices without any
> notification. Further more, PCI aliased devices (PCI bridge
> and all devices beneath it, VMD devices and various devices
> quirked with pci_add_dma_alias()) must use the same domain.
> Forcing one device to switch to DMA domain during runtime
> will cause in-fligh DMAs for other devices to abort or target
> to other memory which might cause undefind system behavior.

This commit log doesn't actually explain what you are chaning, and
as far as I can tell it just removes the code to change the domain
at run time, which seems to not actually match the subject or
description.  I'd need to look at the final code, but it seems like
this will still cause bounce buffering instead of using dynamic
mapping, which still seems like an awful idea.

Also from a purely stylistic perspective a lot of the lines seem
very short and not use up the whole 73 charaters allowed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
