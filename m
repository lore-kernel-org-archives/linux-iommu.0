From: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v3 02/11] iommu/arm-smmu: Introduce iommu_group notifier
	block
Date: Fri, 24 Jan 2014 10:48:04 +0100
Message-ID: <20140124094804.GG26399@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
	<20140120222814.GI3471@alberich>
	<e92c5fd617fb4068b4ec5de696527ee3@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122122550.GA14108@mudshark.cambridge.arm.com>
	<a73ef0128a0141eabf0a3b899f3afdae@DM2PR03MB479.namprd03.prod.outlook.com>
	<20140122134028.GB14108@mudshark.cambridge.arm.com>
	<aeebc7cf4084486790a5166cf83cb332@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140122153352.GE14108@mudshark.cambridge.arm.com>
	<20140123192429.GB26399@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123192429.GB26399@alberich>
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
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 23, 2014 at 08:24:29PM +0100, Andreas Herrmann wrote:
> On Wed, Jan 22, 2014 at 03:33:52PM +0000, Will Deacon wrote:
> > On Wed, Jan 22, 2014 at 01:54:11PM +0000, Varun Sethi wrote:
> > > > > > Ok, so are you suggesting that we perform the isolation mapping in
> > > > > > arm_smmu_add_device and drop the notifier altogether?
> > > > > I think that should be fine, until we want to delay mapping creation
> > > > > till driver bind time.
> > > > 
> > > > Is there a hard dependency on that?
> > > > 
> > > Not sure, may be Andreas can answer that.
> > 
> > Ok. Andreas? I would have thought doing this *earlier* shouldn't be a
> > problem (the DMA ops must be swizzled before the driver is probed).
> 
> Yes, I think, there is no hard dependency.
> 
> (But still have to double check whether arm_smmu_add_device can be
> used instead of the notifier. Will finally see this when doing some
> tests.)

I think we have to keep the notifier and delay mapping creation until
device is bound to a driver.

Otherwise we might create mappings for devices which might not be used
at all. Who guarantees that the running kernel will have driver
support for all devices? If there is no driver for a device why create
a mapping for it -- no DMA will happen.


Andreas
