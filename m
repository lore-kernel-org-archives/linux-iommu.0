Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DF8BFD
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 16:33:36 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-403a7066d9bso27327111cf.3
        for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690216415; x=1690821215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnRivkG6WM9TRuOMq/cdTmoCpoYS5ZS9UTbUmBQcd1w=;
        b=ggbNxtV8851KGsYP7yv6kkqRILR+/iL0QTDfN1q8EEerW7VSn6NBV5uTn/G3s7s6z2
         aoc0LBPy26Sf5gKv8cSzRGhTDJODzUflKajXlfpFesJcSmNIa5zD0RRoPgNwnS//D2vJ
         YCzgfBA2z7Sv99Vn/T6M0U0RbBMQV69PTObaLSZ7B+U6efWJLtNQNEFiH3x4ByvfmDIo
         2rYXcMVH/kDtoqEBw6bn4+YzhMzDYFIN2sWsMWjnx1oKxVjiDo2K+6N+bvZ6mF3su4XJ
         c4ja2kB8lwJLSJGc/EJFmJwbsYmd+qwrCioga/TStu7Uxmk4TzraCvpaV9+A9fj9sdsw
         HcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216415; x=1690821215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnRivkG6WM9TRuOMq/cdTmoCpoYS5ZS9UTbUmBQcd1w=;
        b=UpJOGYoI0QI6h/DycQnmT+TXBMgZebQ1TcXQ4KIIbCfU1ZBzzXCEX5U52c+BokP9UL
         WSge9yK9IxIwTjB9Dbo1iQDep8ky2mJFySvYr1+kN9ZFL7JW3AwuK1EUPOnrW6S+3Sc4
         vBK7LIVBlzAfdZt+fNGzRhm5fydzelgJVCfmBuTQIq4sLHYoiGP5bQaU9pmBw3EhQTvB
         80AL7QeN+6Y7uA3rdIAxs0bAYYgQadzrU9EvN5irAiwuyoPJnQ1HD3Ck1JDMhi8WWjsc
         PINC5S2mg9hXb63ctv5r4Lc3IapkQj3CENUSBlYSDRNXHv++3JAS05mhQDhlfQKGJdUW
         MYAg==
X-Gm-Message-State: ABy/qLY7NcUhzppF7PgjasESYo4BKpc2KfVVgOIlGS8XXybyooInkT+r
	Eij5UWYzvDfusi0eotbqbAhN+g==
X-Google-Smtp-Source: APBJJlFQ4LC4JzpGfviU5rQcz0YnPw5yrkA7UPIbmPCdE3MJ+4yOE8vtrkJazMOsR8QKVwaCNT3WZA==
X-Received: by 2002:a05:622a:182:b0:400:938b:eb0e with SMTP id s2-20020a05622a018200b00400938beb0emr277982qtw.43.1690216415053;
        Mon, 24 Jul 2023 09:33:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w9-20020ac87189000000b00403eab8b7cesm3395763qto.16.2023.07.24.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:33:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qNyV3-000K4o-R3;
	Mon, 24 Jul 2023 13:33:33 -0300
Date: Mon, 24 Jul 2023 13:33:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tanmay Jagdale <tanmay@marvell.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, thunder.leizhen@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, gcherian@marvell.com,
	sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com
Subject: Re: [RESEND PATCH 0/4] Add support for SMMU ECMDQ
Message-ID: <ZL6n3f01yV7tc4yH@ziepe.ca>
References: <20230721063513.33431-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>

On Fri, Jul 21, 2023 at 02:35:09AM -0400, Tanmay Jagdale wrote:
> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU's ECMDQ feature.
> 
> I have tested these patches on Marvell SoC that has the ECMDQ
> feature.

Last time this came up Robin was interested in real world performance
gains

Do you have data to share that is motivating you to do this work?

Jason
