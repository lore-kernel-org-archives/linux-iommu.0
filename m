From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: RE: [PATCH v2 1/2] iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
Date: Thu, 8 Nov 2018 14:00:37 +0000
Message-ID: <TY1PR01MB1770000EE64E62385F53330EC0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <CAMuHMdUe=p42Bp6xgmvrNwPKs=VHUP2BezDBPPn9KgPawvOtgA@mail.gmail.com>
	<1535038384-27080-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<TY1PR01MB1770B9A0AEF082A9CBF5B0E8C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20181108122802.q6kye2tzy6ofod5q@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181108122802.q6kye2tzy6ofod5q-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thank you Simon for getting back to me.

Joerg, does this patch look ok to you?

Thanks,
Fab

> Subject: Re: [PATCH v2 1/2] iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
>
> Hi Fabrizio,
>
> I believe this one is for Joerg.
>
> On Thu, Nov 08, 2018 at 11:22:55AM +0000, Fabrizio Castro wrote:
> > Dear All,
> >
> > Who is the best person to take this patch?
> >
> > Thanks,
> > Fab
> >
> > > From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> > > Sent: 23 August 2018 16:33
> > > Subject: [PATCH v2 1/2] iommu/ipmmu-vmsa: Hook up R8A774A1 DT maching code
> > >
> > > Add support for RZ/G2M (R8A774A1) SoC IPMMUs.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> > > Reviewed-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> > > ---
> > > v1-v2:
> > > * taken out IOMMU_OF_DECLARE
> > >
> > >  drivers/iommu/ipmmu-vmsa.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > > index 51af2c5..331562f 100644
> > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > > @@ -761,6 +761,7 @@ static bool ipmmu_slave_whitelist(struct device *dev)
> > >  }
> > >
> > >  static const struct soc_device_attribute soc_rcar_gen3[] = {
> > > +{ .soc_id = "r8a774a1", },
> > >  { .soc_id = "r8a7795", },
> > >  { .soc_id = "r8a7796", },
> > >  { .soc_id = "r8a77965", },
> > > @@ -942,6 +943,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
> > >  .compatible = "renesas,ipmmu-vmsa",
> > >  .data = &ipmmu_features_default,
> > >  }, {
> > > +.compatible = "renesas,ipmmu-r8a774a1",
> > > +.data = &ipmmu_features_rcar_gen3,
> > > +}, {
> > >  .compatible = "renesas,ipmmu-r8a7795",
> > >  .data = &ipmmu_features_rcar_gen3,
> > >  }, {
> > > --
> > > 2.7.4
> >
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England
> & Wales under Registered No. 04586709.
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
