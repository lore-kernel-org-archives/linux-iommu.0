Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4729CA
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 13:27:32 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id z13so3556366wmp.2
        for <iommu@lists.linux.dev>; Tue, 07 Feb 2023 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJhiytKh63a2Q0Ih/4MzbnKZt6RxQbWjkc5IfouOZfs=;
        b=gZUl/q/IrBjT4+NNchJGC/9j7661ODQsEWoiN8mcIxVQ3uohgT9u5CQ6fj9ozdYkfX
         JFe6f+J3YeuYcIipg9phiWfhMw619XikEztoTe8mpR5vj3asxEGhlKDMyNUfG2W7M3By
         8rNcNWKpZ1L104qpU/w8d3KH5gkjiPctLJPAgv4ckR7iHY/LZ8FjxBTE1H5Ak/4pXpL9
         DktyE6nufnd1OcCl4IHgUNdGkSfKjDPZUrnPblZ7qaXAOpCst8y4BP2GnHilpYEEI+Qq
         pd6FxVP6WpcmPVNWZr0IdTOcAOuz6R8G36iH2QpNhtp0cFjE+SU74qtLMbh/llwuReMN
         bl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJhiytKh63a2Q0Ih/4MzbnKZt6RxQbWjkc5IfouOZfs=;
        b=oGMbohEKqTzcpazAXDLyWdliBlJggPEO3Af0XQeXXborIjIWdaVBAlbqZ2hE8Utke7
         nQxdM8bSlmkmIErGNTQy0PqtSoXDsKtIWz8R654jUBgM4BY5U0/IQCRpgEcjfzkPqyhY
         jFsBs1oOW0mGqpQzEJm+ECiPo+bRBbhAvgoqJImAzZC7tC3F3/Ge2KOpv5rF8zFk9DY2
         M3zgMvX3//IFnJ48b6Iap1/9C90xtcH6RdzEfNyQaJyfMHezs0035cIxt1mjLnvUDk8W
         K9buXFTb54hsTzb9Db3B7El0Fv8sJ++Q8xtkPJeVpw59FBKWMd/5aemctfpHOMVKaQ2+
         YExw==
X-Gm-Message-State: AO0yUKVaIUPSS9FlyQSh05rVW2BWDH4skRmZcPUwq6YAqPZ6kmOtF+BI
	t0KuK0I09qX3SkK/5ViHDO9c1A==
X-Google-Smtp-Source: AK7set8ux4cP2Ybn/abiqHyZixmvKGdmZmX8C0T1Add8hEO97JsvL2S408J4ak5lR1f6nCjluGyEqQ==
X-Received: by 2002:a05:600c:3b93:b0:3df:f3cb:e8ce with SMTP id n19-20020a05600c3b9300b003dff3cbe8cemr126692wms.7.1675776450905;
        Tue, 07 Feb 2023 05:27:30 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d5989000000b002bc7fcf08ddsm11695324wri.103.2023.02.07.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:27:30 -0800 (PST)
Date: Tue, 7 Feb 2023 13:27:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 42/45] KVM: arm64: pkvm: Support SCMI power domain
Message-ID: <Y+JRl3WRwzDJOe2J@google.com>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-43-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201125328.2186498-43-jean-philippe@linaro.org>

Hi Jean,

> +bool kvm_host_scmi_handler(struct kvm_cpu_context *host_ctxt)
> +{
> +	DECLARE_REG(u64, func_id, host_ctxt, 0);
> +
> +	if (!scmi_channel.shmem || func_id != scmi_channel.smc_id)
> +		return false; /* Unhandled */
> +
> +	/*
> +	 * Prevent the host from modifying the request while it is in flight.
> +	 * One page is enough, SCMI messages are smaller than that.
> +	 *
> +	 * FIXME: the host is allowed to poll the shmem while the request is in
> +	 * flight, or read shmem when receiving the SCMI interrupt. Although
> +	 * it's unlikely with the SMC-based transport, this too requires some
> +	 * tightening in the spec.
> +	 */
> +	if (WARN_ON(__pkvm_host_add_remove_page(scmi_channel.shmem_pfn, true)))
> +		return true;
> +
> +	__kvm_host_scmi_handler(host_ctxt);
> +
> +	WARN_ON(__pkvm_host_add_remove_page(scmi_channel.shmem_pfn, false));
> +	return true; /* Handled */
> +}

I am not sure what a typical SCMI channel shmem_size would be.
But would map/unmap be more performant than
memcpy(hyp_local_copy,scmi_channel.pfn,scmi_channel.shmem_size ); ?

Thank,
Mostafa


