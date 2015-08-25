From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Fix bug in iommu_context_addr: Always get pointer to
	lower extended-context-table
Date: Tue, 25 Aug 2015 10:42:08 +0200
Message-ID: <20150825084208.GB32055@8bytes.org>
References: <F9D82F0D71C0024FA18FE771EDDAF149081FAC8F@G4W3303.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F9D82F0D71C0024FA18FE771EDDAF149081FAC8F-qhK1pdpzgV8SZAcGdq5asR6epYMZPwEe5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Xiao, Nan (Nan@HPS Performance, Beijing)" <nan.xiao-VXdhtT5mjnY@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Nan,

On Mon, Aug 24, 2015 at 06:26:33AM +0000, Xiao, Nan (Nan@HPS Performance, Beijing) wrote:
>  drivers/iommu/intel-iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0649b94..4213598 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -759,10 +759,11 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
>  		if (devfn >= 0x80) {
>  			devfn -= 0x80;
>  			entry = &root->hi;
> -		}
> +		} else
> +			entry = &root->lo;
>  		devfn *= 2;
> -	}
> -	entry = &root->lo;
> +	} else
> +		entry = &root->lo;
>  	if (*entry & 1)
>  		context = phys_to_virt(*entry & VTD_PAGE_MASK);
>  	else {

Shouldn't this diff have the same effect?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0649b94..7553cb9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -755,6 +755,7 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 	struct context_entry *context;
 	u64 *entry;
 
+	entry = &root->lo;
 	if (ecs_enabled(iommu)) {
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
@@ -762,7 +763,6 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 		}
 		devfn *= 2;
 	}
-	entry = &root->lo;
 	if (*entry & 1)
 		context = phys_to_virt(*entry & VTD_PAGE_MASK);
 	else {
