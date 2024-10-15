Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E31F76A4
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008783; cv=none; b=twI8Xp72bonu1jGpZUIqyLupGr82Whjh7a337r7EiLL6sTcOIWNDyqK0gWW1LvjVbTNZBceSRib/5pJNxYSsfY37Wxs22WD1TsCfNUXn81bOgL3nAcF9v/5rU/f1cEAgqwXkUDizFYN6En5x/3coQjQuA7PzUmuNb1x2hZ7xBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008783; c=relaxed/simple;
	bh=Vw/mrFNHwGX1puvy/afLyrQYEorWzsNo4hg5/7t1KY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq05fV2ywN6oiekFf1obKKydA7rSh3imtDnTnPFXyp+r4IO9/YKO7vYLilzkNd4/p6ZmuHxvAMyclAui+fXPxsCMQgrq4p8c5nT7njaMWWKek7u7BpWPAzA9OiMNw7wqtQtqPjEa1og14mJDmIxD5lKqSG8XgUezcbLs9HEy1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IEB1+Q7s; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IEB1+Q7s"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45f07eb6f5fso51141971cf.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729008780; x=1729613580; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVWh/tiIYKXqvBSyTiuwmYcBhGV/hVL1sZ2dOM/2U+k=;
        b=IEB1+Q7s7zZyBYpiwdp4nVmexIszhEvIMh6Yu48lM4Vep+LLJQ92XiD/aAhk8x+l1X
         c4aD1t9/X4rFthzea17KgFVGizzGdzKVv7b8TyxQjOpWOC9sY5mIjio79+AnwO7sXr5G
         RoXRZHu+N40TM+joLrf+s5aJanVww6zVqfOkUcwO7evKR8FSagFoJ0yDy1aBR9GREDKR
         qewLbk2EkLPwM0OWG1LL2Mu2+Na4pCQwiegq4KxN1f9uIpo+rvdGgfM7cCny87RLFqqr
         fw2i6kbkmgbCdQgqAVC5oXBxlRtobpCOd/LAodVxPplDw3ZhuhK+NOjnFBgipW1d0S7U
         TApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008780; x=1729613580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVWh/tiIYKXqvBSyTiuwmYcBhGV/hVL1sZ2dOM/2U+k=;
        b=Eg7U+3r0mNMDacqYEYoHpzRg8Gz+NVBjyYRks9+eXSrCxRYnrBfxwCXYR/Q2afPEyt
         d2dXsqtwL3wPRs0dTSMhKFg2m2qlQIEpD4Scz6bTd6vPGRjebz0rjUEhz5yH4QYiLkf1
         gh4n5HcBVOb3X7wWyzt/tuAm3jH2Wld/Jrw0MGx3ZjPb6UoLcLOGSTmYZdIbsVP2bIp7
         zBrNvYrSF1BDS0HF6XCGyHvlqpo/LI8O1wClpCwypSsMt+2+JrjcgXzktHhvGA5vYUiK
         L+N7cXOciEcE9NNk/lKTodXLsT5wUPnFoeU3zCzHfTCg31x5psQeHVEclQeES6PKQsZI
         VFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIpIT0dyrqvZio5tftPtCSDwpQ5e4q+3exMjxnIHYGhkq8xMaGe44OM7DCIkzpFwop+b74sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxahOjCMRGYSP3A/T4D+3OZ0ofGuF0SqO8mevSyBLn7uGkNtpoI
	4eTMBkmRVlEVuKCGsYTla/9haLf3mhtrNtWQ1NWJrE2mnBc5tUniAXrJiBX2mNs=
X-Google-Smtp-Source: AGHT+IF9R1ecI2BuQn7YtpVBXtF1Q8KuLSoMEXaFgWwBik91z4LYaGtRUFygn0WtLUeb1wxii6bBsQ==
X-Received: by 2002:a05:622a:1483:b0:456:919a:11e4 with SMTP id d75a77b69052e-4604b2fd3cdmr245238231cf.20.1729008780476;
        Tue, 15 Oct 2024 09:13:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b4a0882sm7920331cf.95.2024.10.15.09.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:12:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0kAM-00Du7w-HW;
	Tue, 15 Oct 2024 13:12:58 -0300
Date: Tue, 15 Oct 2024 13:12:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
Message-ID: <20241015161258.GN1825128@ziepe.ca>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-7-vasant.hegde@amd.com>
 <Zw4p7Gc099DtQ_f1@8bytes.org>
 <24421a38-3d65-48bf-a40b-7a5b15f9b1fc@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24421a38-3d65-48bf-a40b-7a5b15f9b1fc@amd.com>

On Tue, Oct 15, 2024 at 06:00:25PM +0530, Vasant Hegde wrote:
> Hi Joerg,
> 
> 
> On 10/15/2024 2:08 PM, Joerg Roedel wrote:
> > Hi Vasant,
> > 
> > On Tue, Sep 10, 2024 at 06:58:08AM +0000, Vasant Hegde wrote:
> >> @@ -2119,11 +2135,8 @@ static int attach_device(struct device *dev,
> >>  			 struct protection_domain *domain)
> >>  {
> >>  	struct iommu_dev_data *dev_data;
> >> -	unsigned long flags;
> >>  	int ret = 0;
> >>  
> >> -	spin_lock_irqsave(&domain->lock, flags);
> >> -
> >>  	dev_data = dev_iommu_priv_get(dev);
> >>  
> >>  	spin_lock(&dev_data->lock);
> > 
> > This patch inverses the locking order of domain->lock and
> > dev_data->lock, have you checked all places to make sure it is safe to
> > do so? Has this change been tested with lockdep enabled?
> 
> Sorry. I missed to explain this part in commit message.
> 
> With all changes locking sequence will be :
>   group->mutex -> dev_data->mutex -> domain->lock
> 
> In defer attach path (iommu_deferred_attach()), core call attach_device() w/o
> group->mutex lock. So I retained dev_data lock.

deferred attach is broken to not have the core code take the lock, all
most all drivers depend on group_mutex for correctness.

I think we should fix that, not retain unnecessary locks in drivers :\

Jason
