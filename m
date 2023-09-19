Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466333990
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 12:11:22 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-773a5bb6fb6so301434485a.3
        for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695125481; x=1695730281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoyU9rzOy2BlH5KRJkQm4RzvdmE5afgsiRMrXPWn1pU=;
        b=FnLs2c1HKwDo9QYBNMlN4uO+92ZqFazJGUpSrOW6/QovthyAs+rWXPc8ZQdYnUW6FO
         2qEv650DLWegrkdZw12oSuVuGcSwMmaK1otttpJnF6VmzLdrpuUdtH5NIgPwcWALx7R/
         mDxma/RpXRCFVXw+2/80kB2Tb9+BI1RS1tY8GFMkRGafI9xDvzJk8x9ehtyBZWDpb6fx
         vWVqLPxtTi9iOymoHbhZ0yo9Q7jAjD5hvI/B62fkNL7YN4g+qsNKjN/DPcT0BdMtzlRQ
         v/LPv1unTygmIuT0mdRbowAsHBPt415wuxJY5qdgSthFI0YHRPyL2b5dYS2C/pT2zCd7
         wV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125481; x=1695730281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoyU9rzOy2BlH5KRJkQm4RzvdmE5afgsiRMrXPWn1pU=;
        b=NvyUnUZbT8Hyv5Ncgt3GZit2FeOf+k1mgmYB8wQnD3w6SMexoMMEaFX2cyN1xe8q31
         td0SOQyBDP5rAJ2h76FGyK1wHqaohrOidqBxbv71wgi+BhBRXlhNM4m6Az4vHWsI4mn2
         Wkf5gzHMXFjIzOWp5mTYA1asrZhwXxCEQcErJCQmHS0aBI0+8WGcpEzo8qF7bEhhmUrx
         o69ZmxapU+CRXhGF9BDGzfZurKydVeAbrEKvNgmbUT0GRZumh3uoKIhm85Ot2b5m4Ah4
         joTR1AEU3dvDHOTg0p1dGYzjSzXdOd5JjA8Uct+QlNbDuWVI31AapfD/W4jvyJoOY8wT
         M48Q==
X-Gm-Message-State: AOJu0Yw/pbci+sItkjyih08MkkKIYo9xhlUuGtgdYZOFlVbXyRcOvzyX
	CQvyjbEr1zr4MTzFSxZ/R8nthQ==
X-Google-Smtp-Source: AGHT+IHVTs08d8NaR/JqyVVIELGCXA1MekrWnfCHt/Y23q2QJTj4sfAfOGSXAGhdaB90Vcbx/q+Srw==
X-Received: by 2002:a05:620a:e07:b0:773:ad9b:4c81 with SMTP id y7-20020a05620a0e0700b00773ad9b4c81mr8836359qkm.23.1695125481742;
        Tue, 19 Sep 2023 05:11:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a13db00b0076cdc3b5beasm3909448qkl.86.2023.09.19.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:11:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qiZZW-000EC9-OI;
	Tue, 19 Sep 2023 09:11:18 -0300
Date: Tue, 19 Sep 2023 09:11:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: GuokaiXu <xuguokai@ucas.com.cn>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tools/testing/selftests/iommu:Fixed spelling errors
 in comments
Message-ID: <20230919121118.GS13795@ziepe.ca>
References: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31680D47D9533D91+20230904023236.GA12494@xgk8823>

On Mon, Sep 04, 2023 at 10:32:36AM +0800, GuokaiXu wrote:
> From c4e404036e0a7ffcaedc5760bee234713ccfe4a4 Mon Sep 17 00:00:00 2001
> From: GuokaiXu <xuguokai@ucas.com.cn>
> Date: Mon, 4 Sep 2023 10:18:04 +0800
> Subject: [PATCH 1/1] Fix the spelling errors in comments
> 
> Signed-off-by: GuokaiXu <xuguokai@ucas.com.cn>
> ---
>  tools/testing/selftests/iommu/iommufd.c          | 2 +-
>  tools/testing/selftests/iommu/iommufd_fail_nth.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
