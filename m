Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232393;
	b=Ic1UfM79Y/0X2fHpsiTT8dUM7J7HGK8R8NJxqrvzO0MTZl4kEZ3MCaxlRKLR7l8M9JHJ
	 ZNMWTRgXtYYJ2PwGMBpI/2kEj+7B/vOjy70agKob3FUBvUnFDt8iLU1yWNOcIlNCS6KSP
	 WwVvQfL7QWTAeLhPmZRz5es5enIbYGjnNkjLiqF4eJXOxJRa3vUx/mPz53EpzhXa8eC1H
	 WmZFvD4cuktdck8LwW0HFXElJo8tTj6cTiu2QHZssBGCpeC5SBqTLFwpdqLWKPFgl8lQh
	 SivgQqRa96cSMGeUrTHttq6+Xus6VKf/ot54vHoihACNvON5kKPSOkFTcOaGRepvgXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232393;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FmzE/0AuzROOVSIWwCygvTpvGfdQlGJ3e5R6heSWG28=;
	b=HXc8iEeF07HI+q+Ulrx41VdLvP8GM+US88f7Gg7KbUJTrH1w2iCF3VoYOMcsOjo85n0V
	 kKYqtsrFAuiHxAssZ4bVaP0ZfOZJ9lzwZtNl8qFyBM+WeUJOfsUiLUtueFIi55ua62CWd
	 f0vbrVd8gvaMz87dO1kRfjumpMqrqTzuOdngJO+39KR2UtgSSknkhe+l3sPB85fZsc5d2
	 JzQCVKtcLd4AB8PSDe6nxA5Z7WNtwXll1Ogq3cqrDIl7A5yyLJ0TNTWEotOBGbkLyo1es
	 mt8ZmBUh/9rSLt2/LIfoejwgqyNrJkXoVLgQEqQszpc7WD39ehZi5PryXIz2+oi+/SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PbSiKt+6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C962A606A321;
	Mon,  9 Nov 2026 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C962A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PbSiKt+6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6138A1516;
	Mon,  9 Nov 2026 05:53:08 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 325953F632;
	Mon,  9 Nov 2026 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794232391; bh=wlZiYNVovym20CI+TkD2zA5b5H/GLLhwfGNQAFy1oHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PbSiKt+6/8n08qcvegxvEqZ785gaJmYXPkCXkChu7e4iPaKOKPr/1jPeRUiVcqb1H
	 0qgDWwsPD1EkmkbX1+fO1PRojMVMKmDJxVXyFTHx4NLSzrteJQaRhzRzAMr1SrHAal
	 oJp5YHh3ZyU6EAv/FfCOS4WZ6M+H14+z84WD/B+o=
Message-ID: <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
Date: Mon, 9 Nov 2026 13:53:02 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/11/2026 7:33 am, Leon Romanovsky wrote:
[...]
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fcd..8be2a246d4903 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
>   static int iommu_get_default_domain_type(struct iommu_group *group,
>   					 int target_type)
>   {
> -	struct device *untrusted = NULL;
> +	struct device *restricted = NULL;
>   	struct group_device *gdev;
>   	int driver_type = 0;
>   
> @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
>   							driver_type);
>   
> -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> +		if (dev_is_pci(gdev->dev) &&
> +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {

I think this should be the generic device_is_adversarial(gdev->dev) now 
- in fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't 
conceptually PCI-specific, just an artefact of the current "untrusted" 
flag being so.

>   			/*
> -			 * No ARM32 using systems will set untrusted, it cannot
> -			 * work.
> +			 * No ARM32 using systems select a restricted trust
> +			 * policy; it cannot work.
>   			 */
>   			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
>   				return -1;
> -			untrusted = gdev->dev;
> +			restricted = gdev->dev;
>   		}
>   	}
>   
[...]
> @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
>   {
>   	return container_of(dev, struct pci_dev, dev);
>   }
> +
> +static inline bool
> +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> +
> +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> +}

Unless I've wildly misunderstood, I'm not sure this is right - if the 
user has set DEVICE_TRUST_POLICY_DISABLED to explicitly override the 
bus-default behaviour, but that leads to the IOMMU layer special-casing 
all PCI devices as adversarial and thus force-*enabling* all their 
trust-model restrictions, isn't that pretty much the complete opposite 
of what was asked for?

Thanks,
Robin.

> +
> +static inline bool pci_dev_ats_permitted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_level level = device_get_trust_level(&pdev->dev);
> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> +
> +	if (level == DEVICE_TRUST_DISABLED)
> +		return policy != DEVICE_TRUST_POLICY_ADVERSARY &&
> +		       policy != DEVICE_TRUST_POLICY_DISABLED;
> +
> +	return level == DEVICE_TRUST_FULL;
> +}
> +
>   #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>   #define for_each_pci_dev_reverse(d) \
>   	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> 

