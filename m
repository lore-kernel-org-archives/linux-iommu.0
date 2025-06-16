Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D511CBA
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109571; cv=none; b=EmR7HR7NVLxIypvM0K/3hzF0TvyqOVQrUYwYKHQdGjuQ3t+2ocg5SQQt93EWxOoPMcfTM8BDiE8ljSyu8Q8nD5OUqmARYfseMLQuGkv2A0wHBoIhqM84jYzQviJd71o7ytThzOSLiYedEjQ/TJnzsZe+9bBBo8s14TmMXvwmeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109571; c=relaxed/simple;
	bh=1daXkcpedeVMkdfibmjOiKjSGHv5H5jAWkH3U7rNLWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4p3OexLOFvy23ZoG/JhIKpYk91JK62h7jpcT/KxMpjDxCA5FIFlLiNrTqLKaTALU3S/UVyWdthygEmhakUOVySzpb+FGE2RGVfkk+iUxFjGXLtwE0ibjs01qWnmPMrp7XqkrfHd5Yex4Iz2paiYg6XD9JvG42D4FWB5JcCvwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwxqpMSe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwxqpMSe"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso67595ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750109569; x=1750714369; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=diaMMomGVSeMyl9b0SDQ+0jS5CqmoXFRYMyDr82RfPg=;
        b=NwxqpMSe4D/9SnaOCk58OGou0pVSfEXQh02JS1FG3EqzmmFeyASoyUSNv/B5vMFYnf
         +q+1A1TuTWEyXF6Gb+G7HQH6XTOyRXo0p3Rl47ZAEciOg7UIAeQ4eZWaP5oYzO5LFUz1
         HOOdnVXi0aqBpOLItXH3NfAkw2tnmeztE7gRP6EZ39SsDCw/Mp77YOs80R/tzsWSkIGL
         ZIKijdmET8jztFqi0/4x6NobZNjUVwN2Ik8ojdAif3lxQVCuYiLZ29D4+/sU9XrEvEgg
         xwIf7KDc7cRSwxKgevlLSn9/Wqv93OSJypJV0EL7EgcnpJ21b8I68w9NQNeC8lMJkMPC
         Eb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750109569; x=1750714369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diaMMomGVSeMyl9b0SDQ+0jS5CqmoXFRYMyDr82RfPg=;
        b=V7YnH7tnVteWEHAxb1HMg/7oRFp6/2kDrlM8aFXiNRgKsnSAhmzar8A74nRA1L4Kyh
         dPgCWTACFNENsNzlqHrJOcjN3YhbBi/gcb264q9wRAXrMKUKmkW1yhWxcuS1cJeeXdyv
         xKzGhgu7HcMr6qDVQwrXXivcPniEmcdF2u3nUkEdlOgmd2se5tP2R93b033sU4m2269p
         JVExcew0eae4hq691vuB3kYmJ5IUyIWWw7at15yB9+ciNgTFKUyP4Cdn1svTtmlO6qpy
         1K+l4ozYc4h9qyaY8fJQiXjkn7/3rq7iwp76m79XZfwnyXX0nleMbRnq+27vIFAn6Ot4
         xEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbx72TBCq1N1QWaPJlLoIEM8NQflJljvswaPQ7nHqCe4RqfpvTIOrmgwXoxeHJd7RwJB2d/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpwTyXlf2QuUtV5HGMhZ0Zuf0sujTVQb2Bssq1imCnsbKve28p
	YIMMhWMHlb9aGriCIXlp3qkWin1oktX6auRyMDiiTOTjRUpVorWINBGgkS5Bv9foqw==
X-Gm-Gg: ASbGncstcA092WT81q6NznF7oebIuIWa0lh4B/dbzEFSOL4YEfq3C0S5zu1Ujbbvc0V
	d8n2BISyKadOrBGKUoGK6dqwxL43htiwCwNox5TLCEgHpN9E2VkN4uTBzZS+r8WTD7kJSPVbG1a
	X20DU5wf61IUyGkepu+1ejpgFJSsy02DUTDSIEWYmMKNDk6foe0HwnrotyOg2WROyFRaTRSwcXe
	kzdaCYEOuk2vyXZqNFhsYvJ/fXfuDfifKHnYYVlJswjB7x9jpIb496v1Q9RJ/L0vhf+RbvaoFp8
	Z0dKkXENaTsfr/J6dEVz46+IvhTmObZ7uKAen1fykVEeSWwVhuBE9BtU62xdu1bI3zoCU3XqHNt
	el6JNyh0Cj2UGH4jVjTFs
X-Google-Smtp-Source: AGHT+IFWcQvoP+9fcVVp+c/nzrucrkTOoV642VxsR9D43oNtEPpmRjh6B8M7BM1aG3k8myNk+wmbkw==
X-Received: by 2002:a17:902:e74f:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-2366c4f491bmr6716645ad.0.1750109569076;
        Mon, 16 Jun 2025 14:32:49 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31886377a6sm5271665a12.71.2025.06.16.14.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:32:48 -0700 (PDT)
Date: Mon, 16 Jun 2025 21:32:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Ning li <ning.li@mediatek.com>, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/8] iommu/arm-smmu-v3: Add IRQ handle for smmu impl
Message-ID: <aFCNeOP7oRv7NRjQ@google.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
 <20250616025628.25454-6-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616025628.25454-6-xueqi.zhang@mediatek.com>

On Mon, Jun 16, 2025 at 10:56:11AM +0800, Xueqi Zhang wrote:
> Add IRQ handle for smmu impl
> 
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 8 ++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d36124a6bb54..154417b380fa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1954,7 +1954,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  			arm_smmu_decode_event(smmu, evt, &event);
>  			if (arm_smmu_handle_event(smmu, evt, &event))
>  				arm_smmu_dump_event(smmu, evt, &event, &rs);
> -
> +			if (smmu->impl && smmu->impl->smmu_evt_handler)
> +				smmu->impl->smmu_evt_handler(irq, smmu, evt, &rs);
>  			put_device(event.dev);
>  			cond_resched();
>  		}
> @@ -2091,7 +2092,13 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
>  
>  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>  {
> +	struct arm_smmu_device *smmu = dev;
> +
>  	arm_smmu_gerror_handler(irq, dev);
> +
> +	if (smmu->impl && smmu->impl->combined_irq_handle)
> +		smmu->impl->combined_irq_handle(irq, smmu);
> +
>  	return IRQ_WAKE_THREAD;
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 99eeb6143c49..f45c4bf84bc1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -792,6 +792,7 @@ struct arm_smmu_device {
>  
>  	struct rb_root			streams;
>  	struct mutex			streams_mutex;
> +	const struct arm_smmu_v3_impl	*impl;
>  };
>  
>  struct arm_smmu_stream {
> @@ -998,6 +999,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
>  				bool sync);
>  
> +/* Implementation details */
> +struct arm_smmu_v3_impl {
> +	int (*combined_irq_handle)(int irq, struct arm_smmu_device *smmu_dev);
> +	int (*smmu_evt_handler)(int irq, struct arm_smmu_device *smmu_dev,
> +				u64 *evt, struct ratelimit_state *rs);
> +};

Let's add these to the exisiting struct arm_smmu_impl_ops and invoke
them like:

	if (smmu->impl && smmu->impl_ops->combined_irq_handle)
		smmu->impl_ops->combined_irq_handle(irq, smmu);

Or maybe we could merge the existing impl_dev and impl_ops into a single
structure.

> +
>  struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu);
>  #if IS_ENABLED(CONFIG_ARM_SMMU_V3_MEDIATEK)
>  struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu);
> -- 
> 2.46.0
> 
> 
