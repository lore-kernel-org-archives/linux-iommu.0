Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69532D979C
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845186; cv=none; b=kt5DeShqbDSV7k8wsk6E0Y/mA5xEckuQAToosAFigo0aWJ9BBlOMy7HQ15M80cm/R9Qq3dq8zo5U/W0YEbv+QUyX/1yb/O8gjhVRpQS7mmBGk9oLcFNkeHrb2G2QirKW0XITLvfuNVqjVoJzTYJYiMuhWu1Lt3Y2Yka3mZ7U06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845186; c=relaxed/simple;
	bh=eWsb5uSBhu6bPzZbSom7WozOJmoigRto8Pj5BCIHyeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKBHl1/ztdo0D69WbXdB2okByrqb1NJmNdzEYsUul5UbP6pXvP5Ck1dcFxMpGgxwT3/jhFumQ+Z0b5QFx2DlpFTOJAg1gGvcFJhUf847rI4E5+dfwZxxBzQxamzIUHcbmOIW/VCX0mxrRFh/QcmXlSkyhGXzIVQdK7lMBU2zmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CEOewmIX; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CEOewmIX"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab6b3e8386so20798341cf.3
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752845184; x=1753449984; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWsb5uSBhu6bPzZbSom7WozOJmoigRto8Pj5BCIHyeU=;
        b=CEOewmIXn4V27AciOhHvAAsXPOLXgMGq8Lzav2VwZ7hQUmHx/aq4LehjUoOd+kPlvL
         hMnqI8o5v0BZC1LmxH8lanES8qS4y7qy6iA27/7WqgG2zBcknUMXdUX317dVb7JDdzcz
         nVdtw4l0uqXJXDNgSdnVGz4sJAggwGYR3lP6KwbSrnDI9Z6NOPIyLJ77jbOtG2EqE1r0
         dTEg1qy/meg9SZwcmIZUBX7hgraxvagqWtDTkC1/hD52F7SZMuF4rHRbCodM6vUwU1vk
         6NTKxMKN7n55g4PFikHHaLsWpdCp3kUK3+EqpWt2t6mbMno3oklWfJyM95+wvbtztza8
         VNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845184; x=1753449984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWsb5uSBhu6bPzZbSom7WozOJmoigRto8Pj5BCIHyeU=;
        b=CpQ0spPhQ9AZHnY5SJQXXP7uvA4TO1bxDXk2GqSu9R65h8IvHP/Ma+5oB2QEUWl+wc
         V//uqQ331Lxy3rOkxPdkT03BjMjs+MRH/5aMaI2Q18G4WmZL47VgQACW9RvJ101+dRVR
         Au9REXxcJT/MPPtAtJednfGeKsnv2Yb9Bz9AiiIT9lmFvWycvMB9X4IPexDu7jgNb82y
         EmSU/iR+4/piUTOtAbvgFOzCknFA20l2TvG3ggePzUC3aYdlm/xMaXT6p1QQk0R3Z5cb
         E98lOiTwsKQRvyCo2FuKXAyvduwUMF+iaqXuxaR3iHil0wfgqKq27XmJPsyT2bMpjOTj
         Ji2g==
X-Forwarded-Encrypted: i=1; AJvYcCXnf7HTLzHPmUHG0AITWAardj4NZpY3sRQCR4JPXs6PAh6seSKiSmTqUuZSO15qAsLc7nQE5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgJvTh+Mp/xKN9jJjkXQXqYjruV9L76yMtsdxakmsfpA2eFT0z
	COhnARFEjkKaUKP+uv/j0gko5WfYUdEFwzQE3SB9pNu0Xsl0wDNk95JV2BpwWnGWKbk=
X-Gm-Gg: ASbGncsB6CL92zAigRJJ7GcoAO7G4ugvjOQ6MnYTzYGnr7jhgvxdvQr7ZZ+0ZSseO2j
	eFBfONO7kBc9n27SYFOBJOhDXrldgsHbgFCwsFYy966h7wsnOAWqJgpda+owqY+hIvAk7lkj7W6
	TQzNTKrx/2WLONqWl//MBML3rufLsdKiyIqRblyrodonYZ3wZ8a5L4wb3OGYFh8YZ0box/J9PaG
	x9rkPmYoTZ26wd1nllqQ2QOVraPNDTEUnMSzhUl7UO3eEGbdyZur7vzA09BpbtwlYT4Np0ln0FI
	61AbYu0UAAX/d7h8L4l5i0zBdtMtQ0vkzOwhWXZzP2jWae7CaZAPRapHama6Q7rhD4ixdEbVfZV
	xv/p+fOJvolMbWzGVMylXyDKM7L3RjvY8QaLIN4Exvc2nyCQkumom3663Re20imBkRPEDQsTYVQ
	==
X-Google-Smtp-Source: AGHT+IHxe3HazeTMlNhrIdTEfQ3VTjX7wXKy+xR8Lh7PRfCMXJiCHtJEIAJGMTKjnmoXNaUXBSYUhw==
X-Received: by 2002:a05:6214:1d2d:b0:701:9a6:92f1 with SMTP id 6a1803df08f44-704f480de58mr194846736d6.10.1752845183716;
        Fri, 18 Jul 2025 06:26:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4980463sm6903981cf.12.2025.07.18.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 06:26:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ucl6U-00000009yt2-29EA;
	Fri, 18 Jul 2025 10:26:22 -0300
Date: Fri, 18 Jul 2025 10:26:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250718132622.GC2206214@ziepe.ca>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
 <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>

On Fri, Jul 18, 2025 at 01:56:36PM +0100, Robin Murphy wrote:

> All they really have in common is that they're 2-level formats with 32-bit
> PTEs and 10 bits per level (as is tegra-smmu too). The permission encodings
> have some overlap but are not fully equivalent. Crucially, the schemes for
> packing >32-bit PAs into PTEs are incompatibly different, so if you're
> really keen to genericise things to *that* extent, that's what Jason's
> already working on.

Right, I agree with this. The page table code is duplicated
extensively across iommu and the way to fix it is what I'm working on.

It is all the same code, same patterns, same problems, same bugs :)

I think it is best to leave this as is for now.

Jason
