Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298C24A067
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530048; cv=none; b=ZZZhrrx7kC8wZ/uAtTKGVVan8xlDV2tmna067Fb/VXWbp39rCsL5rO1yRXCwceL1MU8jTa3PFnnP3HVHZil6MSfSSCpGsWvJuJJ1fCyjWoLtAdsv9O+lnzScmQok8lhXfCvjD7naC6P0XZ1PLLi3QshxcxBFrN0HWgwAa95v6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530048; c=relaxed/simple;
	bh=NXZDspMbrOv5vkONMoM2L5ggiE2EAR+AQYiQEdJNcHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZxvxlpLFst8Nhwz8BuH6ffU/9YYe/lxuCm4Gj249TTqsN3lLDWZwTPCqN42nLHmyMrnuuaAfYS4F5TuhJC2kAnbMgz1nMxBhvxIx80ssb9exOoYZzDsVGtotW7jmpSPB2ICNmoFE+6YRPNGDNhZmfSAZDQQMVsOyHP+0o9P/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1619658f8f.1
        for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 13:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785530045; x=1786134845;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Se3TlLpuysYiEG2DYm26v81iW1ITt60yQ73LdmliEgA=;
        b=S/boMCJP+kZXUkvC1hOO2Noq0wZ+05AZtK30GjfWxUzvxVGGawc16t1H9Q6dMuxazd
         4GjBGvezGuAeFpFHclEBGMTu8QDL37RDCmvmTqe0jepiIvgg8CZhCri0zmX1T9K7Dk+Y
         Tsni4+kW6VQ4C4pPnPD6uCvhq4DydGlzxIe3d5bJ8pqx6M1EFKyv3eLoJ5GLoilwUU8+
         6+7MpBSUzyCZgKWgm1sNHs8Z6CWavFHH7Riz6uqgw3DPe+cmOVbc+zxfTgByIASKaHUH
         4rVhmqhKJzkYPCG9oBRSUl34eBAbC70jRiekA/gCuU2+cyJy6SoUpSXK83l7UmxtMQ2d
         JcWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUqHtjOxpCT97pZ7EWVCKR5qqisaKNjEnOdPWUykSmHY1Vh0ru9Tvdo1oMzZDGHqqt2hgJ8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5kEJlFO9IWljBVqDghZSKHGrWIe397A8z3EZI7MBKAaiuiRHQ
	k5ZFLpSFx7gPnU86XhiD7Z+aDq4FndENPY1Gcr5VoNl9Yt8MiJ0EJj3C
X-Gm-Gg: AR+sD137xM7cQ/dJ3wjCsbEOejmOcOvxaNi6YbxP+AiK/RjZRXgI3AeknZ8/nc3sG3K
	sT8uRVis9Yh5Asw3ehGdnPJnG/yq4orWv5uN4VM+GF4XnsdGiiD15J0dbQeVex//lFlaMXL+mDv
	H7Lp9T3rjIQGoKJthFmExqxOyueM/uDc6z3rdMFptDgS+dXZxoCBGdz9cr74FaOXMaTNE1FwQ1I
	D5HDGU6WqDk6IsutdOY70PRrd0jZpZIA2PKUtaJ+9dVV7JdJac68kjiDUt9w196beGD0CsRmq/M
	L75PobS3PrGRAE7qlXWEDhL3HjRSbNpHjDjYCx9K/4xQlLet0m5feZGglewVSc9zPsTm7Ef6/1d
	u7jHQbfM9J98rq/rHrFRwk8RkVWghWd+sBmKt87zMHYps2G5ANVuGaSxwwQqhsc7+45GQlyZGAj
	VYjWzqpuHV0PA/WE5NPQ19fCO7DscJpcTBaaBkSxhqbAxWGWnHuXP2kLXxBHa3/ParSD/s0E7Pf
	6u70Qfd+wz/0rIkZBsZkIPkZRV6a/2bR7SvPsFGnpAK4oJ9bOhxUiH4SPwA0ysXt3fe
X-Received: by 2002:a05:6000:1846:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fd729208fmr2040027f8f.14.1785530045266;
        Fri, 31 Jul 2026 13:34:05 -0700 (PDT)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6d7sm9618856f8f.19.2026.07.31.13.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 13:34:04 -0700 (PDT)
Message-ID: <6d9b28ec-0905-4cb0-9a62-980c7fa69572@reactivated.net>
Date: Fri, 31 Jul 2026 21:34:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
 <20260730-small-solid-spoonbill-8a8bbd@quoll>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <20260730-small-solid-spoonbill-8a8bbd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2026 08:00, Krzysztof Kozlowski wrote:
> On Mon, Jul 27, 2026 at 09:43:59PM +0100, Daniel Drake wrote:
>> +static int bcm2712_iommu_init_cache(struct bcm2712_iommu *mmu,
>> +				    struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct platform_device *cache_pdev;
>> +	struct device_node *cache_np;
>> +
>> +	cache_np = of_parse_phandle(dev->of_node, "brcm,iommu-cache", 0);
>> +
>> +	/* Fall back on 'cache' property used in old/downstream firmware */
>> +	if (!cache_np)
>> +		cache_np = of_parse_phandle(dev->of_node, "cache", 0);
> 
> NAK.
> 
> You cannot have undocumented ABI. I asked you to drop this at v1.
Is there any approach I should consider here in order to support 
existing shipped firmware versions that use the 'cache' property, or 
should I simply break compatibility?

While I was working on another issue recently there was a lean towards 
supporting existing/wrong DTs at the end of
https://lore.kernel.org/all/878q898ulx.wl-maz@kernel.org/

but admittedly that case has some different parameters: it was incorrect 
DT values (not incorrect ABI) and also was more severe (breaks boot). In 
this case if the system were to boot without iommu support it is not the 
end of the world.

Thanks,
Daniel

