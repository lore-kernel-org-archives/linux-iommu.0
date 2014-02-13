From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu/arm-smmu: fix compilation issue when
	!CONFIG_ARM_AMBA
Date: Thu, 13 Feb 2014 17:04:08 +0000
Message-ID: <20140213170408.GM13576@mudshark.cambridge.arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
	<1391710173-4343-6-git-send-email-will.deacon@arm.com>
	<CAOZdJXW6tY=MjHGMa1EQtJayY=ToqiJOWsggCsEjfPzirUeUxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXW6tY=MjHGMa1EQtJayY=ToqiJOWsggCsEjfPzirUeUxg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 13, 2014 at 04:55:25PM +0000, Timur Tabi wrote:
> On Thu, Feb 6, 2014 at 12:09 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 0ae4dd39197f..6fe7922ecc1d 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -2004,8 +2004,10 @@ static int __init arm_smmu_init(void)
> >         if (!iommu_present(&platform_bus_type))
> >                 bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
> >
> > +#ifdef CONFIG_ARM_AMBA
> >         if (!iommu_present(&amba_bustype))
> >                 bus_set_iommu(&amba_bustype, &arm_smmu_ops);
> > +#endif
> 
> So I admit I don't know much about the ARM kernel (yet), but doesn't
> this break multi-arch?  That is, we can't support one binary that runs
> on a processor with AMBA and one without?

Huh?

It's harmless to enable CONFIG_ARM_AMBA, even if you don't have any AMBA
devices in your SoC, it just makes your binary a bit bigger because you're
compiling in code that you don't need. Instead, you might elect to set
CONFIG_ARM_AMBA=n, at which point the arm-smmu driver will fail to build
without this patch.

Will
