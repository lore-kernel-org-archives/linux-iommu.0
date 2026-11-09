Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222376;
	b=mn9qzvLLwJJP1OUz20dcWY40xOsK/XxkQtctYiu5uan1dsde8JhPellBkB8wP0OqtKIJ
	 aUWQEs7VLXYj7EgNGQ9yTqcAUHkrisI4/s8fjTEov/nGE3lBUFaY79z2zZF6R7rXsZVOx
	 Nw2ZWkYYdjfKpd4Bvo3ftGQTawBE0mfMY83WhHTeGHkPhSxmav8TcKcEFgpajSlYhYlef
	 pFdyylM91N00F8molEQkU1QbynkZ4NaKc5zI8ClGPiX6imM23gbs7HPFS1qx1oDxc/+25
	 5tP1r8zGiml2dDMSX1YPovv4Dxg100US9Qfo8hMJt4wLYp6QLX19h5KbKYjTu6mjanA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=d8vRIIYl392fLQltvVGdYCiU5psYi3L4CF/tseUFWuI=;
	b=unJewL4dZ8Xf7lTFSbTCTKmgSRYpHjzgdHl7Xbdyy6/pn0nVTZCgPopMAC+rdqICiErA
	 TDweJIdcROmghVn2vRZ1CeJmYHHLXSrGq6E2usUo5i7iA/tHlkUUMnpUezkN7tLM5JEHO
	 YoUn4mWgDHkO/2Voov9IsCOKia3ZtehLLKqr/Fm5jN8h+LdeqJq49AJ0pPPH4+kzsvhCh
	 iIc+zxVIsMqDhu3CjaPL80mWhZ5NZDQPJqF2Ig5Ehe/8yQrkZa1EMojwQQJ/GrSEwaKXS
	 4Ufa+QPrLAezPelCKJ2KDIXQdXS04mdVzuBeLo/4KzxlmcBPsWGws3m9yo0Ep9G9i1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LFhukCQU;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2A606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 11:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA2A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LFhukCQU
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so22875e9.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794222375; x=1794827175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d8vRIIYl392fLQltvVGdYCiU5psYi3L4CF/tseUFWuI=;
        b=LFhukCQUomrlCiEY7J8HM+MWMGjlTYs6uGCCNa8fCYmmkaxb3AcxUk1a9pR6KuY8bD
         UZg2zNavVdnqn0J6EzY0Ld1WLKBAJa9CANpz/VsKA5wBEKM3UZa/rLUQ8OHXQMiW7W6n
         KcQ9q+6sum7QEC4uf+TRKQHGVgr09bqsetl8p04kZSf+DKphXbcM4Qd9CTB2fbO0lGWq
         n80P5zAts4k6aSPPtG35MW8Mof8m/Ue84MYLg/ei3dzUPweXUI8VTBBV7Ec2KSHmT2f+
         5BjH52HdFSFmneAoCNEdxp6dKxlDMOJ9sSrkXsyg2/tkJUN5sZb1SyIACjcKjm0qub+m
         op5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794222375; x=1794827175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8vRIIYl392fLQltvVGdYCiU5psYi3L4CF/tseUFWuI=;
        b=IzgAbCw3j+neBN9QhGr8J4VBw9xs0YdePMO6fNFI9QoclFL9sb/KyVPVWgCXMvg/Ov
         fJOpf8n3v56Sg3uJgOfhn7fIrehkuLHDSpN0IFzsZp2IZSI8yNOe5jjlWAKHotNPsZAs
         Edj1v2moBqAOcXzH8vmHJAi1Al9Lg8zDB6sFN+U2/+TRiBHJZFtRZOCUkiAaX3CsfnR0
         KV/q34GBwgjyIY4I35aV0ATTbTT9wO0prnHGWgaSnG+VStFmb9CYk12nCPbf+A4E9tH/
         GQ4SpP59HqpLRqhud0szZ0hi5qms0DFAhPMutTsPFHg6O3YMec7FwKd6CSJdMW3DAoFn
         AXEA==
