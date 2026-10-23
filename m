Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770110;
	b=RhlNPwCdAtN1WblfWOH09k3pC9DTphmktIUDHZborI3eehPErNarZ4llcrRr/XRD1QrY
	 XJWRNkbiG9bmA5QD588FH9HwrCccQbQSfv+rGDrn3m9hgDVt/ntxD4MqS3Q0co7HKDsxe
	 4r5xqR/fWrRRsTBHxrzGnRuZSe7mtFf/RuQNPxY8UpUCcJnjaxtWRkkrFqQYK6/uhMSHt
	 KFe7U6Gd4ix1EN488+hAQVxddRjKiReC4Tpf24sDc/Wwor8YzvfFa8lIVVFasZMZJnnIq
	 kJ0nk5f3zv1Bx84KuJV4vgqxvzjBAEvq+psghIyscNFxvqs/OGDqCps6/jjWq810m7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=p4zYTNJnmB4RId87xSly9GxhAKztPRW2cESt3l+Nt3I=;
	b=jMK6nEMMO0rwhTQxv3r3UjDP5SMPWlj7nF2JK9GaNzuk3NOyO5vvV9+h+oF0ObSvfXxT
	 utk3tja7FRCOHZvDjuu94MnzKKVUxSwLoi/r/X6oWE6Dpvv/18lveMTD7vLeP/aPCWQmx
	 +Uiec0oW84286vyA0m/UNGRvyp2cTLUfZJqzHnfnU8I/7d/IknjVzXMZNLAl/KaWsvhAX
	 wD7UWnsEZHS+scg2akT28UF0MtCoOr+GlRJoBCnsTWu6gG+BFKfpw+PYYmlgPbnraGv15
	 Lcj68VreD9w3zbP6VxWMTr/IlWZ6KJWjhqBJYSp1XtylnZzg4DOK5oS134f7o9eOcqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nqdlI001;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718160A3828
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4718160A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nqdlI001
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c45111bebso585588f8f.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792770108; x=1793374908; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p4zYTNJnmB4RId87xSly9GxhAKztPRW2cESt3l+Nt3I=;
        b=nqdlI001Q+gE1EacG9fmDumGihcBXJ5a7M+BIP037/wLC2pLtvjPssX06r5bHQ3hoy
         1Pk7PPYcdLMfcIHsYFRwtjFTYUgoFowfmoWnazJHdC5fXhAVf8ebJFGreexOHE5tAjOR
         J2P+05KslnIBKMS5qeUkIGuwpCweT7MQ04VHtb0t7bvrJQ5+90kSiEjh/+GY7gNws991
         pY1tqF/q3VIX83wge48zFNuf57BQX4r6261jofhIQmYCf3+TIHl9DZQczy1SQ+GerekT
         Ie9MeIntP42+o/2Bdc5I0YACrKTj492tuH5Bg11W14U4gA1B3W5eqwhUKntgSPCSdZJd
         KDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770108; x=1793374908;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p4zYTNJnmB4RId87xSly9GxhAKztPRW2cESt3l+Nt3I=;
        b=pYq50HZUSnuuc0Ae8YeKpTS5+862uxIawMImzFpvPNhHquIKVyONYtMhn1apNT0q5o
         QO7rAEHks0AKG1okm/CEGT0nAToPcm1yJwwsTf+DUL/ohphTgeUHgimrBF9nyYWeWsIH
         afTz7uk4wUR2osunSaRiVYzJasxQgBTBrlACJBiBrROGqib7dxFt5gBfAlaobOhjeF22
         oH+W+72Z2DNaecu0DE7kacnueEGWU54QaELDc3qK1yNianLBCsU1xd4trtXaJtcShYW2
         nQajVjIgR1Dt1Nwr/fMsgRSn0EXJ3Wzj13EIDbfij3f45LtGGjw5FXn0qdwOnSQZsBKI
         O1pg==
