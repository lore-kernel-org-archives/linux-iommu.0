From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Tue, 1 Aug 2017 14:04:16 -0400
Message-ID: <20170801180415.GB3443@gmail.com>
References: <8379cf5a-7539-e221-c678-20f617fb4337@amd.com>
	<20170801172523.GA3443@gmail.com>
	<30eb1ecb-c86f-4d3b-cd49-e002f46e582d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <30eb1ecb-c86f-4d3b-cd49-e002f46e582d-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 01, 2017 at 01:32:35PM -0400, Tom St Denis wrote:
> On 01/08/17 01:25 PM, Jerome Glisse wrote:
> > On Tue, Aug 01, 2017 at 06:07:48AM -0400, Tom St Denis wrote:
> > > Hi,
> > > =

> > > We're working on a user space debugger for AMDGPU devices and are try=
ing to
> > > figure out a "proper" way of taking mapped pages and converting them =
back to
> > > physical addresses so the debugger can read memory that was sent to t=
he GPU.
> > > =

> > > The debugger largely operates at arms length from the application bei=
ng
> > > debugged so it has no knowledge of the buffers other than which PCI d=
evice
> > > mapped it and the mapped address.
> > =

> > There is your issue, you should reconsider your design. You should add a
> > debuging/tracing API to the amdgpu kernel driver that allow one process
> > to snoop on another process buffers. It would be a lot more realistic u=
ser
> > space interface.
> =

> It's funny you should say that:
> =

> https://lists.freedesktop.org/archives/amd-gfx/2017-August/011653.html
> =

> That approach works but it's less than ideal for several reasons.
> =

> Another angle is to add a debugfs interface into TTM so we can search the=
ir
> page tables.  But again that would only work for pages mapped through a T=
TM
> interface.  Anything mapped inside the driver with its own pci_alloc_*()
> wouldn't be searchable/traceable here.  So at every single place we would
> have to trace/log/etc the pair.

You miss-understood what i mean. The patch you are pointing too is wrong.
The kind of API i have in mind is high level not low level. You would
register with the amdgpu kernel driver as a snooper for a given process
or file descriptor. This would allow you to get list of all gem objects
of the process you are snooping. From there you could snap shot those
gem object on listen on event on those. You could also ask to listen on
GPU command submission and get event when that happen. No need to expose
complex API like you are trying to do. Something like:

struct amdgpu_snoop_process_ioctl {
	uint32_t	pid;
};

struct amdgpu_snoop_bo_info {
	uint32_t	handle;
	uint32_t	size;
	uint64_t	flags;
	...
};

struct amdgpu_snoop_list_bo_ioctl {
	uint32_t			nbos;
	uint32_t			mbos;
	struct amdgpu_snoop_bo_info	*bos; // bos[mbos] in size
};

struct amdgpu_snoop_snapshot_bo {
	uint32_t	*uptr;
	uint32_t	handle;
	uint32_t	offset;
	uint32_t	size;
};

struct amdgpu_snoop_cmd {
	uint32_t	size;
	uint32_t	*uptr;
};

...

You would need to leverage thing like uevent to get event when something
happen like a bo being destroy or command submission ...


> > > We also use the debugger to read back kernel programmed buffers (ring
> > > buffers and the like) so we really need a kernel level solution.
> > =

> > Not going to happen, this would be like /dev/mem on steroid and a big
> > security risk.
> =

> Not looking to rehash old debates but from our point of view a user with
> read/write access to debugfs can already do "bad things (tm)" so it's a m=
oot
> point (for instance, they could program an SDMA job on the GPU to read/wr=
ite
> anywhere in memory...).

That's is wrong and it should not be allowed ! You need to fix that.


> > > As a prototype I put a trace point in the AMDGPU driver when pci_map_=
page()
> > > is called which preserves the physical and dma address and that works=
 but
> > > obviously is a bit of a hack and doesn't work if pages are mapped bef=
ore the
> > > trace is enabled.
> > > =

> > > Ideally, some form of debugfs interface would be nice.
> > > =

> > > Is there any sort of interface already I can take advantage of?  I've=
 tried
> > > enabling the map/unmap tracepoints before loading amdgpu and it produ=
ced no
> > > traffic in the trace file.
> > =

> > I think you need to reconsider how to achieve your goal. It is a lot mo=
re
> > sensefull to add new API to amdgpu driver than asking kernel to provide=
 you
> > with access to random physical memory.
> =

> We already have physical memory access (through /dev/mem or our own
> /dev/fmem clone).  The issue is translating bus addresses.  With the IOMMU
> enabled addresses programmed into the GPU are not physical anymore and the
> debugger cannot read GPU related packets.

CONFIG_STRICT_DEVMEM is enabled by many distributions so /dev/mem is root
only and even when root there are restrictions. What you are asking for
is insane.

> =

> The existing tracer patch "works" but it's not ideal and the maintainers =
of
> the AMDGPU driver are legitimately desiring a better solution.

Again re-design what you are trying to do. There is no legitimate need to
track individual page mapping. All you need is access to all buffer object
a process have created and to be inform on anything a process do through
the amdgpu device file.

J=E9r=F4me
