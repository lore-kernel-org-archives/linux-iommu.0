From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add system PM support
Date: Fri, 11 Aug 2017 11:04:06 +0100
Message-ID: <20170811110406.00003346@huawei.com>
References: <71247263f4d88e7776f483fb1cc1139b516c0835.1500381551.git.robin.murphy@arm.com>
	<d8d6f3b606ed05d53b47d36e1c6a7f4b74eb3afc.1500381551.git.robin.murphy@arm.com>
	<20170808111816.GD13355@arm.com>
	<7d0d846b-8ada-6514-ec27-22f4d8487014@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7d0d846b-8ada-6514-ec27-22f4d8487014-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 8 Aug 2017 13:14:18 +0100
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 08/08/17 12:18, Will Deacon wrote:
> > On Tue, Jul 18, 2017 at 01:44:42PM +0100, Robin Murphy wrote:  
> >> With all our hardware state tracked in such a way that we can naturally
> >> restore it as part of the necessary reset, resuming is trivial, and
> >> there's nothing to do on suspend at all.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 86897b7b81d8..0f5f06e9abfa 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -2356,10 +2356,22 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> >> +{  
> > 
> > Did you actually get a warning here without the __maybe_unused annotation?
> > It looks like some other drivers just guard the thing with CONFIG_PM_SLEEP.  
> 
> I'm under the impression that the annotation is preferred over #ifdefs
> for new code (for the sake of coverage, I guess).
https://patchwork.kernel.org/patch/9734367/

Is a good thread discussing this.  Both coverage and to avoid common
pitfalls of the ifdef fun.

Jonathan
> 
> >> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> >> +
> >> +	arm_smmu_device_reset(smmu);
> >> +	return 0;
> >> +}
> >> +
> >> +
> >> +static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> >> +
> >>  static struct platform_driver arm_smmu_driver = {
> >>  	.driver	= {
> >>  		.name		= "arm-smmu",
> >>  		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> >> +		.pm = &arm_smmu_pm_ops,  
> > 
> > Cosmetic: can you tab-align this assignment please?  
> 
> Oops, I missed that - will do.
> 
> Robin.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
