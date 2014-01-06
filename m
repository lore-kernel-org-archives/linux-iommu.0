From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Mon, 06 Jan 2014 09:41:29 +0800
Message-ID: <52CA09C9.7000205@hp.com>
References: <1387529101-29769-1-git-send-email-zhen-hual@hp.com>
	<CAOtp4KqUgSnwadP0T=aWYX7rRzDBn3qkuqMzceDBO0c_bhpFwQ@mail.gmail.com>
	<E959C4978C3B6342920538CF579893F001D3C26D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F001D3C26D-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Yes, that's the problem. And some other structures like this, see "union 
irte".

On 12/26/2013 01:12 PM, Wu, Feng wrote:
> I think if using |= operation, it should use &= operation to clear those
> bits first.
>
> Thanks,
>
> Feng
>
> *From:*iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> [mailto:iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] *On Behalf Of *Kai Huang
> *Sent:* Thursday, December 26, 2013 9:55 AM
> *To:* Li, Zhen-Hua
> *Cc:* David Woodhouse; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> *Subject:* Re: [PATCH 1/1] x86/iommu: use bit structures for context_entry
>
> Just curious, why would |= operation cause problem? :)
>
> On Fri, Dec 20, 2013 at 4:45 PM, Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org
> <mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org>> wrote:
>
> There is a structure named context_entry used by intel iommu, and there
> are some bit operations on it. Use bit structure may make these operations
> easy.
> Also the function context_set_address_root may cause problem because it uses
>   |= operation, not set the new value. And this patch can fix it.
>
> Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org <mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org>>
> ---
>   drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++----------
>   1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 43b9bfe..65cd480 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -221,47 +221,64 @@ get_context_addr_from_root(struct root_entry *root)
>    * 8-23: domain id
>    */
>   struct context_entry {
> -       u64 lo;
> -       u64 hi;
> +       union {
> +               struct {
> +                       u64     present:1,
> +                               fpd:1,
> +                               translation_type:2,
> +                               reserved_l:8,
> +                               asr:52;
> +               };
> +               u64 lo;
> +       };
> +       union {
> +               struct {
> +                       u64     aw:3,
> +                               avail:4,
> +                               reserved_h1:1,
> +                               did:16,
> +                               reserved_h2:40;
> +               };
> +               u64 hi;
> +       };
>   };
>
>   static inline bool context_present(struct context_entry *context)
>   {
> -       return (context->lo & 1);
> +       return context->present;
>   }
>   static inline void context_set_present(struct context_entry *context)
>   {
> -       context->lo |= 1;
> +       context->present = 1;
>   }
>
>   static inline void context_set_fault_enable(struct context_entry *context)
>   {
> -       context->lo &= (((u64)-1) << 2) | 1;
> +       context->fpd = 1;
>   }
>
>   static inline void context_set_translation_type(struct context_entry
> *context,
>                                                  unsigned long value)
>   {
> -       context->lo &= (((u64)-1) << 4) | 3;
> -       context->lo |= (value & 3) << 2;
> +       context->translation_type = value;
>   }
>
>   static inline void context_set_address_root(struct context_entry *context,
>                                              unsigned long value)
>   {
> -       context->lo |= value & VTD_PAGE_MASK;
> +       context->asr = value >> VTD_PAGE_SHIFT
>   }
>
>   static inline void context_set_address_width(struct context_entry
> *context,
>                                               unsigned long value)
>   {
> -       context->hi |= value & 7;
> +       context->aw  = value;
>   }
>
>   static inline void context_set_domain_id(struct context_entry *context,
>                                           unsigned long value)
>   {
> -       context->hi |= (value & ((1 << 16) - 1)) << 8;
> +       context->did = value;
>   }
>
>   static inline void context_clear_entry(struct context_entry *context)
> --
> 1.8.4.3
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
