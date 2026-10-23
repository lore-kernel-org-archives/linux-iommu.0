Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762217;
	b=VTM+xSJDe9BSEphzypiQdjYYhhkIABvowUFGwK2hd+bjRtDoeTE2MjdKeOxedpq/B8sZ
	 2ugz9EzDbDRjhwyiS2DkS/54bWPFfYZRxic5prd20kc04jcIDa/1osvcgk9m/5/1CtUaM
	 G8hIK8q4TrJ093PK7bjOpD9UXAMowwxsSfCzpJM6uGc06xnhZ8MsUO8tktLcZzvF2GuF2
	 gbQxj5dKb9V+Ix9mqsBRSRCxfRMvQTRMaxIZQ11lPFYJ9MqCjIBdMH+iZJWT3REFB34PM
	 PxHrbt5fsQQJI2h/dgOj9+w/9O7tjl3CBIsU3nY5tis5M0WV3iJyhWkszApt3tCQZ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=uRmgUY58lYpE+OAASwZeJvigPvl80FuNSTlXSW3pqM4=;
	b=wo9MmeDOHpANQTIqvVJj80zXyr50i8nqYtDK43Xj4YRwXStUELwZxIGFSQ7imd1flz/U
	 FYvFRQtuqKwwVrdnnv9XvS5J/UC5+Y3+A0Ns3XkeST9vhVFvpW4ri3RKvkXCq6N6cS3DN
	 nNVKZfuN62pB2JLLwfsQhR2wjMCIGwr591bEhsp4vYMaPvf0jiAi82II4Z+vGEHZbmRcL
	 VIWMz85ZvvSZJ+mn/Frb+9n8Hw5Sd12WqUL1BubkmYs5og96FhPpGBvNg6ZihExPj/87P
	 2vo+vfUD0tZvBEafNAdBypKH1DZmCZbifmlhB703yDeqLqwAJvMHRRpOnabYgHqnweg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=IIkpyJxw;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B357606A325
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 13:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B357606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=IIkpyJxw
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91befbcad6dso15201756d6.3
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792762215; x=1793367015; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRmgUY58lYpE+OAASwZeJvigPvl80FuNSTlXSW3pqM4=;
        b=IIkpyJxwyFmTfkBKp42KP1thVVl68sgK9Cel0TOTh1WYLMPLSVSEEoA8AiWy8mGgox
         VPD8pKrzTmVU4cKEIZ9U2HfgioBGMGfJ4vJW2vrY/aLApZn6lgcgAdr+qvIMXrdGFcIk
         LDfkKaYP8DII2fwVNqKvdsl9jMk8/1ZW+I8UkiCGLtoY41CNUlQ8eYDYocPZpny9OxBF
         IlFarac6OX06jFJYeYbAnDMTnS91BtzMX8mPVyO8sSARh6FHLWdzLNK+VzNn5bJSNhIY
         Fv3Jw4iljAQw22zjCx6XUbhHQ5uSDsjRTXsIkHJZ3x4hm2xhuWNCmYPX4sF5cxkH2HOS
         ALGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762215; x=1793367015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uRmgUY58lYpE+OAASwZeJvigPvl80FuNSTlXSW3pqM4=;
        b=hyzVDR2LQ6isnmYcLdaBlXkcqPVgcebp+KsYT1SeWQ/89NLiX+FHrIsu3KkpMpEmb4
         I5TQLPIaKLRSH5ATm1v+f13L9uU/mTNisVXJa+0kQqxU+T6XfFdq5rl3SbF0hwfWbDHH
         S8gRbVJhdEsGw+nvjY1hsGjnp8xKYV5ae5RKy/v7+AQTBVl2jlI1YOdRSY2LYA1q9Aaf
         gbMeCYTnHx1pTHM+HVpATMIaSNdMcI7HtOe3FgbW4ZRqrojK5WY3nloNIgn3TVfxW+uh
         jVUtcO2AsidbvjMBqqdYaoFssygC/+e2jw2zhfZ/fpj4z6M9XGUkY1qaYcXgADvBVG6N
         lCIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo5NN5vzCYPrZwjekPUWCiwByGJXPqQ4739suTOrECBSJCHRFqyXCNd57pKKEsLdhZ6GGbtw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLl2SKlwbdi4y06q4/rBCWshAGfmrPJJQVKlV/zRxlXp4+SBqQy
	V7JTdXjVe3VzP57tzT1GXACm3oHbnZIUg+6d8tqRqT8KVWwZXs6GWEmcDfE3DKk+/88=
X-Gm-Gg: AYBFou2eVgvWKW84CZaPjQQE/jDRbDHqyXSssMnh8Fypau6gxBgE9GTI+PnSHe/U5SV
	zD6xCoMgmB5L7g0Atll1+1dIqqqUHFdWndD6vXikyTvJhYEqkWutHj10VJHgw0hXuWYELZUv0Yy
	RjT4/9bawGYrXCj7MQj22YvyAjvWkp/0yZ5WUBukuRABKjpcBfwNx6iCcQ3MqQGuMYhuX86BimX
	SMp7tyU3y2Royq5jKH6cjOYsAHxNkuApbDlgQpcPyd5ckAQqMkpWe5F7mDgiGHdNaPkRqhTY11c
	kV0v/j/hbfBSVnmLLBfAMzC4Q4s0haZdVqTOB5/uPnAYCSOAnCq/Cz1UdNAdz3XjauYzc52S8NI
	Yjhpe7q8K5i+RC9xDF/PuCN+v6ZroTz+Qn+v3Yo8MrfrmMoHBSvhhP8yYacGqoRlaLdivuhIPIC
	xhR1EN3GRjEw9o8cecmE2Qt3M03mOy+DwhBUPxgVOfqgi9MhLR63htUCvB1VNdE9dN3LioYS1Gk
	co7KIyFg7qSsIqdx/ehRfC8tE5RTDBUea7fLDnOFhKw8DWZdRmcuwO6xYPyp04fW7LJguUNRqfs
	BxXKhaiZ8odnjc6b1fkHZukyPueSF6PjdOz18ih2+MrHJqEm/BorZukMDko=
X-Received: by 2002:a05:620a:28d6:b0:93f:1d5:9973 with SMTP id af79cd13be357-93f6f85a4admr388371885a.73.1792762215070;
        Fri, 23 Oct 2026 06:30:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b43ba1sm16517585a.39.2026.10.23.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:30:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFLZ-0000000GgNS-3Otq;
	Fri, 23 Oct 2026 10:30:13 -0300
Date: Fri, 23 Oct 2026 10:30:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] MAINTAINER: Make Vasant Hegde AMD IOMMU maintainer
Message-ID: <20261023133013.GI3381610@ziepe.ca>
References: <20261015160119.1005966-1-joro@8bytes.org>
 <29b82596-b8a8-44b3-b1db-f438c5d18114@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29b82596-b8a8-44b3-b1db-f438c5d18114@amd.com>

On Fri, Oct 16, 2026 at 07:41:11PM +0530, Vasant Hegde wrote:
> 
> 
> On 10/15/2026 9:31 PM, Jörg Rödel wrote:
> > From: Joerg Roedel <joerg.roedel@amd.com>
> > 
> > Vasant reviews and tests most of the AMD IOMMU patches and is critical
> > for maintaining the driver. Make him an official maintainer.
> > 
> > Cc: Vasant Hegde <vasant.hegde@amd.com>
> > Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> 
> Acked-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
