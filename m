From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4 V3] Allocate pages for kdump without encryption when
	SME is enabled
Date: Thu, 21 Jun 2018 09:53:06 +0800
Message-ID: <20180621015306.GG29979@MiWiFi-R3L-srv>
References: <20180616082714.32035-1-lijiang@redhat.com>
	<20180616082714.32035-3-lijiang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180616082714.32035-3-lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
> When SME is enabled in the first kernel, we will allocate pages
> for kdump without encryption in order to be able to boot the
> second kernel in the same manner as kexec, which helps to keep
> the same code style.
> 
> Signed-off-by: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  kernel/kexec_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 20fef1a..3c22a9b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  		}
>  	}
>  
> +	if (pages) {
> +		unsigned int count, i;
> +
> +		pages->mapping = NULL;
> +		set_page_private(pages, order);
> +		count = 1 << order;
> +		for (i = 0; i < count; i++)
> +			SetPageReserved(pages + i);

I guess you might imitate the kexec case, however kexec get pages from
buddy. Crash pages are reserved in memblock, these codes might make no sense.

> +		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
> +	}
>  	return pages;
>  }
>  
> @@ -865,6 +875,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result  = -ENOMEM;
>  			goto out;
>  		}
> +		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>  		ptr = kmap(page);
>  		ptr += maddr & ~PAGE_MASK;
>  		mchunk = min_t(size_t, mbytes,
> @@ -882,6 +893,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result = copy_from_user(ptr, buf, uchunk);
>  		kexec_flush_icache_page(page);
>  		kunmap(page);
> +		arch_kexec_pre_free_pages(page_address(page), 1);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/kexec
