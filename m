From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v3] drm: use late_initcall() for amdkfd and radeon
Date: Thu, 10 Nov 2016 14:12:44 -0800
Message-ID: <CAB=NE6Vuz4JUYdqy80sgJGMthH3v3DhbxjpQj73E6VA4hxfvwA@mail.gmail.com>
References: <20160527004642.GQ11948@wotan.suse.de>
	<1464311916-10065-1-git-send-email-mcgrof@kernel.org>
	<CAKMK7uHTAWOmrTsGHxwW1nGcNeEeAb8b2OPFKcJvQ3AXkbs+Kg@mail.gmail.com>
	<20160531165834.GG11948@wotan.suse.de>
	<20160531190453.GL7231@phenom.ffwll.local>
	<20160601211159.GO11948@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160601211159.GO11948-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P++eRFICb6hQw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 1, 2016 at 2:11 PM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 31, 2016 at 09:04:53PM +0200, Daniel Vetter wrote:
>> On Tue, May 31, 2016 at 06:58:34PM +0200, Luis R. Rodriguez wrote:
>> > On Sun, May 29, 2016 at 08:27:07PM +0200, Daniel Vetter wrote:
>> > > On Fri, May 27, 2016 at 3:18 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > > > To get KFD support in radeon we need the following
>> > > > initialization to happen in this order, their
>> > > > respective driver file that has its init routine
>> > > > listed next to it:
>> > > >
>> > > > 0. AMD IOMMUv1:    arch/x86/kernel/pci-dma.c
>> > > > 1. AMD IOMMUv2:    drivers/iommu/amd_iommu_v2.c
>> > > > 2. AMD KFD:        drivers/gpu/drm/amd/amdkfd/kfd_module.c
>> > > > 3. AMD Radeon:     drivers/gpu/drm/radeon/radeon_drv.c
>> > > >
>> > > > Order is rather implicit, but these drivers can currently
>> > > > only do so much given the amount of leg room available.
>> > > > Below are the respective init routines and how they are
>> > > > initialized:
>> > > >
>> > > > arch/x86/kernel/pci-dma.c               rootfs_initcall(pci_iommu_init);
>> > > > drivers/iommu/amd_iommu_v2.c            module_init(amd_iommu_v2_init);
>> > > > drivers/gpu/drm/amd/amdkfd/kfd_module.c module_init(kfd_module_init);
>> > > > drivers/gpu/drm/radeon/radeon_drv.c     module_init(radeon_init);
>> > > >
>> > > > When a driver is built-in module_init() folds to use
>> > > > device_initcall(), and we have the following possible
>> > > > orders:
>> > > >
>> > > >         #define pure_initcall(fn)    __define_initcall(fn, 0)
>> > > >         #define core_initcall(fn)    __define_initcall(fn, 1)
>> > > >         #define postcore_initcall(fn)__define_initcall(fn, 2)
>> > > >         #define arch_initcall(fn)    __define_initcall(fn, 3)
>> > > >         #define subsys_initcall(fn)  __define_initcall(fn, 4)
>> > > >         #define fs_initcall(fn)      __define_initcall(fn, 5)
>> > > >         ---------------------------------------------------------
>> > > >         #define rootfs_initcall(fn)  __define_initcall(fn, rootfs)
>> > > >         #define device_initcall(fn)  __define_initcall(fn, 6)
>> > > >         #define late_initcall(fn)    __define_initcall(fn, 7)
>> > > >
>> > > > Since we start off from rootfs_initcall(), it gives us 3 more
>> > > > levels of leg room to play with for order semantics, this isn't
>> > > > enough to address all required levels of dependencies, this
>> > > > is specially true given that AMD-KFD needs to be loaded before
>> > > > the radeon driver -- -but this it not enforced by symbols.
>> > > > If the AMD-KFD driver is not loaded prior to the radeon driver
>> > > > because otherwise the radeon driver will not initialize the
>> > > > AMD-KFD driver and you get no KFD functionality in userspace.
>> > > >
>> > > > Commit 1bacc894c227fad8a7 ("drivers: Move iommu/ before gpu/ in
>> > > > Makefile") works around some of the possibe races between
>> > > > the AMD IOMMU v2 and GPU drivers by changing the link order.
>> > > > This is fragile, however its the bets we can do, given that
>> > > > making the GPU drivers use late_initcall() would also implicate
>> > > > a similar race between them. That possible race is fortunatley
>> > > > addressed given that the drm Makefile currently has amdkfd
>> > > > linked prior to radeon:
>> > > >
>> > > > drivers/gpu/drm/Makefile
>> > > > ...
>> > > > obj-$(CONFIG_HSA_AMD) += amd/amdkfd/
>> > > > obj-$(CONFIG_DRM_RADEON)+= radeon/
>> > > > ...
>> > > >
>> > > > Changing amdkfd and radeon to late_initcall() however is
>> > > > still the right call in orde to annotate explicitly a
>> > > > delayed dependency requirement between the GPU drivers
>> > > > and the IOMMUs.
>> > > >
>> > > > We can't address the fragile nature of the link order
>> > > > right now, but in the future that might be possible.
>> > > >
>> > > > Signed-off-by: Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> > > > ---
>> > > >
>> > > > Please note, the changes to drivers/Makefile are just
>> > > > for the sake of forcing the possible race to occur,
>> > > > if this works well the actual [PATCH] submission will
>> > > > skip those changes as its pointless to remove those
>> > > > work arounds as it stands, due to the limited nature
>> > > > of the levels available for addressing requirements.
>> > > >
>> > > > Also, if you are aware of further dependency hell
>> > > > things like these -- please do let me know as I am
>> > > > interested in looking at addressing them.
>> > >
>> > > This should be fixed with -EPROBE_DEFER instead. Frobbing initcall
>> > > levels should then just be done as an optimization to avoid too much
>> > > reprobing.
>> >
>> > radeon already uses -EPROBE_DEFER but it assumes that amdkfd *is* loaded first,
>> > and only if it is already loaded can it count on getting -EPROBE_DEFER. The
>> > radeon driver will defer probe *iff* kgd2kfd_init() returns -EPROBE_DEFER,
>> > which only happens when amdkfd_init_completed is no longer 0. If radeon
>> > gets linked first though the symbol fetch for kgd2kfd_init() will make it as
>> > not-present though.
>
> I did some more homework and I no longer believe this was the issue. More below.
>
>> > So the current heuristic used does not address proper link
>> > / load order. Part of the issue mentioned on the commit log is another race
>> > underneath the hood with the AMD IOMMU v2 which is needed for amdkfd. The
>> > underlying issue however really is the lack of available clear semantics for
>> > dependencies over 3 levels here.  This is solved one way or another by link
>> > order in the Makefiles, but as I've noted so far this has been rather implicit
>> > and fragile. The change here makes at least the order of the GPU drivers
>> > explicitly later than the IOMMUs. The specific race between radeon and amdfkd
>> > is solved currently through link order through the Makefiles. In the future we
>> > maybe able to make things more explicit.
>>
>> Sounds like the EPROBE_DEFER handling is broken - if the module isn't set
>> up yet but selected in Kconfig, and needed for that hw generation then it
>> should not just silently fail.
>
> Although I cannot confirm through testing, I did an under the hood inspection
> of symbol_request() which both radeon and amdgpu uses and have a better idea
> of why things where failing, it should not really be the inability to trust
> symbol_request() to work if link order changes between amdkfd and radeon or
> amdgpu, its the issue of link order also needed of the AMD IOMMU *and* amdkfd.
> So my above assumption here that -EPROBE_DEFER could fail should be
> invalid given that the real issue should have been that amdkfd was being
> kicked off prior to the AMD IOMMU v2, at that point kgd2kfd_init() would
> fail. The silent failure then was an issue not of radeon but rather higher
> order drivers, and in this case neither radeon nor amdgpu could address
> that regardless of what they do. Oded fixed this by changing the link order
> between all IOMMUs and GPU drivers via commit 1bacc894c227fad8a7 ("drivers:
> Move iommu/ before gpu/ in Makefile").
>
>> > -EPROBE_DEFER also introduces a latency on load which we should not need if we
>> > can handle proper link / load order dependency annotations. This change is a
>> > small part of that work, but as it the commit log also notes future further
>> > work is possible to build stronger semantics.  Some of the work I'm doing with
>> > linker-tables may help with this in the future [0], but for now this should
>> > help with what the semantics we have in place.
>> >
>> > [0] http://lkml.kernel.org/r/1455889559-9428-1-git-send-email-mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
>>
>> That's what I meant with "avoiding too much reprobing". But in the end the
>> current solution to cross-driver deps we have is EPROBE_DEFER. Fiddling
>> with the link order is all well for optimizing stuff, but imo _way_ too
>> fragile for correctness.
>
> Agreed, but EPROBE_DEFER cannot ensure layers below are correct either. By
> moving the GPU drivers radon and amdgpu to late_initcall() we'd actually be
> taking one more explicit ordering step for correctness to ensure that in case
> the Makefile order is different in other environments at least the IOMMU and
> GPU driver initialization is explicitly correct.

Other than addressing more init levels in the future for more device
categories in the kernel, a module section, say with MODULE_SUGGESTS()
might help to enable the core to request_module() on behalf of
drivers... if this seems like it could help I could try it out.

 Luis
