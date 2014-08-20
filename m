From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/arm-smmu: implement generic DT bindings
Date: Wed, 20 Aug 2014 05:18:17 +0200
Message-ID: <201408200518.18036.arnd@arndb.de>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-5-git-send-email-mitchelh@codeaurora.org>
	<20140819125449.GN23128@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140819125449.GN23128-5wv7dgnIgG8@public.gmane.org>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 19 August 2014, Will Deacon wrote:
> > +static int arm_smmu_parse_iommus_properties(struct arm_smmu_device *smmu,
> > +                                     int *num_masters)
> > +{
> > +     struct of_phandle_args iommuspec;
> > +     struct device_node *dn;
> > +
> > +     for_each_node_with_property(dn, "iommus") {
> > +             int arg_ind = 0;
> > +             struct iommus_entry *entry, *n;
> > +             LIST_HEAD(iommus);
> > +
> > +             while (!of_parse_phandle_with_args(dn, "iommus", "#iommu-cells",
> > +                                                     arg_ind, &iommuspec)) {
> 
> We need to check that the phandle does indeed point at one of our SMMUs
> here, in case we have a system with multiple IOMMU types, all using the
> generic binding.

Why does the iommu driver do this at all? The of_parse_phandle_with_args()
call should really be part of the iommu common code when we probe the devices in
of_dma_configure() as far as I can tell.

The way I would have expected it to happen is to have some code that
ensures the iommu drivers are instantiated before we do call of_platform_populate,
and then of_dma_configure() looks for whether there is an iommu property or not
and calls into the respective iommu driver for doing the setup if there is.

	Arnd
