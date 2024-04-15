Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5E7FBA4
	for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197346; cv=none; b=WtM/wxpk5icDh8igSfCANr/3YDr3ZbzaYvQpi/XihABWGo4ztBtmxpl8KpnZiQJyi3uneWy5i27WIcBXz1RhFh0S6aXhY02Ho7k5rq+SWa0FNSCdJmZjk/Qet5l7Un4t7jlxv7rRl0gWekZZ0LCKEE+4L4VO6/9uM7SlejJJL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197346; c=relaxed/simple;
	bh=E/HJYNCwsVkHpTWHtftb4kU3kk8lhl3wMS3rheRjiQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfj5/K/7UXmQcYqZNXvAKEZrWJ+mQd8EqCWURaB458A2yY2u96IvqSDMei9rQ9MPNESSZ3gIsl5nO0V1+g8jIDuoNs8KOv4S3M+7NnYhw636fR07isS11PQkNLc1bktNQDitROWJx/hY1BjBAGYMzs0dyTnMG7TuB9g1/Q5JVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ELAwQtXH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ELAwQtXH"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22fa18566adso1981095fac.0
        for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713197343; x=1713802143; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTXFGU40TZUxrNmMPsS0SfAuCZx2k12qnJO4YGZoAlM=;
        b=ELAwQtXHdJJ5eu1apFVkmcsn8Bl3hVeFMK2JCUnsMmRbQxR1pWCT7wUi4LqerV0n1N
         PSQdZde+ZyO9OWSvuFtAhQJSziseOcOFrb3XmpHhS6NiWl4k7nivz33I9CMb3hz3tyu1
         H1EiEYMIQlnUms38TJnZgtZJReM8PcRVr+EvJXMCgnPFoyj6emGqZTwSPNXNaWVZZiw1
         kv3aUUlB0USNZZacwFoexbS8HMy1SHxRfOi/31famZ9M8jijUcwLubHnGzDOB2cUpTEx
         hDQEylHu+pM25JNr89lHKbMsHaU4Ug8+XRrc7kPOPIRlMHP6viDSu5fYEg/AiU//rBxs
         OgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197343; x=1713802143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXFGU40TZUxrNmMPsS0SfAuCZx2k12qnJO4YGZoAlM=;
        b=JbXVh5UHStnPs7ihJZYu5eIJwJXh5fcuavFyHmtQEBvHhZbRl0GsQ+38PPM9211H/d
         tdYpKYuPnIUyLOSf8oXuyONXYgHsh7t1Le89g8x11eBrjLy7/CaSbJi3CeG+YaUQbKSF
         CxVLqDTl4W9hEFo6bfYDIs1vjheeDIp0tCm2OMhKRFKDvdcA3cxpyVNbAab07r9xw4wp
         T/oy3CXxhdrYJLeF6f8pQpJdkfk31oZB71I9SxIJuRlK5x/6N/0bfe0LNWsYaluOvPgv
         bCimvrhqMTxOaXSzMDnhXrN/zgVF/6yM0B0wrf1Fffj7MWHBg1CKv1bGh4izKKIguj5y
         hdeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMt1g8Qsz5bK+1cJyQc0rmfyb0uja4sY/K8WoPGO5ONu3L72jRs8Xe6+WMd1hA1GUpvjetS5awPsLxOd7NnPNi+TVZz0A=
X-Gm-Message-State: AOJu0YxSwpbEiNxWcuRy32AHtOsXxVWzJvQaxeDzaoAwLZkj1KR5h+jG
	DrUYd6+w64rEyN0jefT4kIXrxdovm1hp81kOAiqw5Q3YKWaJeMrTlzwt6jwmenzOWV+Y21Ujrzk
	F
X-Google-Smtp-Source: AGHT+IGsiA6KZ3pe9BtRhO+pbVOY45AuLQMOs+w2wDePMtUYoW4o4u2JX5C7mqkiROcVBcvSR1rGJA==
X-Received: by 2002:a05:6871:7505:b0:22e:15fd:e247 with SMTP id ny5-20020a056871750500b0022e15fde247mr12653184oac.5.1713197343311;
        Mon, 15 Apr 2024 09:09:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ej2-20020ad45a42000000b0069b7bc51271sm1526012qvb.123.2024.04.15.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:09:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwOtB-006BJP-JQ;
	Mon, 15 Apr 2024 13:09:01 -0300
Date: Mon, 15 Apr 2024 13:09:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240415160901.GN223006@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>
 <20240405001020.GB5792@ziepe.ca>
 <b7c437f5-ac70-4611-908d-b665d8e02679@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c437f5-ac70-4611-908d-b665d8e02679@collabora.com>

On Sun, Apr 14, 2024 at 07:39:58PM +0500, Muhammad Usama Anjum wrote:
> On 4/5/24 5:10 AM, Jason Gunthorpe wrote:
> > On Mon, Mar 25, 2024 at 02:11:41PM +0500, Muhammad Usama Anjum wrote:
> >> On 3/25/24 2:00 PM, Muhammad Usama Anjum wrote:
> >>> Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
> >>> needed by iommufd_fail_nth test.
> >>>
> >>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>> ---
> >>> While building and running these tests on x86, defconfig had these
> >>> configs enabled. But ARM64's defconfig doesn't enable these configs.
> >>> Hence the config options are being added explicitly in this patch.
> >> Please disregard this extra comment. Overall this patch is needed to enable
> >> these config options of x86 and ARM both.
> > 
> > I picked this and the other patch up, thanks
> Not sure why but I'm unable to find this patch in next and in your tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next
> 
> Maybe this patch was missed?

ah I made some mistakes, all sorted thanks

Jason
