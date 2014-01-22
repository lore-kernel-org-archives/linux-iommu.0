From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
	block
Date: Wed, 22 Jan 2014 13:14:13 +0000
Message-ID: <a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
	<20140120222814.GI3471@alberich>
	<e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122122550.GA14108@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140122122550.GA14108-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
> Sent: Wednesday, January 22, 2014 5:56 PM
> To: Sethi Varun-B16395
> Cc: Andreas Herrmann; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Andreas Herrmann
> Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group
> notifier block
> 
> Hi Varun, Andreas,
> 
> On Tue, Jan 21, 2014 at 05:48:02PM +0000, Varun Sethi wrote:
> > > +static int arm_smmu_group_notifier(struct notifier_block *nb,
> > > +				unsigned long action, void *data) {
> > > +	struct device *dev = data;
> > > +	struct dma_iommu_mapping *mapping;
> > > +	struct arm_smmu_device *smmu;
> > > +	int ret;
> > > +
> > > +	switch (action) {
> > > +	case IOMMU_GROUP_NOTIFY_BIND_DRIVER:
> > > +
> > > +		smmu = dev->archdata.iommu;
> > > +		if (!smmu || !(smmu->options & ARM_SMMU_OPT_ISOLATE_DEVICES))
> > > +			break;
> > [Sethi Varun-B16395] Should this check be really done here? The
> > "Isolate devices" property would allow us to set up iommu groups. My
> > understanding is that if we specify the isolate devices property, then
> > each device would have a separate iommu group otherwise all devices
> > connected to the SMMU would share the iommu group.
> 
> That's not what currently happens (at least, in the patch I have queued
> for groups). The code queued adds each device to its own group in
> arm_smmu_add_device, which I think is the right thing to do.
> 
> > With that logic, we should link the mapping to the iommu group.
> 
> Ok, so are you suggesting that we perform the isolation mapping in
> arm_smmu_add_device and drop the notifier altogether?
I think that should be fine, until we want to delay mapping creation till driver bind time. But the "isolate device" property should dictate iommu group creation.

-Varun
