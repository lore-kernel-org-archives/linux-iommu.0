Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFF369992
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657378; cv=none; b=rygi8zB+LejDvYvq18fpiaErQYYKCceZkA3eFwmXj3jeuMiHEvUSzgwTwmAIBsVD3ic4O3jReG2/X2PYIxw1l52BWCeImdfx7hymdWPtCwMLvX2V8Np/NllUcF2aKDQq9fKmsD+peFWRYOcH9eY54NPJ1LCYYc9+vRlkRfkTIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657378; c=relaxed/simple;
	bh=ue4diVlyBdSugrBKczeIr+TdRkmw2LsKvaQpa88/nGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecIftaRySTTqDMl8gd9Ezq6S5WIftYIfXcBaHfctYBmAd2b3k+TBl8A0Wh7qZfVZm+SFbQZoGaEzyWecZr0Dq39gjaNjJDS5+CCaE6uTrx6muFeoos6rJ3/CxIyv33z3pzZD5x3qp0KaodSjAgCzr9jhlZoyyouz+NTec46pU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j86X+/vv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j86X+/vv"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed6882991aso8191811cf.1
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763657375; x=1764262175; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYjA7ex6AZ4LZH9mIUBuXz8C8tSsOfASNmKD7/tpRfk=;
        b=j86X+/vvIATcynq/6C3zzELds8ReXf01GEjLnFq4kqY1nCXKhcf7b76cP5uWUUDU2G
         UaGKFlewaJs88M4bnT6VsL6/N4m/XdHFqd3rxqq3u2LAhKcWg1COBtNrloCtusngGSjv
         rIBgLHGRVWH95G/M1ftMhg/OR8xYtGVBwG2CFjBoIZMAlvi5Qru/cwiwQ+5wOmTHQRp3
         GgQrcPTQjHT3Xc6g3xrSe9YEdm7aCRK5rH3HCnVri7TGQ3Fx5VVjBRh6Vhf40zbP8QB7
         pteXnt0WbEyq+h0COfyALuByz//r6sriQLr2uLD7Yx5nxIAuxxW5/1ouQGwAuXRvrxoy
         v8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763657375; x=1764262175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYjA7ex6AZ4LZH9mIUBuXz8C8tSsOfASNmKD7/tpRfk=;
        b=oGMVrQ+G2EuPhh/6yLFbDnBYVwNKuohbz9MI+nk5Y7l3cDSJhHWbmDqILQBWGG0jU6
         HboWGYTB6nqnCqA12rYFtbBxH6dZaYPVxf+EZ6gqzWSBUp89mUS2EMS47GAU6yRKmrCN
         BtFRnBb4Q1vxu1SxhN3bsemv3qb6QeaBe1GrFh6ZJyKmhyznhOeINxpBoAzDgDgIVYae
         AKopn1rvHW013sLgbuSBb4YJoejhf2Z2+JZRTsvk3/nxIigumKQ8gQq7h9b3WITISHK4
         Zk4Rd8I6qnKg6fHu2WzyOq8WBCBqcJ/+M01TKGXv7SkgX6sC4rNKy1QsiE9DffvkVRcA
         E6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlczANtcLZX1AFmRL85dEiN7oOJwFGpw9yk9apx4FI3/3RGLQYy+1TdYEgGV9m4FY4P6NzKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxk0Z9yNvbbUugmGbNqE5PTgeKxglImcHEjSQFysw1sAuE5VwE
	b1H8k5ofNA9hVXwbUWhlL3GeI8OE4pWjfWVrDc06x6wYMgWgMxYiOwDV6gR8h/t4Mn0=
X-Gm-Gg: ASbGncsd+uQxg0fYjiPEtUvMfPCCc4tEQccnluT96ZaxlBZ/pwC8jgSAXg1/dzVJJMS
	4F5U6XMlVMzUyfTEoLkJFfYS8OvsEuZvBx5B9NWAcxoBEMv9OkkeiOundH0SlttVhDTxJOqO5+O
	KLFBBKHyYcueEuvQxxDpTZlHJNEX0BVkhxeuiDLwZ8LOWVoNT2S16vZmChIVLx2JE8ESaD6S89U
	0/GczrUgX4DAyinCK7Oro6Hz3qZbg3Mjv/tSIQFnH/LMiS7qD1opW8RejXSlrVdIwOJifB+IOyy
	i12GufuX95kl2aH3Km7J7ZlXoMcW5nJQ6znlOZN4JcTnan+AcPsmq0AaOR6PV+aw6dagPo0UUz6
	/cLrtxFQ9GXDUv6XxyDMQ419Ix9T93KGPJDHkVNyOft5xtIdeH2oRf5wDKpiApYCDzE5Ije4Pgb
	2yT9XW1ReRxCHI5nVU4Fdz0iI0TlfsIKHpAi9xXJ8LIXPRGIve28GUzDDs
X-Google-Smtp-Source: AGHT+IHRkWXm08K2hBCWl3UD6cjiKjZ+MsBPZp3KJmrAalTP6PfbeYsFxnnhJ1Uoq1wS45QyoBt//w==
X-Received: by 2002:a05:622a:a312:b0:4ee:1cd7:b53a with SMTP id d75a77b69052e-4ee4b2677d7mr31421201cf.0.1763657374844;
        Thu, 20 Nov 2025 08:49:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48d3a465sm18936881cf.4.2025.11.20.08.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:49:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM7qf-00000000yjm-2VBR;
	Thu, 20 Nov 2025 12:49:33 -0400
Date: Thu, 20 Nov 2025 12:49:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
Message-ID: <20251120164933.GV17968@ziepe.ca>
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>

On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> There is no point in asking the user about the Generic Radix Page
> Table API:
>   - All IOMMU drivers that use this API already select GENERIC_PT when
>     needed,
>   - Most users probably do not know what to answer anyway.
> 
> Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/generic_pt/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
