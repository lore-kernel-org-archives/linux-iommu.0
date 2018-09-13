From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
Date: Thu, 13 Sep 2018 07:15:54 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191301CAC@SHSMSX101.ccr.corp.intel.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-2-jean-philippe.brucker@arm.com>
	<bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
	<03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
	<ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
	<f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
	<2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
	<65e7accd-4446-19f5-c667-c6407e89cfa6@arm.com>
	<5bbc0332-b94b-75cc-ca42-a9b196811daf@amd.com>
	<20180907142504.5034351e@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180907142504.5034351e@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson@>
List-Id: iommu@lists.linux-foundation.org

> From: Jacob Pan [mailto:jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Saturday, September 8, 2018 5:25 AM
> > > iommu-sva expects everywhere that the device has an iommu_domain,
> > > it's the first thing we check on entry. Bypassing all of this would
> > > call idr_alloc() directly, and wouldn't have any code in common
> > > with the current iommu-sva. So it seems like you need a layer on
> > > top of iommu-sva calling idr_alloc() when an IOMMU isn't present,
> > > but I don't think it should be in drivers/iommu/
> >
> > In this case I question if the PASID handling should be under
> > drivers/iommu at all.
> >
> > See I can have a mix of VM context which are bound to processes (some
> > few) and VM contexts which are standalone and doesn't care for a
> > process address space. But for each VM context I need a distinct
> > PASID for the hardware to work.

I'm confused about VM context vs. process. Is VM referring to Virtual
Machine or something else? If yes, I don't understand the binding part
- what VM context is bound to (host?) process?

> >
> > I can live if we say if IOMMU is completely disabled we use a simple
> > ida to allocate them, but when IOMMU is enabled I certainly need a
> > way to reserve a PASID without an associated process.
> >
> VT-d would also have such requirement. There is a virtual command
> register for allocate and free PASID for VM use. When that PASID
> allocation request gets propagated to the host IOMMU driver, we need to
> allocate PASID w/o mm.
> 

VT-d is a bit different. In host side, PASID allocation always happens in
Qemu's context, so those PASIDs are recorded with Qemu process, 
though the entries may point to guest page tables instead of host mm
of Qemu.

Thanks
Kevin
