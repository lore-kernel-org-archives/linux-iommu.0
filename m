From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: of_dma_request_slave_channel() failed ?
Date: Fri, 14 Sep 2018 08:56:31 +0200
Message-ID: <CAMuHMdWHGE0R_qeKCstcCiSc6YYC8GAqX1ZcsyafWP=DmTJgLA@mail.gmail.com>
References: <87efe9ls4n.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
	<87in3at0mv.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWQ4=A6jptiGT4jsyR1H0+Z4sPBdJwOAwGc7GVPw4xAAQ@mail.gmail.com>
	<87lg84ucrr.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <87lg84ucrr.wl-kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

On Fri, Sep 14, 2018 at 2:53 AM Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > > Before 6c92d5a2744e2761 patch, driver will forcibly ignore
> > > non-SSI modules, and try to use PIO mode.
> > > I'm not sure it is "kindly support" or "overkill support".
> > >
> > > After this patch, it needs DMA, otherwise, probe will be failed.
> > > DT shouldn't have non-SSI modules if you want to use PIO mode.
> > >
> > >         + /* use PIO mode */
> > >         - playback = <&ssi0 &src0 &dvc0>;
> > >         + playback = <&ssi0>;
> >
> > OK, so falling back to PIO was really a "best effort" fallback, and the user
> > should really enable DMA?
>
> Yeah, I'm thinking this is better.
> PIO fallback is of course "nice to have" if possible.
> But, because of this new iommu patch, keeping this feature
> needs "big complicated patch", and we can get "small effect" I think.
> Thus, I think this is the time to remove this feature.
> Can you agree ?

You're the rcar-sound expert ;-)
If you think there's not much value in keeping PIO fallback, it can be
removed.

We can change behavior once these dependency issues have been resolved
in a generic way.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
