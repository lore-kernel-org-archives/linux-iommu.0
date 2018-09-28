From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v3 02/10] iommu/sva: Bind process address spaces to devices
Date: Fri, 28 Sep 2018 01:14:17 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1913438B3@SHSMSX101.ccr.corp.intel.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-3-jean-philippe.brucker@arm.com>
	<cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4@linux.intel.com>
	<7cbd503a-c79e-3c40-7388-ce6c23f7f536@arm.com>
	<20180926110103.45b57f75@jacob-builder>
	<79c0e0e1-691e-b8e1-0e68-21876135d2ab@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <79c0e0e1-691e-b8e1-0e68-21876135d2ab-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, September 27, 2018 11:06 PM
> 
> On 26/09/2018 19:01, Jacob Pan wrote:
> > On Mon, 24 Sep 2018 13:07:47 +0100
> > Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> >
> >> On 23/09/2018 04:05, Lu Baolu wrote:
> >> > Hi,
> >> >
> >> > On 09/21/2018 01:00 AM, Jean-Philippe Brucker wrote:
> >> >> Add bind() and unbind() operations to the IOMMU API. Bind()
> >> >> returns a PASID that drivers can program in hardware, to let their
> >> >> devices access an mm. This patch only adds skeletons for the
> >> >> device driver API, most of the implementation is still missing.
> >> >
> >> > Is it possible that a malicious process can unbind a pasid which is
> >> > used by another normal process?
> >>
> >> Yes, it's up to the device driver that calls unbind() to check that
> >> the caller is allowed to unbind this PASID. We can't do it ourselves
> >> since unbind() could also be called from a kernel thread for example
> >> from a cleanup function in some workqueue, outside the context of the
> >> process to unbind.
> 
> Actually I'm not too concerned about a process unbinding another one,
> since in general only the kernel will hold the PASID values. Userspace
> shouldn't even need to see them, so issuing unbind() with the wrong
> PASID isn't an easy mistake.
> 

well, it depends on which scenario is talked here.

for native SVA with device driver in kernel, your description is correct.

for native SVA with device driver in user space, then user space needs to
see/hold PASIDs and program them to device specific register.

for virtual SVA (vtd case), Qemu needs to see/hold PASIDs and pass to 
guest upon any PASID allocation request thru a PV channel, as you just 
saw in another thread. :-)

Thanks
Kevin
