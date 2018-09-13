From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: of_dma_request_slave_channel() failed ?
Date: Thu, 13 Sep 2018 11:00:31 +0200
Message-ID: <CAMuHMdVnoLTYEvtJ3AY0hFxGqtw-kVE0vWtA74ewJkxkirogYA@mail.gmail.com>
References: <87efe9ls4n.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
	<20180912155057.GJ6062@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180912155057.GJ6062-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Vinod <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mark,

On Wed, Sep 12, 2018 at 5:51 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Sep 11, 2018 at 11:43:47AM +0200, Geert Uytterhoeven wrote:
> > So it seems the audio DMAC is deferred a second time, before the iommu driver
> > probed.
>
> Shouldn't there be at least one more round of deferred probe triggers
> after the IOMMU probes?

My statement above was incorrect. Adding more debug info allowed to gain
more insight:

A. If CONFIG_IPMMU_VMSA=y, everything is fine:

  1. ipmmu probes,
  2. audio-dmac probes,
  3. audio probes, using DMA

B. If CONFIG_IPMMU_VMSA=n, the sound driver falls back to PIO, which
   Morimoto-san worked around by commit 6c92d5a2744e2761 ("ASoC: rsnd:
   don't fallback to PIO mode when -EPROBE_DEFER")[1]

  1. ipmmu is not probed: driver not enabled => OK
  2. audio-dmac is not probed: iommu not found
  3. audio fails to probe (3 times, hence just ignoring the first one is
     not sufficient):
        "of_dma_find_controller: can't find DMA controller
         /soc/dma-controller@ec700000"
        => fell back to PIO before [1]
        => -EPROBE_DEFER since [1]
  4. audio-dmac probes
      of_iommu_xlate() calls driver_deferred_probe_check_state(), leading
      to ("ignoring dependency for device, assuming no driver")

  If step 3 returned -EPROBE_DEFER, there's one additional step:
  5. audio reprobes successfully, using DMA.

While step 2 (DMA-capable device not probed because iommu not found)
is correct for devices with a builtin dmac, it causes issues with external
dmacs, as the dmac probe may be postponed after the DMA slave driver
probe.

C. Before commit ac6bbf0cdf4206c5 ("iommu: Remove IOMMU_OF_DECLARE"),
with CONFIG_IPMMU_VMSA=n:

  1. ipmmu is not probed: driver not enabled => OK
  2. audio-dmac probes => OK
      Missing IOMMU ignored, as per
          !ops && !of_iommu_driver_present(iommu_spec->np)
      in of_iommu_xlate(), which is really
          !ops && !of_match_node(&__iommu_of_table, np))
  3. audio probes, using DMA
      Note: if of_dma_find_controller() would have failed (e.g. missing
      dmac driver), the audio driver fell back to PIO here.

As per Morimoto-san's recent reply, audio really needs DMA, so the current
behavior of B.5. is OK. However, this may not be true for other devices
(e.g. SPI, i2c, serial, ...), where the dmac is optional.

The main issue is that if of_dma_find_controller() fails, a DMA slave driver
cannot distinguish between dmac not yet probed successfully, and dmac
driver not present.

However, as we rely more and more on probe deferral, this will cause more
issues in the future.

I guess the proper solution is to take into account dependencies described
in DT before probing devices, i.e. devices with phandles should always be
probed after the targets of these phandles?
Complication:
  - Circular dependencies,
  - Optional phandle targets (dmacs, oops).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
