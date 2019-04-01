From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/7] gbefb: switch to managed version of the DMA
 allocator
Date: Mon, 1 Apr 2019 17:38:40 +0200
Message-ID: <a61e5aa5-53ed-168c-9b75-cb0509e0c065@samsung.com>
References: <20190321225235.30648-1-hch@lst.de>
        <CGME20190321225318epcas1p2a3b1fc89a14c4ab1241d8b48293fb9e0@epcas1p2.samsung.com>
        <20190321225235.30648-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321225235.30648-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <linux@armlinux.org.uk>, x86@kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


On 03/21/2019 11:52 PM, Christoph Hellwig wrote:
> gbefb uses managed resources, so it should do the same for DMA
> allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
