Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E863CB2CF
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131209; cv=none; b=CmJTtSa21BeU8D1kOMxON+J2RAHLmjI4grinfnJXl+XYzAdQcEyA1Ed9FadJOtt+5TGWRmX316Sv8T+Sq3CDZvICsiWpL7nSDdmq+vX7S3ixafoUjILwYu4cgu9bEMamq8Ty1Y7aWFGem3qwkVQvTgDS4RpaVadfqiz/8dUIMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131209; c=relaxed/simple;
	bh=D8lrxleNO/ZsZ60xggEtDnqZrsg4llp225/xd/hr+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBcURc/P2I4pbPviObBC5ULRH4QifubuZJMsJQQBNw2fDb+Bot4a+a7GU1pPCQ/qXUB0BExml+wq77zHIPKAl3OAGgQ2QWIQUxZvGXbDPjusNA0SgGyAxndOoaVqA2+dOVk4heBqgXLXe8pQ1sDo7EFX2rydGMVQ/O6u/tUCMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HVV0AdPx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HVV0AdPx"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50335b926c2so6408831cf.2
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775131200; x=1775736000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8lrxleNO/ZsZ60xggEtDnqZrsg4llp225/xd/hr+rs=;
        b=HVV0AdPxCB1Vs3Ulenu2GbAuy4ZijxIV55p6mM8XcJuebTKwi7TPcc4t23ZO9dZ3tX
         QLcucLhVCYLT960mARwBfCq4qXNAClSF6DmzobJpSxPWpQpITMdOE1TzPYatTtCyRnYQ
         a0TXcJOS85iWYH4Oarz0KhKHOBx6nxIWWNtjgIFXBBqYIwBTcIMK5n++JaNcvaQdoQ7v
         M5mOUVJqV4H+X+dTTa63jKQRq2iBQm0iCCe0pRolZuHduywFcPJptA6lBbg2QfIJaZi4
         1lrZn4MZeI14DpQCzcP+mtQy3kTetU7pHXa/44AtAXAyGALzrs88NFaXZfSoRFfEaNeo
         /Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775131200; x=1775736000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8lrxleNO/ZsZ60xggEtDnqZrsg4llp225/xd/hr+rs=;
        b=o0E2b2tdO0y01HwjLYFizGSHM3FdR9WwrR/Yd3jjLMuFRcdJ4+hV3itPN7A/yyGpEi
         3LGrHDLfPqPHPVB9fEfanTJK7cYqYJKGNCvaqaA3wfzaBD3tQMGVW8lR4bdr8/CriWKM
         5zSD+dKXpeTmBnNLxb5z1bnbnfwCClni32ZlVixDWk2GxyBsbS+xGL3ShJ8gttpe2tZb
         tASO6eyf6gsxvlvG4OTixubK7KZGBwG+k1ND+inDAroL6FQtqVYCYhqe+tC+kvT1ZMDp
         yAfrvvY+OdKRZnPGqn/IQ5iim3Irh6h9ppeN1QlebicSUvVkRKvWmrobB74pUODZ9a3F
         LHkg==
X-Forwarded-Encrypted: i=1; AJvYcCUwUNlkOVX8ETe+8v6XOGj9QRhKNkKHUTr+Vt0Ki5XOvwQV0fzhb7kwXipGoCHUM3mOsDo45Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7ICZLJCXuxpeQanxK3sAjSGfKfhr/ZTMU8QM7QdmpCksSSHp9
	ODjU+hVsOXUuvO/qPxs2bTTr5U8JnPFltFjg4nVK+OQXd+gEdRajYNtbhiKSK9cwMFQ=
X-Gm-Gg: ATEYQzzkZ6eOxKzj/eyIaTq2eHK5Pi/a+b+cyFbsbKRqS1c2v132m+Iql0pFyYnP9Hi
	1gai5zq0lgQIuGXCOGPt/mHDWEHuy57lluDiNGBN3RuHprz9kd1nzg2x6uyEDr8Vu/3w+kUOuRi
	+7AAV9qa1cKLhYtlEp91xpY6r67c6PMPoihUmEBlizbba/n8P2saEvqOelueg9YONgBC+caocrB
	vfXjhMS2GcsX1vpCC6UpQJ4kb2c3lGhVxjh9jbljn8Qy5rAIsiuhLDYD2wVAHqr+0Vj5iTnHMHK
	D5SWiiPspXIu343eB6tqWA3/EhhArKdIjRcwjYPOU62IftqJ9xNC6BWBSQKT6jbZG/ZqJPS+qBv
	pElBl7k1bqQKcP/FVHWrFomaHo0+NoHR2ZUqBgDV1nc3r5i/643nu90fp4TIIVazXCtnNGkFEJo
	GE+HX0k4lgXQAMGrwcQ8a78obGC8wda/DaA0tqMKfnxGpFTm9/m4pX02w59W+nclSF6Kh9Ww==
X-Received: by 2002:a05:622a:1e09:b0:509:1f91:dc2a with SMTP id d75a77b69052e-50d3bd08c56mr95496201cf.36.1775131200416;
        Thu, 02 Apr 2026 05:00:00 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8d9f7bsm21034241cf.30.2026.04.02.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:59:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w8GiM-0000000Blwf-23a0;
	Thu, 02 Apr 2026 08:59:58 -0300
Date: Thu, 2 Apr 2026 08:59:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org, andre.draszik@linaro.org,
	willmcvicker@google.com, jyescas@google.com,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
Message-ID: <20260402115958.GA2551565@ziepe.ca>
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
 <20260323173138.GB8437@ziepe.ca>
 <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>

On Thu, Apr 02, 2026 at 02:25:54PM +0300, Tudor Ambarus wrote:

> I can probably track whether all instances are ready, and defer if any
> is not ready, but then I'll force the iommu clients to use the sketchy
> replay path, which seems like a bad idea, according to Robin's feedback.

I didn't think that was sketchy, it is part of the boot ordering
system to ensure that the iommu driver(s) is probed before the client
devices.

Half operating a device is definately going to get things into trouble
with broken/incomplete domain attachments at least.

Jason
