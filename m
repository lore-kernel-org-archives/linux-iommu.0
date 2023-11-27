Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77B3BB29
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1efabc436e4so3212551fac.1
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 13:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121274; x=1701726074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI2M+j6ioFcb4GQHCuGwFJdfm9icuD7b8LXD5YDuNJg=;
        b=umQoFb5lTA+Zd98O3iCg1eQ5PLfphVzdWXWzKLdcF6NMD45NrR7jtc/RYGY+FDuskw
         fv+NFUF1nbgwpFUChZnugSyQatFv91HBxGxJxijtBcPYRS6TroMRfGle7urXByGKOC4/
         VhOrHmjolkLQflNRU8QkVZi/J6RPJafV+6dx1wYo8gLA0OPVwR5zdjjKqURzFFCDvB36
         gVnF6kmEcAdINNxLZXly+mHvIeQ3hZ0CpxYu1DBt3mQcQg+YLRB/vyqjY2QbeSISU+0B
         QlOetOiijCuH6a+XKPVoXm6w2bfHkHzJ1M3poUkMTOL36z7fVUkuAD5da5yH+HApimPw
         VbSg==
X-Gm-Message-State: AOJu0YzJSDF411vQqbVEixbEkPtY9+2XA6t24JMo0WrHwy1t+AKQTSBe
	VkJRIvaUkibNE8Pr5Yl90A==
X-Google-Smtp-Source: AGHT+IGFvSz34MKUy/WxsVB8cBQNpehhrzjKecPe0agYQUZpudaSX6ZWR8xRNmcDqWBXrxt6W+KwRA==
X-Received: by 2002:a05:6870:e0cb:b0:1f9:385a:f6ef with SMTP id a11-20020a056870e0cb00b001f9385af6efmr14434582oab.19.1701121274068;
        Mon, 27 Nov 2023 13:41:14 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mm23-20020a056871729700b001eaf486140asm2190758oac.28.2023.11.27.13.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:41:13 -0800 (PST)
Received: (nullmailer pid 3795972 invoked by uid 1000);
	Mon, 27 Nov 2023 21:41:12 -0000
Date: Mon, 27 Nov 2023 15:41:12 -0600
From: Rob Herring <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, frowand.list@gmail.com, james.quinlan@broadcom.com, m.szyprowski@samsung.com, hch@lst.de, devicetree@vger.kernel.org, lenb@kernel.org, robh+dt@kernel.org, rafael@kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Don't store redundant offsets
Message-ID: <170112126999.3795360.2028083328309296729.robh@kernel.org>
References: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>


On Fri, 24 Nov 2023 18:10:03 +0000, Robin Murphy wrote:
> A bus_dma_region necessarily stores both CPU and DMA base addresses for
> a range, so there's no need to also store the difference between them.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/scan.c        |  1 -
>  drivers/of/address.c       |  1 -
>  include/linux/dma-direct.h | 19 ++++++++++++-------
>  kernel/dma/direct.c        |  1 -
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

