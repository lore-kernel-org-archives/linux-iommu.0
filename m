From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2 4/7] iommu: provide helper function to configure
 an IOMMU for an of master
Date: Thu, 4 Sep 2014 12:26:25 +0100
Message-ID: <20140904112625.GE7156@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-5-git-send-email-will.deacon@arm.com>
 <5768908.PeRFksrdyQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5768908.PeRFksrdyQ@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "jroedel@suse.de" <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

Thanks for the review.

On Tue, Sep 02, 2014 at 08:10:10PM +0100, Arnd Bergmann wrote:
> On Tuesday 02 September 2014 18:56:24 Will Deacon wrote:
> > +struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
> > +{
> > +       struct of_phandle_args iommu_spec;
> > +       struct iommu_dma_mapping *mapping;
> > +       struct bus_type *bus = dev->bus;
> > +       const struct iommu_ops *ops = bus->iommu_ops;
> 
> I think it would be best to not even introduce the tight coupling
> between bus_type and iommu_ops here, one of the main reasons we
> are doing this is to break that connection.
> 
> Better put the iommu_ops into the iommu_data pointer that gets looked
> up per iommu device.

Yes, I'll add that. It's a bit weird, because those same ops will later
be duplicated in iommu_data->domain->ops, but that's an artifact of how
the domain is currently constructed by iommu_domain_alloc.

> > +       struct iommu_data *iommu = NULL;
> > +       int idx = 0;
> > +
> > +       if (!iommu_present(bus) || !ops->of_xlate)
> > +               return NULL;
> > +
> > +       /*
> > +        * We don't currently walk up the tree looking for a parent IOMMU.
> > +        * See the `Notes:' section of
> > +        * Documentation/devicetree/bindings/iommu/iommu.txt
> > +        */
> > +        */
> > +       while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> > +                                          "#iommu-cells", idx,
> > +                                          &iommu_spec)) {
> > +               struct device_node *np = iommu_spec.np;
> > +               struct iommu_data *data = of_iommu_get_data(np);
> > +
> > +               if (!iommu) {
> > +                       if (!ops->of_xlate(dev, &iommu_spec))
> > +                               iommu = data;
> 
> I would make the first argument of the of_xlate function the iommu_data,
> so the code can find the right instance.

Oops, that's what I intended. Well spotted.

> Maybe also add an extra argument at the end that can be used by the
> PCI code and potentially other drivers with multiple master IDs
> behind one "iommus" property to pass some value identifying which of
> the masters is meant.
> 
> The format of that is unfortunately bus specific and our platform_bus
> really covers a number of different hardware buses (AXI, AHB, OPB, ...)
> but the caller should be able to provide the data in the right form
> that the iommu understands. I would try using a single u64 argument
> as a start, hoping that this covers all the buses we need. At least
> it's enough for PCI (bus/device/function) and for AXI (requester-id?).

Yeah, I think that will work. It's kind of like a device `index' for a
device that sits behind a bridge (trying to avoid yet another ID parameter
:).

> 
> > +               } else if (iommu != data) {
> > +                       pr_warn("Rejecting device %s with multiple IOMMU instances\n",
> > +                               dev_name(dev));
> > +                       iommu = NULL;
> > +               }
> > +
> > +               of_node_put(np);
> > +
> > +               if (!iommu)
> > +                       break;
> > +
> > +               idx++;
> > +       }
> > +
> > +       if (!iommu)
> > +               return NULL;
> > +
> > +       mapping = devm_kzalloc(dev, sizeof(*mapping), GFP_KERNEL);
> > +       if (!mapping)
> > +               return NULL;
> > 
> 
> I don't think it's safe to use devm_* functions here: this is during
> device discovery, and this data will be freed if probe() fails or
> the device gets removed from a driver.

So I can make this a standard kzalloc, but I have no idea where the
corresponding kfree should live. Is there something equivalent to
of_dma_unconfigure, or is this data that is expected to persist?

Will
