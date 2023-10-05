Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808128DD7
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AymiYEIP"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77433d61155so82863485a.2
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531450; x=1697136250; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bv9JmOKZp2Hb05ZdRhbebweP3aei/gOx0hJ6idhzHDo=;
        b=AymiYEIPwH83ylwjHtDKpuBRjK199b485z7imSKp1G+iSlRnsN2LFU4CM4LqwQFkK/
         iHt84CNNzNQrtsFPg1G8OKNuxAcUWEhFZPeD3xVrecZkLfk6w5Eykr3rIAdwLpFiWn5H
         pFQaS7FSTQ5TxZ5eRUvTy/9MP2I7sCbJrZwWVIwIYZKabv3pDah7UKvCgc3fOrot4OJX
         fcTY1tklxtvSHjhAJa3HHtC5BnthFdOysxBowvLSEYukGg8Jn/ZSWOv3cmFK3JsUxzLg
         ldm76RtH62Hde6wkwb5lKuqic9ny1V+duxDr5rm2Mjz5ypgp0cshPfVQbwrHKrDLgkSZ
         B/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531450; x=1697136250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv9JmOKZp2Hb05ZdRhbebweP3aei/gOx0hJ6idhzHDo=;
        b=mGRs40xK4otGqKA5O12/ypPDIjPP41/cpt4/8+O52i4mfWLXanPNVU4Jejl6iSeWXc
         wd01TbDm83wsKsa65mRb/VOhqO5CUXsj/gsDvHVgk8OVzbqnnuAggoFdVrHg/gZbnLSk
         g6fpD9z/Pg2UxrY+lR/1F0/4Qp1SEDDt8rYNfbDl55EojulygSsM8/uOwk/JHmswjSN/
         acYp/txUpIcSOMFeRvORQfa8cF6RcTlG1T4N6lUa7/rTEv1+ssLdODMOJiN76KG969zO
         rIiGWImPAalVa4yjWDGr+MhxNbZQCKMREcFoogPvX3hUw1yJK+RgkW1nafnQ7C/0nB6o
         E3SA==
X-Gm-Message-State: AOJu0YxxA2XgFDCihHXqQqo03i38A80hdQ+shuQ7FylzvoXFIiwDJ8sp
	/zQGOyUhiPOzETdepAls4FMCcw==
X-Google-Smtp-Source: AGHT+IGpRjhmIMTuQ+m//sL6RHcvn5cUvDqoQah3pNtQOHd+HXQ6N6hjpVFl1hyzdYjzT33Zbzlukw==
X-Received: by 2002:a05:620a:2953:b0:775:cf5f:8a81 with SMTP id n19-20020a05620a295300b00775cf5f8a81mr5961620qkp.62.1696531450088;
        Thu, 05 Oct 2023 11:44:10 -0700 (PDT)
Received: from ziepe.ca ([142.68.26.201])
        by smtp.gmail.com with ESMTPSA id e2-20020a05620a208200b0076cb1eff83csm687090qka.5.2023.10.05.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:44:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qoTKO-004Z4y-3f;
	Thu, 05 Oct 2023 15:44:04 -0300
Date: Thu, 5 Oct 2023 15:44:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] iommu: Introduce mm_get_pasid() helper function
Message-ID: <20231005184404.GT13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-4-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-4-tina.zhang@intel.com>

On Mon, Sep 25, 2023 at 10:38:10AM +0800, Tina Zhang wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a4eab6697fe1..db2510da28c1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1189,10 +1189,14 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
>  {
>  	return mm->pasid != IOMMU_PASID_INVALID;
>  }
> -static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
> +static inline u32 mm_get_pasid(struct mm_struct *mm)

This should not be in a global header

Put the mm_get_pasid() in iommu-sva.c as a helper

Have SMMUv3 call mm_get_enqcmd_pasid() for now, it will be fixed

There is no "mm_pasid" that should leak outside of iommu-sva.c except
specifically to support enqcmd.

Jason
