From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] Enable SVM for Intel VT-d
Date: Sun, 11 Oct 2015 16:48:31 +0300
Message-ID: <CAFCwf11gkwGaqJ+Rtbp6Roo3GzKJdXeTp189pJSGattY8POCjA@mail.gmail.com>
References: <1444348223.92154.22.camel@infradead.org>
	<1444483075.92154.98.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444483075.92154.98.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
Cc: intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Barnes,
	Jesse" <jesse.barnes-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Oct 10, 2015 at 4:17 PM, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
>
> On Fri, 2015-10-09 at 00:50 +0100, David Woodhouse wrote:
> > This patch set enables PASID support for the Intel IOMMU, along with
> > page request support.
> >
> > Like its AMD counterpart, it exposes an IOMMU-specific API. I believe
> > we'll have a session at the Kernel Summit later this month in which we
> > can work out a generic API which will cover the two (now) existing
> > implementations as well as upcoming ARM (and other?) versions.
> >
> > For the time being, however, exposing an Intel-specific API is good
> > enough, especially as we don't have the required TLP prefix support on
> > our PCIe root ports and we *can't* support discrete PCIe devices with
> > PASID support. It's purely on-chip stuff right now, which is basically
> > only Intel graphics.
> >
> > The AMD implementation allows a per-device PASID space, and managing
> > the PASID space is left entirely to the device driver. In contrast,
> > this implementation maintains a per-IOMMU PASID space, and drivers
> > calling intel_svm_bind_mm() will be *given* the PASID that they are to
> > use. In general we seem to be converging on using a single PASID space
> > across *all* IOMMUs in the system, and this will support that mode of
> > operation.
>
> The other noticeable difference is the lifetime management of the mm.
> My code takes a reference on it, and will only do the mmput() when the
> driver unbinds the PASID. So the mmu_notifier's .release() method won't
> get called before that.
>
> The AMD version doesn't take that refcount, and its .release() method
> therefore needs to actually call back into the device driver and ensure
> that all access to the mm, including pending page faults, is flushed.
> The locking issues there scare me a little, especially if page faults
> are currently outstanding.
>
> In the i915 case we have an open file descriptor associated with the
> gfx context. When the process dies, the fd is closed and the driver can
> go and clean up after it.
>
> The amdkfd driver, on the other hand, keeps the device-side job running
> even after the process has closed its file descriptor. So it *needs*
> the .release() call to happen when the process exits, as it otherwise
> doesn't know when to clean up.
>
> I am somewhat dubious about that as a design decision. If we're moving
> to a more explicit management of off-cpu tasks with mm access, as is to
> be discussed at the Kernel Summit, then hopefully we can fix that. It's
> a *lot* simpler if we just pin the mm while the device context has
> access to it.
>
> --
> dwmw2
>

Hi David,

There was a whole debate about this issue (amdkfd binding to mm struct
lifespan instead of to fd) when we upstreamed amdkfd, with good
arguments for and against. If you want to understand the reasons, I
suggest reading the following email thread:

https://lists.linuxfoundation.org/pipermail/iommu/2014-July/009005.html

TL;DR, IIRC, the bottom line was that (over-simplified):

1. HSA/amdkfd is not a "classic" device driver, is it performs
operations in context of a process working on multiple devices and
doesn't contain an "instance per device". It's conceptually more like
a subsystem/system call interface then a device driver.

2. It is not a one-of-a-kind in the kernel, as there are other drivers
which use this method.

        Oded
