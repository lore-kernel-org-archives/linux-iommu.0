Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F293A9DAE
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495734; cv=none; b=gTROTTMc+dotXgWon7WQvTUvEqm690GEnD/fsGcd6PiPjaHkOuynW54iS/G4qvINpKHBa/euOsX/0jqnx0UZfYqdwHJnHq+YUQkXtlGhFDIFj2+epzb07+1stvKZD9D7FqIfkCuL1G40qrgbp0XJjcgYWPIWCHDRsR1+oLy/oaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495734; c=relaxed/simple;
	bh=mpS386OIWn/1uIQD+RKTH9RuXoPv4nzB312kCyDGUao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB/wMtsIvDmHYfhsDnGJgKCN5JKR4g2RQgeXr3hPnDvE9kxpUAkH8XMshZbtuJayPBvKKREvG5uVQZykNKMH/k/hCddiqureUxr1Rrb81GCsHb73RU+gFiTHSYEnZTqrBg10na3kKJlUpyPEkj/o5thq39c7wOjtsz+ifqdPJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uT8EVgjT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uT8EVgjT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177d1ff061so366501cf.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780495732; x=1781100532; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrZsZos3Mt/QxzkZ4e65PaNc9Xnu5WiDW2BXX/YqZXg=;
        b=uT8EVgjTo3iZ5z2hfnb4OZ8ZCzXuVlwXJUEgs9HlNqfYRwKYPXXrCyj2Uwp1UN3W30
         tl7N7NqNskdfZnShV6M7aPtYn4llCa3Hl+oKDibza1j1Tnw7ZtN4/UgdWJiWApYj6Z7l
         sOE9sxCLAu/xU992X0aMI8oIq4X9/4KC45vf51iWDrX6zdKNXMj56LY0AUnG/vjLDNpD
         D3/KKV2fTI4hwa4dxIta3p4r+nHlsX210dvUZQHXwwH8JnWZ9RyBFpzqECyFBASc9wBA
         OIEMj3JKHJB18/nXqXkM1smSA/HYlwSDnGT0fEZi+yJfmqxGDAOPX8+gQb/12B/wglDD
         rkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495732; x=1781100532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrZsZos3Mt/QxzkZ4e65PaNc9Xnu5WiDW2BXX/YqZXg=;
        b=X3eUVPHjwRps1BoqVl6hR3t5vYYKPJ2AoR+MUQwO3nBkbINKuFUtpuR23KXnsBuxQ1
         HIfIzEoGgJWLgBVRpQOj3TqYkRfiu/Jr4C4HlZnqbwod818xvvT2edjkk8q7g/sWt9F9
         q8Dw9lXtXw95U4XKLHs/EmGHnkQ9gWjhjM0PU+IfEXN7y2HWyqwbRipp2hcQaxxcuMEz
         v+u7uT61ZAlAO2miBLT3zKXPsS28nXhOreQwtZnxkqyG3rkAPZM0osMvf1KnQ72B7ep9
         GrP1iApfDSD2NiUFsOoEKavnes0AOZUX/8TQdKVJb1ehDF7Gm9jqna/3TkZx48rtc7Lr
         RwCg==
X-Forwarded-Encrypted: i=1; AFNElJ8L2TjgKknlGK7IyCB/0BM+BZg9H9XrJjgLeTdDvqVDUAk0SK2/3uqo15VOO3z5IjC/9POQpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6p0yt84J1ct7n7yaQR7+pocJeSHd2fDtBE0NrMmeWnUPCvCOw
	GsmK+uF3kyUWHF4cfVaI9jydizeNAZufqZ56o9v7chSoEKL0vBxbZ4/+/Ihft1yYIA==
X-Gm-Gg: Acq92OER1eHfNByNkiZAGsIW7IzzJZaj93eVM5g4REl4RUutB0u6fc+O4MCnNUEH1xw
	YF6lCd4A2aY4fOuzIN6qvH8SY+uB2k9wyZkGwEIA1oQkt8+OZdIuVxWDwUBgItpJO/GR2h+1jc5
	sc1qFkqs7AfyMlD2MSe0P0nan2+OKBRiEajTtE0tH7j2Xyx+BwNls0SPAqUIgTt0RnHV3pwm1el
	2DTzZWLV9OTzsEkKrLf2xM5gcc6NWKYXHbQ9URv2N9JOrf5lKZ2K3ByahYf3MN6QZgucuzrb3Sa
	h0gBkX/HbvSYY91uSp5lpKZdPqdT4HaCHWb2uip4hRAiGpTI23V1WGKDrdQw7KlS4ftdSNXAh6D
	1FzrHlIDyS68wp2fk2lRkDE92Edw4/VSnEQRvCfNBKvQZcPtNW9Ycs4tw58pZe8qXUOo691N+uo
	udHsGTz6pQYCoxafKVldo43UwiLfX+asyvhXT7x/94U2vAtnIh/6SR2fH69hUFRmERAJsspNYe2
	U9QTYwbBw==
X-Received: by 2002:ac8:67ce:0:b0:510:f9b:fb5f with SMTP id d75a77b69052e-5177bad00a6mr6870781cf.16.1780495731395;
        Wed, 03 Jun 2026 07:08:51 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c08234sm24412491cf.6.2026.06.03.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:08:50 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:08:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/7] iommufd: Reject invalid read count in
 iommufd_veventq_fops_read()
Message-ID: <aiA1bBMVyur0Rntu@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <e1111adcc8a8882fbfd84accd6674dc846dc5689.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1111adcc8a8882fbfd84accd6674dc846dc5689.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:33PM -0700, Nicolin Chen wrote:
> The read count must be large enough to hold a vEVENT header. For a normal
> vEVENT, it must also hold the trailing data following the header.
> 
> iommufd_veventq_fops_read() does not validate the count, but returns 0 as
> if the read had succeeded while leaving the pending event in the queue.
> 
> Return -EINVAL in both undersize cases.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
