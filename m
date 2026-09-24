Received: from mail-pg1-f232.google.com (mail-pg1-f232.google.com [209.85.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D563C0608
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284120; cv=none; b=tXMk1cTFgUTpgvGp3WlPkxQz8Mhsx6XSun/q3gbMVh0ExFwZkYBuMxmv/CxChi1CNl2p8CVxHm1Yi9D7+sOGahzoesYnzUECdlrgQPts1rde1TtkNmvLUuQtuFsVBkImzJ0wN0Y2dJPHx2hwA2uI4HLQozbXuF58qEh8g8QRqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284120; c=relaxed/simple;
	bh=iFA4JhXbq1qLV+Uw4ikJyL3iIiT0QhtcLZXONqEw3go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1MD3JxPnlT4fi7+9JqKwOI3hZP/Kp42Pm7Y0b9l4OXbL+o8kNcFGL/N8z7e1+COPVAKIecVDWFQtMe8n8PBLPzs8ATq4Y0YTFDcl+X6Ksfll3YII/vwWVIUwjQ9+/9UrlV06SIJ7AViTIgUZ3BwyI2rwHpSVkoPJhPNIOvIAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N6iQqL/Q; arc=none smtp.client-ip=209.85.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N6iQqL/Q"
Received: by mail-pg1-f232.google.com with SMTP id 41be03b00d2f7-cc4e9e56e9aso46046a12.2
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 14:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284118; x=1790888918;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UAD7zwQqN+OPa92RBnAFe2Ct2f8yZB8iRkC4rSgwxKA=;
        b=vdeFUnlOdMU2bbCbQFghyM5QtgW2fujdM8mx6oOnS01qjQNezSMlYBHb9VyIqRu6w+
         1yeSCD3wmxiribLQgMS3qKBF4qX9Yra9ebX82LINSVKDSwjSCndEeEOaGWAkP0oWqFA+
         TyrlJvJ5hu9PgAMLgL0Cos6K2zy4evZ5IAKQHd4noXiYOLpiM7as2IpKezMhQvXImRQ1
         LjTjrNdYe/UC2FF5I62aXtvK72trKH/ILh3axiqAY6SrEZfTtDR0dBNthpFXd/xdobdY
         8sAWkrIb1PprMDd6vStKZdsgRpQYysGvmAfRWxfoBOYVBhn3a93jx5lRv1cdOH/6JCiz
         jFtA==
X-Forwarded-Encrypted: i=1; AKwUvBy1dOsjv+Tkt3g/8QHCWqGsBGK2af0Lx8i3eiV6uuRY2XWc/SGw7DSxkYx6Ks3gBydlb7sBBg==@lists.linux.dev
X-Gm-Message-State: AFuF++lANv6/RLqViy28cCZfBaNOMafI5B1nLdws5IeQ9eymNlbs/DvA
	xeFZXpU/zNd2RSoVUpqQa1HiIlkJsEf2uUw+Ri31UaoOoc2dDzA9bulllZ0SmtrM0gGfeA07/VK
	iYrZJE2ySe0/wEpJY7jEg9Zb93fq2+PLNh7rV7GgS23PhEu7cPg+52zRrIq/b0lp2AwvPRj+BQk
	jTmHL1XekBnEeuz0/dyUZyLWKWPQH5wT7Kdr/h2LskZ2mxsQGgpTsqAt7kT/oOmbXb54N7uA7/D
	kySNjoZ8HsQoUGxZQ==
X-Gm-Gg: AYBFou122m2F7tRjKSnSBiBKbg9o84MohIxZI3RL2zDM6eqNpTv6ttBZ1pSiuVpkIEt
	0f9gX5wmTDbt0oKxbI7LidoSXuXN7ZN+wX6encaUL7expUl68tcMcGOfC9t4I4wDGwodXa4MUL3
	TPBgM53IezXoHwdJkZIChqgw2x2/cWw6vimQcMzZnFgdoy9fOiTRlaIunvD3W0Q8DK0+VI8ufYM
	c63xW0/kurGVqSgUqTKjNcoWI6EOP9+eJ3IaT7A5lbwGGEXquRvOB/AbOYpwRPip7WlBJLFT4sb
	1otziIw1D28YOvK6dxdWncbwcyJjvE/LfOJVqUutftmFFdW/FtOAMoCeNGMgabVq8hl5W+i2lkC
	cKTvpfBo+GzvTqJ2jRD6nfa9MAO1++veEUSrQyTgbdVs3WEM/hrcdT8Adx1+9TQxccWbCVhGdV7
	UuBKEprJd9d1HnVXM+FW4sS+7EDZ72b3v9/jvvlr0K
X-Received: by 2002:a05:6a21:6f06:b0:3d3:ae40:51e5 with SMTP id adf61e73a8af0-3de0e750b0dmr3547940637.25.1790284117849;
        Thu, 24 Sep 2026 14:08:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7877bc2f9sm316445a12.10.2026.09.24.14.08.37
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:08:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c26012cd0so6654021cf.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790284117; x=1790888917; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAD7zwQqN+OPa92RBnAFe2Ct2f8yZB8iRkC4rSgwxKA=;
        b=N6iQqL/Q6XRPVLLt7My3pxrLeTfVswdgQD+E3OHYMBbQh2eTBP2JOYrJVjMZ8n05F0
         s5BvwBMQ4nwHc3g46vygW/buh1sZMLdemK0+rnMMOCV5CKqe5gNlChLD5MSPlFaQpc6Q
         9fL+CWlINMAwBlTMBbUqjXxPFj4aMKTQKYN68=
X-Forwarded-Encrypted: i=1; AKwUvBy27OjXFf/tGNDtrj7N3MsC1EGUCTpuTjJfNeQMcb2dmdVwIw1ShFCpgj73hRBUdoHddkOAiA==@lists.linux.dev
X-Received: by 2002:a05:622a:5814:b0:532:e568:7edd with SMTP id d75a77b69052e-5330b6cbdc5mr8966811cf.55.1790284116634;
        Thu, 24 Sep 2026 14:08:36 -0700 (PDT)
X-Received: by 2002:a05:622a:5814:b0:532:e568:7edd with SMTP id d75a77b69052e-5330b6cbdc5mr8966321cf.55.1790284116200;
        Thu, 24 Sep 2026 14:08:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0a4084sm2150791cf.23.2026.09.24.14.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:08:34 -0700 (PDT)
Message-ID: <ff78ffe0-aa86-4679-a983-12d393a0cd7b@broadcom.com>
Date: Thu, 24 Sep 2026 14:08:31 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
To: Daniel Drake <dan@reactivated.net>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
 <arUJxhEDFYSIUp4e@8bytes.org>
 <19ebea19-c7a6-4135-8abb-1f139ce1f74f@reactivated.net>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <19ebea19-c7a6-4135-8abb-1f139ce1f74f@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/24/26 14:02, Daniel Drake wrote:
> On 24/09/2026 12:30, Joerg Roedel (AMD) wrote:
>> On Tue, Aug 25, 2026 at 09:56:03PM +0100, Daniel Drake wrote:
>>> Daniel Drake (5):
>>>        iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
>>>        dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>>>        iommu/generic_pt: Add Broadcom BCM2712 page table format
>>>        iommu: Add Broadcom BCM2712 IOMMU driver
>>>        arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache 
>>> nodes
>>
>> Applied, thanks.
> 
> 
> I'm assuming you didn't apply the v3 version of the series, since that's 
> an old submission and you also just acknowledged my plan to send a v6:
> https://lore.kernel.org/all/arT-U_Rp0ZFMyCD7@8bytes.org/
> 
> I'll go ahead with v6 submission now, but let me know if you prefer to 
> handle this another way.
> Daniel
> 

Joerg, did you also want to take the DTS patch through your tree? I 
would prefer to carry it via the Broadcom ARM SoC tree to minimize 
conflicts on my side. Thanks
-- 
Florian
