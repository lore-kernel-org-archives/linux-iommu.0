From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: add support for iova_to_phys through
	ATS1PR
Date: Wed, 24 Sep 2014 17:37:12 +0100
Message-ID: <20140924163712.GG16244@arm.com>
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
	<1410460244-18943-3-git-send-email-mitchelh@codeaurora.org>
	<20140922152614.GP25809@arm.com>
	<vnkwiokdx1nj.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <vnkwiokdx1nj.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 24, 2014 at 02:12:00AM +0100, Mitchel Humpherys wrote:
> On Mon, Sep 22 2014 at 08:26:14 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Thu, Sep 11, 2014 at 07:30:44PM +0100, Mitchel Humpherys wrote:
> >> +		return arm_smmu_iova_to_phys_soft(domain, iova);
> >> +	}
> >> +
> >> +	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
> >> +	phys |= ((u64) readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
> >> +
> >> +	if (phys & CB_PAR_F) {
> >> +		dev_err(dev, "translation fault on %s!\n", dev_name(dev));
> >> +		dev_err(dev, "PAR = 0x%llx\n", phys);
> >> +	}
> >> +	phys = (phys & 0xFFFFFFF000ULL) | (iova & 0x00000FFF);
> >
> > How does this work for 64k pages?
> 
> So at the moment we're always assuming that we're using v7/v8 long
> descriptor format, right?  All I see in the spec (14.5.15 SMMU_CBn_PAR)
> is that bits[47:12]=>PA[47:12]...  Or am I missing something completely?

I think you've got 64k pages confused with the short-descriptor format.

When we use 64k pages with long descriptors, you're masked off bits 15-12 of
the iova above, so you'll have a hole in the physical address afaict.

Will
