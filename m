Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89ED3242B8
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465290; cv=none; b=J818r4ShYpAV/HcjdJFiGMqx8BysToeX+w69DBRHRESI1MkGaoq5yJyJ2Yc9nbR9P8iPnrWiFH57ybX5KQ02CFHEL8yFCJk4bYKfJU50Mc4qkjeLAy04MbzAjPmAU6m3PDXHRj423N4lWxZFuNXAmuUcLyCSSOIFxTbjsp4jeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465290; c=relaxed/simple;
	bh=IzG7wcSnS0LX7TU2RQ1pHjEUVUk31vZgsIvwWciX868=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwBBU28SusHQ4yHPWr9ZciGJIUMwUlkpcW04cd+AFqwwdzPd1ncJotOODQ4cySlEYLoCN9kKsVFFchhCGtsaj/hcXRWXeD6+0qo+PECIO4qZZGPhBtSv5k+tBxQHFte9zvdbTNk60O63qIRkRuFhx9RPYflzAwalY4wYVvCznYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=onmahif+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="onmahif+"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfe810293so767611cf.1
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786465286; x=1787070086; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iF1EovNHXjlni8LKG7pfSf4Sk3EXbwMQtSznu/lYQFo=;
        b=onmahif+gWBX4kKpbIj6tfEeuBD8YT7e+ZLhc6pOpWksD4/selwN0B1C2/ibIGFWxq
         B6AS3GVromGyoRmEBeSwELdqY6e8QMgnI0Z6mbODEoUEY+5YyZYZ4c6AQ2aNcstfJKKu
         6z6YALuu4NtQNjtRZrbmXctJ0GqP4f7Hbehv/HvXUN415pqoS31FSiUBHQPiJ1ER1Mfq
         EFNaWjUFfkebuLZUGHr1LaobuYJ1vlD7QwEeC6zsnN+Kh4ttd9XxAIWUfzd/4GugT73K
         NGMFPSwm/Jtr9l6++iN3pAHdtUTzHr+82YWMceElo45v7AIA/xjA0v3NQMJLoUoS57Nd
         7rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465286; x=1787070086;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iF1EovNHXjlni8LKG7pfSf4Sk3EXbwMQtSznu/lYQFo=;
        b=bTYaKsbWpnwylnmSJRVOmSTWdcd8Bu0PiKauBDJMgmmb7/mwzDSL5WEp/vTRE1Rvwx
         Ux+CuRJvhZ9qDofWvmu1dDuYdqn9wjJ5a6To3KMyJj4sy8j1q0EujkAOP4gckor7TQXE
         HKA+oLFTHbir1xXnmKTu5KI9IEyMB3cOPuk84+8/+vOi4jHdlR91zvvkIIvVdoasclKQ
         QDs7UBeE5OkQXlKtqwr5THf780UEyQNGt+NJPSmkVS2aphPbuG9dsYCm99EIzG/3AvBd
         F8wOb3p2VgqsOFLRMAVuUV7JYkpUwewiXWs1XbzTDWI4TQfYpM4Gx0vCgplUovWS4HOq
         MqEw==
X-Forwarded-Encrypted: i=1; AHgh+RrffhCI3RKT1AQuoL6kk85UebCmuGwsdc5BQ1J1LtUk6ccEDkn06RFAngWgxejtPUQf1iFZKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYzPGfmirkDnVpjIcz7HcrXV9+yKPhb47wj8gPsAiRxVFbiBms
	3xxXhJdCQy/t5QLHdfS+VIcThZ5639DTVH4sUU+TJznlFKMKWe6wqZdO+XNUyP0aSgI=
X-Gm-Gg: AR+sD12r29+OQSu7lg3Qixo6+spMRFFGjuij7iCSHB5zNFWETv/mVm/TCl7RnMzHmPe
	ZYMj50hYybdPaJ0Itz0zUoPJrnJg4dzAD2rQLXRo6bpI0UjNUJq+hwKf5XMgehRexWT9uuJkBj4
	laT7/UCiDwFtWUD+FTK5gQvXnBoeRwdAwkvkpVQyBSHgCN1z8/TlkqTdTZMVvTnpGgsekU8oTLZ
	7n24/Dv/5F3u8lSdkk6fTUomdL6jc5g6+jjSbgYzEs+K/bbIUpiXb1kcn5CTw9N9udIr6GcQmA9
	tviygG14P+VpcVx9Sz1sZUj+lKmgzyyvGEKzAyBESRmIh7YUUfA57lTS59iaZtG6n/Rsh0X4BIO
	N+MQQjhzgV4YrOCALUw+OY/+MX3YhaQF8HCD8RhIMEyewn0M1RNT0AlK9j3UFsdDNV17jdOHSBO
	mpLS9t50KSxy6WCC3Xdu7JVEZh7EWHxmyeoL/UpA==
X-Received: by 2002:a05:622a:4d43:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d5867e85amr44709981cf.40.1786465285899;
        Tue, 11 Aug 2026 09:21:25 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c39254fsm2441146d6.23.2026.08.11.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:21:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtpEC-00000002Y6b-1J1V;
	Tue, 11 Aug 2026 13:21:24 -0300
Date: Tue, 11 Aug 2026 13:21:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <20260811162124.GK544626@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811155022.108148-4-zhangyu1@linux.microsoft.com>

On Tue, Aug 11, 2026 at 11:50:19PM +0800, Yu Zhang wrote:
> @@ -50,8 +50,6 @@
>  #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
>  
>  /* Reserved IOVA ranges */
> -#define MSI_RANGE_START		(0xfee00000)
> -#define MSI_RANGE_END		(0xfeefffff)
>  #define HT_RANGE_START		(0xfd00000000ULL)
>  #define HT_RANGE_END		(0xffffffffffULL)
>  
> @@ -3097,8 +3095,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  		list_add_tail(&region->list, head);
>  	}
>  
> -	region = iommu_alloc_resv_region(MSI_RANGE_START,
> -					 MSI_RANGE_END - MSI_RANGE_START + 1,
> +	region = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
> +					 X86_IOMMU_MSI_RANGE_END -
> +					 X86_IOMMU_MSI_RANGE_START + 1,
>  					 0, IOMMU_RESV_MSI, GFP_KERNEL);

Maybe instead of adding constants you should add a
iommu_alloc_resv_x86_msi_region()

That is just an inline doing the above?

Jason
