Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0D2581
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573061; cv=none; b=UBj7OEKWZPyKboS450dMCx0BjkFsYKAxasUIUFkNXyNPL3W16Jq6k5Xe/ia6mqnXrEvhNUdWJDgzObBGNfgGR47QAvc8FafCbbehzwKA2EBRrWa7BvHB2p0Ve14O6vKuuN02/F+xsMCIiUgbB/H2h0S/A3pTanzng5T+8dksh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573061; c=relaxed/simple;
	bh=McZ0JXWkmIU34gRskou0jhystrqelVQo23cGQ5KD7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BClrdalmVywsF/nGsNgUd2pJp9OO3JDmv2t5l4Z2YoQyz6AcL5n/RONJYYJ81H+9MlCbCYfmJiX6wyPjpu58drdokQa9vX+oaLV8wWVh0RQM19Qrj46an2vkrnkhnj5DCqkgBpYsi1mmmxIDoTJqPiNr3vjdn9u9Ufxl2k0x3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n+WgkwL0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n+WgkwL0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b47833dc5so25273276d6.0
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714573058; x=1715177858; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=McZ0JXWkmIU34gRskou0jhystrqelVQo23cGQ5KD7YM=;
        b=n+WgkwL0fIhw7rwWMJ9iE/L1JQLpBGyCOEI4WW1e7TYZV2fm1dHRAgmpQ0fhBisv21
         6OZ7yNONMPb/QPTIPqcWb7i90WdIgIvOdfjxjMeEBzAWW4YElyFb4eXTAGwzhOiF5q2b
         3URYwhxU9/PagPFhv68otCke13WcmgNwwk1Gj6DJWbwauBggoGTD2XBBvQrGjORuJYWt
         TAv4KW3bEtD6nGhW696wCdIGdySuYc05e1s86oHEq9eJTingMFd6dk64X0d1VOH19j1G
         5b70I9Z2ZQA2571IPkqJ5qfzfd38+1zcPNiGS1/qi29pTRE4JeQVrp8/dj0cHpbATeOz
         EfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573058; x=1715177858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McZ0JXWkmIU34gRskou0jhystrqelVQo23cGQ5KD7YM=;
        b=kTpT/KwY+ftgTGfWcKclx/H57B0/8Y8xN4PAX95GEaMRj14P2hjpoqrZ3RmFeS+BnE
         lKzwxlaQvMgViV5tt2fhZE5kZ4ae0BP+ZcxyfcmJbZJwuBFkkEhM48/VQWhKaDFD3TQ7
         YK5QX/vT+TkaCaeghaezbm3phWbJ0NLlwZNGP0vyxuJ0QVNuWnva93vrrpnv0hfas2GS
         q1x7bBIakI9S6iFxz0w5OLHdqSmWm2gbbY9qqs0ieCfkVSeopnqwllGKOymfq1CZDabQ
         NNnmuS05+Hr1VXXajLUIAbA1YqhMTwSmO+/uwWcC2D4FnuFV+u2RYzimqvuKMT69oP1J
         t+gg==
X-Forwarded-Encrypted: i=1; AJvYcCVZIecKSEAOA3ahDUJWYYT/0DzwuYCAiSfvPnpJNtY04xz5xsl/10J6FA88FZ7fzBDhPbOLWiJvcvSvgBR+80m84t2rCPw=
X-Gm-Message-State: AOJu0YzgwlY9UFUQt229j3ntyrb1OKgOtlRl8rvL1kqTdxjdH784fAAs
	ljzYXbdfN8OHpgVLTOmeU79EltQOP0tbNlM8Banh2XXnqg/TVG8HQkzOBEX9lCc=
X-Google-Smtp-Source: AGHT+IFwnbV79fDvZ96M7alsio2h8eMlQXeEgKJ8b2nHbiez1qQwf98dejV4NtLT3Yi/fqMqo4Q0vQ==
X-Received: by 2002:a05:6214:f03:b0:6a0:b6a9:39b0 with SMTP id gw3-20020a0562140f0300b006a0b6a939b0mr3028929qvb.59.1714573058580;
        Wed, 01 May 2024 07:17:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r1-20020a0ce281000000b0069fcd0520easm8965463qvl.17.2024.05.01.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:17:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2Am9-00DRt7-CM;
	Wed, 01 May 2024 11:17:37 -0300
Date: Wed, 1 May 2024 11:17:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 9/9] iommu/amd: Set default domain to IDENTITY_DOMAIN
 when running in SEV guest
Message-ID: <20240501141737.GB1723318@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-10-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430152430.4245-10-suravee.suthikulpanit@amd.com>

On Tue, Apr 30, 2024 at 03:24:30PM +0000, Suravee Suthikulpanit wrote:
> Since SEV guest depends on the unencrypted swiotlb bounce buffer
> to support DMA, the guest AMD IOMMU driver must be force to setup to
> pass-through mode.

You should block the creation of paging domains as well if the HW
can't support them.

But, is there actually a functional problem here? Doesn't swiotlb work
OK with iommu even with the encrypted memory cases? What is missing if
not?

Jason
