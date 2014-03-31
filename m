From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: mechanism to allow a driver to bind to any device
Date: Mon, 31 Mar 2014 20:23:36 +0000
Message-ID: <c6a10ce9bfd84287b5c5aa3809987b2b@DM2PR03MB352.namprd03.prod.outlook.com>
References: <7043e1edd9974de590dcb392cd8aff14@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215173348.GA8056@kroah.com>
	<b6374a0f30194969ba4622ff2f58ae65@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140220224337.GA20097@kroah.com>
	<54cd150235ba4954becdd12f725c5ebd@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140326144025.GA18387@phenom.dumpdata.com>
	<D45FC8F2-7807-4BBB-A253-8EFCD091D6BD@suse.de>
	<1395850862.632.247.camel@ul30vt.home>
	<1395871761.632.316.camel@ul30vt.home>
	<7d1b495cdb6a415e8d3b7f60f409991c@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140331194705.GA13014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140331194705.GA13014-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "Rafael J.
	Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org]
> Sent: Monday, March 31, 2014 2:47 PM
> To: Yoder Stuart-B08248
> Cc: Alex Williamson; Alexander Graf; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; Michal Hocko; Wood Scott-B07421; Sethi
> Varun-B16395; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; Rafael J. Wysocki; Guenter
> Roeck; Dmitry Kasatkin; Tejun Heo; Bjorn Helgaas; Antonios Motakis;
> tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; Toshi Kani; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Joe Perches;
> christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Subject: Re: mechanism to allow a driver to bind to any device
> 
> On Mon, Mar 31, 2014 at 06:47:51PM +0000, Stuart Yoder wrote:
> > I also, was at the point where I thought we should perhaps just
> > go with current mechanisms and implement new_id for the platform
> > bus...but Greg's recent response is 'platform devices suck' and it
> sounds
> > like he would reject a new_id patch for the platform bus.  So it kind
> > of feels like we are stuck.
> 
> ids mean nothing in the platform device model, so having a new_id file
> for them makes no sense.

They don't have IDs like PCI, but platform drivers have to match on
something.  Platform device match tables are based on compatible strings.

Example from Freescale DMA driver:
  static const struct of_device_id fsldma_of_ids[] = {
        { .compatible = "fsl,elo3-dma", },
        { .compatible = "fsl,eloplus-dma", },
        { .compatible = "fsl,elo-dma", },
        {}
  };

The process of unbinding, setting a new_id, and binding to vfio would work
just like PCI:

   echo ffe101300.dma > /sys/bus/platform/devices/ffe101300.dma/driver/unbind
   echo fsl,eloplus-dma > /sys/bus/platform/drivers/vfio-platform/new_id

Thanks,
Stuart
