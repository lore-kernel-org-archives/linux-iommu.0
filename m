From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] Independent use of IOMMU groups
Date: Thu, 05 Nov 2015 10:54:39 -0700
Message-ID: <1446746079.8831.82.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

We have a couple things in-flight that are trying to make use of IOMMU
groups, independent of the rest of the IOMMU API.  One is the proposed
VFIO No-IOMMU hack that will create an IOMMU group for a non-IOMMU
backed device in order to make it operate within vfio and exposed via
vfio-pci:

https://lkml.org/lkml/2015/11/4/437

This has all the caveats that DMA for the device is unsafe and we taint
the kernel, but at least it provides users that are already doing this
thing with a more featureful interface without duplicating tons of code
into UIO and it gives them a consistent device model to easily move to
when an IOMMU is supported.

When we do this, vfio creates the IOMMU group for the device when it
binds to the vfio bus driver (vfio-pci) and removes it when unbound.
For that period, we own the device and don't interact with the IOMMU API
for any sort of mapping.

Another idea that's floating around is that vfio could actually expose
virtual devices to a user, think for instance vGPUs in a non-SR-IOV
scenario.  A struct device is created where portions of the device are
backed directly by some subset of a physical device while other parts
may be emulated by the vfio bus driver.  The virtual device needs an
IOMMU group to participate in the vfio framework, but the platform
itself doesn't necessarily need an IOMMU.  In this case isolation of the
virtual device might be provided by policing of the user programming of
the device and MMU control on the physical device itself.  The vfio
IOMMU backend for such a device would use device specific programming
rather than making use of the IOMMU API.

The IOMMU group address space is global, so creating these groups will
necessarily cause them to appear in /sys/kernel/iommu_groups/, so I want
to make sure there are no objections to these sorts of uses.  In one
scenario the device is real, but the IOMMU group is only present when
bound to a driver that knows the usage restrictions, in the other the
device is virtual, created by the driver itself, which is therefore
aware of its restrictions.  Comments?

A question I'd expect to be asked is why not create a new bus_type and
register an IOMMU for it?  In the no-iommu case, the bus for the device
already exists and does not have an IOMMU present.  Registering an IOMMU
for that bus_type risks other devices on that bus_type attempting to do
real IOMMU API tasks.  In the virtual case, this is more reasonable
since all the virtual devices could be children on a new bus_type, but
the overhead of trying to mate a general purpose API to a device that
really only requires very special purpose mappings seems like
unnecessary overhead.

If there are any gotchas that I'm missing, please let me know.  Thanks,

Alex
