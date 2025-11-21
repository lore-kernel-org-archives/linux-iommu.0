Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66B2BE05F
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754101; cv=none; b=Q1Eq7JtxT7espaJIxkRwTPxoM7oQ9vgipe4g2nu/iM+Ck5bcdxXGh2X5+hd/jCRwHJ871QAZ+OZ2lcJU9u9RHLPNMUqspPsR4KdWXN7fVXg1qycIaFAk61l6+wB71gVU9syGJ+f13CK5yrmh6oLoC+454HufIoDvOjR5rYw1cI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754101; c=relaxed/simple;
	bh=/xngWsAkOy9HobrmWI3BC7n9/5gjXHqZsjIulE6+O9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLkPezlPDA6/y2geFq5EEFEaPkB4n3hWw20qAiSA+BUYc9QGCvkBfVLhTj4/gfiR5Nn5RunaHOZ7dJ5OR1UaAzpvRV0YL3/FaMPuTgpfE11N9y2X2FNG/NFWbE8Q2RQTQW98E3+RN5DH4w2tqY4fgsC9/Su2C0ZzR0ouRs8Xovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=opqrMpHn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="opqrMpHn"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-880570bdef8so27143356d6.3
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763754099; x=1764358899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leQSmYI6CaqvqUUCRW9PtNRuz9kC54AWbM2rvpXiyIU=;
        b=opqrMpHnrLcwyek0kfHPCVdBqcMH7T/HRmpJwykllF5GGLZ7gOLzlS7iDtMBltYYF0
         qAQ+dWlQ6N8gEVo0bpmnYgJakWJcWZiMbESTPQpwd+kmA0bxvVcEGMuyxqdXonc0Fm2V
         ZaRR/+B/UvzkF6SA9X0Uz2dXQZmsFFkeSy4OlIOg19Y1R/on0JkRxbAo5dTstRjYJI25
         vc3DmPDMlLDUiCnR2VU5JqUVUGyf7VqRcEMU6cRj9OAejV62xFSsspXS13rXy+CWiwLj
         x6QW/oJyCTpw7FePsXk5kV+Fywrjav7gMxfdJxsKh5Yx1Q6zreX+XK5btagvEGsYJ8TC
         tKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754099; x=1764358899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leQSmYI6CaqvqUUCRW9PtNRuz9kC54AWbM2rvpXiyIU=;
        b=lumABbWBkjFnznFme+5fTJawwb7foltt/K43Zozj2Q0mbJGUDLs6H63aY10Hz5kyll
         nzisR5C6jcFEZT9ltQPBno1Zsyez2VCgpgP8lHfX7EdiY+WCXzeZSiMXFsru6Se1Ck1q
         a0jqrMNVIIc0uB1awII5DKfYtFc0IWl/mffO5mruG36f0PqhWJygRfJwIFi9O6JKFm/S
         EeNoDlxCXsem8qCXKU4egUtpqRK2AzVu8dFd91BVfR0w1UqEGR7pIkgznlHZT7AdFuEb
         3OFB2D69mjvkO0MuCdX6r0orYPJztqR+RL/jCCwDLYNJXjMTW+fLzjBZo+vpPYXJipt7
         9Xbg==
X-Forwarded-Encrypted: i=1; AJvYcCVuHIZ3b+17jwCJ2/B/C4ixOBAsAoOkI4rNpq/l7k+9C/iKEUHUsuesud+iDNlCgk4fmx385w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuWoaTvys4FGWhN3bywBq+J/nVw1WYcd6sU+/rhAhKt1Z+whcz
	K7s5wPST+y9D53GMKJYSJHGD/hzlCQIVxa1+IHqXnCw+zzq4XImVgfBYL4jsq742Qq4cgxFI3xI
	1yPlX
X-Gm-Gg: ASbGncskQlUf2tkt2+3lfE4IO/Z2MAG3xpFy7Ggt8Aw6QE3qx/V5rgJ8StAiHfESw6D
	hLJjsDjuqAbCCNP/mVo551GN/MWS0GCSa14jpASVtEcDOD43svuGORFYE76lfQUudTvx7Px9Mwe
	RXWgzx7craa+Yrm2pWB5Vwono7lmjPgPNQAtd+nvghDgwFyR8CTxgbxRRuwSxw5VARJiZ7y10pR
	D/iWPKntO2xmLRvRVmVXDCGhnrEzQltXkI/Ig3qEokypd5IGokHAxZnTyVQ6s6BxApyv1CJxDho
	sHUHXd7ShMchehuj0oCu1urIT19dUQI5khOPuN+FOLj580xD7+Qbur85zgtLlpFLK4sqqQu7dZC
	2U8mX8LzZTs1cTax7vSub/g9bbCc/7UL/IGShiJvXsjKfheFvAg6cwvsSSLTDVVDZVnuABg6//K
	u0ULNOpLFBYxpClGnRTdnGN1hjj5acyBAMZNZl60EoTeT25edJBuD8fms6
X-Google-Smtp-Source: AGHT+IFYiwlmP6Q1uBxpUaEOynP+GjSDM52BYOjVNB9E2WPwnPj4mnle0F2KVfZAXkj9LJWK5a3vYA==
X-Received: by 2002:ad4:5aae:0:b0:78d:be82:fffa with SMTP id 6a1803df08f44-8847c5482e6mr65937506d6.33.1763754098808;
        Fri, 21 Nov 2025 11:41:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e469825sm44534696d6.15.2025.11.21.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:41:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMX0j-00000001aQ0-2Qqw;
	Fri, 21 Nov 2025 15:41:37 -0400
Date: Fri, 21 Nov 2025 15:41:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20251121194137.GE233636@ziepe.ca>
References: <aRHOAwpATIE0oajj@kspp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHOAwpATIE0oajj@kspp>

On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that struct iommufd_vevent is a flexible
> structure, this is a structure that contains a flexible-array
> member.
> 
> Fix the following warning:
> 
> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied thanks

Jason
