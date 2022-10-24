Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C3A59
	for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666643626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jS77JQI+Wqma8EkspvaV6jJPvhgOIi/g9VzirTrOEUM=;
	b=RMGDuEbkJU63NNlkHvdMovl4lcX1w6+fIy1zw8kHUE4SJhXQ3h6PZoK5nj3XTdzk1R4mIy
	MIrhTYYtYjptknuO9fIMwHRpucVmWsAs+QcivIpktgeMroewy3pozij4iCG86ESf4DejTH
	4tp/CkRQsug0K3LhVR/chsmjveYEc+c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-199-PvLRUoAWPDiWKB3QkH--lA-1; Mon, 24 Oct 2022 16:33:45 -0400
X-MC-Unique: PvLRUoAWPDiWKB3QkH--lA-1
Received: by mail-qt1-f199.google.com with SMTP id k12-20020ac8474c000000b0039cdd680ccaso7728367qtp.1
        for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 13:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS77JQI+Wqma8EkspvaV6jJPvhgOIi/g9VzirTrOEUM=;
        b=zLpU+L4OtSCrnAtjsZVOt1b3u86gC+/0xGBIlSFoeFwcjydBrgEzv2yTq/DeHc8ifU
         AtbLiKV+QK31+HZoqUgZn6kL7l38i5Lg8b6lQHobWgYpfMKeV4XTLhbN/AGB1uU/CfDK
         cEqyGd/ikBNb+DxOs326TJRhzA8GOVKVC8PpV57Y5jj8E6t9+rDpJNB7jI/hn+f/r3+q
         +UioCyPEhSGDUM1bfzbHmzMfpBtCoRGRU7AZFElIQCd06CQVQKJTsenGUbNP+99w6163
         O0cjXma+8QLx44BPk2LLAgHovSJy0X8di7lsgjIwC0WepVAyoWdbGhdO3Qr+fO2rSlqq
         HlQA==
X-Gm-Message-State: ACrzQf3x+IG07RFrZC1ED5FPnk9k19cJydZojQarqzt5Yq/YnrxbR2dI
	b3n7kM7cKmstl1G0XTzCrFnySgrhWW6VCmd/axZ6EeLiLHg0FLIPxZz6MkBMV2QhDhEYLI5hFpq
	bklJAImdvDLGHFag=
X-Received: by 2002:a05:620a:4155:b0:6ee:e6b5:efa7 with SMTP id k21-20020a05620a415500b006eee6b5efa7mr24649746qko.54.1666643624561;
        Mon, 24 Oct 2022 13:33:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fuJ7umxduSwho5wT/1DHDzI+eD1fRK9Z2IMS9esLQ5xAyDielh1+K8ovaXy8gI3DuPHXL2w==
X-Received: by 2002:a05:620a:4155:b0:6ee:e6b5:efa7 with SMTP id k21-20020a05620a415500b006eee6b5efa7mr24649730qko.54.1666643624349;
        Mon, 24 Oct 2022 13:33:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006eed75805a2sm616099qkp.126.2022.10.24.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:33:43 -0700 (PDT)
Date: Mon, 24 Oct 2022 13:33:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove variable cnt
Message-ID: <20221024203342.nbmqphmfbrqqtr4n@cantor>
References: <20221024134301.2158939-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221024134301.2158939-1-colin.i.king@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 24, 2022 at 02:43:01PM +0100, Colin Ian King wrote:
> Variable cnt is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d3b39d0416fa..3847f3bdc568 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -767,7 +767,7 @@ EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
>  
>  static void iommu_poll_ga_log(struct amd_iommu *iommu)
>  {
> -	u32 head, tail, cnt = 0;
> +	u32 head, tail;
>  
>  	if (iommu->ga_log == NULL)
>  		return;
> @@ -780,7 +780,6 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
>  		u64 log_entry;
>  
>  		raw = (u64 *)(iommu->ga_log + head);
> -		cnt++;
>  
>  		/* Avoid memcpy function-call overhead */
>  		log_entry = *raw;
> -- 
> 2.37.3
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

