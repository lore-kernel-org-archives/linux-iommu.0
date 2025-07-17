Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CE237164
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789854; cv=none; b=K/GECpksgB8za7luquoVTlKu1c9dD3zUk7yXVqEX0Tz0ASlZrKObjsE5daAAvsilRD7+9nWZUelMit24r4/dbURmRvvQMuvGIuj0X5OLqv9yd1SHCGwXUT2WCOqPNesyalFjhji+71HR3wSQcEfoS5o12ZSpkWLRSmih0EwdcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789854; c=relaxed/simple;
	bh=txFdG1TA1k7alMDI+822TkiUPrAEkZHjjc07gGexWaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T89DjLVee1IBuW9T6iXq08uwgC6Mu2fXameCKdVjqBRrvEzSrQpyUzjShCMdBWK9amlWh88tNwhv/EXb4EPKnA8ZZ/AoQnMUchzNZRkPLfmv4m1eSm1abVN1lclR8n+ubQfi5IDodOWBlkIUsuPjIDo0ahf2sVPHIvrAx5paYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvIB27p9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvIB27p9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752789851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14qo4ckuSkp5wHkmhsPFGvb+FvEFS3eV6eZ9+5OrkLA=;
	b=bvIB27p9ZJSHKSGjxc5dQ8Tsvevj3KMTCLQtJibdzsAWCt/AisTJgZeReYnrmyuEdI07P9
	d3Rm3wTfIu/IiqnzXtxw19m9IWWP3WH6CeB38Ek14AxW35Oz8dV0Vea1ro27egAMePmoSl
	IYqhj12GXigLVOIGwdC1AVEgUU6aLT0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-8G7j-20xNv2Ciae0vqm4zA-1; Thu, 17 Jul 2025 18:04:08 -0400
X-MC-Unique: 8G7j-20xNv2Ciae0vqm4zA-1
X-Mimecast-MFC-AGG-ID: 8G7j-20xNv2Ciae0vqm4zA_1752789848
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab401e333bso45330241cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 15:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752789848; x=1753394648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14qo4ckuSkp5wHkmhsPFGvb+FvEFS3eV6eZ9+5OrkLA=;
        b=mXxw5AeTa6W4i4Z8ZJg//7mZJs4vFAfqRBTr0oZdHR1BmaZCEGJ+l93zucR74RXDMp
         PnAaV6Ux+QFxgtaj0jhmXRwBaWDtBWs3Hs0n/Q/NXE9e9/4uTnrnUXnca4tXd/9IBD88
         9jaWY7RMyEx3DBVoMrPIdag8/Gl7Lml7cLC0dddOku6wkq4wXmjb/ll/UPNmiImScNnx
         okbBoJ2ykktXzGwNpyQl/X37zv7/Z3DTJyQpkj7qqkRZ2vlDPqKvT/C2EUMGwAyBP1px
         eyICb8WJvmOcYyMFm10iiI35EKvMG6iGazJEE31GBgZJVgyTFtWfoOPyxEACCRtcFkXv
         n35g==
X-Forwarded-Encrypted: i=1; AJvYcCXlBIohv1QIqal8YRdkQL8dAm1wiXw3jiUFHAZqxCfnVLg4/2siiTy27f6M8KH76q7dtNGm3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCsEVaBqE9n3WroSm+PXIdTgU2arNn7dhB6MOxDZhmqEJbtpA0
	3DYKmo6T8yLQEyT0fl6JMCX/nipRJWiBVxi4MxKOVu0Hue7hSWdrY8CrZmOjkrElFGsy4K5vBnd
	moV/afwbW+b9amyArmXDOKKp1zzE8RpzEnePU6FbrL2kPlPbL2up+I9b6
