From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: use the generic dma-noncoherent code for sh V2
Date: Mon, 30 Jul 2018 11:24:52 +0200
Message-ID: <CAMuHMdXkaoypaszdyXyVA-qZvDtbcEdtdbEwpdoT8ocx-2TPYA@mail.gmail.com>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
	<18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <18df6608-61c1-963d-bb1a-d46320232f40-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

CC Guennadi

On Fri, Jul 27, 2018 at 6:21 PM Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org> wrote:
> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
> > On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
> >> can you review these patches to switch sh to use the generic
> >> dma-noncoherent code?  All the requirements are in mainline already
> >> and we've switched various architectures over to it already.
> >
> > Ok, there is one more issue with this version.   Wait for a new one
> > tomorrow.
>
> Speaking of DMA:
>
> I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
> fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
> reading through all that stuff, but the docs seem kinda... thin?
>
> Is there something I should have read other than
> Documentation/driver-model/platform.txt,
> Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
> source code and the sh7760 hardware pdf? (And watching the youtube video of
> Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
> DMAEngine, the Xilinx video on DMAEngine...)
>
> At first I thought the SH_DMAE could initialize itself, but the probe function
> needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
> _kind_ of like a model I can crib from:
>
> A) "make ARCH=sh se7722_defconfig" results in a config with SH_DMA disabled??!?
> (This is why I use miniconfig instead of defconfig format, I'm assuming that's
> bit rot?)
>
> B) That platform data is supplying sh_dmae_slave_config preallocating slave
> channels to devices? (Does it have to? The docs gave me the impression the
> driver would dynamically request them and devices could even share. Wasn't that
> sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
> minimum amount of micromanaging I have to do?)
>
> C) It's full of stuff like setting ts_low_shift to CHCR_TS_LOW_SHIFT where both
> grepping Docuemntation and Google "dmaengine ts_low_shift" are unhelpful.
>
> What I'd really like is a "hello world" version of DMAEngine somewhere I can
> build and run on a supported qemu target, to set up _one_ channel with a block
> device or something using it. I can't tell what's optional, or what the minimal
> version of this looks like.

I have no experience with DMA on SH, only with DMA on (DT-based) Renesas
ARM SoCs. But I believe the DMA engines are somewhat similar.

I don't know if all pieces to support DMA were ever upstreamed.
See e.g. commit 219fb0c1436e4893 ("serial: sh-sci: Remove the platform data
dma slave rx/tx channel IDs").

Perhaps Guennadi knows/remembers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
