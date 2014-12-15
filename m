From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/4] Generic IOMMU page table framework
Date: Mon, 15 Dec 2014 19:46:40 +0200
Message-ID: <7468866.mC89q8GVPA@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1703241.O5cxT4doxg@avalon> <20141215173911.GT20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141215173911.GT20738-5wv7dgnIgG8@public.gmane.org>
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
Cc: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 15 December 2014 17:39:11 Will Deacon wrote:
> On Mon, Dec 15, 2014 at 05:33:32PM +0000, Laurent Pinchart wrote:
> > On Monday 15 December 2014 16:10:52 Will Deacon wrote:
> > > On Sun, Dec 14, 2014 at 11:49:30PM +0000, Laurent Pinchart wrote:
> > > > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > > > index c1cff3d045db..a41a15d30596 100644
> > > > --- a/drivers/iommu/io-pgtable.h
> > > > +++ b/drivers/iommu/io-pgtable.h
> > > > @@ -24,6 +24,9 @@ struct iommu_gather_ops {
> > > > 
> > > >  	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
> > > >  
> > > >  };
> > > > 
> > > > +/* Set the Non-Secure bit in the PTEs */
> > > > +#define IO_PGTABLE_QUIRK_NON_SECURE	(1 << 0)
> > > 
> > > I think I'd stick an _ARM_ somewhere in here, so maybe
> > > IO_PGTABLE_QUIRK_ARM_NS?
> > 
> > I'm fine with that.
> > 
> > By the way, I'm only familiar with the Renesas implementation of the VMSA
> > IOMMU, could you double-check whether setting the NSTABLE and NS bits on
> > all levels make sense to you ? It seems to be required by my hardware,
> > even though the ARM spec mentions that setting the NSTABLE bit causes
> > non-secure accesses to page tables for all lower levels regardless of
> > their NSTABLE/NS bits.
>
> The ARM ARM is very clear that subsequent levels of lookup must ignore the
> NSTABLE/NS bits since otherwise you potentially have a security violation
> where you can use the table walker to access secure memory from
> non-secure...
>
> So, you might want to check up on that, but given that this is a quirk I'm
> happy for it to do whatever you need.

Given that the ARM ARM states that subsequent levels must consider the 
NSTABLE/NS bits to be set, I think it's harmless to actually set them. I just 
wanted to double-check with you, as we agree let's proceed with the proposed 
patch.

-- 
Regards,

Laurent Pinchart
