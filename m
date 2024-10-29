Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9390205AAD
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203679; cv=none; b=EA03LhUVgABq/TCXOj+OKfh1r0AMBb22azMC34KPtmW1rTRlSHoeDPyIDLZZYcEldT2vOggiQuZqIehTta1Mi1TaH6kyeEmSiR6nEvgHXHfyQ/FbmbdAz9mwafxZrvgsZh8dGEwp1pym5fq4m9v6/wvuzTWy8YFv8/IWwixV5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203679; c=relaxed/simple;
	bh=hEN7fWVSBJu04ZdAcX65OAQfht163nAzvpw7EsYEBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3gIMoQZRWhIBwOW8h/+U+ZvyASJwTnea1khNm4G3EldVcax7kD5iAK04aMUf+ePXfYG/oxw/bp4xu06drf8fzUb69mAXX0xXPaBQ5aabm+G6YPS/pOTMkPuBnz7liBS1GPXHBH0mF2onxWGoXunEGi9BX5ynpu/AnNP8KiCdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jvLNcOhs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jvLNcOhs"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b161fa1c7bso397334485a.0
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730203677; x=1730808477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjG3TMjuly3+sxREugXUl9aKqFk9SyT5Z+kFrmhljos=;
        b=jvLNcOhsUmnTi3TU8pf1qybWkapqJxS6bgqQN7GjL6BbeDVdKlbHfqR0jZdjnyC2n8
         Xl/FQJXro1Krv6VaQyXooMg8lj3HHqk8VEydHrDq4dwyBRK2DMgozaJH7s1f4dX9sctO
         Tnw1LGSchsDyaPrzUEDpRp0Yu+itrmMsLN3AIJZxO0BI1LK2qcjaRWJUGd9s9vVdeMi5
         tUR8+Ggi/5qsRVZ0ohm0cet+v9vqeOoNv15Emb2J5rUpfTCrofcwFBRcRFW7UCLmzruT
         ErXspcQv+eDcYBCAjO7vfPr9JOOd5ikXS8/xEZDVWmnQRYZ0sAZP7VpH8swVNRnJQm0r
         3lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203677; x=1730808477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjG3TMjuly3+sxREugXUl9aKqFk9SyT5Z+kFrmhljos=;
        b=Ih33sZpW5zmXYZvHZqnI6wER8HDUmAzhlIIasKvxreiBuDVZkQt3sqGIxolAkwJBvT
         kXa/TKJ6Hqz8ETlCnfFVGo/+3S7+SOV6lteIAW4oxc2vHIziWqYRlejHN/IkpWKV4c3b
         BN26haduQGOCDZuzaZj7N6b3LfagNwR8Myy0amZJst2BghYAWtoq8cO7wu/OvPwJFWuJ
         lMuvYn45Qlw3cyObBoho/qbFc5LniXm7HmXe4O5LogObntaJNJDRPuvk6mWRtpd0lPSz
         uYzTAotM3N3SPLMR2xb5M0qqYzbleZcjHx7aZdx8jsnY7neU0EgoR3BECFYkge6msnPx
         45lQ==
X-Gm-Message-State: AOJu0YyINxXZRSBs4h1COEt7MqbEyrLd8ZxdWDbv3cq4MmuKG2iK4gRc
	w9QBjHRpfRYfP57PzTTsw5y8dnVNFezZCm8IeRUGV+vtpwbExtKJ1LfXRjaowxM=
X-Google-Smtp-Source: AGHT+IH4MuIST3OZKWrIx2hkCU7uyNoN+FQYg9OtcHZuiu5P6ktzot/euCRm8UR+I2yXMtXn0jPunA==
X-Received: by 2002:a0c:f987:0:b0:6d1:9f63:6d5e with SMTP id 6a1803df08f44-6d19f636d86mr28353386d6.10.1730203676814;
        Tue, 29 Oct 2024 05:07:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a83a7sm41396586d6.41.2024.10.29.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:07:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5l0t-00000000new-3egT;
	Tue, 29 Oct 2024 09:07:55 -0300
Date: Tue, 29 Oct 2024 09:07:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Message-ID: <20241029120755.GK20281@ziepe.ca>
References: <20241029112302.63639-1-joro@8bytes.org>
 <20241029114201.GH20281@ziepe.ca>
 <ZyDPHtJkMdlVRj2N@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyDPHtJkMdlVRj2N@8bytes.org>

On Tue, Oct 29, 2024 at 01:03:42PM +0100, Joerg Roedel wrote:
> On Tue, Oct 29, 2024 at 08:42:01AM -0300, Jason Gunthorpe wrote:
> > Strange that 0-day didn't flag this in my trees. We really need to get
> > 0-day running on the iommu list too :\
> 
> In general I agree, but these issues where found with
> allnoconfig/allmodconfig builds. Or in other words, compile tests I
> expect patch submitters to do before sending changes my way.

I don't necessarily expect that. We have 0-day robots to do this, and
they are more effective..

Jason
