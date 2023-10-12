Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B32B771
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 06:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmwcM3wH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-32d3755214dso617595f8f.0
        for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697092521; x=1697697321; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQJ/cDndsjVH2agIvBOxH1c6r9a6N1viOd7ZKtxc98s=;
        b=mmwcM3wHWlsJ/IS3pfHPHB7R3kZH+9JvSRadVS0hNsFohAA0b5p/FOMg6/60dDz0fW
         ozA/17Y7L+SgXZWcusdVuI0roqx2xlUQxKMCP0moWVJgH+WjwvL60ZGZZzNlT51v2P4C
         s5hoBnxUjik9pvbyZhFqTdTckzlpiNA02Vtc2iAjrJrZp15oOg5g7ZAtJfjaUQcRls1U
         +KWPoyqVaWaM3gdss6lS5WdEM7L5gUcBz9qLiKq6E5jArBO0KD5Fw/1Pbx7hzXCxEuFq
         MHfe8xKxC8vx8q3juS0TpvO2UaRHBCUzdpDl7P9xhowL7qM8AN8+d08NPwYGf/ucsPqz
         yIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092521; x=1697697321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQJ/cDndsjVH2agIvBOxH1c6r9a6N1viOd7ZKtxc98s=;
        b=hEV81q/pRK7aR8UJx1B9sovDW4egg9EwI66E7HBWgWrLePeUVfUu0+DdU2ZIMIHrnv
         BNoBm7ot3hPrFQ+IxMXR1/MdHbi0YKgku955iw3XY5TDDeZ7W9kZzEKOr7ic6LtO8tqL
         KIeLCKJmR8L3iVk3fUHIEiz83LOtMAoQcLurJtKM1za25Z5v9WySIaUCCUWU7WOhWPPZ
         CcVDytLJfLbx9I3PkVpyccCU0l9EIWp1U8vqVelCnnr7rer7oHhIm4XG7Y3eVo14urZX
         wfeNsTMRBlMdbItLnYx7DKcERGSFSQbP+y3fl7bMpsEy/D0ooTVXpK2DKeLfgq1k4FZa
         /tZA==
X-Gm-Message-State: AOJu0YzXldFsHA/smWZUzs2647n2pO1d2g7QFZnyIjq3nG0oeRZtXjdQ
	I+QAUNcTQG0jTvKjnwiKXnytSQ==
X-Google-Smtp-Source: AGHT+IGyIk4DWPD2t+N+AVlVanqjBQjctxVfCWWxlM2wMWm7zGXjiSQ9b0DLtWesEsgOMQL+O1Pglg==
X-Received: by 2002:adf:e892:0:b0:31f:a503:c05c with SMTP id d18-20020adfe892000000b0031fa503c05cmr21106870wrm.38.1697092521391;
        Wed, 11 Oct 2023 23:35:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm4650965wra.30.2023.10.11.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:35:21 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:35:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: x86: drop reference to removed config
 AMD_IOMMU_V2
Message-ID: <b9f08b19-80e9-4908-89f1-8712bb3b59e8@kadam.mountain>
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
 <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>

On Thu, Oct 12, 2023 at 10:45:03AM +0530, Vasant Hegde wrote:
> 
> 
> On 10/12/2023 10:20 AM, Lukas Bulwahn wrote:
> > Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
> > config AMD_IOMMU_V2.
> > 
> > Remove the reference to this config in the x86 architecture-specific
> > hardening config fragment as well.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Joerg, please pick this patch on top of the commit above. Thanks.
> > 
> >  arch/x86/configs/hardening.config | 1 -
> 
> Thanks for the fix Lukas. But I don't see this file in upstream linux tree. Am I
> missing something?
> 

It was added on Aug 24 in linux-next.

regards,
dan carpenter

