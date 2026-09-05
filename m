Received: from out16-54.antispamcloud.com (out16-54.antispamcloud.com [185.201.18.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A504272803;
	Sat,  5 Sep 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636344; cv=none; b=kuL889KnJu6DXJIYxUNcyCCnKC1Sf7ZZBgC7Vi5Ld9LhjwaviWTJKlh/s23pK+5gjVYNAEZwu7dIk7hMQFZDDOdVXw7/zDPuRG8PBnxGYNXJYUWKOv9+RhZFwOy/bxzDuSILO/xR62UW+8bz4f15oTAcjIJnJJCBJXk++Aq8EaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636344; c=relaxed/simple;
	bh=Pg1q+59ODENEdfiPYOqTEYvT02K4TprCqSPHm8zd9fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKxK6IFEz1jLhzbGZq8juOqzX5TmciwYgKbjMRX2uStNO49dNzhyMnsrJI5mzZzfijAhivhqW7QAPghaNReh+D/xPYA1Rks4+mmWRG2SFmakLWlITHy2WmJMWUCvFUNgkxv6NuICL06dZPZF2Q6GNoqx8melAixayZaj6vIkXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=MBK+0tZF; arc=none smtp.client-ip=185.201.18.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="MBK+0tZF"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx322.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x2w15-009Yb0-JP; Sat, 05 Sep 2026 21:25:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I29P3lyigJMFnu99k3G+NxV5W8FFUhlm/5S9hJLKxPc=; b=MBK+0tZFAa/Gn/q6Wbfi1QYf2m
	+SMUMMRhQ+QQRJQMWzBMgk2nJYC66M0gzBYG6o9W3evx36FHo5lHLUAxeHKY9ocu1QGe9f2W7Qfgf
	raetyrvpYvrCs+6Py7sWOjWWxfT0yVemhIjfYuesw2jVNy2U5r+l+UyINrIJwxawCUjGtrLAyWwfN
	dnsVBcbb1X9FfPOF8EX7866M0yOh3yVxb65Z/vxLN3du24NGNU8TxYoWUD78YQmmMFHEu0pEMo+3y
	/g77FpBBbYB2RaJXHcbPSPC7s8mrWeIQBdff8KrYnyUKe+bqVHG3DvSgv1i6Id5Waq8IsM3DjLkqf
	ATUGo8MA==;
Received: from [188.251.249.2] (port=51350 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <dan@reactivated.net>)
	id 1x2w0y-00000007arG-289l;
	Sat, 05 Sep 2026 19:25:24 +0000
Message-ID: <3b5830a2-31f8-48bc-a56e-ed70377bbb1b@reactivated.net>
Date: Sat, 5 Sep 2026 20:25:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add support for Broadcom BCM2712 IOMMU driver
 (Raspberry Pi 5)
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
 <CA+-6iNxpKmqCo+brvnchoEsrmE7nJPqJs_7S0m_HzjooEa+KNg@mail.gmail.com>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <CA+-6iNxpKmqCo+brvnchoEsrmE7nJPqJs_7S0m_HzjooEa+KNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUnZbjr8C3tcPbSEFoPsgmLeziwPHUKuLxe
 4qBq1a+FYCu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVINi54ngXV2h9XXLXGvseU+LGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWBpY9ovdkP9RmEvieRDWoEFGZ7f+7oeClYYrL6OxfWC1jM0MOKiGRkxO3FaI58br05WBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKclZzoe+TZdeH39wA4E
 grA4pE2PuLHIFQdBY9qb1rRWgyz0f29FZkQs6Ir87R/YNAszN6aoC8HwQTObwM1qLvCNTb6qMngR
 zAI55MutK7Hm2WVdqUWFH/m7thLakJHUNLOhsIXfQJBdziWVxbPM+eqcfxRAkuNPA/wWXImf2l3i
 esXQ7SopzlRh1zifXgrC4UG2Pt4fUgp+DZoShaPoyYliAoajAWweUFMTbU8ebAWhOjONRA9OfeQx
 MUNSsA9S/7adOer54gFeYIyf/VI1wUg/KaAJeWYTMyqvWPctqnwRLXABYtQiKS6L1oPObXHG4XuB
 tw8JhfTSZBah6TYySBe/EJBsfXIzfzvfdU6fGHDZThLSXiI9Gw+7tmoMdcYgrgLaoR1Y7hdEFeOM
 IzpuIYvQDyMYLxvGW3IbtaX54tMKOB2mlP2W9u+agdcanH6cUDOvoGd0qTR9MAtZbKbqHklG6k7o
 5kYCtjHeNVHQXMZukoUpztNsa0DUHNL9jMWEuCzM24OD2qGt6TVUNM5e7f/lvCzv9KG+9VPIbHp+
 ++0+2ndXPd2mu86jxvGTfZNouT6f3He7jw4SoVhmTJ/3eP9ONMaEXCDUS2PfGmfkjBlSS66CbGpy
 vykVsbKD1nW2UNFDcZMNsyd9sNan/JeWgUakIgJkZA66p7JimgfMa++iLXrAJbyB+/fbKGEqMODx
 8DkuTvTndFR/A9egQIH068lsbT7SCD6kQJ3tI0MR7rn/4WYZnjq45i1nYESwVKwzZiFUI1t4mPoi
 rRq4PJLWMw/6KojFOrGz33upi7EPNu9rNFYFvf25LVONYbYifH5OzZCiewdqCBE/0+/4pwUv7rIU
 PjeR1T1JQdoCddsmjeKIhdiBBNhBSGY5vxrKJClYskFrCVDof/XkQioXeG4M8YMPbkgXenfBtLq6
 AZRXEgMVECJ/QUl/m3QUU16YM5JjcEIdidSTnS8IQ6usOik9AEZrgOZSaRnsNZVApQzHT4cVx0KY
 do0DOHLiFskKAucWHRMw/Kfe29CB0IyEr6OHBrCQYuMBA7a+Mv5xKXYo4UIrAadw9dTKdIb1I20+
 dwSq6lZSDrVoSWcG6DQ3YMS+IGJeO4HbHw0XswOVNt4vqF35kGyDFhtwEYMSACKY0kCaWypm4zuN
 RcgRKiGg7nXFaZTxaded/ujSY2/ltFtdZhvFO590VAkmxqByO8Gsjp12nsFfQXgXgQLLTOYxoIZ9
 JstU8UMsiAJ6CG7rwwRyQmbntPkbCX79rLXRvB1uJYgnM9NZK591ReVrrqRv1hvAuCIEifnL+9wg
 oTj4ygNPw1XfNyJNE/BHENwcVg2HSapJFbos6C1ONGDORvH/2vBiQAW/8UMsiAJ6CG7rwwRyQmbn
 tHLAjYtUbr3Dqh+N9NAloToxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

On 03/09/2026 19:14, Jim Quinlan wrote:
> I wish you had kept the dma-iova offset hack but I understand why you
> did not.


Well, having an initial iommu driver upstream will provide a good base 
on top of which we can work on that specific problem. It'll need some 
consideration/discussion to be done in a way that is not regarded as a 
hack. I might come back to this later, time permitting.

 > I've built and successfully tested your driver on the> Broadcom 
sister chip of the RpI 5.  I am mostly interested in the
> iommu attached to the PCIe controller.  I tested this by running
> multiple tests where 10MiB is sent by a Wifi chip.  Data integrity was
> validated of course.
> 
> I did not use the driver code as is.  I tried merely decrementing the
> MMMU_PT_PA_BASE value for the 4GB iova-offset required for our
> configuration, but that did not work for some reason.  So I just
> hacked in some iova conversions and got it working.

Thanks for the review and testing! I'll send an updated version that 
removes the blocking domain, hopefully that will be ready for inclusion.

Daniel

