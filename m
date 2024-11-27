Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29352036F2
	for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740994; cv=none; b=fzcPPDFVtgW0u6qwPh9mmsbuGq0ux4nd+d2twW9CQhS7bQsZdTaTWRUQXHDgdiSUq7WyEdJMxmhr83ncrbIY4YtlGoPRaFAYAXe9PdsdHMITI1eDwaEnkuKC259sYQnenkauQu9yRY/3IJfjGHZ7bcFaga64sVBT5kyHfwMg2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740994; c=relaxed/simple;
	bh=L1copXaSWgXaNvjwtNHBNBYRyjwFku4pANsV1rzb5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo0Y+HuFfqpsH19q0Ffhk0+ouRCZWtersB6QGf+IAerZ5I4YiikeubWJDdrS3g5sikqfmhvfy2H+Z4AfjNCTc1hiH/yIvCP29ArYytQMSYwzJyul4vKGPjdvN+fx/tD4kh3HxX+3IvSBfRC+JTTKS6N0XrhXVjUn5fYx/X5+ITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNSYzQtu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNSYzQtu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211f1a46f7fso16595ad.0
        for <iommu@lists.linux.dev>; Wed, 27 Nov 2024 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732740992; x=1733345792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PV7VlEpchxWzzn0e0hf0fjk7yvk607eITmSez74tyYk=;
        b=NNSYzQtuVhaSXiRQ+zOWqQ7WP/3BHHza/SB770XckAbaGHmBGDY772kE+UolxNzrP/
         yYLTo9uiI7iEhGNzo8dgLrKgRi7J9TgbTiZU6uLHpfrPysKF46AO5NZxG+K5r6yp2omi
         STmYdQeuitKF6xp9ffasq87hGt+s1z0ywV1qVRoAhbPANopgVd2KTUPS7OfdkgHaq5jY
         XM5Q2aNgxtM1+YRynMALLrwV2Otaq/vu0o9sociNe00iuOVIGgewnl3pE36ry7fiquyP
         l49D89kj2ScTKBksKl6ijEXHr+7ub7NLxVd6YeBUA2ClxSVJU2/JmnIWVYXipnslMVqD
         8m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732740992; x=1733345792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV7VlEpchxWzzn0e0hf0fjk7yvk607eITmSez74tyYk=;
        b=qyUHqf3ScaEF6FT2MRVUZU1kvU9jeDjR5P3NOQwTFmA/fphvWiOaGIz22liOt9Gpxv
         XFer4zDmXVyfJL9DsuEE+IJFr3aJL8S/x1tPh09F+xySTED9ovXFi2nxvn3BTHYG4lp5
         No8O+vI8MqnEjyuA2fQZ8t3mumamtsF5I/0EZp9s788pPEzxGypZCao2MURrWV2NtLKQ
         cTkDrzWjTmorM99dbTnOjhePitEAbyMapvWogdN6jCN7APVwkR9ywMawQVL6t6DQdXZe
         vghCMzQyyramGTcttbtSmKqc+PY8ceVuZwCKcmwt8s1EiqzUvMSV1KkpjZviDvBIUwcb
         KISg==
X-Forwarded-Encrypted: i=1; AJvYcCVZjbk7zzBj0Z3WQ+tqZrpz336NNPjJ5gkQAJIpFLHmJRoWpetv6E7bZca4gFSnnAEGPTz/4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqHt2gaQyQgHJlEXe7IiHgYp1QjTfgy+yFnyj1ecmWXiECoRFw
	bDGUCL324zkA8fdP+WevXNjAtrhEuZEAEH7NsKQbovoYCaWRzbCUllxBOfkzUg==
X-Gm-Gg: ASbGncvnz1adRGB21N1DmfusAQYDB5DT4vTvSKwOaG+7FZxkhqpetTWwY/YMYIHpHXZ
	Xwf30fVbJWMhQfRrII+7cz9QCIoyOf1dd8bkZThQ3l/xtSO4h7VyYd126Ugu+/vY3VvibA4PnOP
	5rEhlWn7uLGEFNWJUIcb7/A9pFhmrTkr9HNBwTHP/3Z1OVYVBXmiMKRFnGkuxFKO0oyh6iQxUl3
	N5WkOM4OzuaNDuGE4uAY4Pcxz+WdrNiqiv1YnLqLLx9CcY5ErH+vRIH1U6EHQm0+Eoq9wiw5WAP
	W1gSHX5PHSU=
X-Google-Smtp-Source: AGHT+IHJEV/xJ7VWshQOc1EE4Rqr0dDgCCtt3e2DpSltQwFVMFh018hEiQclExKZ+tLF6mS1D/7sQw==
X-Received: by 2002:a17:903:40cc:b0:20b:5e34:1850 with SMTP id d9443c01a7336-21520641371mr322405ad.23.1732740991683;
        Wed, 27 Nov 2024 12:56:31 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454aacsm10659057b3a.11.2024.11.27.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:56:31 -0800 (PST)
Date: Wed, 27 Nov 2024 20:56:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Li,Rongqing" <lirongqing@baidu.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2?=
 =?utf-8?B?XSBSZTogW1BBVENI?= =?utf-8?Q?=5D?= iommu: Downgrade print level
 for iommu group information
Message-ID: <Z0eHeDU25KEJsh38@google.com>
References: <20241126072339.25714-1-lirongqing@baidu.com>
 <84cb9155-4793-45f9-bb67-6926e103dc84@arm.com>
 <e790f039210f4bd78a015a6fa439c607@baidu.com>
 <Z0bxg0P9AtSHW82A@google.com>
 <ad917c62-0e19-4178-9fbc-a288117aa196@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad917c62-0e19-4178-9fbc-a288117aa196@arm.com>

On Wed, Nov 27, 2024 at 12:37:38PM +0000, Robin Murphy wrote:
> On 27/11/2024 10:16 am, Pranjal Shrivastava wrote:
> > On Tue, Nov 26, 2024 at 12:09:03PM +0000, Li,Rongqing wrote:
> > > 
> > > > On 26/11/2024 7:23 am, Li RongQing wrote:
> > > > > This per device log is becoming longer with more and more PCI devices
> > > > > in system, which slows down the boot process due to the serializing
> > > > > nature of printk().
> > > > > 
> > > > > Downgrade dev_info() to dev_dbg() so it is still accessible for debug
> > > > > purposes.
> > > > 
> > > > Previously discussed 4 and a half years ago:
> > > > 
> > > > https://lore.kernel.org/linux-iommu/20200302154426.GC6540@8bytes.org/
> > > > 
> > 
> > Hmm.. I'm wondering if ratelimiting might help here?
> > We can define a rate_limit for the iommu subsystem that can be tuned
> > accordingly to control verbosity. We can keep the rate_limit to a min.
> > as we'd like and maintain it upstream and give users an option to tune
> > it as per their requirement.
> 
> No, this is not an issue of rate, and we're not going to reinvent some
> obscure IOMMU-API-specific version of loglevel just for this. These are at
> "info" level for good reason, so anyone who only cares about warnings or
> errors can already filter their console output to suit.
> 

Ack. Agreed.

> Debug enough "my device stops working after I enable the IOMMU" issues by
> email using only dmesg logs, and you might start to appreciate how often
> it's a case of scrolling way way back from the apparent error to see that
> the device was added to a *different* group than expected, or crucially,
> seeing the conspicuous *absence* of any message, because the IOMMU driver
> didn't believe it was responsible for that device in the first place.

Hmm.. I agree.

> 
> Thanks,
> Robin.
> 

Thanks,
Praan
