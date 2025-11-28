Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D782641C6
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349977; cv=none; b=tHSVf8huV0NYlvWErGROnA1zRguR/TkgOW8mF4ghyLYu3A9kyoMLUtMv8XYPqpkk+6drjB6fVlc7RtsuO9indaJPeM8y7Vgh29+pe2eCaDC0n1Baxk3QCyA1D3MO45xIq9+BtGb1o2pF5cA8F3EMHcI8WMl79eyY8hgb0ZqAxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349977; c=relaxed/simple;
	bh=/sBYS2Dqy7t/Qv6aMLloF3PncUN9/Dov0w4IrPDsi+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBQsiz4hRBxKRYxLXTSrbrKtVn6vSNeJ1TByQnT0p21zDw5YymlQxd1De8/uXksV54Sp/eMHLp6NT+T8UCDpsARxAhnWU7Hd2nZkeYgV5m3anxGv5XHIEzznRUIXNfQDaQQqvuxHQ0j6yIXgrLqGr3rGItWzm/N+hjG8mpkcgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B09mikJw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B09mikJw"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2dcdde65bso286975685a.0
        for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764349974; x=1764954774; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGMOgE5nROcKR76+XJUgIhsjqUTTAWoW5W6MOeDvkTk=;
        b=B09mikJwgHFtd1tfDrnBPZZQoxCfG1v/G5bwhNR2MdnscKbPGVKu4wrhrDToZxeU1u
         LGT+Fd/bVzNok5hSkTNXpeQn6Tr/+jJ44XQ73ul377qDAnLKGqQBkRz5xAHH1Pgk91hg
         xSXS2oK3AWPcsuyeWq500OHfbjyn3ghh+mnO+tf3fBBZsb7ctm2YxydvSu0AgPbg2+M+
         8lkcvFOSk/pRMT/eh8mAxdWBvx3UX3imhtCDFoRfsjrTCwQLeZ2usuLnczLHXd/qxSj+
         u3AQhQZlLQp/Pd/nUZp5eqNFT1nDX027zcfy/K5O7MKc92dyKWdaK8bS2uA8wIwJRfGt
         LlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764349974; x=1764954774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGMOgE5nROcKR76+XJUgIhsjqUTTAWoW5W6MOeDvkTk=;
        b=u3BnLah5u2YrA1GvLN2vepSk7MO3LB8lkdgLlsVtCwzJL70XFzRzHXuHLRJ7WZ9nMp
         OnACToOjdAGwFEg9lgCYjUd0pN8aw1+6XuMIWlndIVvjq4njwOPzq1pJCUTYXKwOVuee
         6vsFIIUSJZX9XbIKJc/KLfVfgKHL4uMpgJqTuw3YNmCrNJkdAQm51cGovi+dCKA+eG3m
         Jii7DWUdPdfYchcrHbkD/hAumnE23V9wFWWgyGzOl81lCUYgCVDNpIfQfvOdUpv20amk
         LZgxu1k7nY2oz1CmcO1VC3OnrVOmFL5jJcgQjsnthYufCzx0wWIJoVP2eHnq1SwPncj0
         5mBg==
X-Forwarded-Encrypted: i=1; AJvYcCX7hr2YQPRg8sJP1OFPtH+wheNe1kTV6QAl9XaJyA4+8VlvUqe9CGFFgYqD3ejHdryuXZpoqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTHZHQ3JACApE0F2cGqd9KILvLWFSNuqbQxRiwvjX35QF5UPnS
	09LjEjE2iX4WmmWUtlaq1Gr0xP1/tOU0oMU57CrDbj5YG30i7QY8gTOh34zFUrfr4wc=
X-Gm-Gg: ASbGncuP7cGsAHLmkU08ww4fpVQ2xWKuXhcFX8juocDA5KSpekm/HOvPm1PjdPXqpb3
	uoDvFa5DMI2zZccBphp3YNV5kAerBYEnBnDTxV7IbZdl6y4zYL8QTpMtbVxvcyS6+rSMOaVkKIz
	OwfjHxzv7eIXyaVrrqsUuCA/2rpWipzPUxBc4ptUEQgRb1DveG5tYB3+i0zytmXr40ryudNMnTd
	rSptPJjRBjrAvyQKu8il7KZwBcVZ/cXNy8BMPmUTRjQK3QnBNgJMM66gjdpebgwHMipvkntDLbi
	7hTYJg8OY/Q2S+01LLH4hucn7Dj020Z8gByGEjx6wH5o49Ue44NJ9KIGAz1a3fXfqLTjnmU8VM5
	M2Kd7nKfYHsGnGCL60wd7g4ZVTaQVm+a1GaSmv475jOTNu8Lfv2nvpuPEsltUmj/P7Cr96TMFTp
	bHZQEYcD+fgS4H+y/YmPqAHryOWSlBm5pbhgIe8T3M5pxktsgsTKIGA0cV
X-Google-Smtp-Source: AGHT+IEpLMRDIa8BpUCxOvzv6sBrlYlrmtR4jLIjgGtg7IeIGGp0t/UdGNKFxQmXbiZHtnUvklj64g==
X-Received: by 2002:a05:620a:3188:b0:864:48eb:34e with SMTP id af79cd13be357-8b4ebdaea45mr2049767785a.55.1764349974363;
        Fri, 28 Nov 2025 09:12:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299a69d1sm339226285a.16.2025.11.28.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:12:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vP21c-00000003Q9u-4AUc;
	Fri, 28 Nov 2025 13:12:53 -0400
Date: Fri, 28 Nov 2025 13:12:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 27/27] iommu/arm-smmu-v3-kvm: Enable nesting
Message-ID: <20251128171252.GF812105@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-28-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184815.1027271-28-smostafa@google.com>

On Mon, Nov 17, 2025 at 06:48:14PM +0000, Mostafa Saleh wrote:
> @@ -441,8 +490,32 @@ static void smmu_reshadow_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, bool
>  		hyp_ste_ptr = smmu_get_ste_ptr(smmu, sid, hyp_ste_base);
>  	}
>  
> -	smmu_copy_from_host(smmu, hyp_ste_ptr->data, host_ste_ptr->data,
> +	smmu_copy_from_host(smmu, target.data, host_ste_ptr->data,
>  			    STRTAB_STE_DWORDS << 3);
> +	/*
> +	 * Typically, STE update is done as the following
> +	 * 1- Write last 7 dwords, while STE is invalid
> +	 * 2- CFGI
> +	 * 3- Write first dword, making STE valid
> +	 * 4- CFGI
> +	 * As the SMMU MUST at least load 64 bits atomically
> +	 * that gurantees that there is no race between writing
> +	 * the STE and the CFGI where the SMMU observes parts
> +	 * of the STE.
> +	 * In the shadow we update the STE to enable nested translation,
> +	 * which requires updating first 4 dwords.
> +	 * That is only done if the STE is valid and not in abort.
> +	 * Which means it happens at step 4)
> +	 * So we need to also write the last 7 dwords and send CFGI
> +	 * before writing the first dword.
> +	 * There is no need for last CFGI as it's done next.
> +	 */

This really should share the main driver logic to do STE writes in the
right order and try to avoid making it non-valid if not necessary.

This will not properly support all the real-world kernel flows around
PASID with such a simplistic implementation.

Json
