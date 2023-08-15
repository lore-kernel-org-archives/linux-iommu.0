Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE323BD1
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 18:31:45 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bc5acc627dso38200025ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124305; x=1692729105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpb0N73P11P1fng1QTXx03Ji9WdL7d/hlpth66hv9q8=;
        b=Lr3sJxJe2vg2AD8mB6g8WeonxBX5Bnal9Xoq2kfTC9JeWngyuS1wtJdz9d84hE+Par
         Kzj5JkKiYauubelA7xwV76FXsafKNhOjU04VmoO8oROEnYcSugMxQ6IG2cI8k6SW6kZP
         1+8H1dzRRGyhWMhDTdDxXrRWSNHLBofL6O5qY1TPWGmcYHprW7ieXvfeFhgukgVosPRa
         Bnl1cDMH3GJbOMz+ovluALBKSp3lIlV9AQJPv+i6qCLrXAm93hIClrZ9R5b3Kkmc65oB
         YHU/Cp7NFxjAqdF02ToB7CLRkFKY1hAAguQKoSO5UKm4N+CAuzcFfMjzVidPqMWNEylZ
         mqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124305; x=1692729105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpb0N73P11P1fng1QTXx03Ji9WdL7d/hlpth66hv9q8=;
        b=MwrvWRmIL6O2R4TiI5j4HOg1zzCqVGnqBMDs/tmrEyJnaBFw8wKS66n6WG/gMiG8N+
         /RxtBfwiPT0Gb2lGxlmyybeghpLr+lLREgzxWK/qPc/KDJHnAVbd0bP+lPhRMilYhf0D
         KcAiaDWnsGNVNpq7RefcYSDf4+41lPrOl6HkTNHT2JPtmGYr5+pGYUJpguKzAN5mU0th
         D7YGFjrqEHiMcjTQTbu6w0ZdslqIp7XqbAoj8VGm7IIH9vYgmxcESe3UyjSXGLoyn7FC
         Q7WWlmWY4PEqBJxNv/t9ygrC2ZKeumH8zMiZdyVvUtpJQYESf37AXa5n78fY+kkN7sx+
         Rpyg==
X-Gm-Message-State: AOJu0Yx2T3EDpiLNCAZ52JNMVZY8tuc+/WI8KROgW782iXqPool2k3VZ
	6Ed6rvuyVRdv2ukT5dUos9oxDA==
X-Google-Smtp-Source: AGHT+IEZKEopR4u7ePD1j9Hz1P/euLevar6BxZYjlaqSEPVjxnrj4l3Z4XeJnLgMkMwvHGkk9dduKA==
X-Received: by 2002:a17:902:bf0b:b0:1bd:a579:3003 with SMTP id bi11-20020a170902bf0b00b001bda5793003mr11729430plb.33.1692124305150;
        Tue, 15 Aug 2023 11:31:45 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001bdc8a5e96csm3657323plb.169.2023.08.15.11.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:31:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVypS-007hij-MK;
	Tue, 15 Aug 2023 15:31:42 -0300
Date: Tue, 15 Aug 2023 15:31:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 08/14] iommu/amd: Consolidate feature detection and
 reporting logic
Message-ID: <ZNvEjom6RD9v8Abc@ziepe.ca>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815102202.565012-9-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:21:56AM +0000, Vasant Hegde wrote:

> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 6bf55de9fbeb..242e25ba2f93 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -90,9 +90,19 @@ static inline bool is_rd890_iommu(struct pci_dev *pdev)
>  	       (pdev->device == PCI_DEVICE_ID_RD890_IOMMU);
>  }
>  
> -static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
> +static inline bool check_feature(u64 mask)
>  {
> -	return !!(iommu->features & mask);
> +	return !!(amd_iommu_efr & mask);
> +}
> +
> +static inline bool check_feature2(u64 mask)
> +{
> +	return !!(amd_iommu_efr2 & mask);
> +}

You don't need the !! when returning a bool

> @@ -2012,8 +2002,8 @@ static ssize_t amd_iommu_show_features(struct device *dev,
>  				       struct device_attribute *attr,
>  				       char *buf)
>  {
> -	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
> -	return sysfs_emit(buf, "%llx:%llx\n", iommu->features2, iommu->features);
> +	return sysfs_emit(buf, "EFR:%llx, EFR2:%llx\n",
> +			  amd_iommu_efr, amd_iommu_efr2);
>  }
>  static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);

Can't do this, sysfs is ABI (and it should have not have returned two
values in the first place, Greg would reject it)

But the rest looks OK

Jason
