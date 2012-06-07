From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH RFC] iommu/amd: Fix missing iommu_shutdown initialization
 in passthrough mode
Date: Thu, 7 Jun 2012 11:32:35 +0200
Message-ID: <20120607093235.GK757@amd.com>
References: <1339001406.2763.49.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339001406.2763.49.camel@lorien2>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.khan@hp.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 06, 2012 at 10:50:06AM -0600, Shuah Khan wrote:
> Change AMD iommu driver to call disable iommus in pass-through mode. AMD
> iommu driver's amd_iommu_init() routine doesn't initialize iommu_shutdown
> in pass-through mode. As a result iommu disable via a call to disable_iommus()
> doesn't happen at shutdown. Enable and disable of iommus is inconsistent in
> pass-through mode. IOMMU is enabled, but not disabled. IOMMU disable is called
> from error legs in amd_iommu_init() in pass-through mode.
> 
> Requesting for comments as I don't have access to AMD system that supports
> IOMMU. I tested the change on AMD platforms with GART IOMMU which is not
> sufficient.
> 
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>

The patch is fine. Thanks, applied to iommu/fixes.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
