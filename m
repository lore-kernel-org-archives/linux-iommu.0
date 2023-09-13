Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA03D6C
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 14:40:09 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-41368601e92so43179241cf.3
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694616008; x=1695220808; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QPP+TPZFJRPRV+Uxt6zI2nlZhVLYECkBOgOUQMGQmU=;
        b=mOk9etnk/Xld7XuqGUHgdqDAAM9xltrf+NVbNHFiWwnywr554q7jP8nzpFjpz83Uig
         PLb1/Pp/edNLT5U34nAW+Mh1vbNk7neFWqG87xlUORsI7/IoHITWw49K8lDLZ5abZGY8
         eNqD7O/nGsA8WRk08JzBQ8lJl/18H6lyvFA1+DjgNfrVbU2rGMBLDtGBg/4ihTLtY18a
         yk1Gelh3zWzciH0Hg0bVI1hfJSORX+P7jWVjSJezOnU+f8aK39U/kFMycGaxRyrB4qpV
         U3GnUStbGvmhI3n6Nzxeo+fTAxz9meASZEa4U8ReVZ7nl4L3qVcneZO1MhFVqdSBUvpj
         ZZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616008; x=1695220808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QPP+TPZFJRPRV+Uxt6zI2nlZhVLYECkBOgOUQMGQmU=;
        b=lpM8UBbUWP4I2wPh/ALwzRGKpmFSiqEOM+2WFQi5AY3CgUDuzn9qgs5Lolt7hbnz3B
         iHTJD5S0wrVSsuL+WLlACj8rDXLyx2GwOO7x/DSewwdB7Q6E/Npo4iyXJU1jS3HOGGTG
         VUsiPjxRoIxdpbiQg1lbtjq2kIqsLRpjPfvvYlSMbBQdAHJtZLiQ61to2a2yy7oPCukI
         5WxrKJoPswlZ0H9rWpqK3qkhoHdWYpuzLqRaer1SHcy+q4oAhMxpvfR0OboOIJP3rLVo
         zj8vELWzebEFFsKmHNo3JNnqK8FU8HsVWn6ouZGaLXKd2oD86zpOQk1AX5qPf3cYSJg3
         cELw==
X-Gm-Message-State: AOJu0YzODc24gV+XHmug1C5qXRPY243Apu6uz69G2myY6AXQUfAjPWOE
	Rk+2/ATP7Z4SBR5erACRAyl04Q==
X-Google-Smtp-Source: AGHT+IE5LjmqBrHGWk7sTKAQmgPyFal4xZnTDzkx7aB8rSny51UAk0B2xTYwNOybfTOFwuolegpGBg==
X-Received: by 2002:a0c:e287:0:b0:655:fc53:873a with SMTP id r7-20020a0ce287000000b00655fc53873amr2568010qvl.24.1694616008070;
        Wed, 13 Sep 2023 07:40:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id s1-20020a0cdc01000000b0064f3b0d0143sm4385549qvk.142.2023.09.13.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:40:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgR2F-003eeP-0z;
	Wed, 13 Sep 2023 11:40:07 -0300
Date: Wed, 13 Sep 2023 11:40:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 7/8] iommu: Retire map/unmap ops
Message-ID: <ZQHJx3FWRQrsNYsC@ziepe.ca>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <d2afdf13b2fbf537713c3ec642dfd49d16dd9e6a.1694525662.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2afdf13b2fbf537713c3ec642dfd49d16dd9e6a.1694525662.git.robin.murphy@arm.com>

On Tue, Sep 12, 2023 at 05:18:43PM +0100, Robin Murphy wrote:
> With everyone now implementing the new interfaces, clean up the last
> remnants of the old map/unmap ops and simplify the calling logic again.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 60 ++++++++++---------------------------------
>  include/linux/iommu.h |  6 -----
>  2 files changed, 13 insertions(+), 53 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
