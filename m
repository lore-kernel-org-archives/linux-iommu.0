Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5E18493
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678466724;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DONNmf6vOmkYEFrdfCWo11P6Yw5uwRfOe9L4sdnr3V8=;
	b=jMPRl6ffAAfk9/xOGCOCGR++obCCqQpRMBuvPkL/doJ04z4e1J7tceqO938rPcZ69QHzdf
	00+Z4we3CbYTbrUFfYlCN4+psvp1IEIvzXjWwHOEwkkTlRzCRSm8Ku6sj9+/7v3mZqiOMv
	rqAitPiOCZ1vJpkK8CvEw/tO28nDKX8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-tMEF0EN5OKqu-uAilt3Xng-1; Fri, 10 Mar 2023 11:45:23 -0500
X-MC-Unique: tMEF0EN5OKqu-uAilt3Xng-1
Received: by mail-wr1-f70.google.com with SMTP id by11-20020a056000098b00b002ce45687cbdso1190796wrb.12
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 08:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DONNmf6vOmkYEFrdfCWo11P6Yw5uwRfOe9L4sdnr3V8=;
        b=OI+t/uf3TgdzSLZwZaWas5JD9ET7WgtjSGETppFNHTid3yrv0YzyCtlinT8ka6id3K
         kjlK1WTR1Ms4YMoeB4rE+TWDURKwp2mkY2PHC/Sm6HD/UwL/ZK59bBtFypo16OY5pZ2S
         jouGCjbN1BxAqjMxmnjBK6BVjy5U/W5NIgqKE5rJqTjaps029RmSF3mZGg28IwDu3i1z
         UT+3Z60cik6yQZ5wxON+DBVOcAsdNmmhD05eUAfBKcBnkKBduBoEwAWIHo2LpCSGEFHm
         gvhV+agz1qdOQYXtk4BfGT5P4/fSB8kqpRrUZtnzWWfG5K5dQsJllxNiTxBz4YYG+eqM
         08NQ==
X-Gm-Message-State: AO0yUKUNaYX7ISfhhjhCn4OOcpGCXqS9iVNfe2frzAZqt9yI4j2aoGq/
	fiOwSudX9guCRl2viffZa6EzsD2vhdOxO0Yod06kwcfpHK6/yRWZl7OIPcCQ9yr6epcUx8zriht
	EdDXCHweR6bU2ZkU=
X-Received: by 2002:a05:600c:3b99:b0:3df:3bd6:63e5 with SMTP id n25-20020a05600c3b9900b003df3bd663e5mr3426154wms.12.1678466722204;
        Fri, 10 Mar 2023 08:45:22 -0800 (PST)
X-Google-Smtp-Source: AK7set9FIdPMomT7dQ1Y0QyyKi/hyyRKXt9VLZujnjqNDzfp44IEdmwTm9WM+arU/1hHrfIkGn8EWg==
X-Received: by 2002:a05:600c:3b99:b0:3df:3bd6:63e5 with SMTP id n25-20020a05600c3b9900b003df3bd663e5mr3426144wms.12.1678466721945;
        Fri, 10 Mar 2023 08:45:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c475300b003eb2e33f327sm673943wmo.2.2023.03.10.08.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:45:21 -0800 (PST)
Message-ID: <919e32d5-26ef-7327-e25f-565967c94e6a@redhat.com>
Date: Fri, 10 Mar 2023 17:45:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 03/14] iommufd/device: Setup MSI on kernel-managed
 domains
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, robin.murphy@arm.com,
 will@kernel.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <5149b7e711a46e81aea8515676cf0e45608b3afd.1678348754.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5149b7e711a46e81aea8515676cf0e45608b3afd.1678348754.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> The IOMMU_RESV_SW_MSI is a kernel-managed domain thing. So, it should be
> only setup on a kernel-managed domain only. If the attaching domain is a
> user-managed domain, redirect the hwpt to hwpt->parent to do it correctly.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index f95b558f5e95..a3e7d2889164 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -350,7 +350,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>  	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
>  	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
>  	 * domain after request_irq(). If it is not done interrupts will not
> -	 * work on this domain.
> +	 * work on this domain. And the msi_cookie should be always set into the
s/And the/The/
> +	 * kernel-managed (parent) domain.
>  	 *
>  	 * FIXME: This is conceptually broken for iommufd since we want to allow
>  	 * userspace to change the domains, eg switch from an identity IOAS to a
> @@ -358,6 +359,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>  	 * matches what the IRQ layer actually expects in a newly created
>  	 * domain.
>  	 */
> +	if (hwpt->parent)
> +		hwpt = hwpt->parent;
I guess there is a garantee the parent hwpt is necessarily a
kernel-managed domain?
Is it that part of the spec that enforces it?
IOMMU_HWPT_ALLOC doc says:
" * A user-managed HWPT will be created from a given parent HWPT via
@pt_id, in
 * which the parent HWPT must be allocated previously via the same ioctl
from a
 * given IOAS.
"
Maybe precise that in the commit msg?

Thanks

Eric
>  	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
>  		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
>  		if (rc)

