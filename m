From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: of_dma_request_slave_channel() failed ?
Date: Tue, 11 Sep 2018 11:43:47 +0200
Message-ID: <CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
References: <87efe9ls4n.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <87efe9ls4n.wl-kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Morimoto-san,

CC asoc, dma, iommu

On Tue, Sep 4, 2018 at 8:06 AM Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Renesas ML
> Cc Rob
>
> I noticed that Sound driver is using PIO mode
> on latest kernel.
>
>         ...
>         rcar_sound ec500000.sound: src[0] : probe error -11
>         rcar_sound ec500000.sound: ssi[0] fallback to PIO mode
>         rcar_sound ec500000.sound: src[1] : probe error -11
>         rcar_sound ec500000.sound: ssi[1] fallback to PIO mode
>         rcar_sound ec500000.sound: ssi[2] : probe error -11
>         rcar_sound ec500000.sound: ssi[2] fallback to PIO mode
>         rcar_sound ec500000.sound: ssi[3] : probe error -11
>         rcar_sound ec500000.sound: ssi[3] fallback to PIO mode
>         rcar_sound ec500000.sound: probed
>         ...
>
> Sound can use DMA mode and PIO mode.
> It automatically fallbacks to PIO mode if it can't use DMA.
>
> I bisected this issue, and found the 1st bad commit
>
> -----------------------------------------------------
> commit ac6bbf0cdf4206c517ac9789814c23e372ebce4d
> Author: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Date:   Mon Jul 9 09:41:52 2018 -0600
>
>     iommu: Remove IOMMU_OF_DECLARE
>
>     Now that we use the driver core to stop deferred probe for missing
>     drivers, IOMMU_OF_DECLARE can be removed.
>
>     This is slightly less optimal than having a list of built-in drivers in
>     that we'll now defer probe twice before giving up. This shouldn't have a
>     significant impact on boot times as past discussions about deferred
>     probe have given no evidence of deferred probe having a substantial
>     impact.
>         ...
> -----------------------------------------------------
>
> In more detail, it seems it can't find DMA controller,
> and of_dma_request_slave_channel() returns
> -EPROBE_DEFER from this commit.
>
> struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>                                               const char *name)
> {
>         ...
>                 ofdma = of_dma_find_controller(&dma_spec);
>
>                 if (ofdma) {
>                         chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
>                 } else {
> =>                      ret_no_channel = -EPROBE_DEFER;
>                         chan = NULL;
>                 }
>         ...
> =>      return ERR_PTR(ret_no_channel);
> }
>
> Is this known issue ?
> Or sound shouldn't fallbacks to PIO mode ?

I assume you wrote commit 6c92d5a2744e2761 ("ASoC: rsnd: don't fallback
to PIO mode when -EPROBE_DEFER") to work around this?

While this got rid of the error messages, and postpones sound initialization
until the audio DMAC is available, it does mean that the driver will _never_
fall back to PIO.

I.e. if CONFIG_RCAR_DMAC=n, audio will fail to probe instead of falling
back to PIO.

With CONFIG_RCAR_DMAC=y:

    rcar-dmac e6700000.dma-controller: ignoring dependency for device,
assuming no driver
    rcar-dmac e7300000.dma-controller: ignoring dependency for device,
assuming no driver
    rcar-dmac e7310000.dma-controller: ignoring dependency for device,
assuming no driver
    rcar-dmac ec700000.dma-controller: ignoring dependency for device,
assuming no driver
    rcar-dmac ec720000.dma-controller: ignoring dependency for device,
assuming no driver

So it seems the audio DMAC is deferred a second time, before the iommu driver
probed.

    subsys_initcall(ipmmu_init); calls platform_driver_register
    module_platform_driver(rcar_dmac_driver);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
