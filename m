From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 1/2] iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist() to
	check SoC revisions
Date: Wed, 28 Nov 2018 09:04:59 +0000
Message-ID: <OSBPR01MB22935659EE48F4706C379FF9D8D10@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1543385279-1584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1543385279-1584-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdVfQgsAgUVBpApjuL=Nv16L=SfCd8vDtFwvR3F4qYpfUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdVfQgsAgUVBpApjuL=Nv16L=SfCd8vDtFwvR3F4qYpfUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: ja-JP
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Wednesday, November 28, 2018 5:47 PM
> 
> Hi Shimoda-san,
> 
> On Wed, Nov 28, 2018 at 7:10 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > Some R-Car Gen3 SoCs has hardware restrictions on the IPMMU. So,
> > to check whether this R-Car Gen3 SoC can use the IPMMU correctly,
> > this patch modifies the ipmmu_slave_whitelist().
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Thank you for the review!

> One question below.
> 
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> 
> > @@ -771,11 +765,35 @@ static bool ipmmu_slave_whitelist(struct device *dev)
> >         { /* sentinel */ }
> >  };
> >
> > +static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
> > +       { .soc_id = "r8a7795", .revision = "ES3.0" },
> 
> Don't you want "ES3.*"?

Indeed (I want "ES3.*"). So, I'll submit v2 patch to fix it.

Best regards,
Yoshihiro Shimoda

> > +       { .soc_id = "r8a77965", },
> > +       { .soc_id = "r8a77990", },
> > +       { .soc_id = "r8a77995", },
> > +       { /* sentinel */ }
> > +};
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
