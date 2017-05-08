From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] Fix incorrect warning from dma-debug
Date: Mon, 8 May 2017 11:19:44 +0200
Message-ID: <CAMuHMdXrBcx2kbrK+uBKvszBKCDt2f9JCLQN-GA6hruqevnC6A@mail.gmail.com>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <57305A4B.70401@arm.com> <57305FD8.7070006@arm.com> <477ded30-eef2-3598-3a8d-95d206e11efb@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <477ded30-eef2-3598-3a8d-95d206e11efb@jonmasters.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jon Masters <jcm@jonmasters.org>
Cc: Robin Murphy <robin.murphy@arm.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jon,

On Sun, May 7, 2017 at 2:06 AM, Jon Masters <jcm@jonmasters.org> wrote:
> On 05/09/2016 06:00 AM, Robin Murphy wrote:
>> On 09/05/16 10:37, Robin Murphy wrote:
>>> On 08/05/16 11:59, Niklas S=C3=B6derlund wrote:
>>>> While using CONFIG_DMA_API_DEBUG i came across this warning which I
>>>> think is a false positive. As shown dma_sync_single_for_device() are
>>>> called from the dma_map_single() call path. This triggers the warning
>>>> since the dma-debug code have not yet been made aware of the mapping.
>>>
>>> Almost right ;) The thing being mapped (the SPI device's buffer) and th=
e
>>> thing being synced (the IOMMU's PTE) are entirely unrelated. Due to the
>>> current of_iommu_init() setup, the IOMMU is probed long before
>>> dma_debug_init() gets called, therefore DMA debug is missing entries fo=
r
>>> some of the initial page table mappings and gets confused when we updat=
e
>>> them later.
>
> What was the eventual followup/fix for this? We're seeing similar traces
> to this during internal testing of 4.11 kernels.

A quick hack is to change arch/arm64/mm/dma-mapping.c:dma_debug_do_init()
from fs_initcall() to arch_initcall().

However, then you loose the debugfs features. A proper fix would involve
splitting dma_debug_init() in two phases: an early one doing the real work,
and a late one registering the debugfs interface.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
