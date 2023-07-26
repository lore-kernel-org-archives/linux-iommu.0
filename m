Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1BCA41
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 12:22:12 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-63d03d3cac6so15171576d6.2
        for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690374131; x=1690978931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boB9DdG0to4xM14rl0/ITWblwyF7Dr52n6iy7cSNi4Y=;
        b=F2oI4pPsa9uswZhq79CvyZeuYbVLzQDumI5bSVzGRCufqpTz/bNlg54uBS02H3qdBg
         4fgcqfcxKnqzrYDVBOES88o6fyoB5roGZ/RTr9/bcuhiBc/3i0Oq9qFpoXGtXmZYhyOQ
         4XVoIiXzAH+n1Jna2ViuSQldUWTqu7ltKz2neTiRsEzs6WMNe/Qq09tAiEz2BEyXs1Ff
         IYHPOvmRz5T7MKaJa6n6yiuFf5PGj3cNYHIj9fGQsp2tzX9FRCJiQDW9guPCJN811s97
         2UXCQi1crfBVDSTkgHXgcgfoZXaFwBQsm2L5ixVPhzUnalGxvVSl7Rf2bPQKW05DH3w4
         PCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374131; x=1690978931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boB9DdG0to4xM14rl0/ITWblwyF7Dr52n6iy7cSNi4Y=;
        b=PK1+40A+2ofaBXsVzcGJ2qDl5IVoieC7Kr04+pb35DVCXNicc06euoSMkDITVeo0An
         PxaDTotDiZapejhwKoWtEqeK3Fnw7OoDReYzdk/gvYzEDGVn+UbvAlrQ9OymK3rEY8Th
         hndNYdxCl0Qf3i3GeWqZXK5Bnw2VjqSmamAyWxnYf3ZKhRpG+ONGmz28doBRBVy4+DFE
         uq9rBR7UMMHLG6WTtg1p0/RYCP7BRf6LwkZTrl6wp0UygPV8KGzaWvl1lrR2PuxzHVQt
         +91kEw6ZEA+BrMqf85C1XqCkaJ69R/Vxwi254bUWUMXO7TxXLooj9xDSYhIpSoZ7gRyq
         UKPw==
X-Gm-Message-State: ABy/qLbKO7uwC6iU7LV/JqqMtM2puihOHn98cuJsqoFfQET63Cu4Ll7d
	JP8KNFXbZHCanQ/ExS1G239H/A==
X-Google-Smtp-Source: APBJJlH9kryacJY9JKJ4Xhiaig+lHfX8BXbkC7RTwpYaR04omH7jyrNEI7Ntdb/vQEN/BCMxnbZIEw==
X-Received: by 2002:a05:6214:3d9e:b0:63d:334:259b with SMTP id om30-20020a0562143d9e00b0063d0334259bmr1691576qvb.43.1690374131199;
        Wed, 26 Jul 2023 05:22:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c5-20020a0cf2c5000000b0063d252a141dsm692554qvm.116.2023.07.26.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:22:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qOdWs-000v1b-73;
	Wed, 26 Jul 2023 09:22:10 -0300
Date: Wed, 26 Jul 2023 09:22:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: laurentiu.tudor@nxp.com
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] iommu: map reserved memory as cacheable if device is
 coherent
Message-ID: <ZMEP8pqztmPw3UmP@ziepe.ca>
References: <20230725140055.12823-1-laurentiu.tudor@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725140055.12823-1-laurentiu.tudor@nxp.com>

On Tue, Jul 25, 2023 at 05:00:55PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Check if the device is marked as DMA coherent in the DT and if so,
> map its reserved memory as cacheable in the IOMMU.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/iommu/of_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

This only makes sense for IOMMU_RESV_DIRECT - is that your use case?
Maybe mention that in the commit message

And add a fixes for the commit that introduces IOMMU_RESV_DIRECT into
of_iommu.c

Jason
