Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C832239E7A
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790033; cv=none; b=IGyM9fVt4wQgjMARTVjYCKwenxQdYQ3D3RTjlVJnEhrQFRRMPFvexzYe/r/b1/PhMT7mGooM/uHn39GkKZs+PRcbopTaUXdjPCY4zDclAYuRHA+nSno0ay6M/tg9AYdgjSv4qI61MVy8758OnycuSYM09nAP7vfbSIK9qjbBT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790033; c=relaxed/simple;
	bh=EG+lJKnf2Bs5h5ukGDK7/JBBSQzQipiVsWFvQtRbYIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpxLJjM44U8H2jeiLS9l7zSatEB/MqbcSx1OsXJscQtbS3qaVEAEIhcIp3BVud1c5faEKTSxn8DXTj6D1KUAkD1DLGsl/aLe6LeMuJQzO5PPMJAqPDNBUBkzFnfy8SbIrFI0tIUea4JAVnZlOqjHMKGcPaHDaQWpeR3NnFLkM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKIU1bGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKIU1bGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752790030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/7LIzWGZTHEMGcMK+WE53GZ9j5TSEz1spH81A3VRh8=;
	b=OKIU1bGd5XAtT6sjGGw2TZqGYexXuG1vIuQ/j6/Ti7K0SUuY6zD+825yItqHs77wV96Odv
	DjRiL3s+YioH5UXmcCdq0b3wJ4shifRr9/VGs3YeNW2pTUwOw+M5gDRvSTZn816M0ajERg
	yVRw9kAfD31FLrI4qclVVLgEajchO+I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-aBH8DzkgOceBv1ymhxZDEA-1; Thu, 17 Jul 2025 18:07:09 -0400
X-MC-Unique: aBH8DzkgOceBv1ymhxZDEA-1
X-Mimecast-MFC-AGG-ID: aBH8DzkgOceBv1ymhxZDEA_1752790028
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e350915d2aso252494085a.1
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 15:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752790028; x=1753394828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/7LIzWGZTHEMGcMK+WE53GZ9j5TSEz1spH81A3VRh8=;
        b=OCAfmxHJMNE1JfBq+iqsuq/LEuL6C/OlsK1yfnADbCijV/PmpVQSETmKUz2ADCe+Dq
         yCZq8Kakdice6aiSUxVVJeY4TVdnmY9rj0Q+mnxT97o/be9Ii4UTv5VHFWlzh1hdaeIj
         W2JYUHD+4mAaEz77UET41n5UDTuo7Z2rtgYddzT5wRdWAwb54mnyHgyParNGMivA3SSA
         RrN6ToTbQD0H1j10Q5EA/ZL1DzPdrqQ5lYpNNIn0uF290OyDSTeT26ggcVO4IK1d249j
         0nAKjPtXTeVNg51z4kjez6pNMm3W+Gl9JmMxWyNib9A45P+gDZiVkAtJKjJMZzphySnn
         fH6A==
X-Forwarded-Encrypted: i=1; AJvYcCWCIYNiasR00FXWJAbtFPGcsxF9R1W+IfEckzYfPWScLyMTIpWcJf7f1hi4VCl/ba/kH0kmsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMVLKJ8TSL5gfRfATFpZpbIlsFGSkPoDD906BWBXd8j+JBH3eK
	LWKoLWuinnClPUCigFJDkpipE9g1yJhcmUT5HInEHghbYmkc42NKOqS72odykyRepUH/7riLK2G
	8u92G2mKTloJRPX55HA3jx+y7TGzP8tiNmSIGxE1PsbtpRxsSQLjy8ED6
X-Gm-Gg: ASbGncsuuilUgFscA5zgThyUxPYo9ZF8IvND9n9OaVd8hNPQyD6nLUBoUXA08HnJYSF
	7/J1O2WepPl2DtM9Q8FoD3R3RFo69d0e64adJSNPvaznB1k+dzn7G3bw3pqbdn75u3kpbbuZtdw
	/U6S/Ur+ZNqQr+Mmnz4OL+vBFAzl6fzRtyZb9T7Qz+6rl6AiQ9c3gbDLcCow8qmPWVBa43xRf7U
	2c8wmfj72RxgWKbLRGsh7oi1xK5Nb92GeBJopC1j+nlStkayThRipR49ICdk+vy0AoCt4y1hEic
	kjuXPrgEGc6lcY2sYB0a87E0IDP0WXGD1PlckSKW
