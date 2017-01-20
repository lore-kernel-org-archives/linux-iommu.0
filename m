From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing workarounds
Date: Sat, 21 Jan 2017 00:50:03 +0530
Message-ID: <000001d27352$37b5cea0$a7216be0$@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org> <1484838356-24962-9-git-send-email-sricharan@codeaurora.org> <20170119161826.GI31594@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170119161826.GI31594@arm.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Will Deacon' <will.deacon@arm.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

Hi Will,

>-----Original Message-----
>From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-owner@vger.kernel.org] On Behalf Of Will Deacon
>Sent: Thursday, January 19, 2017 9:48 PM
>To: Sricharan R <sricharan@codeaurora.org>
>Cc: robin.murphy@arm.com; joro@8bytes.org; lorenzo.pieralisi@arm.com; iommu@lists.linux-foundation.org; linux-arm-
>kernel@lists.infradead.org; linux-arm-msm@vger.kernel.org; m.szyprowski@samsung.com
>Subject: Re: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing workarounds
>
>On Thu, Jan 19, 2017 at 08:35:52PM +0530, Sricharan R wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Now that the appropriate ordering is enforced via profe-deferral of
>> masters in core code, rip it all out and bask in the simplicity.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [Sricharan: Rebased on top of ACPI IORT SMMU series]
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  * No change
>>
>>  drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
>>  drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
>>  2 files changed, 10 insertions(+), 94 deletions(-)
>
>Acked-by: Will Deacon <will.deacon@arm.com>
>
>I can't wait to see this series merged. What's the plan for that?

Thanks. Posted V6 with your tags and comments for V5 addressed.

Regards,
 Sricharan
