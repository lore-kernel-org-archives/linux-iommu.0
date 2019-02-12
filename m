From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/2] dma-mapping: add a kconfig symbol for
 arch_setup_dma_ops availability
Date: Tue, 12 Feb 2019 02:02:48 +0000
Message-ID: <20190212020246.pnxg2tlwejvu45ze@pburton-laptop>
References: <20190204081420.15083-1-hch@lst.de>
 <20190204081420.15083-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204081420.15083-2-hch@lst.de>
Content-Language: en-US
Content-ID: <C4D58356C472DE43A87A2CDF3A97D97A@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Mon, Feb 04, 2019 at 09:14:19AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                     |  1 +
>  arch/arc/include/asm/Kbuild          |  1 +
>  arch/arc/include/asm/dma-mapping.h   | 13 -------------
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/include/asm/dma-mapping.h   |  4 ----
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/dma-mapping.h |  4 ----
>  arch/mips/Kconfig                    |  1 +
>  arch/mips/include/asm/dma-mapping.h  | 10 ----------
>  arch/mips/mm/dma-noncoherent.c       |  8 ++++++++

Acked-by: Paul Burton <paul.burton@mips.com> # MIPS

Thanks,
    Paul
