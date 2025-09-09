Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479454654
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390944; cv=none; b=K0d4+ZvuqKhmLCrzsuuEZlI1bv0Zlow4faQrFFyOUUIxLaO6JIy4ybuvThI5S8wRnWLWJRrR/u19UaJkGhatzki/QOgelQ9Q9rQMrt0/1JYe9M2zwHuZqjmCGj/gXAh/yqHkxJzMD3ev9rFpDWs12/m+qB/Nlb9UCjzigRzljsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390944; c=relaxed/simple;
	bh=iWU6y9sGVKEcalUqGLIVzjnIR1x3e9JlkirRrAFMQa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bh5PRk2MgUs4aFJQNi8D25OYnsa9VdQFdE3oGJ1dfPaEif3OcoBlRZ/zBHjKiChKDt5sz1lJuPPzLO+20+UCU5fgM6RojnO9X7zL1lQFRS79L3ldf7QkFUxlioEvit3fVoYYG3oO+kzn3jVymvTjfPWmWBKFuWgPP4SS8I0BWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsJ+X2uB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsJ+X2uB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757390941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzU2hNnt1jVRFRPaX11xMsuYrOPsVzkQojp04wjwX3U=;
	b=IsJ+X2uBzCpFbG73NH4JHDNh+wKQYxMU4czgXo2/3qmoE/uYS7jATu5kVmrWJ5kchlNM7I
	4CHKrl/6bHZFvnODcgmDI9ryUr8qEQtZwsSOrDXj3FmMxMDpoAO0IwJN695/y1Haerh/VD
	VUUG8onMRGtXcUGB1FvLNQ1DHyyZJIs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-07WNcoqcPqOdPAKp-sW-ig-1; Tue, 09 Sep 2025 00:08:59 -0400
X-MC-Unique: 07WNcoqcPqOdPAKp-sW-ig-1
X-Mimecast-MFC-AGG-ID: 07WNcoqcPqOdPAKp-sW-ig_1757390939
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-80593bfe0a2so1417468885a.3
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 21:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390939; x=1757995739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzU2hNnt1jVRFRPaX11xMsuYrOPsVzkQojp04wjwX3U=;
        b=sCnJuQcXFBp4+kCZNpJRYvAcRLKYpCqxaRZm46nj7bhPzWZVIuNCTnTetG32HBLiSf
         f1HCFIJuKhrASNfHA1gT/BmWVR1O5ypMfMWPaEflxFOYJK0/rvNbR1vW7AElXGcBulsv
         35oElREoZe17iB6BnXTc3Ho13VrsMu6Oza9Z2juRgPWtugF9KqP5Kn4koHgc3gZknJJB
         cml7mptC9Jh/vi205sBPxtMp3AWpGkxz1ih3QI89Iqc9pwAVXs25ZS7LsLWEkz+ETAyi
         0wo2wnPdgFuJeHW7PP97XBR0frFpms4Mf3nYI4hgzV9lfb4Nwn5xbClL6DjqVqud/PHk
         Ae2g==
X-Forwarded-Encrypted: i=1; AJvYcCWAY9QBd9LddL2WVGKcQ/uy1jmmkk4QcZMR7EHUT/hRqw6GSypreqEgR94zhY+HYd2pg8JcLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2VjPcFzdOkpnCczMpM5MDEjGQet/z+yEfbd7Ge6RKKuIdUy8Z
	ODhIt09oe0FzSZ6PCy2C0PMZDaraz4HMJp+93uTgETt5kMZf6qGI3GdFJyh2LWtxzpRNvBhEHvj
	XyoZiTtFUdJOZv4dzGlchY4d3u1pKM3QhhvbZUKCByP2eR0p7esZhq8dJ
X-Gm-Gg: ASbGncuD39SBNPzAiJe0pPwUjntRmxeFIdT5oZtJpY6rZHH4GtrJrg5Gf8Jel1NiLRF
	faseHibope9rkczwWYjiCSt2s1xjmDhX7BDj3vbfAKQdGq1IFdTR8teaYkTspEpjcIdCSW/WDls
	TSUIJ/u3Ex9ebEZR/amtDkvTgNLU1GAwy9AO1cizz6/qOm0G3D99TneL+x495KjL0OqSLoRfG4a
	Mpf3b3V0phBNyb1coSR8k49RpO8691kS1TZM1q4BbnoMOA3dq1YBA/SGC6vcC1HwAEhzU/TQGT4
	gR+1Sjuak8v+yV/s/Jb4Gh1jLfB5YWhOv/rtAWUP
