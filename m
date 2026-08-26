Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F0481AB3
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776645; cv=none; b=nVYj0Q/m24hKoCis4HaYvy/AgmwYigps17RN1gjw4VToVyZWXkCmv8Q8KRFhQP2clmcILSUZzupBggIl66ZoTYGJZeOjA7i43xcD30F18p1ComwDwyqLCGOUcNbipAqIOoVG4+W9L0ZYABUkkzL//RT1d8BKqOCof/r3mWTlNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776645; c=relaxed/simple;
	bh=YBYb28lJo+o6sWxWkJtKpwJvq7b6MSb+mLIbxMdLQwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3DIN36IUtWEjNBmCATZEuVd4pNaJpFbu9RJ6/m8MHeOa5Y7rNG/KUYYje89nFE0R6YjqLeulxyb0CxvtV+lQNUSEuHWaF4RApfZhCZYjXHcMgn3abtr6qLOm19E5hcFrQtSTBJ5awUzcI51xk3H5ae4F17nJAk7u7ILQp6XIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBqB/QOn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBqB/QOn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso31175ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776644; x=1788381444; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBYb28lJo+o6sWxWkJtKpwJvq7b6MSb+mLIbxMdLQwU=;
        b=VBqB/QOn2j40Kwa+H8iIU4yKDUk8VMw2WOIDqWFDL2slV/TsH68EEEff1OlTr1gwnf
         +BDFjE6oG90Fw227u/608kiud5PVD+ld3bMeLgpuXbFoP4I1KsxiOH+7srpe5ATynq4R
         eKIpq0d4c20ZTVaO7tDOcUB5oQf2JxyS/gHxVKTRtsFhc4qMoMfdISe0Tn4xP4C7uG4p
         O1Ok5hU2+gCNyQ4P5CEI6sPpgtEMDOS7frHF6B5ddfmKZNmkuNGKdUMDoIfWNOJ/o/dX
         0HfTL0CS7GEnJubQCr57w6qeRbEDLIZuK1zjZUkckb+9WtAD827KXDRuXn78zAyJiJmQ
         ORFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776644; x=1788381444;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBYb28lJo+o6sWxWkJtKpwJvq7b6MSb+mLIbxMdLQwU=;
        b=p4S4qyRApp8JZTu7ziQkGg2OTzEhsgeugI367FXWfiEvfIgpUgQ6CmG8b7wkqJ/lOT
         YhqLnRY47aOt/6a1W4dHdZGmP9GllciI420FlPLO5V1b3Xd+I6Jcl4JKwdban6vAv+cD
         UIjQ1uQ156G73S3vEQ7H3FhZT4wcoK3kft9E9fBkn0opSVEYwYMBY751j/D3Q062Oygj
         jCl+OlS+cnfdcxIAEsEpIupzRVq4wMF1bVbqmcu8xUIFPFVItGWOCdevwH7WeU7X1k5x
         nRGbbpQhOQ3DyBgPc7tOure+cpw0w5ZW/1IMIQWPC7cmbS+R9DdPbkUt4EXpxleMYBpj
         lnQw==
X-Forwarded-Encrypted: i=1; AHgh+RokWHc5wVgfssFz0G4aTAc+uc/8p55uTIT9Se3tXaC4EOSLp6KHJfitjmKunztHTRivfVCl2g==@lists.linux.dev
X-Gm-Message-State: AFuF++mVGGn71xqx54gvyImgisip2x7K8EQuj9CQYKwZeLGxbiREi9eG
	DDi9hlaVARpr6YZuo/mSvze2gGE5YXJ+C11oB2uqZWx+8Gw/DwIHpBvwhrbTpw7m7g==
X-Gm-Gg: AR+sD13nmOOA7cYu29829MuScqxBx79/vgSMAuoPR3g3LLT8EMj6ofOKCyReAdekQJA
	L4fTmoi9Mdz40qaDayb/Rn0J9736vL7H5AXFnVYjvExfyH3Z92ZPZSGulvYqmk7lbU8QrU0EXnh
	dHBHMyoNE0vSHkTeQCjktuQkyEe2PfxPwuJtM8utVzSOMvoBNZ5Mdmcyt1OhGDkfmgxKfYuMEzZ
	RXDUnMDiwxgz2z5qy5zrLM2SRKmoKHEWGXoOReBnzKo9cYJJUXr2G4HFFcYJxJWVsVVkKe++ws4
	wjUd1H+vREAQu7RpRckxDVzV7zUXpRl0C3Q3gQgaCdAltZviOUTfsU9YSS2Texqhe53tI7heyzs
	x6vyL2CpVCpschcAjlrub+q58LqYcjFopK606Z+04Hxcs0bZ+bf82nEdd3EYZGhjlsX/z/pb/pI
	eSE0z/8Ant3eVGcE5shvU+cHQ6HIzGX2KewQkUroEg732v9bKgALiR/MxNiwcZqWay6WnFaQCz9
	Q4IrFxWR7k40MUAIi31WB6ids1JJ8qUitAEc1T50dGPoHA0zPjFGkV9OEatAz6sVgCwWQ==
X-Received: by 2002:a17:902:f545:b0:2d1:1d3d:97c3 with SMTP id d9443c01a7336-2d733662a3fmr39975ad.13.1787776643126;
        Wed, 26 Aug 2026 13:37:23 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cf3e982sm1302094b3a.54.2026.08.26.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:37:22 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:37:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <ao9ONwUblaEqIpot@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
 <ao7ccBlV9_RXT6Fe@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ao7ccBlV9_RXT6Fe@google.com>

On Wed, Aug 26, 2026 at 12:30:40PM +0000, Pranjal Shrivastava wrote:
>On Wed, Aug 26, 2026 at 04:05:51PM +0800, Baolu Lu wrote:
>> On 8/8/26 10:27, Samiullah Khawaja wrote:
>> > During normal shutdown the iommu translation is disabled. Since the root
>> > table is preserved during live update, it needs to be cleaned up and the
>> > context entries of the unpreserved devices and root entries for the
>> > unpreserved context tables need to be cleared.
>>
>> The key assumption here seems to be that, during a live-update kexec,
>> most devices do not go through the normal iommu release path. Otherwise,
>> their context entries should already be torn down in the
>> iommu_release_device path.
>>
>> Could you please confirm this assumption and add some short note in the
>> comments or commit message?
>>
>
>Yes, that's correct
>
>During the normal shutdown paths (i.e power-off, normal reboot, & kexec),
>the kernel only calls device_shutdown(). This path bypasses driver
>unbinding, as a result, devres_release_all() and iommu_release_device()
>are never called. Those devres teardown paths are only triggered when a
>driver is explicitly unloaded / device is unplugged.
>
>Since live-update piggybacks on the kexec/shutdown path the unpreserved
>devices never have their context entries naturally torn down by the core
>driver's devres model, necessitating this explicit cleanup.
>
>I think we can add a line in the commit msg for this because comments
>might create confusion if similar comments don't exist in other drivers
>performing Live Update. What do you think, Sami?

Agreed. I am going to add it both places.
>
>Thanks,
>Praan
