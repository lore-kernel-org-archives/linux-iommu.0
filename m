From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Fri, 27 May 2016 02:46:42 +0200
Message-ID: <20160527004642.GQ11948@wotan.suse.de>
References: <CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
 <570BA694.8040900@amd.com>
 <CAFCwf10oD9c3MOW3+J8A5MVjVkX0nNRGCEE2pWcQxOy7mjUsBw@mail.gmail.com>
 <570BAC2B.4090508@amd.com>
 <20160412220715.GL1990@wotan.suse.de>
 <CAFCwf12SJ-dTv6PC0_KfHbtC9951xb_4v8wu5uSjXO-V3TgdkA@mail.gmail.com>
 <CAB=NE6WL7j_azrFxQUG3bybXtu67ew51CyzYvkBct6tCdARKDg@mail.gmail.com>
 <CAFCwf12B6TQ5kYEG4+hYoWriv2rnTcngQLX_Cvtbz=64fo35Qg@mail.gmail.com>
 <20160418120350.GE1990@wotan.suse.de>
 <20160425102351.GC17926@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160425102351.GC17926@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Oded Gabbay <oded.gabbay@gmail.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, hpa@zytor.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 25, 2016 at 12:23:51PM +0200, Joerg Roedel wrote:
> On Mon, Apr 18, 2016 at 02:03:50PM +0200, Luis R. Rodriguez wrote:
> > You said that with my patch you saw AMD IOMMUv2 kick off first,
> > that was intentional as I thought that's what you needed. Can
> > someone please describe the requirements?
> > 
> > Also what does drm use that you say has a conflict already? What
> > drm code are we talking about exactly ?
> 
> The required order is:
> 
> 	1. AMD IOMMUv1 (in-kernel only, initialized at boot time after PCI)
> 	2. AMD IOMMUv2 (in-kernel or as module, provides demand paging
> 			and uses v1 interfaces to talk to the IOMMU)
> 	3. AMD-KFD     (Implements compute offloading to the GPU and
> 			uses AMD IOMMUv2 functionality, also provides a
> 			symbol for the radeon driver)
> 	4. DRM with    (Checks if the symbol provided by AMD-KFD is
> 	   Radeon	available at init time and does the KFD
> 			initialization from there, because the GPU needs
> 			to be up first)
> 
> So AMD IOMMUv2 does not initialize (but it does load to have the symbols
> available for drivers that optionally use its functionality) without the
> AMD IOMMUv1 driver, as it can't access the IOMMU hardware then.
> 
> AMD-KFD does not load without AMD IOMMUv2 being loaded, as it depends on
> its symbols. AMD-KFD on the other hand needs to be loaded before the
> radeon driver (but this it not enforced by symbols), because otherwise
> the radeon driver will not initialize the AMD-KFD driver.
> 
> When AMD-KFD is loaded and you load radeon then, you get the KFD
> functionality in the kernel. Then you can move on to the fun getting the
> userspace running and actually execute anything on the GPU. But thats
> another story.
> 
> I know what you think, and I agree: It's a big mess :)

Its no concern for me that its a mess, frankly most drivers are. This however
illustrates a semantic gap in the driver core when you have more than 3
dependencies after a rootfs_initcall(), given that the buck stops at
late_initcall(), only 3 levels above. With 4 dependencies you run out
of semantics to specify explicit requirements.

Ties can be disputed through link order though, but this is obviously fragile,
and the dependencies are then left implicit. Nothing vets for correctness,
either in software or through static analysers.

To summarize the specific code in question is (and order required):

AMD IOMMUv1:    arch/x86/kernel/pci-dma.c               rootfs_initcall(pci_iommu_init);
AMD IOMMUv2:    drivers/iommu/amd_iommu_v2.c            module_init(amd_iommu_v2_init); (device_initcall())
AMD KFD:        drivers/gpu/drm/amd/amdkfd/kfd_module.c module_init(kfd_module_init); (device_initcall())
AMD Radeon:     drivers/gpu/drm/radeon/radeon_drv.c     module_init(radeon_init); (device_initcall())

Commit 1bacc894c227fad8a7 ("drivers: Move iommu/ before gpu/ in Makefile") resolved
the race between IOMMU and GPU drivers this way, however an alternative is to make
the dependencies in levels explicit by making the amdkfd and radeon drivers both
use late_initcall(), this however is technically still racy specially since you
note that the amdkfd driver is not loaded prior to radeon through symbol
dependencies, if happens to be loaded it then you get KFD functionality,
otherwise you don't.

Making both amdkfd and radeon use late_initcall() would actually work now though
but that's only because the link order also happens to match the dependency
requirements:

drivers/gpu/drm/Makefile
...
obj-$(CONFIG_HSA_AMD) += amd/amdkfd/                                            
obj-$(CONFIG_DRM_RADEON)+= radeon/  
...

Since we currently lack proper semantics to define clear dependencies for all
this reverting 1bacc894c227fad8a7 after using late_initcall() on both amdkfd
and radeon would not be useful other than to just test the race fix, given that
such work around would still be present also on drivers/gpu/drm/Makefile to
account for the race between amdkfd and radeon. Reverting 1bacc894c227fad8a7
after using late_initcall() on both amdkfd and radeon would just bump the
race work around another level.

Modifying both amdkfd and radeon to use late_initcall() however seems well
justified for now, and given the current state of affairs with link order
one should be able to then correctly build all these things as built-in
and it should work correctly.

I'm still not satisfied with the issues on semantics here though. A fix
for that, if desired, should be possible using linker-tables, currently
in RFCv2 [0] stage. Linker tables offer practically infinite number (as
long as a valid ELF section name, as the order level is part of the
section name) of order levels. It also would offer the opportunity
to build dependencies outside of the driver core layer, so you can
customize the dependency map per subsystem as you see fit.

So -- for now I'll submit a patch to just use late_initcall(), in the
future we can evaluate linker table uses to make these dependencies
explicit. This is perhaps a good test case to illustrate limitations
of the current driver model.

[0] http://lkml.kernel.org/r/1455889559-9428-1-git-send-email-mcgrof@kernel.org

  Luis
