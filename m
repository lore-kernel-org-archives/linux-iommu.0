From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device
 from a domain
Date: Thu, 24 Jan 2019 15:19:59 +0100
Message-ID: <20190124141958.q3zwkpulwyr32fge@8bytes.org>
References: <20190124041619.1974-1-Suravee.Suthikulpanit@amd.com>
 <20190124141145.GM32526@8bytes.org>
 <c965ccfb-1a98-1fc2-5980-2d7f17688e54@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c965ccfb-1a98-1fc2-5980-2d7f17688e54@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2019 at 02:17:34PM +0000, Suthikulpanit, Suravee wrote:
> On 1/24/19 9:11 PM, joro@8bytes.org wrote:
> > On Thu, Jan 24, 2019 at 04:16:45AM +0000, Suthikulpanit, Suravee wrote:
> >>   drivers/iommu/amd_iommu.c | 15 +++++++++++----
> >>   1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > Applied, thanks Suravee.
> > 
> 
> Thanks. Also, should this also back-ported to stable tree as well?

I added a Fixes tag, so stable should pick it up.


	Joerg
