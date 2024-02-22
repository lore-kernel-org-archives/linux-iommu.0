Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923B12E1F7
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606965; cv=none; b=Gg6YJErUOQ6MisklIfkJmMCK/7nlSKWQKMYHbfdKNOyv3IJ5nXs4SZYfTgaobtRZ409pvIMjjBy88/yxTrbVmgYWvhN99p7ALMaa80ujB+qAAGp2P3SSfWZ3CkeJAUmtVPPS2ucWoz0XD1xqSM2sXipRgfxj2Ayk/GG9zhRfedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606965; c=relaxed/simple;
	bh=mLihlxLtwpBjewJipEa6FRB39ptkzFSdsuzkpNHKxJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDQ+GBfyO7K4WvgUKQb5vlrSTAnR/G2quI83W9R6cGGl4fOP2C4uVVR5vU9Wg5Gls9uR6p6Hs4SL0RhAI2TfHNoCOJnnx+yJDJ9+mn03pOouPBQ6S723PfhFPfm7RwODDEqHzQDixZ/OKRb8Dc8YStZHU9gvOw3PK8iyK0czGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xu3zQWnT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xu3zQWnT"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787a43e2e2dso22682185a.0
        for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 05:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708606962; x=1709211762; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AaVii71/VY2wZ+q8F0jNvSLMQ/WesHh9hxpdt+FDPE=;
        b=Xu3zQWnTlTl3r/2fWxAUCftEqoOXkISJ/YoxGvbR+p3hsH4r+8sKZfMoMC+/T0eGzh
         yXYF96AhRjSapKJO7itR650vUNa6T7rltbCChVxG963WPb+VZjetMYXlldfB66d+lgm/
         5V93mwcTFQDY8SDIq7WcGJbY0eWqpJ9N6lSFHifvMJ1TvngrTrmFAYEEYKkq8HHFBTTM
         0i7UXARzTmoDQ8Rqj8mkADWutj7CnqtwIvXN/St9e7M+FTaAppgiaQScesp7/nEYz/4m
         zHrgJDmtacTUqYffcNU3uLJxAMnn/LONPkgbu4d6oyF52n1Pv/UlyA2nZEWg+MhwzKJY
         qcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606962; x=1709211762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AaVii71/VY2wZ+q8F0jNvSLMQ/WesHh9hxpdt+FDPE=;
        b=eoXn734x/MGBXAMNbymCBKiMoDf52xMHgTwgkAzg28BVGLgI5O57z3K/7FMrzRS7us
         uzcfocq+bNignjYm8opLBrfGqQpnBF/VYO6CxIf3y5lAlS9PfL/k8uqFGovW6Yje5Bwr
         ntECl96FO8caTygI3iaZb58GOB/pSYIjOtEUoGAAuDL3RsRTRoJeHH2ETJPd3X94oQub
         B5yewZLzasFkwwLqxpAkExMk9j0cYvbBRGz4maZqeY0nktHqTpNaHJ+Nj4dlCW/XKeUH
         +OHZ7YPbqV9UKa17cf3CQSCnoZik3VCFX+7dT9JcOp0eCWWhGaJB4jIuz/Ba9iG/gebA
         BNFA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/o/gtHT02Jz3O8VPxlgegpNT6c0RxHsWYmdSlrHt1aw2I6GihqsDtQ9vpiXzT3Rpv5XTAnq4qZQQJvScDOV/cG2qQeQ=
X-Gm-Message-State: AOJu0Yyx0Ry9UnBYpTqDyhTxHDNmOPh/k7clRJBVDXFNjvY/gAACbM3P
	7AnV6a/H1wQeATNkDQihyEsDCDwlgsNeKpSl+WIWUbhkUyvKED9pOzJ7LuwBjGU=
X-Google-Smtp-Source: AGHT+IGAK7E+kzRE8+YA/j2lb1I8Y61tiNcJdozr2Qvcpk6aaDKEVgEQPQJ+SEeGp2gh8IK9zaw/sg==
X-Received: by 2002:a0c:da82:0:b0:68f:2c72:a76a with SMTP id z2-20020a0cda82000000b0068f2c72a76amr22568368qvj.3.1708606962586;
        Thu, 22 Feb 2024 05:02:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068c88a31f1bsm1309293qvb.89.2024.02.22.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:02:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rd8im-00G85D-DJ;
	Thu, 22 Feb 2024 09:02:40 -0400
Date: Thu, 22 Feb 2024 09:02:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: fix the config fragment
Message-ID: <20240222130240.GA3220539@ziepe.ca>
References: <20240222074934.71380-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222074934.71380-1-usama.anjum@collabora.com>

On Thu, Feb 22, 2024 at 12:49:33PM +0500, Muhammad Usama Anjum wrote:
> The config fragment doesn't follow the correct format to enable those
> config options which make the config options getting missed while
> merging with other configs.
> 
> ➜ merge_config.sh -m .config tools/testing/selftests/iommu/config
> Using .config as base
> Merging tools/testing/selftests/iommu/config
> ➜ make olddefconfig
> .config:5295:warning: unexpected data: CONFIG_IOMMUFD
> .config:5296:warning: unexpected data: CONFIG_IOMMUFD_TEST
> 
> While at it, add CONFIG_FAULT_INJECTION as well which is needed for
> CONFIG_IOMMUFD_TEST. If CONFIG_FAULT_INJECTION isn't present in base
> config (such as x86 defconfig), CONFIG_IOMMUFD_TEST doesn't get enabled.
> 
> Fixes: 57f0988706fe ("iommufd: Add a selftest")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/iommu/config | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Appled, thanks

Jason
