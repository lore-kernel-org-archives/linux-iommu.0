From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] dt: Add general DMA window parser
Date: Thu, 19 Apr 2012 15:19:20 +0300
Message-ID: <20120419151920.68ab735a5b9eb8fb938b4d11@nvidia.com>
References: <201204180731.54064.arnd@arndb.de>
	<20120418.121824.1894043789811063795.hdoyu@nvidia.com>
	<20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
	<20120418.131907.2172387798112620167.hdoyu@nvidia.com>
	<4F8EF99E.3050709@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F8EF99E.3050709-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 18 Apr 2012 19:27:58 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 04/18/2012 04:19 AM, Hiroshi Doyu wrote:
> 
> > Subject: [PATCH 1/1] dt: Add general DMA window parser
> > 
> > This code was stolen from:
> > 	"arch/microblaze/kernel/prom_parse.c"
> > 	"arch/powerpc/kernel/prom_parse.c"
> > 
> > Once "ibm," prefix is removed from dts file. This generic one could
> > replace the originals.

It seems that the "ibm," prefix is not used in .dts files, but it
comes from the PAPR compliant firmware and cannot be changed.

The easiest solution would be to make the function understand both
variants.

> > +extern void of_parse_dma_window(struct device_node *dn,
> > +		       const void *dma_window_prop, unsigned long *busno,
> > +			       unsigned long *phys, unsigned long *size);
> 
> At least some other of_*() parsing functions take the property name
> rather than the property pointer, and also take an index into the
> property in order to support multiple entries in it. See for example
> of_parse_phandle and of_get_named_gpio_flags. Should this new API be
> similar? E.g.:
> 
> extern void of_parse_dma_window(struct device_node *np,
> 			const char *propname, int index,
> 			unsigned long *busno,
> 			unsigned long *phys, unsigned long *size);

At least, I can add the code checking the return value of this
function, which won't change the existing code.

Does anyone know the format of "ibm,dma-window"?
