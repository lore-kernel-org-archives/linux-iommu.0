From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: Re: [PATCH 1/9] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
Date: Fri, 27 Sep 2013 11:24:25 +0200
Message-ID: <20130927092425.GG3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380234982-1677-2-git-send-email-andreas.herrmann@calxeda.com>
 <20130927085811.GD8319@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130927085811.GD8319@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 27, 2013 at 04:58:12AM -0400, Will Deacon wrote:
> On Thu, Sep 26, 2013 at 11:36:13PM +0100, Andreas Herrmann wrote:
> > This should ensure that arm-smmu is initialized before other drivers
> > start handling devices that propably need smmu support.
> > 
> > Also remove module_exit function as we most likely never want to
> > unload this driver.
> 
> Doesn't hurt to leave the exit function there though, right?

Yes.

> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  drivers/iommu/arm-smmu.c |    8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 181c9ba..6808577 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1976,13 +1976,7 @@ static int __init arm_smmu_init(void)
> >  	return 0;
> >  }
> >  
> > -static void __exit arm_smmu_exit(void)
> > -{
> > -	return platform_driver_unregister(&arm_smmu_driver);
> > -}
> > -
> > -module_init(arm_smmu_init);
> > -module_exit(arm_smmu_exit);
> > +arch_initcall(arm_smmu_init);
> 
> Why not subsys_initcall, like the other ARM IOMMUs?

No specific reason. I just tried to load the driver at the earliest
point during boot.

I just retested successful with subsys_initcall. The initialization
sequence looks fine (and yes, arch_initcall is overkill).

Will adapt this.


Andreas
