Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE37B
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 11:22:59 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 84C7D222640;
	Mon, 26 Sep 2022 13:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1664191371;
	bh=Ck79Cmnv8ccFuhP8TBiWNQx7/DVNTm3HOuAbULBOHQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gREbkvI5HLLWTP7F/rCv5h9wJT10qWmZocy50VKXbEpNT8eGHhspqVfj1M03SbS9Y
	 yWpTEeiRO+4VxumGih3YZkXAAf++FNNxiXwZDNwUGvFjGMhnsk5NM3k0YSd6AjNtUC
	 HfXNUFxhbYfyilup0t1oOW4j/6gStwgXlEQjFw1rl14kmS4YWQ9CVAZgLvEPoKs6m1
	 XCUKghR/uBs5fS3lzgS4NR8S+NlEc9JC+i+TEqBqdmJi1L5Se1X4DR8hH2/KHAXPy6
	 vY3J8Y5XsmT61Wv10ozEcR5LHVtgvU6oTcr5TOYuPy10dAatYZ2pO49ycUoDeqRyHM
	 zxVuSA7MYKvxA==
Date: Mon, 26 Sep 2022 13:22:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 2/5] iommu/amd: Protect domain update with domain_lock
Message-ID: <YzGLimZhwwt6qIVB@8bytes.org>
References: <20220912063248.7909-1-vasant.hegde@amd.com>
 <20220912063248.7909-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912063248.7909-3-vasant.hegde@amd.com>

Hi Vasant,

On Mon, Sep 12, 2022 at 06:32:45AM +0000, Vasant Hegde wrote:
> In protection_domain_free() path it calls amd_iommu_domain_update() to
> update IOMMU.
>   protection_domain_free -> free_io_pgtable_ops ->
>     v1_free_pgtable -> amd_iommu_domain_update
> 
> Make sure its protected using domain->lock.

A concurrent access to the domain at this point would be a bug in
itself, and the locking wouldn't help here either because the domain
including the lock is freed right after release.

Do you see and concurrent accesses to the domain at this point?

Regards,

	Joerg

