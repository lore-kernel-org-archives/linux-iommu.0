Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179C218858
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790640; cv=none; b=GAjG49X6st8Qh8HWGwTRFaudz3HYZeIq71S0LN4uOSApCzO4wZCQnY8GnSeB1FkUJUhEK/6mVlaVILcIBN1sDDMnKhqo/UoHYXc/Fkegu0Gims2J/atlIpa7HYpPBDzT/geKCVGjDHJu3psLxihax3NXvdpPRpyYHoNDF/t31cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790640; c=relaxed/simple;
	bh=58KJnD9NytLGJCW6oBveiJv4eE1/FvtFSAbReU6RBjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+Q49936hv5XJ5EqdUkeIPq5nWYEc4Gex3E/NlEC56uzBvWFE3G0JMnIWaVIr0kJDPAwDFlJFYwsd5qXnuGOqD56uou0OCGWway3JO9jkJ4Na9IerQJ8QAE1w7bYPi64Ae6dFuMmM/FfOjE5qzhSjuQpkVF+6uvgYROcRwIO70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYC72W9G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYC72W9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752790637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2eLS7DZKuYaKmsCXE04egU2n+sc3hK3vsCJNQUw67k=;
	b=TYC72W9GKBi/+ZJyXy5ITAHGL2YjDS6wy8K3MM4+S0tiXrDApbaYlb8R1hFrjDgCHWMvNb
	z/QIDjcR1mwP6o85Sz7Ge/8z3wJhB0vRy5csqs2thV+0omFoHIBJlcYq1v59pGSdFoniym
	MQvIxe62DFjuI3zWmsEViwMO7rgme9o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-55NFJnXiOhaFKZO55-xErA-1; Thu, 17 Jul 2025 18:17:16 -0400
X-MC-Unique: 55NFJnXiOhaFKZO55-xErA-1
X-Mimecast-MFC-AGG-ID: 55NFJnXiOhaFKZO55-xErA_1752790636
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb3466271fso21842686d6.0
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 15:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752790636; x=1753395436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2eLS7DZKuYaKmsCXE04egU2n+sc3hK3vsCJNQUw67k=;
        b=uTajgNczc18KJMYqlfACBSzFSX67KFmGAQA3EyUSq/ySmXayR5h7ohrhUMWyjxukXl
         8kPNP8jvRn+RgnxtFEV9giDh0kOAnItFdjolQK3xqQXzBe5zST9yVNMZogMEPvbkALo/
         x8VUMPVYK1vGoWgcedFj5b1k/RZcNIl2bllG50jme/suOq7wkDUYRmvmPGcZJfRJVpmj
         kC1yrIiy2xvwQJIOJd9oh+Xuao2aPlDnv1JI8wVI5mvpFuomxvWpvAPL+16t9IuR7AQ+
         eCnpITgJ2JtBhWiZHwW23TATauB5uL46NcOMiWVUbxV7h7S94VcUAI5DCq5VZS1qcpwn
         qD6g==
X-Forwarded-Encrypted: i=1; AJvYcCVSD8lJq8xgATQKwiZHhOCNMmRjnhfTO+1DTzGV5O9A+QaLEQS0yFfO2EVF4zVPjzVPjcDYOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YySEgSADwuvZQPCgkWtlhkzvctwpaI2yW1jEz+P3L5YkoKee2s0
	Uy26SJmq/I6lNvjhJoYRqfQyH0ZQJLw5QpVTtJWgFPynaRMLpIgn6w2KuiTAU5++RCWzAQoHPlu
	ExNCTwdkhql9JFCXhLX7gn4MOW3ZsL9rBBwiubH4mVk6HYw6SqC6Qnl+Z
X-Gm-Gg: ASbGnctYnBQ+g8lpdPQeTNcXG62bJvzTNEh4ove/axUKI4aEgVvrbsaLskd3FykkD2U
	1Few6CGc+WxwttInHNvntwJleDdgwfZWd4drZTDoF7vSFZ74v4AkEixBONdGCpq2CGOC242xlhN
	tITX5h/pQx75YBTnpSV5WhJ4eIN1zCaaXZcLyDZlsXZ1pzuCuCUbrC/OtBB7ixE8zIeIg7hblud
	9LW4JBGAsJd3Z5agT+bbbojgOhEP6XFmPuMka7cIoSkjI9URTZZQ92LzZBdLLLRYsDCDe/BnBzo
	mNhGjwVO1Nbhhfx4gvSOQqxoJpgl/dVhuppwgDZY
X-Received: by 2002:a05:6214:624:b0:702:c038:af78 with SMTP id 6a1803df08f44-705054fd174mr67554506d6.5.1752790635789;
        Thu, 17 Jul 2025 15:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZdYk1t9nSSqx51KlhXGP3E6Q514XZRXomUyAlPzCL3RWf3fbz0HOn4/LJXtmlAmeSbwBFBw==
X-Received: by 2002:a05:6214:624:b0:702:c038:af78 with SMTP id 6a1803df08f44-705054fd174mr67554116d6.5.1752790635341;
        Thu, 17 Jul 2025 15:17:15 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba8df3fsm857016d6.79.2025.07.17.15.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:17:14 -0700 (PDT)
