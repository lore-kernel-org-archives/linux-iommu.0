Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B920DFA
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885152; cv=none; b=RmdQl+KGkh5f9asd4Y2XL5rykRyuPyy7dc0naQv6YogtUp0hF5b7WJTth1qDW18jirwRWyYE9j+28lP+BXoSyz/EC6b6KxVtCyfgFol9jQcQexadNRnsMi8I73MIgTxUGs7ayPI3enD90us92IiF+mfP/4JAAS6Bx6bs0KUfhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885152; c=relaxed/simple;
	bh=WXbStH1chs3BMGJvadxE5FVmFPlwW7wkxtnaAxfG4oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfYOynhS/D202exccUbRRhUbigD8QmALKkkrzLNbmH424C3UzwuhZX19FWb1X7XUVKOxTf3o8O62LIWqZ0cGORRBKPmFqVp4T7XJaoswFC1I2CL/54qGhJvIdhGx87vhGjMgS5mAGC93lXuqZUnAAc3XQzeFoGKqEhZdRB9P7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbyAOBdV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbyAOBdV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a350bfcc621so267608066b.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 06:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706885149; x=1707489949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3F1J8Zm0INeC6Da6UyPK+ptICn8oQqqc4t2eGqc3d0=;
        b=CbyAOBdVANmlBbdsf+oOW3SE193/THzQ6lIbbArWPKVCwdhf2cFUvg4fXgePo9JwEt
         wQ93Lboanw10WIgF3Y8E8l01p0THWAtP3tSaC5429W/cAEiyeHg5XezQvkkOYnid1//n
         Rt2rNlFVIrd1CjPezQOEBif5uDW0+G20gsqV7fvFkPwbxifISDXxGfenntAILk3QTI7N
         uYH9uQqjYrY2b54bdUvlSdjlp7jWtdf6xD8HMh2r09caqFvOzp9VEc3bm4v+Dwe5lvja
         xplld+o9xaReH5qDTuQO7Mm8y/+H1BkYyu4fiUlHFdkJ8uqtJ/5i6XIWLAGFaKRqRePC
         B9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885149; x=1707489949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3F1J8Zm0INeC6Da6UyPK+ptICn8oQqqc4t2eGqc3d0=;
        b=ndeuGFv/NrhGS/vrfj0vyI/iLHLb+J7pjObok/7+jjvQLqk5FuA+II0IgluCPUAxAH
         4dbaqjX18fPZt8FRqoAkoI9NadZdO62BnKPMK/RMo/yubrIUZFt2/vhb37YaaltOiSde
         NarjH0jHCh6t0DBrVAkg4CJv8hk2hgV4jyocXZHGT1MJLtmFL4PFLxXgvu3fK8QJQw/C
         TfVGVDMKJ1UA6xiRj988ngCII859/BG16FwkT+00c8SnQ8s/OUPSbKuvim1JztdaGwXL
         FrAls4r1uqrLm7CYKiG9vgg1tvOqomDWOoAPc1MjyTZuapw9iqJR4+tBi/b38eO266fn
         4syg==
X-Gm-Message-State: AOJu0YyMc4qVLlQHD2Eokl+IYi7BMmx1xzdiMM7VII4zM908Q/7nvteB
	po6HhJH5DEeG44R+hBZu3Yar8RIkYIgZ5+1CtQBLCXyMr/RMxKkdWq9RWy+QCIffxZ+Fx/bag9e
	9
X-Google-Smtp-Source: AGHT+IH6HRggdUJ+CapjNg4fJBgECuVkbmW/7oP3WHsIewxBToksdnuxjkLTKVd4M+vcOJmnVvgKKQ==
X-Received: by 2002:a17:906:a90:b0:a36:7c3b:8489 with SMTP id y16-20020a1709060a9000b00a367c3b8489mr1772226ejf.42.1706885148627;
        Fri, 02 Feb 2024 06:45:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsmVmTVyPHg0w/xLzJKZ4or7SdsmcWlx2Hyp1oki0esDG8rqdiiH9YCMkNHPy8h1tiv2BFrSqFFNdRI5OFmoGIpmeu7sXdgPeH6B4dYFKrngon2HytjlI0QGhlaQh4YvdeJ2ynlAw2xdnUVeAdObdnTK5XYw==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709060c4900b00a363809ef08sm935593ejf.117.2024.02.02.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:45:47 -0800 (PST)
Date: Fri, 2 Feb 2024 17:45:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <46d7086c-36fc-4668-b95b-454e339b94c0@moroto.mountain>
References: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
 <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com>
 <20240202133557.GR1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202133557.GR1455070@nvidia.com>

On Fri, Feb 02, 2024 at 09:35:57AM -0400, Jason Gunthorpe wrote:
> 
> It won't silence Dan's warning warning but it will correct the bug for
> now.
> 

I could just modify the database to say that
arm_smmu_update_ctx_desc_devices() doesn't call arm_smmu_write_ctx_desc()
with preempt disabled.  I don't think it will silence any true
positives.  That's a one liner for me.

regards,
dan carpenter
