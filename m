From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Date: Mon, 18 Mar 2019 10:53:21 +0100
Message-ID: <20190318095321.GA5417@8bytes.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org, dianders@chromimum.org, hoegsberg@google.com, baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 01, 2019 at 12:38:26PM -0700, Jordan Crouse wrote:
> Add an attribute to return the base address of the pagetable. This is used
> by auxiliary domains from arm-smmu to return the address of the pagetable
> to the leaf driver so that it can set the appropriate pagetable through
> it's own means.

What is this going to be used for? Page-table management is supposed to
happen in the arm-smmu driver and the gpu driver only makes changes
through iommu_map/iommu_unmap calls.


Regards,

	Joerg
