From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Tue, 24 Oct 2017 23:31:37 +0200
Message-ID: <20171024233137.295a6b39@t450s.home>
References: <b88fc14b230d7ecac6066bdd9e95be19@hostfission.com>
        <cb2b1ee0a3b705e668ac3cf19cfa1ecc@hostfission.com>
        <1b4a39530fde35783be63470003f0911@hostfission.com>
        <f0680cfe52b9196ee4a1d3ab28a7aefa@hostfission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <f0680cfe52b9196ee4a1d3ab28a7aefa@hostfission.com>
Sender: kvm-owner@vger.kernel.org
To: geoff--- via iommu <iommu@lists.linux-foundation.org>
Cc: geoff@hostfission.com, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, suravee.suthikulpanit@amd.com
List-Id: iommu@lists.linux-foundation.org

On Wed, 25 Oct 2017 07:16:46 +1100
geoff--- via iommu <iommu@lists.linux-foundation.org> wrote:

> I have isolated it to a single change, although I do not completely
> understand what other implications it might have.
> 
> By just changing the line in `init_vmcb` that reads:
> 
>    save->g_pat = svm->vcpu.arch.pat;
> 
> To:
> 
>    save->g_pat = 0x0606060606060606;
> 
> This enables write back and performance jumps through the roof.
> 
> This needs someone with more experience to write a proper patch that
> addresses this in a smarter way rather then just hard coding the value.
> 
> This patch looks like an attempt to fix this issue but it yields no
> detectable performance gains.
> 
> https://patchwork.kernel.org/patch/6748441/
> 
> Any takers?

IOMMU is not the right list for such a change.  I'm dubious this is
correct since you're basically going against the comment immediately
previous in the code, but perhaps it's a hint in the right direction.
Thanks,

Alex
 
> On 2017-10-25 06:08, geoff@hostfission.com wrote:
> > I have identified the issue! With NPT enabled I am now getting near 
> > bare
> > metal performance with PCI pass through. The issue was with some stubs
> > that have not been properly implemented. I will clean my code up and
> > submit a patch shortly.
> > 
> > This is a 10 year old bug that has only become evident with the recent
> > ability to perform PCI pass-through with dedicated graphics cards. I
> > would expect this to improve performance across most workloads that use
> > AMD NPT.
> > 
> > Here are some benchmarks to show what I am getting in my dev 
> > environment:
> > 
> > https://www.3dmark.com/3dm/22878932
> > https://www.3dmark.com/3dm/22879024
> > 
> > -Geoff
> > 
> > 
> > On 2017-10-24 16:15, geoff@hostfission.com wrote:  
> >> Further to this I have verified that IOMMU is working fine, traces and
> >> additional printk's added to the kernel module were used to check. All
> >> accesses are successful and hit the correct addresses.
> >> 
> >> However profiling under Windows shows there might be an issue with 
> >> IRQs
> >> not reaching the guest. When FluidMark is running at 5fps I still see
> >> excellent system responsiveness with the CPU 90% idle and the GPU load
> >> at 6%.
> >> 
> >> When switching PhysX to CPU mode the GPU enters low power mode,
> >> indicating that the card is no longer in use. This would seem to
> >> confirm that the GPU is indeed in use by the PhysX API correctly.
> >> 
> >> My assumption now is that the IRQs from the video card are getting 
> >> lost.
> >> 
> >> I could be completely off base here but at this point it seems like 
> >> the
> >> best way to proceed unless someone cares to comment.
> >> 
> >> -Geoff
> >> 
> >> 
> >> On 2017-10-24 10:49, geoff@hostfission.com wrote:  
> >>> Hi,
> >>> 
> >>> I realize this is an older thread but I have spent much of today 
> >>> trying to
> >>> diagnose the problem.
> >>> 
> >>> I have discovered how to reliably reproduce the problem with very 
> >>> little effort.
> >>> It seems that reproducing the issue has been hit and miss for people 
> >>> as it seems
> >>> to primarily affect games/programs that make use of nVidia PhysX. My
> >>> understanding of npt's inner workings is quite primitive but I have 
> >>> still spent
> >>> much of my time trying to diagnose the fault and identify the cause.
> >>> 
> >>> Using the free program FluidMark[1] it is possible to reproduce the 
> >>> issue, where
> >>> on a GTX 1080Ti the rendering rate drops to around 4 fps with npt 
> >>> turned on, but
> >>> if turned off the render rate is in excess of 60fps.
> >>> 
> >>> I have produced traces for with and without ntp enabled during these 
> >>> tests which
> >>> I can provide if it will help. So far I have been digging through how 
> >>> npt works
> >>> and trying to glean as much information as I can from the source and 
> >>> the AMD
> >>> specifications but much of this and how mmu works is very new to me 
> >>> so progress
> >>> is slow.
> >>> 
> >>> If anyone else has looked into this and has more information to share 
> >>> I would be
> >>> very interested.
> >>> 
> >>> Kind Regards,
> >>> Geoffrey McRae
> >>> HostFission
> >>> https://hostfission.com
> >>> 
> >>> 
> >>> [1]:
> >>> http://www.geeks3d.com/20130308/fluidmark-1-5-1-physx-benchmark-fluid-sph-simulation-opengl-download/  
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
