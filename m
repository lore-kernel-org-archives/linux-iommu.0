From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Date: Fri, 26 Apr 2019 16:13:41 +0200
Message-ID: <20190426141341.GB6731@8bytes.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
 <20190318095321.GA5417@8bytes.org>
 <20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org, dianders@chromium.org, hoegsberg@google.com, baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Jordan,

On Mon, Mar 18, 2019 at 08:19:12AM -0600, Jordan Crouse wrote:
> Adreno GPUs can an internal mechanism to switch the pagetable address in the
> attached arm-smmu v2 IOMMU so that each individual rendering process can have
> their own pagetable. The driver uses iommu_map and iommu_unmap to write
> the pagetable but the address for each individual pagetable needs to be queried
> so it can be sent to the hardware. You can see the driver specific code that
> does this here:

Okay, thanks for the explanation. I still don't like it, but it is
probably better putting gpu-specfic context-switch logic into the iommu
driver, so I guess this is okay.


Regards,

	Joerg
