From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Clean up pasid quirk for
 pre-production devices"
Date: Fri, 20 Jul 2018 13:56:53 +0200
Message-ID: <20180720115652.tswu2sohy6snj4hl@8bytes.org>
References: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Jul 08, 2018 at 02:23:21PM +0800, Lu Baolu wrote:
> This reverts commit ab96746aaa344fb720a198245a837e266fad3b62.
> 
> The commit ab96746aaa34 ("iommu/vt-d: Clean up pasid quirk for
> pre-production devices") triggers ECS mode on some platforms
> which have broken ECS support. As the result, graphic device
> will be inoperable on boot.
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107017
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++++++++--
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)

Applied to iommu/fixes.
