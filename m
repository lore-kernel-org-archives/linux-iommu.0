From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Mon, 21 May 2018 16:03:28 -0700
Message-ID: <20180521160328.02bc9414@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
        <20180517085909.7470dfb5@jacob-builder>
        <A2975661238FB949B60364EF0F2C257439BF2B2D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BF2B2D@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 17 May 2018 23:22:43 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > So as long as in-kernel PRQ handling can do queuing, there is no
> > need for queuing in the host reporting path.  
> 
> Will it affect current interface? Here the handler only get an "evt"
> per a PRQ IRQ. And I suppose vfio needs not rely on host iommu
> queuing?

I don't think it needs iommu driver queuing.
