From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 7/9] iommu/amd: Update domain into to dte entry during
 device driver init
Date: Thu, 10 Nov 2016 12:48:16 +0100
Message-ID: <20161110114816.GE9996@8bytes.org>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
 <1476963440-23039-8-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476963440-23039-8-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Vincent.Wan@amd.com, dyoung@redhat.com, xlpang@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 20, 2016 at 07:37:18PM +0800, Baoquan He wrote:
>  	prot = dir2prot(direction);
> +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
> +		dev_data->domain_updated = true;
> +		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
> +		if (alias != dev_data->devid)
> +			set_dte_entry(alias, domain, dev_data->ats.enabled);
> +		device_flush_dte(dev_data);
> +	}

Hmm, I really don't like to have these checks in the fast-path. But to
get rid of it I think we need to re-work the way domains are assigned to
devices.

One way to do this would be to add a 'defered-domain-attach' feature to
the iommu-core code. What do you think about this?


	Joerg
