Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92E3D349A
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442140; cv=none; b=qPkKRqzUHWJ2pcrfS6M1/5W/QlngpG8cw8VZCChrrWUMSSaVQBoUbs1/VdTt3o2mHw6SvwNOF4wUqyrwtWvJeWknpVgBqk+9wECfLvZgjaVOnkgrbnIlQOcYw7Nd4O4YctuyqQXfptdGNMO9uQSwJjSYvf3ocUipVb8COYbGW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442140; c=relaxed/simple;
	bh=N4emNoFTYG3xPp4JxkTQL6Pnqg8ugTJg4RrW4cfKB3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPcwcjd8AxmaJ9E0DbT0M4fqxwkFQXzmdbGMlpC2Oz9ncZCN4xaI28ac7rJBr2nPkTotzHcVAFXmaVGlQCS9pB67vLAz/yEGfDK9NnLPBPdW0DKrHMOikoFdUXiBO9v1ccimlOhNw/nTJLVjwZLsuT+uHOUIo77fCJ3X66/xkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H2PuIy30; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H2PuIy30"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899fac9caabso27451126d6.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774442138; x=1775046938; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kX9NQyLC4UDORZ63qgYpumbaN43imiei1/pb2zwHVSU=;
        b=H2PuIy30Vh+N68/6h6hBBZDLSv8o5IFRjhLhpZ+2exRkDBWJnnbkVnL/Bv4uW3+0jZ
         Ws6QyccgblH3CiJ/kKEKFPheB1pSStc3nfHMEv5fOpDVvdNkCfXTkWbNr8FHFeHJNsE5
         MDd9je+XXCR9p67IBbSevdeUAKFtsb5HlhxfxsM8ZKteHIJcyrQGdsJhSCITVWLv04ch
         wUhSUsHtKhxi8rEAXc1EZSLO6mnynwzywtVf/dzha95u3qoY5D3gMp9GQKfX6q3sFg59
         ljjXaZfhr1he9/hOIs9KECP9tAMsMOo4NAYEP2wMS4a+Xx8o6aRG1U3LNISy0Ehw9hDR
         HTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774442138; x=1775046938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX9NQyLC4UDORZ63qgYpumbaN43imiei1/pb2zwHVSU=;
        b=Bmc7s8TOYQ8DSbk+nr4VXcImI8o0B2s9qP/yxxt9QO5Igd1zjoqz5qlns0jSppC2cC
         sB4M1Ihd3MNlOTmOEqcdBzzHXszwM2kfPmA8RzeQe3k6AZ9QhLG/Vg8QynrTtMOWOnJE
         U1jRl6nb7wsE+O1NsAYRHboVvl10ViJSElfmeayAUdu6dZWHA5q3o+kIr2GE/xGQa1hC
         yeKRdzxhhFnl6Lpr/UxZi4/WDBuwBZoS9YK6ayxmLEtletlMBtF15loizOl4L7yORQ/P
         cqxAqrHPcKnIvFZXFCKgHQsyYW7iwbQWqSz6b/bLmWqSkNmlOtmVvC5gFeVTQMJoCVhp
         MMbA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Hib2G2rwGyz8ADxIRpcNSifaxV13TQ0zKnmVCc0kPuuHs48exljv8Pwsn4gpU2X17kWKKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ9o/0EXRCPJoO8JYLSaAGZ7hE1n8ZpljgGld1D6BHlCkiDhxd
	LBhpX8wmTUngHW4GodLkPrvKxIog7uzdDrOTq0V8aWiPLu5JE8GFh7nHSU1SrQkEx7Q=
X-Gm-Gg: ATEYQzzmtzNicLnZQvkhR8HFx+Ru4fG/J77r5ObxWUVlMboppTm4pNB03B5KgSMOC/V
	kPG3OdQBQIkP85bW0qKUuU7JqLdmkZiEuZLVTziEM49N7vLpqIASLSBaNHXviFguliR5u5CP3QO
	sX6K0pt+lmbI2Q0LTb32kywwAd2jvnyEKzvW4CQcUrhdssHr2aQZSYR+vemi/hRKcHpFDFjoDZp
	v4hmpiiY+IG7EqRzkDl7fnaKoJAkBFL75FMpeVjR0B7v4RZ30NPpKfT0Pi0TxkgKEKjldFtsb/5
	+w7BynFthQvaVimGdQnYXKEcjyFLCxDIMhmrnS0uetOVeRaGv5eXA33zmTNWjN9RdngBKUUVlQ1
	eI1lbV69BroZMTN9NOYAHIt0TRCy6bG/ark9Wp36pZhj0K7uin1ppG9l7gz0RThc8BXTuDpCRnT
	7Mv8q+6gdd398/rZU/vKnCkX7pfxak0NdXjaRAV8qRCRBLDrO48F+1UvYDZhJHEl0IIntU565hR
	9WeWkrv
X-Received: by 2002:a05:6214:e84:b0:89a:258:c1d9 with SMTP id 6a1803df08f44-89cc4aebc84mr54299026d6.53.1774442138300;
        Wed, 25 Mar 2026 05:35:38 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cc42e67a7sm28732036d6.10.2026.03.25.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:35:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w5NSS-00000000SwT-3uAb;
	Wed, 25 Mar 2026 09:35:36 -0300
Date: Wed, 25 Mar 2026 09:35:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] iommufd: update outdated comment for renamed
 iommufd_hw_pagetable_alloc()
Message-ID: <20260325123536.GG8437@ziepe.ca>
References: <20260321105759.6832-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321105759.6832-1-kexinsun@smail.nju.edu.cn>

On Sat, Mar 21, 2026 at 06:57:59PM +0800, Kexin Sun wrote:
> The function iommufd_hw_pagetable_alloc() was renamed to
> iommufd_hwpt_paging_alloc() by commit 89db31635c87
> ("iommufd: Derive iommufd_hwpt_paging from
> iommufd_hw_pagetable").  Update the stale reference in
> iommufd_device_auto_get_domain().
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommufd/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

Jason
