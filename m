Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224887;
	b=bmqE6ZoKY+w2jP9mOM+CqGoSeEx+p9I7MMuWjil8O7zE0Cw0UjL3ZRgtmEpes7KE+m5e
	 10kyWneenEeV9xGu7Mb81G+9r603xvMqj1wJk+zF1RBUepe2NaZm+4JXoWAfcZfsn8XSm
	 CrpaR6DHQKl+Cedfues0JQOdjKlLgjaWshDlyo5EC3ZYYCFJbJrhqH4+guPXXunvHE8J7
	 kU/QrMYVp/YWlfm3K1m2jKFeUgbzAd7vbHrzOruZaCOAnDhFjxrprc0x1NZ2NLJx5JQIv
	 k5z+Ypd7pNGYCE5QR2mSb6yGz9wpK46P/QW5RlZp4gC+/i8gD9xMlBc6U+4HZmfthHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NTI6bfaVgGVs6WfACz4lcJC4XYY+Jhtgi4CMSA27Peo=;
	b=EoL5Y8NrvPcwgPTfwpuPP4C0BHIlGxQyATKHaS2dJKMTDeliHMg44IEoIXN/ytUGbbDG
	 nSMvHMSZKtJYjMpNngZzp8pCiQVfB0DT+h7I1T3yvhM4FVoPCfZvoBzBajNO/x5fD0cvN
	 wfBU5gs1ycAkGQiwJ/V961Tda2QqhjVs0BaH/k4879syQj+ojZNNVfJDMf5Gkp9pJ8aJm
	 YvK4krQbHEpW0yJpS9UxMXeaKeXi8+VtcULjNqPgQeHd9aZkSH+Lc7VP4EWOCP1LXkEZ5
	 TrP2z36XMeCbY91eW1L75BxRrhzXeKyoafv3gccoL8Nt2/6hPlqN1LkjfmRCZiI+jqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUWIsvKR;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C9606A325
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 11:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731C9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUWIsvKR
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so24335e9.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 03:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794224886; x=1794829686; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NTI6bfaVgGVs6WfACz4lcJC4XYY+Jhtgi4CMSA27Peo=;
        b=lUWIsvKRTr1hRQNI6a66k0XyS6CGwk76LruSlfaM3WUXFLmDjYFI42MGzZROwKUcog
         OZtmNLHZzPd+fqz364bdKj7e3tN8ilORr+l8N9p4DmeYHWfB1BNX/zXCARCehCzjv3xa
         0WMqQZn/PMp7uxZ/Lv3OuOvvjeDlbiOr3lXcQu4/MsYTSlpuztjaY0ytw68IFu8yrHFy
         Ux1AUVuVKIcd+IoEAA1ChA3KHSbaPKMZtLDOo/FiXKiQJxs2Y8pXMBNHSJBA/i1DciIu
         AstpoDQASPTxbG3uKq/IvmnNVFNlz/hd2Yv/kiv9kBpise0Cuoo6OeIGL+IlftxhiBUl
         3lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224886; x=1794829686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NTI6bfaVgGVs6WfACz4lcJC4XYY+Jhtgi4CMSA27Peo=;
        b=yK2006H8cmAIWnJ4LlBam2Rrt+lDYbReXi2KgGlo0vLMZrRB+SbKWumouiZsPg/ykU
         tmavNoauz5on4BO/8c2bBR2IRqeiZS5XegKioWn0gbkzQQ0P/ZfA7AMZqnDiGF1AiN7Z
         UYGSrC+DmyXboWnxL70bN83/tp5O1SLwxFirB3y2Alg6OM4+QrICDIYN8a7UNG3g2w5v
         WWEESz0VTzmssUXqUVdwC8aJjKStld5B8fToPL4FV1PftchhRpf4zuw4XXnISRFFhQl0
         VonVpkcOlKlxa+wk7HZlarJuXEY2Nf6Vfyr8x6ytsXpSeQI8cQSHWkSpgAYWgjZZdlJk
         OVzg==
X-Forwarded-Encrypted: i=1; AL+hErF4yASiGr4W8ltVXYrFmH/3HcY/Jcvg8SH3qOIWm+X3qmih82P4JTWprcN/y9IGe7FfTr1kRA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+QxN2/tCk03PzBRGarCQ4fQemrtNCTyXOVh3VCWzudM+VOgXz3
	RwdTzFdNQ1CW7+zE2P6pDWLu+EWQg0iIc2sED5Qo/8jIjjEeoEDYi9QaUyRMMVpgig==
