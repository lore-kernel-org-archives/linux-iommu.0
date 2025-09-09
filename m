Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B12F3616
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394023; cv=none; b=odYBaNj+qlVeMsCOo9yhKq8U28RyM0ap7GEfOZ+EIbn2SWAVqoePGTkMxLC0c+DTlnYxpgIKpF2gI8mNlDWFNDjaCTSWxZgyg/xmpfrxAOakNbj9dACFOHqDuL7ho0O/YDlmvAOoyjFO54zhtxcxsCpIDQu+6MY49A5QkWvpTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394023; c=relaxed/simple;
	bh=1oxzIB+Bq27heH7UqJ7HD5sfAeymQ9opp8zaJLFAIQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzogI3hAMR64OOL724sUnJ957YjI37oTFVq4W6Km7bZUDX7S1nk4ZE8FXvyL+BiDf59JBI3SHR4+r3ICdhyEO+CY89nsUANA0U8prdMcQTdja6Ko0YJEY3JkYuGNlmMgw8qHaUvJsH1U4eI6xbg+oMBcCiW/KV8qiLxkHIdLu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DB5LYutd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB5LYutd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757394020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6iQxBUowgZS1gNMSIU064JFfiN2wIaCl+0CSNLdzGc=;
	b=DB5LYutdpX1Yfx+LaGb5WU+XpmhrNzaMMpo9rhGtBsH3Xl0zNNibTFqYjQc0+WyV81okYB
	GLp7LMeoRqwe9+NlH687c7PmKrpwGfYjfbCaZ8vK9tM99VBUEqFXtZWZJaDCV72Z2R7Xvo
	X5hZZNg1MdogKTpu5SYjUcFtELDWsfU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-opQ3q1cXPFC7jik9Hco9fQ-1; Tue, 09 Sep 2025 01:00:18 -0400
X-MC-Unique: opQ3q1cXPFC7jik9Hco9fQ-1
X-Mimecast-MFC-AGG-ID: opQ3q1cXPFC7jik9Hco9fQ_1757394013
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72e83eb8cafso82109556d6.2
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 22:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394012; x=1757998812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6iQxBUowgZS1gNMSIU064JFfiN2wIaCl+0CSNLdzGc=;
        b=Ga6v6riPX3xIhRLqXZf3VulTCIScxyrPm/DfFwLtpl229kJbC5nweB1B4S89NCqt4i
         3VE7tt/kyJAZY+ucxpsslaAeeTjhH6qYhv0TRH3WPCN7ZZPP48xy1WjAauiiGlAcaoz2
         xb2wZZI45QUYoqR4Ah4yaKSMwkb5BPDwRXpnjYHXg/GbemZKc/LQcWPg0mWURrWsiVwj
         c3yHChWikJWqyLJEzG8C/6VWh0h50LBZrkuVYg4N73ho7zKgS2EwBbveVk3d5IOtHZn0
         jhbH0WD5RRIhbTT5agb836SPqZqXa/E5UCWeDfIU1alI849pX8JSYBpdGCOmMDRHcCyb
         leow==
X-Forwarded-Encrypted: i=1; AJvYcCXV795z2R1z5OlUZ6brOYS+W3DM+5iSynUCximQ++E72rI9CXCFEmtJSIEMaS2FmKSNXtuwvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFfeTklLjTv+GhEjBYAXNofzB9N4Wunzfc7wPypcPsE+4UGsJS
	Q6qTybTF/J7nQG8kwBoa6JR0yEYCm1VPI8K1GDZO3VogTP78VxBpEL/e4Z8YPcLpGMbhqJVTwE+
	c4n/8hO97DLLaABVQ41/+pooOKcpbRjY/rrBkWqmCF4DxvPrvFkgHMi4RHMP1JXPm
X-Gm-Gg: ASbGncv6kwo3v5ObbrxJ3QpdgKFzl69SnkL7SKkfigddRTicjjvhi29+xYxBg+oE2s0
	IZfKHhQEC97oHFc0vo6RLD/rktM96U2ZZ9FmOxrgVrkKIsLsaCXq0RsS+zTR+5phan0VtOvEP9L
	3wgawgWeX6PR7S6j6UcjksQnoO8DhXtgMwMnjBzMt4BQkEl9v/3p7yDNlfKgCqQGsrB5C0d85O8
	dXX09YE83ZKRlJA4Ssvf3lLK9sM9N4kBLLUnB9e0bo/SQtqLrZvMcBZrOho6b2yTGQTqwIyQRRt
	MU2KHAG44XuzE1quOEEPCEYzG2fptm6cR8j5fYFN
X-Received: by 2002:a05:6214:20a1:b0:749:a12b:2d58 with SMTP id 6a1803df08f44-749a12b2f2cmr61919926d6.60.1757394012287;
        Mon, 08 Sep 2025 22:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbhlr0VwTq4d+7yg1kvRuLY1QCWsGq5tYaJVVe3wMI23DU+9UPnzZF9LjoX5cUPqjAsHKB1w==
X-Received: by 2002:a05:6214:20a1:b0:749:a12b:2d58 with SMTP id 6a1803df08f44-749a12b2f2cmr61919636d6.60.1757394011771;
        Mon, 08 Sep 2025 22:00:11 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-725dda254d4sm118146646d6.8.2025.09.08.22.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:00:11 -0700 (PDT)
Message-ID: <9487fde9-ec40-4383-aafe-7ae0811830f5@redhat.com>
Date: Tue, 9 Sep 2025 01:00:08 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] iommu: Validate that pci_for_each_dma_alias()
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
References: <7-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <7-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GdIlbJ9T1Bdxq_rApDaNpqQrssGoSuauY9Ja-lkzZMk_1757394013
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> Directly check that the devices touched by pci_for_each_dma_alias() match
> the groups that were built by pci_device_group(). This helps validate that
Do they have to match, as in equal, or be included ?

> pci_for_each_dma_alias() and pci_bus_isolated() are consistent.
> 
> This should eventually be hidden behind a debug kconfig, but for now it is
> good to get feedback from more diverse systems if there are any problems.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 76 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fc3c71b243a850..2bd43a5a9ad8d8 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1627,7 +1627,7 @@ static struct iommu_group *pci_hierarchy_group(struct pci_dev *pdev)
>    *     Once a PCI bus becomes non isolating the entire downstream hierarchy of
>    *     that bus becomes a single group.
>    */
> -struct iommu_group *pci_device_group(struct device *dev)
> +static struct iommu_group *__pci_device_group(struct device *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct iommu_group *group;
> @@ -1734,6 +1734,80 @@ struct iommu_group *pci_device_group(struct device *dev)
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
> +	struct check_group_aliases_data data = {
> +		.pdev = to_pci_dev(dev),
> +	};
> +	struct iommu_group *group;
> +
> +	if (!IS_ENABLED(CONFIG_PCI))
> +		return ERR_PTR(-EINVAL);
> +
> +	group = __pci_device_group(dev);
> +	if (IS_ERR(group))
> +		return group;
> +
> +	/*
> +	 * The IOMMU driver should use pci_for_each_dma_alias() to figure out
> +	 * what RIDs to program and the core requires all the RIDs to fall
> +	 * within the same group. Validate that everything worked properly.
> +	 */
> +	data.group = group;
> +	pci_for_each_dma_alias(data.pdev, pci_check_group_aliases, &data);
> +	return group;
> +}
>   EXPORT_SYMBOL_GPL(pci_device_group);
>   
>   /* Get the IOMMU group for device on fsl-mc bus */

