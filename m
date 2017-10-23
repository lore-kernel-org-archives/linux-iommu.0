From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Mon, 23 Oct 2017 13:17:07 +0100
Message-ID: <7aaf9851-9546-f34d-1496-cbeea404abbd@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "liubo95@huawei.com" <liubo95@huawei.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>, gabriele.paoloni@huawe
List-Id: iommu@lists.linux-foundation.org

On 23/10/17 12:04, Liu, Yi L wrote:
>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock(&iommu_process_lock);
>> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
>> +				 domain->max_pasid + 1, GFP_ATOMIC);
>> +	process->pasid = pasid;
> 
> [Liu, Yi L] If I'm understanding well, here is managing the pasid allocation in iommu
> layer instead of vendor iommu driver? Is there strong reason here? I think pasid
> management may be better within vendor iommu driver as pasid management
> could differ from vendor to vendor.

But that's the thing, we're trying to abstract PASID and process
management to have it in the core, because there shouldn't be many
differences from vendor to vendor. This way we have the allocation code in
one place and vendor drivers don't have to copy paste it from other drivers.

It's just a global number within a range, so I don't think vendors will
have many different ways of designing it.

Thanks,
Jean
