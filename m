Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25755319867
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202013; cv=pass; b=PWNWeAtDqzuPEFDKp7i66saJPJIlndgZgKhFkDYNOQRjB8ts+IVjkUdBJnrMlRkxkZhKxNuDZ7byjPCQgL7u9NAuOJ3qWeBcuMlLjjcQMZfKxw6ym6NlDG2SfCrfL7R9ngSOr/gWmySOEpm3qXU52LDspv0uoMgFBZpBHosRk3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202013; c=relaxed/simple;
	bh=Dn3Jicl8olp9EaV0TqV4EBh3aYu+CRSHNFNRqLFHCz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0V7Qjw3Q0Iahv8XSAi+t51Gxx+Aizyv+KiH47nDyyxxpsSPKENgsaFKusY6Kdtb8Pv8zMaO0h3vOfeo3e1mEo9oVLcHc3BFHXPqwnybKX/m43rXwo3cQFz5SOjSnyzrKlkKSbxeqtfAr9Rh52I542iTdHmM1X5hy0UXIlFR0b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=fTL3GjBl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="fTL3GjBl"
ARC-Seal: i=1; a=rsa-sha256; t=1756201998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X3ygrqwUSuwx6dHiIGUQtLF1gLG8fJGjuWMLZdLv54TwSfNdJyatQRzdOHwg8IQikXjAJdmXu2WqkEn1IZA+JnLYycuq0OynB3qzLDRc/t+X2pFpIXOAoF83H/2ieIJGXBdX72EbHm5guOqMpviXNO6BK2zU/9ELbPeEe1pyi8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756201998; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dn3Jicl8olp9EaV0TqV4EBh3aYu+CRSHNFNRqLFHCz8=; 
	b=NNnul6sK8D5SZXlwiOdk2Vo/2XiikXGdpMcK9jsQfThAUe78IoXcAFVswPcuX+vbd0O9b8k1xcXw9CWCkqJJOToJEBtxKviFge/LuvSpwCiMFXLX/qyCGA197jrsGey/MA0nAlXGlfdUpkFyJZl4oIsTvELgk4TJxsQ0gL4zcO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756201998;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Dn3Jicl8olp9EaV0TqV4EBh3aYu+CRSHNFNRqLFHCz8=;
	b=fTL3GjBlvFAwIZNuysAvG47xhYwqyFQ1DdN7snGwnhGRKREejSWnp4NRUPxtrwC6
	7KTnFtpqBWhvVmVvz9hhmlF9hthuyMPDQnpDX8hY9cHYPtjGfr/N9OtCOEWjRm7ofmj
	0uUOyEhks8tNqzhWrXXScbIoOhM0h8Z4Ci6OCW18=
Received: by mx.zohomail.com with SMTPS id 1756201996213653.2470978174058;
	Tue, 26 Aug 2025 02:53:16 -0700 (PDT)
Message-ID: <002f164b-4296-428b-95ec-1ca10b979070@collabora.com>
Date: Tue, 26 Aug 2025 11:53:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] arm64: defconfig: enable Verisilicon IOMMU
To: Krzysztof Kozlowski <krzk@kernel.org>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, nicolas.dufresne@collabora.com,
 jgg@ziepe.ca, p.zabel@pengutronix.de, mchehab@kernel.org
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 linux-media@vger.kernel.org
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-7-benjamin.gaignard@collabora.com>
 <b7869ddb-f44b-4d1f-a6c3-393a28d3cb00@kernel.org>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <b7869ddb-f44b-4d1f-a6c3-393a28d3cb00@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 26/08/2025 à 10:25, Krzysztof Kozlowski a écrit :
> On 25/08/2025 17:34, Benjamin Gaignard wrote:
>> Enable Verisilicon IOMMU used by RK3588 AV1 hardware codec.
> Qualcomm RK3588? This is defconfig for all platforms, so be specific
> which board uses it.

It is for rockchip rk3588 SoC.

Regards,
Benjamin

>
>
>
> Best regards,
> Krzysztof
>
