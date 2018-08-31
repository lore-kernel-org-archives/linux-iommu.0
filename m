From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
Date: Fri, 31 Aug 2018 14:34:52 +0100
Message-ID: <1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-14-jean-philippe.brucker@arm.com>
	<5B83B11E.7010807@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5B83B11E.7010807-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Xu Zaibo <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, liguozhu <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, fanghao11 <fanghao11-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, =?UTF-8?B?57Gz57Gz?= <kenneth-lee-2012-H32Fclmsjq1BDgjK7y7TUQ@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Zaibo,

On 27/08/18 09:06, Xu Zaibo wrote:
>> +struct vfio_iommu_type1_bind_process {
>> +=A0=A0=A0 __u32=A0=A0=A0 flags;
>> +#define VFIO_IOMMU_BIND_PID=A0=A0=A0=A0=A0=A0=A0 (1 << 0)
>> +=A0=A0=A0 __u32=A0=A0=A0 pasid;
> As I am doing some works on the SVA patch set. I just consider why the
> user space need this pasid.
> Maybe, is it much more reasonable to set the pasid into all devices
> under the vfio container by
> a call back function from 'vfio_devices'=A0 while
> 'VFIO_IOMMU_BIND_PROCESS' CMD is executed
> in kernel land? I am not sure because there exists no suitable call back
> in 'vfio_device' at present.

When using vfio-pci, the kernel doesn't know how to program the PASID
into the device because the only kernel driver for the device is the
generic vfio-pci module. The PCI specification doesn't describe a way of
setting up the PASID, it's vendor-specific. Only the userspace
application owning the device (and calling VFIO_IOMMU_BIND) knows how to
do it, so we return the allocated PASID.

Note that unlike vfio-mdev where applications share slices of a
function, with vfio-pci one application owns the whole function so it's
safe to let userspace set the PASID in hardware. With vfio-mdev it's the
kernel driver that should be in charge of setting the PASID as you
described, and we wouldn't have a reason to return the PASID in the
vfio_iommu_type1_bind_process structure.

Thanks,
Jean