X-Forwarded-Encrypted: i=1; AKwUvBySXrvyMQlsgDZNPpG+sV3jacUE4tSy5Y/WhyCm1e07F3JaVf+Y7ZIUvzXLeqtwDec7UPWQfQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJBdpvOYecEUIfHuiqd78+erOPuyqHI6ML9K+PmqLszJu39fAYS
	vQ3xk29Q8OkgeGDpdoDgTvOSmmwQ+DbKjamSdXJScHHx9pIHpAqtRiqxYlPo9nkiUZA=
X-Gm-Gg: AYBFou2xaL+zwxARjwZDrQqjndn9y+vcSzVCy1fwDR6IxRLNHVbQaTHbdIpLDduU1LE
	G1BwCUE0ii/aLozLqOG4Mx4G0r0SUctLVg2G/NxVefF7HVAjcMvTHBj1HlTbQZtncsDHtm/aRK6
	qdBHV698P/4p4INQ4gL3sRC2u9Pcuzvc27VDkHzhtUURwCfbNn7zNHx51ds13fm0tO8I1+7Hkpw
	Cef8w+zjpqR1PIIxO6PdyX+ujsmtDJnC9m3OgCYWr700aVg4qgJczbv1/3qIZMw5+aWe9x6yfHY
	6wxayxvqhJovY2zrMnGvHqSFeQt6OBYbPO2GZDRHXKKRoeR2L2q8QUJzoNHXvIP0X3Lqy8UJc6B
	ruK9DY83h2zA5qyWth5GUwq1Jhxl+RgRihcGBlVP0uRhL1lnhtPyVB5TDQUsjxbzkXo0pKPT38H
	8z0bL9fnQzWVlx73wVPFKGVMyGGrnbo8OHG0WtcDCgG8R2EGADndhS1Mruk0B65XbtFCCyNMjuE
	3+YKQoeT3e1CGEnIo80ymsrtJURMPBnHhnrhpxTuBH+nPVWw46YY7XluJ3rRvxnF8Tm
X-Received: by 2002:a05:6000:178a:b0:48d:f58f:c98 with SMTP id ffacd0b85a97d-48e385a5db6mr4346612f8f.40.1792770107560;
        Fri, 23 Oct 2026 08:41:47 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.107.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d400365sm532405f8f.25.2026.10.23.08.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:41:46 -0700 (PDT)
