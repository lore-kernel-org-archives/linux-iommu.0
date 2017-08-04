From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v9 11/13] iommu/amd: Don't copy GCR3 table root pointer
Date: Fri, 4 Aug 2017 14:27:22 +0200
Message-ID: <20170804122722.GW3431@suse.de>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
 <1501587449-9817-12-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501587449-9817-12-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 01, 2017 at 07:37:27PM +0800, Baoquan He wrote:
> @@ -908,6 +911,14 @@ static int copy_device_table(void)
>  				old_dev_tbl_cpy[devid].data[1]
>  					= old_devtb[devid].data[1];
>  				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> +				/* If gcr3 table existed, mask it out */
> +				if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
> +					tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
> +					tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
> +					old_dev_tbl_cpy[devid].data[1] &= ~tmp;
> +					tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
> +					old_dev_tbl_cpy[devid].data[0] &= ~tmp;

You also need to clear the DTE_FLAG_GV bit.
