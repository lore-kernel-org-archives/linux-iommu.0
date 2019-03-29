From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Date: Fri, 29 Mar 2019 15:51:01 +0100
Message-ID: <20190329145101.GA27670@8bytes.org>
References: <20190328104459.18589-1-joro@8bytes.org>
 <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <ghook@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Gary,

On Thu, Mar 28, 2019 at 02:52:19PM +0000, Gary R Hook wrote:
> On 3/28/19 5:44 AM, Joerg Roedel wrote:
> > +		if (entry->prot & (1 << 2))
> 
> Could we add #define IOMMU_WRITE_EXCL (1 << 2) to amd_iommu_types.h?

Yes, I replace that magic number with a descriptive name.

> The problem I see here is that if, for some untold reason, there is more 
> than one exclusion range emitted, where only the last one wins in the 
> hardware, we'd still end up with more than one range reserved in the 
> IOVA tree. Clearly, this is extremely unlikely, but wouldn't we want to 
> protect against that sort of misuse/mistake?
> 
> I could be missing something.

No, you are not, this could still be a problem. Until now it isn't,
because this week was the first time I have every seen an AMD IOMMU
system making use of exclusion ranges, and it doesn't have this problem.

But this problem has been in the code even before this patch and needs
to be addressed separatly. I think it is the best option to cancel IOMMU
initialization when the IVRS table defines conflicting exclusion ranges
for a single IOMMU instance.

Regards,

	Joerg
