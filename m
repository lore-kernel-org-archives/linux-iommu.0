Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E3410D3C
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581435; cv=none; b=uBY6Yrk0cP1vIJ3Hemfknxl78Sl6nWgZ4imVn+qxWE02bz+mtOuePS82979zPaaa+LmioOGnPsRtWYIaJWaggDX6AvjDuy/+oh2WfjnZxvtIdGGF3iNsbSOPES/Ni+U8A88hf41BxytxsWekHkVhfrJiFTQAXRFsKwHdT1i9idM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581435; c=relaxed/simple;
	bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fNdG41q03s0OU1n+wSy97v3rHI/VSkQZ/t7DA2kmIBiapS7FOqPh/MzUJHfioAQ+MNc+8CQ6rXQCDCylLvpFzeMDYFb60+wFXLeQA8fgrHY7fqm5LIEolhXT9R8jn2R+oui+NHZroPdboND42PwkDUFhNKeEK4b/kIcoueHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kqG33lU1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kqG33lU1"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so7641916d6.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780581434; x=1781186234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=kqG33lU1QCnXWAJGWub4b5yUrDFW9x9HswzbZ970xseFk2Vgo25JZY2PQ2Pndv3Ago
         uYkJ5JZO0X90Eyh1GKMHxiYG/Ocw+Ej0JP8GY6pIuNNWDEDlkCTwlvw9+gpcnpYsvuBv
         u1WwBTFdPCmC8yYIbwtXD393Rzcp4v4cRjPT6gPZsllJ6vB0veGoR+ptkLpixve8o673
         gbozEuLrK0ZzYyJ3LCudnGAGWR4SmBYWB7NGghHovckX5W1/VQDD2Gz6JeQw0CO7kfLH
         7tjjO/TJvBoQ5JMpAN010En/TCOvExMi3icrrjCjC1VW5eNHB/zpBxd5JSFFC+GhW0Wu
         wn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581434; x=1781186234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=Ur5xg3S2xQVcTbAyp8K3NnqhOwLXCAIChW+Ikq3mGo8V8K4RkAyU6gAozhyIBkeIMt
         lc0seM3e5RjLA2fK27SzZQ52TtKFlPssYRJEExs7YNXTwtV6psN048l9swyDLaY0mfsP
         zldcmDYEzfS7rvobFfUN5FsYgTUPi6LBZ0mD7YIMTXiicCJMhCWLuHOCi2leW3A9KZaF
         N/PO9jdRO6FR8BxN6wP2jBahTU8Atk0gbPFw/oMeRCs94xnreVjSS+y3zoH0XkxMpcZX
         hk/6zlJ9oxAaCAujMVJVGWe9BJ/UDyM85dCTYX2e2WfkmOd0asavaJQvDQeGP2Gy5d6j
         T1vA==
X-Forwarded-Encrypted: i=1; AFNElJ97AZ6DPRnDFTqH1we07ejY45xRW14AfI9wkWSWBugym+M78ei533wzn5TecHfHL7MerxxyZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo93OkVFLUQvObwv7VZ7NOHucgVvN1q3qfi8QAuAjpp1rIGSfc
	eqw+6c/CBG3DTeJJ3qqQ2249eD0XlS73EHlxeF+gDmn/5+K3nB1iKC5FqaboxPBLzBU=
X-Gm-Gg: Acq92OEIkD6DGQbDrU0lY4+SVOXuJCDzmcVFvYnMUZtmtLu57/E/fdd6TTgeSX2wEXH
	N8gFopMc0lTNoQz2LN2kUwNO2ja30mb6tr0o3bpuVig4QY1P4Jchxw96U6Fx8VS8KGV+cM2G4e7
	+AEbTWFH8wY6NQZoQMj8K9rhwzsKTDWRAvlf84uwwouM8HGepVcBnOi203I0X++URKpQh7GOUXP
	AbyIPg3yit2D1J6KNkpRmEAXK7JqMJQrGvQQK5eZ7ucMBi/VV1GHm8/SqWqhNOsQzIbQ2Vns1ZJ
	7b9/N2VquS3caKzkpRH8Bd/Ua880YCtHyOx2pOo2cJq9AjwGc6oBJJxf8VE38c9E7JZdOTumY/2
	wqVnM6WaejoarNTsp4f86t0y9UVBqsMyzlrj550dmN51A+sRubmybtqHy+/GD+JB+NzREk96i5c
	6UhKpVf1KrZlqT95nMvt1+S/czMPxpG0UHgqr1QYYYdXBE/3NaR9iSPfncO+RgKecSe2oC861Su
	7hxgbUuh2qdSFOWxdr1jzPEpbE=
X-Received: by 2002:a05:6214:800c:b0:8ce:e098:d974 with SMTP id 6a1803df08f44-8cee098dc5emr22722786d6.6.1780581433691;
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm53598296d6.39.2026.06.04.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8ZM-00000008FiY-2nrt;
	Thu, 04 Jun 2026 10:57:12 -0300
Date: Thu, 4 Jun 2026 10:57:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260604135712.GV2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>

On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:

> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?

Please no, we have stuff already using this so it would be a
functional regression. Revert making heaps into a module since that
doesn't have a functional regression.

Jason
