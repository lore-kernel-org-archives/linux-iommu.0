From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH V5] drm/i915: Disable stolen memory when i915 runs on
 qemu
Date: Wed, 12 Apr 2017 16:21:56 +0300
Message-ID: <1492003316.3274.44.camel@linux.intel.com>
References: <1491358106-26329-1-git-send-email-xiong.y.zhang@intel.com>
         <1491999600-4406-1-git-send-email-xiong.y.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1491999600-4406-1-git-send-email-xiong.y.zhang@intel.com>
Sender: stable-owner@vger.kernel.org
To: Xiong Zhang <xiong.y.zhang@intel.com>, daniel@ffwll.ch, zhenyuw@linux.intel.com, jani.nikula@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>
Cc: intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, stable@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

+ Kevin and David

On ke, 2017-04-12 at 20:20 +0800, Xiong Zhang wrote:
> Stolen memory isn't a standard pci resource and exists in RMRR which has
> identity mapping in iommu table, IGD could access stolen memory in host OS.
> While according to 'commit c875d2c1b808 ("iommu/vt-d: Exclude devices using
> RMRRs from IOMMU API domains")',RMRR isn't supported by kvm, then both EPT
> and guest iommu domain table lack of maaping for stolen memory in kvm IGD
> passthrough environment. If IGD access stolen memory in such environment,
> many iommu exceptions exist in host dmesg and gpu hang exists also.
> DMAR: [DMA Read] Request device [00:02.0] fault addr da012000
> [fault reason 05] PTE Write access is not set
> DMAR: [DMA Read] Request device [00:02.0] fault addr da2df000
> [fault reason 06] PTE Read access is not set
> 
> So stolen memory should be disabled in KVM IGD passthrough environment,
> this patch detects such environment through the existence of qemu emulated 
> isa bridge.
> 
> When the real ISA bridge is also passed through to guest, guest will have
> two isa bridges: emulated and real. Qemu guarantees the busnum:devnum.
> funcnum of emulated isa bridge is always less than the real one. Then
> emulated isa bridge is always detected first by pci_get_class(ISA). So
> stolen memory will be disabled in this case also.
> 
> Stolen memory exists in kernel for a long time, but this patch depends
> on INTEL_PCH_QEMU_DEVICE_ID_TYPE which was introduced in v4.5 kernel,
> so this patch should be backported into v4.5 kernel and above.
> 
> v2:GVT-g may run in non qemu (Zhenyu)
> v3:Make commit message clear (Daniel)
> v4:Fix typo
> v5:Exclude P2X as it is used for VMware (Joonas)
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99028
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org

The commit message still fails to address the fact that the Bugzilla
entry has a completely bogus bisect, the fact that there is a later
commit that allows RMRRs on graphics devices;

commit 18436afdc11a00ac881990b454cfb2eae81d6003
Author: David Woodhouse <David.Woodhouse@intel.com>
Date:   Wed Mar 25 15:05:47 2015 +0000

    iommu/vt-d: Allow RMRR on graphics devices too

And the fact that GuC status is still not answered even I explicitly
asked for it.

By my limited understanding of VT-d details: The stolen memory is never
directly accessed by i915 driver (because CPU access doesn't work even
in DOM0). It is only used through the aperture, which just requires for
the GT device to have access to the RMRR. Further, the GT device needs
to have access to stolen memory, because that's what GuC uses for
backing storage for for WOPCM.

And even if after all of the above is addressed, shouldn't we rather
try to detect the lack of RMRR, than presence of QEMU ISA?

What comes to my mind is exporting function like device_has_rmrr() from
intel-iommu.com and consuming that, if we end up doing this. That way,
if somebody, some day, goes and write RMRR pass-through code currently
missing, it'll start working, just like it should.

Regards, Joonas
-- 
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
