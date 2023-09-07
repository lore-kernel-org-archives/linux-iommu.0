Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E612B8D
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 16:39:00 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-573ac2fa37aso679116eaf.3
        for <iommu@lists.linux.dev>; Thu, 07 Sep 2023 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694104739; x=1694709539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAiBvTcyRsOXkihjAXwijX2b79d/6jZ/7uZYgdQjwfg=;
        b=LTQIEA5RWNM/5pbawYX32iv7g12qNYK+1j7Kol6ksa822I17kSBDzWXxmh33WGTwab
         HvBGlzLFv7xblYGfmBTMsENIEmlivoZFiwfTU5bPYGHeBWYiOwEKqq4NG+CKCSz/+Hmo
         TpnC4qaet4D/KyoiuC7o7XyDgspglXU+6avYJCdevGh8yOn9n7Nm8NS+uLje5TKi56v0
         31Yx1CAGWHk3+dAlkl12bOf3LYqTBHW/Hgp24xCk16b0OXjo9DngXnGzIu2r4cpnscsn
         W+Ocj6+qn64E9KuYqSntYqJHBy2l1PWxWgE2K/GKK9DUbxEKEOEThrJl1uKhlprXLaIl
         9uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694104739; x=1694709539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAiBvTcyRsOXkihjAXwijX2b79d/6jZ/7uZYgdQjwfg=;
        b=Z79AQ4eNDNpTzoDenf3HLP8jLB+YpyezaumfZwfJP+b+QWGHGXG5IYADzU8JzgzBXj
         hKrpeGoTzyDbSdgsuyUzzx4qijt49KAYqiI1OPjamDcjanmoo09QZOFt8WffRZpgx0lF
         YsST5BqWi/nb01efonPwNuYOK5Ufhz1iDuQrWWPBD796PQYKMX63folwAEVGNF4spXQ3
         8rqeixZ+utGU9Rl2K5Bho0baZ5m7pq2L3p1VK0d1flPDA30yGn+h7j+Wr2jILQYS7cAn
         hQOKvWo8Zh+dGKcsMDV12YYmwLy9BYNFg3Xz/dveZhsG0F0nUit4PAjUisRq0D380v+F
         l9dQ==
X-Gm-Message-State: AOJu0YxDgWqNm6US+MF6g7WNd/alsH3x6wO4FSfOn31TV1cZul1zC14G
	Yw4YNtQRi0mnfQunmIeV4QkDYw==
X-Google-Smtp-Source: AGHT+IEuRWnwHgc+ZBKdtmJS94abNZCPgqRUkNRZbk5rlBgeJt8BMHp1bCJwoTQZQ3OLP1WMH8+BQg==
X-Received: by 2002:a05:6358:7e42:b0:135:69d5:1b13 with SMTP id p2-20020a0563587e4200b0013569d51b13mr21167rwm.0.1694104737828;
        Thu, 07 Sep 2023 09:38:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cdd0c000000b0064f5d312babsm6510838qvk.46.2023.09.07.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:38:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qeI1w-0017Sj-R3;
	Thu, 07 Sep 2023 13:38:56 -0300
Date: Thu, 7 Sep 2023 13:38:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bo Liu <liubo03@inspur.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: Use helper function IS_ERR_OR_NULL()
Message-ID: <ZPn8oKc2s0HeBw1A@ziepe.ca>
References: <20230907071409.3805-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071409.3805-1-liubo03@inspur.com>

On Thu, Sep 07, 2023 at 03:14:09AM -0400, Bo Liu wrote:
> Use IS_ERR_OR_NULL() to detect an error pointer or a null pointer
> open-coding to simplify the code.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please no, IS_ERR_OR_NULL is an abomination.

There are only two callers:

	for (i = 0; i < omap_domain->num_iommus; i++, iommu--, arch_data--) {
		oiommu = iommu->iommu_dev;
		iopgtable_clear_entry_all(oiommu);

		omap_iommu_detach(oiommu);

Obviously oiommu is not NULL or ERR since we derefed it

The second:

attach_fail:
	while (i--) {
		iommu--;
		arch_data--;
		oiommu = iommu->iommu_dev;
		omap_iommu_detach(oiommu);
		iommu->iommu_dev = NULL;
		oiommu->domain = NULL;

And here I don't see how iomm->iommu_dev can ever be NULL or
ERR_PTR. The i-- follows this:

	iommu = omap_domain->iommus;
	for (i = 0; i < omap_domain->num_iommus; i++, iommu++, arch_data++) {
		/* configure and enable the omap iommu */
		oiommu = arch_data->iommu_dev;
		ret = omap_iommu_attach(oiommu, iommu->pgtable);
		if (ret) {
			dev_err(dev, "can't get omap iommu: %d\n", ret);
			goto attach_fail;
		}

		oiommu->domain = domain;
		iommu->iommu_dev = oiommu;

And again we have always deref'd iommu->iommu_dev.

It is just wrong defensive coding, remove it.

Jason
