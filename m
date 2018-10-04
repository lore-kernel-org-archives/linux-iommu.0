From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
Date: Thu, 4 Oct 2018 16:00:48 -0500
Message-ID: <793d47b7-cb56-9017-2030-e248921ccab4@linux.intel.com>
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
 <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
 <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, aisheng.dong@nxp.com, sboyd@kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On 10/04/2018 01:49 PM, Vivek Gautam wrote:
> Hi Thor,
> 
> 
> On 10/4/2018 3:58 AM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add a clock to the SMMU structure. In the device tree case,
>> check for a clock node and enable the clock if found.
>>
>> This patch is dependent upon the following patches that add
>> a device tree bulk clock function.
>> "[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
>> https://patchwork.kernel.org/patch/10583133/
>> "[V6, 2/4] clk: add new APIs to operation on all available
>> clocks"
>> https://patchwork.kernel.org/patch/10583131/
>> "[V6, 3/4] clk: add managed version of clk_bulk_get_all"
>> https://patchwork.kernel.org/patch/10583139/
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
> 
> The clock part is already handled by one of the patch in the
> runtime pm series of arm-smmu [1]. This patch should not be needed.
> 
> [1] https://patchwork.kernel.org/patch/10581899/
> 
> [...]
> 
> Regards
> Vivek
> 

Thanks. FYI, I had problems applying [v16,2/5] on [1] but was able to 
apply [v17,2/5] cleanly.

The bigger issue is that with your patchset I need to create a new 
structure for my variation of the ARM SMMUv2 due to the 
of_device_get_match_data() call in arm_smmu_device_dt_probe(). I want to 
use the default arm_mmu500 but it doesn't have a clock specified and I 
end up with num_clks of 0.

Creating a new smmu_match_data structure for each variant feels wrong 
because I have the clock data specified in my device tree. The 
of_clk_bulk_get() call handles this nicely but that patchset isn't 
getting much attention.

I'll investigate adding the of_clk_bulk_get() call on top of your 
patches. This may simplify your patches too since the additional 
structures in [v16,5/5] wouldn't be needed.

Thanks,

Thor

[1] git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git - next
