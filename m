Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA9C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 12:18:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6A22089D
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 12:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6A22089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2629B204B5;
	Thu, 21 Nov 2019 12:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QSL3SKnX4Yz; Thu, 21 Nov 2019 12:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0FFA3204EB;
	Thu, 21 Nov 2019 12:18:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8E8AC1DD7;
	Thu, 21 Nov 2019 12:18:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E823C18DA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5A9D984BBE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id swIYYcZkHZ6N for <iommu@lists.linux-foundation.org>;
 Thu, 21 Nov 2019 12:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 21E2184B65
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 12:18:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895F61045;
 Thu, 21 Nov 2019 04:18:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF27B3F703;
 Thu, 21 Nov 2019 04:18:06 -0800 (PST)
Date: Thu, 21 Nov 2019 12:18:05 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 0/6] Raspberry Pi 4 PCIe support
Message-ID: <20191121121804.GY43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191119111848.GR43905@e119886-lin.cambridge.arm.com>
 <1b116fabe85a324e2d05a593d38811467f43fb91.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b116fabe85a324e2d05a593d38811467f43fb91.camel@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: devicetree@vger.kernel.org, f.fainelli@gmail.com,
 linux-rdma@vger.kernel.org, maz@kernel.org, phil@raspberrypi.org,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 mbrugger@suse.com, bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
 james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
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

On Tue, Nov 19, 2019 at 12:49:24PM +0100, Nicolas Saenz Julienne wrote:
> On Tue, 2019-11-19 at 11:18 +0000, Andrew Murray wrote:
> > On Tue, Nov 12, 2019 at 04:59:19PM +0100, Nicolas Saenz Julienne wrote:
> > > This series aims at providing support for Raspberry Pi 4's PCIe
> > > controller, which is also shared with the Broadcom STB family of
> > > devices.
> > > 
> > > There was a previous attempt to upstream this some years ago[1] but was
> > > blocked as most STB PCIe integrations have a sparse DMA mapping[2] which
> > > is something currently not supported by the kernel.  Luckily this is not
> > > the case for the Raspberry Pi 4.
> > > 
> > > Note that the driver code is to be based on top of Rob Herring's series
> > > simplifying inbound and outbound range parsing.
> > > 
> > > [1] https://patchwork.kernel.org/cover/10605933/
> > > [2] https://patchwork.kernel.org/patch/10605957/
> > > 
> > 
> > What happened to patch 3? I can't see it on the list or in patchwork?
> 
> For some reason the script I use to call get_maintainer.sh or git send-mail
> failed to add linux-pci@vger.kernel.org and linux-kernel@vger.kernel.org as
> recipients. I didn't do anything different between v1 and v2 as far as mailing
> is concerned.
> 
> Nevertheless it's here: https://www.spinics.net/lists/arm-kernel/msg768461.html
> and should be present in the linux-arm-kernel list.
> 
> I'll look in to it and make sure this doesn't happen in v3.

No problem.

Thanks,

Andrew Murray

> 
> Regards,
> Nicolas
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
