From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM
	SMMUv3 driver
Date: Thu, 20 Jul 2017 12:17:05 +0100
Message-ID: <20170720111704.GA16356@arm.com>
References: <ace28bd1-2dd3-482c-d11b-539c055ee9b7@arm.com>
	<CAALAos8y0kLGrbwgz3u=ZVyteSicuPyQZ3Yp=LPZohXzVaE5NQ@mail.gmail.com>
	<20170719112524.GF13642@arm.com>
	<CAALAos_xGCt7U1Oz5uCf9Q4hP6fdn4fcymFNQP5xO_UBduSY3g@mail.gmail.com>
	<20170719113325.GI13642@arm.com>
	<CAALAos99HWLoW=0P-dvFA+oNsF03TRNzNbfppyQNtqmcRELXXQ@mail.gmail.com>
	<20170719115333.GJ13642@arm.com>
	<CAALAos-YbVbgvPmDYXeWaF4y8MQ9i7CG3tgGuf-QLR6hmXo18Q@mail.gmail.com>
	<20170720091003.GA17837@arm.com>
	<CAALAos8571-UVp7Ky81qFESVcNcWx_H2VOemFt_++NFCxcMg3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAALAos8571-UVp7Ky81qFESVcNcWx_H2VOemFt_++NFCxcMg3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 20, 2017 at 04:38:09PM +0530, Anup Patel wrote:
> On Thu, Jul 20, 2017 at 2:40 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Thu, Jul 20, 2017 at 09:32:00AM +0530, Anup Patel wrote:
> >> On Wed, Jul 19, 2017 at 5:23 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >> > There are two things here:
> >> >
> >> >   1. iommu_present() is pretty useless, because it applies to a "bus" which
> >> >      doesn't actually tell you what you need to know for things like the
> >> >      platform_bus, where some masters might be upstream of an SMMU and
> >> >      others might not be.
> >>
> >> I agree with you. The iommu_present() check in vfio_iommu_group_get()
> >> is not much useful. We only reach line which checks iommu_present()
> >> when iommu_group_get() returns NULL for given "struct device *". If there
> >> is no IOMMU group for a "struct device *" then it means there is no IOMMU
> >> HW doing translations for such device.
> >>
> >> If we drop the iommu_present() check (due to above reasons) in
> >> vfio_iommu_group_get() then we don't require the IOMMU_CAP_BYPASS
> >> and we can happily drop PATCH1, PATCH2, and PATCH3.
> >>
> >> I will remove the iommu_present() check in vfio_iommu_group_get()
> >> because it is only comes into actions when VFIO_NOIOMMU is
> >> enabled. This will also help us drop PATCH1-to-PATCH3.
> >
> > I don't think that's the right answer. Whilst iommu_present has obvious
> > shortcomings, its intention is clear: it should tell you whether a given
> > *device* is upstream of an IOMMU. So the right fix is to make this
> > per-device, instead of per-bus. Removing it altogether is worse than leaving
> > it like it is.
> >
> >> >   2. If a master *is* upstream of an IOMMU and you want to use no-IOMMU,
> >> >      then the VFIO no-IOMMU code needs to be extended so that it creates
> >> >      an IDENTITY domain on that IOMMU.
> >>
> >> The VFIO no-IOMMU mode is equivalent to Linux UIO hence having
> >> IDENTITY domain for VFIO no-IOMMU is not appropriate here.
> >
> > Can you elaborate on this please? I don't understand the argument you're
> > making. It's like saying "I don't like eggs, therefore I don't drive a
> > car".
> >
> 
> Like I said, VFIO no-IOMMU mode for a device means device transactions
> will not go through any IOMMU. That's why having IDENTITY domain for
> device using VFIO no-IOMMU is not semantically correct. The analogy you
> proposed does not apply here.

If you have a master that is wired through an IOMMU, then its transactions
go through that IOMMU and you can't avoid that. What you want is a way for
the IOMMU driver to make the IOMMU appear transparent to the device. That is
achieved by creating an IDENTITY domain, which sounds perfect for what
you're trying to do.

Will
