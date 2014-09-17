From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 09/12] kvm: iommu: Convert to use new iommu_capable() API
	function
Date: Wed, 17 Sep 2014 10:29:38 +0200
Message-ID: <20140917082938.GC2533@suse.de>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
	<1409914384-21191-10-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409914384-21191-10-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Gleb Natapov <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Paolo, Gleb,

On Fri, Sep 05, 2014 at 12:53:01PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Cc: Gleb Natapov <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  virt/kvm/iommu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Do you have any objections against this patch? I would like to put this
series into the iommu tree.


Thanks,

	Joerg

> 
> diff --git a/virt/kvm/iommu.c b/virt/kvm/iommu.c
> index 714b949..45ee080 100644
> --- a/virt/kvm/iommu.c
> +++ b/virt/kvm/iommu.c
> @@ -191,8 +191,7 @@ int kvm_assign_device(struct kvm *kvm,
>  		return r;
>  	}
>  
> -	noncoherent = !iommu_domain_has_cap(kvm->arch.iommu_domain,
> -					    IOMMU_CAP_CACHE_COHERENCY);
> +	noncoherent = !iommu_capable(&pci_bus_type, IOMMU_CAP_CACHE_COHERENCY);
>  
>  	/* Check if need to update IOMMU page table for guest memory */
>  	if (noncoherent != kvm->arch.iommu_noncoherent) {
> @@ -254,8 +253,7 @@ int kvm_iommu_map_guest(struct kvm *kvm)
>  	}
>  
>  	if (!allow_unsafe_assigned_interrupts &&
> -	    !iommu_domain_has_cap(kvm->arch.iommu_domain,
> -				  IOMMU_CAP_INTR_REMAP)) {
> +	    !iommu_capable(&pci_bus_type, IOMMU_CAP_INTR_REMAP)) {
>  		printk(KERN_WARNING "%s: No interrupt remapping support,"
>  		       " disallowing device assignment."
>  		       " Re-enble with \"allow_unsafe_assigned_interrupts=1\""
> -- 
> 1.9.1
