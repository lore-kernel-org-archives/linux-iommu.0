From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Date: Fri, 27 Apr 2018 17:10:48 +0000
Message-ID: <HE1PR0401MB24259708C02B6AD57C11A18EE68D0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<1522396485-10248-1-git-send-email-nipun.gupta@nxp.com>
	<20180423125638.GB8824@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180423125638.GB8824-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "msuchanek-l3A5Bk7waGM@public.gmane.org" <msuchanek-l3A5Bk7waGM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel@l>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch-jcswGhMUV9g@public.gmane.org]
> Sent: Monday, April 23, 2018 6:27 PM
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org; hch-jcswGhMUV9g@public.gmane.org; linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org;
> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
> bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; msuchanek-l3A5Bk7waGM@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dri-
> devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bharat Bhushan
> <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH v3 1/2] dma-mapping: move dma configuration to bus
> infrastructure
> 
> Can you resend your changes against Linux 4.17-rc2?  There are a lot
> of conflicts as-is.

Sure.. I will send it soon..

Regards,
Nipun
