From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv3 05/19] ARM: dt: tegra114: iommu: Fix IOMMU register
	address
Date: Thu, 31 Oct 2013 10:34:33 -0700
Message-ID: <20131031173433.GE3037@kartoffel>
References: <1382092020-13170-6-git-send-email-hdoyu@nvidia.com>
	<20131031165127.GB3037@kartoffel>
	<20131031.190524.343708041257755667.hdoyu@nvidia.com>
	<20131031.191126.1326472797634956722.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131031.191126.1326472797634956722.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 31, 2013 at 05:11:26PM +0000, Hiroshi Doyu wrote:
> Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Thu, 31 Oct 2013 19:05:24 +0200 (EET):
> 
> > Hi Mark,
> > 
> > Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote @ Thu, 31 Oct 2013 17:51:27 +0100:
> > 
> > > On Fri, Oct 18, 2013 at 11:26:46AM +0100, Hiroshi Doyu wrote:
> > > > Fix IOMMU register address.
> > > > 
> > > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > >  arch/arm/boot/dts/tegra114.dtsi | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> > > > index 2905145..8d42787 100644
> > > > --- a/arch/arm/boot/dts/tegra114.dtsi
> > > > +++ b/arch/arm/boot/dts/tegra114.dtsi
> > > > @@ -318,9 +318,9 @@
> > > >  
> > > >  	iommu {
> > > >  		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
> > > > -		reg = <0x7000f010 0x02c
> > > > -		       0x7000f1f0 0x010
> > > > -		       0x7000f228 0x074>;
> > > > +		reg = <0x70019010 0x02c
> > > > +		       0x700191f0 0x010
> > > > +		       0x70019228 0x074>;
> > > 
> > > Minor cleanup/consistency request: as all these lines are changing anyway,
> > > would you mind bracketing each entry individually:
> > > 
> > > 		reg = <0x70019010 0x02c>,
> > > 		      <0x700191f0 0x010>,
> > > 		      <0x70019228 0x074>;
> > 
> > No, at all. Attached the updated "[PATCHv3' 05/19]".
> 
> Oops, here's the right one, "[PATCHv3'' 05/19]".

:)

Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Cheers,
Mark.

> From 156a6ad059f902590094570697cb33e5b892d835 Mon Sep 17 00:00:00 2001
> From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Mon, 17 Jun 2013 15:37:35 +0300
> Subject: [PATCHv3'' 1/1] ARM: dt: tegra114: iommu: Fix IOMMU register address
> 
> Fix IOMMU register address.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index 2905145..e629042 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -318,9 +318,9 @@
>  
>  	iommu {
>  		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
> -		reg = <0x7000f010 0x02c
> -		       0x7000f1f0 0x010
> -		       0x7000f228 0x074>;
> +		reg = <0x70019010 0x02c>,
> +		      <0x700191f0 0x010>,
> +		      <0x70019228 0x074>;
>  		nvidia,#asids = <4>;
>  		dma-window = <0 0x40000000>;
>  		nvidia,swgroups = <0x18659fe>;
> -- 
> 1.8.1.5
> 
