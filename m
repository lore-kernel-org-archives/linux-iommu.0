Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479C62DA75F
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394266; cv=none; b=FnnFAEwNTpnJkxPPL1gzgo8zrCJtMukV0l/Oh9vXy5qtuialuf+i9DxBvDICpBfTedNxty9JuUkWJg2J9WJ5XFpvj93atbgEIzTbX63I0TjMAy14NetJw7X2QQ5YbX85XbbUTLUYUGz0m551JvEfsqAxULlyzmzwO3Md7sroYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394266; c=relaxed/simple;
	bh=WRKEjVB88UyDSuQnn2M8CsE1PKosjlo1Gos8s6oIScU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSZ+pvgYd+DgjUo2dfmBGnudqeA2X9upxAM6NfHLLh9vAqU+FlLWNSnBSuEMCEhHQ51mHbbNEp0jaSkXnzQNFXDnW1edujg1KD38BUqRc0V3NPm3IGCFCslHRESgzQcsjDiZMnrfqiBR0+vvUHvoXvuLGdnoJysVcwsXz4c9UHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrIwz7Ir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrIwz7Ir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757394264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr2ePTIKgu+dXGPmYEIQm5pOk8ImaQGQj8O0LKwZ6pU=;
	b=MrIwz7IrRHo4n0+G2gYiRqCAS1T259ZqUaqppe/BDARoRhQYu5BOgZu3zNBjSLW4E/NTgL
	hSiCNIaHw/XBVxgS7UVXYa9CI512DzgrEyMkDg1DT5s6ZEHcMjrp8Ffgw8ERA/F1l8/voK
	GFxpzyZvQJ4T+CwsEta/puzi1a1JNrw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-_rJT4ktsNeOj0DOT76jr1g-1; Tue, 09 Sep 2025 01:04:21 -0400
X-MC-Unique: _rJT4ktsNeOj0DOT76jr1g-1
X-Mimecast-MFC-AGG-ID: _rJT4ktsNeOj0DOT76jr1g_1757394260
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-806f812a0aaso1324270385a.3
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 22:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394260; x=1757999060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr2ePTIKgu+dXGPmYEIQm5pOk8ImaQGQj8O0LKwZ6pU=;
        b=Sr680iilnluR7CBWy2hpCtJehNJRgu2tRyGPZsRf1G87mhZi5T1SaOxsi9E5QPnqiX
         OjcqELtE6xSsWJhhohxiA4cK2JHNxTQDXl6RBuZ1xac1fjckZOsN2D2Y3x1qawBvl1WV
         Xge2ZYkX7uz7Lzvr2I3ilF84lh4dKw+V8AU7q8sBIVA+tt9lJRdYUHNKOPFtcWPVbhvE
         dippjbzeNZRKrRSzGFO6c8EBg5pNR2q0izLHcV3MR9T3tFcD05d29YLA1fDPyL7n9FJ/
         m7PH3Skts2zsr2V3Z0aO+rgGftR2A2Msp59WMCuf9tEUnFlOagTgd5mTZarkpX9V6doM
         PFJw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7L2UOID2GCmoTNxue9CmwD7bVgYTW2BfBfsSFi++tfOemP6Shqz8qcFPL/useQdFFnF0cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzShs9RUtO/i50SmgxkBTHPkNWvfJhUPo/O2PWkbQE1A4Jq282t
	PTYZEKGqzQQj8HfcKZg+JEs0nC7jj70IoIKkkA1y4lZga2o1qui9zFhSK+gIT5e7uCdqDZFr5eL
	YOLgFjFZc6kkMngn6pgsQ4mCpPmUtRy/RRhrRmuwqA9iDFWUSAlFHdO+b
X-Gm-Gg: ASbGncttlG6wxhqMJePZw1yJkAl0juI+yB5knX4KkJk4rYLnj/FNuHNHUI6zJ76iOws
	6ytpiE6KlNd2W4TwqyFVyqtml6c6qyzxIsjtfPD0GnpM6VomS91mSYlLSKScspzjvy7DIMseiYT
	EkhmT5J/b99TZgF2xh7f4eV904Ryr159dkmUP96aeO8bJc4V1AAtK/kdQopZTjvTCdgthvqJPyC
	4/npAaQyDzWOt+j5G9JQTMastIjiskpaZLQtusXp0AStpPeB72fldB8e5OQ5HLfTPCRLg3ixpDm
	pfNJBkvnq1qE4MygO4yFpQJcf6q3nCF+tSAWIKan
