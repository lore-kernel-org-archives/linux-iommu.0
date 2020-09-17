Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64985C2D0E3
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 18:53:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D2021973
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yo2ThNdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D2021973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 095062045A;
	Thu, 17 Sep 2020 18:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqNXQFxxo3My; Thu, 17 Sep 2020 18:53:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 22D7920242;
	Thu, 17 Sep 2020 18:53:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 001DDC0864;
	Thu, 17 Sep 2020 18:53:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4305EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 18:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2D84886881
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 18:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrBwzKTOsdEz for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 18:53:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 111D48567A
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YmDVFHDpizYc/TwnnkFHJuvq4HZQyroxl/6sftZyOfg=; b=yo2ThNdDFBBSofow6/GUT6znO
 AV6up04hQxQ87JSuwyBsYZ6cPA40Jyx7/h7ugIDDAyxGQuxpPb7h5RlTXju5lRqwNwH3Fjtcjriq2
 2Y2Ot122hkB0c8aWhxQrgYjG80j2F5sIUEsORGJiB2kK1NYmSxCzSWwiHMsw747ECXq0qsnP05pjU
 /uU6Kplfx0ojCnVoas3BJbwS+VAr2GmyiBXJHhn477cic+DTVgN3eO/PfKEqRXHH9HZAPhIG8WSKx
 ObsOX+yk+sxyxrx9eX608uRInho4bEz9J93gW/BvXdNi7EZUjRuENs8kmXOTAYqZhDjd1PkACkjEB
 DwbP5k/MA==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34896)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1kIz2K-00065q-UW; Thu, 17 Sep 2020 19:53:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1kIz2K-0005xj-Ax; Thu, 17 Sep 2020 19:53:40 +0100
Date: Thu, 17 Sep 2020 19:53:40 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] ARM/footbridge: switch to use dma_direct_set_offset
 for lbus DMA offsets
Message-ID: <20200917185340.GC1559@shell.armlinux.org.uk>
References: <20200917173229.3311382-1-hch@lst.de>
 <20200917173229.3311382-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917173229.3311382-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org,
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

On Thu, Sep 17, 2020 at 07:32:27PM +0200, Christoph Hellwig wrote:
>  static int __init cats_pci_init(void)
>  {
> -	if (machine_is_cats())
> -		pci_common_init(&cats_pci);
> +	if (!machine_is_cats())
> +		return 0;
> +	bus_register_notifier(&pci_bus_type, &footbridge_pci_dma_nb);
> +	pci_common_init(&cats_pci);

I'd prefer these things to retain a positive-logic construct, so:

	if (machine_is_cats()) {
		bus_register_notifier(&pci_bus_type, &footbridge_pci_dma_nb);
		pci_common_init(&cats_pci);
	}

It's the same number of lines.

Otherwise, I think it's fine. I'll try to find some spare time to give
it a go on a Netwinder.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
