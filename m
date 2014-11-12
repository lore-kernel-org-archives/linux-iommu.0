From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 05/13] KVM: Update IRTE according to guest interrupt
	configuration changes
Date: Wed, 12 Nov 2014 10:11:24 -0700
Message-ID: <1415812284.16601.372.camel@ul30vt.home>
References: <E959C4978C3B6342920538CF579893F00226EF05@SHSMSX104.ccr.corp.intel.com>
	<5461EC99.1000101@redhat.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0ABDBB25@SHSMSX104.ccr.corp.intel.com>
	<546324F4.8010002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <546324F4.8010002-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2014-11-12 at 10:14 +0100, Paolo Bonzini wrote:
> 
> On 12/11/2014 04:42, Zhang, Yang Z wrote:
> > Personally, I think this feature will be helpful to the legacy device
> > assignment. Agree, vfio is the right solution for future feature
> > enabling. But the old kvm without the good vfio supporting is still
> > used largely today. The user really looking for this feature but they
> > will not upgrade their kernel. It's easy for us to backport this
> > feature to old kvm with the legacy device assignment, but it is
> > impossible to backport the whole vfio.
> 
> You can certainly backport these patches to distros that do not have
> VFIO.  But upstream we should work on VFIO first.  VFIO has feature
> parity with legacy device assignment, and adding a new feature that is
> not in VFIO would be a bad idea.

Thanks Paolo, I agree.  We should design the interfaces for VFIO since
we expect legacy KVM assignment to be deprecated and eventually removed.
I think that some of the platform device work for ARM's IRQ forwarding
should probably be leveraged for this interface.  IRQ forwarding
effectively allows level triggered interrupts to be handled as edge,
eliminating the mask/unmask overhead and EOI path entirely.  To do this
through VFIO they make use of the KVM-VFIO device to register the device
and set attributes for the forwarded IRQ.  This enables KVM to use the
VFIO external user interfaces to acquire a VFIO device reference and
access the struct device.  From there it can do some IRQ manipulation on
the device to reconfigure how the host handles the interrupt.  Ideally
we could use the same base KVM-VFIO device interface interface, perhaps
with different attributes, and obviously with different architecture
backing.  Thanks,

Alex
