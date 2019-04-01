From: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
Date: Mon, 1 Apr 2019 10:21:22 +0000
Message-ID: <DB7PR04MB5132EF28E1CAB23EBF0238B0EC550@DB7PR04MB5132.eurprd04.prod.outlook.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
	<20190329140014.8126-2-laurentiu.tudor@nxp.com>
	<CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
Cc: Madalin-cristian Bucur <madalin.bucur-3arQi8VN3Tc@public.gmane.org>, Netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roy Pledge <roy.pledge-3arQi8VN3Tc@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Camelia Alexandra Groza <camelia.groza-3arQi8VN3Tc@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "moderated list:ARM/FREESCALE IMX /
	MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Leo,

> -----Original Message-----
> From: Li Yang [mailto:leoyang.li-3arQi8VN3Tc@public.gmane.org]
> Sent: Friday, March 29, 2019 11:50 PM
> To: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>
> Cc: Netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Madalin-cristian Bucur
> <madalin.bucur-3arQi8VN3Tc@public.gmane.org>; Roy Pledge <roy.pledge-3arQi8VN3Tc@public.gmane.org>; Camelia
> Alexandra Groza <camelia.groza-3arQi8VN3Tc@public.gmane.org>; David Miller
> <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>; Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>; linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>;
> lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Subject: Re: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
> Importance: High
> 
> On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org> wrote:
> >
> > From: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>
> >
> > ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
> > longer making sense and it also breaks the ICID settings inherited
> > from u-boot. Do the fixups only for PPC targets.
> >
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c
> b/drivers/soc/fsl/qbman/qman_ccsr.c
> > index 109b38de3176..12e414ca3b03 100644
> > --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> > +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> > @@ -598,6 +598,7 @@ static int qman_init_ccsr(struct device *dev)
> >  #define LIO_CFG_LIODN_MASK 0x0fff0000
> >  void qman_liodn_fixup(u16 channel)
> >  {
> > +#ifdef CONFIG_PPC
> >         static int done;
> >         static u32 liodn_offset;
> >         u32 before, after;
> > @@ -617,6 +618,7 @@ void qman_liodn_fixup(u16 channel)
> >                 qm_ccsr_out(REG_REV3_QCSP_LIO_CFG(idx), after);
> >         else
> >                 qm_ccsr_out(REG_QCSP_LIO_CFG(idx), after);
> > +#endif
> 
> According to the Linux coding style recommendation, it would be better
> to put the #ifdef into the header files
> "drivers/soc/fsl/qbman/qman_priv.h".  And I'm not sure if this is
> needed on PPC when IOMMU(PAMU) driver is not compiled, if not,
> probably using CONFIG_PAMU as condition would be even better.

Good point, will so in the next spin.

---
Best Regards, Laurentiu

> >  }
> >
> >  #define IO_CFG_SDEST_MASK 0x00ff0000
> > --
> > 2.17.1
> >
