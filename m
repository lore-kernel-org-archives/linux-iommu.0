From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
Date: Tue, 02 Sep 2014 17:04:30 +0200
Message-ID: <3346878.JiG6x1BkX4@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-2-git-send-email-will.deacon@arm.com>
 <04b313674bc14231a47570f91336c6e6@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <04b313674bc14231a47570f91336c6e6@BL2PR03MB468.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: "jroedel@suse.de" <jroedel@suse.de>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hdoyu@nvidia.com" <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 02 September 2014 14:47:54 Varun Sethi wrote:
> > +void __init of_iommu_init(void)
> > +{
> > +     struct device_node *np;
> > +     const struct of_device_id *match, *matches = &__iommu_of_table;
> > +
> > +     for_each_matching_node_and_match(np, matches, &match) {
> > +             const int (*init_fn)(struct device_node *) = match->data;
> 
> Is the init function also responsible for setting iommu_ops (per bus)?
> We need to take in to consideration that iommu API (iommu.c)
> initialization happens during  "arch_init".

I would hope that as part as one of the next steps, we can skip
the step of setting the iommu_ops per bus_type. It's really
not that meaningful when only some of the devices on one bus
are able to use an iommu, and some may need other ops than others.

> When we setup bus iommu
> ops add_device would be called for devices which have already been
> probed.

As soon as you move to the generic way of probing the IOMMU for
DT, you should not need an add_device callback any more.

Each iommu driver should do one one or the other, but not both.

> Also, as I can see from the code we have of_platform_populate
> which gets called right after of_iommu_init, which would in turn also
> lead to add_device invocation (after add_device_master_ids). 
> I believe this would happen before iommu API initialization which
> would cause issues. 

of_iommu_init should be the point where the iommu API gets
initialized.

	Arnd
