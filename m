Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D2274B3B
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661907; cv=none; b=LvpgTfi9JDe+u9m7OSMUB1GwDFOPxNLZh4X05OmTxKNEbUTcm+pPUs2xw7hOcjcb24h8PjjKuiCfApbTVCzxIoCi8xQh81USabRtzeaQbuEDNDGX0xVpa40oG3CcWDKEB1r/zZWbug1nkmJ9fqQWgOhTtfZSsh2ikReRkULIZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661907; c=relaxed/simple;
	bh=7QxghaDm861CKYRDD8kHL8SgeDsapiSRzVIH2YrlMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmmAPL4WP3cMUIYUpJOY+3gCw3KNOdtwseCvYhb/8Gg2NnJTCPwXH4tpnOA0poeYkBofSQmqqmxexaFrqt2WqIRPcwP2qN5qJMBfSPTrK13cITdfOYwy4Nv+L8P0K1hue18BlmvPdc5eRQopCcL62gGIHEfuR/NT7yodz6TX1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=grWA8b60; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="grWA8b60"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ba3ffd54dbso61959885a.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767661905; x=1768266705; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0M6wACUwu7ZPlV5A2pQScdlqF/ktZzTx82xX4yJbmJQ=;
        b=grWA8b60nOSm6T2Ip9v7bQYmYrsyDz25Aw0kBG+cWp5pTp/FKTzJgHKUTM50PPoD+8
         wQny+iBPQj4aK57oYX8ecUGkDVhQ4r/Z45ViY/Ie1jitfut1oJciYqkkS/hF/sNmRsdH
         nUsItyHoxqakhjqUY9nxDOQcMosS9H0yp/g2KoR7dftuLVooefudx0hRnWnV/ktBaUHr
         QOmQs3vxbuG2gHM8rxTQFzrAcQnr4DuOF/cbQ2CUcEnjOJDWgnI4NGh3oK8avkfXTEKj
         b9ST8Q8XJdMly+J4kLfdsHj2djx5ydp94abLE4BnYPnzI0XtXiyMKEjs6uyppcvQJLRM
         jagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661905; x=1768266705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0M6wACUwu7ZPlV5A2pQScdlqF/ktZzTx82xX4yJbmJQ=;
        b=dP+bLIpjx6lJvIVJD2o9+HVuqVnmIZyoqykMSs3yVIIZNJisGCWIKKTMknhDI8yrHD
         lhArDsTYWm/3WtDrqwxeRAFQPAIg/NUojqpJALS5TFtl35wh0+HxBQ6EL0r+8f5V3Swk
         u6K2CNnI5Qzt19J0+jkaHNveKeJTIK3tiYnc8Oo86tZ/pPBbx8FU/t8kATj/U+d7vRNk
         pJCEipEwvyLHjh1OZ0chkoYj/qd3lqekBR7F7akBmzL0YZt/KbaYnStmwfy6JVO1ILpT
         uH49K/RPw4G32m16purm8pbU2g+UVYk43g5acplRnb0J6d5q7uvo5nwf5ui1U/jYEAJu
         TKyg==
X-Forwarded-Encrypted: i=1; AJvYcCV7iaIT1dxQNn/r01KITmSi4hT7CbzRXrAozYhoIoQNp6eBcMkAp7tAudhr9yXnFEtyzjYKiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1oFINYgZHxkyA9+8eEhZmLjQWtEAXfyvQeg2cKNh1WU5JOwLJ
	Z2+BufbCpXrZA1JDWjpeHxAheT6ZVlEh+E83UzdA//oHefdN9oK2969Usi1Qn8ybA/1rX+NtdPl
	Hg/jy
X-Gm-Gg: AY/fxX4atUEJkVKDQnAZ3TmUynS0JcHoAoeDj6cUC/dHWM2y42R4NJSe7fWvk7SSE+8
	qIQLxYaQkTQoRXOJck+FSX9ZA+4SWZX/r9YiWRcR1F1dMqHu0Z2cgJI16Xu1zRkDfalCR8MX+2u
	zYnnmFm7vePBiQV7yomx3LkmmqTxoKjnHEanyVIVZWMD8n9zSAwu7o5Yz5BKd4PnfU8TRtWM0lD
	6M0YiImZACtoA8dHf0NxxTdJxNzBIuSAYKRU+vd3VV5sTAncLqcBGDpfw0XxW7ReE8ne48ZKcY4
	0Hl2zQbJQTM8ZKZVhM26+Daa+7ibVLwH1yDOmXgss0zTWzFPztLhFtP1igQSQn7rhvFU3FFTEi+
	ab7rHLiQcjz6EvNF7/U7HfW/zF7xQEv9yqFAIa4m1eSkJxuSxq9Qcw/bVIRPMJ0fStBxr/T98mj
	0hNTQKKdKVkYtlicQhBRvK5j4qBWFA7FtH8VljEYMb3zoUPiHO8tKTQpjkh3zm9UwQXaU=
X-Google-Smtp-Source: AGHT+IFxbvXmsKhVoiNfeU0gqUSCgEVUTzTPmXjaEEUemMygzC5mzPD60qjzhxEZyV6lPJlPXUhCBg==
X-Received: by 2002:a05:620a:7105:b0:8be:e044:8cfa with SMTP id af79cd13be357-8c37eb8143fmr221733485a.40.1767661904885;
        Mon, 05 Jan 2026 17:11:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4c964csm67177785a.22.2026.01.05.17.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:11:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvbr-00000001Ecf-3FnI;
	Mon, 05 Jan 2026 21:11:43 -0400
Date: Mon, 5 Jan 2026 21:11:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	suzuki.poulose@arm.com, akpm@linux-foundation.org,
	steven.price@arm.com
Subject: Re: [PATCH v2 0/4] Enforce host page-size alignment for shared
 buffers
Message-ID: <20260106011143.GP125261@ziepe.ca>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251221160920.297689-1-aneesh.kumar@kernel.org>

On Sun, Dec 21, 2025 at 09:39:16PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Hi all,
> 
> This patch series addresses alignment requirements for buffers shared between
> private-memory guests and the host.
> 
> When running private-memory guests, the guest kernel must apply additional
> constraints when allocating buffers that are shared with the hypervisor. These
> shared buffers are also accessed by the host kernel and therefore must be
> aligned to the host’s page size.
> 
> Architectures such as Arm can tolerate realm physical address space PFNs being
> mapped as shared memory, as incorrect accesses are detected and reported as GPC
> faults. However, relying on this mechanism alone is unsafe and can still lead to
> kernel crashes.
> 
> This is particularly likely when guest_memfd allocations are mmapped and
> accessed from userspace. Once exposed to userspace, it is not possible to
> guarantee that applications will only access the intended 4K shared region
> rather than the full 64K page mapped into their address space. Such userspace
> addresses may also be passed back into the kernel and accessed via the linear
> map, potentially resulting in a GPC fault and a kernel crash.
> 
> To address this, the series introduces a new helper, `mem_encrypt_align()`,
> which allows callers to enforce the required alignment for shared buffers.

This explanation makes sense, but to maybe bottom line the requirement
to something very simple..

 In ARM64 the guest shared/private granule size must be >= the
 hypervisor PAGE_SIZE, which may be larger than the VM's natural
 PAGE_SIZE.

Meaning we have to go through an change all the places doing
shared/private stuff to work on a shared/private granual size. I think
this is not just alignment, but allocation size as well?

Jason
