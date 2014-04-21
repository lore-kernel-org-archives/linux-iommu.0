From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/9] iommu/ipmmu-vmsa: Define driver-specific page directory sizes
Date: Mon, 21 Apr 2014 22:52:14 +0200
Message-ID: <11850321.Q0Kc9vhtF9@avalon>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1398089589-9181-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <53556BDC.6040705@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <53556BDC.6040705@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Sergei,

Thank you for the review.

On Monday 21 April 2014 23:05:00 Sergei Shtylyov wrote:
> On 04/21/2014 06:13 PM, Laurent Pinchart wrote:
> > The PTRS_PER_(PGD|PMD|PTE) macros evaluate to different values depending
> > on whether LPAE is enabled. The IPMMU driver uses a long descriptor
> > format regardless of LPAE, making those macros mismatch the IPMMU
> > configuration on non-LPAE systems.
> > 
> > Replace the macros by driver-specific versions that always evaluate to
> > the right value.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   drivers/iommu/ipmmu-vmsa.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 1ae97d8..7c8c21e 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -210,6 +210,10 @@ static LIST_HEAD(ipmmu_devices);
> > 
> >   #define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
> >   #define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
> > 
> > +#define IPMMU_PTRS_PER_PTE		512
> > +#define IPMMU_PTRS_PER_PMD		512
> > +#define IPMMU_PTRS_PER_PGD		4
> > +
> 
> [...]
> 
> > @@ -487,7 +491,7 @@ static void ipmmu_free_puds(pgd_t *pgd)
> > 
> >   	unsigned int i;
> >   	
> >   	pud = pud_base;
> > 
> > -	for (i = 0; i < PTRS_PER_PUD; ++i) {
> > +	for (i = 0; i < IPMMU_PTRS_PER_PUD; ++i) {
> 
> I don't see where you #define IPMMU_PTRS_PER_PUD...

Come on, it's easy. I don't define it anywhere :-)

The line is changed in a further patch, it seems I've forgotten to compile-
test all intermediate versions. Thank you for catching the problem, I'll fix 
that in v2 and will make sure to properly test all patches individually.

-- 
Regards,

Laurent Pinchart

