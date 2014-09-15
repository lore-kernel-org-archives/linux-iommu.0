From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC][PATCH] devicetree: Add master-id-bits property to the iommu
	device
Date: Mon, 15 Sep 2014 18:57:05 +0200
Message-ID: <201409151857.05463.arnd@arndb.de>
References: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
	<201409150438.29649.arnd@arndb.de>
	<bfdff6494d7f46ab9a9f00f94159e9e1@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bfdff6494d7f46ab9a9f00f94159e9e1-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "Mark.Rutland-5wv7dgnIgG8@public.gmane.org" <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 15 September 2014, Varun Sethi wrote:
> > 
> > This seems rather specific to MMU-500. I don't think that most IOMMUs would
> > use the term 'master ID', 'stream ID' or even the general concept, and you
> > don't expand the acronym 'TBU'. I've seen many IOMMUs and I don't even
> > know what that means.
> 
> TBU refers to the translation buffer unit, which is responsible for caching page translations. In case of translation miss in the cache, translation request is forwarded to the TCU (Translation control unit). The master id forwarded to TCU would also contain the TBU ID.  Using the master-id-bits property we can mask out the additional TBU bits at the TCU. This is a cause of concern when we want to share master id for devices which are connected to different TBUs. We have a hot pluggable bus architecture, where a device group can have multiple devices connected to different TBUs. So, we need a mechanism to mask out additional TBIU bits.

Ok, I think I understand now

> > Why do you think this is something that is needed to be known at the global
> > level, rather than a property for some individual drivers?
> > 
> In case of Freescale Layerscape SOCs, number of bits used for defining a stream id are specific to a given platform. 
> 
> Are you suggesting that this property should be added to the master device node, rather than the iommu node?

Most importantly, I think this needs to be part of the (iommu) device specific binding, not the
generic binding that is used for all iommus that may or may not have this concept.

I believe in case of the ARM SMMU, it should actually go into the master node as part of
the 'iommus' property, because the mask can be different for each master. If your IOMMU
has a fixed mask that is used for all devices, that's fine and you can put it into
the iommu node itself but document it in the binding for your IOMMU.

For hot-pluggable buses, you probably need to have the 'iommus' property in the node
that corresponds to the bus controller, and that will have a mask that is used for
all devices plugged into it.

	Arnd
