Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0C22576C
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254735; cv=none; b=AOdUFS7Io4GlRSnX9fAWAAZ1/7Pq5BcQYpvUiDF2r8f6x6YmVzgimHfOMjpRvUHV8rPMp5gC/z+gAiBF7s1r990UPfupC2jIV3+R2izb7TU9TMAnyDCBOOiKWsH0jdLrsnJgfrfBDcAcSd2fei64ysXPs6MxhYyZvfxNghj5IgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254735; c=relaxed/simple;
	bh=oD58rtSkgR9/HDrRgWtpmg1LwtWuOjwY8yU80bdRgco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnzXrDzrLOSn8SbSn0W5TJTH8wM/C7eY5JQrQpyghKVkEgnccHDSL40Jc8HeSCTYR2eClZcJkFCTaROzHxrZbxBB/URJobfHLhPDW9srfwMAmfICwm7yQrIUB2Nkxp/LYQAtH7OWaq0NrDWPzQ04y95/gyHPBi6Vp+IRlbbAGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oak75Koj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oak75Koj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-242d1e9c6b4so164435ad.0
        for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254734; x=1755859534; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZOHDfnUcExL3Br23cP9r4Hw7xHtBw2wjRy9sUmDuzw=;
        b=Oak75Kojkb0gH5Dti0xsYvHSKqBCijbudYyeeitTVvneHxyc+VgHxbGGGvsgwVpbcP
         +WxeCrvNzv+MT5fKyn+Jr42vk8TauxVjY7AW3NeyA3KTFKsGvD3Sq2C1ERFH770Ih0Z5
         0wHVYTN26dikcP24tDzNelcQYqwqZTT9YDWdZYOflwrQHG0Y/pMWG9aXisJsd/3tOoJ/
         52+QCVqk977UrlEPiXKPHF6Tztg0BIZZqfcpgtPo4HOz5xmIVEdT3iLTJ+xTvVdLa14Q
         oV/BWxf9FpqvQMjO1EB1bHdeqS/Zm+gJgDCJn4+3u6WNTKbLMSvHELXDTaCMNDmXUO2Y
         Ul0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254734; x=1755859534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZOHDfnUcExL3Br23cP9r4Hw7xHtBw2wjRy9sUmDuzw=;
        b=uLTXDAY4a0co5y51TtwBZUcA3cDk3PeKi4BIPXCwFWrveI/ia3+U4VrAev9WecQwfw
         C5NgsIzFVPNsAxUevWcBfPJnAO4daHRwVaauh+Dn7yQ45rHt8Kf65R56cKktjLq6mTGd
         ZRfFzxX4SANoDR2nUtHW8rcZvzccDg6WK+AG83AhkP3TNxc2+iYq/oKmc+N4MBvIhbJi
         ziqqUf22neASsZqE4+EaS+awxxw/q93OMH9wF1Zx6DIMpfdUSTuKU/i929xmJCpFetv0
         2KUpzls5Uk5d8tlv+CL3i3h7YuX4iZqKRCcKzgWkCWtNpMZZI6+ULjFLHLv4ba+WySAz
         +noA==
X-Forwarded-Encrypted: i=1; AJvYcCVNoxmBzpAobo7yjGHyQr1AsPIS36ByQm7bvJuESzJBPHhTYjqlu1+DOCGVQEYK/rzvR9EX2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRVwM5OGKtALFTp/zQfAwV3U3S2oNC/kYSBjjvB+ZXxieBhkki
	2TKW5OowdI5FNJOgfJFI4kAHhAk3ddt6nFgNDwUNOJWUYjpFMf8senhHjt6Jh4rt2A==
X-Gm-Gg: ASbGncvZzPFZNSQ59kUMkQw6inE4qWNPu3sNIsVXlK2aOhoUXc2vh54KQYkaHF0Dw0p
	hS491mz95/3N+tFGX5+V2l66hEcKCxNRXVNrdPI2I5iqb3vzhqSqAV3npeDvbN2Lkz1e5Zjyxg0
	3cXc4Obb0OeXW4pxzs6pohu5XQ6Hf153UODAX95FvAexaatBmWwU7QWfXMILz5mMIs3GGhmFReo
	zm8/hczDl4uR1YILiItfUpB5adalOKb6aToSzsKPnjWXBDEJhXb85xBa0q8jEGaxlOyu51SPEWY
	xanH/g0rGmEkDTYVHIfLm1r0ODsKHQWO4umHWIR+UJElEpgKLPelwKYRNJVeZ4Qhe9tWBDiE4KO
	+zkaIlaWyB67QAR9gmj2tCcDLwSmg75LWIOMqwrdzPG0v/sWVx4uY7IK9CQ6GzmUebIqfUa2H9x
	BrAzjLYUcx
X-Google-Smtp-Source: AGHT+IG0rikT/NZEANwZZw4qUgDRW9B6Cy5Tz+GUMNCa7cz1l4czOTgp2vuDl6rPX++zqkwkfKsE5A==
X-Received: by 2002:a17:902:f690:b0:243:597:a301 with SMTP id d9443c01a7336-24469933caemr3236235ad.2.1755254733564;
        Fri, 15 Aug 2025 03:45:33 -0700 (PDT)
Received: from google.com (208.131.87.34.bc.googleusercontent.com. [34.87.131.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cadf96fsm11524465ad.41.2025.08.15.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:45:32 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:45:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, nicolinc@nvidia.com,
	jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Message-ID: <aJ8PxlIP_KtYgYun@google.com>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>

On Sun, Aug 10, 2025 at 07:04:01PM +0530, Akhilesh Patil wrote:
> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
> Ensure the memory is properly freed, as kvcalloc may internally use
> vmalloc or kmalloc depending on available memory in the system.
> 
> Fixes: 2238ddc2b056 ("iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
