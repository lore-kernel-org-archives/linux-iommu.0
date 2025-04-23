Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A84289370
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427489; cv=none; b=VIsC62v5MApsVGximBe1awcf7um8vueqk0S77b3vOnF8W2zSW0YE7E+T/guUTLetBLDRMF+nsgLej7DUJcBJnrLKZaPIoepBLd9xvj8uc2A4BqkSQ7tNDmxt6PgLElk+PbRPXIzj4QVkxcUuW4/24rUd4k3eF5DjL+nvywG273I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427489; c=relaxed/simple;
	bh=WcPCU1hSyhgctaeqKm9zoc/Oay4S1DO6JF3Q6paXapA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MieRdR+6yn9Sad/tXq2ZH4HD+vtVBxwENgN5igpGIH/gRvPtRkgqtGzQE3POIehlfVdpXlehwuNOpm5NKWuTBX/OqlHV9JL0lczvxfy5f3HMEQUWzJKzxV34cryRbfDjmeSShZwFNiN3PXOyVHI/4pvQ9uPpq2IRqQyIrQsZiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L5nGtQcC; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L5nGtQcC"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8fc176825so860866d6.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745427487; x=1746032287; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdaxjUBCM/U9au6hWz3Tef+l2xx9Bf4bGZ+yCP5Q9pg=;
        b=L5nGtQcCNdTZEOXPCAg+B64yvGxz3FhhVQy3c2Dt2SuJW3V5pZ98Fua6moG3fu+G9W
         jvF85T7Hti8rBk6abZkj//gKEwZMjsrQrVVFfogvQzEz0toWlkwNoLUxw/AMvJ4v9bAN
         VaKSxsTLDGwVXvSUd3Bp1HR6UhTt9Yd4H4Cz3mb4Dx4YkyPTiOKOTfJQWn8JERNy9nEO
         Z0Xu27woMAvEcRkr+3k3zjcTsDil/JwJZN2iZKRNkI/uPP37x53Lgbhcd3UIxR3SlJIb
         a+p6OzoEVfYzubC+Oiado7IExm68vPY2qs6X9lRbKvQVUhPo9oQ5TjnnAC7tP8QOXBpY
         gyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427487; x=1746032287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdaxjUBCM/U9au6hWz3Tef+l2xx9Bf4bGZ+yCP5Q9pg=;
        b=FgP5zqW6eJ3LILr82LcU8L5u2XT0K07BbOMTmiSjMhvXYTmA2sdF1xHRewxsnM0xyu
         UVQR6iBR1tcktTpJ3WzoevlN7A5rXxLZ56jFWuvWJVjK9cjAxB/uD5q5N0AEG9Z5znVX
         MtkOIDU33BpgbbUA24telP0nvr1GSOmYYQSBNZ8g6tbaBchfAy9NjrXnIN1HB73+aBlF
         OIDnPzp/M+Jz1b/yItJHBuI/1YaotDEsvebdbcSOGFsf2oz8ArFKJCC3Q+VRXd6iYTyD
         bXXEccAaSAIjfua8pEF2x5e4KdOwmaPrVj+A4/hpaNRfX2xHW36/E9LhjxxeG0rK1//v
         6jjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm48krr31Z+Gu7HzcgMaxrsQ9UE9IlgzVgaxTwM+ABdihMTK/R4/93WI41jwnQMFkm3ayKbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwATyxKbPphIzVExr+AxN6FmI2M+sDbPMl4xFm/nCbk/v0QVjHe
	wdgCfF9SHU9PD31kkUCaycn9ATAbqyqHhfHKY+EpqhCJZCsFKCCcuJbE9oJAtxw=
X-Gm-Gg: ASbGncvC9VM5d+D2e+NGtCHFHl3S7bRigUS+sERMdAk4qsjaQZsdaE0zvz5eQzC5sXR
	Pdnn4syj16Y508vyDChUAkOapxLRJ3gUxa3u8nU2vDa79KqZ44/bP1jZYJM+OoS4l73gLEaMYit
	VcjkOFRxPk7aNvqE5rPYvjrux93ehvEsy1gHr46w5CBehl7CD7UHpV2mcGghP5fdGLMgU/Yb8mt
	ccTzqTtcI1aslM0sK+NuvWhsd1HoStH44k0WbMf79ZgF88A7mpLz4di4lxBy2G1TVkT6LNO7qJj
	dIlbR/GNQurhDRm+Q83PnzfVDwWTy7/ou4jFkaQwge3rbPBkvi/7ITAbAxcGF0pmSr5GddewWSa
	MEetjOd4RSa490OvwyhE=
X-Google-Smtp-Source: AGHT+IHuXAnn3LD2RsV+POFTEBSnlhfjUnllEISncqMVJ23JzNpd/zkh3NntjclWpZD1eE0LRZpS9Q==
X-Received: by 2002:a0c:ee4b:0:b0:6f4:5dbd:2761 with SMTP id 6a1803df08f44-6f45dbd2822mr85774406d6.32.1745427486686;
        Wed, 23 Apr 2025 09:58:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f7dsm69980821cf.74.2025.04.23.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:58:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dQD-00000007LGX-1t9j;
	Wed, 23 Apr 2025 13:58:05 -0300
Date: Wed, 23 Apr 2025 13:58:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Will McVicker <willmcvicker@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform: Fix race condition during DMA configure at
 IOMMU probe time
Message-ID: <20250423165805.GH1213339@ziepe.ca>
References: <20250422232650.2737369-1-willmcvicker@google.com>
 <20250423150823.GA422889@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423150823.GA422889@bhelgaas>

On Wed, Apr 23, 2025 at 10:08:23AM -0500, Bjorn Helgaas wrote:
> I think this would all be clearer if we tested for the NULL pointer
> explicitly before applying to_platform_driver().  I don't like setting
> a pointer to an invalid value.  I think it's better if the pointer is
> either valid or uninitialized because the compiler can help find uses
> of uninitialized pointers.

+1

Jason
