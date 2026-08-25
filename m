Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C52192F9
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653936; cv=none; b=PBpXkYQ9RboaPa07tDLn85igsUuQTn9fq47jcvniTweNkY4cxgOL2qTlFVXuYTPjBhIEJYw74ajE7BXeKFJthyVra4p+iMNwKSylCRbayjoKlTS5yZuZtNbPm8gRjM1Jym8G/Gs6pdt+qefu0yqLWTIZ5u4Xt7WAp3cVzmQhwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653936; c=relaxed/simple;
	bh=4QTkjd/s8diQPSf8tQmphgnN9lPOUKEI5Qx+/DyJBEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsvCr43ezAHjH4OMBhM6MNUuyua7axBKtqSO6dw5i9KOzHkVJm/h+b8PHJ0sISO3RmlL4nbuFdJDfthPTyf0+ugPeGk5Tv7w18CdZkdAvULqktLJzFWjc9aBJ4sRig9HhUYFuUnqzMfSzQNULo4TWdI5AcvlQLN1i60FIX0QB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRTVxqBB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRTVxqBB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccdf36f63dso101635ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787653934; x=1788258734; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+r+5no3iFtMSZafzKDoU+7TmlqdFwa3seHnjZcCnMD8=;
        b=nRTVxqBBrcw26JV7Ccah4K585sJG8c2yvv3yVzpACmtmCUcmQFwc3gbPjMmmMKwVeg
         iTCVy5c+dYyjvnhXTHiJW3mUs3+prQ/mn5/URM+SqhAmqiTk7cIhP/g+2Pw4QoxQH+K3
         w9ThEYFcLgQyy8w4qtWonU28CAUZ247Bp7iWeIogwc8dpvJVYUZPWLw4xsbZJ6coUYPV
         A+U0Rktrq2kt67YULWvShe+CG0hWQ2Zxi3y5NALbxU4QZy5SqY9hUaZuXEPMeyVFQyEY
         Rx/A/mjQWanqoDLaL8qxj5WtrTHMWhNfVBCKcUIziVIvYSwCwmaH4E74w3aUrfzNpVeH
         cOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653934; x=1788258734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+r+5no3iFtMSZafzKDoU+7TmlqdFwa3seHnjZcCnMD8=;
        b=IkuRsGxq+CMtC0IsrW2BCuo/yXPflx0nVahC62Tw8pGGlUvK9fhfqJBIPjJcchPImU
         QP0y3QQfemHVh9g7yeHX4yy6kqVPObfE77IeroCsiiOZp6y1hg/oHXFI0d7io7PKQNri
         4iUzpMzUeeih/51f4xGmXYNK6aw3G+IssljfQ3j0EA2+kFbtHeyVYRwBozJzxGtG+em7
         K1ODCqV5HDNDtzM9MW7qfu8ieL+3iFQNV7EAyDgMy0IlSdfZh+i9y+B1EcljCRyNtsxV
         lVsojTQRxTxVzIcczM+NcTiNCeh729CWPK5lAqcFTOLdYdlCzwLT/iEEWTR1runPbc5o
         LoYA==
X-Gm-Message-State: AFuF++lrm3IKIb63sBkj9/HPztBhfVyAMUGC7c4L7chI5bGKI+EhTRHI
	68h3vwmBNc5tSkVmmgBqPhvED5I4LYzohDnkpNhirt+UAOFgvHd8NTRII4yYCF5M8A==
X-Gm-Gg: AR+sD10XjHHgMbZfWNyiG1+LnuSkmoLk15uKJdLoJ9pv3jDFIphv73Atq3Byqxh1dNj
	c0Ir1hDPtl0sw/KRjKMfNvPre6045DIG1tLWempX3RmTELPEg1KCpUDE49fGvsz+zOMhNyR+kvQ
	ybmQVbKC5Zf5/caKDHNK2iOhiT9L0aeLt2oTidqIyTb1lvAzqpemxWSqlOuWgQkrVmt8Bgl80Pd
	st7yX3F+u1ajdAo4JMdWrEXDaEua2EDOOxDv4141JNRfu/nVcYIJk1Dw6ujdsL03ehjMN60Bvu5
	QFSAR3lqtE/Pa5u5Gt81257advOGHx3a/fmQncqii/e6mL2C6V9RIKAsCPdB4X7HzpW2UvbOfMs
	O2XTS+BX+LcNOXOksZvr8p+3sz5lYHh0g+hB55yzC6gXYH8Di7H4WIyNkVTiYTJxpEAJrI8qMiE
	cOzLom1j6s9Z2Ekzhpac1wlJpqq7OvitRiea8xgxYgeuncWsBciBdxh89uIF4JTu+2GDVRFQ7Ab
	p20oA3YHK4cOnA+zztvtxo2yYOsopGjiZAozcjICg==
X-Received: by 2002:a17:902:c394:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2d6e0833465mr4854905ad.3.1787653933633;
        Tue, 25 Aug 2026 03:32:13 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645bbb87esm3420518a91.13.2026.08.25.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:32:13 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:32:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <ao1vJxkZsJpr1qXG@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520117.3131778.15279605903087565179.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 52 lines skipped ... ]
> > +/*
> > + * Invalidate a DTE by clearing the Valid bit first.
> > + * Note: Lockless; Not to be used on a fully probed
> > + * device with live dev_data.
> > + */
> > +static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
> > +{
> > +	struct dev_table_entry new = {};
> > +
> > +	write_dte_lower128(ptr, &new);
> > +	write_dte_upper128(ptr, &new);
> > +}
> 
> No need just call update_dte256() with a 0'd new. This is how all the
> update flows work, and it flushes the DTE which this looks like it has
> been missing all long.
> 

I originally considered using update_dte256(), but iommu_disable_device
is called from the early probe error path (err_deinit).

If iommu_init_device() fails before dev_data is fully allocated and
attached to dev->iommu->priv, we don't have a valid dev_data pointer.
Passing NULL into update_dte256() would cause a NULL pointer deref when
it tries to acquire dev_data->dte_lock.

That's why I introduced this helper amd_iommu_disable_dte(),
specifically for this early teardown scenario where the device isn't
fully live yet.

Thanks,
Praan
