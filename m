Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7202FD1BB
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718560; cv=none; b=YqcEfymtFOFhRUQmYIcq9CRcDPKy9Q6xLNGRTfxAz/iPacDC50Q23PfT8FWLldZBB6yAg2dtipG0pk6lNNMA3sQFNWNqc7nH8l6M2g4tnJXdnrr947Lr9LDq9sVg5RORj4yiVFELHSelG+sI3KobsZIIe4peRnGlEmne9ruB/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718560; c=relaxed/simple;
	bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfufm3Rbsq/kcf+snd4yFKBn9bmTPrRYmowaS3lxMf7hENxRvebTeB/4dFTiwudZxfMkwhOXfCNU71JwX8gkCV3KWgNB0XySON6bu/bVECPgMecP39aMnFLr1RA5R32Pw97EojnmZdRvTU8nUwOxgKypvM/QYJM7gqekiB9tKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MgBt+2LN; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MgBt+2LN"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7859d18aa33so2073959a34.0
        for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758718558; x=1759323358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
        b=MgBt+2LND05eiLo/upxLpwJSH+nUaCPrj99qeLb2r80Idx0TphaDb0uiVdVTIgLJNQ
         oaovNOwEcsuu0Wbi6wOtQo9d4hN7FtWmgQEB78VD3LCH+vWGnJn28Qj2UFJBa5KfNnSW
         TYJQVpBMdFYqfdQZm2C8Hug1Ms+wR8eS4OH538GmBkj8DNIxZWqTT6OMSoHQwLD3EbAs
         y2orczRPD41J1QfBLi4xLYZtWsUB4rjVD+Q8wnK6uEC2ZnAWC7wsZmgRLbVdIGfjK/zw
         DtIvZhnhUqlrzMNl+ooTFSuaHmSCJBbKfpoErLRASBXmkO6ZTZjpAXJm+y/Ryso2fq8I
         LtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718558; x=1759323358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qhfbs5/dOfdODZ9W2ISGsgvtvUAf69XpGYPjAvdJ34=;
        b=Q0EWNcVZUP3yywHs3j/CTxqFzddfkyd4m98S3kmiE37hU/oX1VcXHK2cOXSQ7uDGKy
         X7c+P8Qf5+0w/q+OjlMcIt6fud0Ar5QwSPnRC3gF9RPDI6tM+IQI6ubwlZgft5F4jKIp
         jsuhF8YAQR40rHM2V008BATlEItq8mjCPN7BJoWEAhwiriLsn4suTWg/OzxpeM95fcTE
         rAGq68xd9UhbiB0u0Y+OUAZ0cRd4VMNJe0ibOXuZ6UC5Ui9eTaZz3OtFLlpV9+ryXtL2
         ruY2VA7lmMQDrFrx3RSjQYsMuzEmM3JJleTKhYHzDs8gX8B8LZ2Pi5d8OF3b1d04GEzS
         dOWg==
X-Forwarded-Encrypted: i=1; AJvYcCWE54kjs8HGYmKLj8KmlSl6OKcU3AyADbg3tTBZcV7T0GIwL0XTHP7snw1gmMUB7jCRH+HVDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa1DRHFlLWaOkqxFuhdemECgWhzZGrJaPbE0WW+3kHn/BnSJyc
	ZPAgex9rNRTDm8I7a02ZRCG3JXS7jW8ODzoGKrloFtr4mW//3jdKwcyQpE8NWHGLJLM=
X-Gm-Gg: ASbGncu/WAnr3DBE5XkJMZQpchdguL/9ErnokyN0oMUIZwp9zYWB8+xH2wuAll4/v7G
	5+V3lfCKs0N8E0aUHZ/gnOK2MaEXt0NEKQ/fWOJnJGurs5p10U9DWKdL+mfPKtT/qRGIaA7LUbI
	9F8sHwLxSDXG2oq07GTqUGNWDg1C9D0BQZWvS4b1KItltMZgjtD9CCMShLGWQTgCIpflQWCz5Vn
	haRmGk4GuGENNxFVPiPrgJ487DkE7Dl8/sWIKhqrBTRKWU33ewUs/xyQ5txyDFFnEX86lz4qmdh
	wJ1DoXfkNosJ0SIzv3s3RB648yNA2xRw8apT6gg+mXEEhAAdilr+Mx8CUhRxD/1n9qu6s7ep
X-Google-Smtp-Source: AGHT+IHQ1WFwERflWPT6pleBXcoHSBQbFQS1yTbSrGY2yC7WZRjb2FbqLBgkt00nf34cnENXHwUiCg==
X-Received: by 2002:a05:6830:65c3:10b0:746:dc05:8604 with SMTP id 46e09a7af769-79153cba081mr2694566a34.20.1758718557920;
        Wed, 24 Sep 2025 05:55:57 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692af2f9desm7576308a34.31.2025.09.24.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:55:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1P2J-0000000B800-3i6s;
	Wed, 24 Sep 2025 09:55:55 -0300
Date: Wed, 24 Sep 2025 09:55:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250924125555.GJ2547959@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
 <20250923162139.GC2547959@ziepe.ca>
 <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oig5w7dnrdpgvzuqu4johs526qe57x7dkurd2abllqyvpavvti@s3pwtoduusfr>

On Wed, Sep 24, 2025 at 01:51:23PM +0530, Manivannan Sadhasivam wrote:

> This device is not spec conformant in many areas tbh. But my
> suggestion would be to follow the vendor suggested erratum until any
> reported issues.

I mean the ethernet chip retaining it's SBR after a FLR or link up/down
is probably not a spec requirement..

Jason
