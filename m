Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202822;
	b=ulgr2anR0Li1XLifh+9GiOlqso5hA2yPmbpTMpfC04HGYdHPLTJaakFM7coUC+AvpbPQ
	 ChNbTuee5y8xQNtmbOTdWKgMB79Itl48uod49ijI5z6kj1KQnR1MPhHW/ZUVZR+k+8q45
	 PFoNUGIVvQpH90xezNf1BE7Sb7OVcFKNq2kcxcIRsOxbse6GwBZeocQswfXUWOM6zz3D7
	 aBt7kMDEEtIuvT6aH8o5UJnbScla7Y1Vj8HmWKhBykGKs5JUrmp5ju3XkJVDY84yIfrYk
	 eg0vGp+5OV9c0Q/jbCSjtuO28Ib3C5I3E6UOumj25/oyQ2CJeHBbxGHYuM3qtpLh/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jjkMFPKYhpXJNyu/eeEZrlXcQkUZ89E0N1Ixp5FlKxI=;
	b=nvZfkdWhjKcROVTvJpc+661lZ9QLGFa6rVoWjVWwfYKVbo6r4hYqCsWYnqv2VFrpE5kx
	 BLUDce5GaGAcQAqaQ1rKCxEl5nQf9z8bCbMhTcU9TVf+JC5dcZ9hsbGyDAzkxWgdMpvhB
	 jQr7QTi1is3Lrbk+zhRbGfzxVAKHtk+MROOOUss4jploI2KYC66pjSLSWbA9WKHgRd0AT
	 qqvTQIXKSBEHbrZ+WVzMeB5u413FGKhzoxeNoa/dQUr1ggfGK6KNSXaz2OXOjUlBQLvbw
	 Ozk8Umb+NiLqKyGQ/uyenZx0LQMC+i+RzRwJiUFLFj8ZXDOT1r9ph55Em+VYCo38EEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RsicD8MG;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DA606A6F7
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 19:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D4DA606A6F7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RsicD8MG
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53639b8903bso15683581cf.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795202815; x=1795807615; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jjkMFPKYhpXJNyu/eeEZrlXcQkUZ89E0N1Ixp5FlKxI=;
        b=RsicD8MGwdx08d6ObKSt/zCaqQScpQ9miy1uZ2zdufh+LJL7ze0ZU4Lu0SaeqL8LgL
         EZZ1Db4Mus3Pw9pmf/FsmIQqXfGjHMoq0rrEXwok9Bicd3GIzANsQZIKXd5WGTVMUTnM
         jljcoVRyR4o/Nk+qyVkETkiElmwhd2VOOu5lh5G3CULX9JxlmiKOPqBIknxAmC1yR89e
         2AUzwgm//RQcwAdmX75cNcpqGzkgq17LyTwghNaAeysWPwZ8UZMMQc3FlKdnW8Y0kXOa
         K2oQpFPAwL7ihZsnrPGYK3rWIcX5c7TVDrOn8S4gQk5oPbzFQ1xQIq+vZTMU2ZMlngid
         VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202815; x=1795807615;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjkMFPKYhpXJNyu/eeEZrlXcQkUZ89E0N1Ixp5FlKxI=;
        b=U24wJ8wUlO09W58VOUZ9xmx6B6LN6G7frXQLRejLHyA1RML/Xju3L+u897+mVmLjhq
         SRcpSRbfpn5hqEJ9YJBwv4QziCCAUcA+1DkyqABduGMl2UNruotsYPxnbllPK6m8C01F
         h3E6vL7rhhHhTFBCck1fZn+m6sG2x1ZH8fagiKq2qDbBMnpVO10suSfffg8Aoy9RUngM
         BZwOgqkp48671mXLGw6sc2qTLtPSKGWTnSdxha6a8wPLYwJJ4CiY6bLdQp3LMB6juUxN
         XJIniQXh4TuVhG5zR014r04q8Bp683FhegQlqyPKSvyjhtrLtYESmRXNDWhVroLbYRAl
         LS6Q==
X-Gm-Message-State: APuU4Z8g/Aq1M/mK7Ewq+VLWtu49fkgVVoLaL2RESlOCqTBPtwsqDUc0
	iPSDA8Yiv5iaTbp9lBdEcZ1rqDOt4zf8+gVzlt3irNN02b+0KjFBgD7QwQhaCIpAQvk=
X-Gm-Gg: AYBFou3+O1axMpulho0qQ/xk83gC78oapOsK7f5hEVIAIAmxb4VGZ2sIuAQySY7S+cV
	YTpcEhA/1NPr4FEvl0p0V+dQ9jxoCdyA7/VcviYSXtVG84RZpv7H/y5ga7ZpIqwrWnsGzjE9RnE
	KGNsfoBTl04K3M94wzprk57C6VC6N+wiVSfVQaf22Hv63LlcVQkO0GrxNWmoHqXYw0d1frShxQX
	4/Zxkj6zk77DTtOx3rWjgzB7bOU96QPge4rCs4OngRFgCeCmBxfNnpR11zIVSIU/zFU95b+E9uG
	Htu4P6pWxCOWPgvIxv1ImsSTCNj8yAWwI/xvXmiilY7VRpXbTbTXSa+tNZgnnkPNpo8o3sHVMG4
	+6ovChetiMN4lw2ZnJgTCy2FrJVLPBNvB+D9rUHKO0mDEVeQfUv1KuGnyKYYm9d64GNt/KvIVSt
	50k+X8n2NxfwPOqWln4r56Ts//YF9Q0+WEfsYmvmiA4jRUCkufBFC7yBdEuMunGHRvgH7B/+zV2
	slc2XxdC8jg/RwtkqrywsWi2AtiG0/GjV7rvziYBlP9TrCP86Eszgk2HX0n7eWEmnpI0fF7OThw
	cr7meg==
X-Received: by 2002:a05:622a:a17:b0:55b:8787:dc2e with SMTP id d75a77b69052e-55d76a6a086mr71710871cf.33.1795202815466;
        Fri, 20 Nov 2026 11:26:55 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e2c6sm31606431cf.12.2026.11.20.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:26:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUUG5-00000004psc-1nb5;
	Fri, 20 Nov 2026 15:26:53 -0400
Date: Fri, 20 Nov 2026 15:26:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Mario Limonciello <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Akshata V Unkal <Akshata.VUnkal@amd.com>,
	Nathan Blomquist <nblomquist@gmail.com>
Subject: Re: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
Message-ID: <20261120192653.GE1133597@ziepe.ca>
References: <20261120152308.76894-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120152308.76894-1-vasant.hegde@amd.com>

On Fri, Nov 20, 2026 at 03:23:08PM +0000, Vasant Hegde wrote:
> DMA fails on Cezanne (family 19h, model 50h) when a device is placed in
> an IOMMU v2 paging domain due to missing coherency setting in IOMMU HW.
> The IOMMU walks v2 page tables without observing CPU writes still held
> in the cache. v1 PTEs have a Force Coherent bit, which the driver sets
> on every entry, but the v2 format has no equivalent bit, so v2 walks
> are not kept coherent.

That seems like an enormous obvious hardware bug? I'm shocked it was
released like that..

Is anything else non-coherent by accident?

> +/*
> + * Force a clflush on Cezanne (family 19h, model 50h) when the v2
> + * page-table is enabled.
> + */

No errata #?

It seems OK to me otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
