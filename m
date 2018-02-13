From: Mathieu Malaterre <malat@debian.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Date: Tue, 13 Feb 2018 16:22:50 +0100
Message-ID: <CA+7wUsy80+5XJnbt5yXe-GYjD6V7Ea_wrAxu0Gwwh2kLs2fibQ@mail.gmail.com>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee> <20180213145120.GA14657@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180213145120.GA14657@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Meelis Roos <mroos@linux.ee>, iommu@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Tue, Feb 13, 2018 at 3:51 PM, Christoph Hellwig <hch@lst.de> wrote:
> Does this fix your warning?
>
> diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
> index 62f541f968f6..07074820a167 100644
> --- a/drivers/macintosh/macio_asic.c
> +++ b/drivers/macintosh/macio_asic.c
> @@ -375,6 +375,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
>         dev->ofdev.dev.of_node = np;
>         dev->ofdev.archdata.dma_mask = 0xffffffffUL;
>         dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
> +       dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
>         dev->ofdev.dev.parent = parent;
>         dev->ofdev.dev.bus = &macio_bus_type;
>         dev->ofdev.dev.release = macio_release_dev;

Indeed, Thanks much! If needed:

Tested-by: Mathieu Malaterre <malat@debian.org>

System: Mac Mini G4

ref:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg128662.html
