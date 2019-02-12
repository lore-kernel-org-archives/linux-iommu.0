From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
Date: Tue, 12 Feb 2019 14:11:25 -0600
Message-ID: <CAL_JsqJFGhTa+izRTeUxjtbyOek-zynZofOJGDK+xZbD4r5H0Q@mail.gmail.com>
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, SH-Linux <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 11, 2019 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The OF_RESERVED_MEM can be used if we have either CMA or the generic
> declare coherent code built and we support the early flattened DT.
>
> So don't bother making it a user visible options that is selected
> by most configs that fit the above category, but just select it when
> the requirements are met.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig     | 1 -
>  arch/arm/Kconfig     | 1 -
>  arch/arm64/Kconfig   | 1 -
>  arch/csky/Kconfig    | 1 -
>  arch/powerpc/Kconfig | 1 -
>  arch/xtensa/Kconfig  | 1 -
>  drivers/of/Kconfig   | 5 ++---
>  7 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