X-Forwarded-Encrypted: i=1; AL+hErFXnriKtS+8gEyfwwoB98FgLt/5tyKvZeeDrsGehQoMzxaCO4GIyd6rWvIxtLiMY8VIbiBRcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+YVRByMQBMslmStv0TzL/QhdbqtlpxT7qdT2KQyaIQ3Qcm6bfe
	Hv4cCoOUVg5ge6H2CldswCATmsyfb3VGx8w4ozSUXTXJV2glEfe4IHWDL8p6z0/Fmg==
X-Gm-Gg: AYBFou3GZDYh5iRAtuF10M262JHoNceploh2a2w321lQweOuiUzV83ptPnSUg7Lp0r2
	G4ySdZg5JC/VoX8+/1hnpuFxM17qwXD01Zjb4InwXNyHY48F5sm3duV//qx5752By4SDGotua6K
	kc7HRUrSKmMxbd8CYUI/rWfVLmfScC0zb4eKzOTcUEiV1l3QA6fEVFo85nqpipL7mD+/165ERVJ
	KZN9BW9m3X7o0SBUt4w9ZHesk48IuhdE7Y2R4ZuJWXn1Ncibnz+aUBbJTR1gU216AiehPz5PwNX
	PpWxBLfrRzHyAXt1V31YIySXz/oXIl9INcEZe0j+g9JYTXF363ClQNkf9FV3s2tCoChH7bc1v4o
	Tgb4qfpUR+nwaVtHEt3Njmu1UTlgjMsBhS5TKn8bZ15QCatJ6EwrTwpJqv/TVdwjnryW3AhqQ3/
	FsNMPugBkrQz+dkq3jLezaedzXTcdx6P2hTWcuQkw7G5VtBR0hv1ikeBqfc/8Bw0M77a8FT4gWy
	wHRbCtN1I9oK7JyIQqa/8XUg1LzyTbc4qGpSTrCwaJsbqsxqJKEIYNHjtwioXv4XGqCuZRZRjkt
	OyYjlxEKMn1rc/iCOFlGGd/ggN4MuUxWlkAhnEtaFd5DVjS+E5T5+CjnAfxxCPN04b6VRg==
X-Received: by 2002:a05:600d:640f:10b0:4a2:1912:6687 with SMTP id 5b1f17b1804b1-4b8aec1d290mr1382195e9.2.1794222374432;
        Mon, 09 Nov 2026 03:06:14 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-496c89d8630sm4422045f8f.15.2026.11.09.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:06:13 -0800 (PST)
Date: Mon, 9 Nov 2026 11:06:09 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 13/25] iommu/arm-smmu-v3-kvm: Add MMIO emulation
Message-ID: <avGpIXoiLzncL29t@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-14-smostafa@google.com>
 <au4w8nvPQ3xv7igC@nvidia.com>
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
In-Reply-To: <au4w8nvPQ3xv7igC@nvidia.com>

On Fri, Nov 06, 2026 at 11:56:34AM -0800, Nicolin Chen wrote:
> On Thu, Oct 15, 2026 at 08:08:44PM +0000, Mostafa Saleh wrote:
> > +static bool smmu_dabt_handler(struct user_pt_regs *regs, u64 esr, u64 addr)
> > +{
> > +	struct hyp_arm_smmu_v3_device *smmu;
> > +	bool ret;
> > +
> > +	for_each_smmu(smmu) {
> > +		if (addr < smmu->mmio_addr || addr >= smmu->mmio_addr + smmu->mmio_size)
> > +			continue;
> > +		hyp_spin_lock(&smmu->lock);
> > +		ret = smmu_dabt_device(smmu, regs, esr, addr - smmu->mmio_addr);
> 
> Going through the followup patches, I found this smmu_dabt_device
> gets really too big. Perhaps it can be bisect to read and write at
> least? Something like:
> 
> static bool smmu_mmio_handler(smmu, regs, esr, off)
> {
>         /* decode ESR: len, rd, xzr; width check */
>         if (is_write)
>                 return smmu_mmio_write_handler(smmu, off, len, val);
>         val = smmu_mmio_read_handler(smmu, off, len);
>         if (!is_xzr)
>                 regs->regs[rd] = val;
>         return true;
> }

Yes, I was wondering about the size of the dabt handler also.
I will try this, but that will propably won't cut the size in half.

Thanks,
Mostafa

> 
> Nicolin
