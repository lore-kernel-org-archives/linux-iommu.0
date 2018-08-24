From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Date: Fri, 24 Aug 2018 12:47:24 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CCE9CC@SHSMSX104.ccr.corp.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<e9ddb745-9cfb-1d40-05e0-7bd75292a41f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e9ddb745-9cfb-1d40-05e0-7bd75292a41f-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org" <Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Auger Eric
> Sent: Friday, August 24, 2018 12:35 AM
> 
> Hi Jacob,
> 
> On 05/11/2018 10:53 PM, Jacob Pan wrote:
> > Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
> > use in the guest:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> >
> > As part of the proposed architecture, when an SVM capable PCI
> > device is assigned to a guest, nested mode is turned on. Guest owns the
> > first level page tables (request with PASID) which performs GVA->GPA
> > translation. Second level page tables are owned by the host for GPA->HPA
> > translation for both request with and without PASID.
> >
> > A new IOMMU driver interface is therefore needed to perform tasks as
> > follows:
> > * Enable nested translation and appropriate translation type
> > * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> >
> > This patch introduces new API functions to perform bind/unbind guest PASID
> > tables. Based on common data, model specific IOMMU drivers can be extended
> > to perform the specific steps for binding pasid table of assigned devices.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---

[...]

> > +#ifndef _UAPI_IOMMU_H
> > +#define _UAPI_IOMMU_H
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * PASID table data used to bind guest PASID table to the host IOMMU. This will
> > + * enable guest managed first level page tables.
> > + * @version: for future extensions and identification of the data format
> > + * @bytes: size of this structure
> > + * @base_ptr:	PASID table pointer
> > + * @pasid_bits:	number of bits supported in the guest PASID table, must be
> less
> > + *		or equal than the host supported PASID size.
> > + */
> > +struct pasid_table_config {
> > +	__u32 version;
> > +#define PASID_TABLE_CFG_VERSION_1 1
> > +	__u32 bytes;
> > +	__u64 base_ptr;
> > +	__u8 pasid_bits;
> 
> As reported in "[RFC 00/13] SMMUv3 Nested Stage Setup" thread, this API
> could be used for ARM SMMUv3 nested stage enablement without many
> changes. Assuming SMMUv3 nested stage is confirmed to be interesting for
> vendors and maintainers, we could try to unify the APIs.

Just a quick question on nested stage on SMMUv3. If virtualizer wants to
enable nested stage on SMMUv3, does it link the whole guest CD table to
host or do it in other manner?

> As far as I understand the VTD PASID table is equivalent to the ARM
> SMMUv3 context descriptor table (CD). This corresponds to the stage 1
> context table with one or more entries, each corresponding to one PASID.

PASID table is index by PASID, and have multiple entries. A PASID table
would have 2^PASID_BITS entries.

> maybe using the s1ctx_table_config terminology instead of
> pasid_table_config would be more generic, the pasid table being Intel
> naming.
>
> on top of pasid_bits, I think an "asid_bits" field may be needed too.
> The guest IOMMU might support a different number of asid bits from the
> host one.

Maybe needed for SMMUv3. I've noticed you've placed it in
struct iommu_smmu_s1_config.

> 
> Although without having skimmed through the whole series yet, I wonder
> how you handle the case where stage1 is bypassed or disabled? The guest
> may define the S1 context entries but bypass or abort stage 1
> translations globally. Looks something missing to me at first sight.

Sorry, I didn't quite follow here. What usage is case such for? like stage 1 is
bypassed or disabled. IOVA or SVA?

Thanks,
Yi Liu
