From: chenfeng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/hisilicon: Add hi6220 iommu driver
Date: Mon, 19 Oct 2015 09:49:43 +0800
Message-ID: <56244C37.9030407@hisilicon.com>
References: <1444290348-66509-1-git-send-email-puck.chen@hisilicon.com>
 <1444290348-66509-2-git-send-email-puck.chen@hisilicon.com>
 <20151014121843.GN27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151014121843.GN27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuyiping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2015/10/14 20:18, Joerg Roedel wrote:
> On Thu, Oct 08, 2015 at 03:45:47PM +0800, Chen Feng wrote:
>> +static int hi6220_smmu_attach_dev(struct iommu_domain *domain,
>> +				  struct device *dev)
>> +{
>> +	struct hi6220_domain *m_domain = to_hi6220_domain(domain);
>> +
>> +	smmu_domain_prepare(m_domain);
>> +	dev->archdata.iommu = &m_domain->smmu_dev->iova_allocator;
>> +
>> +	return 0;
>> +}
> 
> What happens when you attach devices behind different smmus to one
> domain? Will that overwrite the smmu_dev pointer in the domain?
> 

Since the smmu master use the same pagetable, the master can use the iova_allocator
in smmu driver to allocate iova address.

In this way, the different master can get the different io address.

>> +static size_t hi6220_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>> +				size_t size)
>> +{
>> +	struct hi6220_domain *m_domain = to_hi6220_domain(domain);
>> +	size_t page_size = m_domain->smmu_dev->page_size;
>> +	struct hi6220_smmu *smmu_dev = m_domain->smmu_dev;
>> +	int *page_table = (unsigned int *)smmu_dev->pgtable_virt;
>> +
>> +	if (size != page_size) {
>> +		pr_err("unmap size error, only support %zd\n", page_size);
>> +		return 0;
>> +	}
>> +
>> +	__clear_smmu_pte(page_table + IOVA_PFN(iova));
>> +
>> +	return page_size;
>> +}
> 
> Don't you need a call to __invalid_smmu_tlb here too?

Thanks, I will fix this next version.
> 
> 
> 
> 	Joerg
> 
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
