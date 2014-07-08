From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
	handler.
Date: Tue, 8 Jul 2014 13:03:56 -0400
Message-ID: <20140708170355.GA2469@gmail.com>
References: <20140701110018.GH26537@8bytes.org>
	<20140701193343.GB3322@gmail.com>
	<20140701210620.GL26537@8bytes.org>
	<20140701213208.GC3322@gmail.com> <20140703183024.GA3306@gmail.com>
	<20140703231541.GR26537@8bytes.org>
	<019CCE693E457142B37B791721487FD918085329@storexdag01.amd.com>
	<20140707101158.GD1958@8bytes.org>
	<1404729783.31606.1.camel@tlv-gabbay-ws.amd.com>
	<20140708080059.GF1958@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140708080059.GF1958-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mgorman-l3A5Bk7waGM@public.gmane.org" <mgorman-l3A5Bk7waGM@public.gmane.org>, "jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Bridgman,
	John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Cornwall,
	Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "Lewycky, Andrew" <Andrew.Lewycky-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu@lists>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 08, 2014 at 10:00:59AM +0200, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> On Mon, Jul 07, 2014 at 01:43:03PM +0300, Oded Gabbay wrote:
> > As Jerome pointed out, there are a couple of subsystems/drivers who
> > don't rely on file descriptors but on the tear-down of mm struct, e.g.
> > aio, ksm, uprobes, khugepaged
> =

> What you name here is completly different from what HSA offers. AIO,
> KSM, uProbes and THP are not drivers or subsystems of their own but
> extend existing subsystems. KSM and THP also work in the background and
> do not need a fd to setup things (in some cases only new flags to
> existing system calls).
> =

> What HSA does is offering a new service to userspace applications.  This
> either requires new system calls or, as currently implemented, a device
> file which can be opened to use the services.  In this regard it is much
> more similar to VFIO or KVM, which also offers a new service and which
> use file descriptors as their interface to userspace and tear everything
> down when the fd is closed.

Thing is we are closer to AIO than to KVM. Unlike kvm, hmm stores a pointer
to its structure inside mm_struct and those we already add ourself to the
mm_init function ie we do have the same lifespan as the mm_struct not the
same lifespan as a file.

Now regarding the device side, if we were to cleanup inside the file release
callback than we would be broken in front of fork. Imagine the following :
  - process A open device file and mirror its address space (hmm or kfd)
    through a device file.
  - process A forks itself (child is B) while having the device file open.
  - process A quits

Now the file release will not be call until child B exit which might infini=
te.
Thus we would be leaking memory. As we already pointed out we can not free =
the
resources from the mmu_notifier >release callback.

One hacky way to do it would be to schedule some delayed job from >release
callback but then again we would have no way to properly synchronize ourself
with other mm destruction code ie the delayed job could run concurently with
other mm destruction code and interfer badly.

So as i am desperatly trying to show you, there is no other clean way to fr=
ee
resources associated with hmm and same apply to kfd. Only way is by adding a
callback inside mmput.


Another thing you must understand, the kfd or hmm can be share among differ=
ent
devices each of them having their own device file. So one and one hmm per mm
struct but several device using that hmm structure. Obviously the lifetime =
of
this hmm structure has first tie to mm struct, all ties to device file are
secondary and i can foresee situation where their would be absolutely no de=
vice
file open but still an hmm for mm struct (think another process is using the
process address through a device driver because it provide some api for tha=
t).


I genuinely fails to see how to do it properly using file device as i said
the file lifespan is not tie to an mm struct while the struct we want to
cleanup are tie to the mm struct.

Again hmm or kfd is like aio. Not like kvm.

Cheers,
J=E9r=F4me

> =

> > Jerome and I are saying that HMM and HSA, respectively, are additional
> > use cases of binding to mm struct. If you don't agree with that, than I
> > would like to hear why, but you can't say that no one else in the kernel
> > needs notification of mm struct tear-down.
> =

> In the first place HSA is a service that allows applications to send
> compute jobs to peripheral devices (usually GPUs) and read back the
> results. That the peripheral device can access the process address space
> is a feature of that service that is handled in the driver.
> =

> > As for the reasons why HSA drivers should follow aio,ksm,etc. and not
> > other drivers, I will repeat that our ioctls operate on a process
> > context and not on a device context. Moreover, the calling process
> > actually is sometimes not aware on which device it runs!
> =

> KFD can very well hide the fact that there are multiple devices as the
> IOMMU drivers usually also hide the details about how many IOMMUs are in
> the system.
> =

> =

> 	Joerg
> =

> =
