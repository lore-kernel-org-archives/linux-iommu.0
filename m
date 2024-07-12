Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC25EAC7
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788753; cv=none; b=qOGGPIRkV+kX/gJ0Cq8da5jcO39PrqJ7/fwnz/FpsgZP/4zvespWbiAnS7ocOkJROkewaEk2Zt6k+KF4+YB9ho8g53Oxnx+dctwhAhxKM3qQ48WyGczLJbgyC9gaPxLIgw6UNBROto4QTF08ELRlabA59K/gJBPnEXgK6diEk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788753; c=relaxed/simple;
	bh=SDo32lqaEdgpKmnbB45hNjQ5qll9+Li1SCmphlKrzik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW7kHqVkTtWJoI7VdqP2BMJTPd2ETRRFWybmX6VbZ/i2eRkNQE99uxZyWsFn37htKBCYiUtQ5Zf67RkVKsEO/NT6sRqLkmP5mJ7rPamGBtGNqd2nw3DuHWwnHMcRH5EfGEUJoXsrEIeKrsGY7HkGjdwDO9XN+jZ5oT7j9nltMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SS1AfjpH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SS1AfjpH"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5f2ac0fb9so10234276d6.2
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788749; x=1721393549; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZwt1H7oIW6nXmkPtQFYiNDgw6nwG52P49Io5oP+Jfg=;
        b=SS1AfjpHjK8rwGVogngZCxigeewcmsrxEtLxun9LUI78y3GzZxU488ugmYe7pqwZ5N
         TFdo09YaeA7cQiTMl3FU4nuF8HRcAFeHi98owUhvsPjyeM6NAu53KuSCzQ/Jv0guuVwo
         DwF1jVxwOcwP8Obt5Px1Xo4xEdUp4DPmNAAPir03OXLoqXZYDKt7HqlWubOoPn0VYWAc
         bEqRs6w+EXDj768fnoz2VBWxjO6ekzu9XnEuRMRTKZTa0IR+9geN+T95gL+0cqpjroX+
         s3ig/kQwyifgwuOx00VBOaHe79GfyahQA5WgWl0QTi4Zp/1rgZHuGDcuIYSDsv/GthnW
         X17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788749; x=1721393549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZwt1H7oIW6nXmkPtQFYiNDgw6nwG52P49Io5oP+Jfg=;
        b=L0PkyRJptIZ3tkU0LcJjUT9Ok0eR99KktSRbgocfKMyZIcnjBVwWAaNI0vakclspWn
         zSQa8BXmJurl9xLEGcm6dTDpCeKNWPX5ddpFddCTj29jAIHtGakdypC0judYFVTBkYoE
         MT+zezGfRrJOqWrmSfKG4NhZyeJfvXly9BGUS38EmUfly+tpqYiflrmWrHsSOsuXSE12
         69JgnklffZzEJl/uPLnNkb5GXCn7H2EgE0q6jsiusPmZQ5ZZwBIoVw7lrbY1we/Gkp0t
         588BY0wExB1ccZ3JfA+UAe+Mj1rcl9FI7qqks303Bg0K4TWIhhMsOCcATXMulEdnCM+7
         qH3g==
X-Forwarded-Encrypted: i=1; AJvYcCVH08itoxs+XrVyCjHIu7kWV2Yd5eBaCWVjonila/wSIy64fOAHeMQxsRWD4tjE9R4sR5wJqDqrKROekPtdkrwLR72764A=
X-Gm-Message-State: AOJu0Yz2TDYT3jRet7I8Cg1vnujwoEKyRD8X+6+Aotsm/y97wTkFEvMC
	+/3VVWgV2tz/us93mDB421UOVVL1Ih/E5u7TjW7gm2+nH63OxFFSQoVdT3CKPA8=
X-Google-Smtp-Source: AGHT+IHIkQn3yXzLP7vYHXmOANs9UFpH9tGkJikLJj4kjPZefiBKLX1DQjbvKbejP3eOobRWdj5qlg==
X-Received: by 2002:a05:6214:1cc3:b0:6b4:fda5:8230 with SMTP id 6a1803df08f44-6b61bbe0c8amr143829566d6.0.1720788749076;
        Fri, 12 Jul 2024 05:52:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8c9f1sm34903496d6.123.2024.07.12.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:52:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFlE-000HKf-3g;
	Fri, 12 Jul 2024 09:52:28 -0300
Date: Fri, 12 Jul 2024 09:52:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd: Fix error pointer checking
Message-ID: <20240712125228.GZ14050@ziepe.ca>
References: <20240712025819.63147-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712025819.63147-1-baolu.lu@linux.intel.com>

On Fri, Jul 12, 2024 at 10:58:19AM +0800, Lu Baolu wrote:
> Smatch static checker reported below warning:
> 
>     drivers/iommu/iommufd/fault.c:131 iommufd_device_get_attach_handle()
>     warn: 'handle' is an error pointer or valid
> 
> Fix it by checking 'handle' with IS_ERR().
> 
> Fixes: b7d8833677ba ("iommufd: Fault-capable hwpt attach/detach/replace")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-iommu/8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied

Thanks,
Jason
