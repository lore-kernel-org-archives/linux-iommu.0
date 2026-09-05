Received: from out16-54.antispamcloud.com (out16-54.antispamcloud.com [185.201.18.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF40503BF2;
	Sat,  5 Sep 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788635594; cv=none; b=YSz+X0YJIIR2juwXLu26hdXHYo59ixzbRRgD3S7ZgPrhCAvxk/Z/wcV4pJWp+dftDK9A45N7syaOoz4Lq9dBEM8NaAFs4P2metFETSR1/qJ80DdvyxiEFpxNW8SHwqSV5TdWmdcZTTJdKydRbsJqctxMGrIWuUDvoVY8O3HHxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788635594; c=relaxed/simple;
	bh=c0JbcJlaQkLipwnt3/DkOfWpW9dmip0vnBaWJmFIvVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOSptgGuYTRHVwKQtZDE1DrR4Y1q2jzZodWYAjr3StS0U6nh2iekqMkB7nxjA09CLoNICWFCsuBAyDmxmTuLadU46SvCZV3TRbyoy+Hu1drdDENrhbfxAslHyF8wGuVMrrv69pVkpMFvR7wkkiQpI6QrUuFr9KPK4dEVn6vMguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=OUWnS9Cl; arc=none smtp.client-ip=185.201.18.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="OUWnS9Cl"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx323.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x2vov-00DMF7-LB; Sat, 05 Sep 2026 21:13:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IDAdXdmYQiGftn1IVgZRxHeMgqio9VkUoC0IFVH1RRA=; b=OUWnS9ClHf0H/CmASbIt/lqFPP
	IeouFZ7ZpMOp7GqEHiLDricPCROGULEFG26AryKFvQvFCc3FczOZl6mE0QhyzEIHKxPtc6JtF3hpA
	ZlLKr6JxqeSdMOo6UnobPETqjK9ZCdEMCebS+0kSshbphA/T6y8jVyDyBHkd2tTGP5y6dgi69SvQK
	1JarMQsE+PgN1/i5PdwS8QpM9lYS+K2OjXcBocW9Pqi1gOmnQdtNt2uNqbuKsjY3SEa8fnPqeqvVZ
	pirmOnY62g/WJ+ti8y6MLj5fMM8+HCntaesxGpWprqjPOKrZu4lvK9gyZUYsTKTC46tDcmhL91E1I
	Sansa4XQ==;
Received: from [188.251.249.2] (port=48122 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <dan@reactivated.net>)
	id 1x2voo-000000074uS-2DE0;
	Sat, 05 Sep 2026 19:12:51 +0000
Message-ID: <54e99476-1824-4dc8-b0e3-8d95cfb0ca82@reactivated.net>
Date: Sat, 5 Sep 2026 20:12:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260902-bcm2712-iommu-submit-v4-0-9dbb657578c1@reactivated.net>
 <20260902-bcm2712-iommu-submit-v4-2-9dbb657578c1@reactivated.net>
 <CA+-6iNyAU9uw1QyA8TaBWOvhWuxe=DdbeEzoHgM9Gk3TSsSccA@mail.gmail.com>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <CA+-6iNyAU9uw1QyA8TaBWOvhWuxe=DdbeEzoHgM9Gk3TSsSccA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.13)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVNdYZM0yLKecDbLpFxMoMA7so6Wt9YoFQ0
 ccjaCh6XZyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOK9Jzy6E0Hj75Vv8qhxyDUGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWBpY9ovdkP9RmEvieRDWoEFGZ7f+7oeClYYrL6OxfWC1kiZ5sDJvU3vQetKu48NmiFWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHXeC6Fp2UeS7H+y7loLTGzjk6Pnrj57pHasIWjxl
 5VQaCkQZW81tMEBQ4bAn0uDrJ9uGRuKPr0Bb/YuPEx8xCp8sVji4cAyRuviG9RNPI/hhtGILrmkE
 lozHQFHLOT6ky701An1vNgfn8qLx5ufPTavvHrDFUeJkFlrxAO7a4MyxvV6eez/2pXtRk67lE1pK
 ip0NQbcmUOf5g+Cu/8v2RgiMtHyOAopYGto1ZND1xOhKQ/xOsDxA6gxAbLULxQQNoGJT8d9Ba5wO
 9ZizJ7G1fW//V9KstGWt+qElQbzPhH3+DAhJrbM68g8iJLXx/5kDQNyLBKa52mO4ut4dtZCHnpZk
 unegD6yDtdNYigyY4x8WCqllmv57Tj6tiQZFHltAdzPaTC70bTG5XdYT+TrxfHim0b8ZLR/tc14S
 MwnwErmAd1N05ar9GFRLmgMiU/Irb3ws3TRjaC42FtNJuTWwh7zOAIws9QcDfaxJBDYI7rc6t8C9
 mOBdONdnsxgsk1D2p8400dnId1/Bnfq55U0ALjQbONHJki/bT3w/adEN9DqaO7ZGoOoYIKBVJEt+
 vlxtdD4KDYIhXXGWpMdQulPUSP3/u+rFPMBpjpy3GniDZYeA/nyWTY2V77n1/ThmdEcBVb2zTZYK
 e+y4VTLHb4QDZyifdXZ1LDHmhCkCHFdzUwaYnIl+pXXQe0+n5X3Sj3Z9zZ0bAsC9nfCIZz3Wd8D7
 ouPHQoHZm8Gp6aP0g/fJgXX36hVPCCjCaMNz1R77bD91Di9Is0KRF1AETmGxSMUY3jcjCX07Ixtg
 ncOn+BG3oz5i2+nyE0o1dKxKwo8tSXoc0N9h9klG894O4vkdFH4CpOwgr/U0flMcy2Vi/IcBgY4a
 vWgQKhj3Fcsd2rNfFFLypQlVWw0YdWfl1Ha0fbK2G35c78ohQjHlOaO6zAzIopnUm4Htr2UEhVEK
 whm6ser0T44JvUV2HwwnUT2pMXKdjPGEYPejAacuzuzUkO9n7Ku11YfzA0qETuZkqmB/pTfshouq
 rdtYXg/+3CpdEb6Y59cS5Tfqo1bt/OdiqUKUH++/+IDul3UHH62q70QJKnyATr3RQrMbS5NztA69
 WlVxa2oRS2om1AXjIKyh9pGiu58U7RSTTTCtUfm9KZcUI1l5gogDCjHQP3iMwHBrpEjajuxRXxKF
 5tPxTxfD0dMN+t5Z2cqRsd3Vtwdcj0q/nQ5H3VMXSjyLr4N9+BUoBAGCvz4YOooXGM1M7qYfB6kv
 9uuFsEVjgQXYooY6HFYx801qhKuPoDClMk376TihCdFdWNHrR4SFPNSzcO1VukZGZNCq/2rAztFe
 klLxGNN3KHaPkPnTQmYnS7QiVQ4H59IGm5iLm7yEMgceH7ChscXf30fVsEVjgQXYooY6HFYx801q
 hAGsnbPK4M36tRlD+OTrkVw=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Hi!,

On 03/09/2026 18:36, Jim Quinlan wrote:
> What are your thoughts on allowing the iommu work without the cache
> property, ie having its presence be optional?  I work on the Broadcom
> version of the Rpi4/5 SoCs,  and  (a) on certain workloads the cache
> slightly degrades performance or (b) on some chips there is no cache
> associated with a specific iommu.  This is probably on me to implement
> these possibilities, but I just wanted to give you a heads-up.


For (a) I think the DT must encode the relationship between iommu & 
iommuc in any case, because the DT's job is to describe the hardware.

If the user wishes to disable use of the iommu cache then that would be 
a software configuration choice. This control could perhaps be exposed 
via a module parameter, or by iommu_device_sysfs_add() to expose a 
writable attribute. Ultimately which approach is suitable would be a 
decision of the iommu subsystem maintainers.

For (b) we could just make the property optional when support for such a 
chip arrives, or alternatively we could use a different compatible 
string for the cache-less iommus and have the cache property only 
required for certain specific compatible strings (see 
mediatek,iommu.yaml for an example where some properties are only 
required for certain compatible values).

I'd be happy to review patches for these cases once the driver support 
is added.

Thanks!
Daniel

