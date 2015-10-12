From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] mmput: use notifier chain to call subsystem exit
	handler.
Date: Mon, 12 Oct 2015 13:41:31 -0400
Message-ID: <20151012174130.GA8037@gmail.com>
References: <20140701210620.GL26537@8bytes.org>
	<20140701213208.GC3322@gmail.com> <20140703183024.GA3306@gmail.com>
	<20140703231541.GR26537@8bytes.org>
	<019CCE693E457142B37B791721487FD918085329@storexdag01.amd.com>
	<20140707101158.GD1958@8bytes.org>
	<1404729783.31606.1.camel@tlv-gabbay-ws.amd.com>
	<20140708080059.GF1958@8bytes.org>
	<20140708170355.GA2469@gmail.com>
	<1444590209.92154.116.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444590209.92154.116.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jakumar-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldunning-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mgorman-l3A5Bk7waGM@public.gmane.org" <mgorman-l3A5Bk7waGM@public.gmane.org>, "jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <sgutti-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Bridgman,
	John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <mhairgrove-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <cabuschardt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <dpoole-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Cornwall,
	Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "Lewycky, Andrew" <Andrew.Lewycky-5C7GfCeVMHo@public.gmane.org>, "SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <SCheung-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu@lists.>
List-Id: iommu@lists.linux-foundation.org


Note that i am no longer actively pushing this patch serie but i believe the
solution it provides to be needed in one form or another. So I still think
discussion on this to be useful so see below for my answer.

On Sun, Oct 11, 2015 at 08:03:29PM +0100, David Woodhouse wrote:
> On Tue, 2014-07-08 at 13:03 -0400, Jerome Glisse wrote:
> > =

> > Now regarding the device side, if we were to cleanup inside the file re=
lease
> > callback than we would be broken in front of fork. Imagine the followin=
g :
> >   - process A open device file and mirror its address space (hmm or kfd)
> >     through a device file.
> >   - process A forks itself (child is B) while having the device file op=
en.
> >   - process A quits
> > =

> > Now the file release will not be call until child B exit which might in=
finite.
> > Thus we would be leaking memory. As we already pointed out we can not f=
ree the
> > resources from the mmu_notifier >release callback.
> =

> So if your library just registers a pthread_atfork() handler to close
> the file descriptor in the child, that problem goes away? Like any
> other "if we continue to hold file descriptors open when we should
> close them, resources don't get freed" problem?


I was just pointing out existing device driver usage pattern where user
space open device file and do ioctl on it without necessarily caring
about the mm struct.

New usecase where device actually run thread against a specific process
mm is different and require proper synchronization as file lifetime is
different from process lifetime in many case when fork is involve.

> =

> Perhaps we could even handled that automatically in the kernel, with
> something like an O_CLOFORK flag on the file descriptor. Although
> that's a little horrid.
> =

> You've argued that the amdkfd code is special and not just a device
> driver. I'm not going to contradict you there, but now we *are* going
> to see device drivers doing this kind of thing. And we definitely
> *don't* want to be calling back into device driver code from the
> mmu_notifier's .release() function.

Well that's the current solution, call back into device driver from the
mmu_notifer release() call back. Since changes to mmu_notifier this is
a workable solution (thanks to mmu_notifier_unregister_no_release()).

> =

> I think amdkfd absolutely is *not* a useful precedent for normal device
> drivers, and we *don't* want to follow this model in the general case.
> =

> As we try to put together a generic API for device access to processes'
> address space, I definitely think we want to stick with the model that
> we take a reference on the mm, and we *keep* it until the device driver
> unbinds from the mm (because its file descriptor is closed, or
> whatever).

Well i think when a process is kill (for whatever reasons) we do want to
also kill all device threads at the same time. For instance we do not want
to have zombie GPU threads that can keep running indefinitly. This is why
use mmu_notifier.release() callback is kind of right place as it will be
call once all threads using a given mm are killed.

The exit_mm() or do_exit() are also places from where we could a callback
to let device know that it must kill all thread related to a given mm.

>
> Perhaps you can keep a back door into the AMD IOMMU code to continue to
> do what you're doing, or perhaps the explicit management of off-cpu
> tasks that is being posited will give you a sane cleanup path that
> *doesn't* involve the IOMMU's mmu_notifier calling back to you. But
> either way, I *really* don't want this to be the way it works for
> device drivers.

So at kernel summit we are supposedly gonna have a discussion about device
thread and scheduling and i think device thread lifetime belongs to that
discussion too. My opinion is that device threads must be kill when a
process quits.


> > One hacky way to do it would be to schedule some delayed job from =

> > >release callback but then again we would have no way to properly =

> > synchronize ourself with other mm destruction code ie the delayed job =

> > could run concurently with other mm destruction code and interfer
> > badly.
> =

> With the RCU-based free of the struct containing the notifier, your
> 'schedule some delayed job' is basically what we have now, isn't it?
> =

> I note that you also have your *own* notifier which does other things,
> and has to cope with being called before or after the IOMMU's notifier.
> =

> Seriously, we don't want device drivers having to do this. We really
> need to keep it simple.

So right now in HMM what happens is that device driver get a callback as
a result of mmu_notifier.release() and can call the unregister functions
and device driver must then schedule through whatever means a call to the
unregister function (can be a workqueue or other a kernel thread).

Basicly i am hidding the issue inside the device driver until we can agree
on a common proper way to do this.

Cheers,
J=E9r=F4me
