Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F02594BD
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505236; cv=none; b=a5b4Y3AE7mWGp+9kY1G9Ran1eMwRDjxKDIjt6b3pFZ5/TDGDRNmaq7RzWCsuyFqBji1x+xXyxSKJTYsr2IUk3RcBTpWDNTydAS4BfnAyLlJ2l19HH76kRwMLScTBmZM8WZx07kOzX7TNbLEw0KQOwU2nY0y/BwChQsGMR0PWyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505236; c=relaxed/simple;
	bh=BqSpm8PNCUKVTxH8J5CRGzEctolfXeFC2z0fNOKLLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+WTqUOYbNtHGISp1VLxlPePz5YGAPiiLmoxzL2zBTk7wzoDL6F8VpMHfLLrMKOeyrOgR1RDeTNTeFlsYwxMZidamZtVGeYroku0gUCZLu8qkYtG8V+dzygx6ZgDQjIay0dzkk2T89NnR4RJLgjnWm5hYnP/GeOV8dN4aFvAEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E47UfOfY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E47UfOfY"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab5e2ae630so17113571cf.3
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752505234; x=1753110034; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K43Yrdtzk3WuRcwS8KJIPgkGui9z8KNkHJx2gzTT56Y=;
        b=E47UfOfYHpAUdfqyjschbgUEDAYistnr41wQj8mTd3IwNpSh2TVHWHVnCsgq9nLQSU
         /enLCpWqN9zOHGF1JO6BlLVIQZN3saC1L+Zq2iIhi617e/WGACMwW8642jgP0LKK4HfU
         cGaXV/A/9wVbnjsXcp+/MNbvvMuqhU+16f6FXiGbBxePSDOvchM/BVIaL3lz5BNV2+Cz
         HhbBj1XaBiTy44kZWtYmPFsBdGWUiqku4CbCQYa+OUsYv3L/7/f8g3NbNwreAReB0Ks+
         duVBNGJ8rrQaucZY4AFwFJq8imTIthMCvwUKZaCljAzGElc9OtXluLJVg83afMFYxlzn
         G8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505234; x=1753110034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K43Yrdtzk3WuRcwS8KJIPgkGui9z8KNkHJx2gzTT56Y=;
        b=AqA/zqGBoHAvn7ldHtX2Qa6yWXYw9RIuQyPxjyGeYx6E5omi31y11BqDGBlSIX7NkD
         ucTmRq+Kz9Fhz5WgsavjwIAuCpwuwMpYB3dl2acRztjG2myQ/bhx4mZtrPPTCX7Xg79H
         NA5Tq8SyMun7Zx+n63K5TjQI2FninVdBdJyUf01VXS/bqYp2yDa3rXCb3MzT1bhuwJqP
         8nF0EnSbbsielJg0NeuByhQ3D2J3Q9ydDUXSqjNIRGOkBPqQ2txpXX8s9wLaUIf88QiM
         98QPyF5e+Ql8ZryVIVQvC2JdoaUVSDQB2QMVrMWl5irZiYZKqxINzD4mPHbpHbQ9gNgs
         ztoA==
X-Gm-Message-State: AOJu0YztLxC4XP2rpf+OtR2F3YAlLm9Ue4enDpblHIEN2Tiojdwk0CCD
	2ImeFCoYedwJNhHgmg/JPuIM5YmQgS9u16tE4heMA7MHQO4XNRpO7bH8n5NfVKLOa7M=
X-Gm-Gg: ASbGncv7SYTcQUfNGd1xH85jkJLHuOm+lTwPgSKLaOQl36tQfEHUbrTWPRSOnQsKWcQ
	BsCipbjZnUjVRoqCkvRIIRCHfMDGIE4UnwUfi+X0l7gB2BT4ODrMy0NaqM2yZcLD4Q7QYay/U1Q
	PMNlb3HUdeEmmZm2JF9UHbiwcWvIsYMgzGdetNqckqIsWXQLbwWcoZb0AkEWX5ZBgeRNBVjhlbU
	ATHCTLN95MMnRcemY/UIgM6AK3KFEvpaDV0iazsn//UQQpZCELl/SZI1a/Wv1K3qFyHg65tdyU5
	mgTpQB+TmOsCDSQFdxZ7fClDEkZcw8hvTUhdeEyfE6ZcHqwJiNCyUCTkq/kX850u9OwQl6BLS/a
	8Q6BE2K4TP3ACe2jpVGHGxutVBYoVWWmR6fpy/x60AEQCnrJ/Bemd0+ht6khpGmcC9cDh8f5dQQ
	==
X-Google-Smtp-Source: AGHT+IGa7iUOIBOxm6d7Y54+RFCrKYNbdExiSoR6+R1Zbrt/FhZARF3G8J48ACQJndBYr9rSmihssQ==
X-Received: by 2002:a05:622a:5a93:b0:4ab:6c5a:1fe7 with SMTP id d75a77b69052e-4ab6c5a24d4mr65558691cf.52.1752505233674;
        Mon, 14 Jul 2025 08:00:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab5823310dsm23562841cf.2.2025.07.14.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:00:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubKfP-00000008g49-39Yr;
	Mon, 14 Jul 2025 12:00:31 -0300
Date: Mon, 14 Jul 2025 12:00:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 4/4] iommu: Notify requesters of IOMMU fault failures
Message-ID: <20250714150031.GI1870174@ziepe.ca>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
 <20250710134215.97840-5-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710134215.97840-5-sergey.temerkhanov@intel.com>

On Thu, Jul 10, 2025 at 01:42:15PM +0000, Sergey Temerkhanov wrote:
> Call the notifier callbacks installed by the device drivers when
> failing IOMMU page faults occur during the SVA mode operation.
> 
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

It doesn't seem to me like any of this is really needed..

Look at how iommufd already associates faults back to its own struct
device structure side-structure.

I think all you want for this problem is a way to hook the fault
callback chain on a domain, and that should be local to the domain not
global to the device..

Jason
