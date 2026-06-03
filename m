Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E3481246
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495282; cv=none; b=VtZCHD1f/xxLtbAp8INVeL0G5/rVaocy3zID9/WpttdcaihW6vxMLyujsvfdmNC2pQWKMx61+Fpay/PrqGniHddTSAw1Dl9bJ8yLtRhEN6YHCzTKTTXVqQ84SZIK35kSUmRpRzx8oyOHyIgQFvAs/AL5dTE9Sf8DtXcgwRGe7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495282; c=relaxed/simple;
	bh=0SPmCaZS/EgZ0V0kI9JhDAG319HQSuZSW2ZRzTouxwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGdgRCsdKeHVP2zdmDitH8HCB8HPMSqX28Yzp8GzGsbEqjHFlQaHXmrW3QFMv4wg7s2XC0lJDpWT7PFQGRoK6ILWaeYklTY4lPtSN8fN8yFn7AqLEbv77/Uog4mEkDyEnOYJ6SIixYX/54E7yuqrvyXCf9ff7ijYIdS03vK4zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWHCcZp6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWHCcZp6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b1a48855so86775ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780495272; x=1781100072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIQgZlVSwyLoihF2al8NLtNtB2ubHrdRhrWZHSeU/cs=;
        b=mWHCcZp6JKWLckm978BDkM54sgG4gfHmsZ7tDkNksxXvN0Ux5ok51dRN3s9oK1Zo5+
         Ey47m0urMMC/IBwhg1fjufwWbMzV7wdG+jhqnU7NMWYW5ozQnAFjLRG/zqWvehe01IMs
         7Pbb+bZFvo7YBMHvUe814G7gUuMDXLSlE+5vsrQWxLv4E02/Cp4oHHLYkFCL0/6wqH06
         Ass3R0w/Q8ExkAlmqSdfsrcado+lM6kUtA9ch+S7RPo5Ti1zFu2Ys+wlOFGBHPifiB68
         j13LmoGaHdoNDP4YfUrmycQUMM4UwqvZYHbMof9o5vD96ZhOWI1oJ9Svm11qkh0LkBNS
         PztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495272; x=1781100072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIQgZlVSwyLoihF2al8NLtNtB2ubHrdRhrWZHSeU/cs=;
        b=BqpHxs7Av+RH1x99jNGXPd/0do+tRKMAOBivASAQY3aFCFVQ7LogIUKwaTaZlvUPEk
         pdAY3gd1O8xp1bPSbes2nIpLnBRpgg+WMJfocz1EncBwtw+wy6mmQwpo2beQdyrAIUoa
         Vp4swnqSui4aGo6Ui5FeopNs35SFRfog54hqStgHlgLoR7iLru2WO6Fz0jJh/ACoAtYr
         kbTY1W6kvmubGZwtq0TAwmAJxrerxvMCeSGqr7MDtSjbYhpQvwtRaZJjqcWHBCCtb2I6
         pA70bMZ9g70mwutZpwl9DvSmLEUMW1zZX3XydEcrIpH/pzdbxqaZplWdPZ6KQrH4M6J7
         /EcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yR7K0if7PDRwOUg3CtXAuZk0WZK7aZWkOzA+VY7gnIZ4xDB2BoYc50fmLHKP2u/hrhOrilg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1FUqDTga4jgjmxAE3J2OESbTbRG78d+4FnpfLr0bxEOEs/A+r
	HPEqDBx04bZ+jS5SW66roM2Kz2CK/E6foJXxm6Y1mz4Miw9U3sb3pmWl9lpxPGEvJQ==
X-Gm-Gg: Acq92OHt0UpXQRCFgrfuWi28UIJ6hEo02iM0a/aoivsBlibjFq40H4ZrXWQrXLoVXOg
	/JO6wQ3mHtyM3V4WpoMQmK0LUe0zQh0Q5HlV95CBEWOBQVF9zQ9cEXSIwlFCCyF6NeTpFwap4oF
	fINN4NUW7+vr0mIjWRPoHigExHWAB7zwt88KMYmexE3+n/ebbcVbTh1Eb8rXNNQib+7PYbfm+i1
	65hr/ICteQ8wPS562ubwXcQ/tXr8uve1/GwQfENPwLUVYGtaQDpUFrqTj3qvKdNqZdWdoEtEgBr
	VRbU83MKra8Mev4LD02cCkzQX35YwIPI9m+2z6+vQ6o4xwOHGKr0SvFM6OTBoRjGnUpf+BkqBpp
	Fzc3muMlApulCeslxokGj5MPpuyyeMahobPIGUzo0JuH51oPn/k7GKXqMTNfqRqvzgiZ2RjzzjY
	ATRiKoTaSaXB207B+ya8u6BaC7PcHpKQldrVzPwOBreHvB2DG/JjwNkw/LzyeYrTH6gpnLGrfhF
	mMsASDpjg==
X-Received: by 2002:a17:902:ea03:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2c16c13fc72mr1885615ad.18.1780495271752;
        Wed, 03 Jun 2026 07:01:11 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd9877d85sm6188825a91.14.2026.06.03.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:01:10 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:01:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/7] iommufd: Rewind header length in done if
 iommufd_veventq_fops_read() fails
Message-ID: <aiAzoKRCgF6Ddbm8@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <78f8caeb6a5d667a26b870e3068cec47dd4b5be1.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f8caeb6a5d667a26b870e3068cec47dd4b5be1.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:32PM -0700, Nicolin Chen wrote:
> When the first event copy fails, rc = -EFAULT will not be reported as done
> is set to the length of the copied header.
> 
> Rewind it to report rc correctly.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/eventq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
> index 1f1e415285b1a..896f45be0d2ee 100644
> --- a/drivers/iommu/iommufd/eventq.c
> +++ b/drivers/iommu/iommufd/eventq.c
> @@ -336,6 +336,7 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
>  		if (cur->data_len &&
>  		    copy_to_user(buf + done, cur->event_data, cur->data_len)) {
>  			iommufd_veventq_deliver_restore(veventq, cur);
> +			done -= sizeof(*hdr);
>  			rc = -EFAULT;
>  			break;
>  		}

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
