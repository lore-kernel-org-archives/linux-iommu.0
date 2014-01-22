From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
	block
Date: Wed, 22 Jan 2014 19:07:40 +0000
Message-ID: <3d0a888e122f490ba6bbc80b1aaa977c@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
	<20140120222814.GI3471@alberich>
	<e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122122550.GA14108@mudshark.cambridge.arm.com>
	<a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
	<20140122134028.GB14108@mudshark.cambridge.arm.com>
	<aeebc7cf4084486790a5166cf83cb332@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122153352.GE14108@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140122153352.GE14108-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, January 22, 2014 9:04 PM
> To: Sethi Varun-B16395
> Cc: Andreas Herrmann; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Andreas Herrmann
> Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group
> notifier block
> 
> On Wed, Jan 22, 2014 at 01:54:11PM +0000, Varun Sethi wrote:
> > > > > Ok, so are you suggesting that we perform the isolation mapping
> > > > > in arm_smmu_add_device and drop the notifier altogether?
> > > > I think that should be fine, until we want to delay mapping
> > > > creation till driver bind time.
> > >
> > > Is there a hard dependency on that?
> > >
> > Not sure, may be Andreas can answer that.
> 
> Ok. Andreas? I would have thought doing this *earlier* shouldn't be a
> problem (the DMA ops must be swizzled before the driver is probed).
> 
> > > > But the "isolate device" property should dictate iommu group
> creation.
> > >
> > > The reason we added automatic group creation (per-device) is for
> > > VFIO, which expects all devices to be in a group regardless of the
> > > device isolation configuration.
> > >
> > IIUC, with the "isolate devices" property we ensure that there would
> > be independent SMR and S2CR per device. Is that correct?
> 
> Yes, as part of giving them independent sets of page tables. Initially
> these tables don't have any valid mappings, but the dma-mapping API will
> populate them in response to dma_map_*/dma_alloc/etc.
> 
> Not sure what this has to do with us putting devices into their own
> groups...
[Sethi Varun-B16395] Devices in an iommu group would share the dma mapping, so shouldn't they be sharing the SMR and context registers? In case of the "isolate devices"  property, each device would have its own SMR and context registers, thus allowing the devices to have independent mappings and allowing them to fall in separate iommu groups.

-Varun
