From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/of: Only do IOMMU lookup for available ones
Date: Thu, 18 Jan 2018 14:41:18 +0000
Message-ID: <20180118144118.GA12394@arm.com>
References: <20180103060920.23475-1-jeffy.chen@rock-chips.com>
	<20180117132808.s5henw63oseg3ufd@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180117132808.s5henw63oseg3ufd-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 17, 2018 at 02:28:08PM +0100, Joerg Roedel wrote:
> On Wed, Jan 03, 2018 at 02:09:20PM +0800, Jeffy Chen wrote:
> > The for_each_matching_node_and_match() would return every matching
> > nodes including unavailable ones.
> > 
> > It's pointless to init unavailable IOMMUs, so add a sanity check to
> > avoid that.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > ---
> > 
> >  drivers/iommu/of_iommu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 50947ebb6d17..6f7456caa30d 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -240,6 +240,9 @@ static int __init of_iommu_init(void)
> >  	for_each_matching_node_and_match(np, matches, &match) {
> >  		const of_iommu_init_fn init_fn = match->data;
> >  
> > +		if (!of_device_is_available(np))
> > +			continue;
> > +
> 
> Makes sense to me, but I'd like to have an OK from Robin or Will (added
> to Cc) before applying this.

I don't think this patch makes a lot of sense in isolation: the SMMU drivers
themselves will likely still probe, and it's unclear what we should about
DMA when an IOMMU is not deemed to be available. See:

https://patchwork.kernel.org/patch/9681211/

Jeffy -- are you solving a real issue here, or is this just an attempt at
some cleanup?

Will
