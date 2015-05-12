From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Tue, 12 May 2015 17:35:53 +0200
Message-ID: <CABxcv==0gbM_veanjHjtUgwo9hVuhLji5REi7nQfVTP8p-xAWg@mail.gmail.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
	<CABxcv=mpCQKyuJOFsUgMdhD50yYdH+WwnEbYUNXByErMHpUuYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CABxcv=mpCQKyuJOFsUgMdhD50yYdH+WwnEbYUNXByErMHpUuYA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 11, 2015 at 6:00 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Marek,
>
> On Mon, May 4, 2015 at 10:15 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hello Everyone,
>>
>> This is yet another attempt to get Exynos SYSMMU driver with integrated
>> with IOMMU & DMA-mapping subsystems. The main change from previous
>> version is addition of the patches to define iommu-mapping, which need
>> to be created during system boot to avoid IOMMU fault by devices, which
>> has been left enabled by bootloader (i.e. framebuffer displaying slash
>> screen).
>>
>> Patches has been also rebased onto v4.1-rc2 with 'arm: dma-mapping: fix
>> off-by-one check in arm_setup_iommu_dma_ops' patch applied (see commit
>> 1424532b2163bf1580f4b1091a5801e12310fac5 on fixes branch in
>> git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git,
>> more information:
>> http://www.spinics.net/lists/arm-kernel/msg414722.html).
>>
>> All patches are also available in the following git repository:
>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
>> branch v4.1-exynos-iommu.
>>
>
> Thanks for the new series, this time I didn't get a system hang when I
> enabled both CONFIG_DRM_EXYNOS_FIMD and CONFIG_DRM_EXYNOS_DP on my
> Exynos5420 Peach Pit Chromebook.
>
> The system finished booting and I have both a console on the HDMI and
> eDP/LVDS displays. But if I try to start X or weston, I again have a
> completele system hang with no output on the serial console. This
> works correctly without your IOMMU series.
>
> And again disabling CONFIG_DRM_EXYNOS_DP or CONFIG_DRM_EXYNOS_FIMD
> avoids the system to hang. If I only have CONFIG_DRM_EXYNOS_HDMI
> enabled, then I can start X with out issues and is displayed correctly
> in the HDMI output.
>
> So it seems your workaround for the boot-loader leaving the FIMD dma
> engine enabled is not enough? I'm not a graphics person so I can think
> of the top of my head what could trigger the system hang when X or
> weston are executed so I wondered if you have any ideas.
>

I looked a a bit more on this issue today and found that the system
hang when dma_alloc_attrs() is called from lowlevel_buffer_allocate()
in drivers/gpu/drm/exynos/exynos_drm_buf.c [0].

The call chain is:

exynos_drm_gem_create_ioctl() -> exynos_drm_gem_create() ->
exynos_drm_alloc_buf() -> lowlevel_buffer_allocate() ->
dma_alloc_attrs().

An interesting data point is that the allocation succeeds when a GEM
buffer is created for fbdev but it causes a system hang when is
created from the DRM ioctl API. For fbdev the call chain is:

exynos_drm_fbdev_init() -> exynos_drm_fbdev_init() ->
exynos_drm_fbdev_create() -> exynos_drm_gem_create() ->
exynos_drm_alloc_buf() -> lowlevel_buffer_allocated() ->
dma_alloc_attrs().

Although for fbdev, the EXYNOS_BO_CONTIG flag is passed to
exynos_drm_gem_create() so the DMA_ATTR_FORCE_CONTIGUOUS attribute is
set before calling  dma_alloc_attrs(). So I don't know if is only
working because the allocated memory is physically contiguous so the
IOMMU mapping is less of an issue here?

I also don't know if is relevant but I noticed that both for HDMI and
DP, the address of the allocated a DMA buffer is always 0x20000000.
Which is the start of the iommu-reserved-mapping region for the
exynos5420 peach pit.

While the address of the allocated DMA buffer for the GEM buffer
allocated with EXYNOS_GEM_CREATE is always != 0x20000000 (i.e
0x2184c000).

So in summary, Exynos HDMI DRM can allocate GEM buffers correctly
fbdev and DRM while EXYNOS DRM DP/FIMD can only allocate a GEM buffer
for fbdev, trying to allocate with the EXYNOS_GEM_CREATE ioctl hangs
the system. Both fbdev and DRM works correctly with Exynos IOMMU
disabled.

I included some DRM debug log [2] (drm.debug=0xff) for DP/FIMD fbdev
and DRM GEM buffer creation.

Thanks a lot and best regards,
Javier

[0]: http://lxr.free-electrons.com/source/drivers/gpu/drm/exynos/exynos_drm_buf.c#L84
[1]: http://lxr.free-electrons.com/source/drivers/gpu/drm/exynos/exynos_drm_fbdev.c#L153
[2]:

DP fbdev:

[    4.181241] [drm:drm_enable_connectors] connector 31 enabled? yes
[    4.181248] [drm:drm_target_preferred] looking for cmdline mode on
connector 25
[    4.181254] [drm:drm_target_preferred] looking for preferred mode
on connector 25 0
[    4.181259] [drm:drm_target_preferred] found mode 1366x768
[    4.181265] [drm:drm_target_preferred] looking for cmdline mode on
connector 31
[    4.181270] [drm:drm_target_preferred] looking for preferred mode
on connector 31 0
[    4.181276] [drm:drm_target_preferred] found mode 1920x1080
[    4.181281] [drm:drm_setup_crtcs] picking CRTCs for 4096x4096 config
[    4.181290] [drm:drm_setup_crtcs] desired mode 1366x768 set on crtc 23 (0,0)
[    4.181298] [drm:drm_setup_crtcs] desired mode 1920x1080 set on crtc 29 (0,0)
[    4.181307] [drm:exynos_drm_fbdev_create] surface width(1920),
height(1080) and bpp(32
[    4.181314] [drm:exynos_drm_init_buf] desired size = 0x7e9000
[    4.181327] [drm:exynos_drm_gem_init] created file object = 0xedc68300
[    4.187406] [drm:lowlevel_buffer_allocate] ccu
dma_addr(0x20000000), size(0x7e9000)
[    4.187418] [drm:exynos_drm_fb_buffer] dma_addr = 0x20000000

DP DRM:

[  206.210769] [drm:drm_mode_getconnector] [CONNECTOR:31:?]
[  206.216074] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1,
DRM_IOCTL_MODE_GETPROPERTY
[  206.223798] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1,
DRM_IOCTL_MODE_GETPROPERTY
[  206.231538] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1,
DRM_IOCTL_MODE_GETPROPBLOB
[  206.239240] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1,
DRM_IOCTL_MODE_GETPROPBLOB
[  206.246965] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1,
DRM_IOCTL_MODE_GETPROPERTY
[  206.254680] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1,
DRM_IOCTL_MODE_GETPROPERTY
[  206.275736] [drm:drm_ioctl] pid=3458, dev=0xe200, auth=1, EXYNOS_GEM_CREATE
[  206.281287] [drm:exynos_drm_init_buf] desired size = 0x408000
[  206.286989] [drm:exynos_drm_gem_init] created file object = 0xed0d6400
