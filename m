From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Tue, 1 Aug 2017 16:26:38 -0400
Message-ID: <77e557d2-aa75-46c4-88a7-cca5448ea08e@amd.com>
References: <8379cf5a-7539-e221-c678-20f617fb4337@amd.com>
	<20170801172523.GA3443@gmail.com>
	<30eb1ecb-c86f-4d3b-cd49-e002f46e582d@amd.com>
	<20170801180415.GB3443@gmail.com>
	<483ecda0-2977-d2ea-794c-320e429d7645@amd.com>
	<20170801190259.GC3443@gmail.com>
	<42c5fe2b-f179-cb71-03d3-7ae991543edb@amd.com>
	<20170801195556.GD3443@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170801195556.GD3443-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Koenig,
	Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Was trying to walk away from this ... :-) (all in good fun).


On 01/08/17 03:55 PM, Jerome Glisse wrote:
> On Tue, Aug 01, 2017 at 03:28:26PM -0400, Tom St Denis wrote:
>> Adding the AMDGPU maintainers to get their opinions.
>>
>> Context:
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023489.html
>>
>> (and others in case you missed it on the list).
>>
>>
>> On 01/08/17 03:03 PM, Jerome Glisse wrote:
>>>>> You would need to leverage thing like uevent to get event when something
>>>>> happen like a bo being destroy or command submission ...
>>>>
>>>> The problem with this approach is when I'm reading an IB I'm not given user
>>>> space addresses but bus addresses.  So I can't correlate anything I'm seeing
>>>> in the hardware with the user task if I wanted to.
>>>>
>>>> In fact, to augment [say] OpenGL debugging I would have to correlate a
>>>> buffer handle/pointer's page backing with the bus address in the IB so I
>>>> could correlate the two (e.g. dump an IB and print out user process variable
>>>> names that correspond to the IB contents...).
>>>
>>> When you read IB you are provided with GPU virtual address, you can get the
>>> GPU virtual address from the same snoop ioctl just add a field in bo_info
>>> above. So i don't see any issue here.
>>
>> This is effectively what I'm doing with the patch except via a trace not a
>> bolted on snooping ioctl.
>>
>> Tracers are a bit better since there's not really any overhead in the normal
>> case which is desirable (and the code is relatively very simple).
>>
>> In an ideal case we could simply search the ttm pages for a given device to
>> look for a match for a given dma address.  But that also has the problem
>> that ...
>>
>> This will fail for all the other allocations e.g. for our GART, ring
>> buffers, etc.
>>
>> So a "complete" solution would be nice where any bus address mapping that is
>> still valid for a device could be resolved to the physical page that is
>> backing it.
> 
> So you agree that you can get what you want with ioctl ? Now you object
> that the ioctl overhead is too important ?

No, I object that the overhead of keeping track of it in some sort of 
snoop structure is too much (and adds too much new code to the driver 
for the sole purpose of this one feature).

Not to mention we can't really invent ioctls without co-ordinating with 
with the other drm users (re: not just AMD).  umr is a lot less coupled 
since it's not really versioned just yet (still bringing up a lot of 
features so users use git not packages).

> I do not believe ioctl overhead to be an issue. Like i say in the model
> i adviced you mix ioctl and thing like uevent or trace so you get "real
> time" notification of what is going on.

Unless you can nop that in a config invariant fashion (like you can for 
tracers) that's a NAK from the get go.  And we'd need to buffer them to 
be practical since you might run the debugger out of sync with the 
application (e.g. app hangs then you fire up umr to see what's going on).

> Why do i say that your approach of tracking individual page mapping is
> insane. There is several obstacle:
>    - to get from GPU virtual address to physical memory address you need
>      to first walk down the GPU page table to get the GPU pte entry. From
>      that you either get an address inside the GPU memory (VRAM of PCIE
>      device) or a DMA bus address. If it is the latter (DMA bus address)
>      you need to walk down the IOMMU page table to find the physical address
>      of the memory. So this is 2 page table walk down

We already do this in umr.  give a GPUVM address we can decode it down 
to a PTE on both AI and VI platforms.  It's decoding the PTE to a 
physical page (outside of vram) that is the issue.

In fact being able to VM decode is important to the kernel team who have 
to debug VM issues from time to time.

>    - none of the above walk down can happen while holding enough lock so
>      that the GPU page table do not change behind you back (especialy the
>      second walk down) so you are open to race

Which is fine because you'd only really do this on a stalled/halted GPU 
anyways.  Just like you don't inspect variables of a program that is 
currently running (and not blocked/asleep/etc).  We have the ability to 
halt currently active waves/etc.

>    - GPU device memory is not necessary accessible (due to PCIE bar size
>      limit i know that there is patches to allow to remap all GPU memory).

We have ways of accessing all of VRAM from basic MMIO accesses :)

>    - you need to track a lot of informations in userspace ie what memory
>      is behind each 4k of GPU virtual address space you are interested in
>      so you are basicaly duplicating informations that already exist in
>      kernel space into userland

Agreed, if we had a TTM query API that'd be better but we don't.  And we 
work out what the memory is by inspecting the ring.  The ring has 
pointers to IB buffers which then have their own contents (e.g. CE/DE 
content).

