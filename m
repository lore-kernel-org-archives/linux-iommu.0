From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
 block
Date: Wed, 22 Jan 2014 13:40:28 +0000
Message-ID: <20140122134028.GB14108@mudshark.cambridge.arm.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
 <20140120222814.GI3471@alberich>
 <e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140122122550.GA14108@mudshark.cambridge.arm.com>
 <a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
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
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Andreas Herrmann <herrmann.der.user@googlemail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 22, 2014 at 01:14:13PM +0000, Varun Sethi wrote:
> > On Tue, Jan 21, 2014 at 05:48:02PM +0000, Varun Sethi wrote:
> > > > +static int arm_smmu_group_notifier(struct notifier_block *nb,
> > > > +				unsigned long action, void *data) {
> > > > +	struct device *dev = data;
> > > > +	struct dma_iommu_mapping *mapping;
> > > > +	struct arm_smmu_device *smmu;
> > > > +	int ret;
> > > > +
> > > > +	switch (action) {
> > > > +	case IOMMU_GROUP_NOTIFY_BIND_DRIVER:
> > > > +
> > > > +		smmu = dev->archdata.iommu;
> > > > +		if (!smmu || !(smmu->options & ARM_SMMU_OPT_ISOLATE_DEVICES))
> > > > +			break;
> > > [Sethi Varun-B16395] Should this check be really done here? The
> > > "Isolate devices" property would allow us to set up iommu groups. My
> > > understanding is that if we specify the isolate devices property, then
> > > each device would have a separate iommu group otherwise all devices
> > > connected to the SMMU would share the iommu group.
> > 
> > That's not what currently happens (at least, in the patch I have queued
> > for groups). The code queued adds each device to its own group in
> > arm_smmu_add_device, which I think is the right thing to do.
> > 
> > > With that logic, we should link the mapping to the iommu group.
> > 
> > Ok, so are you suggesting that we perform the isolation mapping in
> > arm_smmu_add_device and drop the notifier altogether?
> I think that should be fine, until we want to delay mapping creation till
> driver bind time.

Is there a hard dependency on that?

> But the "isolate device" property should dictate iommu group creation.

The reason we added automatic group creation (per-device) is for VFIO, which
expects all devices to be in a group regardless of the device isolation
configuration.

Will
