From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 1/9] iommu: add IOMMU_PRIV attribute
Date: Fri, 6 Jan 2017 12:06:27 +0100
Message-ID: <20170106110627.GO17255@8bytes.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
	<1483362764-11990-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483362764-11990-2-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 02, 2017 at 06:42:36PM +0530, Sricharan R wrote:
> From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> Add the IOMMU_PRIV attribute, which is used to indicate privileged
> mappings.
> 
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0ff5111..8c15ada 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -31,6 +31,7 @@
>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>  #define IOMMU_NOEXEC	(1 << 3)
>  #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
> +#define IOMMU_PRIV	(1 << 5) /* privileged */

Since this is a new generic global flag, can you please add a more
verbose comment telling what a 'privileged' mapping is about in the
iommu-case? We should have a clear defined semantic for this flag or we
might end up with different meanings for it with different
iommu-hardware.


	Joerg
