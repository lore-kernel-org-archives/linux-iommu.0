Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C81CA9E
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 17:18:49 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-32001d16a14so6682628f8f.1
        for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695662328; x=1696267128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tciPN/nxlvJ0kD/I8pIzAtOjgHRjqQjNn6wevcTJGg=;
        b=Fv75Bsnc2R5sep1fh19MaxukdvCEjUl2Gx9BsvaSyoLZGNNp/pU8Jk5FLVrAa4kIk3
         AQAv4tFq1uqVgtCAaAK8HyCyTfkwwIc+jyO1oeTVj3BDQXvfhUnZOq1WciP5hC9h7Whl
         xyLOITaboFjhuaxq2XQe6J91G3rML02uzXlnAN3Aew3ZyuJ+TnVzjRIvIsv6gAXfzQP8
         p0q5oV54pMdPRH00NmRGDe0viBw+LoZ6IPehhXkfiA/ZtcO33vDDWJvVEnD1cTXkX+W/
         g7kds/wD1WVS+Xl8ZRg0l71zP1NkkrIAZh8SKB5jRQ979utEPSWQGgcZSpWWoIjRf6Xs
         WTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662328; x=1696267128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tciPN/nxlvJ0kD/I8pIzAtOjgHRjqQjNn6wevcTJGg=;
        b=o5ftPFSR6uBG5c+LbkjMvX7x42rDc2Rj1g3Ov0THPisJKFzSRNDlPv+oZNNBq3fcuR
         kgcQ/Bpv7UvBx57eQSLT6qlLK/rHND2vBSgu1SVoMY3RpnaTmKA2RmAP8sFB+FSwIyRQ
         +QLgg98r8hJ2tEY52j9pzSd33JW9I3I2dnfClhvw7kgnKFEpPHRQJjkpS/AR1xKBHtjl
         2/0s7fROyKxP1li/03cp/n0N8dBPYBA5UKasFGLbepriPAAadAf1TeQsyqdiXjmWBi8f
         eXzBwEE6AlWUSkn5zqKeqCSCRVOE3ep5PSt3UaSzdk8L0S5VspAktjpqr7sY7AXGCDoH
         mVJg==
X-Gm-Message-State: AOJu0YyHy9xN7riMySsHfbGUQaTz+E2ZmPxHp8U+68OUlxuxpW67+Iyi
	K3RBnPC0Ho+LmdH3YBNcp5E4WQ==
X-Google-Smtp-Source: AGHT+IGqhtUhSeoHDeBBUcu7FhFEX2xileNPxVaKSeBdM/QI+UNynZlC0Y4NrgOPfhgrgwDOmSC0uQ==
X-Received: by 2002:a05:6000:1a54:b0:31f:8999:c3fe with SMTP id t20-20020a0560001a5400b0031f8999c3femr5751965wry.69.1695662328188;
        Mon, 25 Sep 2023 10:18:48 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id m16-20020a056000009000b0031c71693449sm12449193wrx.1.2023.09.25.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:18:47 -0700 (PDT)
Date: Mon, 25 Sep 2023 18:18:53 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 40/45] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20230925171853.GA2068481@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-41-jean-philippe@linaro.org>
 <ZQsdfcCaeQSn2pzQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQsdfcCaeQSn2pzQ@google.com>

On Wed, Sep 20, 2023 at 04:27:41PM +0000, Mostafa Saleh wrote:
> > +static void kvm_arm_smmu_domain_free(struct iommu_domain *domain)
> > +{
> > +	int ret;
> > +	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
> > +	struct arm_smmu_device *smmu = kvm_smmu_domain->smmu;
> > +
> > +	if (smmu) {
> > +		struct host_arm_smmu_device *host_smmu = smmu_to_host(smmu);
> > +
> > +		ret = kvm_call_hyp_nvhe(__pkvm_host_iommu_free_domain,
> > +					host_smmu->id, kvm_smmu_domain->id);
> > +		/*
> > +		 * On failure, leak the pgd because it probably hasn't been
> > +		 * reclaimed by the host.
> > +		 */
> > +		if (!WARN_ON(ret))
> > +			free_pages(kvm_smmu_domain->pgd, host_smmu->pgd_order);
> I believe this doube-free the pgd in case of attatch_dev fails, as it
> would try to free it their also (in kvm_arm_smmu_domain_finalize).
> 
> I think this is right place to free the pgd.

Since this depends on kvm_smmu_domain->smmu being non-NULL, which is only
true if finalize() succeeded, then we shouldn't get a double-free.

But finalize() does leak kvm_smmu_domain->id if the pgd allocation fails,
I fixed that.

Thanks,
Jean
