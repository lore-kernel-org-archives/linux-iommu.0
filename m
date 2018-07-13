From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
 tables
Date: Fri, 13 Jul 2018 13:00:03 +0800
Message-ID: <20180713050003.GA2379@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
 <20180711024506.GB2359@xz-mi>
 <5B4801A6.1090200@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B4801A6.1090200@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 13, 2018 at 09:34:30AM +0800, Lu Baolu wrote:
> Hi Peter,
> 
> Do you have further comments for this series? I will work out a
> new version if there are no ones.

Not for now.  Though since you mentioned about the work to remove the
pasid state table, not sure whether it'll be nice to put that into
this series, or even put more patches that are directly related
(e.g. including the two-level pasid table work and anything related)
so the series could be more complete.

> 
> Thank you for reviewing my patches. Do you allow me to add your
> reviewed-by to the patches which you've reviewed?

I'm glad to read your work.  I didn't leave r-bs because I'm not that
familiar with the codes so I'm not confident to leave any, just to
raise the questions.  Please feel free to post a new version as you
wish, I'll try to leave r-b there if possible.

Thanks,

-- 
Peter Xu
