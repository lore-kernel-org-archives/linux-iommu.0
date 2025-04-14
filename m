Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838E1DE2A9
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633940; cv=none; b=ZO2uixXmmFX8RLS6AjnKbQvKvEEEtlQo0J/h8O8bWvEhiWK0jj4mQafMOBspEvszcRrJX+TsA8zIAMijlbC2tiQZRAANE77nToxkj2t6+x8T4phkUrLf4ww9FuWD7a7tPLF+zK5v8U8HCFIlXPm9svhiJtNkSrhuqSzurQUAk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633940; c=relaxed/simple;
	bh=1pFt/87U7JVc1PcG1pz222huCXbScxD5ZUMEbnDkIUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzxLJTD1805zjb3Ze6CPt4zKx9ui6qitsKaXzQ3WaOhvVAumOYMVVcGy2NXMWsvn/wb8r6AlAeNjusJzBv6ImkWRH+rB3QQC0wj9GqDOIpiKIVAstBiIv/jGqw9jsga5+X51nm76Px52+957R2qya6DuzfxkLuv0k9RZSz/c6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KIPYhbZA; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KIPYhbZA"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so45046606d6.1
        for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744633935; x=1745238735; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQEV8Z90wF8qigDS7RtWmW063pcW65PtxJ9RBpJJ728=;
        b=KIPYhbZA5xCPuL1eqexTtyjKR+uzBxLVhtI6FSOiymF3EmrQQjEAGOwbQ4LAAlum7M
         CkbnjWsqyAiEwjJjy8tgsYRkUOuMkOEKU36bg9g4x1/kx4s9PnFM2as3FgN9SsxU/c+H
         nTKtqH6EqhjU4O0ZiRRp1e6t5ARVg/ec2KzpNsOlhhXafwLDBo6zy8li1d0lr+t281VP
         LrfW+1UsWurAbz2b2+YtLoHwVhAkijXJzFB426wHIY2BTgDJJC/4/3Q0y2XRhVbYHHFz
         JeZ35VHgkL6mbRfM11yIJbW65lNlmLMPtDvf/12B6JAgbHGMOUgecVnHDSBWnnssEXMt
         8wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744633935; x=1745238735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQEV8Z90wF8qigDS7RtWmW063pcW65PtxJ9RBpJJ728=;
        b=e+YGuMPF/lrHHxtkqr75A/5lEAETtGP/OInxtccoJNtDcBTFLBjwCpDgcddMVqHnz3
         8Vh0E++IskoIeFUzJ8XcsJctQP+fvbhq7uMv87th/g7GG7QZFuKR3dSDbMhKIJDND2r8
         yymd8Sz2+OAPWQWpSKLT7whgPmkTXJih8dHtfjor+yf3ZAACFOphoO2TFeOfN6X5L7lo
         o9YpJg4J+hPVzIzvPYzXZ0isE8xwsWDa0+jnIvO0wG8TTnRpYqH2pL7N10oJQ+UZvoGH
         del7EI5+Uryf2YmMZwfauziOB+FtyiiozIvJ//9zGe56tiGgF/Tdc5TOGprstRNHqx9l
         1iVw==
X-Gm-Message-State: AOJu0YxiRyYdYtJObJPbPTSxTdeBIxWcfcaeW2pd4gz80abDBg4XcdVt
	tsiSU19AebEiBgNg6QodGs6OawSIqOhf86Sdo9ePAOBhrmP3gnurHUQeGCqiRHI=
X-Gm-Gg: ASbGnct/McNuMEwkiglxtqVQ8/GdZ10qeHFoDz4/ZkJYVIMfxZ18RXJYlsCve3GXVFX
	AMUe7qzfemS7OLaelbt71h8zCeSqUKltBkh+DxUrppO3J06wwPiUI6r6E2ccST34esgfMmCb46g
	so2T19J+hKr/zmi3Ia/a1pCr6jpMHZS/UOTgISi8/SbBNglCIA0jsRkRPSImLLylmJbBnGExktG
	DSVBx4umvidyun1kg+jpX3s4gY7uQjK3y6JPpNTWOOe+sw0lIcYPRFUSK79C8bkBwQOr8ct+/Q5
	XXM66lzJ5AXYp1lSobNo0q4NHb/jav8h/YLMvCqrkfoE7Ak8sbS4dMKMTF5MvZ80v6qirAIho6G
	zfF6Oy67Xxpu7DVLO1SY=
X-Google-Smtp-Source: AGHT+IF3qKfkUrQeNBy+HopsgcIPWxZ033bDr6Do0sZLaLpoCGQvj1/wFu0IEPVcilHdHpU19VTSOQ==
X-Received: by 2002:a05:6214:e61:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6f2141fba13mr181308266d6.15.1744633935147;
        Mon, 14 Apr 2025 05:32:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de837f9dsm83030336d6.0.2025.04.14.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:32:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u4Iz0-00000001fYG-0odm;
	Mon, 14 Apr 2025 09:32:14 -0300
Date: Mon, 14 Apr 2025 09:32:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zorro Lang <zlang@redhat.com>
Cc: iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug report] kernel crash after WARNING: CPU: 72 PID: 1 at
 kernel/dma/mapping.c:74 dmam_free_coherent+0x110/0x120
Message-ID: <20250414123214.GF63245@ziepe.ca>
References: <20250412061955.7vzrmjr5pwfj2mdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412061955.7vzrmjr5pwfj2mdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, Apr 12, 2025 at 02:19:55PM +0800, Zorro Lang wrote:
> Hi,
> 
> I'm from fstests@ list, when I did regression test for fstests on
> latest linux v6.15-rc1+ (HEAD=900241a5cc15e6e0709a012051cc72d224cd6a6e),
> I got kernel warning then crash several times on aarch64 system,
> e.g. [1], [2]. They all got same warning
> 
>   [   20.180530] WARNING: CPU: 72 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0x110/0x120

At least this splat has been fixed:

https://lore.kernel.org/linux-iommu/20250407201908.172225-1-nicolinc@nvidia.com/

Jason