X-Gm-Gg: ASbGncvHsCGT/2W0ZvIjOXHcOhsDNGHBLU9U8zocHbeIuEf6XaTYfkRRv6RA5Oc4Dcs
	l8yqMQK41+DlTqv2qSXY68OLrvc9BDYwI+jHXhlPnfNL2up5ttPbrS4QMlWd+KynwKqC51gLE1I
	NiuJn1/c3Xa9CZFPVjU/V450CMNKo2KC5ZVdd7nWdbsMZbvE+o6VNXDsJW4wJqUaZNHDXTPwzJi
	xlOL5bBJc+TZzWrH//mnztRUvTofFR8DEokTRkZLT5UsXKPDQkhYax4eiwn2Gz2OMlr5/lBcpkT
	xW55JlwEQgIKxYxXMhe+ECAakmGIjNj4K8IYLk5r
X-Received: by 2002:a05:622a:4898:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4abb078731emr29333521cf.5.1752789847777;
        Thu, 17 Jul 2025 15:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1MD1NbNTtFtXk2nNvNPQWBDbPtpdcIJIB0sY9UfJlcgBx07gvMOxQw7v7ytGjpx3C6A55ZA==
X-Received: by 2002:a05:622a:4898:b0:4ab:622b:fffb with SMTP id d75a77b69052e-4abb078731emr29332751cf.5.1752789847095;
        Thu, 17 Jul 2025 15:04:07 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb497fb35sm341791cf.15.2025.07.17.15.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 15:04:06 -0700 (PDT)
Message-ID: <3bf0f555-535d-4e47-8ff1-f31b561a188c@redhat.com>
Date: Thu, 17 Jul 2025 18:04:04 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] PCI: Add pci_reachable_set()
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <5-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <5-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CfevyYCbDziyF5i16-Q_9vausfZc_3DpnVAKgVoocUI_1752789848
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jason,
Hi!

general question below, that you may know given your efficient compute log below.

On 7/9/25 10:52 AM, Jason Gunthorpe wrote:
> Implement pci_reachable_set() to efficiently compute a set of devices on
> the same bus that are "reachable" from a starting device. The meaning of
> reachability is defined by the caller through a callback function.
> 
This comment made me review get_pci_alias_group(), which states in its description:
* Look for aliases to or from the given device for existing groups. DMA
  * aliases are only supported on the same bus, therefore the search
  * space is quite small

