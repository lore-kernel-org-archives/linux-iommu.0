Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C529BD83
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148675; cv=none; b=mkfOELcsnto3VxkXpRkD58UXkVbCjc5hv1vm3R+Owdx0ooFkG5S/7J4goGezpER/S0pHVRCpjjLoini3CE29T0m5eaoOBVgACPNkHKOypd3iGGAg8J6GwjIGYaw606HZdW3QdSrF0K/4eCqkmJ8tbIPLarurUcvkYYrYZciYSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148675; c=relaxed/simple;
	bh=5KdGJe/bEGi1FhUqrPmS9UicetsUrP9DB3DL92NpLN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlW6HLh6lzudTWYWrKxV/9/jxtS6BWkCSTdh/W7lJzjhv+1Q87jOvm637l7qC62XHM3khbKuWFFGqOAwCuOmzkQUlGMoQbIGC8nbSU+QgkM+kigwy5uFFuja8rU8WC/E7/2fhlGpSRZpNzBi/9KgsQu7Q/NeIHj/jl3wwNFb2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1NwziNU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1NwziNU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2b7eee0dso99965e9.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759148673; x=1759753473; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSFD5HCO/fWrI/TwXdCpgBbytcTu1BHw+rvoEt1zy1U=;
        b=o1NwziNUHpX87j5JZwCzPGMUdT89inNErZYCQPbVcMgeEHBAoMX7S+EMYRJp9nbv0g
         yarFIuom1UgruGB3E4UNo6mZ5r87ezFuJ1v+/NoIlfbTYr0j7Pjz5TSy/o4ioOKj33uX
         nt04s0UGweXBXkaW9YVc0KyH9uFD+ZCFQzDNBn8qXizXxrWjhqHe6RfzpUjGJv40e4eY
         felHvQdIXofKivlPl3ZfyiYS8JsBbuHDDYea9RhKO/y8JkRz1a+nAhrxIZyuuXLrP368
         LufjnK4nd46giWboW+/byRVj3cPAp6sDasTrHUkGavHmpS2yw7/FWU3YGvLvUt01uLym
         GSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148673; x=1759753473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSFD5HCO/fWrI/TwXdCpgBbytcTu1BHw+rvoEt1zy1U=;
        b=vZ0CZz/24XkeXMqoJuzrqWfeUH9b+9kOPZDa1bW+7voYJhmAhwOMvg2cHLdEpUsEIQ
         lyCeSq0gNwDcVpvIJdE1PW1Fh5O6ROc/xFy9HOMEZXSxXVV4SIKRtYUdQsOdhMJwvBdm
         Ada2M9NAD5HdSbv4JsJ4nQB2zscaKsVrb7oxXzzkEbBnwCnkMenMWIxaa9PG14GqwBpn
         oOduW7chbkSYPk1h7VokNjM0VG53PrCulVwVhMWh95HZg0qMfc+7b4p31fqOYWL5rSoF
         nAPkWtftzRcij60rnDG3dKj2Af2vBHb2vfS9PMDm9sYNdwQiSvZ0pZsKByO8Cy0FCwlF
         s3QA==
X-Forwarded-Encrypted: i=1; AJvYcCVbkiY6DjmdlX80SGG14VntD1TqDLmX5H7mMYlOKdY/ShaFSLog5LNK5G61jSXD66yliZNmEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdzISt4JgzJiLZliLv9XjeFBjUdsgJxL83eX3frbq0PxGZ3ows
	I/z9+VnqSWccceKGkrOueCY799ypAt7kDAxRmHWpwLDCq1hizxGN9HK/d1IfzGVbIg==
X-Gm-Gg: ASbGncujabAf95/LMS5dOHMxoxhSxYN4oDlFOhQ1VkuOR0ydyXMTOUxc2HgY+/zmEin
	cyaoFcfJE2hQYrwVC9PIa3Ht6UkFc7PN+A3/Apof2AUWpMGMakOyL1FhX11qWy/D9I+wU47yUSS
	xhKocKIApkDUH7X0aB2yZacDlV3sWlioloyl8BD5MeWsO7pyUZ/5rJU9+aW5PSD7QbQGIbr8Cwd
	ORbSghu+xcxdNqdVvBIKM73gL5nKfMv2iUalXd17ZhNA1LhyATG6Q3ep/kUJUyCbcbXR5IO+sA9
	DXb+oa/vqy7mU73Cn4ycjfdp9NV8dCa2UvJOyf31Br42kyztaj5WcmcdiTf56VAsSd6nTSBOPKO
	Im8XCZRUYDcP+IdjgaDYuey90CEO6+pTY42EDyXWeluMBIMWTxXInnUOdlaOldtSIcNk=
X-Google-Smtp-Source: AGHT+IHUrvcIjuK8K/AD/L7fltFhFhuLnwnDhrskN4yhDHWfTGxrdtG5cZIEZ2TKcQtBDbGt6u158w==
X-Received: by 2002:a05:600c:3417:b0:46e:1b09:1cda with SMTP id 5b1f17b1804b1-46e575a9c53mr363595e9.5.1759148672430;
        Mon, 29 Sep 2025 05:24:32 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm17977354f8f.59.2025.09.29.05.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:24:31 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:24:28 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNp6fJNoehs8hMyF@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929115803.GF2617119@nvidia.com>

On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> >  		.map_pages		= arm_smmu_map_pages,
> >  		.unmap_pages		= arm_smmu_unmap_pages,
> >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> 
> Shouldn't this avoid defining the op on coherent systems?

Does that mean we need to have 2 iommu_ops, one for
coherent/non-coherent SMMUs, as both can be mixed in the same system.

The current implementation would skip the page table call on coherent
SMMUs, As in the first patch it only sets the pointer for them:
 .iotlb_sync_map = cfg->coherent_walk ? NULL : arm_lpae_iotlb_sync_map.

Thanks,
Mostafa

> 
> Jason
