From: Xu Zaibo <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
Date: Mon, 27 Aug 2018 16:06:54 +0800
Message-ID: <5B83B11E.7010807@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-14-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511190641.23008-14-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, liguozhu <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, fanghao11 <fanghao11-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, =?UTF-8?B?57Gz57Gz?= <kenneth-lee-2012-H32Fclmsjq1BDgjK7y7TUQ@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 2018/5/12 3:06, Jean-Philippe Brucker wrote:
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82e8169..dc07752c8fe8 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -665,6 +665,82 @@ struct vfio_iommu_type1_dma_unmap {
>   #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>   #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>   
> +/*
> + * VFIO_IOMMU_BIND_PROCESS
> + *
> + * Allocate a PASID for a process address space, and use it to attach this
> + * process to all devices in the container. Devices can then tag their DMA
> + * traffic with the returned @pasid to perform transactions on the associated
> + * virtual address space. Mapping and unmapping buffers is performed by standard
> + * functions such as mmap and malloc.
> + *
> + * If flag is VFIO_IOMMU_BIND_PID, @pid contains the pid of a foreign process to
> + * bind. Otherwise the current task is bound. Given that the caller owns the
> + * device, setting this flag grants the caller read and write permissions on the
> + * entire address space of foreign process described by @pid. Therefore,
> + * permission to perform the bind operation on a foreign process is governed by
> + * the ptrace access mode PTRACE_MODE_ATTACH_REALCREDS check. See man ptrace(2)
> + * for more information.
> + *
> + * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
> + * ID is unique to a process and can be used on all devices in the container.
> + *
> + * On fork, the child inherits the device fd and can use the bonds setup by its
> + * parent. Consequently, the child has R/W access on the address spaces bound by
> + * its parent. After an execv, the device fd is closed and the child doesn't
> + * have access to the address space anymore.
> + *
> + * To remove a bond between process and container, VFIO_IOMMU_UNBIND ioctl is
> + * issued with the same parameters. If a pid was specified in VFIO_IOMMU_BIND,
> + * it should also be present for VFIO_IOMMU_UNBIND. Otherwise unbind the current
> + * task from the container.
> + */
> +struct vfio_iommu_type1_bind_process {
> +	__u32	flags;
> +#define VFIO_IOMMU_BIND_PID		(1 << 0)
> +	__u32	pasid;
As I am doing some works on the SVA patch set. I just consider why the 
user space need this pasid.
Maybe, is it much more reasonable to set the pasid into all devices 
under the vfio container by
a call back function from 'vfio_devices'  while 
'VFIO_IOMMU_BIND_PROCESS' CMD is executed
in kernel land? I am not sure because there exists no suitable call back 
in 'vfio_device' at present.

Thanks,
Zaibo
> +	__s32	pid;
> +};
> +
> +/*
> + * Only mode supported at the moment is VFIO_IOMMU_BIND_PROCESS, which takes
> + * vfio_iommu_type1_bind_process in data.
> + */
> +struct vfio_iommu_type1_bind {
> +	__u32	argsz;
> +	__u32	flags;
> +#define VFIO_IOMMU_BIND_PROCESS		(1 << 0)
> +	__u8	data[];
> +};
> +
> +/*
> + * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 22, struct vfio_iommu_bind)
> + *
> + * Manage address spaces of devices in this container. Initially a TYPE1
> + * container can only have one address space, managed with
> + * VFIO_IOMMU_MAP/UNMAP_DMA.
> + *
> + * An IOMMU of type VFIO_TYPE1_NESTING_IOMMU can be managed by both MAP/UNMAP
> + * and BIND ioctls at the same time. MAP/UNMAP acts on the stage-2 (host) page
> + * tables, and BIND manages the stage-1 (guest) page tables. Other types of
> + * IOMMU may allow MAP/UNMAP and BIND to coexist, where MAP/UNMAP controls
> + * non-PASID traffic and BIND controls PASID traffic. But this depends on the
> + * underlying IOMMU architecture and isn't guaranteed.
> + *
> + * Availability of this feature depends on the device, its bus, the underlying
> + * IOMMU and the CPU architecture.
> + *
> + * returns: 0 on success, -errno on failure.
> + */
> +#define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
> +/*
> + * VFIO_IOMMU_UNBIND - _IOWR(VFIO_TYPE, VFIO_BASE + 23, struct vfio_iommu_bind)
> + *
> + * Undo what was done by the corresponding VFIO_IOMMU_BIND ioctl.
> + */
> +#define VFIO_IOMMU_UNBIND	_IO(VFIO_TYPE, VFIO_BASE + 23)
> +
>   /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>   
>   /*
