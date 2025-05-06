Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB712820C8
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545279; cv=none; b=uWSVvKYbsVY/xupRdCe5V5qQ13YMm6iZoED8vd88WtivQRFbc3cUJmEa+60ZuFAh6j8ANgk9ltUmha53WKA1EdNBVvGey7g1PvP86os/MQym4/5UAhyOgxIyv01Y1a64chR9XWHy9hVDvgsG0BZzOOSAeQwOsHxxMqYylT4Refs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545279; c=relaxed/simple;
	bh=q6yD1hgb9gL5tWjzslo1xUDCSEc3dComkIFW77xR5V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRxkHV/4HO4i0+AzQGO8QFJcuygRtNKEkPZ9Hw7quNK6rdTHs9KM6w8xa5t9osVAARRA9ZlFfa1KC0GbG6MRa+kIoJZ05Td9m1ayjOb4AjR/hpvaUo60jEH2oco+s2ZG+bzIS5+vJH2oUQ4Go22xTRnC72E1Flo0H887fNUiIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KBQQMmo3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KBQQMmo3"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0ad74483fso67464776d6.1
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746545277; x=1747150077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAmqzYzWZIcDvblA53R8o+pxqG6akPJefQO4BMgGGbg=;
        b=KBQQMmo36q9Mlq2Ar/uB/TXGbK6s6jFuoGndb/yIXPfkIIBerMdCGwRaaF12L+ssLx
         ApyTpBPGQOfzW9SoO73rIy6YRkl3e+TBxhj1EQ/r+Kdx1YDZkYMu0AUOg87qCR/jlL5/
         ieEMQisVctdVCQj7f3FOCkoRVeIyvjjs31aV6z857qJSCTyQ/v/JB6MQgpd9g4q0K24J
         nYrXryLAWsRnz1i/rS8Pf0xqTgWaT4RlPYywC6VxDrwDdI19MVGBdljrc1Ofh26RzYUE
         +8TguyC2dVPoEiqXjuoNunTG+vLVDrgMnNXQY55YKgdLqlbKvO8N4jL2qN8796hhMmTF
         PlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746545277; x=1747150077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAmqzYzWZIcDvblA53R8o+pxqG6akPJefQO4BMgGGbg=;
        b=iDlEt4Vz4rDU2oZ3Lahc0hqF265mLxMz5hi0B98eM2F4YGJKFpwGKRqKgXy6QVRWD7
         qSkViVW3Zh4otCxXP5DeUYSgFhYA82/9oaJy/VoHruFtgWGISAsgfHosomMGGp2XVxc1
         qzhH8bJIFymNoB5zT/IqpKvvbxGSoFWcS3bD/ehhsKJbTVIhBTEZEdDbb4YNyUZrq1ia
         C3HUpoDJvs2g2IMjCqESENpbykEEAyUfcAn6YhY84oV1iQxpPf5ZAJqeFAqIQmo6JksF
         wk3Uui/3LXvLHJHANCxNaYEjpvOvkHBiqcyTN7IQD71QPDkXhXzFYICK+U0NQCTyJh4C
         YgJg==
X-Forwarded-Encrypted: i=1; AJvYcCWR3qnnA5Y0ve5yllpr7m/Jrm9gCGI+lP0tzOxlLXyGINbX1Dw2ksES+dgD7InFMRFlBIkCgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlSNeWBzDHWfM3eacSfm+EImMNapMx849Se6ms8o3e0rWAOwyL
	Kez4pTzZfq6L9dVUm2f8zdjWl+e2Cjn2bQE9TVGDqtableOzyyMB8R4Mxw03k1U=
X-Gm-Gg: ASbGncunuwr+RCJBMpac1wkTM731s7UYQwSKkSfh5inIP1Fu3AyH/clm4H3RPj5tOMa
	tYA5VLLkzObElxTfJ9Ie3D4JgNUHZb6q1hx4t/JJ9mPD+t4bXVjmehfF6QTCGR65/WSeBjlTUzc
	ywrtHEuHQ5cl62TTw1IF68mdaMRHF439jwzXQcKBFeGZkx7dYFhWo2k7pwBJsI1/FBsl9Bn0ZNY
	hXmhzhY27hycI7uQJ0OxesamHcWIG1yy+FR3nPVtvgSqomYZ3qGcG9n1IfLDIkIfjZKFwcnNZbL
	2Kl9R7H+9/YpuUQbO23Ii1zlOq0WDYfC10GSfq+GXnCiRviFQP71cGjg0C1/s79VvAmYkoB2+Ta
	OhfZq+vHsL3vFJWsw3K8=
X-Google-Smtp-Source: AGHT+IGk8GO6QkuDXe8YPX7kWFBYemERDMNBd+Jcc85mtaA3x/CtnVOa2UU6sYAQeDk4KAunVgGCKQ==
X-Received: by 2002:a05:6214:d0d:b0:6f0:e302:7c1 with SMTP id 6a1803df08f44-6f5358873e7mr64121196d6.5.1746545276896;
        Tue, 06 May 2025 08:27:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f44f489sm71153706d6.90.2025.05.06.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:27:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCKD5-000000008S4-3tnb;
	Tue, 06 May 2025 12:27:55 -0300
Date: Tue, 6 May 2025 12:27:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/amd: Add efr[HATS] max v1 page table level
Message-ID: <20250506152755.GK2260621@ziepe.ca>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <e11bcff900090636a547f03c77baeb35b43234f7.1745389415.git.Ankit.Soni@amd.com>
 <252eb71c-9913-4199-8645-59d8a7513b10@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252eb71c-9913-4199-8645-59d8a7513b10@amd.com>

On Wed, Apr 30, 2025 at 05:27:10PM +0530, Vasant Hegde wrote:
> > +	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
> > +	if (efr_hats != 0x3) {
> > +		/*
> > +		 * efr[HATS] bits specify the maximum host translation level
> > +		 * supported, with LEVEL 4 being initial max level.
> > +		 */
> > +		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
> > +	} else {
> > +		pr_warn_once("Disable host address translation due to invalid max level (%#x).\n",
> 
> s/invalid max level/invalid translation level/

This should have a FW_BUG annotation too?

Jason
