Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CAE47DF86
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038005; cv=none; b=i/MDNlKxosMQ0TtkWipNsRsB1mCfHQ9NVDPVcrMnXELet5XVlwxK/51XIgYCcrYdNdA507TVACD8oQJEvj6FJrreU2StL+q7Cshc5hOYkrWL+h/+k+Dnmh3vGj4azgW+1p558r/DBxmAJpSUTidFydpn3E8Tb+Ezi0gmLjRrtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038005; c=relaxed/simple;
	bh=fwB1KSWDgCjz736/QRS02PHr1umKh6szh5Kc6lKbPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKxPsR3Dk0L0lVHRzvZDhs1pgm9asqc2lvpzAyzR/hEvVI2tLGaAfqJgP+4N8Ff4heFp6mNEmqG+5RLj8rSdajU60LBk9/01cGLafjKeeiQMqA1St82kLATKJQQfzG1cEIEWYch5D+s9+OCQXUgM+e0qTJ36PS/msmsX3egyY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVq9P9Ro; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVq9P9Ro"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacef7d299so131155ad.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784038003; x=1784642803; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WNvFdxUOXW/A4axtOAxmsZVOINdFqW5S4fBoLOQeKM0=;
        b=GVq9P9Ro0Frpxktc5gtAV42f0/QbpbVJ0S8Rj+Il3X46NemGSZve22EyvLcJ2lSYmC
         vVtkubZ8lmHW4Axuocsmc6eK/CKN/f8D9Sy6+8dz9QVgXNIbPDZHeTh7RFINi+lPuMGe
         nd7v5Y/x4JyoAQJvLG1oD0e1ZsyAlQX+B1UCtMxx9LRx1ocVFpPCR3qAmihxWdNywnE+
         9hFYPurQa/C30QX5vZML9J5TljHj8ooTiK1pfnCSDKdX4UFINDxUgIKrCQO+PA2apizh
         M35UxbHjRQIRA+b+2gym6Ty4K7MtNzqwwiUaOqp8bXm0YNNhZyTaRJU17ey5ywWQbCRT
         Q//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038003; x=1784642803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNvFdxUOXW/A4axtOAxmsZVOINdFqW5S4fBoLOQeKM0=;
        b=Wf4gVvPk74uvtoFiaa4umUvzKK8wfDN5+sWJPc7AHJMrvz6xUskxIvFrkL0HQocbcf
         88rfBfM5CFg20kcMPDsho/evCVPdWzBJiHOxaHmPnYcMO+ko1OoAC3GdXFyIitpUQA9R
         OW6YVMVEHfn7zipUnvQ0qSc+qWpMEDJBUnpvP2jpDqT6nxI8VMcOqqRvC+H5Q/Z/eB3n
         +kwXd+uCNX87EAkIPtDDD1ueg2PJJEBOk7fVht/NdiMxUZH4qKmGBVq4JWFlvyfZuO4T
         hgmmy6dbuD0qafye8wAzdQeNNjO3MxqCN4cb3MHdTY5MDWbkdRkmwnP3p5FgTUvbZ6lt
         JUVQ==
X-Forwarded-Encrypted: i=1; AHgh+RralCJhhMMT6CY4jBClUKAV17Xg+FcatOlU0PDp+GxnrQJvO1heWcih0CCWcIge7pfY/BTjKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZJwyCE/XbKj2v/eeBgDuZIBXPB1QIBnRslaJZXlD0tXfMiruO
	6ZIkiKYyTh5LvyrXIi0V1SFY63mk0YWLhPPhN+0F0DDDlh0vJl2uqo/zR0AcUBwkgw==
X-Gm-Gg: AfdE7cmU8REZ6/eYBXhG6j/AAfR7Sfbr4INJZA9vCrRLKXDPs6bE4YmHnXaOQQ6xz7a
	bX2cfgDKSuGTU2Os8iZoW0Vftdyw9apOwStit0X6kEKjP4H9FruOd6MeoqaH91mdVwQlrswON2t
	gjYgJZB7k5MOw/GlG7uwovrlHPQ8Qi486S1Cfbq6Vm4PbflIlBko7vOA2bdzYVHXy14l+1zmnVl
	QCRPwMjsjdhtY6wzwq6Fpz295x7FVtyAjBLYDeUjdZn0+VYTOflps6ihl7W1O8ygnDKZYAzskmS
	V3+xCB3uJiOX4cGvJooF8PRb08KWDuVh5ZRTS9m+6DQxdp7wBDJVMa0hxj6ghIQTpcuzYlLIDw6
	wsG/vPl7dj3w0tcxVlqPQaWKCf19NkyhbbTQjmOiCcIw5RmiZrt3Le+v3WOP0CfUjHle/mjFWau
	9USuMUPGXTSrlgc1FmG6hBOK9XteNjgASShom9+WkWrFwmpH4=
X-Received: by 2002:a17:902:d4cd:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2cee1663632mr5888285ad.4.1784038002901;
        Tue, 14 Jul 2026 07:06:42 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e16e1d010sm1598056a91.0.2026.07.14.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:06:42 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:06:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: weimin xiong <xiongwm2026@163.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 0/4] iommu: Fix device lookup lifetime and probe
 cleanup
Message-ID: <alZCbIIuawpugaQe@google.com>
References: <20260714060930.220277-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714060930.220277-1-xiongwm2026@163.com>

On Tue, Jul 14, 2026 at 02:09:26PM +0800, weimin xiong wrote:
> Fix a few IOMMU driver lifetime and error-path issues found while
> auditing fwnode-based device lookup and probe cleanup paths.
> 
> The first three patches avoid deriving driver private data after
> dropping the device reference returned by bus_find_device_by_fwnode().
> They also make the ARM SMMU v2 and VSI probe paths fail cleanly when the
> IOMMU lookup fails.

I'm not sure if that's really needed? All these drivers are doing is
dropping the "extra" refcount (incremented by calling find_device)  back
to the state *before* the fwnode function call. If you find that this
put_device caused the count to drop to 0, I believe that's the real
problem/bug. These fwnode functions are usually called in probe and the
refcount shouldn't be 0 inside probe.

Could you share your observation / failing logs where this fails? Maybe
something else is wrong with the system?

Thanks,
Praan
