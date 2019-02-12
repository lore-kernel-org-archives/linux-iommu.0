From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch static
Date: Tue, 12 Feb 2019 14:24:19 -0600
Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, arcml <linux-snps-arc@lists.infradead.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, SH-Linux <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 11, 2019 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This function is only used in of_reserved_mem.c, and never overridden
> despite the __weak marker.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/of/of_reserved_mem.c    | 2 +-
>  include/linux/of_reserved_mem.h | 7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Looks like this one isn't a dependency, so I can take it if you want.

Rob
