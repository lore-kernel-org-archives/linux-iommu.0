From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] iommu/vt-d: Use cmpxchg16b to update posted format IRTE
	atomically
Date: Fri, 16 Oct 2015 01:01:02 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00ADDD81E@SHSMSX104.ccr.corp.intel.com>
References: <1444875551-4064-1-git-send-email-feng.wu@intel.com>
	<20151015142420.GT27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151015142420.GT27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-kernel-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Joerg Roedel
> Sent: Thursday, October 15, 2015 10:24 PM
> To: Wu, Feng <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] iommu/vt-d: Use cmpxchg16b to update posted format
> IRTE atomically
> 
> On Thu, Oct 15, 2015 at 10:19:11AM +0800, Feng Wu wrote:
> > If IRTE is in posted format, the 'pda' field goes across the 64-bit
> > boundary, we need use cmpxchg16b to atomically update it. We only
> > expose posted-interrupt when X86_FEATURE_CX16 is supported and use
> > to update it atomically.
> > +
> > +		ret = cmpxchg_double(&irte->low, &irte->high,
> > +				     irte->low, irte->high,
> > +				     irte_modified->low, irte_modified->high);
> > +		/*
> > +		 * We use cmpxchg16 to atomically update the 128-bit IRTE,
> > +		 * and it cannot be updated by the hardware or other
> processors
> > +		 * behind us, so the return value of cmpxchg16 should be the
> > +		 * same as the old value.
> > +		 */
> > +		BUG_ON(!ret);
> 
> Changed this to a WARN_ON, otherwise applied.

Thanks a lot, Joerg!

Thanks,
Feng
