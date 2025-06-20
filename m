Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8923AB9C
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413308; cv=pass; b=b3K/YA8jE4wtEVJXAcQyLx4AVuKaNrtbx6a1piwj2wEQxkJ0ByCFHuKMv8NByql3f6t1OiL32BGytoFzvkCQtCKfStosLx9I5/7pNvizBzMpjksVLxqoxQaERMy1QHhcHFoYluc4rv8yoTLC6bJkRsvWPrsHVzYCU19otuddcD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413308; c=relaxed/simple;
	bh=pze55APxtyCaqLQ7ERtutzcnPhaYtGpBxEVH8PwbPKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGxOJNnpSlttdVq+etbQ5ut7a3mjDncwBY0wC+poqCV+xt7FJxVTi9kWq5AjgMJG1fzbqpL1Dgt5BKYnCvfGvFThpdU4Mo6kLYtSt4WXl061pQXMwMMZXCeA6jtrCnPFoj+x84rNTMFMjj3GGNlw+dJBgGZMoxHFOK+hLJ/Db6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=b/q7LDjR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="b/q7LDjR"
ARC-Seal: i=1; a=rsa-sha256; t=1750413294; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=buxEGVBXCHdiuRG7q6sV4d7yeqisQewFmfTArcPMLDMJpVhZiQuhXPN4YH3nsW4EX4A+94uzTa1+mcC9m8i2tpwyZ0YeeVOCMpH8ZmrCpMxWXo+DplH30C870y4PqeaehgSZDEaWTQUTWGuDnJDI/meJgM7KOSAXBSw4B5kIcO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750413294; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PwxAthPjmI1ic6P01b6IWTuo7e6HnLmqXzNXxwM6Kuo=; 
	b=UjItsuDRwJWVwiC9s/iFH6yZkARBVy/bUrQwerP4Qq/Z6QProSOvgVbEpymy1IfInMue2XZhMiKIQZv1U3jzMDr5KTL8hSrsrQ2hZW9LzLdDt+YKHzhoauu4oVQYwqcm1UpxZEFPL9CMD9ujT0qy+6LwpkOj0bPjIe6Tgdf91IU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750413294;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PwxAthPjmI1ic6P01b6IWTuo7e6HnLmqXzNXxwM6Kuo=;
	b=b/q7LDjRPLKkw0j9TTNYtSjmnIfQ0z6/o4T8vE45q5PeXmqtyVFcMk/sRT03KhRl
	tF5z2L3pGW/oYrbRtiwIKTKc4e0wmJDztFMJ3KVwtmtp9gCtQnGtnIfU22blVE1KTen
	jfna8vqrDKhd4aPBUALRvOsCv8aXhBQhrYalZeEc=
Received: by mx.zohomail.com with SMTPS id 17504132917981020.3930091890192;
	Fri, 20 Jun 2025 02:54:51 -0700 (PDT)
Message-ID: <34c871c9-3367-4b62-b2f8-11ed7d3482e5@collabora.com>
Date: Fri, 20 Jun 2025 11:54:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-3-benjamin.gaignard@collabora.com>
 <n5ddeogrpgctrljnxjfxqaz22qfnxsgm6ro7qihbjeyhd5br44@ojlzlz7gsuzb>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <n5ddeogrpgctrljnxjfxqaz22qfnxsgm6ro7qihbjeyhd5br44@ojlzlz7gsuzb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 19/06/2025 à 16:19, Sebastian Reichel a écrit :
> Hi,
>
> On Thu, Jun 19, 2025 at 03:12:23PM +0200, Benjamin Gaignard wrote:
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: verisilicon,iommu
>> +      - const: rockchip,rk3588-iommu-1.2
> The entries should be ordered the other way around, so that the
> "generic" compatible is the fallback. Also the 1.2 version is from
> Verisilicon. It does not really make sense for Rockchip. So I
> think it should look like this:
>
> properties:
>    compatible:
>      items:
>        - const: rockchip,rk3588-av1-iommu
>        - const: verisilicon,iommu-1.2
>
> Otherwise LGTM.

Thanks I will do like that.

Regards,
Benjamin

>
> -- Sebastian
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Core clock
>> +      - description: Interface clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: iface
>> +
>> +  "#iommu-cells":
>> +    const: 0
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - "#iommu-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    bus {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      iommu@fdca0000 {
>> +        compatible = "verisilicon,iommu","rockchip,rk3588-iommu-1.2";
>> +        reg = <0x0 0xfdca0000 0x0 0x600>;
>> +        interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
>> +        clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
>> +        clock-names = "core", "iface";
>> +        #iommu-cells = <0>;
>> +      };
>> +    };
>> -- 
>> 2.43.0
>>
