Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923F28137E
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988736; cv=none; b=BWuP7ov87NoniOFr6zSinT1/i4aL9GBFVauAa//v8azCPFVdbr+ajPJ8SCgO15wP0XWXkts43w7BqHFExWSyG7LZkuIXupYBZKcK+JjAeDOIxkN4Z7xgyPqxRSBdPTK5Yfddeo9/rTZRuuN1cCQ1J9wm0z8ypf6zLqSGK7YTwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988736; c=relaxed/simple;
	bh=DjqbnqMauH7Rz5mYETfYJBnvKbcPqg9Bet2qd5QKtbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD36waNZhe9WUsB513q0eZ0Kz/pASRxrn0nHTBJ7Z2TjtFk1FY/70/qAEr29ReZYhunEjS+q5AzKy235ePWQ36M2eMQgkUEcHhlH/QwAWHKCuNwtK58uL3YQMAOm502AGnoIMCNoKtgjB5byswbmLhuu02K6/NlUuGcwttCexCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5jrsC0B; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5jrsC0B"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450dab50afeso72435e9.0
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751988732; x=1752593532; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GluJBwY9NbvnBeZjQZU45ssXk5Te8rweY8yFjh6vHuQ=;
        b=Z5jrsC0BuziieFGYfI3tXk2DIVCsYOBrhG7rEYtX7PO5y18vTSqgvh6dmwhPThaCE2
         BgMPN1JFYcaIm5HFeX7FC+D7vHO82RYHi+ua4EeD13RKofZkKUnaDbG03YMGjPY7D/TV
         bsArwB+h+Pk6f3lZXwQgR757inXQe5xaLctyuEKJXAS0Jwz0W/vT979JwLG8mSeWKP0j
         jVTuYAcVPrjdpWNTcKYFJO3jjPxbMNI5orNn7zvF5kSgKZ7hWkJ2oRayrFonXmO9mVVi
         MCKzG3oCZ1AF46hrlMlvFlJbR43YZqyxi7NYlbEjSRuYEzGjfr4FXl/ZhLduRvIKS0ev
         L3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988732; x=1752593532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GluJBwY9NbvnBeZjQZU45ssXk5Te8rweY8yFjh6vHuQ=;
        b=RftVDlDBzfMT7h6RDSij8F+V0ObyKPhbMMcK9cRtwxJ5qc2PzO8y//ahO+71k1obLX
         LRRpHN50Qz6SRq/+DcO08RvH/Z0fMFukJzTKL4NNU8HFmyxeTlOGxsbpyzGOqiD2FsJr
         08BCLPx8//EK7E0g/A1/nvLSLw814NWRaE5tfd+8IzJU+VLhrWnJJnWoa+c4puy434y1
         +hla8XqvKDWJ+u75qs0gd4UGKK9Zjf4CCEAZZoWL25Y+a/0XlC/Yku1iD+shO4NwpL0Z
         f3EsCyoYRYA3hUJ5PMRDgfds7uUcAiB3htbW8XkaSK+KWyk8cb/RnM17GYz7uUtyyIlO
         Ncrg==
X-Forwarded-Encrypted: i=1; AJvYcCXVuCeuXDAlFU2f+u/fz3iHJ//1Bf5W/5TXpv2QhAdTJvB/NE4tevdgRfJf0MqLmlJ9rvOlEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf8xou67j8yCp9Wdwp8b0WZuI4k8hbGlqiw3Jc3+cAx+UGc9F2
	NnBAqOuYjAl9MUdehlbAqQfC9Vv/7PU0qVbaUs3paKLWaBojLbjqyLjvtxissuVycg==
X-Gm-Gg: ASbGncstNdtjfm++NinOk/fKiuPXe0JnoZhNHIrebNAvODMV6VaFOdk/YLysv8mDLuv
	IiLAHHs9zdXBkl6WPPKXxlE3XFq/Lfos3LJOgn3io3sUtft96yNNu50Yy0+X+J7yUy9T3H6mnvn
	hFpQ1xslGunW75iZkm/casJjRI7CHiaNtBskNktyRgGgvFVzhUpt9j7qvcXYXHHD9rXgXtICwsB
	jLN3YMIMcTklnaym4ERwXLYWIk62uEqC4SLEUeesWO4aspM9cIbAlyliKH+yycfZxZhWNByt/mn
	+dDkrlugp2SNrJ80Be8r6BY2WSexEq/LVUJexUUhX0TXp7kayL3C2KR08S8S5vazW8DqwNrG452
	m0xm9yM31V1GRzZ6MnSWSkw==
X-Google-Smtp-Source: AGHT+IHnYatH1sI2ufuwKjQVv2MCvFSOpO6A6OfrqnE4JgAAIbdjwPxZiCnVS5OvPt9na5pWkrZl7w==
X-Received: by 2002:a05:600c:1497:b0:453:7edd:fdbb with SMTP id 5b1f17b1804b1-454cff07a94mr695735e9.4.1751988732147;
        Tue, 08 Jul 2025 08:32:12 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a2dcsm13269976f8f.71.2025.07.08.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:32:11 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:32:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <aG05-KFZRivJ5iHY@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616203149.2649118-3-praan@google.com>

On Mon, Jun 16, 2025 at 08:31:43PM +0000, Pranjal Shrivastava wrote:
> Before we suspend SMMU, we want to ensure that all commands have been
> flushed by all the queues i.e. the queues are empty. Add a helper
> function that polls till the queues are dained.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 40 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f19a77708d2c..0df1b17a09cc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -981,6 +981,46 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  					   cmds->num, true);
>  }
>  
> +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +				    struct arm_smmu_queue *q)
> +{
> +	struct arm_smmu_queue_poll qp;
> +	struct arm_smmu_ll_queue *llq = &q->llq;
> +	int ret = 0;
> +
> +	queue_poll_init(smmu, &qp);
> +	do {
> +		if (queue_empty(llq))
> +			break;
> +
> +		ret = queue_poll(&qp);
> +		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> +{
> +	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> +	unsigned long flags;
> +	int ret;
> +
> +	/*
> +	 * Since this is only called from the suspend callback, we
> +	 * should be able to acquire the exclusive lock without failing.
> +	 */

I don’t understand the comment, can’t the command queue be busy at this
point form another unmap context?

> +	arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags);
> +	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> +	arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +

I wonder if that’s enough, I see that if arm_smmu_cmdq_issue_cmdlist()
is called with sync=false, it won't touch the exclusive lock, so what
happens if another driver keeps unmapping, that means that this thread
can loop forever as prod keeps growing?

Thinking out loud about this, if the aim of draining the command queue
is not TLB invalidation but ATC, maybe we need higher-level
synchronization between those 2 and keep the command queue out of this.
(this also applies for the next patch for tegra)

Thanks,
Mostafa

>  static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
>  				   struct iommu_page_response *resp)
>  {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index dd1ad56ce863..461f1958e574 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -965,6 +965,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
>  		       struct arm_smmu_cmdq *cmdq);
>  
> +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +				    struct arm_smmu_queue *q);
> +
>  static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>  {
>  	return dev_iommu_fwspec_get(master->dev)->flags &
> -- 
> 2.50.0.rc2.692.g299adb8693-goog
> 