Message-ID: <aa84cbc8-6d7e-4e70-887d-b103f2e01a77@redhat.com>
Date: Thu, 17 Jul 2025 18:17:11 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] PCI: Check ACS DSP/USP redirect bits in
 pci_enable_pasid()
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <15-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <15-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: czvUr42_S6Q0I-hWBOlTaLtbgDtuiY4Ec39QI3p2bG0_1752790636
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/25 10:52 AM, Jason Gunthorpe wrote:
> Switches ignore the PASID when routing TLPs. This means the path from the
> PASID issuing end point to the IOMMU must be direct with no possibility
> for another device to claim the addresses.
> 
> This is done using ACS flags and pci_enable_pasid() checks for this.
> 

So a PASID device is a MFD, and it has ACS caps & bits to check?

> The new ACS Enhanced bits clarify some undefined behaviors in the spec
> around what P2P Request Redirect means.
> 
> Linux has long assumed that PCI_ACS_RR implies PCI_ACS_DSP_MT_RR |
> PCI_ACS_USP_MT_RR | PCI_ACS_UNCLAIMED_RR.
> 
> If the device supports ACS Enhanced then use the information it reports to
> determine if PASID SVA is supported or not.
> 
>   PCI_ACS_DSP_MT_RR: Prevents Downstream Port BAR's from claiming upstream
>                      flowing transactions
> 
>   PCI_ACS_USP_MT_RR: Prevents Upstream Port BAR's from claiming upstream
>                      flowing transactions
> 
>   PCI_ACS_UNCLAIMED_RR: Prevents a hole in the USP bridge window compared
>                         to all the DSP bridge windows from generating a
>                         error.
> 
> Each of these cases would poke a hole in the PASID address space which is
> not permitted.
> 
> Enhance the comments around pci_acs_flags_enabled() to better explain the
> reasoning for its logic. Continue to take the approach of assuming the
> device is doing the "right ACS" if it does not explicitly declare
> otherwise.
> 
> Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/pci/ats.c |  4 +++-
>   drivers/pci/pci.c | 54 +++++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ec6c8dbdc5e9c9..00603c2c4ff0ea 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -416,7 +416,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>   	if (!pasid)
>   		return -EINVAL;
>   
> -	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
> +	if (!pci_acs_path_enabled(pdev, NULL,
> +				  PCI_ACS_RR | PCI_ACS_UF | PCI_ACS_USP_MT_RR |
> +				  PCI_ACS_DSP_MT_RR | PCI_ACS_UNCLAIMED_RR))
>   		return -EINVAL;
>   
>   	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d16b92f3a0c881..e49370c90ec890 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3601,6 +3601,52 @@ void pci_configure_ari(struct pci_dev *dev)
>   	}
>   }
>   
> +
> +/*
> + * The spec is not clear what it means if the capability bit is 0. One view is
> + * that the device acts as though the ctrl bit is zero, another view is the
> + * device behavior is undefined.
> + *
> + * Historically Linux has taken the position that the capability bit as 0 means
> + * the device supports the most favorable interpritation of the spec - ie that
> + * things like P2P RR are always on. As this is security sensitive we expect
> + * devices that do not follow this rule to be quirked.
> + *
> + * ACS Enhanced eliminated undefined areas of the spec around MMIO in root ports
> + * and switch ports. If those ports have no MMIO then it is not relavent.
> + * PCI_ACS_UNCLAIMED_RR eliminates the undefined area around an upstream switch
> + * window that is not fully decoded by the downstream windows.
> + *
> + * This takes the same approach with ACS Enhanced, if the device does not
> + * support it then we assume the ACS P2P RR has all the enhanced behaviors too.
> + *
> + * Due to ACS Enhanced bits being force set to 0 by older Linux kernels, and
> + * those values would break old kernels on the edge cases they cover, the only
> + * compatible thing for a new device to implement is ACS Enhanced supported with
> + * the control bits (except PCI_ACS_IORB) wired to follow ACS_RR.
> + */
> +static u16 pci_acs_ctrl_mask(struct pci_dev *pdev, u16 hw_cap)
> +{
> +	/*
> +	 * Egress Control enables use of the Egress Control Vector which is not
> +	 * present without the cap.
> +	 */
> +	u16 mask = PCI_ACS_EC;
> +
> +	mask = hw_cap & (PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> +				      PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> +
> +	/*
> +	 * If ACS Enhanced is supported the device reports what it is doing
> +	 * through these bits which may not be settable.
> +	 */
> +	if (hw_cap & PCI_ACS_ENHANCED)
> +		mask |= PCI_ACS_IORB | PCI_ACS_DSP_MT_RB | PCI_ACS_DSP_MT_RR |
> +			PCI_ACS_USP_MT_RB | PCI_ACS_USP_MT_RR |
> +			PCI_ACS_UNCLAIMED_RR;
> +	return mask;
> +}
> +
>   static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
>   {
>   	int pos;
> @@ -3610,15 +3656,9 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
>   	if (!pos)
>   		return false;
>   
> -	/*
> -	 * Except for egress control, capabilities are either required
> -	 * or only required if controllable.  Features missing from the
> -	 * capability field can therefore be assumed as hard-wired enabled.
> -	 */
>   	pci_read_config_word(pdev, pos + PCI_ACS_CAP, &cap);
> -	acs_flags &= (cap | PCI_ACS_EC);
> -
>   	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
> +	acs_flags &= pci_acs_ctrl_mask(pdev, cap);
>   	return (ctrl & acs_flags) == acs_flags;
>   }
>   

