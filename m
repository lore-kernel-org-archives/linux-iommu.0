Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147A4C9559
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694462; cv=none; b=mA1+7QNyh7zho+5sCp3yH9AQTSPhoddtXUFXY2E277ootSQNbJc3Gh39L03uOv4TQzifEpW7fCPeT6bwY0H6vDArJKGzsNUng8oF0NAqg1aVtvhxfm8iAgdQY+mSoH2Umx6FdWVwWTQHE1bsh7AGwhO3C1P0aQU1Vu6rU7tcrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694462; c=relaxed/simple;
	bh=/d7ugw8j3llT+i0xpw6oKwmdDsEr5lQSNXVbHHx7Bbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTXIWU8PRChXHrpJiUyfz0TAR1qzL7fNQmlPJHQuLx1Bid9opJPTldDH5NB/G9ffoW9vM8OV81wSFK7HJsLdXqUxySMnfCSgChkhzPH0U4hkwtDC8QS+78E2FXqj4/H/uv2h+akCuBlvugbE+p+CZABxrmesNOE93jj/tA5vKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIbRyatq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIbRyatq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so2495ad.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694460; x=1779299260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UD9g7VTOeXYFNZR2QR68/VBGy1DjrVre8yBvcooH1jI=;
        b=HIbRyatqt3mooVc7FGe7b61HMev9AaRpWXyNyt3yu56mb63qrWR24RHss4KtrPdXn8
         P7MR4ymLpth2iQjLhzLoURbaqApvGLiMFCUBLgh4MnY60hMVQqmOFVyqrcdWXAJzvVvS
         OwONnkIY9vZsvvkfNtYx6eNaMPUfWyvA5Wywef7ifrdKNxXnxBGJwefhiSfo33dDNIDD
         pTMPNkuJnVK+4mHJjHFfhXF5ohBt20j5wr0wEV1+PLWtTrU8ykHw6MfGgZ432C8g3unI
         wSJdNldtl1mhkn9JQNd5fzV1NOZE2DBOq4UmgrvL6kWkyHBdaDVs02a4NAma4vvTG3bw
         Apnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694460; x=1779299260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD9g7VTOeXYFNZR2QR68/VBGy1DjrVre8yBvcooH1jI=;
        b=K7pQklvKkwCrrT0v2bBZEVLHC2P6JglpbBh+C26hRQSIR0JY/2lnO2S6iaYhndKfME
         F9c5Zm63gXaWXcVu9nCAcyC95kMQbY/nX1N2a+x0eArC7r3J186GeVnCAEbe7WIKF8Nr
         N3H0Zsk1PHKhVpJPwOcDIrJb+KNamux4GRKInNpQ09o4V98HzEhbuvxBfBeuPQu9gOON
         jKOCaVpMSzQ27H/BW8LuCX7Wdbo33afQiH00fCs8NSRoeFmPKc4njKKznEwsxHjRW6ou
         SwcLw59PYhWHNYl3sQawaxAXW320rk1WMsXPNTrZD37LeiWHdTnZI4acGb4y+H2KNbCw
         kGWw==
X-Gm-Message-State: AOJu0YwPh8uHDQCZYLrCZSzi760ZbtYA/vTpvlbZ2A2WgFYpXgfni8AW
	fKAOOcZmLVF+ph9eVyJpudPe5dqHBKQlGkODgLi7dMk4zTMDAvFruDqoQ2gIFvXSoQ==
X-Gm-Gg: Acq92OGUyput8jpgq4Ck3KgGvwo+t6Ud3Y6OC3DwaQgEHdwDLP4/yipEtqdiUwVQ2Rk
	LzcwzmZ4+/p05hO3GPeIyrQJwCBL9UOTQgQo2u/GRECa698oHGVstZd4aYgWHusg3nTRHPoHMJ0
	txVLo5L4bZ9LyBtMNyoDAXXBTCuFnHMI3QjsLWLvoRMVlACCROVaOGDB/4cr3KXelhfsvZnNkWN
	hH6QZpFN5IQllX7Ao7KBcQUEZLggSen7CCQnARgRTOJ7Bw/Vscq5FWSpXBraaru6sPj5d4wLjMg
	qkqcMEaBozXdgTYSKhs/3LWSO/qZB8dxiw1y4mBc1nfkxO7ouJzcwdkITfhpIKKcuRwd3DFAnnf
	2hag7Wj6P3NG4reseGMMFXnhL6zeEd+JIcY1Q4/Gvip1RDkpQD59jCz2RuoiWgKIEqukLf1+XKQ
	gleJUIr7zSmhNPgg2c0PqSbtDrn0wTNmI1njliqZsc+B0QLEmH3jLmtnB8w6CIMp3h/4tK
X-Received: by 2002:a17:902:db09:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bd568f44a7mr144265ad.17.1778694460069;
        Wed, 13 May 2026 10:47:40 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc8bsm117708b3a.55.2026.05.13.10.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:47:39 -0700 (PDT)
Date: Wed, 13 May 2026 17:47:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 3/5] iommu: Handle unmap error when iommu_debug is
 enabled
Message-ID: <agS5NHNCAwmTesf2@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:15PM -0300, Jason Gunthorpe wrote:
> Sashiko noticed a latent bug where the map error flow called iommu_unmap()
> which calls iommu_debug_unmap_begin()/iommu_debug_unmap_end() however
> since this is an error path the map flow never actually established the
> original iommu_debug_map() it will malfunction.
> 
> Lift the unmap error handling into iommu_map_nosync() and reorder it so
> the trace_map()/iommu_debug_map() records the partial mapping and then
> immediately unmaps it. This avoid creating the unbalanced tracking and
> provides saner tracing instead of a unmap unmatched to any map.
> 
> Fixes: ccc21213f013 ("iommu: Add calls for IOMMU_DEBUG_PAGEALLOC")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>
