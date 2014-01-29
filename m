From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
	block
Date: Wed, 29 Jan 2014 19:19:03 +0000
Message-ID: <fd76e563312749508e5f952f5d9b1391@BL2PR03MB468.namprd03.prod.outlook.com>
References: <20140120222814.GI3471@alberich>
	<e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122122550.GA14108@mudshark.cambridge.arm.com>
	<a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
	<20140122134028.GB14108@mudshark.cambridge.arm.com>
	<aeebc7cf4084486790a5166cf83cb332@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122153352.GE14108@mudshark.cambridge.arm.com>
	<3d0a888e122f490ba6bbc80b1aaa977c@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140123195718.GC26399@alberich>
	<991cc0024ea54cdb964f31de89c0b0ea@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140129141429.GD19326@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140129141429.GD19326@alberich>
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
To: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Andreas Herrmann
> Sent: Wednesday, January 29, 2014 7:44 PM
> To: Sethi Varun-B16395
> Cc: Andreas Herrmann; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Will Deacon;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group
> notifier block
> 
> On Tue, Jan 28, 2014 at 11:00:35AM +0000, Varun Sethi wrote:
> >
> >
> > > -----Original Message-----
> > > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Andreas Herrmann
> > > Sent: Friday, January 24, 2014 1:27 AM
> > > To: Sethi Varun-B16395
> > > Cc: Andreas Herrmann; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Will Deacon;
> > > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > > Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group
> > > notifier block
> > >
> > > On Wed, Jan 22, 2014 at 07:07:40PM +0000, Varun Sethi wrote:
> > > > > -----Original Message-----
> > > > > From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> > > > > Sent: Wednesday, January 22, 2014 9:04 PM
> > > > > To: Sethi Varun-B16395
> > > > > Cc: Andreas Herrmann; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > > > > linux-arm- kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Andreas Herrmann
> > > > > Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce
> > > > > iommu_group notifier block
> > > > >
> > > > > On Wed, Jan 22, 2014 at 01:54:11PM +0000, Varun Sethi wrote:
> > > > > > > > > Ok, so are you suggesting that we perform the isolation
> > > > > > > > > mapping in arm_smmu_add_device and drop the notifier
> > > altogether?
> > > > > > > > I think that should be fine, until we want to delay
> > > > > > > > mapping creation till driver bind time.
> > > > > > >
> > > > > > > Is there a hard dependency on that?
> > > > > > >
> > > > > > Not sure, may be Andreas can answer that.
> > > > >
> > > > > Ok. Andreas? I would have thought doing this *earlier* shouldn't
> > > > > be a problem (the DMA ops must be swizzled before the driver is
> probed).
> > > > >
> > > > > > > > But the "isolate device" property should dictate iommu
> > > > > > > > group
> > > > > creation.
> > > > > > >
> > > > > > > The reason we added automatic group creation (per-device) is
> > > > > > > for VFIO, which expects all devices to be in a group
> > > > > > > regardless of the device isolation configuration.
> > > > > > >
> > > > > > IIUC, with the "isolate devices" property we ensure that there
> > > > > > would be independent SMR and S2CR per device. Is that correct?
> > > > >
> > > > > Yes, as part of giving them independent sets of page tables.
> > > > > Initially these tables don't have any valid mappings, but the
> > > > > dma-mapping API will populate them in response to
> > > dma_map_*/dma_alloc/etc.
> > > > >
> > > > > Not sure what this has to do with us putting devices into their
> > > > > own groups...
> > >
> > > > [Sethi Varun-B16395] Devices in an iommu group would share the dma
> > > > mapping, so shouldn't they be sharing the SMR and context
> registers?
> > >
> > > I aggree with the context but SMRs won't be shared. I think you just
> > > can say that a certain subset of the available SMRs will be used to
> > > map all devices in an iommu group to the same context. Depending on
> > > what streamIDs each device has you might have to use separate SMRs
> > > for each device to map it to the same context.
> 
> > [Sethi Varun-B16395] IIUC the SMRs would unique per device, but there
> > is a possibility where the number of context registers are restricted?
> > In that case IOMMU groups should correspond to unique stream IDs (and
> > corresponding SMRs).
> 
> > > > In case of the "isolate devices" property, each device would have
> > > > its own SMR and context registers, thus allowing the devices to
> > > > have independent mappings and allowing them to fall in separate
> > > > iommu groups.
> > >
> > > I aggree with Varun's view here. (Now that I take iommu groups into
> > > consideration.)
> > >
> > > But my goal with the "isolate devices" thing was twofold:
> > >
> > > 1. actual make use of SMMU for address translation for all master
> > >   devices (instead of just bypassing the SMMU)
> 
> > [Sethi Varun-B16395] even if masters have to share translation? But
> > from the patch it seemed that we are creating mapping only if we find
> > the isolate devices property.
> 
> Yes, the patch creates mappings only if isolate-devices property is
> given. Currently there is no trigger to create a common mapping for all
> devices attached to the same SMMU.
> 
> > > plus
> > >
> > > 2. put each master into it's own domain to isolate it
> > >
> > > The latter matches usage of separate iommu groups for devices. If we
> > > now use the isolate devices property to just control whether master
> > > devices fall into the same or separate iommu groups it seems to me
> > > we would need to have another mechanism that triggers the creation
> > > of a mapping for a group.
> > >
> > > What do you think?
> > >
> 
> > [Sethi Varun-B16395] As mentioned before, we should be having iommu
> > group per device (having a unique stream id). Isolate devices property
> > just ensures that each device has a unique context. Now, for the
> > devices for which we don't have the isolate device property, can't we
> > have the multiple devices point to a common mapping.
> 
> Hmm, the isolate-devices option is per SMMU. So if this is set for an
> SMMU the driver tries to create a mapping per device. (And this is done
> for all master devices of this SMMU.)
> 
> Are you requesting to change the default behaviour of the driver to
> create a shared mapping in case the isolate-devices property is not
> specified in DT for an SMMU node?
> 
> Or maybe your concern is that you have x master devices for an SMMU which
> support y number of contexts and x > y? Which would imply that not all
> devices can be isolated and some need to share a context?
> 
[Sethi Varun-B16395] I am trying to understand the requirement for the "isolate devices" property. Currently no default in mapping is created in the SMMU driver. The new property allows default mapping to be created for all masters. Why can't we create default mappings for all masters without this property?

-Varun
