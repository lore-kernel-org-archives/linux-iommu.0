Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963794C74
	for <iommu@lists.linux.dev>; Fri,  5 Apr 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275824; cv=none; b=gyXvrkOiK7w8gaNVvYYgMz/CXAE4vqAcbyBhXX5+gwB+l3lAxxSISdq/V3tJjJj9qih59NM68jZtde4Y5h5M1WE6s2eva00i3btx9xRnlqDWjg/4b/MTqFvGzfkz4qTXrVm6JxmydWxAUjGgMNLmMPVaJNkoqhesIrgja4LzG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275824; c=relaxed/simple;
	bh=sPDQJ05/TQ4qe3SR/jxdqKkXBS1tuENTJJthlGc29hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuoIQetCCiEcBEy3twdOvWDhXFOceUaaLaKueEXKdLDYpYX3yuMPJ2wI0Wsz91Ynqrm1gp1fK63sjN7U1SLUxq/0xr2gMxPYRdpjdgwjZngofRFceJWKF93uzSvl8bSzGqDiWutGmmkbOPk7JmbUT9X8k9PlPvqzHax6ARL9xXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SZueSM09; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SZueSM09"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e6db4dfd7aso1037916a34.2
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712275822; x=1712880622; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+Ek+p9fVawjZ7qm9N+x1SgR6NYTn+xc7F3vNghiclw=;
        b=SZueSM09hezF1aP1wCUYLmjlsNjiDYnWGIRDrzVF9Tp4Kufogpez6JwfeEuNF2+7sd
         BSt1ycPf6cHfAoUIPqaTw1WxIzRXheFv8O9mkgGb3JkQWv0hl77G8FjkytNdEicLFlZc
         yOgBtsh+jUtbrj9DaxCgied7UHhilu5Zw4NABpxfIXrg3490IyrXqxsGsiQI8nBBdj7B
         FMLiStc4Dfe2HryBdQSWrDBDGSVp96ofb30UgMkyh7py5SR6Y/3NX+yrV0pvivcIHLWx
         6aJvBqW8FqrY99n77gMvoiBqj4GCFEIP9dgzu9PXs5b0Y0IGMUCPuDqXkDOhQxcL+1NA
         sI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275822; x=1712880622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+Ek+p9fVawjZ7qm9N+x1SgR6NYTn+xc7F3vNghiclw=;
        b=ab1T5k1IPRuaQWqXQ2/g/tD0OCEB9edgqJm4VxbMQ2UwmQMQHj6bwQW/U38Hgo1th+
         fRT4m8jVoop4qjrAD1I3jBqkX9NlbHz331vXNQ1hJT0xsHsYbVuaVSaO1ggbUiKepwwf
         55LpBqNF6fWZnITLsRUZB8GGyiWID7xsTQv1MrfDzdvaETubeB71sdBYWZeBUHkfMmd5
         DO77kfqXFZocUiIOmJCfTdav5QiSOemAForhr6/4GUNUeQ25iGTSWAxTmGon9bAO3nbi
         9yjU9zoz+dSyrqFQCVF9pWlUWy6QLPq8bHWadMkx42iYW0RyiXaH4/rv7GQVUg34QSQZ
         4kXA==
X-Forwarded-Encrypted: i=1; AJvYcCWUGV4zTyQYdHBXw73+klwP5lAtZlitPE33T4taYbGQC2eX5WypCQAYX0weru2CRQHz/rqM1V+kPtA24fniMCBHmpxV3vY=
X-Gm-Message-State: AOJu0Yyu3U9nkJS7zHyzVy4OiUW3YteIt7yWo7j6ibVYD79bL/kXRZO5
	iINUoHjHacKo/Iag+ciZBScIpz2Ed4RjApf5y9CACFg2GomP+Hd+XlYSpuiIw8M=
X-Google-Smtp-Source: AGHT+IEKMKYTQECfUlI5Xqkk2n1CcC+Bn9kk/cYoX2vF7L9C8xyQOyAac6X58xIRZYOETJnlR1vW7A==
X-Received: by 2002:a9d:6511:0:b0:6e6:c9a5:6585 with SMTP id i17-20020a9d6511000000b006e6c9a56585mr1312038otl.23.1712275821781;
        Thu, 04 Apr 2024 17:10:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bn11-20020a05620a2acb00b00789f221a46bsm193731qkb.119.2024.04.04.17.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:10:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rsX9w-0002Iz-Kz;
	Thu, 04 Apr 2024 21:10:20 -0300
Date: Thu, 4 Apr 2024 21:10:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240405001020.GB5792@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>

On Mon, Mar 25, 2024 at 02:11:41PM +0500, Muhammad Usama Anjum wrote:
> On 3/25/24 2:00 PM, Muhammad Usama Anjum wrote:
> > Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
> > needed by iommufd_fail_nth test.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> > While building and running these tests on x86, defconfig had these
> > configs enabled. But ARM64's defconfig doesn't enable these configs.
> > Hence the config options are being added explicitly in this patch.
> Please disregard this extra comment. Overall this patch is needed to enable
> these config options of x86 and ARM both.

I picked this and the other patch up, thanks

Jason
