Received: from out16-31.antispamcloud.com (out16-31.antispamcloud.com [185.201.18.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55735AC24;
	Thu, 24 Sep 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283756; cv=none; b=k2BgMrqobcqr7golYKP6iDQOASQHac4MslglSTYIu/16N4S3mje75RHvtpDkkr9jnB/uyOZ7w5mU2DoP0vLpfcG4Jnm/hmibtSAJpVowHOWsyfaiKrh/zeLQZMGh8Wim2STNg23iw8aFM3xvCG3S50oLyjROmuuK6IiidbK0E9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283756; c=relaxed/simple;
	bh=68YIcqXIEF/kPMUkzpQZ3sv7ReLsVwsj+i1v9U2ZKc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0Co73vzTK0gEIOgOPam7KBIcyo5SsQpllvitx9gKTjVSrFwDloMYtO6Jn5cYizeeRnc5er9YDqMtwKe4mwU75MNCOLOtr4eTU2q4hkZfd49Lu2IYa0KMdB7CxWRpzd7lb/0rphOsDQ3tdOKOPPaY5vdQuiu/LUheMXm2orndiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=zac2eTzd; arc=none smtp.client-ip=185.201.18.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="zac2eTzd"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx321.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x9qa5-00ECoc-Dd; Thu, 24 Sep 2026 23:02:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=fSLpZABWWT2QC12oVoBVzQDjxUCLfjlwQF4+Oy3kyjI=; b=zac2eTzdql0T
	Vf5p6kKLl6WKpbDW5ahZ8XFqA4eAWqgegNhpx34OHYkcE/0/qjTwFWv6sZGT+wLrq4Q0mqcHfPrSF
	uVbNxPkoRp9iAUchqyH95vsfOE5sLlyGldYcp2TtFem8zSSsBPv3xLfDMYztfpvQ0x3bdk0CEJxV9
	0GIptReVBAdg9VsedBkdT30Aol1eJxzTKF7oHm4FECbrrV93yhGT1RaNbxAd5GxGDrAHiyHp6tv2K
	zG6VaRjK8N2HRX85qbzykzzcpAvYA0cqAKyE/Ws0wrg5kzmjCbqSshHJmlGszBNwHAZtFku96WHme
	ZWEt1eq9/gPqBZX5cLXFIQ==;
Received: from [188.251.249.2] (port=60568 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <dan@reactivated.net>)
	id 1x9qZy-00000005v13-3u57;
	Thu, 24 Sep 2026 21:02:07 +0000
Message-ID: <19ebea19-c7a6-4135-8abb-1f139ce1f74f@reactivated.net>
Date: Thu, 24 Sep 2026 22:02:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com, james.quinlan@broadcom.com,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
 <arUJxhEDFYSIUp4e@8bytes.org>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <arUJxhEDFYSIUp4e@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUI6VlrppaKMI350tzbitpsV7EYtdIDduUM
 IbM3yETjliu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVINB+PBQNEtUhkVluwFFCsX/GnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb7ubyJcscJCC/8jhyq4eIIJWBb39
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
 JIBq/vl4T589Eoyw88oKK0Ika8ptpD+DyUmjOrd9V8i0AjwQSM6AQD8AM65nbdW1/nvATdPRNfRC
 ogKUBoiGk7+7TY+LxsYMBY14CoC2k4ZFj2kpuIv/9gSqTljzmaSLiwQzKw+6v3CaIMG6s7LqJEBr
 r4RYD5fnTwa0tMnLz6SKQpgZ8zVbGmL5ozttECcg597p245AIcvvY28Ycjy4wfZVgO2+xlhjYQtN
 TOKCWKLh6v5HXh8xAM0W3+ESyNN702F0dRgAVZw81E22mZaseAdYAUt3zF2gN7skM/50TVH1H/aA
 warQpYDOYx/6JtUORHHV0k7mR0VPG9HQWV7dXfBjXbvxH2nMLfV+SMGovieHnQDrcLDN17YMjSrM
 Y2oTcPJOcrZu7OKsSObGAqhi7iERbInMiTBIUBbQ/Dy6Ip5s2Cc9h6F0bzi9eJvFy172Pif4H4Ku
 78pBi/ZAqnPyI/BjXbvxH2nMLfV+SMGovie1ATPpp8i1sHWZQrJ+tLuI
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

On 24/09/2026 12:30, Joerg Roedel (AMD) wrote:
> On Tue, Aug 25, 2026 at 09:56:03PM +0100, Daniel Drake wrote:
>> Daniel Drake (5):
>>        iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
>>        dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
>>        iommu/generic_pt: Add Broadcom BCM2712 page table format
>>        iommu: Add Broadcom BCM2712 IOMMU driver
>>        arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU cache nodes
> 
> Applied, thanks.


I'm assuming you didn't apply the v3 version of the series, since that's 
an old submission and you also just acknowledged my plan to send a v6:
https://lore.kernel.org/all/arT-U_Rp0ZFMyCD7@8bytes.org/

I'll go ahead with v6 submission now, but let me know if you prefer to 
handle this another way.
Daniel

