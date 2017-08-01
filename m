From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Tue, 1 Aug 2017 15:55:57 -0400
Message-ID: <20170801195556.GD3443@gmail.com>
References: <8379cf5a-7539-e221-c678-20f617fb4337@amd.com>
	<20170801172523.GA3443@gmail.com>
	<30eb1ecb-c86f-4d3b-cd49-e002f46e582d@amd.com>
	<20170801180415.GB3443@gmail.com>
	<483ecda0-2977-d2ea-794c-320e429d7645@amd.com>
	<20170801190259.GC3443@gmail.com>
	<42c5fe2b-f179-cb71-03d3-7ae991543edb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42c5fe2b-f179-cb71-03d3-7ae991543edb-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Koenig,
	Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 01, 2017 at 03:28:26PM -0400, Tom St Denis wrote:
> Adding the AMDGPU maintainers to get their opinions.
> =

> Context:
> https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023489.html
> =

> (and others in case you missed it on the list).
> =

> =

> On 01/08/17 03:03 PM, Jerome Glisse wrote:
> > > > You would need to leverage thing like uevent to get event when some=
thing
> > > > happen like a bo being destroy or command submission ...
> > > =

> > > The problem with this approach is when I'm reading an IB I'm not give=
n user
> > > space addresses but bus addresses.  So I can't correlate anything I'm=
 seeing
> > > in the hardware with the user task if I wanted to.
> > > =

> > > In fact, to augment [say] OpenGL debugging I would have to correlate a
> > > buffer handle/pointer's page backing with the bus address in the IB s=
o I
> > > could correlate the two (e.g. dump an IB and print out user process v=
ariable
> > > names that correspond to the IB contents...).
> > =

> > When you read IB you are provided with GPU virtual address, you can get=
 the
> > GPU virtual address from the same snoop ioctl just add a field in bo_in=
fo
> > above. So i don't see any issue here.
> =

> This is effectively what I'm doing with the patch except via a trace not a
> bolted on snooping ioctl.
> =

> Tracers are a bit better since there's not really any overhead in the nor=
mal
> case which is desirable (and the code is relatively very simple).
> =

> In an ideal case we could simply search the ttm pages for a given device =
to
> look for a match for a given dma address.  But that also has the problem
> that ...
> =

> This will fail for all the other allocations e.g. for our GART, ring
> buffers, etc.
> =

> So a "complete" solution would be nice where any bus address mapping that=
 is
> still valid for a device could be resolved to the physical page that is
> backing it.

So you agree that you can get what you want with ioctl ? Now you object
that the ioctl overhead is too important ?

I do not believe ioctl overhead to be an issue. Like i say in the model
i adviced you mix ioctl and thing like uevent or trace so you get "real
time" notification of what is going on.

Why do i say that your approach of tracking individual page mapping is
insane. There is several obstacle:
  - to get from GPU virtual address to physical memory address you need
    to first walk down the GPU page table to get the GPU pte entry. From
    that you either get an address inside the GPU memory (VRAM of PCIE
    device) or a DMA bus address. If it is the latter (DMA bus address)
    you need to walk down the IOMMU page table to find the physical address
    of the memory. So this is 2 page table walk down
  - none of the above walk down can happen while holding enough lock so
    that the GPU page table do not change behind you back (especialy the
    second walk down) so you are open to race
  - GPU device memory is not necessary accessible (due to PCIE bar size
    limit i know that there is patches to allow to remap all GPU memory).
  - you need to track a lot of informations in userspace ie what memory
    is behind each 4k of GPU virtual address space you are interested in
    so you are basicaly duplicating informations that already exist in
    kernel space into userland

With what i outline you rely on the kernel informations to get to the
thing you want. You can even add something like:

struct amdgpu_snoop_snapshot_ioctl {
	uint64_t	gpu_virtual_address;
	uint64_t	size;
	uint64_t	uptr;
};

To snapshot a range of the GPU virtual address space so you not even
have to worry about GPU virtual address -> bo handle -> offset into
bo. You can even go further and add a /dev/dri/card0-snoop device file
that you can mmap to access GPU virtual address space. Process open
the card0 file register as snoop against another process from that point
on a GPU virtual address in the snooped process becomes an offset into
the card0-snoop file. So now you can read/write on that device file
to access the GPU memory of a process without doing ioctl. The changes
to amdgpu are not that big.

> =

> > > Again, not looking to rehash this debate.  AMDGPU has had register le=
vel
> > > debugfs access for nearly two years now.  At the point you can write =
to
> > > hardware registers you have to be root anyways.  I could just as easi=
ly load
> > > a tainted AMDGPU driver if I wanted to at that point which then achie=
ves the
> > > same debugfs-free badness for me.
> > =

