Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635AB1D2BB;
	Mon,  5 Jun 2023 14:00:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8ABDD75;
	Mon,  5 Jun 2023 07:01:16 -0700 (PDT)
Received: from [10.57.85.135] (unknown [10.57.85.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEB083F663;
	Mon,  5 Jun 2023 07:00:28 -0700 (PDT)
Message-ID: <01dee34c-5663-22f4-0d88-90f87b1fe879@arm.com>
Date: Mon, 5 Jun 2023 15:00:24 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 10/17] iommu: Do iommu_group_create_direct_mappings()
 before attach
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <10-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
 <20230605070959.moupivvi7wr4nibu@rcn-XPS-13-9305>
 <ZH3nXbVFR6JfUKpV@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZH3nXbVFR6JfUKpV@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-06-05 14:47, Jason Gunthorpe wrote:
> On Mon, Jun 05, 2023 at 09:09:59AM +0200, Ricardo Cañuelo wrote:
>> [   16.267594] Call trace:
>> [   16.267597]  mtk_iommu_flush_iotlb_all+0x18/0x70
>> [   16.267603]  iommu_create_device_direct_mappings.part.0+0x13c/0x21c
>> [   16.267608]  iommu_setup_default_domain+0x27c/0x430
>> [   16.267611]  iommu_probe_device+0x7c/0x144
>> [   16.267615]  of_iommu_configure+0x114/0x200
>> [   16.267619]  of_dma_configure_id+0x1e0/0x3b4
> 
> This is definitely some problem in the mtk driver.. But I can't guess
> what is wrong:
> 
> static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
> {
> 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> 
> 	if (dom->bank)
> 		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
> }
> 
> We know domain != NULL since the caller checked (and de-ref'd)
> it.
> 
> dom->bank should either be NULL (if pre-finalize) or a devm tracked
> pointer.
> 
> parent_data is always valid if bank is valid.
> 
> So I'm at a loss.. Can you debug a bit more and find out where mtk is
> crashing?

The log says it's next-20230530 - the fix you're seeing there from 
commit b3fc95709c54 landed 2 days later :)

Robin.
