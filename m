Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DC14EC42
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836611; cv=none; b=biVqpr2a2Kvsx5Zx+5QEJnMMDUgXxegebXUCOTTIsrahbEefeTTBbsc8FTjatvajdyE45HlLwmqX11uFCXS6Pxwax4opRnfZ+bIC3rOv/4G2KefU4GOyIAa5QWQGAk9e0ulk/R7Bue1uWlSphWG3iIr8WY3x62P+ZuXpI5tUO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836611; c=relaxed/simple;
	bh=OBrX2SPJ/cy3El5dwOb+gA0sMiQmSueLxgklcEUTSzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iprEKnpY/mtOMnm/WB+xzHd1MstwjAXLydcKTLQ5qsSnzNXg4WHTErLjvxxORi6oqvatHrApgC2um7ECYDYFVUSqBkhJpxic/5AszbshVv+Zy/NK/tD7+fcnmZgspASIiM105M5blfehJ3pt5UTsX1z0ZdwjprXsO3SC8y6ZKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JmZQW2mU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JmZQW2mU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso2448822a12.1
        for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836607; x=1727441407; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRXulz5VMdOActwNuWRT+AsW1pBw6lAA7iZwsxIHYO0=;
        b=JmZQW2mUhRd+wAOYT0tBD5MDz/J9NtLaOVJ6o2n8LTftT1U0HQ3DVZdggW9lrpJiAw
         ioVN8aMepE1EOepppeSuJPsIb+PFzmUPfl5MczZWPSZkI7+/EEbWD6Om53cF6n/ItFG+
         oEfUVaS7eWCkAQxMiIdTSd4iSu8ge8oWMOXvpimOqineK6mDh62xzoFrfSJlTE6KpT2m
         t9VeboT3czU4+HL9PHUAdjacJREdL2GNbhFg71wRf5huxtPDThpiNnFIpeOEBG2v5Sv5
         tI0RJ07YJVztxro1bfqdflp601GUN0Ws79j93FYkzHfXDhUgmnwKFTaVi+3kaBSlck5I
         v8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836607; x=1727441407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRXulz5VMdOActwNuWRT+AsW1pBw6lAA7iZwsxIHYO0=;
        b=xLeJ+U/lQx8lb/3M06IjmVZPHmfhoeQb6F/8AIzj2RQespOTJco5st/5f8QD+P3W5F
         R8imVdOwzqVsjb8PRXCJp9Lhdh/FGndS9Urwno+WaT1pQb6eWtSjLw+1L5Kz+jiBjaaN
         HztP4lQcNb6TOx2a205twnDg98TnmugYzCX/HuyDlTUtgj6OhqDQXrnsuA2TOEIdUGD7
         TGzji0lAoyeMfS8OAgSF83FP9HTE+hXNfkunqomccz8BPUGGDLYrQE/FApZ/Gevfqmcc
         tUpuJ+JvBPcHzpd5vBXjYqGihaDgEaDAUNyO47C7qZPWsccE3o4JHbP0UDfUdLh3ksEa
         58Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV/T0OHFL+7Cukh20jvuhOZ1jcwz+bw7bmCkJ29J4Awcc2zFTzJmJc5fd80tHCeqhvMuE/DyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcrhSvRFfeNMcoRk6kq5WBPtnoerRoDnMdrnC3yVLGTI0bcqqc
	Bq5XdPmuAI/M/337HXosfu9YALnWOKwWBNEQzKQUijg44zkVotL1bomrULRhI/Y=
X-Google-Smtp-Source: AGHT+IGLI5JfAevbKAytrlds8J1QIXfY6Ge4HV9Rl/H/KbAR0IgFYHFmb2dXYfkU7QHPZn2hH+C85w==
X-Received: by 2002:a17:907:782:b0:a8d:2ab2:c9b1 with SMTP id a640c23a62f3a-a90d512261amr243385366b.56.1726836607080;
        Fri, 20 Sep 2024 05:50:07 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4400sm845161466b.84.2024.09.20.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:50:06 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srd5J-00018q-Fy;
	Fri, 20 Sep 2024 09:50:05 -0300
Date: Fri, 20 Sep 2024 09:50:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, nicolinc@nvidia.com, mshavit@google.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Convert comma to semicolon
Message-ID: <Zu1vfRGrBTfEAivT@ziepe.ca>
References: <20240919035356.2798911-1-nichen@iscas.ac.cn>
 <7a532573-9e59-41c6-bf57-f50cad502e57@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a532573-9e59-41c6-bf57-f50cad502e57@linux.intel.com>

On Thu, Sep 19, 2024 at 12:45:18PM +0800, Baolu Lu wrote:
> On 9/19/24 11:53 AM, Chen Ni wrote:
> > Replace comma between expressions with semicolons.
> > 
> > Using a ',' in place of a ';' can have unintended side effects.
> > Although that is not the case here, it is seems best to use ';'
> > unless ',' is intended.
> > 
> > Found by inspection.
> > No functional change intended.
> > Compile tested only.
> > 
> > Signed-off-by: Chen Ni<nichen@iscas.ac.cn>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> A typo in commit e3b1be2e73dbe ("iommu/arm-smmu-v3: Reorganize struct
> arm_smmu_ctx_desc_cfg").
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Yes should have a fixes line, plese include and resend it..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
