Received: from out13-75.antispamcloud.com (out13-75.antispamcloud.com [185.201.17.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF82135B8;
	Fri, 18 Sep 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773034; cv=none; b=LBtQg15dp9t3Hi8HqzP8t5q6qvSSzYtDHQJIAdsBdFzw8PdVOcIKSFgi0SmQY9KaWSNkRLbPLT7E0XYzz0EvwBeZzOmKRtSBFCmUKYPO9jQPKXjKt3+gp5Qd06j2w4tCe5XwhmDYdvUatSQVe6L3sdJ0s0pEhSsV7BebZEMRGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773034; c=relaxed/simple;
	bh=/6CKCPe5NKSJf4Pp90nvOGmgfKX4k0Rm+VSUMYFOlW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWaaYuYum6BmUIZl0cAbkDY+wL68kL61XIBMtKCByN2mbNwY7WDZ5H7/AEhYNpoC8IDU9z3DmXTOnXDaWLaxlVxnswMbOkJ2Ze13x029kS94i07xFmC1jc2L2RBVoCT0XLjE3QYE9/vWVoVPEWLTKA4Yqo3eOGrYoW5+WpsIDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=Qgw2OE+g; arc=none smtp.client-ip=185.201.17.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="Qgw2OE+g"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx323.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x7fnO-002Yl8-Bb; Fri, 18 Sep 2026 23:07:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=4x5/myjxPO1OExIcXHbLzVf6Ck/Kseoniz2MwqtIlwk=; b=Qgw2OE+gVwN8
	dIA2u6uR/kP9kZwFCPlNiv9r8XO4dKYVJfi87H7UfZQF8NntRWPk/+nNvPlshITbkSFzdM+QqtkLw
	z+hGVgJWTabVMByOepyMZ3PGS1sPZERBmKvdytD+atd+KFFNtk+BjPw3arGD003ZBJmzOl0dFIlUK
	NtlPmUVZRg9A8ZX4yyLksB/9kGGXCrZ7GqJP5cnFCxaM65qOyiSfAotqb0AdAZ2+0w5DG7P/lhDvJ
	PY6umONduJaRNGPNYyZHolZRtwRxH0bwSDBQOTfyuSnEr4E46epW7o/QcNQ6RG48mlI02shyE5LY0
	xbmlOsWYwBUqLjzAJBIiRA==;
Received: from [188.251.249.2] (port=52294 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <dan@reactivated.net>)
	id 1x7fnG-00000003DTq-3iaV;
	Fri, 18 Sep 2026 21:06:48 +0000
Message-ID: <29bf6c8a-1689-4fda-b605-c972e91d1c73@reactivated.net>
Date: Fri, 18 Sep 2026 22:06:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: broadcom: bcm2712: Add GPU IOMMU and
 IOMMU cache nodes
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com,
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260909-bcm2712-iommu-submit-v5-0-2539c52b249e@reactivated.net>
 <20260909-bcm2712-iommu-submit-v5-5-2539c52b249e@reactivated.net>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <20260909-bcm2712-iommu-submit-v5-5-2539c52b249e@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXrlO9wllOTdVCMR9b+jbqu2wFwG65a4Qh3
 wUjvFN4P7Su2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIMrWUWuUTR6VtpnMiz/VOrxGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb0iZ5sDJvU3vQetKu48NmiFWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKclZzoe+TZdeH39wA4E
 grA4pE2PuLHIFQdBY9qb1rRWgyz0f29FZkQs6Ir87R/YNAu4LTp8S3dP3ahgJ5Qcw+TYW/Yi0hJk
 8x1QQxCxZuYYqu1Es/mNlaSZ677NPMmQgxXznb05WiC8jaGsg2zWAtSwOqsKFjyOw6ht9+0m+2HK
 hyDZczNB19Zd16i8m1k/DGgEQyEoi1/j5tZiR031ah+gQPOIjlkSAfAYMUguLL/iJyO1DBoi69uN
 i8SsHHKkwfIcMf/IXZptVL/AvAk4qADKpWAtS6hgL14V/ocDGzv3txBOv3jFjgsNoFxTfcJiJyEa
 2OI0tSy1D95E625Y16tBpucgO37djUJrXU/wgrKuQcWSKoKpHc12nUrWNUzw/3DGQdeBNIkLb6r4
 7afaw/CHM6llfItwtYhKi/k9/RA3UB2LIFGgh/QiXjPxB1Apcw3AHj9py9u4Cvw3T1rOV/d4D61d
 j5p7BYnIfUPLdSLTlKS/neSdJxr5whbTg0m4/7LGifDpq5EYH46qR+vFm9wC7ren9RtRNyYim5e3
 GD8LGQOAW9bE+k+gl+anV+4sNfMDJFSfqfmiZ+On+h6teTV37eoUTJObIfbUgxRJO5so89RJ9UeM
 S3sx/LZgkEzT4R77BsVio7IvGyM4VI1B3eqGna9aZwZynFm29FaFzEVtpg4br2+mEmVJrJM4fd19
 PqjIyvGxWL1rN3cWjPD5viEZJolz8ClgrSFC0qV2pwUtO92lcKbdXd1aPKEJfyZsBP+3ojxAc8lp
 0sobbdB+F7B3Y8TjGBGmQjnZT0wGxghmQiiyHai0+C+cV2SwXGGBGRJoh9VoIekQHpwUfpYnEThm
 JIBq/vl4T589Eoyw88oKK2k2juCx8jpJuYnlmMrz5nN5IXEFyNeBSpOL6XLQkK7G/nvATdPRNfRC
 ogKUBoiGk7+7TY+LxsYMBY14CoC2k4ZFj2kpuIv/9gSqTljzmaSLiwQzKw+6v3CaIMG6s7LqJEBr
 r4RYD5fnTwa0tMnLz6SKQpgZ8zVbGmL5ozttECcg597p245AIcvvY28Ycjy4wX5942JtwBlZxZwg
 qgCXen83SxxqV8dQK7QbjvOnC/QU02F0dRgAVZw81E22mZaseAdYAUt3zF2gN7skM/50TVH1H/aA
 warQpYDOYx/6JtUORHHV0k7mR0VPG9HQWV7dXfBjXbvxH2nMLfV+SMGovieHnQDrcLDN17YMjSrM
 Y2oTcPJOcrZu7OKsSObGAqhi7iERbInMiTBIUBbQ/Dy6Ip5s2Cc9h6F0bzi9eJvFy172Pif4H4Ku
 78pBi/ZAqnPyI/BjXbvxH2nMLfV+SMGovie1ATPpp8i1sHWZQrJ+tLuI
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

On 09/09/2026 21:08, Daniel Drake wrote:
> Define the IOMMU and IOMMUC nodes for the Broadcom BCM2712 SoC found in
> the Raspberry Pi 5. Enable use of the IOMMU for the graphics/display
> block.


> @@ -667,6 +680,7 @@ v3d: gpu@1002000000 {
>   
>   	vc4: gpu {
>   		compatible = "brcm,bcm2712-vc6";
> +		iommus = <&iommu4>;
>   	};
>   
>   	timer {
> @@ -701,5 +715,6 @@ hvs: hvs@107c580000 {
>   		interrupt-parent = <&disp_intr>;
>   		interrupts = <2>, <9>, <16>;
>   		interrupt-names = "ch0-eof", "ch1-eof", "ch2-eof";
> +		iommus = <&iommu4>;

Found some issues here: the iommus property needs to be added to the 
dt-bindings for this to be considered valid, and actually, it should not 
be added to the vc4 node (that is just a virtual node), only the hvs node.

But that setup triggers a warning from the iommu layer because the 
dma/iommu setup is established too late during vc4 device setup.

Working on it...
