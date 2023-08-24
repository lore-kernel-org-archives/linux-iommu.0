Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C757E
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692917172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYqrMRiBnf0y+vsLmmaXFnXsvi5+cfeyw9I9lzK5JuQ=;
	b=Y84n6sTt81GbkJoAtR/zhbrGJG7Uzv4D8AAAqoK6ddoeoLH+SEjjZOZzoQo+7oDnULgn4U
	+OAxqdiFDOhRmB+cr6hSoEI1yLC9b/7bhw/H2iX/TZ2pMtjgWY35x3PTVpXqLydZbd7wCO
	aKPFJXOdGdPPegrwb6jL9Yn43zt+YmU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-DEJdMA1-N5ixcwsH6AqUgg-1; Thu, 24 Aug 2023 18:46:10 -0400
X-MC-Unique: DEJdMA1-N5ixcwsH6AqUgg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-64a31d99a07so3977676d6.0
        for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 15:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917170; x=1693521970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYqrMRiBnf0y+vsLmmaXFnXsvi5+cfeyw9I9lzK5JuQ=;
        b=Uw1OtdrkqgBML40gbgkeIuUM06y/oSMYqRCBtKZOCJJNQSeOiUV4L/UusLkb6dJEeD
         p0/k756mRfaVMMRgGNYKJ37R3Bbr2ophXoxwZQ9/yzvhr9+cw1l4RrFvU955c3CzhufK
         YEAgCuvrr6Jm6T0btjqM8cZxkkMTPZHRXHbSNOTJiRDCOAvGPHvLj8WcGfYWDrOozcu8
         dhor2nFG3hfwRnWBZWCfmWmypBCcENV2KgdrJEcxrAvmveoEcCiHfNf3G2LxB552sX55
         XdFymDhXu/gcS1THSj2CjmagNEX56Qtu9OmQNJ6v6Gq4+ykYPHdbGQjlsLtsJo6qRM4j
         t4TA==
X-Gm-Message-State: AOJu0YzQLU1SW1WXe45VxBEVV7NMprJqo/5adEwc8i2VXROTMq/vb+3I
	eRU12b3eYQeTFY2oI8eeA9BXVyZrfjnisbRbndGE/dhbYwwJtkf0iTEjccmF4xenBGPlBaFUFA7
	p+PzW4mAvHX1AoHM=
X-Received: by 2002:a0c:dd84:0:b0:64f:5d57:b6ca with SMTP id v4-20020a0cdd84000000b0064f5d57b6camr5387522qvk.39.1692917170260;
        Thu, 24 Aug 2023 15:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz94pinZren0/iz0IwyYMmPfiw/OG1TZZd40PTYM93QG7xzHp2+9ii/YpaLTnjWcvirQZD7A==
X-Received: by 2002:a0c:dd84:0:b0:64f:5d57:b6ca with SMTP id v4-20020a0cdd84000000b0064f5d57b6camr5387515qvk.39.1692917170041;
        Thu, 24 Aug 2023 15:46:10 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cf24b000000b0064f732aa463sm110706qvl.105.2023.08.24.15.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:46:09 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:46:08 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 4/5] iommu/amd: Remove unused EXPORT_SYMBOLS
Message-ID: <qmwqe6en7ldpdojc3kaf4rmbsy64dnvhulrznvcojo2kunaqpu@3kdxkrrkwwhl>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
 <20230821104956.707235-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104956.707235-5-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:49:55AM +0000, Vasant Hegde wrote:
> Drop EXPORT_SYMBOLS for the functions that are not used by any modules.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c  | 1 -
>  drivers/iommu/amd/iommu.c | 6 ------
>  2 files changed, 7 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

