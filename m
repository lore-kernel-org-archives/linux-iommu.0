From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/7] iommu/arm-smmu: don't bother truncating the s1
	output size to VA_BITS
Date: Tue, 2 Dec 2014 09:26:38 +0000
Message-ID: <20141202092638.GA9917@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
	<1409849405-17347-6-git-send-email-will.deacon@arm.com>
	<87mw77cdft.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87mw77cdft.fsf-hBGjKatGTSWzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "tchalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <tchalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 01, 2014 at 08:39:18PM +0000, Andreas Schwab wrote:
> Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> writes:
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index ecad700cd4f4..2a7e3331b93a 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -24,7 +24,7 @@
> >   *	- v7/v8 long-descriptor format
> >   *	- Non-secure access to the SMMU
> >   *	- 4k and 64k pages, with contiguous pte hints.
> > - *	- Up to 42-bit addressing (dependent on VA_BITS)
> > + *	- Up to 48-bit addressing (dependent on VA_BITS)
> 
> Does that mean that the dependency on !ARM_SMMU for ARM64_VA_BITS_48 is
> obsolete?

No, you need my other patch series for that (we don't handle stage-2
properly without it):

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306786.html

Will
