From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v5 3/9] iommu, x86: Abstract modify_irte() to accept two
	format of irte
Date: Thu, 21 May 2015 07:01:34 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00254319E@SHSMSX104.ccr.corp.intel.com>
References: <1432098937-19527-1-git-send-email-feng.wu@intel.com>
	<1432098937-19527-4-git-send-email-feng.wu@intel.com>
	<alpine.DEB.2.11.1505201144370.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1505201144370.4225@nanos>
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
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org]
> Sent: Wednesday, May 20, 2015 7:46 PM
> To: Wu, Feng
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v5 3/9] iommu, x86: Abstract modify_irte() to accept two format
> of irte
> 
> On Wed, 20 May 2015, Feng Wu wrote:
> 
> > After introducing VT-d posted-interrupts, we have two format
> > of IRTE: remapped and posted. This patch make modify_irte()
> > suitable for both of them.
> 
> >  static int modify_irte(struct irq_2_iommu *irq_iommu,
> > -		       struct irte *irte_modified)
> > +		       void *data)
> 
> That's hardly an abstraction. You just make the pointer void so you
> can hand in arbitrary nonsense.
> 
> And with the new struct you having crap like this:
> 
> +               memcpy(irte_pi, &ir_data->irte_entry, sizeof(struct irte));
> 
> and this:
> 
> +       struct irte_pi *irte_pi = (struct irte_pi *)irte;
> 
> Why not extending struct irte proper and avoid the whole void pointer
> and mempcy and other crappola.
> 
> Patch below.
> 
> Thanks,
> 
> 	tglx
> 
> ------------->
> 
> iommu: dmar: Extend struct irte for VT-d Posted-Interrrupts
> 
> The IRTE (Interrupt Remapping Table Entry) is either an entry for
> remapped or for posted interrupts. The hardware distiguishes between
> remapped and posted entries by bit 15 in the low 64 bit of the
> IRTE. If cleared the entry is remapped, if set it's posted.
> 
> The entries have common fields and dependent on the posted bit fields
> with different meanings.
> 
> Extend struct irte to handle the differences between remap and posted
> mode by having three structs in the unions:
> 
> 	- Shared
> 	- Remapped
> 	- Posted
> 
> Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  include/linux/dmar.h |   68
> +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 15 deletions(-)
> 
> Index: linux/include/linux/dmar.h
> ================================================================
> ===
> --- linux.orig/include/linux/dmar.h
> +++ linux/include/linux/dmar.h
> @@ -185,28 +185,66 @@ static inline int dmar_device_remove(voi
> 
>  struct irte {
>  	union {
> +		/* Shared between remap and posted mode*/
>  		struct {
> -			__u64	present 	: 1,
> -				fpd		: 1,
> -				dst_mode	: 1,
> -				redir_hint	: 1,
> -				trigger_mode	: 1,
> -				dlvry_mode	: 3,
> -				avail		: 4,
> -				__reserved_1	: 4,
> -				vector		: 8,
> -				__reserved_2	: 8,
> -				dest_id		: 32;
> +			__u64	present		: 1,  /*  0      */
> +				fpd		: 1,  /*  1      */
> +				__res0		: 6,  /*  2 -  6 */
> +				avail		: 4,  /*  8 - 11 */
> +				__res1		: 3,  /* 12 - 14 */
> +				posted		: 1,  /* 15      */
> +				vector		: 8,  /* 16 - 23 */
> +				__res2		: 40; /* 24 - 63 */
> +		};
> +
> +		/* Remap mode */
> +		struct {
> +			__u64	r_present	: 1,  /*  0      */
> +				r_fpd		: 1,  /*  1      */
> +				dst_mode	: 1,  /*  2      */
> +				redir_hint	: 1,  /*  3      */
> +				trigger_mode	: 1,  /*  4      */
> +				dlvry_mode	: 3,  /*  5 -  7 */
> +				r_avail		: 4,  /*  8 - 11 */
> +				r_res1		: 4,  /* 12 - 13 */
> +				r_posted	: 1,  /* 15      */
> +				r_vector	: 8,  /* 16 - 23 */
> +				r_res2		: 8,  /* 24 - 31 */
> +				dest_id		: 32; /* 32 - 63 */
> +		};
> +
> +		/* Posted mode */
> +		struct {
> +			__u64	p_present	: 1,  /*  0      */
> +				p_fpd		: 1,  /*  1      */
> +				p_res0		: 6,  /*  2 -  6 */
> +				p_avail		: 4,  /*  8 - 11 */
> +				p_res1		: 4,  /* 12 - 13 */
> +				p_urgent	: 1,  /* 14      */
> +				p_posted	: 1,  /* 15      */
> +				p_vector	: 8,  /* 16 - 23 */
> +				p_res2		: 14, /* 24 - 37 */
> +				pda_l		: 26; /* 38 - 63 */
>  		};
>  		__u64 low;
>  	};
> 
>  	union {
> +		/* Shared between remap and posted mode*/
> +		struct {
> +			__u64	sid		: 16,  /* 64 - 79 */
> +				sq		: 2,   /* 80 - 81 */
> +				svt		: 2,   /* 82 - 83 */
> +				__res3		: 44;  /* 84 - 127 */
> +		};
> +
> +		/* Posted mode*/
>  		struct {
> -			__u64	sid		: 16,
> -				sq		: 2,
> -				svt		: 2,
> -				__reserved_3	: 44;
> +			__u64	p_sid		: 16,  /* 64 - 79 */
> +				p_sq		: 2,   /* 80 - 81 */
> +				p_svt		: 2,   /* 82 - 83 */
> +				p_res3		: 12,  /* 84 - 95 */
> +				pda_h		: 32;  /* 96 - 127 */
>  		};
>  		__u64 high;
>  	};

This looks great, thanks for your suggestion!

In fact, I also thought about combining this two formats into one structure,
but I encountered two problems:
1. Need change the current remapping code which uses this structure.
2. Building errors.

You patch solves the first issue by generating a shared part in the union,
and based on that it is easy to address the build error issue by renaming
the members.

Thanks,
Feng
