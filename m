Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309928937D
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628843; cv=none; b=Vq5/ljdKWZ+97Baij+8x5wpniN9N0KlJ1vqhBh8MyCXgjoVeZyBku0gY793dgBNcRiyRwR/SoKZr9/DBt6sRC7f9EZrRo05cYkzMF7REzvgY/xXwhE8tp/ShsEJIKh+sJJvEKDUJ+lFJV3EOstN1BSP1o/xIpFn2aMBVQwFxoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628843; c=relaxed/simple;
	bh=cUb158x33akkosvBbXGRgoNYLmW5StrRgcPT7blbiXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4Mng3juHJuER+VNw5Hf/bQ/q7dg+0epmME67PXj6OIu10IkcaLcPzaqXHIP2ToLqxtvTw17VIyqbk71DvIQXNp75aTv1CuX2ZK76PglZoyusnyZ26qvQ35hsTD9yhMjLnK6LMJSW2/ZzI36QjKo1nI0PJeChqHz/7TLSsfoZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GKqDhCHs; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GKqDhCHs"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c9376c4dbaso117783385a.0
        for <iommu@lists.linux.dev>; Wed, 07 May 2025 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746628840; x=1747233640; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hE5pqIIiTRP3xPbQUA3RBdQkSkJonXNdeQ/5U/JPsWw=;
        b=GKqDhCHssGcAfsuuc2vL87Hl6NBd7ROelX3xLKRcucf5CJNnohE1bfjtBcZJLEm/2g
         qdNJnRGriy450JbLCh9o1/mRyhnfvfU0AdGsyi8gueFwT4CAhWGJvjKFJnYiGCtK/5DG
         N4x0vK+rof6zXSCWAfkeQlx+X6WDi9EU5IPcp9M3Rs2PlP8ZDkxhNslktZvx41aorhgb
         wm5u7UHj5Wgc0xFv0pC6MPwcaopmzfiISub1yHwTV2gdO5tV2J1c6WLwbxMxKwBADQso
         CgFB6PIZ9dSXdfJJG83Ppm/Q1dP+JJ1J0yF+T9+DWaptp0C06nMo7b4ucb357sfgxNIC
         wlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746628840; x=1747233640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE5pqIIiTRP3xPbQUA3RBdQkSkJonXNdeQ/5U/JPsWw=;
        b=THsYpcH9w7hKkDMHsvOWa711EoaYAgQl2Y/8fSlBk/3IwpVjk6u+9fAbCYhNMvmXBj
         bA7DXWznXG4OG5Cj82qgmBZAIHk5xgMKKMtKliuaGr3p4WsLV6/4s9QygV/VXhdfYg2U
         t0ZJGVxfKLPXlCRSlf3RKXIHVmBCElRbAyuwTPG9DICLUdpCmYODcrG8YraLn+vZLQRG
         CnsRftBr9n7tzzAUL3TPTDEgQUq4qRnrUkjmI7K59LKSFSc1fjZMuUikhI5D7xvVxtnN
         1of7LajD9UhC5caiSvsLTvdVI46VKpPtF2XKymAO0cQ+iyv/9Edn5FUXVMsANXiWWkIA
         YwiA==
X-Gm-Message-State: AOJu0YxaftA4shM6++7ZN0pk4z/0zmxAm3AQmqAxT7wl+rS8lJLZT0tR
	ftWH2nzu2PSlbGIKCuI2KfdLinzoi7BNMZbdekBKLucUiqph1qmSrf81QIpwv/w=
X-Gm-Gg: ASbGncvuCd7Yu8AbACyyaxRT+Y4WNgI4e4hP2Zbyy0EtVnyRHzcZN1wEQQSu7JPnG+M
	yVeg0aKtcWVyuHEPoBYNzW9IiQcYgaJbdDJuOKNGcLJQhlvdR71q/TwB7evCWzHXCfHxJg4O18J
	A/tCrwftF9XPtzrF4jGPGX/a1CTP1yO6a6AYaGEkhk+OoCQu192FpuzHufQphGTFfaIpgfGhRbx
	MnPKhSAHJrbI0dmE/a0HF7nKHL0/Lx/gTmj5dXzEz+S+ihkc4R5smSBdrc1f/PtMn+Fqn0J9WfY
	X4hbj83N65osfHIJHPWC/XcG6ObtO8NF6yOK8ROuieAMnM2iVZRREfkNCmWO4lOmolFQsyqBSJ8
	YvgHxVzH/eNX670ZnkIxsgFv/JpeN1w==
X-Google-Smtp-Source: AGHT+IFBJ2lDgmMwPn9NZnZ8/xbfRhIS1u/h+c1wZoIdheyW8lXaMbj8dqq9Df2szLQOMYCQifNTEg==
X-Received: by 2002:a05:620a:370d:b0:7c7:c1f8:34eb with SMTP id af79cd13be357-7caf6d53f0cmr559703785a.23.1746628839912;
        Wed, 07 May 2025 07:40:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf752a60fsm159257985a.42.2025.05.07.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:40:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCfws-000000011tV-36y7;
	Wed, 07 May 2025 11:40:38 -0300
Date: Wed, 7 May 2025 11:40:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
Message-ID: <20250507144038.GC33739@ziepe.ca>
References: <20250507142953.269300-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507142953.269300-1-robdclark@gmail.com>

On Wed, May 07, 2025 at 07:29:51AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In situations where mapping/unmapping sequence can be controlled by
> userspace, attempting to map over a region that has not yet been
> unmapped is an error.  But not something that should spam dmesg.
> 
> Now that there is a quirk, we can also drop the selftest_running
> flag, and use the quirk instead for selftests.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Sending v2 stand-alone, since I'm not quite ready to send a new
> iteration of the full VM_BIND series.  And with selftest_running
> removed, I think this patch stands on it's own.  (And maybe there
> is still time to sneak this in for v6.16, removing an iommu dep
> for the VM_BIND series in v6.17?)

You should just remove the warn on completely, no other driver does this.

Jason
