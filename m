Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB002F41
	for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676073074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxG2e2jd/Ft5YwmWrl0Bp+sdIxiuwt9Kd232cbEoDxs=;
	b=fP8ygXSKd9toKX+RNShuSUKdxRME1pGdqCwLayp+DpYhmf1POP0pwWee5DBrWIA58ueABp
	qArzQS05WnpZhtnfSAqEMC8Rgrsqfdc4LkiYVbo5Cx0Qd8roC2KrsOSOBM6q8Vb5WUmx1f
	N+laIKD5Wx30RocUAPI7gnZVZikg0wo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-GZzlj3WtNYOFUmBwKc5iTw-1; Fri, 10 Feb 2023 18:51:13 -0500
X-MC-Unique: GZzlj3WtNYOFUmBwKc5iTw-1
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso5268734ilq.4
        for <iommu@lists.linux.dev>; Fri, 10 Feb 2023 15:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxG2e2jd/Ft5YwmWrl0Bp+sdIxiuwt9Kd232cbEoDxs=;
        b=kHHNkVQhgyhkbyBsM7m0uC+IXZYAxIinUwyKQCaRs7VbmzHlzdrGg0uVIGoEGImtOx
         5CGUM2ZJhwoeB5UOxbYuoZcvPwkmsgNXxn+CNAXY/qiWMe6xqL2bT+cLSmMGuZIvn+IC
         v0BNasTozHg2+63uRHCwsgUCE/glzerrUDTNkifPMhIfkjRJzdAPphyD8qz0T2KZRo+c
         NSbLf8kvyJO4+OXbn9J+mDygr7r+BA33uQvxRy/nDIC990P+VJhJDL5RH2mquttOWKNT
         tsXpYD81j7xqk+CGCiRMfh3Sk/XFe/5BFJQTWPn29CrYDRJ5W5uzZN68OmIjzBVGeLYG
         xlEw==
X-Gm-Message-State: AO0yUKUnLagPGyDueIp0JQ+HEeARIh0wRAf03kzDqAriRhzbKZ93Pl+s
	RauFYHw9PmluT8qcjq/y+DGQL8c8gW9jqw3hpLzFYpGxiYW3mn+DBe0p6fWM4PJv2Ps+KWZnQT1
	8V6eCE55ON0LxmJo=
X-Received: by 2002:a05:6e02:19cf:b0:315:2b7c:3bcd with SMTP id r15-20020a056e0219cf00b003152b7c3bcdmr227361ill.23.1676073072671;
        Fri, 10 Feb 2023 15:51:12 -0800 (PST)
X-Google-Smtp-Source: AK7set842Z0z6M94KbGdEcodes2zf58/JeUwSHWqWrZfu04modlNc2olG9foLCn5r2HwqlyIBAtLsA==
X-Received: by 2002:a05:6e02:19cf:b0:315:2b7c:3bcd with SMTP id r15-20020a056e0219cf00b003152b7c3bcdmr227334ill.23.1676073072410;
        Fri, 10 Feb 2023 15:51:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t26-20020a02c49a000000b0035678e2e175sm1766330jam.50.2023.02.10.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:51:11 -0800 (PST)
Date: Fri, 10 Feb 2023 16:51:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
 <will@kernel.org>, <robin.murphy@arm.com>, <shuah@kernel.org>,
 <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
 <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <20230210165110.4e89ce55.alex.williamson@redhat.com>
In-Reply-To: <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
	<fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Feb 2023 13:17:54 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> qemu has a need to replace the translations associated with a domain
> when the guest does large-scale operations like switching between an
> IDENTITY domain and, say, dma-iommu.c.
> 
> Currently, it does this by replacing all the mappings in a single
> domain, but this is very inefficient and means that domains have to be
> per-device rather than per-translation.
> 
> Provide a high-level API to allow replacements of one domain with
> another. This is similar to a detach/attach cycle except it doesn't
> force the group to go to the blocking domain in-between.
> 
> By removing this forced blocking domain the iommu driver has the
> opportunity to implement an atomic replacement of the domains to the
> greatest extent its hardware allows.
> 
> It could be possible to adderss this by simply removing the protection
> from the iommu_attach_group(), but it is not so clear if that is safe
> for the few users. Thus, add a new API to serve this new purpose.
> 
> Atomic replacement allows the qemu emulation of the viommu to be more
> complete, as real hardware has this ability.

I was under the impression that we could not atomically switch a
device's domain relative to in-flight DMA.  IIRC, the discussion was
relative to VT-d, and I vaguely recall something about the domain
needing to be invalidated before it could be replaced.  Am I
mis-remembering or has this since been solved?  Adding Ashok, who might
have been involved in one of those conversations.

Or maybe atomic is the wrong word here since we expect no in-flight DMA
during the sort of mode transitions referred to here, and we're really
just trying to convey that we can do this via a single operation with
reduced latency?  Thanks,

Alex

> All drivers are already required to support changing between active
> UNMANAGED domains when using their attach_dev ops.
> 
> This API is expected to be used by IOMMUFD, so add to the iommu-priv
> header and mark it as IOMMUFD_INTERNAL.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu-priv.h |  4 ++++
>  drivers/iommu/iommu.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 9e1497027cff..b546795a7e49 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -15,4 +15,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>  	 */
>  	return dev->iommu->iommu_dev->ops;
>  }
> +
> +extern int iommu_group_replace_domain(struct iommu_group *group,
> +				      struct iommu_domain *new_domain);
> +
>  #endif /* __LINUX_IOMMU_PRIV_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a18b7f1a4e6e..15e07d39cd8d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2151,6 +2151,34 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_group);
>  
> +/**
> + * iommu_group_replace_domain - replace the domain that a group is attached to
> + * @new_domain: new IOMMU domain to replace with
> + * @group: IOMMU group that will be attached to the new domain
> + *
> + * This API allows the group to switch domains without being forced to go to
> + * the blocking domain in-between.
> + *
> + * If the currently attached domain is a core domain (e.g. a default_domain),
> + * it will act just like the iommu_attach_group().
> + */
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *new_domain)
> +{
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		__iommu_group_set_domain(group, group->domain);
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
> +
>  static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
>  {
>  	const struct iommu_ops *ops = dev_iommu_ops(dev);

