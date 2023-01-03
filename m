Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32438AD21
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 23:13:00 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id u2so8773646qvo.12
        for <iommu@lists.linux.dev>; Tue, 03 Jan 2023 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz3yFtNFzzGkwABV122YXiYemg/f9Py/y3zMd9l0kjs=;
        b=K8BFjmCv4SP0O1UgUJEke3gZvrhshL0Th//Uv3fh3mghbZpd19cfYKoqfId3IMB1jT
         i2QfvVbIpgA6oZwFgqWizRXZ2bMkJ/bcYDrMXJ0GeU+qj8vOuMMvW+/l74inPalTpnom
         U/rvIfD2Txzbn7s1ZqZzIbNi/H4p6t3cTuL5aiDQll/5aV3Xys6v/nlt8lN3Z5Qi+eRJ
         vvAfe/zLtGNxRAp1/J9tXuNlOMI8HUuDltGio3CMy6SWqv23HoFisneDWiGqypNO6TEn
         p6Ij9lLf3OyIC/6fHbOhy6/m2B3QVaWK/1uo+4fH8R8wm2uTtGi/l1NU/SJhr1A8K5KU
         Kh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz3yFtNFzzGkwABV122YXiYemg/f9Py/y3zMd9l0kjs=;
        b=hD+n47jzHlSHOlLSlXFr8tS9YaKCAXo/5DuYnyx/klLWn3qzTMQzqXKZsU6p3vFXQM
         2GuYlGB211JHAguYTHG+Fl+W0AEn3Il3qh//cXqjo6otZ9Yxs3frs4KSIRBuXfI6VFkL
         d16STLpFSHNbsSXqeL/klVfAMMcDa9CL5wqW5t2qumYuJc/IGIVtkTatzSydm4Jlo4+h
         swIDDLhCLfqQ9BRfhaxF/sVkxLR09AxYK9/9ULoaHuUuped8DSN7fiLcdQAgF/to+S7J
         DYT4OCHaN3G1Nre3YAV0NlzVglQLuQgWew0p3D5uOK4UPV2xzuErkb24dpag5fZeh7lZ
         MVOw==
X-Gm-Message-State: AFqh2kqRwc5jhJtb0bu6LJQwQS7UEmfgFsqdUYxRG6bOGNP5cROBVg3s
	GqWoHIUzbMWEC6WnwJeXf7/vCQ==
X-Google-Smtp-Source: AMrXdXv/9OQoPmXf9qQIzU8Hfku2rK3T4lvHGb+hsDicfH3LE9m63GWJi2ZtfV+32khLMrvgjJF3pA==
X-Received: by 2002:a0c:ab54:0:b0:4c7:7a7e:8067 with SMTP id i20-20020a0cab54000000b004c77a7e8067mr26074197qvb.18.1672787579124;
        Tue, 03 Jan 2023 15:12:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05620a458d00b006fefa5f7fc9sm22747831qkb.134.2023.01.03.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:12:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pCqSo-001c73-3B;
	Tue, 03 Jan 2023 19:12:58 -0400
Date: Tue, 3 Jan 2023 19:12:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix refcount leak in iommu_device_claim_dma_owner
Message-ID: <Y7S2erhj3xWUR6xH@ziepe.ca>
References: <20230103063017.4022393-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103063017.4022393-1-linmq006@gmail.com>

On Tue, Jan 03, 2023 at 10:30:17AM +0400, Miaoqian Lin wrote:
> iommu_group_get() returns the group with the reference incremented.
> Also an empty @owner is a more serious problem than refcount leak.
> Move iommu_group_get() after owner check to fix the refcount leak.
> 
> Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Remove set NULL to group as suggested by Baolu Lu.
> - Update commit message according to Lu's explanation.
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Joerg, can you pick this for rc?

Thanks,
Jason
