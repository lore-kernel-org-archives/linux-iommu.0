From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 1/1] iommu: Bind process address spaces to devices
Date: Mon, 1 Apr 2019 11:10:23 +0100
Message-ID: <31f7cee6-730c-7ca1-5107-358b8aa8f7b9@arm.com>
References: <20190320150258.3240-1-jean-philippe.brucker@arm.com>
 <20190320150258.3240-2-jean-philippe.brucker@arm.com>
 <20190325144241.GC25350@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325144241.GC25350@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, ashok.raj@intel.com, zhangfei.gao@foxmail.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, christian.koenig@amd.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 25/03/2019 14:44, Joerg Roedel wrote:
> Hey Jean-Philippe,
> 
> thanks for the patch, I think we are on the finish line with this
> interface. Just one small question below.
> 
> On Wed, Mar 20, 2019 at 03:02:58PM +0000, Jean-Philippe Brucker wrote:
>> +int iommu_sva_set_ops(struct iommu_sva *handle,
>> +		      const struct iommu_sva_ops *sva_ops)
>> +{
>> +	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
>> +
>> +	if (!ops || !ops->sva_set_ops)
>> +		return -ENODEV;
>> +
>> +	return ops->sva_set_ops(handle, sva_ops);
>> +}
> 
> What is the purpose of the sva_set_ops call-back in iommu-ops? Is the
> IOMMU driver supposed to do some extra setup work with the provided ops?
> Otherwise we can just store the pointer in 'struct iommu_sva' without
> calling into the iommu driver.

Right that would be simpler. I added the sva_set_ops callback so that
IOMMU driver can use the same lock in unbind() and sva_set_ops(). But I
think it's safe to assume that device drivers don't call unbind() before
setting the ops.

Thanks,
Jean
