From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB invalidate
 propagation
Date: Fri, 12 May 2017 15:58:43 -0600
Message-ID: <20170512155843.5abeb4bd@t450s.home>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
        <1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, 26 Apr 2017 18:12:04 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> This patch adds VFIO_IOMMU_TLB_INVALIDATE to propagate IOMMU TLB
> invalidate request from guest to host.
> 
> In the case of SVM virtualization on VT-d, host IOMMU driver has
> no knowledge of caching structure updates unless the guest
> invalidation activities are passed down to the host. So a new
> IOCTL is needed to propagate the guest cache invalidation through
> VFIO.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  include/uapi/linux/vfio.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 6b97987..50c51f8 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -564,6 +564,15 @@ struct vfio_device_svm {
>  
>  #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
>  
> +/* For IOMMU TLB Invalidation Propagation */
> +struct vfio_iommu_tlb_invalidate {
> +	__u32	argsz;
> +	__u32	length;
> +	__u8	data[];
> +};
> +
> +#define VFIO_IOMMU_TLB_INVALIDATE	_IO(VFIO_TYPE, VFIO_BASE + 23)

I'm kind of wondering why this isn't just a new flag bit on
vfio_device_svm, the data structure is so similar.  Of course data
needs to be fully specified in uapi.

> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