X-Received: by 2002:a05:620a:4049:b0:7e6:9a11:f0c8 with SMTP id af79cd13be357-813beffa169mr1079400085a.21.1757394260379;
        Mon, 08 Sep 2025 22:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+4M9jnqZ7XEtL8iNZFr7DfeWbk4fN2cPgrooLCIHf05hyNRzqCDxbOlnIixcIpPme44IWnw==
X-Received: by 2002:a05:620a:4049:b0:7e6:9a11:f0c8 with SMTP id af79cd13be357-813beffa169mr1079397285a.21.1757394259952;
        Mon, 08 Sep 2025 22:04:19 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c51dacsm64417585a.12.2025.09.08.22.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:04:19 -0700 (PDT)
Message-ID: <b71c7500-3e1b-491b-8cf0-989401bc6795@redhat.com>
Date: Tue, 9 Sep 2025 01:04:17 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] PCI: Check ACS Extended flags for
 pci_bus_isolated()
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com
References: <11-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <11-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DS0rPz-7Wm1OJ9GdCfNdGuzCWMVfWZalK8LLhewkn_4_1757394260
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> When looking at a PCIe switch we want to see that the USP/DSP MMIO have
> request redirect enabled. Detect the case where the USP is expressly not
> isolated from the DSP and ensure the USP is included in the group.
> 
> The DSP Memory Target also applies to the Root Port, check it there
> too. If upstream directed transactions can reach the root port MMIO then
> it is not isolated.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/pci/search.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index dac6b042fd5f5d..cba417cbe3476e 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -127,6 +127,8 @@ static enum pci_bus_isolation pcie_switch_isolated(struct pci_bus *bus)
>   	 * traffic flowing upstream back downstream through another DSP.
>   	 *
>   	 * Thus any non-permissive DSP spoils the whole bus.
> +	 * PCI_ACS_UNCLAIMED_RR is not required since rejecting requests with
> +	 * error is still isolation.
>   	 */
>   	guard(rwsem_read)(&pci_bus_sem);
>   	list_for_each_entry(pdev, &bus->devices, bus_list) {
> @@ -136,8 +138,14 @@ static enum pci_bus_isolation pcie_switch_isolated(struct pci_bus *bus)
>   		    pdev->dma_alias_mask)
>   			return PCIE_NON_ISOLATED;
>   
> -		if (!pci_acs_enabled(pdev, PCI_ACS_ISOLATED))
> +		if (!pci_acs_enabled(pdev, PCI_ACS_ISOLATED |
> +						   PCI_ACS_DSP_MT_RR |
> +						   PCI_ACS_USP_MT_RR)) {
> +			/* The USP is isolated from the DSP */
> +			if (!pci_acs_enabled(pdev, PCI_ACS_USP_MT_RR))
> +				return PCIE_NON_ISOLATED;
>   			return PCIE_SWITCH_DSP_NON_ISOLATED;
> +		}
>   	}
>   	return PCIE_ISOLATED;
>   }
> @@ -232,11 +240,13 @@ enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus)
>   	/*
>   	 * Since PCIe links are point to point root ports are isolated if there
>   	 * is no internal loopback to the root port's MMIO. Like MFDs assume if
> -	 * there is no ACS cap then there is no loopback.
> +	 * there is no ACS cap then there is no loopback. The root port uses
> +	 * DSP_MT_RR for its own MMIO.
>   	 */
>   	case PCI_EXP_TYPE_ROOT_PORT:
>   		if (bridge->acs_cap &&
> -		    !pci_acs_enabled(bridge, PCI_ACS_ISOLATED))
> +		    !pci_acs_enabled(bridge,
> +				     PCI_ACS_ISOLATED | PCI_ACS_DSP_MT_RR))
>   			return PCIE_NON_ISOLATED;
>   		return PCIE_ISOLATED;
>   
Reviewed-by: Donald Dutile <ddutile@redhat.com>

