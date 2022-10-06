Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95037F6
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 10:46:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7831ED6E;
	Thu,  6 Oct 2022 03:46:51 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E771C3F73B;
	Thu,  6 Oct 2022 03:46:42 -0700 (PDT)
Message-ID: <86084a28-be55-1c58-eace-1d73868c33dc@arm.com>
Date: Thu, 6 Oct 2022 11:46:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/3] iommu/mediatek: add support for 6-bit encoded port
 IDs
Content-Language: en-GB
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
 <20221001-iommu-support-v2-2-dbfef2eeebc9@baylibre.com>
 <7d37e6ae-0dca-e0ef-2841-298c1ba9784f@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7d37e6ae-0dca-e0ef-2841-298c1ba9784f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-10-04 12:59, AngeloGioacchino Del Regno wrote:
> Il 04/10/22 12:01, Alexandre Mergnat ha scritto:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> Until now the port ID was always encoded as a 5-bit data. On MT8365,
>> the port ID is encoded as a 6-bit data. This requires to rework the
>> macros F_MMU_INT_ID_LARB_ID, and F_MMU_INT_ID_PORT_ID in order
>> to support 5-bit and 6-bit encoded port IDs.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 5a4e00e4bbbc..a57ce509c8b5 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -108,8 +108,10 @@
>>   #define F_MMU_INT_ID_SUB_COMM_ID(a)        (((a) >> 7) & 0x3)
>>   #define F_MMU_INT_ID_COMM_ID_EXT(a)        (((a) >> 10) & 0x7)
>>   #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)        (((a) >> 7) & 0x7)
>> -#define F_MMU_INT_ID_LARB_ID(a)            (((a) >> 7) & 0x7)
>> -#define F_MMU_INT_ID_PORT_ID(a)            (((a) >> 2) & 0x1f)
>> +#define F_MMU_INT_ID_LARB_ID(a, int_id_port_width)    \
>> +                ((a) >> (((int_id_port_width) + 2) & 0x7))
>> +#define F_MMU_INT_ID_PORT_ID(a, int_id_port_width)    \
>> +                (((a) >> 2) & GENMASK((int_id_port_width) - 1, 0))
> 
> I can't think about any cleaner way than this one, but that's decreasing 
> human
> readability by "quite a bit".

In terms of readability, the best thing to do would be define separate 
macros for each register format and make the choice at the (single) 
callsite rather than hiding it in the macro. In fact we're already doing 
exactly that with the HAS_SUB_COMM_2BITS and HAS_SUB_COMM_3BITS flags 
right at the same point, so please follow that same pattern for consistency.

Thanks,
Robin.
