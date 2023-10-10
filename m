Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2D2135A
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2CxLWKG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-406619b53caso52544795e9.1
        for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945004; x=1697549804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmUolm1QSdNeTrqOVAQPrq9kGFBVTiJa2lpVnk3jmBI=;
        b=T2CxLWKGHH+CG5ogk7nYtyZ6ywm5rOpoAvsWSorBeNmhsgRaihYATLuHxLFmyWEjX0
         tLozvoYBfVLZa5tbEYCWV/tOrlOgWwNakqeL1AkCzT3mGTIEorbVorPNAOfX0T0KB3bi
         tiN4MsIBrb1Wqf9YS5eFzHqHXYv0wjy0aFeW2QmVonp7Zq/o+U6NSjMXrs+wAeEPsXsL
         s3Gfwy8p6EJ6BnhguICZv/4w6n6wkMACelhSWFZNPb0VViRpc1sDocIIfPEBsg3B9P/A
         uI8MGO1JN+eJJYPxQbBk0YlzKajE+nbaM/f7G8qT7/IAah4vJ8lfeD9v8/6Dc7+SUUI/
         xBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945004; x=1697549804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmUolm1QSdNeTrqOVAQPrq9kGFBVTiJa2lpVnk3jmBI=;
        b=omfT7kqkFSK6ihuBtnQCafQIEzsUSHKSdX75OrxOMnC49HltsM98mvGulRHsl9IHzG
         N9QkwS5F9av767QRrqBTmfqZKAt1nVFwH1VuE8ul2CCKvxtb530OleweRxGezPldvXyK
         oVOkZSsqE9A6tLYW4vVqofArJnwioK9jccJjt/WumKudXVk9xEQcR2oUutaEmBeBgoRM
         cgYs5rsMlyqoEYquphRkKEyGLmv/1mb9zrlj0ZrIRqXvHbR24xLbcZ60XG/JrLy/njA0
         lmYHV0bfhx72tZIr/ZdFTnliUVhEpuk9g+thQ+aMynm9b4FjXCvPa0mt4KWYkEWuAPtw
         5dWg==
X-Gm-Message-State: AOJu0YyDZc8EiwdhgqXt3m5MlMdZPoy/7zFMLAcgWD4tJfzTRnqBk/G/
	4fXTIY7J075IdRSARqWO4knihg==
X-Google-Smtp-Source: AGHT+IHXwKtrRxLqgdq4AfzMyWp6S9vbUS+FM9ayQpgPUAK4Eah+7xzWBZhlrzBTdjuZoJ3DKx6Icw==
X-Received: by 2002:a05:600c:224a:b0:3fe:dcd0:2e32 with SMTP id a10-20020a05600c224a00b003fedcd02e32mr15632141wmm.19.1696945003617;
        Tue, 10 Oct 2023 06:36:43 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm16493195wmk.1.2023.10.10.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:36:43 -0700 (PDT)
Date: Tue, 10 Oct 2023 14:36:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <20231010133649.GA2902909@myrica>
References: <ZSRFW0yDlDo8+at3@work>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..379ebe03efb6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -85,7 +85,7 @@ struct viommu_request {
>  	void				*writeback;
>  	unsigned int			write_offset;
>  	unsigned int			len;
> -	char				buf[];
> +	char				buf[] __counted_by(len);
>  };
>  
>  #define VIOMMU_FAULT_RESV_MASK		0xffffff00
> @@ -230,7 +230,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
>  	if (write_offset <= 0)
>  		return -EINVAL;
>  
> -	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
> +	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
>  	if (!req)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
