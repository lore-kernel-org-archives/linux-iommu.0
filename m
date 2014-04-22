From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch Part3 V1 19/22] iommu/vt-d: simplify intel_unmap_sg()
 and kill duplicated code
Date: Tue, 22 Apr 2014 15:42:25 +0800
Message-ID: <53561D61.7030706@linux.intel.com>
References: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>	 <1398150453-28141-20-git-send-email-jiang.liu@linux.intel.com> <1398152333.723.27.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1398152333.723.27.camel@shinybook.infradead.org>
Sender: linux-pci-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, Tony Luck <tony.luck@intel.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 2014/4/22 15:38, David Woodhouse wrote:
> On Tue, 2014-04-22 at 15:07 +0800, Jiang Liu wrote:
>> +       size_t size = 0;
>> +#if 0
>> +       /* current the third argument of intel_unmap_page is unsued */
>> +       int i;
>> +       struct scatterlist *sg;
>>  
>> -       freelist = domain_unmap(domain, start_pfn, last_pfn);
>> +       for_each_sg(sglist, sg, nelems, i)
>> +               size += sg->length;
>> +#endif
> 
> Please don't do that. If you want to rely on the fact that
> intel_unmap_page() currently just uses the size from the IOVA it finds,
> then split it out into a separate function which explicitly does
> precisely that. And call that new function from both intel_unmap_sg()
> and intel_unmap_page().

Good suggestion, will change to follow that way in next version.
