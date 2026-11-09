Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224228;
	b=NL3xFLGLqYwi27vFZtvG3BLLVUyvyTYoko8QkzLm76Km78840rwQM1PUHOFWXfLRDUe/
	 9V7YWb69OlQ7ITgw5tsBZzHkXV0V/mq+m2eoLLYMaf0cWTHiyCDmhc9IWoDBKlOn0BKC9
	 oTcHMcSOzfgEoZRdBEVdoCOe9mHpUNx05hffQfoKnbM393vVK+xA0MG17SYuB8QNVLGdp
	 /6LfJq2L4+IWJQjrj8wT2sTTlDnzVxmItSY1JQEXdnRWTvfkR23Sr6rMl1YEb7N2zaOc/
	 OtAhSIz/AhXeprAcz+d4zZA9NduMYRhsoiP3EzxCGeV02okNOAX/CFqGy7T0dm25GFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=udQqDn88X0b3LP4L0/q7EU+GGttEjcPesqMGbO00iBE=;
	b=t/4KZxpLEPL+SnWQR2EDTKOtHp79RN2C1PXsSTUTS52nqk+5Cn1x2PWwPRW1XvRI4tg2
	 NiXKmplNzCOHw12AaopXu0EvfySi1G3dHm/ul2BSVDsWpbqXl25XJ5DhuyFjvcl/ciMCF
	 RG8VOsJUdVFCkTzJFtImbIlM4ewl8x/eW86PMY0N5+Hm2qxAC9+cz3eph7sh/ABbEqiQG
	 dx2qGyNnEoaADVpyMsoQzIux+p/5ycXkhRNa1Hw4O5j+lI63hT44ejL0WgBYAUl1R9c2x
	 II51xKc0KzwroSQg9cjPQqHjrOlKAdS7b3LYZOySoj4yct925DJXhxoBCGzI6oAoutw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cD92+wZe;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916F606D804
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 11:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9916F606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cD92+wZe
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso30825e9.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 03:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794224226; x=1794829026; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udQqDn88X0b3LP4L0/q7EU+GGttEjcPesqMGbO00iBE=;
        b=cD92+wZe25pBoZwDARzunHYSoV8ThYNdjrPVyCj3G4mtUWlm0p3myAu1aKZ2DTKMZu
         IbMKWneeI0HMR9imPYbwXXRKD/u4kGFDVInhOK80GuwWlBqAYhImCqnVnxr76KnJ/cuT
         XJ49ZQAiJnv8h9djC8h5YZENvyY8zL5Q6/h6OhadEb1tCDh5whIBg/nApEz5csx5qNv9
         YkUp0GHBfeQ/qc/2nxFI3J4F6qSduakMHfdAcfYhx7MCPn3hio9h/hIAXQt5xzMhGah0
         P8k3GJs8qAWMArHDWBphSN6XfGQ9lGliD5yA5dUagcpgOZvJzpl3ECBL/0sEAiqw0Yb1
         /KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224226; x=1794829026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udQqDn88X0b3LP4L0/q7EU+GGttEjcPesqMGbO00iBE=;
        b=Zt1ZmPUXlAhntitsAXpYwyHssZfD0Rgz60dh0SzGvGkLs5eE4J2XrpRqhbSWm1Ihts
         KEECWTC6lypV0PFNkw2Mey4ly6/eDqnRTzURGpIaiBVHYyPTZJUXjZ56pKF+lbTgbe60
         SZUg7vZI/qkNyRkOdgt/zViaynse4ACPwZ85KCE6zGaTU+vpNQp4hrRLRUQ6JccNi3LQ
         J+j0IfD5CvI0kRAsTOZ2ggqwUS1lpRPm3H8bz2eWrfeovJYeM/sFxb4JgOfhVHjqZsdg
         LAVHOONRiXuvRWcrfiz1jPZ0VvZftLfuHewLHCK6pP++3zJ1g8frO1mXy93xJ3Lf6uD1
         gKOw==
