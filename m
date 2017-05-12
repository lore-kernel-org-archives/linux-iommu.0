From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 5/8] VFIO: Add new IOTCL for PASID Table bind
	propagation
Date: Fri, 12 May 2017 15:58:51 -0600
Message-ID: <20170512155851.627409ed@t450s.home>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-6-git-send-email-yi.l.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493201525-14418-6-git-send-email-yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 26 Apr 2017 18:12:02 +0800
"Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> This patch adds VFIO_IOMMU_SVM_BIND_TASK for potential PASID table
> binding requests.
> 
> On VT-d, this IOCTL cmd would be used to link the guest PASID page table
> to host. While for other vendors, it may also be used to support other
> kind of SVM bind request. Previously, there is a discussion on it with
> ARM engineer. It can be found by the link below. This IOCTL cmd may
> support SVM PASID bind request from userspace driver, or page table(cr3)
> bind request from guest. These SVM bind requests would be supported by
> adding different flags. e.g. VFIO_SVM_BIND_PASID is added to support
> PASID bind from userspace driver, VFIO_SVM_BIND_PGTABLE is added to
> support page table bind from guest.
> 
> https://patchwork.kernel.org/patch/9594231/
> 
> Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  include/uapi/linux/vfio.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff3..6b97987 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -547,6 +547,23 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/* IOCTL for Shared Virtual Memory Bind */
> +struct vfio_device_svm {
> +	__u32	argsz;
> +#define VFIO_SVM_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
> +#define VFIO_SVM_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver */
> +#define VFIO_SVM_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
> +	__u32	flags;
> +	__u32	length;
> +	__u8	data[];

In the case of VFIO_SVM_BIND_PASIDTBL this is clearly struct
pasid_table_info?  So at a minimum this is a union including struct
pasid_table_info.  Furthermore how does a user learn what the opaque
data in struct pasid_table_info is without looking at the code?  A user
API needs to be clear and documented, not opaque and variable.  We
should also have references to the hardware spec for an Intel or ARM
PASID table in uapi.  flags should be defined as they're used, let's
not reserve them with the expectation of future use.

> +};
> +
> +#define VFIO_SVM_TYPE_MASK	(VFIO_SVM_BIND_PASIDTBL | \
> +				VFIO_SVM_BIND_PASID | \
> +				VFIO_SVM_BIND_PGTABLE)
> +
> +#define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
