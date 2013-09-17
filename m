From: ZhenHua <zhen-hual@hp.com>
Subject: Re: [PATCH 1/1] x86/iommu: correct ICS register offset
Date: Tue, 17 Sep 2013 16:38:29 +0800
Message-ID: <52381505.4010701@hp.com>
References: <1379053652-29206-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379053652-29206-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Zhen-Hua" <zhen-hual@hp.com>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Donald Dutile <ddutile@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Hi Guys,
     Though  DMAR_ICS_REG is not used yet, I think this patch is 
necessary. So please take a look at it.

Thanks
ZhenHua

On 09/13/2013 02:27 PM, Li, Zhen-Hua wrote:
> According to Intel Vt-D specs, the offset of Invalidation complete
> status register should be 0x9C, not 0x98.
>
> See Intel's VT-d spec, Revision 1.3, Chapter 10.4, Page 98;
>
> Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
> ---
>   include/linux/intel-iommu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 78e2ada..d380c5e 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -55,7 +55,7 @@
>   #define DMAR_IQT_REG	0x88	/* Invalidation queue tail register */
>   #define DMAR_IQ_SHIFT	4	/* Invalidation queue head/tail shift */
>   #define DMAR_IQA_REG	0x90	/* Invalidation queue addr register */
> -#define DMAR_ICS_REG	0x98	/* Invalidation complete status register */
> +#define DMAR_ICS_REG	0x9c	/* Invalidation complete status register */
>   #define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
>
>   #define OFFSET_STRIDE		(9)
>
