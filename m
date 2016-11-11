From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v6 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Fri, 11 Nov 2016 03:13:32 +0200
Message-ID: <4788186.AG5JRIdpl8@avalon>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
	<941ff264-8f9f-e0e6-2b50-bdd3e19946e5@arm.com>
	<20161110114206.GC9996@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161110114206.GC9996-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On Thursday 10 Nov 2016 12:42:06 Joerg Roedel wrote:
> On Fri, Oct 21, 2016 at 06:52:53PM +0100, Robin Murphy wrote:
> > > -static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> > > -{
> > > -	if (type != IOMMU_DOMAIN_UNMANAGED)
> > > -		return NULL;
> > 
> > I *think* that if we did the initial check thus:
> > 	if (type != IOMMU_DOMAIN_UNMANAGED ||
> > 	
> > 	    (IS_ENABLED(CONFIG_IOMMU_DMA) && type != IOMMU_DOMAIN_DMA))
> > 		
> > 		return NULL;
> > 
> > it shouldn't be necessary to split the function at all - we then just
> > wrap the {get,put}_cookie() bits in "if (type ==  IOMMU_DOMAIN_DMA)" and
> > in the 32-bit ARM case they just don't run as that can never be true.
> 
> This would be a good improvement. Magnus, Robin, can either of you send
> a follow-on patch to implement this suggestion? I have applied these
> patches to my arm/renesas branch (not pushed yet). The patch can be
> based on it.

I like the suggestion too, a patch is on its way.

Joerg, as I've sent a few comments about the other patches (sorry for the late 
review, I got delayed by KS and LPC), the follow-up patch should probably be 
squashed into this one when Magnus addresses my comments. Could you please 
hold off pushing the arm/renesas branch until Magnus replies to this ?

-- 
Regards,

Laurent Pinchart