> With what i outline you rely on the kernel informations to get to the
> thing you want. You can even add something like:
> 
> struct amdgpu_snoop_snapshot_ioctl {
> 	uint64_t	gpu_virtual_address;
> 	uint64_t	size;
> 	uint64_t	uptr;
> };
> 
> To snapshot a range of the GPU virtual address space so you not even
> have to worry about GPU virtual address -> bo handle -> offset into
> bo. You can even go further and add a /dev/dri/card0-snoop device file
> that you can mmap to access GPU virtual address space. Process open
> the card0 file register as snoop against another process from that point
> on a GPU virtual address in the snooped process becomes an offset into
> the card0-snoop file. So now you can read/write on that device file
> to access the GPU memory of a process without doing ioctl. The changes
> to amdgpu are not that big.

Honestly I'm not qualified to agree/disagree with your last sentence.  I 
suspect it's a lot more complicated than a trace though and as I said a 
few times already this won't cover allocations done privately in the kernel.

>> Well aside from the fact it doesn't cover all mappings, I can't see how it's
>> materially different than what I was already doing.  For this to work I'd
>> have to be able to mmap objects from another process into the debugger.  I
>> don't know if drm is really designed for that sort of flow and I suspect it
>> would take a lot of work to add that.
> 
> The amount of work does not matter. We are aiming for sane solution not
> insane thing. We are aiming for thing that are safe from security point
> of view. We are aiming for design that lower barrier (ie no need to be
> root to debug/trace GPU). This is what matters.

Except that you're approaching this from the angle that the KMD is 
perfect and we're debugging the UMD.  umr is meant to debug both.  So 
things like raw access to VRAM/GART is necessary.  For instance, to 
debug VM mappings, to read IBs, to read frame buffers, etc...

> Quite frankly what i outline is not a lot of work. The snoop device file
> scheme for instance is pretty easy to achieve. Everytime there is a change
> to ttm object or GPU virtual address space you would need to update
> accordingly any mmap of that file. Overall i would say this is in the
> 500/1000 lines of code range.

Again I'm not familiar enough with the DRM/TTM code design to comment here.

> GPU device memory is slightly harder, you probably need to do it as a
> snapshot ie you copy device memory to system memory and map the system
> memory.

Which is unnecessary since we can directly read VRAM from the debugger :-)

> We want thing like debugger to work out of the box on any distribution so
> design must be sane and you should not need either to ask special modules
> or special kernel config option or to be root. There is way to do what you
> want without any of this requirement and thus that should be what you aim
> for.

Except again you're looking at this from the lens that the KMD is 
working perfectly.  We use umr (our debugger) to debug the kernel driver 
itself.  That means you need to be able to read/write MMIO registers, 
peek at VRAM, decode VM addresses, read rings, etc...

Since we already have an entire list of "security breaches" we might as 
well make use of them for UMD debugging too.  Again, you're not going to 
give random logins access to umr on your machine.  I mean in reality you 
wouldn't do that anyways for UMD tasks (you can easily lock up a GPU 
from a user task with no privileges...).

> My design do not need to get the reverse mapping at all that is my point.
> No need to engage the iommu folks no need to ask them for something as
> you have all the information from inside the amdgpu driver.

Which again works iff you're debugging UMD only.

>> Adding drm support to allow another process to GEM_MAP BOs (and a search
>> ioctl) might work but seems like a lot more work (and will likely reduce
>> performance) than the tracer and has the same limitation.  And ultimately we
>> find direct memory access useful in NPI work so that's unlikely to be
>> removed.
> 
> You have not proof that it would be slower and i outline the special file
> idea that avoid any ioctl.

By "slower" I don't mean the syscall for ioctl.  I mean the housekeeping 
we'd have to do in the driver on top of normal TTM housekeeping.  Unless 
you can nop it all out by default (which I suspect you can) it will get 
NAK'ed immediately by the maintainers.

Setting aside the fact of adding 500+ lines of code so you could attach 
to other libdrm processes and rifle through their BOs is code they have 
to maintain.

>> Thanks for your time Jerome.  I do understand where you're coming from but
>> I'm not sure a drm update is both politically or technically feasible and we
>> need this functionality (limited though it is) sooner than later.
> 
> You have to understand that kernel is not about compromising design so that
> people can reach their schedule. Sane design do matter and if sane design
> require lot of work than you should size your team accordingly to face the
> challenges.

Except the real world doesn't work that way.  And we have legitimate 
reasons for being able to peek/poke at the hardware.  Philosophies likes 
yours lead companies to write private debug tools and not share them 
with the public.  Whereas we're trying to come up with a debug tool (and 
kernel module) that is practically safe and effective at its job without 
overly mucking about in the kernel.

You can't legitimately debug hardware from a userspace tool without 
having some knobs/etc that would otherwise be ill advised to give to 
everyone.  In a normal distribution your users run unprivileged and 
wouldn't have umr installed.  So they have zero access to any of our 
debugfs facilities and can only talk to the device via libdrm (via 
GL/VK/etc).

I still haven't seen an explanation for why having root-only access to 
the device is bad other than "it's insane!"  At the point you can run 
privileged processes you can simply compile and install a tainted kernel 
module to do the same thing.

Ideally, though if we went this route it'd be a drm/ttm change not an 
amdgpu change since I can't believe the other vendors wouldn't be able 
to make use of this functionality either.

> What you want to do can be done with very little code and no change outside
> amdgpu kernel driver so i do not see any reason to not do so.

Maybe Alex or Christian can weigh in at this point?

I'm not saying your proposal isn't possible I just don't have enough 
clarity on how I'd implement that nor enough confidence that it would be 
materially any better (keep in mind we are NOT removing our debugfs 
facilities).

Tom