X-Received: by 2002:a05:620a:1a8d:b0:7d4:6123:fae0 with SMTP id af79cd13be357-7e356b058a6mr86371685a.44.1752790028588;
        Thu, 17 Jul 2025 15:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbseTo+gO4cZxdtMq5RbINML3GgRZjSc2b9jj9nPnFlA7otH7sfkPnFo9zj9g7oUpzhXsLAg==
X-Received: by 2002:a05:620a:1a8d:b0:7d4:6123:fae0 with SMTP id af79cd13be357-7e356b058a6mr86365585a.44.1752790027957;
        Thu, 17 Jul 2025 15:07:07 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b28a7esm17195285a.19.2025.07.17.15.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:07:07 -0700 (PDT)
Message-ID: <e951d3a6-faa6-44e5-a3c4-19bfd20782ee@redhat.com>
Date: Thu, 17 Jul 2025 18:07:05 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] iommu: Validate that pci_for_each_dma_alias()
 matches the groups
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <12-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <12-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HvdIrHBvhnfS3UdNp-GKdhWOaZ1btDVV9htqLs51Ggg_1752790028
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/25 10:52 AM, Jason Gunthorpe wrote:
> Directly check that the devices touched by pci_for_each_dma_alias() match
> the groups that were built by pci_device_group(). This helps validate that
> pci_for_each_dma_alias() and pci_bus_isolated() are consistent.
> 
> This should eventually be hidden behind a debug kconfig, but for now it is
> good to get feedback from more diverse systems if there are any problems.
> 
+1 ... good idea!

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd26b43916e8be..e4ae1d064554e4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1606,7 +1606,7 @@ static struct iommu_group *pci_hierarchy_group(struct pci_dev *pdev)
>    *     Once a PCI bus becomes non isolating the entire downstream hierarchy of
>    *     that bus becomes a single group.
>    */
> -struct iommu_group *pci_device_group(struct device *dev)
> +static struct iommu_group *__pci_device_group(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct iommu_group *group;
> @@ -1713,6 +1713,77 @@ struct iommu_group *pci_device_group(struct device *dev)
>   	WARN_ON(true);
>   	return ERR_PTR(-EINVAL);
>   }
> +
> +struct check_group_aliases_data {
> +	struct pci_dev *pdev;
> +	struct iommu_group *group;
> +};
> +
> +static void pci_check_group(const struct check_group_aliases_data *data,
> +			    u16 alias, struct pci_dev *pdev)
> +{
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(&pdev->dev);
> +	if (!group)
> +		return;
> +
> +	if (group != data->group)
> +		dev_err(&data->pdev->dev,
> +			"During group construction alias processing needed dev %s alias %x to have the same group but %u != %u\n",
> +			pci_name(pdev), alias, data->group->id, group->id);
> +	iommu_group_put(group);
> +}
> +
> +static int pci_check_group_aliases(struct pci_dev *pdev, u16 alias,
> +				   void *opaque)
> +{
> +	const struct check_group_aliases_data *data = opaque;
> +
> +	/*
> +	 * Sometimes when a PCIe-PCI bridge is performing transactions on behalf
> +	 * of its subordinate bus it uses devfn=0 on the subordinate bus as the
> +	 * alias. This means that 0 will alias with all devfns on the
> +	 * subordinate bus and so we expect to see those in the same group. pdev
> +	 * in this case is the bridge itself and pdev->bus is the primary bus of
> +	 * the bridge.
> +	 */
> +	if (pdev->bus->number != PCI_BUS_NUM(alias)) {
> +		struct pci_dev *piter = NULL;
> +
> +		for_each_pci_dev(piter) {
> +			if (pci_domain_nr(pdev->bus) ==
> +				    pci_domain_nr(piter->bus) &&
> +			    PCI_BUS_NUM(alias) == pdev->bus->number)
> +				pci_check_group(data, alias, piter);
> +		}
> +	} else {
> +		pci_check_group(data, alias, pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +struct iommu_group *pci_device_group(struct device *dev)
> +{
> +	struct iommu_group *group = __pci_device_group(dev);
> +
> +	if (!IS_ERR(group)) {
> +		struct check_group_aliases_data data = {
> +			.pdev = to_pci_dev(dev), .group = group
> +		};
> +
> +		/*
> +		 * The IOMMU driver should use pci_for_each_dma_alias() to
> +		 * figure out what RIDs to program and the core requires all the
> +		 * RIDs to fall within the same group. Validate that everything
> +		 * worked properly.
> +		 */
> +		pci_for_each_dma_alias(data.pdev, pci_check_group_aliases,
> +				       &data);
> +	}
> +	return group;
> +}
>   EXPORT_SYMBOL_GPL(pci_device_group);
>   
>   /* Get the IOMMU group for device on fsl-mc bus */

