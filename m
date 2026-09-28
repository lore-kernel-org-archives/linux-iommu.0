Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294239B96A
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620015; cv=none; b=dmoiiueXwY7YqmXqiorZH1TCLYs1dv2tpzemCm7qm5dPPa4Lcys8BBXS8XZJ+CgAAuqHkKhc2EhTfiFZkjWfnul27JJiKshkhtT3wX3wS6pUXJpfVghadU/GjWS8tQGx3Kw6hUNJpPSS3Y2sK0AOtCQ9nFCzr01ytbMT103do68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620015; c=relaxed/simple;
	bh=EpikG7Z0U6spB0qXKcgHsc68xeElTBeYTJAUVsrk9Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNGkv2WINweJ1TPgijtW9LvGQjYv5mlKw0ikwDJhkiDPq8zyUoEcH2nYh2vztbVsrupVohKYkjYOhZsk4XpX5AalMoycg6tsXi8ebNAYOBxZVvn4eQUsvbeG4VPsnm372Fu+UJmesdjkXrqN0T28PJ4Ha09dkaQRhbaCRpjNEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EphBlklo; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EphBlklo"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-674183ca360so312485d50.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620012; x=1791224812;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FuQw+B0kSq5FJU56nD6/IW5lKXSJDgEpfGuGLprZ8a4=;
        b=n7loTx3JWQLryi7Rtb7UjLfz3TkqxFjQpPjASWeJ5yl6FIFfNaWsQxYAUQPCkvamgR
         49TQrgS1ZNIO0tVpntHojxiFRm/dkXQsQ6ItMwYjJtfBehyvcpACKe+x0Xts0LuDlyDq
         MG7BrtFYM4ffThfMGOQMkZm+ku2txwiipM7dL6TZk9+tIi9qL39ElX7pdsoVEqwW76Yi
         Ybov4tm3YkfJOls8Un8Z2hjuwXdVPcByJbRqCRUpxnA72H48uioFTd6MD/krdW8boowe
         vR3HXC+4AcOkADuuFGRnVMOCPKLcoeyUD5uP/mjCkOctxBnlGTdAYi/7QtkE9efN5EJH
         P7ig==
X-Forwarded-Encrypted: i=1; AKwUvBzhALssroxq2b31XJzjMRAZtyd9CBgPDRjb2SI0wsT9JVB2V8lEQoJ4i20wE2Exwyny3CPt6A==@lists.linux.dev
X-Gm-Message-State: AFq9FYI48OJFtNuNIksOWgR1F91Psxbu5EWD8ApvQFCbPNONosHCnA3k
	1ST0KQPRv+auz6uwfZ9Q4jG9A7RpOa43opHXqPuvj8vq7cO5imy4wlHexPhmYr9w0K6AB8Zv9h+
	276OkIVwwG966bREwtgaYiN+UyL7NjbnNEJzO07ulC0nh6GxnkeyxjMRjSsA7Br75Xyysev3pR1
	emU4YOCwE0+2mE/7Qd0KlJ0zfSYGG5u4yzlY3K/oX+Dfi8PGddNdDZKn73/W4MrIUjlcXnHZRXV
	3USNewpqQw7VbU=
X-Gm-Gg: AYBFou3cxQYTEGhnpv2cMpTgffZ1T0WqjV6bg+VsaF6eYon/mqJ/vFDbe7oPq2n81eU
	0wD0Mq/fy2nUcFHU4nIFPxJkV5K3XlWzXVH+rlXKwnB098gUHGwSzO60aqDgOB2w4W8FIN5piOD
	p0DpPTqjAefG/tVnQrtC4tY5fRG8FASZZOyR3ndZ8wyaZR+XgOHclcFDKWH/5mbeXUV3+xgRSNU
	n4vsNBo01UpARakf+KapJV/sWEDOuCzxNUiou4HanuJS9ZfAsiC/+1P2WACO2K6Wm3WqxfoaHoM
	t749hOO0bHbvP5FPhLOL+0jzO19fSp2TEvWGjDEffxqTKzn28OyEbg0lUAMJ6fJ/E7e3RYHfTzx
	ffy+6bFhS2VO9Vy7gRkh2zlXNjFBHXZH4a9wCm63k3uQt2TRJM3hjlLKOU+JEwaYgVMBxYKMxki
	tyDQH6w2twutEYeerXiZrz8Jw5hiFYKrAfSMv/T4Re
X-Received: by 2002:a05:690e:1c09:b0:671:33f6:721e with SMTP id 956f58d0204a3-6741124f8cdmr3747427d50.54.1790620011810;
        Mon, 28 Sep 2026 11:26:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6740ef7e5e7sm1487154d50.22.2026.09.28.11.26.51
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:26:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bfb2da664so971120185a.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790620011; x=1791224811; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuQw+B0kSq5FJU56nD6/IW5lKXSJDgEpfGuGLprZ8a4=;
        b=EphBlklocq1KmmoCNRSZU5hXo0Ujxjv85AQG/FpJ6RuNRjKPCv+DgN1S670XGWxW9/
         h0ILRbwfIz3w2y7V/PfM9ALVhFeryR06pVc1TO/ReAg1rvMUwRBze4hIONA0eeczON0E
         sZYVKEqntsY1XQkmVtdTGeYRA/UHWNOgr0+Kc=
X-Forwarded-Encrypted: i=1; AKwUvByIceFFfN815YJ1kR8awpwPd/B2qUAK4DSMuwKXoDE99rNpeoMtRfBKxmkkUwLpQzslAA0AJw==@lists.linux.dev
X-Received: by 2002:a05:620a:7117:b0:93c:2c15:e51d with SMTP id af79cd13be357-93c474ff392mr2182137585a.46.1790620011096;
        Mon, 28 Sep 2026 11:26:51 -0700 (PDT)
X-Received: by 2002:a05:620a:7117:b0:93c:2c15:e51d with SMTP id af79cd13be357-93c474ff392mr2182130685a.46.1790620010447;
        Mon, 28 Sep 2026 11:26:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c8147c4desm205669385a.39.2026.09.28.11.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:26:49 -0700 (PDT)
Message-ID: <6b61fc5d-1f4c-4634-8d61-2f090f0f7c3d@broadcom.com>
Date: Mon, 28 Sep 2026 11:26:47 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, dan@reactivated.net
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260927-bcm2712-iommu-submit-v7-0-dfa2b975cbc9@reactivated.net>
 <arojDdPH1o2ckB5x@8bytes.org>
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
In-Reply-To: <arojDdPH1o2ckB5x@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/28/26 01:19, Joerg Roedel (AMD) wrote:
> On Sun, Sep 27, 2026 at 02:08:59PM +0100, Daniel Drake via B4 Relay wrote:
>> Daniel Drake (6):
>>        iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
>>        dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>>        dt-bindings: display: brcm,bcm2835-hvs: Document iommus property
>>        iommu/generic_pt: Add Broadcom BCM2712 page table format
>>        iommu: Add Broadcom BCM2712 IOMMU driver
>>        arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes
> 
> Applied patches 1-5, thanks.

And applied patch 6 to devicetree-arm64/next, thanks!
-- 
Florian
