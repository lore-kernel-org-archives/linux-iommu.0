From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 02/19] iommu: introduce device fault data
Date: Thu, 25 Apr 2019 11:07:20 -0700
Message-ID: <20190425110720.07d7d317@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
        <220a581e-0ee8-70e2-796b-b434594e4825@redhat.com>
        <a2880e11-90fe-36d4-01ad-bf3c346c6d7f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2880e11-90fe-36d4-01ad-bf3c346c6d7f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 25 Apr 2019 15:33:17 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 25/04/2019 14:21, Auger Eric wrote:
>   We could add a
> >> IOMMU_FAULT_PAGE_REQUEST_PERM_VALID bit instead, but I still find
> >> it weird to denote the validity of a bitfield using a separate bit.
> >>
> >> Given that three different series now rely on this, how about we
> >> send the fault patches separately for v5.2?  
> 
> Sorry I meant v5.3 - after the merge window
> 
> >> I pushed the recoverable fault
> >> support applied on top of this, with the PERM_READ bit and cleaned
> >> up kernel doc, to git://linux-arm.org/linux-jpb.git sva/api  
> > 
Sounds good to me. We need th READ perm. I will pick the fault reporting
patches from this tree for my next rev. My plan is to add PRQ support
for vSVA after the current series.
> > my only concern is is it likely to be upstreamed without any actual
> > user? In the positive, of course, I don't have any objection.  
> 
> Possibly, I don't think my I/O page fault stuff for SVA is likely to
> get in v5.3, it depends on one or two more patch sets. But your
> nested work and Jacob's one may be in good shape for next version? I
> find it difficult to keep track of the same patches in three
> different series.
Same here, hard to track especially for minor tweaks. I am working
towards the next version for vSVA page fault. Then I will look into
converting VT-d native IO page fault to yours.

Thanks,

Jacob
