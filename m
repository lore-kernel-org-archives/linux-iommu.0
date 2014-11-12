From: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] x86/iommu: fix incorrect bit operations in setting
 values
Date: Wed, 12 Nov 2014 19:28:32 +0800
Message-ID: <20141112112832.GA3334@dhcp-17-108.nay.redhat.com>
References: <1415172619-4801-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415172619-4801-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The kdump starts 2nd kernel without any error message when I use
3.18.0-rc4 merged last 6 patchs. The following is the message which 2nd
kernel prints during booting.

Patchset:
	0001-iommu-vt-d-Update-iommu_attach_domain-and-its-caller.patch
	0002-iommu-vt-d-Items-required-for-kdump.patch
	0003-iommu-vt-d-data-types-and-functions-used-for-kdump.patch
	0004-iommu-vt-d-Add-domain-id-functions.patch
	0005-iommu-vt-d-enable-kdump-support-in-iommu-module.patch
	0006-x86-iommu-fix-incorrect-bit-operations-in-setting-va.patch

log:
[    1.689604] IOMMU intel_iommu_in_crashdump = true
[    1.694310] IOMMU Skip disabling iommu hardware translations
[    1.699987] DMAR: No ATSR found
[    1.703151] IOMMU Copying translate tables from panicked kernel
[    1.710786] IOMMU: root_new_virt:0xffff8800296ec000 phys:0x0000296ec000
[    1.717401] IOMMU:0 Domain ids from panicked kernel:
[    1.722364] DID did:13(0x000d)
[    1.725424] DID did:12(0x000c)
[    1.728482] DID did:11(0x000b)
[    1.731542] DID did:10(0x000a)
[    1.734603] DID did:6(0x0006)
[    1.737574] DID did:7(0x0007)
[    1.740549] DID did:5(0x0005)
[    1.743522] DID did:9(0x0009)
[    1.746495] DID did:8(0x0008)
[    1.749467] DID did:4(0x0004)
[    1.752439] DID did:3(0x0003)
[    1.755413] DID did:2(0x0002)
[    1.758385] DID did:0(0x0000)
[    1.761357] DID did:1(0x0001)
[    1.764331] ----------------------------------------
[    1.769302] IOMMU 0 0xfed50000: using Queued invalidation

On 11/05/14 at 03:30pm, Li, Zhen-Hua wrote:
> The function context_set_address_root() and set_root_value are setting new
> address in a wrong way, and this patch is trying to fix this problem.
> 
> According to Intel Vt-d specs(Feb 2011, Revision 1.3), Chapter 9.1 and 9.2,
> field ctp in root entry is using bits 12:63, field asr in context entry is
> using bits 12:63.
> 
> To set these fields, the following functions are used:
> static inline void context_set_address_root(struct context_entry *context,
>         unsigned long value);
> and
> static inline void set_root_value(struct root_entry *root, unsigned long value)
> 
> But they are using an invalid method to set these fields, in current code, only
> a '|' operator is used to set it. This will not set the asr to the expected
> value if it has an old value.
> 
> For example:
> Before calling this function,
> 	context->lo = 0x3456789012111;
> 	value = 0x123456789abcef12;
> 
> After we call context_set_address_root(context, value), expected result is
> 	context->lo == 0x123456789abce111;
> 
> But the actual result is:
> 	context->lo == 0x1237577f9bbde111;
> 
> So we need to clear bits 12:63 before setting the new value, this will fix
> this problem.
> 
> Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a27d6cb..11ac47b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -195,6 +195,7 @@ static inline void set_root_present(struct root_entry *root)
>  }
>  static inline void set_root_value(struct root_entry *root, unsigned long value)
>  {
> +	root->val &= ~VTD_PAGE_MASK;
>  	root->val |= value & VTD_PAGE_MASK;
>  }
>  
> @@ -247,6 +248,7 @@ static inline void context_set_translation_type(struct context_entry *context,
>  static inline void context_set_address_root(struct context_entry *context,
>  					    unsigned long value)
>  {
> +	context->lo &= ~VTD_PAGE_MASK;
>  	context->lo |= value & VTD_PAGE_MASK;
>  }
>  
> -- 
> 2.0.0-rc0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
