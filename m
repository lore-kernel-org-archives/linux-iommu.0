Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9810F9
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 10:55:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2088D2F4;
	Tue, 27 Jun 2023 03:55:52 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAF8C3F64C;
	Tue, 27 Jun 2023 03:55:04 -0700 (PDT)
Message-ID: <73f11258-1562-17c1-969e-b134dcb5f35c@arm.com>
Date: Tue, 27 Jun 2023 11:55:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/7] swiotlb: make io_tlb_default_mem local to
 swiotlb.c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Juergen Gross <jgross@suse.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kees Cook <keescook@chromium.org>, Saravana Kannan <saravanak@google.com>,
 "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
 <a1ef6eeab8b64fac817b9734da4a056f05a68d01.1687859323.git.petr.tesarik.ext@huawei.com>
 <2023062745-routing-palace-d0b4@gregkh>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2023062745-routing-palace-d0b4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2023 11:24 am, Greg Kroah-Hartman wrote:
> On Tue, Jun 27, 2023 at 11:54:23AM +0200, Petr Tesarik wrote:
>> +/**
>> + * is_swiotlb_active() - check if the software IO TLB is initialized
>> + * @dev:	Device to check, or %NULL for the default IO TLB.
>> + */
>>   bool is_swiotlb_active(struct device *dev)
>>   {
>> -	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>> +	struct io_tlb_mem *mem = dev
>> +		? dev->dma_io_tlb_mem
>> +		: &io_tlb_default_mem;
> 
> That's impossible to read and maintain over time, sorry.
> 
> Please use real "if () else" lines, so that it can be maintained over
> time.

Moreover, it makes for a horrible interface anyway. If there's a need 
for a non-specific "is SWIOTLB present at all?" check unrelated to any 
particular device (which arguably still smells of poking into 
implementation details...), please encapsulate it in its own distinct 
helper like, say, is_swiotlb_present(void).

However, the more I think about it, the more I doubt that logic like 
octeon_pci_setup() can continue to work properly at all if SWIOTLB 
allocation becomes dynamic... :/

Thanks,
Robin.
