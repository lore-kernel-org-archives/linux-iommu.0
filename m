Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB460446CF;
	Tue,  4 Jun 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488295; cv=none; b=jAQFwMR3XRkiCDpZJU4MP+/SZU6/G0nfyvqLAs3/cahFBwk58zYhd9PSP72iRTRolQOj6jA05Osh6AKKO+PXF2FxnTwv6ZXzNIYv747LMsmyx73eFZRAkwrH/o9xohNM4a4RtU6wNNb+Lgs+9Mh/ph4/Tk5wUCOBdWrCdSiyUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488295; c=relaxed/simple;
	bh=eufJhGzotYQO/wB5pebQ9hNTZ2+IitsAmtf4OoG013c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcgb2Cvmux4Zvxh3N/Yp2XFOR5qvCM0Iw4HzKDXz3Fe4Bn09GwDuzXPXcRvLp0vRDF30uBc8JUbzHkAtQg4sHxSwV4gKANLDD4DkAyd2vAonJRd0Cn671viPvfzEcjSCQtRmFAePSKCWi/bt2pG2ln6gyZXPpNINxZ11nQr55KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=j9mr7DEo; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="j9mr7DEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1717488268; x=1718093068;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=UXqCa0XptvgIpred1zczDXpXI9rILjNkiEd9vbGoU9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j9mr7DEoWtpcjfsblOEorUc91XcXg/OHaOyzVdCe+2HqCK/0fv0bB9nmyd7Zrolc
	 qWmt4NZZcLoloXOlBJfJuPwtEpKteiLpj18qZYDyBxo68Q2E8QMJeKNAIN1IRzDCF
	 E8p8cr7S12Uqg6Ew+KROLTj13vWnHQ6RnCv/uTFBmvtoe/2JhIRHbNo26aWv8caUi
	 KjGzOB49mg3le1R/mrWQfaoA531qrNL2j+O/cRIiYeABExD8WTeM5AU9ycUxpDTTu
	 rK2UU3Hi9V1+S8YEtpwynosluMKZe/QP3kqk9cZNX6ke9I7h4ijPVdzPFTBSBl8JF
	 mwqPn5pFTYgSpvt5WA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.67] ([80.128.165.129]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOzGc-1rp3DD3Ojk-00PMmU; Tue, 04 Jun 2024 10:04:27 +0200
Message-ID: <b8237590-e26d-48d4-be44-c0d884e3f703@oldschoolsolutions.biz>
Date: Tue, 4 Jun 2024 10:04:26 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/dma: Fix domain init
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: iommu@lists.linux.dev, will@kernel.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <159193e80b6a7701c61b32d6119ac68989d457bd.1716997607.git.robin.murphy@arm.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <159193e80b6a7701c61b32d6119ac68989d457bd.1716997607.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OcN+soGdAKSKnSO2NjId4WGmnb8wMNc7sZM+XuvY80M36wUuMrv
 LXE6itywsWLzy6fG02s+qTPgCfCPPnUOz0/vZRj3UJnUiiXKks84Qd0+v6klbuajDX23G3Z
 6tvlYjGOk2Glvcemt6O04g7ZbQU8C18cqZEdvGLWxHOHXTt4FLXJDwjXkvnJ2L6rhKMclnb
 4p7V+aZQCDYV5Kxz3Bcig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xdcExhbEqhk=;fOv1j4yEDtoBgX5w5WEtShNXvye
 W5dbjzXrQJ7vHCNrYTRhX9FzPrMLwsiyCpsJLr5G2Clf6HcwqQukYOEI0344Env/WwgwNAdln
 XMnL56ud1nu8BY/WX+zhUFAALlX0BGsIwGJLNM+WbWuVHhV90IQLgGyM1pIk4fWRp8FTEaeed
 foFqSN6AgB/lmxyW5oGnmhtE8iv+KiALyJ2NdA433k15ESNIcb/m1nItr87oWulOkmcL8LNKN
 bHaRB3sRnc07ATJYAq2VkMbThzaeq/F7XQGw+A5dk1aPCpTGYStCtyKUekWtdwlNa9HunPSEM
 YGHF3DAUw76erpzzwtS8Tm0XKI2xsxZy7kHB6S2pG6kP1uuoXU4ehGdTB4z0okqGOcHUol82b
 y5LsrJL3r3gtcodKQFhzhmM59FeOv0nQrCLknfFPmZlGBNHXWQvFwhB+DNTu4fMT7avn+NmdL
 zyvcMPpck/IoJhzDwbSsW579lDcJIw3mKbgezJYJ7MWhajhSden95punsF3fVG6SDdziXn+ow
 fITxKStzHPcCZoZpykP03NaI0M6f+9fyWC4akNFiE1EGfNHcUb9c+cL7ke0PAqbQ+tm/YVD8y
 9hjjR6AMVj+qRGB7v4keyemB64VFUqJkBxxV9UwTa5GJZZkmvATh25TJvBLZwijFrvg2lQXjW
 Gvsz4gNx/3fiIkcy3bia8n+0cSYI88Jd8Aus5DDz8VEh5crn5DWJe8xIIyPAl09hlqp873Mcl
 hchBiY8JuOQhHkegctInW3KjOBlliFUps0S2Yjofy7E3k6gUXCXMnA=

Hi Robin,

I just tested this on my Windows Dev Kit 2023 running on EL2. This works
now, thank you!

with best regards

Jens

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

On 5/29/24 17:54, Robin Murphy wrote:
> Despite carefully rewording the kerneldoc to describe the new direct
> interaction with dma_range_map, it seems I managed to confuse myself in
> removing the redundant force_aperture check and ended up making the code
> not do that at all. This led to dma_range_maps inadvertently being able
> to set iovad->start_pfn =3D 0, and all the nonsensical chaos which ensue=
s
> from there. Restore the correct behaviour of constraining base_pfn to
> the domain aperture regardless of dma_range_map, and not trying to apply
> dma_range_map constraints to the basic IOVA domain since they will be
> properly handled with reserved regions later.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: ad4750b07d34 ("iommu/dma: Make limit checks self-contained")
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Since I've now got round to rebasing on -rc1, I figured I may as well
> send a v2 with updated tags to avoid any confusion.
>
>   drivers/iommu/dma-iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f731e4b2a417..43520e7275cc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -686,15 +686,15 @@ static int iommu_dma_init_domain(struct iommu_doma=
in *domain, struct device *dev
>
>   	/* Check the domain allows at least some access to the device... */
>   	if (map) {
> -		dma_addr_t base =3D dma_range_map_min(map);
> -		if (base > domain->geometry.aperture_end ||
> +		if (dma_range_map_min(map) > domain->geometry.aperture_end ||
>   		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>   			pr_warn("specified DMA range outside IOMMU capability\n");
>   			return -EFAULT;
>   		}
> -		/* ...then finally give it a kicking to make sure it fits */
> -		base_pfn =3D max(base, domain->geometry.aperture_start) >> order;
>   	}
> +	/* ...then finally give it a kicking to make sure it fits */
> +	base_pfn =3D max_t(unsigned long, base_pfn,
> +			 domain->geometry.aperture_start >> order);
>
>   	/* start_pfn is always nonzero for an already-initialised domain */
>   	mutex_lock(&cookie->mutex);