> > You also have IOMMU that restrict what you can do. Even if you can write
> > register to program a DMA operation you are still likely behind an IOMMU
> > and thus you can't write anywhere (unless IOMMU is disabled or in pass
> > through ie 1 on 1 mapping).
> =

> Fair point.  All I was saying is at the point you have MMIO access you can
> typically do bad things if you wanted to (like crash the system).
> =

> > I am saying you can have access to this memory with a sane API and not =
with
> > something insane. What is wrong with what i outlined above ?
> =

> Well aside from the fact it doesn't cover all mappings, I can't see how i=
t's
> materially different than what I was already doing.  For this to work I'd
> have to be able to mmap objects from another process into the debugger.  I
> don't know if drm is really designed for that sort of flow and I suspect =
it
> would take a lot of work to add that.

The amount of work does not matter. We are aiming for sane solution not
insane thing. We are aiming for thing that are safe from security point
of view. We are aiming for design that lower barrier (ie no need to be
root to debug/trace GPU). This is what matters.

Quite frankly what i outline is not a lot of work. The snoop device file
scheme for instance is pretty easy to achieve. Everytime there is a change
to ttm object or GPU virtual address space you would need to update
accordingly any mmap of that file. Overall i would say this is in the
500/1000 lines of code range.

GPU device memory is slightly harder, you probably need to do it as a
snapshot ie you copy device memory to system memory and map the system
memory.


> =

> > > At the point I'm root I can attach to any process, change memory cont=
ents,
> > > do whatever I want.  Unless the kernel has such broken vfs security t=
hat it
> > > allows non-root users to read/write debugfs/etc it shouldn't be a pro=
blem.
> > =

> > With sane API you would not need to be root to debug/trace GPU activity=
 of
> > your own process like gdb.
> =

> You need to be root to read GPU registers though (simply reading some
> registers can cause a GPU hang).  So if you want to see which waves are
> active, or the contents of a ring (or it's IBs) you can't do that as a
> normal user.  There's a very tiny subset of registers you can access thro=
ugh
> libdrm and often we need more than that (especially for npi work).
> =

> Indeed we recommend that on devel machines people +s umr so they can invo=
ke
> it from normal user processes.  You wouldn't normally install umr unless =
you
> were a developer anyways so for customers/users it's not an issue.
> =

> It's not exactly as confined as all-software which is where some compromi=
ses
> are made.

We want thing like debugger to work out of the box on any distribution so
design must be sane and you should not need either to ask special modules
or special kernel config option or to be root. There is way to do what you
want without any of this requirement and thus that should be what you aim
for.

> =

> > > > > The existing tracer patch "works" but it's not ideal and the main=
tainers of
> > > > > the AMDGPU driver are legitimately desiring a better solution.
> > > > =

> > > > Again re-design what you are trying to do. There is no legitimate n=
eed to
> > > > track individual page mapping. All you need is access to all buffer=
 object
> > > > a process have created and to be inform on anything a process do th=
rough
> > > > the amdgpu device file.
> > > =

> > > Again the problem is the hardware is programmed with the dma address.=
 So I
> > > want to correlate what the hardware is doing with what the process is=
 doing
> > > I need the mappings.
> > =

> > You only need the GPU virtual address and you can get it with the API i=
 outline.
> =

> Which is effectively what my tracer is.  But it (and your design) can't
> translate all mappings which is why we even engaged with iommu list in the
> first place at all.

My design do not need to get the reverse mapping at all that is my point.
No need to engage the iommu folks no need to ask them for something as
you have all the information from inside the amdgpu driver.

> =

> Adding drm support to allow another process to GEM_MAP BOs (and a search
> ioctl) might work but seems like a lot more work (and will likely reduce
> performance) than the tracer and has the same limitation.  And ultimately=
 we
> find direct memory access useful in NPI work so that's unlikely to be
> removed.

You have not proof that it would be slower and i outline the special file
idea that avoid any ioctl.

> =

> Thanks for your time Jerome.  I do understand where you're coming from but
> I'm not sure a drm update is both politically or technically feasible and=
 we
> need this functionality (limited though it is) sooner than later.

You have to understand that kernel is not about compromising design so that
people can reach their schedule. Sane design do matter and if sane design
require lot of work than you should size your team accordingly to face the
challenges.

What you want to do can be done with very little code and no change outside
amdgpu kernel driver so i do not see any reason to not do so.

J=E9r=F4me
