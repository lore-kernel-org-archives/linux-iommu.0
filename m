From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Tue, 1 Aug 2017 17:01:05 -0400
Message-ID: <20170801210105.GE3443@gmail.com>
References: <8379cf5a-7539-e221-c678-20f617fb4337@amd.com>
	<20170801172523.GA3443@gmail.com>
	<30eb1ecb-c86f-4d3b-cd49-e002f46e582d@amd.com>
	<20170801180415.GB3443@gmail.com>
	<483ecda0-2977-d2ea-794c-320e429d7645@amd.com>
	<20170801190259.GC3443@gmail.com>
	<42c5fe2b-f179-cb71-03d3-7ae991543edb@amd.com>
	<20170801195556.GD3443@gmail.com>
	<77e557d2-aa75-46c4-88a7-cca5448ea08e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <77e557d2-aa75-46c4-88a7-cca5448ea08e-5C7GfCeVMHo@public.gmane.org>
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

On Tue, Aug 01, 2017 at 04:26:38PM -0400, Tom St Denis wrote:
> Was trying to walk away from this ... :-) (all in good fun).
> =

> =

> On 01/08/17 03:55 PM, Jerome Glisse wrote:
> > On Tue, Aug 01, 2017 at 03:28:26PM -0400, Tom St Denis wrote:
> > > Adding the AMDGPU maintainers to get their opinions.
> > > =

> > > Context:
> > > https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023489.=
html
> > > =

> > > (and others in case you missed it on the list).
> > > =

> > > =

> > > On 01/08/17 03:03 PM, Jerome Glisse wrote:
> > > > > > You would need to leverage thing like uevent to get event when =
something
> > > > > > happen like a bo being destroy or command submission ...
> > > > > =

> > > > > The problem with this approach is when I'm reading an IB I'm not =
given user
> > > > > space addresses but bus addresses.  So I can't correlate anything=
 I'm seeing
> > > > > in the hardware with the user task if I wanted to.
> > > > > =

> > > > > In fact, to augment [say] OpenGL debugging I would have to correl=
ate a
> > > > > buffer handle/pointer's page backing with the bus address in the =
IB so I
> > > > > could correlate the two (e.g. dump an IB and print out user proce=
ss variable
> > > > > names that correspond to the IB contents...).
> > > > =

> > > > When you read IB you are provided with GPU virtual address, you can=
 get the
> > > > GPU virtual address from the same snoop ioctl just add a field in b=
o_info
> > > > above. So i don't see any issue here.
> > > =

> > > This is effectively what I'm doing with the patch except via a trace =
not a
> > > bolted on snooping ioctl.
> > > =

> > > Tracers are a bit better since there's not really any overhead in the=
 normal
> > > case which is desirable (and the code is relatively very simple).
> > > =

> > > In an ideal case we could simply search the ttm pages for a given dev=
ice to
> > > look for a match for a given dma address.  But that also has the prob=
lem
> > > that ...
> > > =

> > > This will fail for all the other allocations e.g. for our GART, ring
> > > buffers, etc.
> > > =

> > > So a "complete" solution would be nice where any bus address mapping =
that is
> > > still valid for a device could be resolved to the physical page that =
is
> > > backing it.
> > =

> > So you agree that you can get what you want with ioctl ? Now you object
> > that the ioctl overhead is too important ?
> =

> No, I object that the overhead of keeping track of it in some sort of sno=
op
> structure is too much (and adds too much new code to the driver for the s=
ole
> purpose of this one feature).
> =

> Not to mention we can't really invent ioctls without co-ordinating with w=
ith
> the other drm users (re: not just AMD).  umr is a lot less coupled since
> it's not really versioned just yet (still bringing up a lot of features so
> users use git not packages).

You can do this outside drm and if API make sense to other it can be added
latter to drm.

> =

> > I do not believe ioctl overhead to be an issue. Like i say in the model
> > i adviced you mix ioctl and thing like uevent or trace so you get "real
> > time" notification of what is going on.
> =

