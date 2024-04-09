Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18C81725
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659404; cv=none; b=L4vGi7pO3VXkwWFxrFIcEfoaEr8McXp4csZW5ikWvRJpqaM90DcAD8uoLoHJp4920En6iF+VBLs+mcaDuZnrQplC2fwP3JOLe5Ay4tnOtFIvnIHxMLCKaDXLHzWH8puxqx7RUjb4LT4UW0/RVerHK/QvikRW1Acc8WJOLxs/QUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659404; c=relaxed/simple;
	bh=P1drV4PVyYjqV1TiHKD9r5Q92b00wwuRopyWCFjwIO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6WoxxfOm/xgqiFMwiAyGIWt0MjE6OIeVGjqUvSeU4Lgb5YlCLl9yVc+1Q9HLsQbj4iktXZvObiDJyTMcqvsZLfaVM/2ys3Ct7JurPYZX+ZzKP6AYPJnNR9Kk/5S1pdIayth8wmKdTohidZlkufBXczA2xyV6rmRBTmoPXdwyT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgN/Sw+4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgN/Sw+4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so66945e9.0
        for <iommu@lists.linux.dev>; Tue, 09 Apr 2024 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712659400; x=1713264200; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ikQVwwVGg1QRlqcNnHhwQAmZ6t6nRddh161TyahHqsI=;
        b=HgN/Sw+4HVdRVY6GG4Oayw0v6ItSkRcMfzZboss1WnHPn2KgN5iTr3QR5eanVwoRk0
         wUPbZKhdZApW1Ljyrv4T/AgnpZFxOdbuFbiuLJgFRbpMnL3S+LKTRAOd0CAKwDOWHB7E
         jdXtuVQUr5n6cUSAuRYnAZqPo9LtDG5MoZqHLNiU0yihDyGejevw6/FW0GpLJFyw/xKX
         2g7tTVNulqFY1D1XIu6IUvNbt0QRH0bmjkTYErAUrhyJq3w8wxK4860OIOCa5HcisYIv
         Lxhex1Q0MRky7hs3I3HNKWrpUh7QsvT/gs2PHF1HbQMf/m0AqIkUl1WgTdODOTsBUI5V
         li1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712659400; x=1713264200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikQVwwVGg1QRlqcNnHhwQAmZ6t6nRddh161TyahHqsI=;
        b=Nj69xMgdmdYA+F1cgBzmmEKvKJvJM4p+NxKA6c5pbWrdHF+0zRztU+tsagYkylxEz0
         Z7ds1CfyNIsCHXciTW9XnqDfgCtcHCjX1XHcJ9I0uPsulwBR3SKvB5adT4f9sS3aBPUj
         c0JLjj3LsiKiBiSN+AxmXWM2fIHA+gofg+U3DtQlGhP5K436eyn1IY0p0ogjQGH8Lij0
         q9VyNyd5ZMftM17hHobwXg/5GNDvruFOrp1AyJsISpDWTgSToEHS8tSwUYDti+o3MV7p
         AYkEC/xlymeQqn5n08fKxwf5ojzgs9oeoIf9+A5xyxmEWjD7ywEx4iuNGtFm1gyvtc71
         eU/g==
X-Forwarded-Encrypted: i=1; AJvYcCU64x1LKhO2xJrHWYX0ctA0neNY55gSC0faI0DQ7uQ4Kju9LkBNyQBsRjzRU4pjdUE9f4MelkEHEUeJ3073G47pzjDJzmM=
X-Gm-Message-State: AOJu0Yw080sVRsAAgcjImgyCtoBoJ88QOm6bAG0ii1Ih5TQwLlPVHEmn
	snbDwoED2Kg3Iu8Brq2mP17hG/XvCiX8vfhKsu9iwH2nZVSPzvh9i9d2rEE2MA==
X-Google-Smtp-Source: AGHT+IEmRPrla3hhCrDIRObyh+HMBsdD+xkXu0Qn4yIa7MpXx8XpCnlB5sSXyw9+afvoI4IVfrqHbg==
X-Received: by 2002:a05:600c:3b21:b0:416:6b86:852 with SMTP id m33-20020a05600c3b2100b004166b860852mr150180wms.2.1712659399532;
        Tue, 09 Apr 2024 03:43:19 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00343d6c7240fsm11098732wrp.35.2024.04.09.03.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:43:19 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:43:15 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Aleksandr Aprelkov <aaprelkov@usergate.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Message-ID: <ZhUbw6gAeBjpFz5C@google.com>
References: <20240403053759.643164-1-aaprelkov@usergate.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403053759.643164-1-aaprelkov@usergate.com>

Hi Aleksandr,

On Wed, Apr 03, 2024 at 12:37:59PM +0700, Aleksandr Aprelkov wrote:
> If devm_add_action() returns ENOMEM, then MSIs allocated but
> not freed on teardown.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
> ---
> v2: Use appropriate function for registration failure as 
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 41f93c3ab160..8800af041e5f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>  
>  	/* Add callback to free MSIs on teardown */
> -	devm_add_action(dev, arm_smmu_free_msis, dev);
> +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
> +	if (ret)
> +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");

I am not sure that is the right fix, as allowing the driver to probe
without MSIs, seems worse than leaking MSI memory.

IMHO, we can just add something like:
    dev_err(smmu->dev, “Can’t allocate devm action, MSIs are never freed! !\n”) ;

Also, we can’t unconditionally fallback to wired irqs if MSI exists,
according to the user manual:
    An implementation must support one of, or optionally both of,
    wired interrupts and MSIs
    ...
    The discovery of support for wired interrupts is IMPLEMENTATION DEFINED.

We can add some logic, to check dt/acpi irqs and to choose to fallback
or not based on that, but, if we get -ENOMEM, (especially early at
probe) something really went wrong, so I am not sure it’s worth
the complexity.

>  }
>  
>  static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
> -- 
> 2.34.1
> 
Thanks,
Mostafa
