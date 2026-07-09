Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E842E8F1
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613084; cv=none; b=fqzxY7nJA/4ni31DYDYk8K3QMVf3g5DU2V73uwHNQWcH7I49m/xFH4nOd1hvfGvtLpEB0rE6MLfmlV0iC4Gls6m8C59CjxtxLsmtImoykM89lBTp0w+TmvZkXl3+spCMx1Zoelxmo+tTKWMIdSxqkgR7jGd2X+BVNcTd8qqKQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613084; c=relaxed/simple;
	bh=u7N2Wz8N3g79uBYieYx5umiLmofN8vzB4vLH6EOh0wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qubx6N7byJ6glnDpmM3zJSHijorajR7TxttviVeXpB7u8MEtQ4DTi/q1rnZ1Y3qAZFwClEia+UB7d1cpJwEulONYx8cn14pjs7Q1/a07NJvl8XOdi7tPWPK/cfZNrfe0TPdMHFgxtoPVWO0mN8JyNXN7oF2gzT5skPmCe9a52/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ou4TkW+8; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ou4TkW+8"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so1526241.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783613082; x=1784217882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u7N2Wz8N3g79uBYieYx5umiLmofN8vzB4vLH6EOh0wc=;
        b=Ou4TkW+8XH7i/K5oBEl+3ovptcHFNA0mix5UOPjoIc1gJzciwJxJkNwS/xokVrcsy0
         6MddQkc+UIp4URt+b+x1G8D1OZzeu/D6J9vasyoHhYetE6EJJrOeRQtxFXOQcAa2XfwT
         0RJqdSun8R2S1vn+oB4u2MFFDpM1jds7KYQ/GNkdSv9TPB5LgeTMjI1ZL+jS8jsGeb0x
         d4WfvfsxcAA64SGaMZRiYhRS1mrcALULlGm4NuELZ+5DUNv0A58NRCT6PS7A4FKyVyYP
         uSscWcUXBD7aWz5FCOXMnG+zmYM/RBqLlWsvYzmXu4z9i8ujrf19DLCvtqoGybZqaJpI
         1CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613082; x=1784217882;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7N2Wz8N3g79uBYieYx5umiLmofN8vzB4vLH6EOh0wc=;
        b=fvWJRK5GWfSSjVRmaS+HMjxpLg6O8VSjOKiw8WGTQ5Mg5eBhfkPPRnEzHhHId56bI1
         kjbqYVH68dclF9D7z6jpmYmXt2h/n1G8XRVqsLEhQLBwAxKPCAWy/cUmwsP3DorfflN3
         MLlGP8tVQ/0qaXKxR95xYZp8layCJVy7hmKSiZrFp0yFbRcOXA2GoEJckiLGz9xRe85r
         om7L3EF2hLFyVIPagzhwbbL6xc+AkWiFNnsQRrX8ZxImS69hz1YNxZGuDZEkEKBzdO9p
         P8bW6hITySgTK+I7X2PtShephJ3sZj+td+2I2y7HFwWzFt2CEY30X4gVmXrjhtKZ4FW6
         UdwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxGT02AZOH46SP4bg8cbeUr0PWY7DnIX88dp4AqkQCA0SBMpCSqJXTwVVyvduHBLMx3Rk6kQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX17vQgxOTedbQwTk4sZMsQt6j8yMl0Yj43I2mlmibgM5U8Ig8
	OZe/GUBlAM+ALTGSjOtxBWZ9WyK5D0yJBqIX1hEZ1UYjWAS1vIRk7Vejv3/2AU2JWHU=
X-Gm-Gg: AfdE7cn3LTen8pSBW65+fb5p2AjA7IuTTsSEzXASB8DCdiZXhMWhXBTXZEK3weZ8ncH
	Ka93svbBao4K87hznyr0tae9V7dEeV9vE2VkXQ2GXf1fVu6e6zaUg0hulNrlr4CFrZ8i7a7CAtQ
	jzf8T4Q4ooPjA/QxVJ1DKMhLMDT+r19LSaKKVOvFPFKegSXBbiwAWgmnenEj3tUeqxl2nSO9mBR
	qeTm7SA18HZfKIakpwdbosdGuETc5tVR3dtjKC2mOzIs7+yetv9e4AzdpkYD/OqKL92WWiU2q+v
	IppKN42efQJxsSbojpb/tTr3s8V4D05sRcSyLC/WIUCNXYNUVS8jiipZLTOWiEF/3RqKwairxmY
	8vC199kTSZl0r1CGirLQ0tkY1Ix6x9V9dhhdbITdwt2i+JkjPErhcR0DeRksu
X-Received: by 2002:a05:6102:f9c:b0:737:ba2e:8a29 with SMTP id ada2fe7eead31-744e0306830mr5071060137.27.1783613081904;
        Thu, 09 Jul 2026 09:04:41 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d9f6sm20470796d6.23.2026.07.09.09.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:04:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whrEu-000000058g9-24As;
	Thu, 09 Jul 2026 13:04:40 -0300
Date: Thu, 9 Jul 2026 13:04:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <20260709160440.GL118978@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
 <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
 <20260703192459.GB1978949@ziepe.ca>
 <f13b30cf-e885-44c6-8e61-7924937eb8ac@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13b30cf-e885-44c6-8e61-7924937eb8ac@arm.com>

On Mon, Jul 06, 2026 at 03:13:01PM +0100, Robin Murphy wrote:

> Indeed if anyone does want to use SVA on such mismatched hardware and are
> happy to use a custom kernel with CONFIG_ARM64_HAFT disabled then they can
> and will continue to be able to do so.

It seems like we have a chip that is impacted by this. I'm being told
that the necessary ARM IP is not available in time to properly match
SMMU and CPU for its particular application.d

The chip is embedded so those work arounds are possibly OK - but I
think this issue keeps coming up and ARM should have a better overall
solution for CPU/SMMU mismatch in the ecosystem since it seems like
this is going to keep happening..

Even if Linux could automatically limit the CPU features to the SMMU
it would be a big help.

Jason
