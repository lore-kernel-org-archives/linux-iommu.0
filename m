Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D37C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 07:30:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CC764DD8
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 07:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CC764DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 71DF385F9A;
	Mon,  1 Feb 2021 07:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nxt2NX1476ec; Mon,  1 Feb 2021 07:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF6FB85F8B;
	Mon,  1 Feb 2021 07:30:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFC9BC0FA7;
	Mon,  1 Feb 2021 07:30:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE96BC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 07:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B4C3885F97
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 07:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M23oHdmdN7bu for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 07:30:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CB96385F8B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612164637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GxejYmvqxAVe79rsjXK+9gKzCLOQZ1mJGritX/MZYCc=;
 b=Cy0qsFOnLkOwi2OSOUz+YbIwkH8Qs6vvlYdiK4IgWk9kDVvTmY7udH+nAkpNaaLxXJwdZU
 5AG3ZeGwRi0kgHEXtFy3rn1VDoZkSFF3fMLHUIKtcmJeJu3v8hheNsSmZnE2aLNVt+Sz5r
 Y69J5uYZGNB1VLn+vtwCrFiP7cEWF7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-kxmqfPUGMjO-V6Eu84qfgA-1; Mon, 01 Feb 2021 02:30:32 -0500
X-MC-Unique: kxmqfPUGMjO-V6Eu84qfgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1ABD107ACE8;
 Mon,  1 Feb 2021 07:30:29 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E835779CF;
 Mon,  1 Feb 2021 07:30:22 +0000 (UTC)
Subject: Re: [PATCH v12 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-3-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ce05e0e7-8ccc-0a9e-0762-64a41d05b33c@redhat.com>
Date: Mon, 1 Feb 2021 08:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210127154322.3959196-3-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, vivek.gautam@arm.com,
 guohanjun@huawei.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
> The pasid-num-bits property shouldn't need a dedicated fwspec field,
> it's a job for device properties. Add properties for IORT, and access
> the number of PASID bits using device_property_read_u32().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  include/linux/iommu.h                       |  2 --
>  drivers/acpi/arm64/iort.c                   | 13 +++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
>  drivers/iommu/of_iommu.c                    |  5 -----
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bdf3f34a4457..b7ea11fc1a93 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -571,7 +571,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>   * @ops: ops for this device's IOMMU
>   * @iommu_fwnode: firmware handle for this device's IOMMU
>   * @flags: IOMMU_FWSPEC_* flags
> - * @num_pasid_bits: number of PASID bits supported by this device
>   * @num_ids: number of associated device IDs
>   * @ids: IDs which this device may present to the IOMMU
>   */
> @@ -579,7 +578,6 @@ struct iommu_fwspec {
>  	const struct iommu_ops	*ops;
>  	struct fwnode_handle	*iommu_fwnode;
>  	u32			flags;
> -	u32			num_pasid_bits;
>  	unsigned int		num_ids;
>  	u32			ids[];
>  };
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index d4eac6d7e9fb..c9a8bbb74b09 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -968,15 +968,16 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  static void iort_named_component_init(struct device *dev,
>  				      struct acpi_iort_node *node)
>  {
> +	struct property_entry props[2] = {};
>  	struct acpi_iort_named_component *nc;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	if (!fwspec)
> -		return;
>  
>  	nc = (struct acpi_iort_named_component *)node->node_data;
> -	fwspec->num_pasid_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
> -					   nc->node_flags);
> +	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
> +				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
> +						nc->node_flags));
> +
> +	if (device_add_properties(dev, props))
> +		dev_warn(dev, "Could not add device properties\n");
>  }
>  
>  static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index baebaac34a83..88dd9feb32f4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2392,7 +2392,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		}
>  	}
>  
> -	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
> +	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
> +	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
>  
>  	/*
>  	 * Note that PASID must be enabled before, and disabled after ATS:
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e505b9130a1c..a9d2df001149 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -210,11 +210,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					     of_pci_iommu_init, &info);
>  	} else {
>  		err = of_iommu_configure_device(master_np, dev, id);
> -
> -		fwspec = dev_iommu_fwspec_get(dev);
> -		if (!err && fwspec)
> -			of_property_read_u32(master_np, "pasid-num-bits",
> -					     &fwspec->num_pasid_bits);
>  	}
>  
>  	/*
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
