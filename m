Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3B4D4868
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284373; cv=none; b=iZDxhFOVVdOicqU6GLn1Q+pC/hUKfzaEz/F/fkTAMQIshdK6BkLDR1PW+1vreRKu8H/0KDYx9OWUrqAxPXwRh0IOePtNDdct+ee4ND05FGJY3wkrNFkYyr0Ha/jXFV+TD7G10doB2oCo9UZdwMtwjyDfwBXFuDZWY4VR36VZhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284373; c=relaxed/simple;
	bh=rlPdolT+Chhji/nEjBLdBkwo9wL9te5/uKOfpt6lX1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhlnpAP0miFnefjfYcvc9tMda0beuFBCkjtvuOWFkdD7P8/mVDZI0Tsra1w0rK6KFd/6n4g0s+Hw/p9j1iQExopkXzc2vP5rLiGwCaLsZwmHh0OKZ3r8i1DW9JxsshgQFU+m4ub/yr16rF+TIXkvEdO96gGpYr7rxJx7oMg2EWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AV9lK9Up; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AV9lK9Up"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-98534213173so29080241.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 14:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284370; x=1790889170;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=skcWtpxGtZJwW4Q1vAThTtylvAwrMeApRCrXkDCWfgY=;
        b=DFQnUxbz4TcUmdPcLEXzduTEMGfTxMul8Y08fu0EbnhaDifa/CfhITI4XaiId39gRm
         2lsFSeTGCoISM0rriJcFWF+fHwt7Q8ESrGz5+pHGA1NWH81QOc4FW/+bX9OIS/EhSRCZ
         ImbjoGPpsF0pDUwFaPOP7dsl/sNl/JLrAz/ayY7qrnwQr6M0RqHiKom/6Bjsd3yBDkA7
         jiyGl5Z3RIBcpHp+igzJfJ8Yw0NfG6nmGKeotNI6XoA8Rq4a7CjK8pX5vfUTz2LGGWSl
         BdKlB5EvtX50EEWJqDG6p8r3Qi0WB8UDx/ueDP8xmdDletFEuZQfy7+0SvK+UPIAxXLN
         UODg==
X-Gm-Message-State: AFuF++l10nmrYCoc3VvnBdUbo1wjAau7aFlPMEiKa4HH2+2/pppS5Ify
	qfdIxKNEZJP20ziMZfeGfXv9JPa6vLjwECnf/Bi/rVNNCNIuL4xn8nzCVitbFocUbO05CBsBxYp
	nlFfqPBZertB2q1+hQiV/ma2jYIKkwkWN/8zjQvej/QK43yD9coIgUV98PYaNAqdoRWBFNEY8OA
	FPK0HgUXSqFbSBPVarWNgSp8HuevzftOEfvuwPB/DnMPaC7eL6ZEmPLe8ZV7lNXeeS04hz5rsX8
	QiKM8qACgcYmr4=
X-Gm-Gg: AYBFou1fDFGHbLx/xBk22J7ofmTW2VSNjUU0r0jYo67SdpI3hOUcwVJpbJFwTQB5Inh
	zjpcsWZzDE9uEgl7AA0HpSQrGrNxVixye1f4Y5qFuS6xppI2IMqfrsormWHoD2vnkHcjJ7e20wV
	qbGlnu46whAb7Sbx72eeqpQl2Ss2uyXecSl4gxrkKdOUk2LZ3tFZ70jdvcvpaSwizjSMlEBNo5s
	GQG/mmukJehicOCRBrxbjt6tzrLMN3ZT5F/R1VpR3DJWfcbbPSLjfgN9mWedFyZNVCSvMwE3cbT
	6zsCofBBarhsakqEDusqvhUMj6Th5EeyfYQry11EgA1LRtdzsUz7uo/nbUdqTWjzgno1AToduVb
	7wMyACuGmHo7awh8D2rCedVL67C7QU8cHuwZRw0/DEJu5G6rFJ18PNzBKWJ+qVC010J+/CxKvSo
	u880ieg45Q5ON6NLgRTqQDWUtdBtG9PA01aQLzrjSS
X-Received: by 2002:a05:6102:a4c:b0:7a1:f7d2:e832 with SMTP id ada2fe7eead31-7af1d4b7598mr1661982137.18.1790284370458;
        Thu, 24 Sep 2026 14:12:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9861af46516sm54693241.4.2026.09.24.14.12.50
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:12:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so54052985a.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790284370; x=1790889170; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skcWtpxGtZJwW4Q1vAThTtylvAwrMeApRCrXkDCWfgY=;
        b=AV9lK9UpwrgDbjMquJRVhB3jydhfmE+VYRCohv6k4csqxXSGz6a5o6ApS/t5Mn4VAD
         emNt5NuYa+BwPrDw7RaLSMdeLpVmD9b1lWcdH2SqJ61Stti3IWQgc7bG/d9ZkVdKLzVd
         XTxYrkknya3awSpFAVx7hdIsWwcRx6wv/2dmU=
X-Received: by 2002:a05:620a:8389:b0:939:f8e9:5e19 with SMTP id af79cd13be357-93c43c2f3ecmr105807485a.1.1790284369796;
        Thu, 24 Sep 2026 14:12:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:939:f8e9:5e19 with SMTP id af79cd13be357-93c43c2f3ecmr105803685a.1.1790284369353;
        Thu, 24 Sep 2026 14:12:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448eb2a4sm25619685a.20.2026.09.24.14.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:12:48 -0700 (PDT)
Message-ID: <7eb8da6d-0c09-44d5-979c-fe0952b92018@broadcom.com>
Date: Thu, 24 Sep 2026 14:12:45 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] dt-bindings: display: brcm,bcm2835-hvs: Document
 iommus property
To: Daniel Drake <dan@reactivated.net>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com,
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
 <20260924-bcm2712-iommu-submit-v6-3-7b3cace86973@reactivated.net>
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
In-Reply-To: <20260924-bcm2712-iommu-submit-v6-3-7b3cace86973@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/24/26 14:10, Daniel Drake wrote:
> On BCM2712, the Hardware Video Scaler (HVS) is connected behind an IOMMU.
> Add the optional iommus property to allow describing this connection.
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
