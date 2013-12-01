From: Kim Phillips <kim.phillips@linaro.org>
Subject: Re: [RFC PATCH v2 0/7] VFIO for device tree based platform devices
 (work in progress)
Date: Sun, 1 Dec 2013 12:09:54 +0000
Message-ID: <20131201120954.1d6cec431a99a7ad5f34da18@linaro.org>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: a.motakis@virtualopensystems.com
Cc: kvmarm@lists.cs.columbia.edu, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, agraf@suse.de, B08248@freescale.com, tech@virtualopensystems.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 30 Sep 2013 17:28:36 +0200
Antonios Motakis <a.motakis@virtualopensystems.com> wrote:

> This is a preview of the base work, towards VFIO support on ARM platforms
> with an IOMMU. It forms a base on to which to implement the functionality
> necessary to enable using device tree devices on ARM (and other platforms
> based on device trees) with VFIO.
> 
> This patch series has been subjected to limited testing on the Arndale board
> (with the Exynos 5250 System MMU). More extensive testing will follow as more
> features are implemented.

Hi, I'm trying to attach the vfio-platform driver to an(y) iommu-backed
device on the arndale.  I chose the relatively simple 'tv' device,
isolated it in the arndale device tree (to get rid of any dependency
conflicts), and, when I run Alex' vfio-correctness-tests [1], I get
this:

# echo 14650000.sysmmu > /sys/bus/platform/devices/14650000.sysmmu/driver/unbind
# echo 14650000.sysmmu > /sys/bus/platform/drivers/vfio-platform/bind
# ls -l /sys/bus/platform/devices/14650000.sysmmu/iommu_group
lrwxrwxrwx 1 root root 0 Oct  1 23:14 /sys/bus/platform/devices/14650000.sysmmu/iommu_group -> ../../kernel/iommu_groups/43
# vfio-tests/vfio-correctness-tests 43
[   84.567643] ------------[ cut here ]------------
[   84.572258] WARNING: CPU: 0 PID: 1606 at drivers/iommu/exynos-iommu.c:472 __exynos_sysmmu_enable+0x170/0x184()
[   84.582225] Modules linked in:
[   84.585268] CPU: 0 PID: 1606 Comm: vfio-correctnes Not tainted 3.13.0-rc1-00296-gb703d74-dirty #46
[   84.594219] [<c0014d20>] (unwind_backtrace+0x0/0xf4) from [<c0011648>] (show_stack+0x10/0x14)
[   84.602719] [<c0011648>] (show_stack+0x10/0x14) from [<c0377948>] (dump_stack+0x7c/0xb0)
[   84.610791] [<c0377948>] (dump_stack+0x7c/0xb0) from [<c001dc50>] (warn_slowpath_common+0x6c/0x88)
[   84.619730] [<c001dc50>] (warn_slowpath_common+0x6c/0x88) from [<c001dd08>] (warn_slowpath_null+0x1c/0x24)
[   84.629365] [<c001dd08>] (warn_slowpath_null+0x1c/0x24) from [<c02dace8>] (__exynos_sysmmu_enable+0x170/0x184)
[   84.639348] [<c02dace8>] (__exynos_sysmmu_enable+0x170/0x184) from [<c02dad4c>] (exynos_iommu_attach_device+0x50/0x108)
[   84.650111] [<c02dad4c>] (exynos_iommu_attach_device+0x50/0x108) from [<c02d939c>] (iommu_attach_device+0x64/0xb8)
[   84.660440] [<c02d939c>] (iommu_attach_device+0x64/0xb8) from [<c02d92ec>] (iommu_group_for_each_dev+0x78/0x94)
[   84.670509] [<c02d92ec>] (iommu_group_for_each_dev+0x78/0x94) from [<c0263678>] (vfio_iommu_type1_attach_group+0xd0/0x144)
[   84.681530] [<c0263678>] (vfio_iommu_type1_attach_group+0xd0/0x144) from [<c02629e0>] (vfio_fops_unl_ioctl+0x3ac/0x460)
[   84.692295] [<c02629e0>] (vfio_fops_unl_ioctl+0x3ac/0x460) from [<c00c1f14>] (do_vfs_ioctl+0x3f0/0x5b8)
[   84.701668] [<c00c1f14>] (do_vfs_ioctl+0x3f0/0x5b8) from [<c00c2114>] (SyS_ioctl+0x38/0x60)
[   84.710002] [<c00c2114>] (SyS_ioctl+0x38/0x60) from [<c000e1a0>] (ret_fast_syscall+0x0/0x30)
[   84.718417] ---[ end trace a1400d7981f699ce ]---
[   84.723071] vfio-platform 14650000.sysmmu: exynos_iommu_attach_device: Failed to attach IOMMU with pgtable 0x6eae8000

It's failing this test:

        if (WARN_ON(!client))
                return -ENODEV;

but I haven't been able to figure out why...I have the exynos
iommu v10 patchseries applied, and even though there's not much
documentation available for this device, I figure this simple test is
supposed to 'just work.'  Any ideas?

Thanks,

Kim

[1] git://github.com/awilliam/tests.git
