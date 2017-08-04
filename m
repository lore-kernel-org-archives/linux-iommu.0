From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v9 10/13] iommu/amd: Allocate memory below 4G for dev
 table if translation pre-enabled
Date: Fri, 4 Aug 2017 14:25:24 +0200
Message-ID: <20170804122524.GV3431@suse.de>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
 <1501587449-9817-11-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501587449-9817-11-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 01, 2017 at 07:37:26PM +0800, Baoquan He wrote:
> AMD pointed out it's unsafe to update the device-table while iommu
> is enabled. It turns out that device-table pointer update is split
> up into two 32bit writes in the IOMMU hardware. So updating it while
> the IOMMU is enabled could have some nasty side effects.
> 
> The safe way to work around this is to always allocate the device-table
> below 4G, including the old device-table in normal kernel and the
> device-table used for copying the content of the old device-table in kdump
> kernel. Meanwhile we need check if the address of old device-table is
> above 4G because it might has been touched accidentally in corrupted
> 1st kernel.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/iommu/amd_iommu_init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6a77b99d08e4..8c6431ac5698 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -882,11 +882,15 @@ static int copy_device_table(void)
>  			continue;
>  
>  		old_devtb_phys = entry & PAGE_MASK;
> +		if (old_devtb_phys > 0x100000000ULL) {

Needs to be '>='.

> +			pr_err("The address of old device table is above 4G, not trustworthy!/n");
> +			return -1;
> +		}

Okay, forget my previous comment about it, the check is added here
