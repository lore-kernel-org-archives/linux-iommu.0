Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EF1714AB
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723539; cv=none; b=WeLyRgphtjd8I/GK+fArbXKNGSuuLOZvjVcF6ElXpRUiV9tHvAqiVnNhtMJQqZy7qtyOtomkEdTzostnrJLcMJ6TjWenlGI+jBLMavuAOeZkJthBQwPwhqs7WfE5NOGCA+n3Ia5lSwaNpmzzP16V6KGPZRMzy10+PKuCXrnrZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723539; c=relaxed/simple;
	bh=bX+Z03KAir1AvRgDPM3iUP5NFkMq/MyZqnmhaxA+O14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8E3CUhNWirk+N+8lwNDndGipqNdAiavRu8LbLn6sAC76hMmlXnucZz3ueZdzL0xUlqEQvIMZDA4B2sa5rHqYgCCgDEnrX58Si0cSINn5dT5rTGOm5pmoQcj/xhkoy9uVJ3vcCTceaZFrYYBh9dJ4S+9oxd0tPPPLIvKySpzX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G0KNLqb4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G0KNLqb4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso1597126d6.0
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723723536; x=1724328336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bX+Z03KAir1AvRgDPM3iUP5NFkMq/MyZqnmhaxA+O14=;
        b=G0KNLqb4Yr0T5zMCt9lwXd4SQwHKT4dIUqLPJ3aui9X1NqV9ZrK7nqzBweqGoZlHzv
         Qtoy8GEo5c2jorqZDYipghNg3lllI2ivu0eEbn7Dp7iahfFBweICkM3H9M/OBaY/MD77
         mGhqpqN/510fgn2Rp4TZwAZOCw3iHaVQyNEMz0gk7mVWOAk0XI03391CriBo17fj90eq
         qmi87KziO03Xl4N/rdSRFPzOWJWmdmrv3Lby2uS5bEMyksn5PJj7mUxbzcwYlv4/zmAM
         jor92F3iUqFuyt4E064K9wcWIj90uegNrfqU4DGJQ8Fo4JVJzi2FIPkhEPz3RNeuvW0T
         LkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723536; x=1724328336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX+Z03KAir1AvRgDPM3iUP5NFkMq/MyZqnmhaxA+O14=;
        b=NtS6e/YSammO1um4pTGYuZ56C0xOAIXK4ZumnvhGT+fwKUC1HG9m79XXKIISnw9Phv
         9ptPIkfCBEPQYH8Ro8t+aoH8B4h60nJ4IshAt+ZiQZ1OxM7A24LUJfqIkfbv+4C82qm9
         hYFjib9gD0nkeq2CzKYpuPaJgRjNFIPk6Pu2padE6s2SBT9KneCiADIa/BidjdcwlCUd
         JmFhmfCrr2hbIkeE4TB80AbA/6KBkAKr7IpXTs8RPYfEPVy7apsUUs5vNCbtRkVCbVhN
         tLy2HSf+frlF/3ky5YuNEME/bBGm4tDbfTG3sWXfGkDshKs0fgO4ZAxPwOJZjor1HatL
         jYDw==
X-Forwarded-Encrypted: i=1; AJvYcCUHB0d22ib08TFk0H2lvbC070YiNj1BihSc9+y0311EnNGOMYSQfUadktrYNeMgsqzWrNzs6UsoFixfXabtoqbaxSPJTEk=
X-Gm-Message-State: AOJu0Yz8wLgJnfqQcMgcxObs0hiEHLJvhJlXZ4/cWQL//ovVXGVU/IOL
	ZWHverHV1SNrl0QcP8w8EQ5SeExqzN4c7rMx2x32VcbLLoX6fkXpVoKRqZy+m64=
X-Google-Smtp-Source: AGHT+IHPJiOlGhJDc6291J9QgmSpFBfBzpYQwHmlzz1FILnpS5kT+SLIzITpRexaKsXRzXG8EOyBGg==
X-Received: by 2002:a05:6214:2b89:b0:6bb:9c14:8bbb with SMTP id 6a1803df08f44-6bf5d277e83mr60014146d6.48.1723723536093;
        Thu, 15 Aug 2024 05:05:36 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3107sm5805326d6.121.2024.08.15.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:05:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seZEU-002lfC-2K;
	Thu, 15 Aug 2024 09:05:34 -0300
Date: Thu, 15 Aug 2024 09:05:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240815120534.GD3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr3m4YCY7Ape3R6y@google.com>

On Thu, Aug 15, 2024 at 11:30:41AM +0000, Mostafa Saleh wrote:

> Yes, s2 translation fault events are the same but with an extra bit
> set (S2), and with a new field for IPA which is not relevant here as
> we only report the IOVA.

Okay, as long as the IOVA is decoded and passed into report_fault it
should be fine

We don't yet have support for specifying the IPA on nesting..

Jason
