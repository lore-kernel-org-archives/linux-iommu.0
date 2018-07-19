From: Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Date: Wed, 18 Jul 2018 17:47:02 -0700
Message-ID: <20180718174702.31e1c1d6@jacob-builder>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
	<07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <07fe2e3f-4f4a-58db-ee2a-2620183d93b2-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 16 Jul 2018 11:51:57 +0100
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi,
> 
> On 16/07/18 07:49, Lu Baolu wrote:
> > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > 'scalable mode', which enables PASID-granular translations for
> > first level, second level, nested and pass-through modes. The
> > vt-d scalable mode is the key ingredient to enable Scalable I/O
> > Virtualization (Scalable IOV) [2] [3], which allows sharing a
> > device in minimal possible granularity (ADI - Assignable Device
> > Interface). It also includes all the capabilities required to
> > enable Shared Virtual Addressing (SVA). As a result, previous
> > Extended Context (ECS) mode is deprecated (no production ever
> > implements ECS).
> > 
> > Each scalable mode pasid table entry is 64 bytes in length, with
> > fields point to the first level page table and the second level
> > page table. The PGTT (Pasid Granular Translation Type) field is
> > used by hardware to determine the translation type.  
> 
> Looks promising! Since the 2nd level page tables are in the PASID
> entry, the hypervisor traps guest accesses to the PASID tables
> instead of passing through the whole PASID directory? Are you still
> planning to use the VFIO BIND_PASID_TABLE interface in this mode, or
> a slightly different one for individual PASIDs?
> 
Since we deprecated ECS mode, there is no need for VT-d to bind guest
pasid table in scalable mode. We are planning on adding another flag for
bind guest pasid and guest CR3, Perhaps call it
VFIO_IOMMU_BIND_GUEST_SVA.
> Thanks,
> Jean
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
