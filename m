Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565230595F
	for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648833; cv=none; b=pFae2PcQXfz/E5l9EU3+XB4yyD4OW7mMfEHV6v9MrJ1L9i2PWliqvyfovomtFdoD6l0s2iWflsQnZo2tHuz+7/t8UQGQHXBV9z8e7c3umcgqryECIbRZ8SQ4tMmNHC1twep9tHTYmhamNNtzeOO0ygdCgFvZ+8LNy8OfW2EbseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648833; c=relaxed/simple;
	bh=KAAq3UD42W1vG9OmM9VYHYbQDySbjL7ySIBoXYb+P6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4BXkGiPFrXD6H2xXNUIR2ZAqxiXdM14m6uuamCj2Gz8lMqpJfmT++IGL8rLH6o7HMzo/Ry23BgYAQNfbAbkFIZdk0Cr5VO48FsJm6kwUB/3VoysH11OS+PgEgfYjRMV5M1NoYlx1e8d86j3TlXigLIVc2QXvcTXPkZ4nysvKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s9WzrjR8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9WzrjR8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4283be7df63so2810898f8f.1
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761648830; x=1762253630; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ciiMP+aVPTGP01jthAKSkaUntJMAjHCa/1wZcaGOww=;
        b=s9WzrjR8LspZo+X9NeRVROTtzCjlsrGTSf099N7UNEMPbNTrQJ3tii1GUAyMQDyrbL
         aFnXt1fV4t1tGI8q+rcZvLZI3iDmog8L87dB5R/3r/CanyAbTcLhI1/e7oNLT7nzFlAO
         XCeJ+SaAXXAGdvrpPgG832vl6dYoNfkUFuWftwAkr7teO/KHS/8ujAnhCEsQNNjSD13Y
         N0V6XXQ1OxC/aUBlXlJB8sONsdRA7m+HZvxhKNy27LAODKXG3ULJNjPWXxeu+bSAKDqK
         U4N9Zi1zOa+mmuMDnlF/RpncKHVf9HQCogNnYz92J0TDs7xb7s5m7DWTNLeIUjMSy+2P
         XNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648830; x=1762253630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ciiMP+aVPTGP01jthAKSkaUntJMAjHCa/1wZcaGOww=;
        b=s12lWYUT/BhyB3czGu3Toz0WnS46Yw6fAi4lg6mqzGMH7UOPAj4EyxQ+cOJc1VLVxk
         XPkWxTFA+7JBKwrPnBSK4kglUrygPUMn4FNBL6HnYUrqvPC4d3ljNhDdUS+K5eFVirQ2
         TBqKVgT1mDDjF6J0M3SZNqMvXTzr064acmfVouccYtEsRxB29ajgy8651W2WaKhbfBQd
         XhXLfUA7Em0q1YEAoWHOeDVREtD3OhPSprUP+p65es9Q4pkQtmR9IO54R7wqeDtMZyvr
         MZnMixU2UTq4+KMTqPZePm33VFBjYUOqvFcB/HJ3gSP9si8zY6Ngz3N3DqI/pJJD1oA+
         20uA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3oqpKzM98DB5/Uw5F05INFs7CUagel3WsSnbGzT9xGQM8CQxIEnkRhZWo3lqOD6GsqeK3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCJmqSTLRHdqtTJIdXz8+qoT3COqoT2Xvsz6/8nmirdFGSwmeM
	tGy8Uw66qIEIw2ZTSq5ssavpQVfcxWaPPOOui9OnvKFvVODKHQG4Xxp+SesK3Iu8dGs=
X-Gm-Gg: ASbGncuyXbTkA+srNHFZLjEM/5+LsuqgsXyytjqXbQwD0g8WQFCenkMI4cqPSb3mg2r
	A+3J6C8oPGZCkTAMo6PA93l+8ZLEetvEOi4llF35RFtw699rLCwJE8DCvEwuouKFMQ0NEAaOgYm
	TITSPN4SOupiuk8vzEPC+XJizQt1v8aDAtrUi+NXvi3MVdyZuwvFDrSKqtCKtsSKo1rsCj4MJUB
	+QbfTj9x9jg2E8wjpIQlM/GbmHsVAet4WUzyikxVHSQwl2f6va2jnQTORL8XCojfglX+k3uNljw
	N1vZakNU/2ryB6m3O2wIgQBKPuU1Tzd6mtypfNa3NtvTA0vLgXbl5M29mrJCiWL6Q9HMP81nErA
	WMNlsqHpJUR5E8Wz2i+6BmaF83LbeMx+qa15Av75PIYcW+gLHVWJiqiPrwu34hWXffGrKBdxquS
	aPhx8cdf+Go7sP/F3m86jR
X-Google-Smtp-Source: AGHT+IGNt3x1+qvnQdvPMrB8YbMOh25mEuFQD2Py5L6FbHFNPHpPfAZVVrBrzGdO5MKQniNEUyPgGA==
X-Received: by 2002:a05:6000:26d1:b0:3eb:9447:b97a with SMTP id ffacd0b85a97d-429a7e8e222mr2559278f8f.54.1761648829920;
        Tue, 28 Oct 2025 03:53:49 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:7f41:186a:1d61:ae59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e21sm191479545e9.9.2025.10.28.03.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:53:49 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:53:44 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Enable use of all SMR groups when
 running bare-metal
Message-ID: <aQCguL11h6oa5Y4C@linaro.org>
References: <20250821-arm-smmu-qcom-all-smr-v1-1-7f5cbbceac3e@linaro.org>
 <aMAkJ7CfPQuhvhfm@willie-the-truck>
 <aMBJNzXpQTMg4Ncs@linaro.org>
 <d73e5026-ccb0-4a19-9742-099a0443f878@arm.com>
 <aMsJHheI6Y1V5q74@linaro.org>
 <aM0LZVudBKjWuVrT@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM0LZVudBKjWuVrT@willie-the-truck>

Hi Robin,

On Fri, Sep 19, 2025 at 08:51:01AM +0100, Will Deacon wrote:
> On Wed, Sep 17, 2025 at 09:16:46PM +0200, Stephan Gerhold wrote:
> > I realize it is weird to allow non-architectural features like this, but
> > I haven't found any indication that the additional SMRs work any
> > different from the standard ones. The SMMU spec seems to reserve space
> > for up to 256 SMRs in the address space and the register bits, as if it
> > was intended to be extended like this later. That's also why it works
> > correctly without any changes in arm-smmu.c: the bit masks used there
> > already allow up to 256 SMRs.
> > 
> > What do you think?
> 
> Although it's all pretty ugly, I think we really only have two choices:
> 
>   - Teach the core driver code about all this and use an rmr-like scheme
>     to leave the upper SMRs in bypass
> 
>   - Hack it in the impl code as per your patch
> 
> The latter option is probably the most pragmatic (especially considering
> the need to handle the virtualised case differently) but I'd like to see
> what Robin thinks.

Do you have any thoughts for this?

The stream match conflicts that happen without this patch still exist,
I've been testing this patch for quite some time now and have never
noticed any issues.

Thanks,
Stephan
