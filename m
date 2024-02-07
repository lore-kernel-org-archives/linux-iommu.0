Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD847E576
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317821; cv=none; b=AMNCBDu0mqBQqMWVXusXapoKYS3c7Xy7Z6e7NFA4JccHfxRqxa5j5rYehwdvkCT9rXN+nyu24ZdvK5KdFRm76jNyLw5Syy9sDW+R7C/gGtZGpY0kHDvYWVWPd/HlLqzLCixX8NWPw2BTK1voaDvksESYCYY9XJ77h5NTFS97GkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317821; c=relaxed/simple;
	bh=/qjE+nqSpEqB34LHfo7cPWwv+pZ6RnEWm3Y5iE2Thd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t00F0GTehCcPkvTZv6yXkmtjP2J8t0g6DXM8PBKFTJPIi+XqXs6d1Xm5KlI/icjbvuQYqGyudnfPzBLL9tpgid7Ua/rB9V2vXAkNg9NUInDItn3KEdC4nKQ/v2r7ov2B4QuARFfGpxGLHxFVgsI7cQsEZqRaBcZzGDlQKwtqdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KYjQyEAV; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KYjQyEAV"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3be61772d9aso333269b6e.3
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 06:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707317818; x=1707922618; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0M3TTROdnQ99LEOVazWVIVuG+en6VXt1COOl14WDc8=;
        b=KYjQyEAV9JAABSSmOk0e9z/fHl+A4iC58hRpdpb91p1Nk1b04+oc8yfwp0q56LyF5A
         Mq0jhJnNBB36L7KiqTETPrNNWo9Dxz2WD6SLn+q2RmEgfoT47id0OoE2CNGlGxwGoDtm
         KXv7O+A9dmA0y1ls7f4NXDIaV30X5B0v9kfiR1pZfCOmwxCGe8hJV1Tvj/p091diqlTX
         X1IMCNgv8yGTfnE6wFiHdCBmDw9MPfOfOCcRd/cBT7DrIjGqlyFUsxbbstvbuncQBbd7
         jIMlLxLC13dNTO31raNHQnT9xN3oNks+cLp37r9WP9pW8knzh1r9Zs/JmitQk2bOlzNn
         EbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317818; x=1707922618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0M3TTROdnQ99LEOVazWVIVuG+en6VXt1COOl14WDc8=;
        b=huauhBZAttKpUqb8m4Di+rtXlyk1NFUv/BRK706nOeXex+MEgMwinKomsvAwzZ740e
         JTVKOwtcUJGNXErzOGnX9yRq5FYCmdvt8KfW+jM4v7nnF7EHnyPBt90XmfOEDI0DbmKF
         DGY1V221/S/ETKMKh1R5X+embmPIqIFdyeTJZdXNDUjcmjUe2DSArJcsmrG9lBZx3ssk
         Xvrdn40WfISTUhxy5WNW78QkK30DECFdz6EyEXNwmXvdtSK72rnjeWsdWOti0e+60II0
         jp3/DuutmO22RyDq5vmXFcB9AkSY0C12mOBQ7TdZpObVzK/hIozF4P4I3c7mD9eIcZKh
         wXlA==
X-Gm-Message-State: AOJu0YwcDfnl8BlhX73JIvujXUsZdjS6i7vbkvNJ/XN1vQPqPf3eqSex
	KGIRUHROdDDLgcM7y2GYuYx24Ys92xEqhfj3XkL+2EIrKYw9j1qu5DwAN8uTIt0=
X-Google-Smtp-Source: AGHT+IH0cGhGSUUEHRfNJyx46hgtKE8MP2Q4bijQoKH/+hSAOGqsrBm8bmc4wOyxrlNBdW++URiPlw==
X-Received: by 2002:a05:6808:228d:b0:3bf:e427:d11e with SMTP id bo13-20020a056808228d00b003bfe427d11emr6918880oib.27.1707317818498;
        Wed, 07 Feb 2024 06:56:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8Vl0sHpxqYNmb3IO1yaxSDS8Kwsbp3SFMBoVHT0KITNM8mecYYn7vRx6DgxJfxVsz+8az+e0iU511lusFO7VEXsStZrpyPCtahqJFSKIGp8qCQyhZ0VBPq9iFSzT5sLyGS4mfU/JS0TPw+n5X0EUOaI1UuaMhwyQbc2p60pV8YqEJk9NQa9hCOGfMvMJCYaBBPATZLFVDBMKCOu06L4Izdao9SVg=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id es11-20020a056808278b00b003bfe85d3a62sm205325oib.38.2024.02.07.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:56:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjM8-008VpY-Vw;
	Wed, 07 Feb 2024 10:56:56 -0400
Date: Wed, 7 Feb 2024 10:56:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240207145656.GJ31743@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
 <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>

On Wed, Feb 07, 2024 at 07:56:25PM +0530, Nikhil V wrote:
> 
> 
> On 2/1/2024 9:53 PM, Jason Gunthorpe wrote:
> > On Mon, Jan 29, 2024 at 01:29:12PM +0530, Nikhil V wrote:
> > 
> > > Gentle ping to have your valuable feedback. This fix is helping us
> > > downstream without which we see a bunch of kernel crashes.
> > 
> > What are you expecting here? This was fixed in Linus's tree some time
> > ago now
> > 
> > Are you asking for the stable team to put something weird in 6.1? I
> > don't think they generally do that?
> > 
> > Jason
> 
> 
> Hi @Jason,
> 
> Considering that the issue is reported on 6.1, which is an __LTS kernel__,
> any suggestion to fix this issue cleanly would help us a lot. Right thing
> here would have been propagating the changes from 6.6 (like for any
> stability issue), but considering the intrusiveness of them, is it even
> possible?
> 
> Just to be open about reproducibility of the issue, a bunch of them are
> reported, both internally and by customers.

I think you need to talk to the stable maintainers not the iommu
upstream folks. I don't well know their policy.

Frankly, I'd suggest just proposing the necessary (and tested)
upstream patches to 6.1, however large they are, and see what Greg and
Sasha say. This is the usual working model they have, as I understand
it.

Jason
