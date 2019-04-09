From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 00/18] Shared virtual address IOMMU and VT-d support
Date: Tue, 9 Apr 2019 09:33:04 -0700
Message-ID: <20190409093304.459c0bfd@jacob-builder>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190409095623.GB9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190409095623.GB9224-XvqNBM/wLWRrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 9 Apr 2019 12:56:23 +0300
Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Mon, Apr 08, 2019 at 04:59:15PM -0700, Jacob Pan wrote:
> > Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on
> > Intel platforms allow address space sharing between device DMA and
> > applications. SVA can reduce programming complexity and enhance
> > security. This series is intended to enable SVA virtualization,
> > i.e. shared guest application address space and physical device DMA
> > address. Only IOMMU portion of the changes are included in this
> > series. Additional support is needed in VFIO and QEMU (will be
> > submitted separately) to complete this functionality.
> > 
> > To make incremental changes and reduce the size of each patchset.
> > This series does not inlcude support for page request services.
> > 
> > In VT-d implementation, PASID table is per device and maintained in
> > the host. Guest PASID table is shadowed in VMM where virtual IOMMU
> > is emulated.  
> 
> This seems missed the comments I gave you internally.
> 
I didn't include that since the code you commented on is from Jean and
I don't have a strong opinion on either way. I thought I explained that.
Sorry for the miscommunication.

Thanks for your review,

Jacob
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process CR3, FL only|
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |                CR3 in GPA
> >     '-------------'
> > Guest
> > ------| Shadow |--------------------------|--------
> >       v        v                          v
> > Host
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.------------------------------.
> >     |             |   |SL for GPA-HPA, default domain|
> >     |             |   '------------------------------'
> >     '-------------'
> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> > 
> > 
> > This work is based on collaboration with other developers on the
> > IOMMU mailing list. Notably,
> > 
> > [1] [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
> > https://lkml.org/lkml/2019/3/17/124
> > 
> > [2] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by
> > Jean-Philippe Brucker
> > https://www.spinics.net/lists/iommu/msg30639.html
> > 
> > [3] [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation by
> > Lu Baolu https://lkml.org/lkml/2018/11/12/1921
> > 
> > There are roughly three parts:
> > 1. Generic PASID allocator [1] with extension to support custom
> > allocator 2. IOMMU cache invalidation passdown from guest to host
> > 3. Guest PASID bind for nested translation
> > 
> > All generic IOMMU APIs are reused from [1], which has a v7 just
> > published with no real impact to the patches used here. It is worth
> > noting that unlike sMMU nested stage setup, where PASID table is
> > owned by the guest, VT-d PASID table is owned by the host,
> > individual PASIDs are bound instead of the PASID table.
> > 
> > 
> > Jacob Pan (15):
> >   ioasid: Add custom IOASID allocator
> >   ioasid: Convert ioasid_idr to XArray
> >   driver core: add per device iommu param
> >   iommu: introduce device fault data
> >   iommu: introduce device fault report API
> >   iommu: Introduce attach/detach_pasid_table API
> >   iommu/vt-d: Add custom allocator for IOASID
> >   iommu/vt-d: Replace Intel specific PASID allocator with IOASID
> >   iommu: Add guest PASID bind function
> >   iommu/vt-d: Move domain helper to header
> >   iommu/vt-d: Add nested translation support
> >   iommu/vt-d: Add bind guest PASID support
> >   iommu: add max num of cache and granu types
> >   iommu/vt-d: Support flushing more translation cache types
> >   iommu/vt-d: Add svm/sva invalidate function
> > 
> > Jean-Philippe Brucker (1):
> >   drivers core: Add I/O ASID allocator
> > 
> > Liu, Yi L (1):
> >   iommu: Introduce cache_invalidate API
> > 
> > Lu Baolu (1):
> >   iommu/vt-d: Enlightened PASID allocation
> > 
> >  drivers/base/Kconfig        |   7 ++
> >  drivers/base/Makefile       |   1 +
> >  drivers/base/ioasid.c       | 211
> > +++++++++++++++++++++++++++++++++++++ drivers/iommu/Kconfig
> > |   1 + drivers/iommu/dmar.c        |  48 +++++++++
> >  drivers/iommu/intel-iommu.c | 219
> > ++++++++++++++++++++++++++++++++++++-- drivers/iommu/intel-pasid.c
> > | 191 +++++++++++++++++++++++++++++-----
> > drivers/iommu/intel-pasid.h |  24 ++++- drivers/iommu/intel-svm.c
> > | 217 +++++++++++++++++++++++++++++++++++---
> > drivers/iommu/iommu.c       | 207
> > +++++++++++++++++++++++++++++++++++- include/linux/device.h
> > |   3 + include/linux/intel-iommu.h |  40 +++++--
> > include/linux/intel-svm.h   |   7 ++ include/linux/ioasid.h      |
> > 66 ++++++++++++ include/linux/iommu.h       | 127
> > +++++++++++++++++++++++ include/uapi/linux/iommu.h  | 248
> > ++++++++++++++++++++++++++++++++++++++++++++ 16 files changed, 1559
> > insertions(+), 58 deletions(-) create mode 100644
> > drivers/base/ioasid.c create mode 100644 include/linux/ioasid.h
> >  create mode 100644 include/uapi/linux/iommu.h
> > 
> > -- 
> > 2.7.4
> >   
> 

[Jacob Pan]