> Unless you can nop that in a config invariant fashion (like you can for
> tracers) that's a NAK from the get go.  And we'd need to buffer them to be
> practical since you might run the debugger out of sync with the applicati=
on
> (e.g. app hangs then you fire up umr to see what's going on).

Again when you start snooping you can access all the existing bo
informations and start monitoring event to keep userspace in sync
with any changes from the first snapshot you take.

> =

> > Why do i say that your approach of tracking individual page mapping is
> > insane. There is several obstacle:
> >    - to get from GPU virtual address to physical memory address you need
> >      to first walk down the GPU page table to get the GPU pte entry. Fr=
om
> >      that you either get an address inside the GPU memory (VRAM of PCIE
> >      device) or a DMA bus address. If it is the latter (DMA bus address)
> >      you need to walk down the IOMMU page table to find the physical ad=
dress
> >      of the memory. So this is 2 page table walk down
> =

> We already do this in umr.  give a GPUVM address we can decode it down to=
 a
> PTE on both AI and VI platforms.  It's decoding the PTE to a physical page
> (outside of vram) that is the issue.
> =

> In fact being able to VM decode is important to the kernel team who have =
to
> debug VM issues from time to time.
> =

> >    - none of the above walk down can happen while holding enough lock so
> >      that the GPU page table do not change behind you back (especialy t=
he
> >      second walk down) so you are open to race
> =

> Which is fine because you'd only really do this on a stalled/halted GPU
> anyways.  Just like you don't inspect variables of a program that is
> currently running (and not blocked/asleep/etc).  We have the ability to h=
alt
> currently active waves/etc.

So you want to add something to the kernel just for a corner case ie
when debugging GPU hang. Not for more generic tools. I don't think
that the work needed for that is worth the effort just for such a
small usecase.

> =

> >    - GPU device memory is not necessary accessible (due to PCIE bar size
> >      limit i know that there is patches to allow to remap all GPU memor=
y).
> =

> We have ways of accessing all of VRAM from basic MMIO accesses :)

Yes and it is insane to have to write VRAM address in one register and
read the VRAM value in another, insane from tedious point of view :)

> =

> >    - you need to track a lot of informations in userspace ie what memory
> >      is behind each 4k of GPU virtual address space you are interested =
in
> >      so you are basicaly duplicating informations that already exist in
> >      kernel space into userland
> =

> Agreed, if we had a TTM query API that'd be better but we don't.  And we
> work out what the memory is by inspecting the ring.  The ring has pointers
> to IB buffers which then have their own contents (e.g. CE/DE content).
>
> > With what i outline you rely on the kernel informations to get to the
> > thing you want. You can even add something like:
> > =

> > struct amdgpu_snoop_snapshot_ioctl {
> > 	uint64_t	gpu_virtual_address;
> > 	uint64_t	size;
> > 	uint64_t	uptr;
> > };
> > =

> > To snapshot a range of the GPU virtual address space so you not even
> > have to worry about GPU virtual address -> bo handle -> offset into
> > bo. You can even go further and add a /dev/dri/card0-snoop device file
> > that you can mmap to access GPU virtual address space. Process open
> > the card0 file register as snoop against another process from that point
> > on a GPU virtual address in the snooped process becomes an offset into
> > the card0-snoop file. So now you can read/write on that device file
> > to access the GPU memory of a process without doing ioctl. The changes
> > to amdgpu are not that big.
> =

> Honestly I'm not qualified to agree/disagree with your last sentence.  I
> suspect it's a lot more complicated than a trace though and as I said a f=
ew
> times already this won't cover allocations done privately in the kernel.

Kernel allocation should be out of your reach really.

> =

> > > Well aside from the fact it doesn't cover all mappings, I can't see h=
ow it's
> > > materially different than what I was already doing.  For this to work=
 I'd
> > > have to be able to mmap objects from another process into the debugge=
r.  I
> > > don't know if drm is really designed for that sort of flow and I susp=
ect it
> > > would take a lot of work to add that.
> > =

> > The amount of work does not matter. We are aiming for sane solution not
> > insane thing. We are aiming for thing that are safe from security point
> > of view. We are aiming for design that lower barrier (ie no need to be
> > root to debug/trace GPU). This is what matters.
> =

> Except that you're approaching this from the angle that the KMD is perfect
> and we're debugging the UMD.  umr is meant to debug both.  So things like
> raw access to VRAM/GART is necessary.  For instance, to debug VM mappings,
> to read IBs, to read frame buffers, etc...

Then you can use the snoop device file to access gart and use mmio reg to
access device memory. Have 2 files one that gives you gpu pte for each 4k
and the other one that allow you to access gart object either through mmap
or to read/write.

> =

> > Quite frankly what i outline is not a lot of work. The snoop device file
> > scheme for instance is pretty easy to achieve. Everytime there is a cha=
nge
> > to ttm object or GPU virtual address space you would need to update
> > accordingly any mmap of that file. Overall i would say this is in the
> > 500/1000 lines of code range.
> =

> Again I'm not familiar enough with the DRM/TTM code design to comment her=
e.
> =

