Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA22C15A2
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842216; cv=none; b=dypoyT68Gmr5zTm+UhR1Cz6DGovNH8FqEb3NE3+GqN4QtTvIu5WlMvZVv8UQQsE+/FaI44bMLVeZEra+31H+QBc+sTvCdhSgALFRj/pUytTqF1FdrGCfZeNG60s6YtNrnIJC/3CDFNsk2btJZOPdQ5zfIM3Nv/5Rf/oKbRMTNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842216; c=relaxed/simple;
	bh=rf6zLo4HMSx3jjTOpNOmyUHF2Og5rRAkebiZTxcDcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHC8cEyOj1S8hwziAEQGFwd6cUSpR+O69kScrBBp3++5QTXrIitgFPigHYdBT9hsNoRXBz2OjnVhTInLM3lL3mPxBsEHIAtjMdk+C3oNLdANoljqc4bb45fEaa77FDex5VT9ttW7EwgHiDnQFhWdwtoofe3RIF/SAaB+RoL7HPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=etGEmKRh; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="etGEmKRh"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso2732388241.1
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768842214; x=1769447014; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPF37M4OZRPT3BtJHYXM5EEOm0b3fHdtNnzMGWb7xcQ=;
        b=etGEmKRhp/a4Av/U5IqTruxF2Vwqnvo3PDrIXzeewfsAVuWavSfSeamH/NjCyqrvVW
         8Wr+cnY5nplEg1J06noMDABA4+kKJ4mwoV0IfUQQJ11Gh5Lvwrlcw0rGh0w/NZYCH1bQ
         6cRzsdAJy2Z/RLdIYVOQ0tWeohlR4Bhu1IppDtyEqI7QEz+C1q7KEVmbIBQEc1qckGfM
         wQ1PKiF3RpJV4zwdbzEpISMf0o5iu6vBMo8bljL7Q8DI9v2eiTGoqFLoRbS+6Ikb8zyY
         R+CuweR3Hw22swS8YuLsWhXYIpwIYO9yB5+G1glLZ/XSyPGSP6TfuGCFBmtGz/2pAosJ
         74CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842214; x=1769447014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPF37M4OZRPT3BtJHYXM5EEOm0b3fHdtNnzMGWb7xcQ=;
        b=kIwc3boUN7Wcw0BgYcEBQNSnCO06wv70/qGmqL1XDGwjiC2NUxLc5/u0haO5LRj2fb
         4cOxIfScjo3oa1egC9M+6JF6w3Mx5EGsdUYE39rCc8wK1Am9dW61j+regxPdH5LGbPMF
         mlMZhT3kh+Rl9g+GEt1x/ZLEw0aX9givAi8jZazF4LefhBTWnAQwAKHjo9MSdN62v/55
         RztlZLJ+LCaoVS4hmvQ6DzSSPFZ6ubOYzycg7Iij0nt94cFl5ksQ2SRjrJcTYQcr8lLV
         xry2C6gT6/1EXrn9z4m5ERkuNRN9zdAaCARJPufhUFyGdNh6A735XBL1N8pOskd0nDwe
         y1gg==
X-Forwarded-Encrypted: i=1; AJvYcCXzH+//jPwRrrTkFVFSQNSjMPxs97laUAr+Wko9Z09e+8eBCVQcTHf4TwfDGNwrLFcqzSy//Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6w5W++4Tr6x1kz5Hzbbjx8mn5phtgInGkgnZsp77U/lK+GnPW
	E/S+3A9GzTqrwcRhtmUS02CkqhadgRt/V8ogVXAIkcrnK+91KOmLCIKIJdX4ezeD9jA=
X-Gm-Gg: AY/fxX7jlzwyIZq8kzoWXZyJRpvGdQM1R03ekIBJmM85HjQO9KK28l+lwTv59mTCw1J
	6ga0/jY5pEIlD78WZhkcEPw+pocME+0V2sb/+6tIEhbMgrUcDrcOcAxOPYAmAPKgA7WosrB74xF
	z60ru8mh9mCUuWmo6naA7jGWNNLiRrftynp38oPDtCMv9jK0OhkJj4lHLrjGl5WYjm+OH8jOVCs
	kYxd3bGOnY3Q+VskMplohN3aJiDhnrZhLiFI7QoODLfBf2us5BAYwp47Z21hpROPGOsLZ+Xzu5L
	W8ZF6EjXX+t4rZ0hTCTFtULxkLWjXtZwqDpbPTLtJbtllUYNPzazxwicMC/bjYk8IspxV4j+xoU
	aDW/JbW/XNPEfi8vE0NBpwwbO1kV3nQ5fzrKJPwHtG3xHDPeAQZpfvuenoDK2ayzHF9DSy05vom
	ViA8ZPVYb7QbkJ+qzdPOxoXLpmdJebBBeqNyaKgtUCcg3FH7KLMYIHhy5+y/W+3i7LE3c=
X-Received: by 2002:a05:6102:2ac9:b0:5db:d07c:218f with SMTP id ada2fe7eead31-5f1a55dacc2mr3505780137.40.1768842212920;
        Mon, 19 Jan 2026 09:03:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6027c9sm90833946d6.13.2026.01.19.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:03:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsf5-00000005ITl-3vB3;
	Mon, 19 Jan 2026 13:03:31 -0400
Date: Mon, 19 Jan 2026 13:03:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] vfio: Add pinned interface to perform revoke
 semantics
Message-ID: <20260119170331.GJ961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-4-a03bb27c0875@nvidia.com>
 <bd37adf0-afd0-49c4-b608-7f9aa5994f7b@amd.com>
 <20260119130244.GN13201@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119130244.GN13201@unreal>

On Mon, Jan 19, 2026 at 03:02:44PM +0200, Leon Romanovsky wrote:

> We (VFIO and IOMMUFD) followed the same pattern used in  
> amdgpu_bo_move_notify(), which also does not wait.

You have to be really careful copying anything from the GPU drivers as
they have these waits hidden and batched in other parts of their
operations..

Jason
