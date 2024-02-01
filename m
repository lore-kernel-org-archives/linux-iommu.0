Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479386FB9D
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809113; cv=none; b=Hl+Ky7qResEu699OQHnGq5wIARjtW27I7RUsJrMGL8yzZwrLlFRvlHOXopm9iEn3kRsuC+eb/HeGcMKkiVYLJ08NcNfl0710vnn7+yXPmNkGL3kEjAx0ivtmP4hQsXzsuMfP994sSGI9JzzQGaQ4WN20mQXKLK6kV+g71oYFZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809113; c=relaxed/simple;
	bh=uN05oQipSF2+HJNixlmUoLZ2EhduhVgF+m/6jNk9lkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g49N7SDFt7x9BTPfVqModrOYd9LikRdkUOuVNrObo/PcGFrPePFNIls9vOMik1IZo5wHmO2zKDD0Xl8EYV6Jp3POEKRfHjsZT7SeFgYcBhoea/JkstJ4uckzXm1q2tB04nqUPoKOU1ZWJ/TeHhFU7qgjvsXKHFO2b2uu+ic/2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dj3XaBxx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dj3XaBxx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a9c21f9ecso6518661cf.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 09:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706809110; x=1707413910; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ+x1eheo2V1bM2tCyvsRK5IaqR0gxAV5pDawtkF0Bs=;
        b=Dj3XaBxx8qxsAKBBGTmmkZJYYuGz5GmzNwTfKb7KzYJBGhWpyEA4j9dEE842po9D+1
         DR4xvsTo0zQqh21rTyosgc3P2qGro08sN1WF1yORfAjzxwCnh2DxzHH9LeRN6fsGPi2D
         dvPIF1BLrpQzPCNizfIOgI/eAL+dSx0clwcEm26MvO+Ap/Yyf1OBU9DPMVxFhexX0X/D
         CpYxq7iSEwUAXVMyukZCJx/s1feI0JbXV7FXG6zXtRbFSgfI7OlJcLd01EmdnquoIp71
         ski9HlbWGub1ECvDN2ABCgwd48MNrqDjnhj8IamYFLewg0ZVmm9bCuIuLsqGGif0gZRC
         k7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809110; x=1707413910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ+x1eheo2V1bM2tCyvsRK5IaqR0gxAV5pDawtkF0Bs=;
        b=YzI7n2HXZXKSA+04Ba4IcsQIdJzVISqx2vAH1gROdbpow9XDhpIzdb5eaQxPD3hI7L
         2OKO/Iec5saL9+2n8cQH6OS0bJIMDAs/HXd1R9DWwMFiUF3R8tyDHwTSPFJnKQe0GvVK
         F7634vRg9IgiZld4aBHI8SR6YfIw6Bxo0eGo7rHWLq/+zKPlC8Pj/10MCXOo4e4uHFFY
         c2X3yOutsxE7qQbUYk9zkmSBPfh6zy7T6gGzlaMt9oZ9U6UqvfGTegR3RWQ13C6i7Ma3
         RAYiWXUjite3EXhzylAudOBeFScG8ysmJfkar2t/fHAunBBhtoCfueCcBfhVmNVL99qi
         niUw==
X-Gm-Message-State: AOJu0Yx+2iBZX4lKPsL+AznRhvY2lvq2yAYRrkCfv+e6XGrRBOKnN1MW
	edq8kTWeh9Cktk+qLf6/R3XYl9quXd3LudQlYH1dQkkc/JYHfVid4lv4AZTsNCI=
X-Google-Smtp-Source: AGHT+IFgqOjFSqnA7uxFbEqjjyPGp9hlmeA3EwVIEsW3BEBnggNv+ylPrKbmZmgT6Bnt5/y/Xt9F2g==
X-Received: by 2002:a05:6214:1c0e:b0:68c:3ad7:517e with SMTP id u14-20020a0562141c0e00b0068c3ad7517emr6978490qvc.14.1706809109912;
        Thu, 01 Feb 2024 09:38:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFc6JV0EPbT06lTO6ZXBR4fNfbH3LDvJbLU5TZaBzcNQQ2dOJNn75KOLkpFD/28eVbKK9RmjAc//S3M+8egMThMv+tXCI0ForHxssNiY1686p8T+52Tl3MGBKewxGlffTrHPOfJ7D7Q8oDs2PMNDy0IwLatBzzz3KGozV9qZNXEmC7iETyOgQ=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id om31-20020a0562143d9f00b0068c657e68b6sm2476570qvb.143.2024.02.01.09.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:38:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVb1A-00AnGk-Uc;
	Thu, 01 Feb 2024 13:38:28 -0400
Date: Thu, 1 Feb 2024 13:38:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 07/17] iommu/amd: Add support for device based TLB
 invalidation
Message-ID: <20240201173828.GL50608@ziepe.ca>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125121135.8217-8-vasant.hegde@amd.com>

On Thu, Jan 25, 2024 at 12:11:25PM +0000, Vasant Hegde wrote:
> Add support to invalidate TLB/IOTLB for the given device.
> 
> These functions will be used in subsequent patches where we will
> introduce per device GCR3 table and SVA support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  5 +++++
>  drivers/iommu/amd/iommu.c     | 23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
