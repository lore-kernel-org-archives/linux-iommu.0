Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4A2561
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662390394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgfFwixXVehi1PSvEZVFU5vKRx86AcuJqWkFha0PYcg=;
	b=cUKvoBJJeg7V1n0gG9rW1NJH2hLtEPk49owP+MqgE32De/2cdMN0t/Ifp3ctfWxNyGCxUo
	9k/0qEfERPPfSfS8GUJYBRlncIxMhJ2wAi8Xmp9M0hoja1e645jw802art++Ym97Ws/D9N
	X7kqzNSn1L00h3Cct4i2XEWjzJlXGKM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-X3sAaScSOGSpsf8QhrLtDQ-1; Mon, 05 Sep 2022 11:06:33 -0400
X-MC-Unique: X3sAaScSOGSpsf8QhrLtDQ-1
Received: by mail-qv1-f72.google.com with SMTP id q5-20020a056214194500b004a03466c568so3081908qvk.19
        for <iommu@lists.linux.dev>; Mon, 05 Sep 2022 08:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dgfFwixXVehi1PSvEZVFU5vKRx86AcuJqWkFha0PYcg=;
        b=FWxCzAQokF7RnDTWqmSisi2nAxM9OrxHoJy8bXkfNJRpHmYsCRcUrVm1BfBq2mOwGu
         mcMES0raryjzpJMdw8HCXi46AGexecbSkvvPqJaXvICmln7/xswhpDlVupaCt3PIt0kl
         8+jitpUzKsYCRJK4LHC0luNF1Z2Q1nBs9dFQIyzIWDl9M7T+Hn/bUfZ/OLzmuEiEQLzL
         +pEtsl+FeTOozkaVBZ0a2bgxnRijyM/mnZtetiEDyi8FNDYY0khb0qmSJlxOB/0gL6/Z
         3my4nkWDMMXC3V6gqhtwktqLLMdjWhW3lUM3tsh3EabB5iOhZCPB1LOgrHUt99fZgFfN
         7Lvw==
X-Gm-Message-State: ACgBeo3j6NrcH2fHHn4hRlu88PHmTikyuICEm/LTc/f91vFXsFNUTXUz
	5jC8Cdt3DqcM2OkPF0iVB3AfU0wOhi/G0G7JvwzNiooYG0Iv1ZD/2vnoItnPqcU+zMCdLIlk51h
	GJ9gkPtOjYkmqRTA=
X-Received: by 2002:a37:a02:0:b0:6bb:17af:a8e6 with SMTP id 2-20020a370a02000000b006bb17afa8e6mr32109758qkk.80.1662390393318;
        Mon, 05 Sep 2022 08:06:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CQVvjjHeLNOC3yz5M2uqgjeZSamPDWorBe07HjcMAA8/ZIsc8Dps/cJhhfRyfe0dYQiU+8Q==
X-Received: by 2002:a37:a02:0:b0:6bb:17af:a8e6 with SMTP id 2-20020a370a02000000b006bb17afa8e6mr32109742qkk.80.1662390393051;
        Mon, 05 Sep 2022 08:06:33 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b5-20020ac812c5000000b00344883d3ef8sm7135554qtj.84.2022.09.05.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:06:32 -0700 (PDT)
Date: Mon, 5 Sep 2022 08:06:30 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH v2 2/2] iova: Remove magazine BUG_ON() checks
Message-ID: <20220905150630.boe7zy2nwcgb5jb6@cantor>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-3-git-send-email-john.garry@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1662369083-238529-3-git-send-email-john.garry@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 05, 2022 at 05:11:23PM +0800, John Garry wrote:
> Two of the magazine helpers have BUG_ON() checks, as follows:
> - iova_magazine_pop() - here we ensure that the mag is not empty. However we
>   already ensure that in the only caller, __iova_rcache_get().
> - iova_magazine_push() - here we ensure that the mag is not full. However
>   we already ensure that in the only caller, __iova_rcache_insert().
> 
> As described, the two bug checks are pointless so drop them.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/iova.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 580fdf669922..8aece052ce72 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -694,8 +694,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  	int i;
>  	unsigned long pfn;
>  
> -	BUG_ON(iova_magazine_empty(mag));
> -
>  	/* Only fall back to the rbtree if we have no suitable pfns at all */
>  	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>  		if (i == 0)
> @@ -710,8 +708,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  
>  static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>  {
> -	BUG_ON(iova_magazine_full(mag));
> -
>  	mag->pfns[mag->size++] = pfn;
>  }
>  
> -- 
> 2.35.3
> 

