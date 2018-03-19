From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/14] set_memory.h: provide set_memory_{en,de}crypted
	stubs
Date: Mon, 19 Mar 2018 09:21:20 -0500
Message-ID: <cedbd051-cc59-1f80-4143-975342fc5e0c@amd.com>
References: <20180319103826.12853-1-hch@lst.de>
	<20180319103826.12853-11-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180319103826.12853-11-hch-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 3/19/2018 5:38 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Reviewed-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>

> ---
>  include/linux/set_memory.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index e5140648f638..da5178216da5 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>  
> +#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
> +static inline int set_memory_encrypted(unsigned long addr, int numpages)
> +{
> +	return 0;
> +}
> +
> +static inline int set_memory_decrypted(unsigned long addr, int numpages)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
> +
>  #endif /* _LINUX_SET_MEMORY_H_ */
> 
