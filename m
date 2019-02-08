From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Date: Fri, 8 Feb 2019 08:52:26 +0100
Message-ID: <20190208075226.GA22538@lst.de>
References: <20190207193653.18221-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207193653.18221-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, "Rafael J . Wysocki" <rafael@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Yes, we should not reset the DMA ops before releasing all resources:

Acked-by: Christoph Hellwig <hch@lst.de>
