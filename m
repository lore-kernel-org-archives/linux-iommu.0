Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE239060B
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598697; cv=none; b=EI38dQzOM3FisM6iuFdrQyczcYoiV6gC1rMQE/hqke4ZJiGBhSOJCj5OoPhTzfEtSZvMzgzYNKuQ/1zhJ/Go6ncHIjRxLAcTDnjTHu8UiSt5n3GLdQtD88kpUkcubBegHc+SPBvThC0rhIwtAHXdpfwiGSrn7fzQ57/Ims3lB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598697; c=relaxed/simple;
	bh=vWXMLSbqiyEkH0k1UKJeayzUqXsbhd23PKmYFrT067Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fUPw5xV05yQff6IdQiqmxwn9F9JbwyxoYfvJnIPWhXIHHdBowSfItKpRyA4QyO28+hNv/sUmRoeXhFiEmAzZ/oP/Lce1xKgGXgrOHp3II4GWyyZAOYRsC7KRPlTaGqNqD3345s1N0A0h05/TX9XKkl4Vk7XULL0NustbuyepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n9/pEw56; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n9/pEw56"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-900fa9f178dso612412485a.1
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778598695; x=1779203495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWXMLSbqiyEkH0k1UKJeayzUqXsbhd23PKmYFrT067Y=;
        b=n9/pEw56GaeaMQujClmkcuD2Kqtxde8pCh7VKKEktBZYj2bA1SXouqE0HEtLJrsH/Q
         IQjYSP489IaSh4LEplPfrrtsUTc8iGZbLU5j70oDJCsF04cM3sLtx4Kp9xl/lTUG02P2
         8uMev9wAj0fQj+BvgOcjKDQhVelW3sKBP60Jmo4t30meyyIIXPtGEqTsHjF36bof6S07
         YUVmUlsRdAAjmF0hOtfQCtOdpwcWpbJ85QpU7fRIKdezUJq96g/pQN1z50Qv0bz5Sz1Q
         mxO322RDD9qTHnz6h4EAtPCDWLLA+x2zTzDMIi5WcEYbUpfKLWEi4L/qyDd0iJ2ST+93
         YASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598695; x=1779203495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWXMLSbqiyEkH0k1UKJeayzUqXsbhd23PKmYFrT067Y=;
        b=HzRHGoAfnqkGK70TBTHh/DPfl6cOxTV/SNEPPE08KGSbHqFkVPSH/0hqOlXYtZUte5
         Jg+aD7XRohHGHm2tihAmXgX3JZxuDWNto0+7TlQuAAQ8QUCHlSMwCZ3GbYqF71oWZ9wH
         wAYGJ9wu1pCY20CXhA/q5nPnF6A3ZdPIxZUlZBWeUVCpBUub0oc4hDhSRBoQusG4OD7Z
         1VM7JcJuow+Tdn/W3xLiWOS3TDn0gFcZuE7fHwncAx3iFMlX7TzjlFMHrmdoRnbJ42zV
         vBWtcOZxZLH9fUSYwUPnd14gO6QE4Y6UBw6XGbiwpKijgtyAl82FXaH3VwhMT68SwjNP
         wFnw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yiqc85tfW5V10G6jdRX6nc0iWVyYBSFLGKMv9Ad81FCG9Nda3oI2xPNBBx9x4deb3mIT5cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNLY0f5+xT73rRtb2EFi8G8DUUvPtVQJSsX6v+IEi6Z4KsaRgo
	N2QlBsqD8fM+liTdBSYt6pR3+tGMCbNtLLr7vswznFkpM97Zxe6puq3NrUApRCPaaE8=
X-Gm-Gg: Acq92OF39LNYV3i3nFG7z1VE7X9YFNGK8qZgp4s7SFHl5RPTzu4DhhlEcugqJXf8Zyj
	JrSNDT54e6pmi/j90FG0BeDER3WTOFPHTzb1o6JyOwjpWjkV33qVNEoTAUISHxze6g/Hzz9c9sq
	yWQgkN6cF/VNNDbawEzcDadGX7CsCwCGt1LDUNEFzydF/uw+LGn2FhjKnbBmnA8FfkHB3iZmwJ/
	qlokKgN88c5DF5fNAhe9Pn/blFH15LI2rbWG/thVLjAiT759fIROV1FMJauixeLkV+F5k/fFE6R
	5I3vBqIfBjxMeRYCxLHDrLvII9DdENeczPJwJaZj+yxm8KXpev6SqkoO96C/OjrCNWSAdTNpD3l
	/senQ1VoCv8vmZy5cQUMi9C6xQ+ECheT7srO4ghIVVdi+PKUgq28R6Pxfg3xJkUM6roJeAz7pmy
	AyZphMW0s3dQfNPIOD7DeCPcWT2MyT+s8yt5xOV3xGWdW8S/CUK1KmkYgQ7viTeE8ovw7hWKquQ
	gzpwONSa9atHNsu
X-Received: by 2002:a05:620a:c45:b0:8d6:39c0:e6a0 with SMTP id af79cd13be357-90910ffe81cmr2184465385a.54.1778598694733;
        Tue, 12 May 2026 08:11:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b918cffesm1444739385a.14.2026.05.12.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:11:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMolh-00000000ATo-2WZI;
	Tue, 12 May 2026 12:11:33 -0300
Date: Tue, 12 May 2026 12:11:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: robin.murphy@arm.com, Alexander.Grest@microsoft.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com,
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com,
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	smostafa@google.com, will@kernel.org
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260512151133.GD7702@ziepe.ca>
References: <b95b42c6-4d10-4701-88e2-9991f3773e6a@arm.com>
 <20260512145138.3414002-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512145138.3414002-1-joonwonkang@google.com>

On Tue, May 12, 2026 at 02:51:38PM +0000, Joonwon Kang wrote:

> Appreciate all your clarifications here. So, my understanding is that if
> our system does not support ST64BV and ST64BV0 or if our device does not
> distinguish between the posted write and the non-posted write regarding
> PASID, then we can lift the use of the global PASID space. Can I say this?

You should do what Robin said - just have your driver use a per-device
PASID that it allocates and never use the global pasid allocator.

To do this lightly re-organize the SVA code so the driver can supply
its own PASID, and in this mode we wouldn't activate the ENQCMD
features in the mm.

Jason