X-Forwarded-Encrypted: i=1; AL+hErEiCF9tP8MaaLw0v77dYEtYapq3P8OanFAE9QNZNWRPBMi4efrS1E3VpuTzOmw4atjSko5bbg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Wzj5sqPMsXGeIQCCo5rutBP+tGrS3mlpeaPmxqq46znEokim4
	+7gzCMXF3A6CUDNF+KXQJQ4yJuHaV0UASxhSvtDcgVy8kXR573PRVZmukS1ZvpAKrQ==
X-Gm-Gg: AYBFou3/XtJA8EgSvG9PwFh5vqF/5rS05AltViFo3ZSW3BkX19+BmojbBq1Md02N3XM
	8vAFOHm/hZqFQDtPrfDNVXwRQqYARIaPQ+xp90pBOGYgIjCpHDFIO9zK1oEapYa+ZiC/4+2WMvS
	eomuN8Tf1fpyvvYJPJiWSqKNZAwopWfQzg7rLjuho2GT1hF2eoV7xY9vzffmZB2dZETA+vMouMI
	gmGW3MHR4cw3vGHALzs905nu4qFyegjrtHAhH7Gtna7ClubxJnJ2jiAtfd9oe8vrUP47ggwLVeT
	4REtlZFpHlO3dviNfLF0q0QH73R68eRGvEIhlfQbZFsrToqeoSqvs4wBhRsWTXRzRp6uvbiDkD8
	BMZWOb+Y6wypWZKff42nT7PQGEDy0cY4j1lXWiz61s4KlXk3WMEIPZc4GWwfp0u8cK91BCab2RI
	zF24noQHxK9LMtg0g1G+FINPMJ8dr3/snt2phkpJna71ljMXgjZ6lBCDXBVpMlhhuZncmk1dYGr
	080DwWr/pQaHZ8eNWt54AZA80MsiN4Z/UyyVWPnbP2iVvvGQIx2kE4iIdBYRDyzJCoJf3cH5jNQ
	xbLfWJf2wC+uAP/zcoTsDp0pURFwMBbjSv8eS7EPPRo8hPnk9ITsa+I/90ex0KHJg002cBcTAwp
	KXe5w5/pLI+Th6+o=
X-Received: by 2002:a05:600c:4c06:b0:4a1:eb02:37c with SMTP id 5b1f17b1804b1-4b82056727fmr1353855e9.6.1794224225622;
        Mon, 09 Nov 2026 03:37:05 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bbd2sm134824845e9.1.2026.11.09.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:37:04 -0800 (PST)
Date: Mon, 9 Nov 2026 11:37:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 14/25] iommu/arm-smmu-v3-kvm: Shadow the command queue
Message-ID: <avGwXHSlo3Zj6Fpz@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-15-smostafa@google.com>
 <au00hT6fsY10WJ9J@nvidia.com>
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
In-Reply-To: <au00hT6fsY10WJ9J@nvidia.com>

On Thu, Nov 05, 2026 at 05:59:33PM -0800, Nicolin Chen wrote:
> One more thing:
> 
> On Thu, Oct 15, 2026 at 08:08:45PM +0000, Mostafa Saleh wrote:
> > +/*
> > + * The kernel part of the driver allocates and zeroes the shadow cmdq. Take
> > + * ownership of it and program it into the hardware.
> > + */
> > +static int smmu_init_cmdq(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	size_t cmdq_nr_pages;
> > +	int ret;
> > +
> > +	smmu->cmdq.llq.max_n_shift = min(smmu->cmdq.llq.max_n_shift, smmu->cmdq_max_shift);
> 
> Given this is the cmdq used to run commands eventually..
> 
> > +static void smmu_emulate_cmdq_enable(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	u32 shift = smmu->cmdq_host.q_base & Q_BASE_LOG2SIZE;
> > +
> > +	smmu->cmdq_host.llq.max_n_shift = min(shift, smmu->cmdq_max_shift);
> 
> .. should this be min(shift, smmu->cmdq.llq.max_n_shift)?
> 
> Otherwise, a buggy guest SW might setup a larger queue and number
> of commands?

Makes sense, as in patch#16, it caps the host view in the emulated IDR1:
			val = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
			val &= ~IDR1_CMDQS;
			val |= FIELD_PREP(IDR1_CMDQS, smmu->cmdq.llq.max_n_shift);
Thanks,
Mostafa

> 
> Nicolin
