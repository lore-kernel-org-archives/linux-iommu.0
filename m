From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 22 Oct 2018 09:35:42 -0600
Message-ID: <20181022153542.GG26762@jcrouse-lnx.qualcomm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11f88122-afd3-a34c-3cd4-db681bf5498b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 22, 2018 at 12:50:56PM +0100, Robin Murphy wrote:
> On 22/10/2018 07:53, Tian, Kevin wrote:
> >>From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> >>Sent: Saturday, October 20, 2018 2:12 AM
> >>
> >>This is a first prototype adding auxiliary domain support to Arm SMMUv3,
> >>following Lu Baolu's latest proposal for IOMMU aware mediated devices
> >>[1]. It works, but the attach() API still doesn't feel right. See (2)
> >>below.
> >>
> >>Patch 1 adapts iommu.c to the current proposal for auxiliary domains.
> >>Patches 2-4 rework the PASID allocator to make it usable for SVA and
> >>AUXD simultaneously. Patches 5-6 add AUXD support to SMMUv3.
> >>
> >>
> >>When a device can have multiple address space, for instance with PCI
> >>PASID, an auxiliary domain (AUXD) is the IOMMU representation of one
> >>address space. I distinguish auxiliary from "main" domain, which
> >>represents the non-PASID address space but also (at least for SMMUv3)
> >>the whole device context, PASID tables etc.
> >
> >I'd like to clarify a bit. :-)
> >
> >a domain can always represent one or more address spaces, where an
> >address space could be for IOVA or GPA and/or other address spaces for
> >SVA. Address spaces may be chained together in so-called nested mode.
> >
> >a domain can be associated with a full device (in BDF granular), and/or
> >with a partition of a device (say in PASID granular). In the former case,
> >the domain becomes the master (or primary) domain of the device. In
> >the latter case, the domain becomes the auxiliary domain of the device.
> >
> >vendor domain structure may include vendor-specific states which
> >are applied to device context at attach time, e.g. PASID table (SMMUv3)
> >if representing as master domain, or PASID value (VT-d scalable mode)
> >if representing as auxiliary domain.
> >
> >so the domain definition is never changed with the introduction of
> >AUXD. 'auxiliary' is a per-device attribute which takes effect when at
> >domain attach time. A domain is perfectly sane to represent as a
> >master domain to deviceA and an auxiliary domain to deviceB at the
> >same time (say when device A and a mdev on deviceB are assigned to
> >same VM), while supporting one or more address spaces.
> 
> To me, that sounds like a very good argument for having separate
> "attach as primary domain" and "attach as aux domain" APIs. Say a
> driver wants to use multiple aux domains itself to isolate
> logically-separate transaction streams, but still also needs to
> control the main domain for transactions without PASID (interrupts?)
> - having to juggle some invisible device state around multiple
> iommu_{attach,detach}_group() calls which look identical but are
> expected to behave differently at runtime sounds like a recipe for
> unmaintainable code.
> 
> I don't think it's necessarily safe to assume that
> one-struct-device-per-PASID will be the only usage model.

This feels exactly like the QCOM GPU model - multiple aux domains
for individual process pagetables but the main domain for TTBR1
(global) allocations.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
