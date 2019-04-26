From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Date: Fri, 26 Apr 2019 08:05:45 -0700
Message-ID: <20190426080545.485a4124@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
        <20190425164017.6aed942e@jacob-builder>
        <8e063ce8-e5bb-5de8-f243-852c7a692c98@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e063ce8-e5bb-5de8-f243-852c7a692c98@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 26 Apr 2019 09:24:29 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > Agreed  
> >>> +#define VCMD_VRSP_RESULE(e)		(((e) >> 8) &
> >>> 0xfffff)    
> >> nit: s/RESULE/RSLT?  
> > yes. Also the mask bits should be 8 to 63
> > s/0xfffff/GENMASK_ULL(63, 8))/  
> Well the macro definition looks correct as 63:28 is RsvdZ

you are right, I misread the spec.

Thanks,

Jacob
