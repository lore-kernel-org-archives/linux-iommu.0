Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5B44839A
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775582; cv=none; b=kZ6wt8jcJ9aw3XcaJZjVXDZL0gSpYXsqT8hP7cMsLenk26v3459bqTo6Lji168OR3CVbiHDgUJ6sM1wlZx0IhaMpn/vCGYeIagJFyb1KgxYBIlhmToG/se3auMzuOHIdZ6A+/X2+d+JjlaG/+j0UyccKF/AykYvPPvigUE2bte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775582; c=relaxed/simple;
	bh=JGIElWR1TH2NMfiEhiBJgGaDbYGgOqDPtEOc4C1/2D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTneZuPYurhnCAb1G6bUEtOHiDoB2x5L8hzeiQY4riquW/mBI3q/nduXulxilRtO30gqz+it96bPl752GrUy1SQoZnhtzUxU/9c/7GRajIXsSV8fX23wzCQhwcjFTXGr1TSwWH/qx7qSntHWH9AK4kqtxeHSRf4EceLNsB1IuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N5wK67lC; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N5wK67lC"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-92ed3993c1eso79636385a.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775580; x=1788380380;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/6rNKp5zlYMpk4fONW4RGx+rrtp5DhLmtBHfLZxwndU=;
        b=VajW2uWjjmozsAs/Jpfp+oreWErapAdZGECkeF+g5HargMDKHmqLNAXsSxZA1Tz5Sw
         YAIQkr3g65tfmQKhnYDxrO4TeXjmgulWGkuVV6eK3rVizd3F4zKctCx05LwofQTlpISK
         bmdM/guwr+XHJSLqoiWYSZ5Vvt2Lx4M/H+Ki3mmGSF2sZSl+6mYqHP2P/gvutUv36SNq
         JFDg/CMTYSuqzeF4O2JY+JQiuLvGvBBWCbSU9LT7fzUvBrLR7UMtIfBm6REBz/8WFLhZ
         LE4+/647tyRsWdp/8cksCtjLJ99V0RjqzMNJ/Z1BjSQpC+BylfQj0Uu/9X3Hg6yVYMg8
         RUpg==
X-Gm-Message-State: AFuF++mIoyTkEO7Z77VvNiFq+MzFjAcMK7+n3+/1ErfxvPPeb4qkLIZO
	9d0ip8XsnKFPCn7WUOTEQcaB5hClmS9jjf8u7U11fDVMXIASRW3IPvUVFIsQ+xWvMZ4PlUmgZYV
	Ox0jY7obxyZp88PI8e3WdU5T1+Q+dt7TKXCbWQaL6JqidGEHTuXnOj/rg69aQIqHmT9o/Kv50Iw
	1RWBvyFxNHJRBnUnSFZWZSlDPfippLnW5xbOlLEQIpxhZYNdWd/pHP4PczhLzuRZLS3/X+2lWuT
	5M+SIIv4TOxO7g=
X-Gm-Gg: AR+sD11WbTzaGApm+ChJKGmC6HDOtDv0Gm0eC89eJcSXsQ1Ga3Pz0yEh51xm0siTObc
	vqqTsLTj68c4oVbJv+yM9+Wr0QXjeVMTsXbdkrXlvt4YFSozpK1Ly6pvM8n2zyVlGBbY+8s0/4q
	0VqLXLra0Ul4VH6DsGNEKm33gXd10fOq7VfrotxgR0uhhEkQwE2r8KmRwZN+yPiuomE+vkNvueb
	Jcyw34T5s2bzVCxUy2rwo2FqVuqc22zBJ4S/hYtJqXZ0LUVKrVQ91Ku74einDuxXf5+KNO+uEBD
	ROJ0Zlu6qVh51ADqiKA9nhbviC/0AqU2DvtYzvqYwGr6lhg1IQkmjIP3zo4f1doloe+56n64RaP
	TSYPHbvt89N0o7VVV9fcKfOo97pmRnwVem3gRxOpnmIRWGN1jeUovfQKZLLEhchm7ArLUz05CJn
	AKHxd12ap5xSjYG8NwCfjrVg5+sU78RPkdG1cUSB4u
X-Received: by 2002:a05:620a:2612:b0:937:1538:6b93 with SMTP id af79cd13be357-9378043f36fmr1037063785a.40.1787775579612;
        Wed, 26 Aug 2026 13:19:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93782458923sm50340285a.5.2026.08.26.13.19.38
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 13:19:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f75c1219so28219685ad.3
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787775578; x=1788380378; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6rNKp5zlYMpk4fONW4RGx+rrtp5DhLmtBHfLZxwndU=;
        b=N5wK67lCK+f5KZKw27LdthOlljSziza4AO6NkERxUPhuSnRyL5Ox3aWqujpzSJJhp/
         vzu3XRB767GG+GXzoUtf0oYCp9e9p44cN2tNC3x26Vf5RPFSPuzQuzE+jCVcHGaF/SCd
         BwDkZdJ5GCSQU7YVFAEIb3jHeAfC9iXLVb+eU=
X-Received: by 2002:a17:902:fc4c:b0:2d7:7cb:a44a with SMTP id d9443c01a7336-2d707cbaba8mr182678785ad.11.1787775577886;
        Wed, 26 Aug 2026 13:19:37 -0700 (PDT)
X-Received: by 2002:a17:902:fc4c:b0:2d7:7cb:a44a with SMTP id d9443c01a7336-2d707cbaba8mr182677995ad.11.1787775577440;
        Wed, 26 Aug 2026 13:19:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm16611574eec.5.2026.08.26.13.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 13:19:36 -0700 (PDT)
Message-ID: <e073e341-76c5-43c7-9e0d-e7b3f10007f2@broadcom.com>
Date: Wed, 26 Aug 2026 13:19:35 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
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
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
 <20260825-bcm2712-iommu-submit-v3-2-7f143e7289b6@reactivated.net>
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
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-2-7f143e7289b6@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/25/26 13:56, Daniel Drake wrote:
> Add bindings for the Broadcom BCM2712 IOMMUs and their shared TLB cache.
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>

Only if you need to re-submit, would you mind listing Jim and myself as 
bindings maintainer for these two files?

Thanks!
-- 
Florian
