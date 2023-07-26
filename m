Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EA1AA61
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 16:47:26 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-767ca28fb32so55092685a.1
        for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690390045; x=1690994845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfFN/WGXuOHIMKBQ3+3OOtROPffGpXKcKNRwslb388k=;
        b=FWR/tOM3m8ymV8DyTbRQ7eaEteObGOXJAPT5Sl795DdhehLIKCq+DwQNfTY1bwKb1I
         QwalD+ky+3BWrZTJepOuWUtQq4cgkJ8YIEFtajLqME0F+H7OPH9Zpu5jGCU6ZiouQxiS
         LnuKXwu5WOZQexR9EZapP/DiZhXLMd3/6xQiD8nm4Ych6hAwfJ16vQgBh3u0ei7m7ViL
         3Ilp+LunL0UEYkEHenUMbekAHSPXYMfwfsKhbq7bSaea1j4LxQCSfl557omMm5FrC+EN
         9yra4kdk0uB0mOiiZKRTrWGC9rhhgTFFZsHaHp4VdFButWHBHmn9SkOjnhCbcExGwmeO
         UxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690390045; x=1690994845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfFN/WGXuOHIMKBQ3+3OOtROPffGpXKcKNRwslb388k=;
        b=AQKDvI6Q3mUSO0aWc/ZHptWW+Y5Tg827cJmmS2JjMr4y5ApuovAzLq+t+IoPQs8mB+
         mNIgCdbB+0zD+TbRXFkBnx7UcXqB5yt/MygJPqSO3FpteDPihN8eLtk2ZyJIsRi7TCsE
         8CTlCkbPjHECrcbhGeCB5fyo6/8NwMk4M9Srxno1YaZEMmtI8XqSLjJtSdVFo9x/EY0E
         l0yZpcwFokl+Jm8Te2J7KNzRpHSr1rDkpYz746x0kSK2IdrLRwjM6qxXuET5sDeZFfXW
         3sgjHb/TWdRUG5OqFMDhty9XLYxbUJhucjgXyIR8KcP5zhhDIZ42kIykSWXYzVGt5huW
         y2oA==
X-Gm-Message-State: ABy/qLa7Eddsr4JZ94hsJTcZJITmbsQvAs3PBJkmIQvlUJA1Km7sClW6
	Vep1nH/1RhlnEoJqs4xmbdUFSjrhl3JL5rxsVhc=
X-Google-Smtp-Source: APBJJlGUShzpp1LWO5iF2JuogyMmVSyKgl0zlK33Sq+zhGW5xLnq50903JB9/vUQpFc2UTbWYAKfCw==
X-Received: by 2002:a05:620a:4052:b0:765:a955:74a7 with SMTP id i18-20020a05620a405200b00765a95574a7mr59211qko.24.1690390045496;
        Wed, 26 Jul 2023 09:47:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id ow4-20020a05620a820400b007682af2c8aasm4489742qkn.126.2023.07.26.09.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:47:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qOhfY-0018T0-Eo;
	Wed, 26 Jul 2023 13:47:24 -0300
Date: Wed, 26 Jul 2023 13:47:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: laurentiu.tudor@nxp.com
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu: map reserved memory as cacheable if device is
 coherent
Message-ID: <ZMFOHM/SihB3Pe+b@ziepe.ca>
References: <20230726125059.19123-1-laurentiu.tudor@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726125059.19123-1-laurentiu.tudor@nxp.com>

On Wed, Jul 26, 2023 at 03:50:59PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Check if the device is marked as DMA coherent in the DT and if so,
> map its reserved memory as cacheable in the IOMMU.
> This fixes the recently added IOMMU reserved memory support which
> uses IOMMU_RESV_DIRECT without properly building the PROT for the
> mapping.
> 
> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/iommu/of_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
