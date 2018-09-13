From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: of_dma_request_slave_channel() failed ?
Date: Thu, 13 Sep 2018 13:04:41 +0200
Message-ID: <CAMuHMdUygpJTcumhsZPbrssX8TN2HqkdvEgVSv2b9XUU6o315A@mail.gmail.com>
References: <87efe9ls4n.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
	<20180912155057.GJ6062@sirena.org.uk>
	<CAMuHMdVnoLTYEvtJ3AY0hFxGqtw-kVE0vWtA74ewJkxkirogYA@mail.gmail.com>
	<2b5e7838-5c5f-b993-1a9c-38208c2b4d24@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2b5e7838-5c5f-b993-1a9c-38208c2b4d24-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Thu, Sep 13, 2018 at 12:12 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 13/09/18 10:00, Geert Uytterhoeven wrote:
> [...]
> > The main issue is that if of_dma_find_controller() fails, a DMA slave driver
> > cannot distinguish between dmac not yet probed successfully, and dmac
> > driver not present.
>
> ...which is in fact the exact same problem that the IOMMU code has -
> might it make sense to give of_dma_request_slave_channel() similar
> (optional?) driver_deferred_probe_check_state() logic, i.e. "if my DMAC
> driver's not shown up by this point, assume it's not built-in and go on
> without it". Of course it is somewhat easier for IOMMU drivers as
> there's zero chance of those popping up as modules later on.

It may solve the issue in some cases.  But only if the dmac is reprobed
before the DMA slave driver, which is not guaranteed.

BTW, it seems e.g. i2c and serial suffer from the same problem, and fall
back to PIO. However, these drivers try to obtain the DMA channel when
used, not during probe, so they start using DMA after the dmac has been
probed successfully.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
