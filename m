Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1153B8
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 17:34:46 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id t22so13105514pjy.1
        for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=284A91xJpS6nwRvx67VF7YSoP83e6JuEnTUJYB3raPg=;
        b=bYb4QUNP3jcTW6w5gDojVQgeXieFUswJifAM9vhjd5FVyK6aT/pZ1TVAJ5dVh0bdGC
         aXbTIhrFz+1A2lDCIfmBaGWPy8SxJvhCvjNoezyYG4Mxudr+RR03FBD6SfcLo2zT+jxd
         bOzysazjUG8D7hoyV8Wfb3h+0ZUi+pi/+pb3NqUns1qH2tYAbaoUi/xMg2KnOaV6HIwl
         wF7ggN2pke5cdFaWc1/ty05TbtcDMG4kSYFLdAWr9uCNaZNKf3y65ww6hZPkZvMVi5Rx
         2cuBoB1OrziAclyREuyqHWWBhEsrhutWB0p7R6xLN54BMQf6fnHp5yV3xuzvmyCEhqwh
         0GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=284A91xJpS6nwRvx67VF7YSoP83e6JuEnTUJYB3raPg=;
        b=S+QVgmmZ0MSGQZVwmRN2U/gZJQPDgPP5l3tozcvq9wQbWrsgHcqPiHX9h2EQHan+aj
         IUx0isDDZnkVUBOyZWEuciK+d4SRT4FmyNNlrzznJg28PoysovLm8ZrBx33+rAti8i3/
         JXSJctdOg4WEsxSTuM4UgDBd3AQelk33PZAvmD1iGgmT8TawWTmQJ6LqDMdNM2PgHQVC
         7sIFbvpTfIL3oLag4gbni/zHAC3l+6vX5erc3XziCoRp6q07MmkAqy988gp7n0oeLK0z
         uQ4l0BTXFjG5iFFPaC/1AdPi1BFKSVglcdBvGQTzh+ryEqbBQOXXZ+zXQ8EdWSQAXfaW
         6pxw==
X-Gm-Message-State: ACgBeo3G56r2rqQPYD90h2ua65DlS6pj4gKgdYmzTxbsZr+ilKvOCs96
	bPtnpNw6ZOmNd5/d5afp7Ag=
X-Google-Smtp-Source: AA6agR77E6Bi90PS6CwHLsHj14t+4aZgUalGnRDUpaOb2EZ4IhtQuUC4Pu11YPiVtnY2Q5XTCJifMg==
X-Received: by 2002:a17:90a:5517:b0:1f8:a7ce:ac33 with SMTP id b23-20020a17090a551700b001f8a7ceac33mr4870074pji.83.1660757686216;
        Wed, 17 Aug 2022 10:34:46 -0700 (PDT)
Received: from biggie ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id i190-20020a6254c7000000b0052d4f2e2f6asm10696208pfb.119.2022.08.17.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:34:45 -0700 (PDT)
Date: Wed, 17 Aug 2022 23:04:39 +0530
From: Gautam Menghani <gautammenghani201@gmail.com>
To: chenxiang66@hisilicon.com, shuah@kernel.org, liaoyu15@huawei.com
Cc: song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/dma: Add a .gitignore file containing name of
 executable
Message-ID: <Yv0mr+vGANGYcxio@biggie>
References: <20220724145931.32556-1-gautammenghani201@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724145931.32556-1-gautammenghani201@gmail.com>

On Sun, Jul 24, 2022 at 08:29:31PM +0530, Gautam Menghani wrote:
> The dma tests in kselftests are missing a .gitignore file, which leads
> to the dma_map_benchmark executable file showing up in "git status".
> This patch adds a .gitignore file containing the executable name.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/dma/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/dma/.gitignore
> 
> diff --git a/tools/testing/selftests/dma/.gitignore b/tools/testing/selftests/dma/.gitignore
> new file mode 100644
> index 000000000000..668e2f8be2f7
> --- /dev/null
> +++ b/tools/testing/selftests/dma/.gitignore
> @@ -0,0 +1 @@
> +dma_map_benchmark
> -- 
> 2.34.1
> 
Hi,

Please review the above patch and let me know if any changes are required.

Thanks,
Gautam
