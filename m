Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428232DA75F
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394150; cv=none; b=amPIwyl86M9inc9KNdW/iqeEqTJD3k0ngy8JSnPXsOs1USvk7vP1YwTF1QyJcY8Q9HWR5dx0evX9WvjrLzCqaleCU9qjgAm2h/DSu4DBYBxdi1i/xSrke/G/oqCoutA0fpPktxzCIPG+QuE3hXBrY53OilTxGjVTbAO2Ub1sog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394150; c=relaxed/simple;
	bh=gXv5DczA8BHmj10ljecAUFcrTfjIfTSGoxbnbtpszVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtVQ6KUKW/u59yOAz6cba/3pEjVnp0mbQXJGZ9YS/vYKSmyOESR+qjwbfW8upcZnMtRVE4B0PS+7H7eHmMJDx9IWSFpTuiupXPiADPoEX0Fxo7jVdizGr8lrdS5h5CPpybcgKx68R05uiP6aaOQxFHhzDCZwh7BTRxgl4uCWvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzPK/b6z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzPK/b6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757394148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCS+GXo7l3jWjrg5Bypd/akHpCsecj9WSjxZu9TyHkQ=;
	b=HzPK/b6zVWclVq8lLRfCwxg6hhjd/4vafpj5ADCJIhmN+6o1sE4zlqxtH1UvdA0sSuTyCC
	K/lnNQSVkYA2cTDlhDcitdlVllqTep+FvFUvnAyJ+BPRUgKDRKmb6aqZfdo8+J5pWgUUJc
	droK6bNoKNPHeNmizeYCMQKcgvnukEM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Xw940jZ7P_-q0X7E4e-4RQ-1; Tue, 09 Sep 2025 01:02:27 -0400
X-MC-Unique: Xw940jZ7P_-q0X7E4e-4RQ-1
X-Mimecast-MFC-AGG-ID: Xw940jZ7P_-q0X7E4e-4RQ_1757394146
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-71ffd145fa9so154779026d6.2
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 22:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394146; x=1757998946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCS+GXo7l3jWjrg5Bypd/akHpCsecj9WSjxZu9TyHkQ=;
        b=P7XY9mnUHN4pDSSuRRUC2nT5p6Fdgmk6lTsj2ZwVOZFbEeBWE2VvsN7v5xcV6J2MUr
         Nc2QAHINPBWiyD6HFEfFLlKitdO6M2egkAPBzYlLAEPBZZ2BACGPscbE5n3twUfdk4rk
         pKNfOtyaKoyV7DZHkxyxJIzo1IrKRlIndHjj5FdQWPVmbcGh7U8MMYGmuT65RTjqy2Hm
         K6DEF2SlmkDxLMk6b7XJiop1IDaWKriLS6fhSvGZOZugoPfWBZXVr6lrmWFayp4CmsKQ
         /q5MuIpAjo95ZbpV4aMqiFfWDJiE5j0IHmujTP/FUa7pErop3Bfkt4/b3rOzJB51/6sW
         ycRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXP1JT6dWFW/bBeT09wXgNxCCT7te+mYL/i645RiR0ZmLHkTqd3zdXSCAS6yLLJi6wyzbDfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6pQpfSZ7sVu7HjPH6cMqYDYD0OAW2J4dqGxEMEvuWKO9jvtzn
	OEE3J933RwZWVS0IXI5psYBO7SVd2OpLhVDCtR1G+nGzjq9vSGaA32LIeeqBDarmp9Yd7yuaHwA
	7MdrWPrUPIC/LG1fM8h/9r/p07sK8+mEJ7fdLM77ancEIKKCWzSByJ+gO
X-Gm-Gg: ASbGncvP3M3S1Kq6Cllo41lyKelLX1+REF87DJWJXBqof/k3LMJIU4PMdvI84JrAe4d
	SY0pftupstuS96rTcx7JFORyOHGzwWP4TE40/BcCyfJYbGnJzC67Wggkeq/VmJAufWklqkhqGwl
	ondcOGaOs4hIQuxCQTOMxqsZ95Bqn80KWEjeBRhK1o43xnunLLzRZZyoBp840jYWwRAVKSSDu8F
	QrJK2+8Ljv4bz1eg0w2WjBjZRzVW1QgLHVPvgKKVuFW/pEhWV7EeaHsiVHoiEX5h+jg+KyH6/Ff
	h1X0rRBWTUSIyK/GrXIpLmKzVDmK4RA2w2sG2QDU
X-Received: by 2002:a05:6214:2a4a:b0:720:4a66:d3e6 with SMTP id 6a1803df08f44-739315968ddmr121084136d6.21.1757394146394;
        Mon, 08 Sep 2025 22:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn85npmWzjIJW0hynDE6Mpm3rDqP/qRIIKt5rOWGiYhcWvV1gB7Jh1a3RQQxtStWY9TJrKrg==
X-Received: by 2002:a05:6214:2a4a:b0:720:4a66:d3e6 with SMTP id 6a1803df08f44-739315968ddmr121083966d6.21.1757394146035;
        Mon, 08 Sep 2025 22:02:26 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-725dda254d4sm118146646d6.8.2025.09.08.22.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:02:25 -0700 (PDT)
Message-ID: <d5875eab-2c69-4e50-9b11-27d6a77c4db3@redhat.com>
Date: Tue, 9 Sep 2025 01:02:23 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] PCI: Check ACS DSP/USP redirect bits in
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
References: <10-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <10-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j4tdRF31cvZewy38-_py3prkqSL799eJG0h7mLyxsvg_1757394146
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> Switches ignore the PASID when routing TLPs. This means the path from the
> PASID issuing end point to the IOMMU must be direct with no possibility
> for another device to claim the addresses.
> 
> This is done using ACS flags and pci_enable_pasid() checks for this.
> 
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
> index 983f71211f0055..620b7f79093854 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3606,6 +3606,52 @@ void pci_configure_ari(struct pci_dev *dev)
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
> + * the device supports the most favorable interpretation of the spec - ie that
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
> @@ -3615,15 +3661,9 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
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

Reviewed-by: Donald Dutile <ddutile@redhat.com>