X-Received: by 2002:a05:620a:2588:b0:80b:c6fe:d020 with SMTP id af79cd13be357-813c31ed847mr999897485a.81.1757390939249;
        Mon, 08 Sep 2025 21:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp0lJqEawClZhPCZAPzI3y6p7bipMTBTSQzkm1P0k4tseTDGuIBLxBMAl/wmkP4doTA2xMIA==
X-Received: by 2002:a05:620a:2588:b0:80b:c6fe:d020 with SMTP id af79cd13be357-813c31ed847mr999894985a.81.1757390938798;
        Mon, 08 Sep 2025 21:08:58 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f9f65e9sm56912485a.64.2025.09.08.21.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 21:08:58 -0700 (PDT)
Message-ID: <2820eb21-9bd7-4832-bd88-31553cfd909d@redhat.com>
Date: Tue, 9 Sep 2025 00:08:56 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] PCI: Move REQ_ACS_FLAGS into pci_regs.h as
 PCI_ACS_ISOLATED
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <1-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <1-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y6hN8j0ZxkFC-qDbESuyWQd-EZdf9SnS_ANrwbQizxk_1757390939
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jason,
Hi.


On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> The next patch wants to use this constant, share it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c         | 16 +++-------------
>   include/uapi/linux/pci_regs.h | 10 ++++++++++
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee163..2a47ddb01799c1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1408,16 +1408,6 @@ EXPORT_SYMBOL_GPL(iommu_group_id);
>   static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>   					       unsigned long *devfns);
>   
> -/*
> - * To consider a PCI device isolated, we require ACS to support Source
> - * Validation, Request Redirection, Completer Redirection, and Upstream
> - * Forwarding.  This effectively means that devices cannot spoof their
> - * requester ID, requests and completions cannot be redirected, and all
> - * transactions are forwarded upstream, even as it passes through a
> - * bridge where the target device is downstream.
> - */
> -#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> -
>   /*
>    * For multifunction devices which are not isolated from each other, find
>    * all the other non-isolated functions and look for existing groups.  For
> @@ -1430,13 +1420,13 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
>   	struct pci_dev *tmp = NULL;
>   	struct iommu_group *group;
>   
> -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> +	if (!pdev->multifunction || pci_acs_enabled(pdev, PCI_ACS_ISOLATED))
>   		return NULL;
>   
>   	for_each_pci_dev(tmp) {
>   		if (tmp == pdev || tmp->bus != pdev->bus ||
>   		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
> -		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
> +		    pci_acs_enabled(tmp, PCI_ACS_ISOLATED))
>   			continue;
>   
>   		group = get_pci_alias_group(tmp, devfns);
> @@ -1580,7 +1570,7 @@ struct iommu_group *pci_device_group(struct device *dev)
>   		if (!bus->self)
>   			continue;
>   
> -		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
> +		if (pci_acs_path_enabled(bus->self, NULL, PCI_ACS_ISOLATED))
>   			break;
>   
>   		pdev = bus->self;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f5b17745de607d..6095e7d7d4cc48 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1009,6 +1009,16 @@
>   #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
>   #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
>   
> +/*
> + * To consider a PCI device isolated, we require ACS to support Source
> + * Validation, Request Redirection, Completer Redirection, and Upstream
> + * Forwarding.  This effectively means that devices cannot spoof their
> + * requester ID, requests and completions cannot be redirected, and all
> + * transactions are forwarded upstream, even as it passes through a
> + * bridge where the target device is downstream.
> + */
> +#define PCI_ACS_ISOLATED (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> +
>   /* SATA capability */
>   #define PCI_SATA_REGS		4	/* SATA REGs specifier */
>   #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
like the move & rename...

Reviewed-by: Donald Dutile <ddutile@redhat.com>

