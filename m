From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Wed, 2 Aug 2017 00:42:14 -0400
Message-ID: <20170802044214.GA6285@gmail.com>
References: <20170801172523.GA3443@gmail.com>
	<30eb1ecb-c86f-4d3b-cd49-e002f46e582d@amd.com>
	<20170801180415.GB3443@gmail.com>
	<483ecda0-2977-d2ea-794c-320e429d7645@amd.com>
	<20170801190259.GC3443@gmail.com>
	<42c5fe2b-f179-cb71-03d3-7ae991543edb@amd.com>
	<20170801195556.GD3443@gmail.com>
	<77e557d2-aa75-46c4-88a7-cca5448ea08e@amd.com>
	<20170801210105.GE3443@gmail.com>
	<2cd345ee-d5ad-1ad7-508a-86225e65621c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2cd345ee-d5ad-1ad7-508a-86225e65621c-5C7GfCeVMHo@public.gmane.org>
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

On Tue, Aug 01, 2017 at 05:38:05PM -0400, Tom St Denis wrote:
> On 01/08/17 05:01 PM, Jerome Glisse wrote:
> > > Unless you can nop that in a config invariant fashion (like you can f=
or
> > > tracers) that's a NAK from the get go.  And we'd need to buffer them =
to be
> > > practical since you might run the debugger out of sync with the appli=
cation
> > > (e.g. app hangs then you fire up umr to see what's going on).
> > =

> > Again when you start snooping you can access all the existing bo
> > informations and start monitoring event to keep userspace in sync
> > with any changes from the first snapshot you take.
> =

> You'd have to be able to do this post-mortem as well though.  And ideally=
 I
> don't really care about getting live updates (at least not yet though...).
> The way it would work now is you read the ring and get IB pointers which =
you
> then have to fetch and decode.  So all I care about now is what does the
> pointer point to right now.
> =

> Though at this point I'm decoding a GPUVM address not a DMA nor physical
> address so I then have to decode the GPUVM address "somehow" (assuming I
> don't use my "unsafe" methods) then I can proceed to look up the buffer
> based on the DMA address.

Everything is a GPU virtual address in first place. Then it is translated
to either GPU VRAM address or bus address. IIRC some of the DMA engine do
not use GPU VM but directly bus address and VRAM but this can also fit in
what i am proposing. See at the end.

> =

> (* being notified of changes might be useful later on.  We do have more
> grandiose plans to integrate umr into gdb/etc functionality).
> =

> > So you want to add something to the kernel just for a corner case ie
> > when debugging GPU hang. Not for more generic tools. I don't think
> > that the work needed for that is worth the effort just for such a
> > small usecase.
> =

> You can't really read GPU data when it's in flight anyways.  Ask a GFX
> hardware person about reading registers when the GPU is running and they'=
ll
> say "NAK."
> =

> So even if the application hasn't crashed if you want to inspect things y=
ou
> need to halt the waves (effectively halting the GPU).

I thought you were also doing a tracing/perf monitor tools so i wrongly
assume that you wanted thing to keep going.


> > > >     - GPU device memory is not necessary accessible (due to PCIE ba=
r size
> > > >       limit i know that there is patches to allow to remap all GPU =
memory).
> > > =

> > > We have ways of accessing all of VRAM from basic MMIO accesses :)
> > =

> > Yes and it is insane to have to write VRAM address in one register and
> > read the VRAM value in another, insane from tedious point of view :)
> =

> I'd think double buffering **all** of VRAM in case you might want parts of
> it to be more insane.

Not saying all vram only thing that is accessed think of it as temporary
bounce buffer of couple mega byte.

[...]

> > > Except again you're looking at this from the lens that the KMD is wor=
king
> > > perfectly.  We use umr (our debugger) to debug the kernel driver itse=
lf.
> > > That means you need to be able to read/write MMIO registers, peek at =
VRAM,
> > > decode VM addresses, read rings, etc...
> > =

> > And you can do that with the scheme i propose.
> =

> Not everything is a BO though ...

What isn't a bo ? Everything inside amdgpu driver is an amdgpu_bo unless i =
missed
something. I am ignoring amdkfd here as this one is easy.

[...]

> > I was saying that your design is restrictive and can not be use for oth=
er
> > thing and thus it is hard to justify the work for a single use case.
> =

> I'm not married to my trace idea.  It just happens to work for user
> applications and is better than nothing (and is very unobtrusive).  If you
> want to take a crack at a proper interface that accomplishes the same (and
> more) by all means I'll gladly adopt using it.
> =

> Just keep in mind we have no plans to remove our existing debugfs
> facilities.
> =

> > Well maybe i will code it down latter today on the train back home.
> =

> Good luck Fermat.  :-)

So here it is

https://cgit.freedesktop.org/~glisse/linux/log/?h=3Damdgpu-debug

most of the plumbing is there, i am puzzle by the absence of an obvious
lock that protect the virtual address range from concurrent insert/remove.

I haven't finished the read method but what is missing is accessing ttm.tt
object if any or falling back to mmio read otherwise. Probably couple hundr=
ed
line of code to add this.

It is untested as i don't have hardware.

J=E9r=F4me
