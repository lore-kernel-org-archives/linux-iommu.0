From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Date: Thu, 13 Sep 2018 05:01:46 +0000
Message-ID: <VI1PR04MB448065E40C0930BA42FDE08DE61A0@VI1PR04MB4480.eurprd04.prod.outlook.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
	<20180912165845.GD16071@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180912165845.GD16071-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linuxppc-dev-uLR06cmDAlatORQsKGg5Ig@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, September 12, 2018 10:29 PM
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; catalin.marinas-5wv7dgnIgG8@public.gmane.org;
> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>;
> bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; hch-jcswGhMUV9g@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
> shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>;
> stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
> 
> Hi Nipun,
> 
> On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> > This patchset defines IOMMU DT binding for fsl-mc bus and adds
> > support in SMMU for fsl-mc bus.
> >
> > These patches
> >   - Define property 'iommu-map' for fsl-mc bus (patch 1)
> >   - Integrates the fsl-mc bus with the SMMU using this
> >     IOMMU binding (patch 2,3,4)
> >   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
> >   - Updates the fsl-mc device node with iommu/dma related changes (patch 7)
> 
> It looks like you have all the Acks in place for this series now, so I
> assume it's going to go via Joerg directly. Is that right?

This is what I am expecting :)
 
> Will
> 
