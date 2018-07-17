From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Date: Tue, 17 Jul 2018 01:47:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439C9DAB8@SHSMSX104.ccr.corp.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
	<07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <07fe2e3f-4f4a-58db-ee2a-2620183d93b2-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

> From: Jean-Philippe Brucker
> Sent: Monday, July 16, 2018 6:52 PM
> On 16/07/18 07:49, Lu Baolu wrote:
> > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > 'scalable mode', which enables PASID-granular translations for first
> > level, second level, nested and pass-through modes. The vt-d scalable
> > mode is the key ingredient to enable Scalable I/O Virtualization
> > (Scalable IOV) [2] [3], which allows sharing a device in minimal
> > possible granularity (ADI - Assignable Device Interface). It also
> > includes all the capabilities required to enable Shared Virtual
> > Addressing (SVA). As a result, previous Extended Context (ECS) mode is
> > deprecated (no production ever implements ECS).
> >
> > Each scalable mode pasid table entry is 64 bytes in length, with
> > fields point to the first level page table and the second level page
> > table. The PGTT (Pasid Granular Translation Type) field is used by
> > hardware to determine the translation type.
> 
> Looks promising! Since the 2nd level page tables are in the PASID entry, the
> hypervisor traps guest accesses to the PASID tables instead of passing through the
> whole PASID directory? Are you still planning to use the VFIO BIND_PASID_TABLE
> interface in this mode, or a slightly different one for individual PASIDs?

You are right. For Intel VT-d, we don't need to give the access to the whole guest
PASID table in Scalable Mode. However, VFIO BIND_PASID_TABLE may still needed
for other vendor. So it may still in the proposed list. This would be covered in the
new vSVA patchset from Jacob and me.

Thanks,
Yi Liu
