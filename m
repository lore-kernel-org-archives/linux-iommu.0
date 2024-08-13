Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C222F11
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571822; cv=none; b=GLC7Js1dfeaby+hG+k2DLlwVFxEuW58J25YT+Qo54sQ/zmJr6yMKM8lIbJYVbhM2jVZkNkh3Wf9mY0YhRVPO5fWsZKMKpBtd88X1E1ws66msfItOchbmMx5V0GalS662bEhTc8u5cr/kRcImIgoRteZ+SVywfX8wdYd+IsuHbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571822; c=relaxed/simple;
	bh=757LLvYh7tCy/Za0nmABifBJAXzCB8Y9uZkMalML1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvO0pmD2x9q2V2e3wO2ulpmqRaD5FXb3hkxcuEqFnCBuiEzZTtNjuo0MSe1wsmADWWdlye4Fa7Ogcy0xDL9d8OtQMC+xln1vN2QlYV9tTNTUlnWpYIY0THFAHLCUD0S6oFjVLy95n++toHXJ+0F3IlG1/O7nNCSS0WNQoGBuTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MaScGL7Y; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MaScGL7Y"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b795574f9dso31844916d6.0
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723571820; x=1724176620; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqHCv1f37dJdFmlxfLDwmGn7VkBUztlhPRalJOl3Txc=;
        b=MaScGL7Yl9j25lJXM7+r/3kHMPtrH8ftCbqCehW1Uhai3pM0DvKpzKMhtpEdT1y/Tv
         D+lLvzasvcpCCx12WR8THVF6WYnYZTZaV+0Sy28h9WDSGCjpBf2+CSvekCBujN/iNQO1
         b97BBPmlYwTrnJVUK90V8doP3qZgXe2xwHnFRaB1a0xOtGJwPEM7rpA+GkseuOpenBnS
         OeyTppYInKL2iHXoOxm849cpdjOHjqG337BInHBp+SuewrepLjlPzJkX6TqOY+872wxj
         tVT/ohk1DK6S3T7S32tUNiqMI0Hl2a0vs6FNHts0dJiYab2Bj84p3cWo/1YCQ+2zJLPY
         8brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571820; x=1724176620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqHCv1f37dJdFmlxfLDwmGn7VkBUztlhPRalJOl3Txc=;
        b=te8H6FkTujwq0OS9GptlMN3OX7N4cUXlo6A4OIU2mVSkcq891br3wHX/it6P3lmKM/
         bO0c+/jLmt3Yyun4SqOudDeSbPyPu9e5GhiNf7fn701Akts/jeUgqKOpa47brfsduj8X
         x5QmtakKIJnYE9DovAioX3Qm/D7hiuwvxzyTYLcBmCu3avDWJxZ92qPuUeoQgaZRdld6
         TR5yEEd+D45wqKIRKUEa0VNQ0xA8iPZ2kEHCideo0bsA9O14qJXq3yJ5SDRuOFX3CFDM
         SF25M9Tdv06tR84kC25+JcI2k9yFtuuAPgyxgu3+YJGE/7YGQRPmobXYx7bezJvxzL+6
         rdHA==
X-Forwarded-Encrypted: i=1; AJvYcCXHqXP85KVgkjWJQjMiy/Cky3QpNzDcCkgU0j90sgwCPQhYZOmnnLJwFWK231RBPbeGjTt/Qrs3PAooBmM4mwk122EuEhw=
X-Gm-Message-State: AOJu0Yyowib9xqJRCjHgRzoU+Y7a1LB7YxNIj0VQyhHkfumyU01HCSzc
	mmvX7FV3vR+ztplLTaIWSzILiJH2HV/0W73OV5hQ/8DHuHzc9+cd9DPBJ+7QVBU=
X-Google-Smtp-Source: AGHT+IF0ahYqaweAPCwsOz0r2FqFsLLNlBLP+hAUNAK3I7TnTFqEVk0JoImTkYUd7Un7vFvQodQtow==
X-Received: by 2002:a05:6214:318e:b0:6b8:5afd:8f89 with SMTP id 6a1803df08f44-6bf5d23f9b3mr2429676d6.37.1723571819915;
        Tue, 13 Aug 2024 10:56:59 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e33ec9sm35691786d6.77.2024.08.13.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:56:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdvlS-008pOM-3A;
	Tue, 13 Aug 2024 14:56:58 -0300
Date: Tue, 13 Aug 2024 14:56:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240813175658.GO1985367@ziepe.ca>
References: <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca>
 <ZrJIM8-pS31grIVR@google.com>
 <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>
 <ZrTNGepJXbmfuKBK@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrTNGepJXbmfuKBK@google.com>

On Thu, Aug 08, 2024 at 01:50:17PM +0000, Pranjal Shrivastava wrote:
> 
> Kunkun -- Please try this diff and check if it fixes the problem?

This looks OK to me, you should send it as a proper patch..

>  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> -		report_partial_fault(iopf_param, fault);
> +		ret = report_partial_fault(iopf_param, fault);
>  		iopf_put_dev_fault_param(iopf_param);
>  		/* A request that is not the last does not need to be ack'd */
> +
> +		if (ret)
> +			goto err_bad_iopf;
>  	}

rebase it on -rc3 and there will be a return line added here
too.. Maybe you don't want the goto in that cast

Jason
