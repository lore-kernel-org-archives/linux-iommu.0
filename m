Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFE6839E5
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376443; cv=none; b=p/vMEdXdiGvnPdFCBxbyKraE5R6SBAayWbHgeQCdlfl6FwO9U7RQpXcktLGww+fks5hh7kU3cAZ1hqtw38jXGFY3szvOUFdHvm7zjJCwy3CHFNdubMx5q1b8KPppu5tc8E8DR5k2PesAgTVRPMh6SwfI30JYHBFBy71C/nghBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376443; c=relaxed/simple;
	bh=63TCN/grSYA1rWAH+qH7a+lfvhQsFmLttF5pjeCdXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW3hfbdaIRAjycQlUADPT7YClohD5QJ0WD8W0mtw+/920Ldz/VPGdq3BrHah4HwQik+/1oA/gqHKyZnBKly5sOl/aDQ3yMccDzm8x87B3ql3VzogWbKtRDp/Ohtjz/E893SyQzLsBVX9WAR10MnvuQayXJAFIP+L/EUQh9A+Oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kUKBNQmu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kUKBNQmu"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78a01a3012aso316157985a.2
        for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711376441; x=1711981241; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4khMi8YsL4x6qQRj8U1+7HQEKktCZ8TqyaiPDmkbrE=;
        b=kUKBNQmut368gxP4A8CMHZFnmP9x4T1R/O10U3SjALsh6A4ZjoIkTU3235SphoHTcd
         3lXdoDdpxStNtjsSR12YMEY8A3u4pv9j1oe0SaGrAV4Pb4HgBxdJr5nXoM7A+kNGiK58
         gD1JF5zfKk68YvLKX0nAfV99TRUOspo6+1qWQc8OPwDWa6VL9GUvXSe6842EnNMradRT
         sfCCaFS+1+qG0nifUF7rmuD+3CM83lCUU7wUOa2xS2gtPgsnXcE6kWEWt9gys2bupcon
         SV26hXEeFGukEJjCaVqm/zblQ1eXdsX5005K0FwnQeUnapiZjJ5Dn5VA1AUWEzCSSqRu
         Z0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376441; x=1711981241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4khMi8YsL4x6qQRj8U1+7HQEKktCZ8TqyaiPDmkbrE=;
        b=lXwfHqNmTMc/VHL3q154AjSQaBo4qx9tc5tLTS1MLZgKv92ozbYombTvefckoHE7aa
         1CfQUZTYnluT9s4xYEu8VqGeyJb6o7hs0H+4TgfqEgkRoRtE1L4tf8qwqoaPs8SXW6iV
         QAMCQxXwiGHiupvrhpuQ97Ri6BxhpEt8QlUnwzKoVIXuEDIRi8FB/194AA941NaL+FIo
         ylYWm7pHYtJa4YdK+Ye30PlKqaQrACW0wb3cemlTPEAVfrsoiR97oh/eWRol6NxtOPpZ
         9Dxneg1a/ln0YTNQH1W6x+1U2Z7eJhipGMgQJj+healSVs2H+iDXBqiBM9VR2/YuDzVl
         tIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPUkKpZjbiU9XMB/IILSwIYFJ5LNMXlFqXLm8vw5EkM/lHUE3NivSbPZGTtgN8B1H/2W4CjjuVm8ZXkgHut9o3jMYNxZI=
X-Gm-Message-State: AOJu0YzXP3EbL8Fv012Up6ZS4eLw6BWRiIaXFSxIjG1F3xykibDXK+tr
	ziLnGYnI1dy3wemhj/3lO8FPmmwFyx79ULHM9LiyZBpdgBLsMWret+36+3zmFYQ=
X-Google-Smtp-Source: AGHT+IEIDvH4aJX0QxV4yhRacQicWFP/ioH96fdSaZc4HTl73ipKGoKLrbARimpUoqXo7Z7Mj3Cjjg==
X-Received: by 2002:ae9:e64a:0:b0:789:e917:ac8d with SMTP id x10-20020ae9e64a000000b00789e917ac8dmr12632qkl.71.1711376440895;
        Mon, 25 Mar 2024 07:20:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ou8-20020a05620a620800b007882e204d45sm2170804qkn.37.2024.03.25.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:20:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rokgy-000ME6-0a;
	Mon, 25 Mar 2024 10:48:48 -0300
Date: Mon, 25 Mar 2024 10:48:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Bixuan Cui <cuibixuan@huawei.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
Message-ID: <20240325134848.GA8419@ziepe.ca>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>

On Sun, Mar 24, 2024 at 08:29:00PM +0800, Peng Fan (OSS) wrote:

> +static void arm_smmu_resume_unique_irqs(struct arm_smmu_device *smmu)
> +{
> +	struct device *dev = smmu->dev;
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!dev->msi.domain)
> +		return;
> +
> +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
> +	if (desc) {
> +		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	}
> +
> +	desc = irq_get_msi_desc(smmu->gerr_irq);
> +	if (desc) {
> +		get_cached_msi_msg(smmu->gerr_irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	}
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> +		desc = irq_get_msi_desc(smmu->priq.q.irq);
> +		if (desc) {
> +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
> +			arm_smmu_write_msi_msg(desc, &msg);
> +		}
> +	}
> +}

I wonder if this should be done instead by converting the driver away
from platform MSI to the new MSI mechanism?

Jason
