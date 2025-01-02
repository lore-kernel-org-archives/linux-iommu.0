Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90651192B96
	for <iommu@lists.linux.dev>; Thu,  2 Jan 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849115; cv=none; b=Y5WrFvF7GmB3dLzz+GGUEL/EURYwxXX62XPQuw3jH/f81/fjyxQTtqYcntCRstTUYgyNfOSCyKcMO4eYKFm1BacPjsNPe/jRXeHTjmgsp0thbPECXJL3YGI3H/hUNn2TZZAtlg3vI9QF1U9GiO0Z8/FMBQszopObS4yV+D3lCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849115; c=relaxed/simple;
	bh=4e1IdUvGapScSUpgK7R6llp+8eAfEdh0yOfh5Obu5/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agJj0iTJGzLq9FLJ/eMiGoI52hTtflN3erBGtwHDoSXQXZY3BoosWLsbMaF77uOKtsmtn74CNTwQ6NF0PvztthHb4wXDTRQI//6nAkXGQ4gy2SiGg9d8yAPiHv58XtC22rjr0RSorth7aivW8qYKvG7/2tSjdFV6hLMALLy+O4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kMPQDZLC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kMPQDZLC"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46792996074so114953281cf.0
        for <iommu@lists.linux.dev>; Thu, 02 Jan 2025 12:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735849112; x=1736453912; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4e1IdUvGapScSUpgK7R6llp+8eAfEdh0yOfh5Obu5/E=;
        b=kMPQDZLCKrLiEYmepXWxkJF7vuDJhl/aRjPxXnCQ98ey+3JCawZ0s9Dmk92qjFvAZk
         u9/kMBnMAGrTVs+jIfePMTFuvQlaw9Z2wwDAqkiXTIbDj/fi6H68OGyTy2nEJgY4d+Yw
         C8cEjDA5skbP5oLq8V3AUDXYPYLIxr1FkEq3WJBRTRZEsHtSVBU7yFphExGPQY/axkXH
         UfXDXQ97vQy3ogLbh8zzTz5y2aj9ur2EK0eJYfGJHiy9/BwU1CAU5m3pGrK+zs175N2V
         DY+rljaOQOpXZkTC7KPOrCB2pAP6kh512YIuQDj+Z43XcQ8oByAPpyf0utbYNn3bNcpd
         aiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849112; x=1736453912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e1IdUvGapScSUpgK7R6llp+8eAfEdh0yOfh5Obu5/E=;
        b=tvTjlQCiYK9d2/5ZJ34UGGan6Z0A+KoFFatJrf48tzDHp3pT3QxZZipR3EqeaYd1JR
         4+ewoFHL+fWs1Wyd40Bb8ZYAOYIBYY33qLddgnDiiPxkR21U2xq8rekR713lpElLQLft
         YHSUvWntc4J9QjpEwg/PB7xCCFxBHk5w0zdjQxTNRQZGGFrWhcBi4KJMkEmhqxuChSIF
         75Gjst+mxtrlA36Z0qsb+E+jaEwqxtv8PqP+O6aqT1oGncnLZCUGaOzxmoDLp1edbhuP
         c7N2W4l6ZN9n8Wx3rBab3FhL0DLd0eX5hi4XS20YTV66Vz9F9/w2tUuHsZmTV9JOmO4e
         F+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoevuFsGRVKxFVjAkLZZiYOJExL7Fmn4Egk7Ajl7hIovsXWOlDv72eb3H38opRMs7ZbBxIlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8LDOKBd/yfBwGL85OVU7RrlcI+L2e+JqAnmWyWc5LlUUob10f
	W7TYd09cUydu8dMxHs3kgfZkQnh9Tc7tbXLkvVcDlTA5Lyro7dNQtf1f1sMu0rA=
X-Gm-Gg: ASbGnctiETB0rD/9PqqQToh2VAAAm5DjdSAgY89ZLMx6tgBXjAOZNGMG1VaqPc7aliz
	+3o1Xv3hn8uG0kJoNbTbrhUPJLGcfiCYIAmiwEtIhP9CZugBvLR17F6niXaVdU9VJuAUHRGlsGl
	JZwxF6CLmCAp0LlfXoRXW01bn+CID62h4/2GLruq7Se9wQJfGZfy23GHkI+9REqmH1uiUJ5B+jW
	e17E8kOOnN/W7bqo7jyifKJn5kLl0Mr7lb30317PlYo4hlsOXZm2wquLNg8r0vHo6koHr7fXv3I
	lqx8vUXDyO4qeKZjMSQ5+Scg+di12g==
X-Google-Smtp-Source: AGHT+IEubZlgbIa9gMEMKah3ttFKamsGoFQpk1RjIrpqZNlNGIW4EdOxYKL1s14UXV0ZPoQHIA67hQ==
X-Received: by 2002:ac8:5d02:0:b0:467:6461:e143 with SMTP id d75a77b69052e-46a4a8efe3bmr794078931cf.33.1735849112516;
        Thu, 02 Jan 2025 12:18:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46afc4597d3sm21460311cf.50.2025.01.02.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:18:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTReJ-00000000MFl-10vf;
	Thu, 02 Jan 2025 16:18:31 -0400
Date: Thu, 2 Jan 2025 16:18:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	robdclark@gmail.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com,
	tabba@google.com, danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 55/58] drivers/iommu: Add deferred map_sg
 operations
Message-ID: <20250102201831.GB26854@ziepe.ca>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212180423.1578358-56-smostafa@google.com>
 <ce4c8db4-4895-426b-8d9d-97dc5d74fbc4@arm.com>
 <Z2Qshft8lQjI-x7c@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2Qshft8lQjI-x7c@google.com>

On Thu, Dec 19, 2024 at 02:24:05PM +0000, Mostafa Saleh wrote:
> I had a quick look now at s390, and it seems a bit different as they only
> notify the hypervisor about the iova range being changed, and don’t need
> to provide iova->paddr mapping which pKVM does.

Can you explain this statement some more. It seems strange to me, why
would the pkvm side, which has it's own page table, need to be be told
about the iova->paddr during range unmapping requests - and why would
the host/guest side have to unnecessarily store this information?

Jason
