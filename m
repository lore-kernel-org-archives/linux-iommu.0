From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 09/11] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
Date: Fri, 17 Jan 2014 12:01:19 +0100
Message-ID: <20140117110108.GV3471@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-10-git-send-email-andreas.herrmann@calxeda.com>
	<CAL_JsqK2JUBEvCb-=eHFE_T=2AD0K_+V=NAeijzK2DrCwkaCOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqK2JUBEvCb-=eHFE_T=2AD0K_+V=NAeijzK2DrCwkaCOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 16, 2014 at 09:30:26AM -0500, Rob Herring wrote:
> On Thu, Jan 16, 2014 at 6:44 AM, Andreas Herrmann
> <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org> wrote:
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> 
> One minor comment, but otherwise:
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> > ---
> >  arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
> >  arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
> >  2 files changed, 48 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
> > index 2ccbb57f..722de49 100644
> > --- a/arch/arm/boot/dts/ecx-2000.dts
> > +++ b/arch/arm/boot/dts/ecx-2000.dts
> > @@ -76,10 +76,11 @@
> >         };
> >
> >         soc {
> > -               ranges = <0x00000000 0x00000000 0x00000000 0xffffffff>;
> > +               ranges = <0x0 0x0 0x0 0xffffffff>;
> >
> >                 timer {
> > -                       compatible = "arm,cortex-a15-timer", "arm,armv7-timer";                         interrupts = <1 13 0xf08>,
> > +                       compatible = "arm,cortex-a15-timer", "arm,armv7-timer";
> > +                       interrupts = <1 13 0xf08>,
> >                                 <1 14 0xf08>,
> >                                 <1 11 0xf08>,
> >                                 <1 10 0xf08>;
> > @@ -109,6 +110,45 @@
> >                         interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
> >                 };
> >         };
> > +
> > +       soc@920000000 {
> 
> I believe this and the other > 32-bit addresses below should be
> "soc@9,20000000".

Will fix this.


Thanks,

Andreas
