Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011B211710
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460822; cv=none; b=TY/2sSR8uDDtxDPInUb5q6uQUBcACm9khchelNVliuGtoGNARpMEutdwFiF1dbNDD7mYksI2s5vS95L/UuKbeoTvmeUf1rXPROBI7JZCVo8x/HUM2WA6SSw8dFQQaCTgMy907/236SknzeQcy8qYhUmWg6XYyBnXlFfPt+0WLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460822; c=relaxed/simple;
	bh=y3Cp/rR1QpScC+x03y/C76tenIDZqGYsuw2cyuaBGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ1ZR4cOWyXS84d7fOPkUuIssc4IAZJ7y4sbwHGIa4PJRArne7Fwvlnsq0pThTHEsHzr7GZc7FINFqAHGBc9AhnfWe1K3K3jvKeM3bnlqTsqYM8SrQL7hKxgJ7SWg1BL+49xytgOpG2jEOD+8AY7KhruJS+aL+FLOHQLVcsqZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZqkti8f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZqkti8f"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so2754535e9.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742460818; x=1743065618; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KnFSXct6epNrQpkkv+yjVEVzsh1c64Flg8Y81A0Hvc8=;
        b=bZqkti8fFGQuaVp1O8+/N1fVRII4uBWp9SZ26ksXu4mgB4McxUMJaCvL8NPG3qlE63
         QDSXmvyCXl2oKRNBlOD0Vk3FfwCIQxIWwertWRZd2HAZkRJdfPxdT9ze+gNhu79OmL6b
         1m/kreCM77G2xEM2sdZJ0zxoLF03Pi2WM0rRLK+18a2mebo5bygp/GS9NqRCVTuEPVDP
         6q/VJAhTIxJPTOACqABhAaWeJrwuvxU8wWGGKhClR8tCFddgLbkZBU/j1na1+HkvPj/Z
         vQWpZZsBzhiyDpdT2kGy9Gf2mQ46eFbYdE2TTxT3BnzC7sKkaYlJ8GQ6iRmeihx+/hmC
         8lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460818; x=1743065618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnFSXct6epNrQpkkv+yjVEVzsh1c64Flg8Y81A0Hvc8=;
        b=i7m6v+nO/cKtKkXERzqjaI8HDBmFIlWwYqs+tz4ug9BSd3a7UG2o5ALAOWSBHu8rXr
         HqHaV8/TRsmKNtFrQjZinMjwN6dIcnmLIkt5swEulvHcmQhrByl8wXrv6dz87kp/h4r2
         rUAi5fK5hmzUP/GyW4fMm3hsq1KCMIdGXGHDpYOD+0/XPjgI2gbwDGOi4H07B++raoI7
         iZkD7S5HQV/sAdq0Rrd0ocyt12ClrqKem12olg4QZNoEdRJHyxoK1KzQT8CYDMUu3ZXQ
         ofHzCd79hHMeDZhTe/UNxPnsjZc3e08eoVc243Ex4ffJ+BKSKfYMXHHJedMyd2pkVoet
         dEFw==
X-Forwarded-Encrypted: i=1; AJvYcCWWD9eXfEdJ1emXrE07oI/b+CorI+WkeYN+7oM0Tdy3MD/fGOX8CE3vwDwyeOPgN+B/Dy85dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE7bJGOkw/iTFKj/356NGnmfS+ZmGFk4/HQHyzZUXPkd4qxpXS
	BYyIQISaxxhufZLDahndZeT2C3FP66rRoUNpwObR8JGoz0n81FT9vpnS+vAkmmY=
X-Gm-Gg: ASbGncsTbby2fIaDxxIU6yqVPq0pbGz1U2mUimF7I2GBPLR70n0SYUZX22tBbISGOJ3
	IpJUFmA8GCMA6EyFnWQrASrQ81SAvdc6jRauYGSbVYelG1rlBAdFzVO6CL0YkYxq3VNKqDU3TQi
	wn4g+Kna8V/kal4Xvom/l5HD7qeNfjksLnNb1h9v02shOkeGlX7Ah74FjTw7h8UqH4fSb9yNpwD
	hLXWUxv/KerAG1HeniNchqxlEw8WsrI10D63VIbKYbu13k9Yvn2rsVeOg7uFDQiDNC+7GFZhvGG
	6r/kNVspE7uHKQEoFWlgAltXWGRct3gfsDs3361xQP9HIzmbrA==
X-Google-Smtp-Source: AGHT+IE5XfB71cllV/n5EH1T284eA4sduFcvd6HSLYQ1/iWgIzjCRYet+uoDCJ/LzmZ1nTW11RBTYQ==
X-Received: by 2002:a05:600c:cc8:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d490d2411mr21934425e9.0.1742460818458;
        Thu, 20 Mar 2025 01:53:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f37665sm42436645e9.2.2025.03.20.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:53:37 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:53:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/amd: Return a literal in init_gcr3_table()
Message-ID: <f688c2a2-a4d9-42c4-bf09-5ecbdbe9c9b5@stanley.mountain>
References: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>
 <faa7edf4-a757-4390-8226-2604ef6476d6@stanley.mountain>
 <Z9vLuWvzVJOyuuWu@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vLuWvzVJOyuuWu@8bytes.org>

On Thu, Mar 20, 2025 at 09:03:05AM +0100, Joerg Roedel wrote:
> On Mon, Mar 17, 2025 at 09:43:32AM +0300, Dan Carpenter wrote:
> > This code intentionally returns zero but it does it as "return ret;"
> > Returning ret looks like an error path where return 0 is more
> > clear and looks more intentional.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/iommu/amd/iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index ce2626801ddf..7cbcc4933c8b 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2150,7 +2150,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
> >  
> >  	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
> >  	if (!pdom_is_v2_pgtbl_mode(pdom))
> > -		return ret;
> > +		return 0;
> 
> There is another case of this a couple lines above in the same function.
> Mind changing that as well?

Thanks.  Happy to.  I'll resend.

regards,
dan carpenter

