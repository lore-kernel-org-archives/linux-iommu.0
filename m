Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF043DCD9C
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127501; cv=none; b=Ck+a9gOfF3aNDysn+WjBEveZqu7J2FGEqYP78ZznOSzjMGeHevuPVO1Ez4YVEvfnvZUzld3vnjuzsf11vI1wN731dQvaPGzVIQf7rZ+5BoC9iLU5Wx5Y+OhT4dTdG+lmqlrl8OnbwkaFUYUy8+ZMsKq+X7K1eH4P8e1CrtYxM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127501; c=relaxed/simple;
	bh=EXylCZgrL9h8nQeApwtJhBUtSUDE7y517bWPFtRYkSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJwQH5XrRt9cR4OVY95vrUl1sG1jnCQpdpTyEEcv7q/BnoInyMnW+FKxu+uYh2KiCACWdhFGeNuiJZxAqzQkJ7YI93aoYpNIZFst5jB9L/jNngWeiiI3yqfF4lesATQNkfsn26aMxsIvY20M5KZZDX4U1vm+8S00g0zxKstLGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EeiBFDkq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EeiBFDkq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787127484; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LaoALB+EnDmHNgZ/YlM0ls9eU9C1PElBX2geRRczHss=;
	b=EeiBFDkqDgDxTcGuO5YLOa4ZPCym5gdgFa5z/PoyDCUptGBEJOiNdhOGe7lFsu1Vq75TGwauHiZA56bGL4dXtd9nqhRqISCD0F4HP2R4vDDhTqwL7f4r4b6AYqufnvEzk6r9xbfiXBT2mgq7QFWnRhoa8kpbJzKJwb0NGSpGIwI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9FxBER_1787127460;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9FxBER_1787127460 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 16:18:03 +0800
Message-ID: <edbd2471-58c4-4166-8692-d4d03a7486e5@linux.alibaba.com>
Date: Wed, 19 Aug 2026 16:17:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] iommu/amd: Introduce vIOMMU-specific events and
 event
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:28, Suravee Suthikulpanit 写道:
> Adding support for new vIOMMU events:
>    * Guest Event Fault event
>    * vIOMMU Hardware Error event
>
> Also, adding support for the additional vIOMMU related flags
> in existing events.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  7 ++++
>   drivers/iommu/amd/iommu.c           | 58 ++++++++++++++++++++++-------
>   2 files changed, 52 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index d2c64e2e9f05..4df6a50128de 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -149,6 +149,9 @@
>   #define EVENT_TYPE_IOTLB_INV_TO	0x7
>   #define EVENT_TYPE_INV_DEV_REQ	0x8
>   #define EVENT_TYPE_INV_PPR_REQ	0x9
> +#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb
> +#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
> +
>   #define EVENT_TYPE_RMP_FAULT	0xd
>   #define EVENT_TYPE_RMP_HW_ERR	0xe
>   #define EVENT_DEVID_MASK	0xffff
> @@ -261,6 +264,10 @@
>   #define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
>   #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
>   
> +/* Constants for IO_PAGE_FAULT event */
> +#define IO_PAGE_FAULT_VFLAGS_SHIFT	27
> +#define IO_PAGE_FAULT_VFLAGS_MASK	GENMASK_ULL(27, 23)
> +
>   /* Constants for PPR Log handling */
>   #define PPRLOG_ENTRY_SIZE	0x10
>   #define PPRLOG_SIZE_SHIFT	56
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4b4dd20ebec6..50f26c8123f3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -854,7 +854,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
>   
>   static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>   					u16 devid, u16 domain_id,
> -					u64 address, int flags)
> +					u64 address, int flags, u8 vflags)
>   {
>   	struct iommu_dev_data *dev_data = NULL;
>   	struct pci_dev *pdev;
> @@ -889,13 +889,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>   		}
>   
>   		if (__ratelimit(&dev_data->rs)) {
> -			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
> -				domain_id, address, flags);
> +			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
> +				domain_id, address, flags, vflags);
>   		}
>   	} else {
> -		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
> +		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			domain_id, address, flags);
> +			domain_id, address, flags, vflags);
>   	}
>   
>   out:
> @@ -932,29 +932,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   	}
>   
>   	if (type == EVENT_TYPE_IO_FAULT) {
> -		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
>   		return;
>   	}
>   
>   	switch (type) {
>   	case EVENT_TYPE_ILL_DEV:
> -		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
> +	{
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY deice=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x vflags=%#x]\n",
>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			pasid, address, flags);

A minor typos in the log strings: "deice" -> "device"

> +			pasid, address, flags, vflags);
>   		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
>   		dump_dte_entry(iommu, devid);
>   		break;
> +	}
>   	case EVENT_TYPE_DEV_TAB_ERR:
> -		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
> -			"address=0x%llx flags=0x%04x]\n",
> +	{
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x address=%#llx flags=%#04x vlfags=%#x]\n",
>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
typos : "vlfags" -> "vflags".
> -			address, flags);
> +			address, flags, vflags);
>   		break;
> +	}
>   	case EVENT_TYPE_PAGE_TAB_ERR:
> -		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
> +	{
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -			pasid, address, flags);
> +			pasid, address, flags, vflags);
>   		break;
> +	}
>   	case EVENT_TYPE_ILL_CMD:
>   		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
>   		dump_command(address);
> @@ -986,6 +999,25 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>   			pasid, address, flags, tag);
>   		break;
> +	case EVENT_TYPE_GUEST_EVENT_FAULT:
> +	{
> +		u8 gid = event[1] & 0xFFFF;
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);

The GuestID is declared as u8 but assigned a 16-bit value masked with
0xFFFF. This truncates the upper 8 bits. Per the AMD IOMMU Specification
(Rev 3.10, Section 2.5.12, Table 68), the GuestID field is 16 bits wide
[15:0]. This should be:

     u16 gid = event[1] & 0xFFFF;

Note that the VIOMMU_HARDWARE_ERROR handler below correctly uses u16 for
the same field, so this looks like an oversight.


Additionally, per Section 2.5.12, a GUEST_EVENT_FAULT occupies two log
entries (paired event entry). The current iommu_poll_events() advances
by a single entry per iteration, so the second (paired) entry will be
misinterpreted as an unknown event type on the next iteration. The
handler should consume/skip the second entry.

> +
> +		dev_err(dev, "Event logged [GUEST_EVENT_FAULT gid=#%x flags=0x%04x vflags=%#x]\n",
> +			gid, flags, vflags);
> +		break;
> +	}
> +	case EVENT_TYPE_VIOMMU_HW_ERR:
> +	{
> +		u16 gid = event[0] & 0xFFFF;
> +		u8 src = (event[0] >> 16) & 0x3;
> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> +
> +		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=%#x vflags=%#x]\n",
> +			gid, address, src, flags, vflags);
> +		break;
> +	}
>   	default:
>   		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
>   			event[0], event[1], event[2], event[3]);
