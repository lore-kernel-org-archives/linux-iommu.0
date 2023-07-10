Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A0C8D0
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 09:34:26 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso47385055e9.2
        for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688981665; x=1691573665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIkNJXrfeAXdU6LyOguKwi2Z7Ylg4KQ+PIrj1Vet5Bo=;
        b=H3ctb6FEJbcH3zCNxTLZj1KJckXm68BTXHywjITt6N1wHwTBE8YWA1jawWv/shu6S+
         NT9PuJTCLHSZ4+vWYdacAZi8xWpKhSNR8nxOlO+M2pf2ndY3OfkVMglR65alBcDFssaO
         BEphrGjmuuhmHMpbP7I0ke1YXQZ8GXHGaGUbbLyiyq4JwAjp64FWvYlsYzBAt5/85FO2
         eeYh0ME0af5rcPK4EYeLLIurICOtTgmFHS/I7PlZXjSTsjf+nC4OCIlW6b+YMkppuWAZ
         gBxa7E/hHhC+3QCBrJdM1z26wCirTkBIL15YTp5yX2ICtrjgCIXCLGEKgbtbThZ2uxp5
         lgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981665; x=1691573665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIkNJXrfeAXdU6LyOguKwi2Z7Ylg4KQ+PIrj1Vet5Bo=;
        b=IaqUZKOgoPQAdJTXG4j9tubULXHEtkxxVZAh2rXzCGDE9jQmcjg/qywF13a6ZjrW7M
         k47dGg9CEFKrocj8buIiOztb3vRVL7wnQHsPTdQcSpCMNW8+B7XvvvIZkamqnfKcn3Wn
         vsqkmvBGRoYJr20DVoWmoZ3eaWbJftQS+zqIXBfPdA19NXNF2IpzDSi9z+gYU+nSnCMz
         j9+p62mcf/z1ROIg3v+kuE9fKE9M6mq8pWjfBDMsXozdvSqiWZUCL4CSw64JX/Nburgd
         KzcQZriq/MUci7F0aa00zw68aS2cyUrbIwSslqBIel0MhfYTvp1S3JcRu9dgqK3qZB+L
         +Icw==
X-Gm-Message-State: ABy/qLbcKFlnui+/UaGKfiubgJKFdWFqjDR+vuluGc0L85hofU7VCw4m
	T+4B8NhKt/icp8FcfaWgtADToQ==
X-Google-Smtp-Source: APBJJlHfQ+vP9gLJf9Y0ooi1WF/rziyDZkixdQqDwNlNcdLXuvSUKme2SFNVFWekSyhEZEVhq2Wjhw==
X-Received: by 2002:a1c:e902:0:b0:3fb:1b78:38d2 with SMTP id q2-20020a1ce902000000b003fb1b7838d2mr12750353wmc.4.1688981665022;
        Mon, 10 Jul 2023 02:34:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc354000000b003fbb8c7c799sm9840084wmj.30.2023.07.10.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:34:22 -0700 (PDT)
Date: Mon, 10 Jul 2023 12:34:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Will Deacon <will@kernel.org>, joro@8bytes.org
Cc: Dan Carpenter <error27@gmail.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org,
	joro@8bytes.org
Subject: Re: [PATCH] iommu/sva: fix signedness bug in iommu_sva_alloc_pasid()
Message-ID: <5574a5bc-e108-4206-b189-03ec79bc08ec@kadam.mountain>
References: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>
 <5e474464-34ee-414a-8eb3-b11e74540b14@kadam.mountain>
 <20230710092713.GA32673@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710092713.GA32673@willie-the-truck>

On Mon, Jul 10, 2023 at 10:27:14AM +0100, Will Deacon wrote:
> On Fri, Jul 07, 2023 at 10:17:23AM +0300, Dan Carpenter wrote:
> > Ping!
> 
> Ah, Joerg isn't on CC. Fixing that now...
> 

Sorry!  I use a script to send patches and for a while if the patch had
a Fixes tag then my script would remove the top name listed from
get_maintainer.pl.  Doh!

I should probably resend this?

regards,
dan carpenter

