From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 2/2] drivers: remove force dma flag from buses
Date: Wed, 21 Mar 2018 18:49:24 +0100
Message-ID: <20180321174924.GA11141@kroah.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
	<1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
	<20180321093525.GT14085@kroah.com>
	<HE1PR0401MB2425644F72A063ED42B79D5FE6AA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB2425644F72A063ED42B79D5FE6AA0-B0v07Ae2taqTjcJO+iVGAo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Cc: "zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "msuchanek-l3A5Bk7waGM@public.gmane.org" <msuchanek-l3A5Bk7waGM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32k@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 21, 2018 at 04:28:46PM +0000, Nipun Gupta wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org]
> > Sent: Wednesday, March 21, 2018 15:05
> > To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org; hch-jcswGhMUV9g@public.gmane.org; linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org;
> > m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> > andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> > vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> > frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> > rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> > msuchanek-l3A5Bk7waGM@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org; linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> > msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bharat Bhushan
> > <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
> > Subject: Re: [PATCH v2 2/2] drivers: remove force dma flag from buses
> > 
> > On Wed, Mar 21, 2018 at 12:25:23PM +0530, Nipun Gupta wrote:
> > > With each bus implementing its own DMA configuration callback,
> > > there is no need for bus to explicitly have force_dma in its
> > > global structure. This patch modifies of_dma_configure API to
> > > accept an input parameter which specifies if implicit DMA
> > > configuration is required even when it is not described by the
> > > firmware.
> > 
> > Having to "remember" what that bool variable means on the end of the
> > function call is a royal pain over time, right?
> > 
> > Why not just create a new function:
> > 	dma_common_configure_force(dma)
> > that always does this?  Leave "dma_common_configure()" alone, and then
> > wrap the old code with these two helper functions that call the 'core'
> > code with the bool set properly?
> > 
> > That way you do not have to "know" what that parameter is, the function
> > name just documents it automatically, so when you see it in the
> > bus-specific code, no need to go and have to hunt for anything.  And if
> > you are reading the dma core code, it's obvious what is happening as the
> > functions are all right there.
> 
> How about we do not pass any flag in 'dma_common_configure()', and inside this
> API we pass "true" to 'of_dma_configure()'? I am saying this because currently
> both the busses (platform and AMBA) which uses 'dma_common_configure()' passes
> "true" value. If we create additional 'dma_common_configure_force()', then
> 'dma_common_configure()' will not be used anytime and will become redundant.
> 
> If someday new busses come and they needs to use similar functionality which
> 'dma_common_configure()' provides, but with passing "false" to 'of_dma_configure()',
> then what you suggests of having two separate such API's will be more reasonable
> and can be implemented?

If that makes things "simple", yes, sounds good.

greg k-h
