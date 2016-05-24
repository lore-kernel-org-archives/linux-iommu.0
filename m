From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/4] ARM: dma-mapping: Constify attrs passed to internal
 functions
Date: Tue, 24 May 2016 09:35:19 +0100
Message-ID: <20160524083519.GC19428@n2100.arm.linux.org.uk>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
 <1464071290-15948-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464071290-15948-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 24, 2016 at 08:28:08AM +0200, Krzysztof Kozlowski wrote:
> Some of the non-exported functions do not modify passed dma_attrs so the
> pointer can point to const data.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
