From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFCv2 PATCH 21/36] iommu/arm-smmu-v3: Implement process
 operations
Date: Thu, 9 Nov 2017 12:08:59 +0000
Message-ID: <812aa54c-1cda-d4a4-640f-4aa2d8eb81fa@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-22-jean-philippe.brucker@arm.com>
 <084b1848-0939-5e73-3890-3aab8dc4bc70@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <084b1848-0939-5e73-3890-3aab8dc4bc70@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "liubo95@huawei.com" <liubo95@huawei.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>, nwatters@cod
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/11/17 03:32, Yisheng Xie wrote:
> Hi Jean,
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> Hook process operations to support PASID and page table sharing with the
>> SMMUv3:
>>
>> +
>> +static void arm_smmu_process_exit(struct iommu_domain *domain,
>> +				  struct iommu_process *process)
>> +{
>> +	struct arm_smmu_master_data *master;
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +
>> +	if (!domain->process_exit)
>> +		return;
> 
> If domain do not set process_exit handler, just return? smmu do not
> need invalid ATC, clear cd entry, etc.? Maybe you should check when
> call domain->process_exit?

Indeed, that doesn't make sense. I'll move the check below.

Thanks,
Jean

>> +
>> +	spin_lock(&smmu_domain->devices_lock);
>> +	list_for_each_entry(master, &smmu_domain->devices, list) {
>> +		if (!master->processes)
>> +			continue;
>> +
>> +		master->processes--;
> Add
> 		if (domain->process_exit)
> here?
>> +		domain->process_exit(domain, master->dev, process->pasid,
>> +				     domain->process_exit_token);
>> +
>> +		/* TODO: inval ATC */
>> +	}
>> +	spin_unlock(&smmu_domain->devices_lock);
>> +
>> +	arm_smmu_write_ctx_desc(smmu_domain, process->pasid, NULL);
>> +
>> +	/* TODO: Invalidate all mappings if not DVM */
>> +}
>> +
> Thanks
> Yisheng Xie
> 
> 

