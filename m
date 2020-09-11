Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6CC433E2
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 11:28:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E16221EB
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 11:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mCkPoBCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E16221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 905CE2E232;
	Fri, 11 Sep 2020 11:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id laX1dIHLcDvD; Fri, 11 Sep 2020 11:28:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C39F2038B;
	Fri, 11 Sep 2020 11:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA80C0859;
	Fri, 11 Sep 2020 11:28:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E868C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 11:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EE6A78783B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 11:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZVwS19xsStZJ for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 11:28:43 +0000 (UTC)
X-Greylist: delayed 00:12:46 by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 33B088783A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=36ZkAoKN0iM1NJFnvg/F9ZJ4FujUHf3nFyIgYS8P20E=; b=mCkPoBCG7tgxr2kE/Qp1HVqZL
 h81Rtwehr+ARfsh7bmrzSubSwZ6TrCNOpp4KKPoPmEJWZjFv+2/sFHEGgvvsP3NuwFJonTkPZXghH
 6npI0zHhfXgkZ7oV4DOdcPY8RVKLb51mdOONSN9MuAvFR1TUnY/vLnoEzjW+Zx/UO0D8gAosOohhi
 9mjZR+SSIO18EltTo6oerFym0wiGncjRKliSmXjXiHTg4LC4kqTIBnz8gOo7A3piVYJcjryjVQadS
 JIOopqxmg0two8HXps05Mob6s6ZDn8ZLxDm88ujhBsL1KmRGK2aZQQa2BASe6ElJ5fbcT8GtpFDo7
 TBU2NvCsQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33012)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1kGh21-0007Ia-To; Fri, 11 Sep 2020 12:15:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1kGh1z-0008Az-Jq; Fri, 11 Sep 2020 12:15:51 +0100
Date: Fri, 11 Sep 2020 12:15:51 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] ARM/keystone: move the DMA offset handling under
 ifdef CONFIG_ARM_LPAE
Message-ID: <20200911111551.GG1551@shell.armlinux.org.uk>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910054038.324517-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 10, 2020 at 07:40:37AM +0200, Christoph Hellwig wrote:
> The DMA offset notifier can only be used if PHYS_OFFSET is at least
> KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
> phys_addr_t.  Currently the code compiles fine despite that, a pending
> change to the DMA offset handling would create a compiler warning for
> this case.  Add an ifdef to not compile the code except for LPAE
> configs.

However, to have use of the high physical offset, LPAE needs to be
enabled, which ensures that phys_addr_t is 64-bit.

I believe that DMA is non-coherent on this platform unless the high
physical address is used. Or something like that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
