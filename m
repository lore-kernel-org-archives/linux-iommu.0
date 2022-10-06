Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960B7F6
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WaWuacrXgoWUqhxrOHl4GMa+cvVSYL4PbBYATd6NYOI=; b=vD/jM2h1/0IWT4NtS1F2NBTybP
	NCLAbo+pGUkt5UeVNZM9XUWEb/BhdSDMsyJD04k5+Rgwx2O2BF7LYkkZDeqSs/4slGoQqCIgxfamS
	/EgkHeR6uTjxUWg+SxaZr/8DKuAuKfmI6F8J5IDH9z5I6acG4Cxa+2RpH6yNa4tQAertF4L/17iy5
	HAX/RWOodePS0qNAviGnMXKZFrDHLfO6c7fJ0ce3/s3uf8ie5jON7q0iGB/IRQoxhUxVfr7A3zswG
	9CI6ZXDcfutgQhi22/Nq6Nik38wDXdEfuqhYezC18JLCCN005NybiwP0BqbjBRRxUu7T03TWTchVr
	q1Q1EK4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34604)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ogPQ6-0001Xz-K6; Thu, 06 Oct 2022 12:52:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ogPQ4-0006Ha-HD; Thu, 06 Oct 2022 12:52:04 +0100
Date: Thu, 6 Oct 2022 12:52:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: mvebu DMA fix
Message-ID: <Yz7BZOkUkQhJUgKf@shell.armlinux.org.uk>
References: <20221006074824.521457-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006074824.521457-1-hch@lst.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 06, 2022 at 09:48:22AM +0200, Christoph Hellwig wrote:
> Hi Russell,
> 
> the first patch fixes the regression that overwrites ->dma_coherent after
> the mvebu notifier set it, and the second one removes a now unused field
> in the arm arch_devdata.
> 
> Let me know if you want to take these, or if I should route them through
> the dma-mapping tree that introduced this problem.

I think it would make sense to send them through the dma-mapping tree,
so for the series:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks for fixing this!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
