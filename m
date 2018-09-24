From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 09/20] memory: tegra: Adapt to Tegra20 device-tree
 binding changes
Date: Mon, 24 Sep 2018 16:22:42 +0300
Message-ID: <bca7c87a-5f86-4a98-bb6b-411c641a0e80@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-10-digetx@gmail.com> <20180924100205.GB21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924100205.GB21032@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 1:02 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:42AM +0300, Dmitry Osipenko wrote:
>> The tegra20-mc device-tree binding has been changed, GART has been
>> squashed into Memory Controller and now the clock property is mandatory
>> for Tegra20, the DT compatible has been changed as well. Adapt driver to
>> the DT changes.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/memory/tegra/mc.c | 21 ++++++++-------------
>>   drivers/memory/tegra/mc.h |  6 ------
>>   include/soc/tegra/mc.h    |  2 +-
>>   3 files changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index e56862495f36..1b4ceefd82f9 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -51,7 +51,7 @@
>>   
>>   static const struct of_device_id tegra_mc_of_match[] = {
>>   #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>> -	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
>> +	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
> 
> Technically we now regress because we no longer support the older device
> tree bindings. I know that it doesn't really matter because this driver
> doesn't really do much interesting yet other than reporting memory
> access violations, but if that's enough to warrant a change of the
> compatible string, then I think we also need to preserve compatibility
> in the code.
> 
> That said, I think compatibility would be easier to preserve if we stuck
> with the old compatible string and used a "reg-names" property to
> specify which version of the binding we're referring to.
> 
> For example, we could have:
> 
> 	memory-controller@7000f000 {
> 		compatible = "nvidia,tegra20-mc";
> 		reg = <0x7000f000 0x024
> 		       0x7000f03c 0x3c4>;
> 		...
> 	};
> 
> for the old binding and:
> 
> 	memory-controller@7000f000 {
> 		compatible = "nvidia,tegra20-mc";
> 		reg = <0x7000f000 0x00000400>,
> 		      <0x58000000 0x02000000>;
> 		reg-names = "mc", "gart";
> 		...
> 	};
> 
> for the new binding. The driver can then easily check for the existence
> of the reg-names property and take the legacy or new code paths.

There is no problem with keeping compatibility for newer kernels with the older binding, 
it just not worth the effort. The real problem is keeping compatibility of older kernels 
with the new binding, the older kernels won't care about the reg-names and will treat GART 
registers as the second registers bank of the Memory Controller. Unfortunately I don't see 
how your suggestion is supposed to help with the problem.
