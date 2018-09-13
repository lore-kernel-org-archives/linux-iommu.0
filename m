From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: of_dma_request_slave_channel() failed ?
Date: Thu, 13 Sep 2018 11:11:49 +0100
Message-ID: <2b5e7838-5c5f-b993-1a9c-38208c2b4d24@arm.com>
References: <87efe9ls4n.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
	<20180912155057.GJ6062@sirena.org.uk>
	<CAMuHMdVnoLTYEvtJ3AY0hFxGqtw-kVE0vWtA74ewJkxkirogYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdVnoLTYEvtJ3AY0hFxGqtw-kVE0vWtA74ewJkxkirogYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/09/18 10:00, Geert Uytterhoeven wrote:
[...]
> The main issue is that if of_dma_find_controller() fails, a DMA slave driver
> cannot distinguish between dmac not yet probed successfully, and dmac
> driver not present.

...which is in fact the exact same problem that the IOMMU code has - 
might it make sense to give of_dma_request_slave_channel() similar 
(optional?) driver_deferred_probe_check_state() logic, i.e. "if my DMAC 
driver's not shown up by this point, assume it's not built-in and go on 
without it". Of course it is somewhat easier for IOMMU drivers as 
there's zero chance of those popping up as modules later on.

> However, as we rely more and more on probe deferral, this will cause more
> issues in the future.
> 
> I guess the proper solution is to take into account dependencies described
> in DT before probing devices, i.e. devices with phandles should always be
> probed after the targets of these phandles?
> Complication:
>    - Circular dependencies,
>    - Optional phandle targets (dmacs, oops).

Yeah, a proper dependency graph would be ideal, but it's certainly not 
trivial. There was an interesting proposal a couple of years ago of a 
half-way approach where various phandle-chasing routines could actively 
try to probe the target, but I think that got stymied on the fact that a 
single OF node may represent multiple different driver-level providers, 
so it's tricky to tell whether the *right* dependency has been satisfied 
without detailed knowledge of the individual bindings and driver 
implementations. That's probably still an issue for other approaches 
too, sadly.

Robin.
