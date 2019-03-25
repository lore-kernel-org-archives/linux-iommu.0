From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/1] iommu: Bind process address spaces to devices
Date: Mon, 25 Mar 2019 15:44:13 +0100
Message-ID: <20190325144241.GC25350@8bytes.org>
References: <20190320150258.3240-1-jean-philippe.brucker@arm.com>
 <20190320150258.3240-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190320150258.3240-2-jean-philippe.brucker@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com, zhangfei.gao@foxmail.com
List-Id: iommu@lists.linux-foundation.org

Hey Jean-Philippe,

thanks for the patch, I think we are on the finish line with this
interface. Just one small question below.

On Wed, Mar 20, 2019 at 03:02:58PM +0000, Jean-Philippe Brucker wrote:
> +int iommu_sva_set_ops(struct iommu_sva *handle,
> +		      const struct iommu_sva_ops *sva_ops)
> +{
> +	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
> +
> +	if (!ops || !ops->sva_set_ops)
> +		return -ENODEV;
> +
> +	return ops->sva_set_ops(handle, sva_ops);
> +}

What is the purpose of the sva_set_ops call-back in iommu-ops? Is the
IOMMU driver supposed to do some extra setup work with the provided ops?
Otherwise we can just store the pointer in 'struct iommu_sva' without
calling into the iommu driver.


Regards,

	Joerg
