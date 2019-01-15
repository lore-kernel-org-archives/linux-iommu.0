From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v7 00/24] Tegra GART driver clean up and optimization
Date: Tue, 15 Jan 2019 19:33:54 +0300
Message-ID: <bbefe330-d3e8-3eea-0f9e-a2b0b7915120@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
 <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

17.12.2018 12:14, Joerg Roedel пишет:
> On Wed, Dec 12, 2018 at 11:38:43PM +0300, Dmitry Osipenko wrote:
>> Dmitry Osipenko (24):
>>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>>   iommu/tegra: gart: Clean up driver probe errors handling
>>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>>   iommu: Introduce iotlb_sync_map callback
>>   iommu/tegra: gart: Optimize mapping / unmapping performance
>>   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
>>   ARM: dts: tegra20: Update Memory Controller node to the new binding
>>   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
>>     Tegra20
>>   memory: tegra: Adapt to Tegra20 device-tree binding changes
>>   memory: tegra: Read client ID on GART page fault
>>   memory: tegra: Use of_device_get_match_data()
>>   memory: tegra: Use relaxed versions of readl/writel
>>   iommu/tegra: gart: Integrate with Memory Controller driver
>>   memory: tegra: Do not try to probe SMMU on Tegra20
>>   memory: tegra: Do not ask for IRQ sharing
>>   memory: tegra: Clean up error messages
>>   iommu/tegra: gart: Fix spinlock recursion
>>   iommu/tegra: gart: Fix NULL pointer dereference
>>   iommu/tegra: gart: Allow only one active domain at a time
>>   iommu/tegra: gart: Don't use managed resources
>>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>>   iommu/tegra: gart: Don't detach devices from inactive domains
>>   iommu/tegra: gart: Simplify clients-tracking code
>>   iommu/tegra: gart: Perform code refactoring
> 
> Applied, thanks.
> 

Hello Joerg,

Should I expect that the patches will appear in the IOMMU git and in -next consequently? Please let me know if there is any problem with the applying of the patches.