X-Gm-Gg: AYBFou0QVoPPOSYqJamPcBAcsmZ57mFCqK07TKbGPV0XL3SBumu7ZptqJgzYOZ/i/ry
	aPXaGgcCCMN/Zkx7kR6D9gEweAxB2hjr6MtJYJFAbJgZHMyt30iGERQGwhCq2GDCIw+I1Rb6Y0p
	EcMQf4gZEKrcmONM/JLWpn7mgWHz1NWBYuyH78fXl/w1MpXqEjGlCs6NMMCOIhAYwTHqUvsvgEP
	0AEO4UfO131AZrU05vZ1iCundcCbClbaxrk47yBeWt0CvfR70LnLOjoWw55ylj+EgNoONh2o/YE
	l4T40YDoxXlw9Hppykbx1HNrOWuLZ5n7cz74ifzvTMjph1Ms6N/sVNa3J/6Pw0AdLF8GnC/EwhF
	3bXYOoNVzrzlrxEL9P+NRxJNPx8a3E45HIY+H8i3x2er2TnxIePhcle3GizoLObgz9kftGcDkm/
	EJ5wTFa13hZ4ikXAniSsK2JBU2abyRSga2vvNAF2I1CZ1etWfTgUjpc5UfGZ1CDrMRN/sje2tU8
	dzVhSDvZt8t16hSx9jC0f1szfXVuvyIHM/SBoQXytgTZS/isRtMF4eQBUS/SBYvTdpu5OY4UYKC
	j3lVtERT1sjGkXQaX3UyVkaDsfIWMvVPvrLYz787CpucF/yKhe/PDFEsRT8Lo86AZdWSyg==
X-Received: by 2002:a05:600c:528f:b0:4b6:5035:d54a with SMTP id 5b1f17b1804b1-4b8aec15d44mr2258615e9.1.1794224885385;
        Mon, 09 Nov 2026 03:48:05 -0800 (PST)
Received: from google.com (160.193.189.35.bc.googleusercontent.com. [35.189.193.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596f9a9ffsm9878242f8f.30.2026.11.09.03.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:48:04 -0800 (PST)
Date: Mon, 9 Nov 2026 11:47:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 16/25] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <avGy7mS5A0SGib0m@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-17-smostafa@google.com>
 <au4lp8sAnWm3/Sw5@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au4lp8sAnWm3/Sw5@nvidia.com>

On Fri, Nov 06, 2026 at 11:08:23AM -0800, Nicolin Chen wrote:
> On Thu, Oct 15, 2026 at 08:08:47PM +0000, Mostafa Saleh wrote:
> > @@ -385,18 +482,51 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
> >  		 */
> >  		mask = read_only & ~(IDR0_S2P | IDR0_VMID16 | IDR0_MSI | IDR0_HYP | IDR0_ATS);
> >  		break;
> > -	/* Passthrough the register access for bisectability, handled later */
> >  	case ARM_SMMU_CMDQ_BASE:
> > +		/*
> > +		 * Although allowed to use smaller size, we rely on the SMMUv3 driver
> > +		 * using 64-bit store instruction for simplicity.
> > +		 */
> > +		if (len != sizeof(u64))
> > +			break;
> >  		if (is_write) {
> >  			/* Not allowed by the architecture */
> >  			if (is_cmdq_enabled(smmu))
> 
> The spec says the register is RO when CMDQEN=0. So, maybe it should
> be allowed by just ignoring the write?
> 

Yes, that's possible, I am slightly inclined to be more strict here,
as this should never happen and if the kernel is buggy or malicous
it is better to catch the point it goes wrong rather than trying to
debug the side effects of ignoring the write as most likely it will
go wrong shortly after (timeouts or commands are ignored causing TLB
corruption...).

An alternative would be to ignore it and log something, at the moment
tracing is supported in EL2, and IIRC, logging to dmesg is also planned.

Thanks,
Mostafa

> >  	case ARM_SMMU_CMDQ_CONS:
> > +		if (len != sizeof(u32))
> > +			break;
> > +		if (is_write) {
> > +			if (WARN_ON(is_cmdq_enabled(smmu)))
> > +				break;
> 
> Ditto
> 
> Nicolin
