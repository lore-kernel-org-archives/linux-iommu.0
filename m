From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v8 06/13] iommu/amd: copy old trans table from old kernel
Date: Thu, 27 Jul 2017 17:38:25 +0200
Message-ID: <20170727153825.GM3610@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-7-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500627551-12930-7-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 21, 2017 at 04:59:04PM +0800, Baoquan He wrote:
> @@ -2128,9 +2131,43 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>  static void early_enable_iommus(void)
>  {
>  	struct amd_iommu *iommu;
> +	bool is_pre_enabled = false;
>  
> -	for_each_iommu(iommu)
> -		early_enable_iommu(iommu);
> +	for_each_iommu(iommu) {
> +		if (translation_pre_enabled(iommu)) {
> +			is_pre_enabled = true;
> +			break;
> +		}
> +	}

is_pre_enabled should only be true when _all_ iommus are pre-enabled. If
only one is found disabled just disable the others and continue without
copying the device table.
