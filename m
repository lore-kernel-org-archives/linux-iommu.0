Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1220B7EA
	for <iommu@lists.linux.dev>; Tue,  1 Apr 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522256; cv=none; b=knzbUR0yHb0J8j7TpcQz742SMTkvCyg5GjHgjLFIVP7R+T2c+ivMYKkcc3Sgk77TYR+zlFmqLtUjwJRbVkvf9KW7H5Ip3eYgF9/e4hSY6wGCOdt5WhG+IwHZG32csSjDdZixtaFfpfpC2RjIRx3dw3liRyClj6c3i+HYVLKTjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522256; c=relaxed/simple;
	bh=a6xhRfFpTxAAJ5SlpRIOnpKIhMU+TA2ntom8u7AyK9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl9CUQpFic5PRJjCTMCfB/v8v2euPXYa3wgpTiO1AfIW53YC4civvndTTlsTEqWzPBrrHOCU5SdZiAZi+NCH+8SdDdYT5tygaG2qHGyU2J5C1U/oIsmkGY0rgzZF6dVB9WuECvo/VFcIWTQy84KUAZZhQ/9t5XPP/8cIAnArTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NairphKM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NairphKM"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c56a3def84so575221885a.0
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743522253; x=1744127053; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtdWsRwfUOBxgsIg+kVSTkMJUa8tV9VXtloNeO/dNoo=;
        b=NairphKMaFBgDCANWP2cdGmXx6GgPdaSQiW2jjObueZkGyoMcR+UZJNhPJrReRWekX
         6SiuyMiXjJHcqasf/sgvxuS36aGaTArNlSCxeVAJe4yqXaEuJK40/Fd5FFiPPvvCLmHh
         DrOxsAc+ITWxU6Tv6FTrrPaeBOIMimStnRhq37AKz8GxNESMExWX7JwjuKGDVdo/J6Kz
         gKar1Tj1V9JSWTjCxIn5dqqTUjSNAxArDti8IujhUn2fa78PrbVsObl7Hx9fKK4v43nR
         lnD0ul0xMXz657xS1XidCr7gg1Og+shKBqYWjdtU8mi828IS9QpcTHONp22EwKwFEhxH
         Rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743522253; x=1744127053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtdWsRwfUOBxgsIg+kVSTkMJUa8tV9VXtloNeO/dNoo=;
        b=ipiew5osSUt+eM9LkyGSgfe7eYiJ++U7CiR45wmmwkYCHvVXcbol+qaxensjgxv6LX
         DU2n3wEp6MPYQzu7AkHICiiGC+o6QqnpQayp5jVDDJn5Hs6iwfmo9gdbFXiUlQ3JDZW3
         +eZwl91cSp7T0ZOR8icrMYqUYFi0xEZ2iTalqeTrijybYtDdrGzO6VkF72hMrCpC8iYv
         OprpjSBGIY3mgl/0+2pIFSUjbL904nzw8czhh1WFbyaB12dC9f+M22r6H3dYAzAmCkRk
         MGVyDXEZeCF8wAi3RCCI8+Tt5ZPnfgIpgmr5bW+unFNaNGMpRmP1SacazGYEzkUsuKQP
         gitg==
X-Forwarded-Encrypted: i=1; AJvYcCXM/OgBrTmWg56KDH4BPrw5LAGYNvzgPR12+dtneYb5iYsaPu6M50jl8j6PeJYiTNvxH4eT8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2a0Nlz2ivn+aE564Pl4Dbm1DdNeMbTVk8sTyCz7Vrg3yUg4rI
	U15OmYixCZdX5ObUhrxrCLLez9Aj0E0Sh087iO+7pCRbi0GNAWAMof0h8BX+HyE=
X-Gm-Gg: ASbGncvUAMAirQ2U8gkQT8QGELIZjQtugLifUFM1eEdG1z+6jVgYnH6ZYgpP17SLSDz
	RAbH/vpwlZYivkLfpzUEI5spyZFwwVZ2dLxoxhG2qvyg1EQYqFPHKs3BIAf1VZLTIxD1FIyr2Eb
	tGhYOlc8yoEhapWtXxkpsNpPNBNsH0PrqrOn6XZV5uLYtHVl3ViRpe5cZPJ0d+em0yIQ7h8XGMk
	V0du36Iv/eE+M+xfVm9oSyrFmCnrs4lgnjheNNL1v6A1lZ680JdLiG++XptM6CbVQCciEwNXl4a
	Y3Z8LfzKCusvogis6ILcmtVU6LrrCUvci1jDvBnisTD+lDwSuI15VCKtMxVDnRMIDC8JXvfBmDW
	f+yZXjq8Ahq9blenfM3kyekk=
X-Google-Smtp-Source: AGHT+IFNoRzI7w1svFEnu6uSg1a7Al/lfHMRAFbRiHbN38KY+jMtZlEEZoz8sPSAU2QwNot8xAw/Fw==
X-Received: by 2002:a05:620a:1a91:b0:7c5:9ac2:2a7a with SMTP id af79cd13be357-7c69089246emr1907329985a.47.1743522253345;
        Tue, 01 Apr 2025 08:44:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec97974ffsm62920086d6.99.2025.04.01.08.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:44:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzdme-00000001MBc-1Y2l;
	Tue, 01 Apr 2025 12:44:12 -0300
Date: Tue, 1 Apr 2025 12:44:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>, tjeznach@rivosinc.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	alex@ghiti.fr, lihangjing@bytedance.com, xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [External] Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32
 bit I/O bus platform
Message-ID: <20250401154412.GI186258@ziepe.ca>
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
 <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
 <CAPYmKFtAWNz7nCDDD7rjGeV2fRBgy5Kt6KR60pEyXAM=bb7r4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYmKFtAWNz7nCDDD7rjGeV2fRBgy5Kt6KR60pEyXAM=bb7r4g@mail.gmail.com>

On Wed, Mar 26, 2025 at 11:26:07AM +0800, Xu Lu wrote:
> Hi Jessica,
> 
> > Is such a platform conformant to the specification?
> 
> We have talked about this before [1]. I think the IOMMU spec does not
> mandate the implementation of 8-byte access functionality. The related
> sentences are listed below:
> 
> "The 8-byte IOMMU registers are defined in such a way that software
> can perform two individual 4-byte accesses, or hardware can perform
> two independent 4-byte transactions resulting from an 8-byte access,
> to the high and low halves of the register, in that order, as long as
> the register semantics, with regard to side-effects, are respected
> between the two software accesses, or two hardware transactions,
> respectively."

I think the commit message should explain an anyalsis that the code is
safe against the mentioned side effects due to ordering.

And a comment should explain this:

+#define riscv_iommu_writeq(iommu, addr, val) \
+       ((addr == RISCV_IOMMU_REG_IOHPMCYCLES) ? \
+        lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
+        hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))

As the naive reading of the above spec paragraph doesn't seem like
there are exceptions or why one register has to be the opposite order.

Also missing () around addr

Jason
