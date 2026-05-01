Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8173A542D
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639489; cv=none; b=Ew3h94CfmtFaIqnWRq7KbYp3q9dks409hfDJl2JNj0w0bpn1X93fttkjdGsqUdWpJJ/7QFEOGxEO6XdRbvgCFQIWRL5LQ5G/GrTAFR1kVFb53fzSVV+xDqApPVPngFXzZ/9pv9KEn1hHGz9U+WBOA+i6ziVurpi40atWcREDOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639489; c=relaxed/simple;
	bh=6Yymezd7E/UB3QsnyrfM7fDI7+HVN1rOcGdLpyRqtwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKAFH/j1fFjFIPnrop0VEHAisUfsD9PfhB0L1ilhxOIU9DPTw3rlHAMImqoItvsFVEdLxmkEkFoENEp+DiBIyC/j1G5lArQ8/s+UIYOJ8WTmBltI9xapoq3NYcBxqEUnMEZsxRFfOPk7rhb+bscU+th0T3mGdIZ5rR+LiXlZIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E4g/zCKo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E4g/zCKo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d736211595so129021385a.0
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777639487; x=1778244287; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+W1ujC/i2sYkXDbzkORn7Jew8iq3dGZCwNInAwZJio=;
        b=E4g/zCKo30bnrmL3jJbn45RNuE5khStlNBTb09gKk3p6RKPMKJK50DpS05c/vTTXAg
         lrlAqxfI6SKqme+L8pI+RMPbwKS0POKodxkXaZyMyI2UOZpYVOAvohdBxMg659IA2IUL
         uc9xBvINIUkXxmqvyu5wmiAMXJ1jvZoaIXK8x6ubS6WQDfOFlwok4OQL/8BXISbl2i/0
         qDz+O3BnUThb8oAjb02XAw3mnc8vjoTWEmBVkaaqzeCiKr+kAuvEuV87ZU3OSTTbYWyi
         qacBSRmzVyWYYT0w03O7I725R5+PPmMIDsDv9o3byfmnp4iCcz4gDmC0aeL93e8r3aM5
         K8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777639487; x=1778244287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+W1ujC/i2sYkXDbzkORn7Jew8iq3dGZCwNInAwZJio=;
        b=R8DbSdPyv9kX3sLSOwhBfCmknb+RP/uQzAuwhXwvWDtuVj7Q7LjVgP8MBxWcYzgBzd
         hSuM1YD+HQjb/Ixjg/N0IYOnewthKsaqEhUHSMmWhx2sm4TfzYhykOIps3hWySWxfpYb
         iZB6ReTCwq6+LMWEQx1cQUG2346LgGdnJBtj1P3P10J3LtcmS0gFpndXsW9XH3UzIfAx
         ZjiPfSkuKRxc7GotH6oDnL4wvdN2HpAREoyxKORwivJr+NFcCMLtIDM9hfIU48xhkPvF
         RYFc4j6wlPnSAn5Sqo0pDr4hy3IuwMuzXQw26jvOXxwzHJnuho+ChrWYv3MG2UMNJbZW
         dwQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cQbt+hI7iYDyM/BgQBDQH2rh7MQTPZocg2+pfL2+wgMWUITHu7mtmltxPhWegM7Mqg74Icw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytggyqIt14BHF9aRMoV55O6MIeYZ3m31vfkeCJ9QBoCOaNpkyQ
	qcgJ0tZabAQo+yZa14huCJrerBvPbruyfhEXvlI3ks048qifTXm21ucXZFEKcDBuUGA=
X-Gm-Gg: AeBDieu3BFua+KabByRbk4aIOmRub9SpK2MQ5/fEaN6zGtmJ7yKXpimKq3zeasG7lJO
	o0Rzcxqqu79b2jK999u0TTIUbRniV5f8UCQ8WBqz1Al/4GvfpitVHPxMydt2YKizeKARcNK1MH0
	WbYbQlEBO/Q9qfeFkBhst4SNprLMhEn+ebq9wmhYG3Uc6dWkEyk/ddEOcJUrfpekBCtMPpi+Ysl
	+w7kuXmWSAyqbmm72BqmZd8y1hz3KRZ2clPCWw4Pf9O/F0Tsq6SFddutPV0TUnuj2TtyUsfCJDK
	2pRtGcXRGKKU6p8GEbTBstxYQhBoATlqCENdfGoG3BC3G1MPEqqwaK8ma1XRlfT7gmazNj9Tn9l
	hTmIdM8cBcCzDo7fPUj3G3jZ1EdunxMQmxDu4LlL3z6payA4ZwsxDf+bT+kRTNlo3RoVobz06Sm
	OpT3wN6HAzNNCz18Rt11auS5T865iMEaQvgFqOGwJ8pZpXERCaR48/FTQRSmmo0mr6HEtsa1g1f
	OFLj2fu19i5NcufMkyTz/qCbUU=
X-Received: by 2002:a05:620a:6989:b0:8f0:a3f8:fb2d with SMTP id af79cd13be357-8fa869c827amr1076322085a.2.1777639486728;
        Fri, 01 May 2026 05:44:46 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd06f16sm155809085a.42.2026.05.01.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:44:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wInEb-000000059N4-2gid;
	Fri, 01 May 2026 09:44:45 -0300
Date: Fri, 1 May 2026 09:44:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 03/25] iommu/arm-smmu-v3: Split code with hyp
Message-ID: <20260501124445.GC6912@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501111928.259252-4-smostafa@google.com>

On Fri, May 01, 2026 at 11:19:05AM +0000, Mostafa Saleh wrote:
> +int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +{
> +	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> +	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);

Hopefully I get to it today, but I am going to post a series that will
move this logic into the headers while deleting arm_smmu_cmdq_ent. It
should be directly usable for pkvm as well to achieve this same split
without having to shove a giant inline into a header file.

https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/

cover-letter: Remove SMMUv3 struct arm_smmu_cmdq_ent

Jason