So why does it do the for loop:
   for_each_pci_dev(tmp) {

vs getting the pdev->bus->devices -- list of devices on that bus, and only
scan that smaller list, vs all pci devices on the system?


> This is a faster implementation of the same logic in
> pci_device_group(). Being inside the PCI core allows use of pci_bus_sem so
> it can use list_for_each_entry() on a small list of devices instead of the
> expensive for_each_pci_dev(). Server systems can now have hundreds of PCI
> devices, but typically only a very small number of devices per bus.
> 
> An example of a reachability function would be pci_devs_are_dma_aliases()
> which would compute a set of devices on the same bus that are
> aliases. This would also be useful in future support for the ACS P2P
> Egress Vector which has a similar reachability problem.
> 
> This is effectively a graph algorithm where the set of devices on the bus
> are vertexes and the reachable() function defines the edges. It returns a
> set of vertexes that form a connected graph.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Could we move this to just before patch 11 where it is used?
or could this be used to improve get_pci_alias_group() and get_pci_function_alias_group() ?

> ---
>   drivers/pci/search.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci.h  | 12 ++++++
>   2 files changed, 102 insertions(+)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a13fad53e44df9..dc816dc4505c6d 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -585,3 +585,93 @@ int pci_dev_present(const struct pci_device_id *ids)
>   	return 0;
>   }
>   EXPORT_SYMBOL(pci_dev_present);
> +
> +/**
> + * pci_reachable_set - Generate a bitmap of devices within a reachability set
> + * @start: First device in the set
> + * @devfns: The set of devices on the bus
> + * @reachable: Callback to tell if two devices can reach each other
> + *
> + * Compute a bitmap where every set bit is a device on the bus that is reachable
> + * from the start device, including the start device. Reachability between two
> + * devices is determined by a callback function.
> + *
> + * This is a non-recursive implementation that invokes the callback once per
> + * pair. The callback must be commutative:
> + *    reachable(a, b) == reachable(b, a)
> + * reachable() can form a cyclic graph:
> + *    reachable(a,b) == reachable(b,c) == reachable(c,a) == true
> + *
> + * Since this function is limited to a single bus the largest set can be 256
> + * devices large.
> + */
> +void pci_reachable_set(struct pci_dev *start, struct pci_reachable_set *devfns,
> +		       bool (*reachable)(struct pci_dev *deva,
> +					 struct pci_dev *devb))
> +{
> +	struct pci_reachable_set todo_devfns = {};
> +	struct pci_reachable_set next_devfns = {};
> +	struct pci_bus *bus = start->bus;
> +	bool again;
> +
> +	/* Assume devfn of all PCI devices is bounded by MAX_NR_DEVFNS */
> +	static_assert(sizeof(next_devfns.devfns) * BITS_PER_BYTE >=
> +		      MAX_NR_DEVFNS);
> +
> +	memset(devfns, 0, sizeof(devfns->devfns));
> +	__set_bit(start->devfn, devfns->devfns);
> +	__set_bit(start->devfn, next_devfns.devfns);
> +
> +	down_read(&pci_bus_sem);
> +	while (true) {
> +		unsigned int devfna;
> +		unsigned int i;
> +
> +		/*
> +		 * For each device that hasn't been checked compare every
> +		 * device on the bus against it.
> +		 */
> +		again = false;
> +		for_each_set_bit(devfna, next_devfns.devfns, MAX_NR_DEVFNS) {
> +			struct pci_dev *deva = NULL;
> +			struct pci_dev *devb;
> +
> +			list_for_each_entry(devb, &bus->devices, bus_list) {
> +				if (devb->devfn == devfna)
> +					deva = devb;
> +
> +				if (test_bit(devb->devfn, devfns->devfns))
> +					continue;
> +
> +				if (!deva) {
> +					deva = devb;
> +					list_for_each_entry_continue(
> +						deva, &bus->devices, bus_list)
> +						if (deva->devfn == devfna)
> +							break;
> +				}
> +
> +				if (!reachable(deva, devb))
> +					continue;
> +
> +				__set_bit(devb->devfn, todo_devfns.devfns);
> +				again = true;
> +			}
> +		}
> +
> +		if (!again)
> +			break;
> +
> +		/*
> +		 * Every new bit adds a new deva to check, reloop the whole
> +		 * thing. Expect this to be rare.
> +		 */
> +		for (i = 0; i != ARRAY_SIZE(devfns->devfns); i++) {
> +			devfns->devfns[i] |= todo_devfns.devfns[i];
> +			next_devfns.devfns[i] = todo_devfns.devfns[i];
> +			todo_devfns.devfns[i] = 0;
> +		}
> +	}
> +	up_read(&pci_bus_sem);
> +}
> +EXPORT_SYMBOL_GPL(pci_reachable_set);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 517800206208b5..2e629087539101 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -834,6 +834,10 @@ struct pci_dynids {
>   	struct list_head	list;	/* For IDs added at runtime */
>   };
>   
> +struct pci_reachable_set {
> +	DECLARE_BITMAP(devfns, 256);
> +};
> +
>   enum pci_bus_isolation {
>   	/*
>   	 * The bus is off a root port and the root port has isolated ACS flags
> @@ -1248,6 +1252,9 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>   struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
>   struct pci_dev *pci_get_base_class(unsigned int class, struct pci_dev *from);
>   
> +void pci_reachable_set(struct pci_dev *start, struct pci_reachable_set *devfns,
> +		       bool (*reachable)(struct pci_dev *deva,
> +					 struct pci_dev *devb));
>   enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus);
>   
>   int pci_dev_present(const struct pci_device_id *ids);
> @@ -2063,6 +2070,11 @@ static inline struct pci_dev *pci_get_base_class(unsigned int class,
>   						 struct pci_dev *from)
>   { return NULL; }
>   
> +static inline void
> +pci_reachable_set(struct pci_dev *start, struct pci_reachable_set *devfns,
> +		  bool (*reachable)(struct pci_dev *deva, struct pci_dev *devb))
> +{ }
> +
>   static inline enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus)
>   { return PCIE_NON_ISOLATED; }
>   

