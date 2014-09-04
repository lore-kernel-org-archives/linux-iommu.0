From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2 4/7] iommu: provide helper function to configure
 an IOMMU for an of master
Date: Thu, 4 Sep 2014 13:28:24 +0100
Message-ID: <20140904122824.GF7156@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <5768908.PeRFksrdyQ@wuerfel> <20140904112625.GE7156@arm.com>
 <30707436.FH2aSkoH5H@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <30707436.FH2aSkoH5H@wuerfel>
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

On Thu, Sep 04, 2014 at 12:59:50PM +0100, Arnd Bergmann wrote:
> On Thursday 04 September 2014 12:26:25 Will Deacon wrote:
> > > 
> > > > +               } else if (iommu != data) {
> > > > +                       pr_warn("Rejecting device %s with multiple IOMMU instances\n",
> > > > +                               dev_name(dev));
> > > > +                       iommu = NULL;
> > > > +               }
> > > > +
> > > > +               of_node_put(np);
> > > > +
> > > > +               if (!iommu)
> > > > +                       break;
> > > > +
> > > > +               idx++;
> > > > +       }
> > > > +
> > > > +       if (!iommu)
> > > > +               return NULL;
> > > > +
> > > > +       mapping = devm_kzalloc(dev, sizeof(*mapping), GFP_KERNEL);
> > > > +       if (!mapping)
> > > > +               return NULL;
> > > > 
> > > 
> > > I don't think it's safe to use devm_* functions here: this is during
> > > device discovery, and this data will be freed if probe() fails or
> > > the device gets removed from a driver.
> > 
> > So I can make this a standard kzalloc, but I have no idea where the
> > corresponding kfree should live. Is there something equivalent to
> > of_dma_unconfigure, or is this data that is expected to persist?
> > 
> 
> Can this be a simple kfree in of_platform_device_create_pdata?

We could certainly hook into the error path there (when of_device_add
fails), yes, but I was also thinking about device removal and whether we
need to care about that. I guess not for the OF case.

Will
