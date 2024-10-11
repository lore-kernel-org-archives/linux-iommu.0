Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBF19939E
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664218; cv=none; b=q7dXwHevMc60Y+rqSOw24myhXDaL7b9TJFgb3sCco7LvhIPFMKny1do8Psh58QHlxCutMXxbgo8IwSmynEkBNxlg8mtAayBYq5cmKW65dgdNQGykp4jTxts4mrWEMFftDOTTeZH7v0zbjWKki+DMOy/MCi3HCr05XjrM3bPjI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664218; c=relaxed/simple;
	bh=ouMRHIXhivuHHZGJlG3Z44V/Huuo89hdE0o6BXQHi2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjV6K/MAHRaNefgKSN2e/wjABtxVwZv6P9Kbdtev75I0ccA/OjBKAh+uTEyMsDGafxVSRmq6Oa8VthWJy13EnXyNjYva0zTp/ZIrpJk9mp64j2/etayB5bZM6lWRevCy1ulF5+kzZmXkEsjbrETs21Pukf1DXhTzirIimOvTOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=egoSU+Le; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="egoSU+Le"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso14419686d6.1
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664214; x=1729269014; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPhAadXb6deLzT65nScMA8kj+FFthnCaAO8bn8FgNrY=;
        b=egoSU+Le2ZTF2dDJLFXrHAiUqAzrLN8yL9kmO/Qp+HuUcMldkYie2liJHZQVCqHYFF
         hk8ze4KM3dcAhc5rRHEtH8WPg3cWS8wDMLb+lJ+tN8iX4qjDKc81+ysR+NY6uNc/X3R3
         AbsjWQpqRtYoB+14nduhVo5wu2biB+U2X2pJrWFnFrgi4J5JHl6iF5dHEqUkbPMbxvB5
         e2v8ackZsqPP7Uj/3K9S7DQo0RYt4lB0J2tKNFtbdF7tgYz41XT6SIXWsldnMsDAg39u
         Kl/e7plBP7tm1z54sh22nUf5+kzXdNNmRn6gOvzeOfKycH47nbHPa7SS7rqwktIrJkw0
         tXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664214; x=1729269014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPhAadXb6deLzT65nScMA8kj+FFthnCaAO8bn8FgNrY=;
        b=O5SqOTnBbjZnlWrafVJeEjC809LPg5h5JpLQWe/yNUeiUcOstsWel0x4NQH+9Ijm2u
         u/41uU2J82xaXhqB7JSOx9bA+/GKWH2NhjuiYcf0CZRhRNf46CD2r0plJYiNKsROoqmi
         VondtRTnCE7K3wNcEnRQXU/CsCbXbWDnhCer0VgBEuVdZ0+uy8fD5KKTnF5NJc/0juRR
         fTfBpa+oE5tBQJb2RGupEgt595vhZXyTzBE0xQTXzo+RanOA+D0LxxeBpUiKxjAodR/d
         qmZXyZO3YpifnHC+6A2AVC+i49t9+xj2yGGeyewc6ig+EicYeM1OjXlFWiTmpJkHNvHu
         begA==
X-Gm-Message-State: AOJu0Ywo9iMSWCoFanZWyS7TT6+1loiWccwjhMHyVfKDapUwClAvcoJF
	emiiTBcEyHFDB1zFGsQPlkC2fTxGvYEDBhZmU/jHtu/gPtj87ykw+/IHljdXUK8=
X-Google-Smtp-Source: AGHT+IFVYjgNGvbnm+fz+S+roYIt0msKBxnq6ZqbWkjMoLLY6L7C62MrX3NFxmjayxzvu7T4CrAADA==
X-Received: by 2002:a05:6214:469e:b0:6cb:a616:7c7e with SMTP id 6a1803df08f44-6cbefffdebbmr35637696d6.2.1728664214289;
        Fri, 11 Oct 2024 09:30:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b79e9sm16838466d6.32.2024.10.11.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:30:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIWq-007e0D-Tu;
	Fri, 11 Oct 2024 13:30:12 -0300
Date: Fri, 11 Oct 2024 13:30:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iommu/vt-d: Remove domain_update_iommu_cap()
Message-ID: <20241011163012.GM762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-5-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:19PM +0800, Lu Baolu wrote:
> The attributes of a paging domain are initialized during the allocation
> process, and any attempt to attach a domain that is not compatible will
> result in a failure. Therefore, there is no need to update the domain
> attributes at the time of domain attachment.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 83 -------------------------------------
>  2 files changed, 84 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