> > GPU device memory is slightly harder, you probably need to do it as a
> > snapshot ie you copy device memory to system memory and map the system
> > memory.
> =

> Which is unnecessary since we can directly read VRAM from the debugger :-)
> =

> > We want thing like debugger to work out of the box on any distribution =
so
> > design must be sane and you should not need either to ask special modul=
es
> > or special kernel config option or to be root. There is way to do what =
you
> > want without any of this requirement and thus that should be what you a=
im
> > for.
> =

> Except again you're looking at this from the lens that the KMD is working
> perfectly.  We use umr (our debugger) to debug the kernel driver itself.
> That means you need to be able to read/write MMIO registers, peek at VRAM,
> decode VM addresses, read rings, etc...

And you can do that with the scheme i propose.

> =

> Since we already have an entire list of "security breaches" we might as w=
ell
> make use of them for UMD debugging too.  Again, you're not going to give
> random logins access to umr on your machine.  I mean in reality you would=
n't
> do that anyways for UMD tasks (you can easily lock up a GPU from a user t=
ask
> with no privileges...).

Locking up is one thing, allowing to access data that should not be accessi=
ble
from userspace is another issue entirely. The former is bad, the latter is
worse.

> =

> > My design do not need to get the reverse mapping at all that is my poin=
t.
> > No need to engage the iommu folks no need to ask them for something as
> > you have all the information from inside the amdgpu driver.
> =

> Which again works iff you're debugging UMD only.

No it works also if you are debugging kernel side ie anything that is mapped
to the GPU either into userspace GPU virtual address space or into kernel
GPU virtual address space.

> =

> > > Adding drm support to allow another process to GEM_MAP BOs (and a sea=
rch
> > > ioctl) might work but seems like a lot more work (and will likely red=
uce
> > > performance) than the tracer and has the same limitation.  And ultima=
tely we
> > > find direct memory access useful in NPI work so that's unlikely to be
> > > removed.
> > =

> > You have not proof that it would be slower and i outline the special fi=
le
> > idea that avoid any ioctl.
> =

> By "slower" I don't mean the syscall for ioctl.  I mean the housekeeping
> we'd have to do in the driver on top of normal TTM housekeeping.  Unless =
you
> can nop it all out by default (which I suspect you can) it will get NAK'ed
> immediately by the maintainers.

No i don't think it would be anything big unless they object to an if()
in a hotpath.

> =

> Setting aside the fact of adding 500+ lines of code so you could attach to
> other libdrm processes and rifle through their BOs is code they have to
> maintain.
> =

> > > Thanks for your time Jerome.  I do understand where you're coming fro=
m but
> > > I'm not sure a drm update is both politically or technically feasible=
 and we
> > > need this functionality (limited though it is) sooner than later.
> > =

> > You have to understand that kernel is not about compromising design so =
that
> > people can reach their schedule. Sane design do matter and if sane desi=
gn
> > require lot of work than you should size your team accordingly to face =
the
> > challenges.
> =

> Except the real world doesn't work that way.  And we have legitimate reas=
ons
> for being able to peek/poke at the hardware.  Philosophies likes yours le=
ad
> companies to write private debug tools and not share them with the public.
> Whereas we're trying to come up with a debug tool (and kernel module) that
> is practically safe and effective at its job without overly mucking about=
 in
> the kerne.
> =

> You can't legitimately debug hardware from a userspace tool without having
> some knobs/etc that would otherwise be ill advised to give to everyone.  =
In
> a normal distribution your users run unprivileged and wouldn't have umr
> installed.  So they have zero access to any of our debugfs facilities and
> can only talk to the device via libdrm (via GL/VK/etc).
> =

> I still haven't seen an explanation for why having root-only access to the
> device is bad other than "it's insane!"  At the point you can run privile=
ged
> processes you can simply compile and install a tainted kernel module to do
> the same thing.

I was saying that your design is restrictive and can not be use for other
thing and thus it is hard to justify the work for a single use case.

> =

> Ideally, though if we went this route it'd be a drm/ttm change not an amd=
gpu
> change since I can't believe the other vendors wouldn't be able to make u=
se
> of this functionality either.
> =

> > What you want to do can be done with very little code and no change out=
side
> > amdgpu kernel driver so i do not see any reason to not do so.
> =

> Maybe Alex or Christian can weigh in at this point?
> =

> I'm not saying your proposal isn't possible I just don't have enough clar=
ity
> on how I'd implement that nor enough confidence that it would be material=
ly
> any better (keep in mind we are NOT removing our debugfs facilities).

Well maybe i will code it down latter today on the train back home.

J=E9r=F4me
