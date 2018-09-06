From: Jacob Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Thu, 6 Sep 2018 16:43:17 -0700
Message-ID: <20180906164317.786bbdda@jacob-builder>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
        <20180830013524.28743-3-baolu.lu@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A85@SHSMSX101.ccr.corp.intel.com>
        <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 6 Sep 2018 10:46:03 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> >> @@ -224,7 +271,14 @@ struct pasid_entry
> >> *intel_pasid_get_entry(struct device *dev, int pasid)
> >>    */
> >>   static inline void pasid_clear_entry(struct pasid_entry *pe)
> >>   {
> >> -	WRITE_ONCE(pe->val, 0);
> >> +	WRITE_ONCE(pe->val[0], 0);
> >> +	WRITE_ONCE(pe->val[1], 0);
> >> +	WRITE_ONCE(pe->val[2], 0);
> >> +	WRITE_ONCE(pe->val[3], 0);
> >> +	WRITE_ONCE(pe->val[4], 0);
> >> +	WRITE_ONCE(pe->val[5], 0);
> >> +	WRITE_ONCE(pe->val[6], 0);
> >> +	WRITE_ONCE(pe->val[7], 0);  
> > 
> > memset?  
> 
> The order is important here. Otherwise, the PRESENT bit of this pasid
> entry might still set while other fields contains invalid values.

WRITE_ONCE/READ_ONCE will switch to __builtin_memcpy() in if the size
exceeds word size, ie. 64bit in this case. I don;t think compiler will
reorder built-in function. Beside, we only need to clear present and
FDP bit, right?