Message-ID: <99a419c3-81a8-4b37-b9c7-2dd56978162d@linaro.org>
Date: Fri, 23 Oct 2026 16:41:44 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] iommu: of_iommu: Add support for "iommu-ranges"
 on a device node
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2026 07:34, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> Introduce a new property, "iommu-ranges", to specify the device
> specific IOVA ranges when there is no backing "reg".
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/iommu/of_iommu.c | 128 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 121 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..9766a6944d0e11a6cd8b74b1b89428acffe3dfdf 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -190,6 +190,111 @@ iommu_resv_region_get_type(struct device *dev,
>   	return IOMMU_RESV_RESERVED;
>   }
>   
> +/**
> + * of_iommu_derive_resv_regions - derive reserved regions which
> + *                                are outside of iommu-ranges
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list
> + *
> + * A device can describe its own usable IOVA ranges directly on its node
> + * via "iommu-ranges". Everything not under those ranges is derived
> + * as a reserved region so the IOMMU allocator won't use it. Entries may
> + * appear in any order in the property.
> + */
> +static void of_iommu_derive_resv_regions(struct device *dev, struct list_head *list)
> +{
> +	struct of_iommu_range {
> +		struct list_head node;
> +		phys_addr_t start;
> +		phys_addr_t end;
> +	} *pos, *new, *next_range;
> +	int size, prot = IOMMU_READ | IOMMU_WRITE;
> +	struct iommu_resv_region *region;
> +	const __be32 *maps, *end;
> +	struct list_head *prev;
> +	phys_addr_t next = 0;
> +	LIST_HEAD(ranges);
> +
> +	maps = of_get_property(dev->of_node, "iommu-ranges", &size);
> +	if (!maps)
> +		return;
> +
> +	end = maps + size / sizeof(__be32);
> +
> +	while (maps < end) {
> +		phys_addr_t iova, iova_end;
> +		size_t length;
> +
> +		maps = of_translate_dma_region(dev->of_node, maps, &iova, &length);
> +		if (!maps) {
> +			dev_err(dev, "%pOF: failed to parse iommu-ranges\n",
> +				dev->of_node);
> +			break;
> +		}
> +
> +		if (!length)
> +			continue;
> +
> +		iova_end = iova + length - 1;
> +
> +		if (iova_end < iova) {
> +			dev_err(dev, "%pOF: iommu-ranges overflows address space\n",
> +				dev->of_node);
> +			continue;
> +		}
> +
> +		prev = &ranges;
> +		list_for_each_entry(pos, &ranges, node) {
> +			if (pos->start > iova)
> +				break;
> +			prev = &pos->node;
> +		}
> +
> +		new = kmalloc_obj(*new);
> +		if (!new)
> +			continue;
> +
> +		new->start = iova;
> +		new->end = iova_end;
> +		list_add(&new->node, prev);
> +	}
> +
> +	if (list_empty(&ranges))
> +		return;
> +
> +	if (of_dma_is_coherent(dev->of_node))
> +		prot |= IOMMU_CACHE;
> +
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		if (pos->start > next) {
> +			region = iommu_alloc_resv_region(next, pos->start - next, prot,
> +							 IOMMU_RESV_RESERVED, GFP_KERNEL);
> +			if (region)
> +				list_add_tail(&region->list, list);
> +		}
> +
> +		if (pos->end == PHYS_ADDR_MAX)
> +			goto exit;
> +
> +		if (pos->end >= next)
> +			next = pos->end + 1;
> +
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +
> +	region = iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next + 1,
> +					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
> +	if (region)
> +		list_add_tail(&region->list, list);
> +
> +exit:
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +}
> +
>   /**
>    * of_iommu_get_resv_regions - reserved region driver helper for device tree
>    * @dev: device for which to get reserved regions
> @@ -214,10 +319,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   
>   		memset(&phys, 0, sizeof(phys));
>   
> +		maps = of_get_property(it.node, "iommu-addresses", &size);
> +		if (!maps)
> +			continue;
> +
>   		/*
> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
> -		 * that represent reservations in the IOVA space, which are regions that should
> -		 * not be mapped.
> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
> +		 * the physical address and size of this memory region, for an identity 1:1
> +		 * IOVA mapping to that physical memory.
>   		 */
>   		if (of_property_present(it.node, "reg")) {
>   			err = of_address_to_resource(it.node, 0, &phys);
> @@ -226,11 +335,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   					it.node, err);
>   				continue;
>   			}
> -		}
> -
> -		maps = of_get_property(it.node, "iommu-addresses", &size);
> -		if (!maps)
> +		} else {
> +			dev_err(dev, "%pOF: iommu-addresses requires a reg property\n",
> +				it.node);
>   			continue;
> +		}

The if/else doesn't belong in a path entitled 'Add support for 
"iommu-ranges"' as this changes he behaviour of iommu-addresses 
independently of whatever iommu-ranges does.

The reg update part basically has nothing to do with this series at all 
i.e. the code you depend on later in this series doesn't declare 
iommu-addresses so... this is an update to align with a DT schema change.

https://github.com/devicetree-org/dt-schema/pull/207

Perhaps splitting this into two patches as an iommu-series would be best.
>   
>   		end = maps + size / sizeof(__be32);
>   
> @@ -258,6 +367,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
> +				if (type != IOMMU_RESV_DIRECT)
> +					continue;
> +

If you look in iommu_resv_region_get_type() you can emit

         dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] 
as reservation\n", phys,
                  &start, &end);
         return IOMMU_RESV_RESERVED;

on a mismatch - which is not what the code will do now. Mismatch will 
warn and then not map.

So maybe dev_err() saying you won't map - in the new patch for reg. 
Either way this isn't a change specific to iommu-ranges.

>   				region = iommu_alloc_resv_region(iova, length, prot, type,
>   								 GFP_KERNEL);
>   				if (region)
> @@ -265,6 +377,8 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   			}
>   		}
>   	}
> +
> +	of_iommu_derive_resv_regions(dev, list);
>   #endif
>   }
>   EXPORT_SYMBOL(of_iommu_get_resv_regions);
> 

