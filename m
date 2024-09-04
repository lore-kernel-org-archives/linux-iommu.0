Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4363B1DFE33
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466230; cv=none; b=d48FHmQZSgmiJCkrD5+3ifDgAAIpn0er+ycyixaYnins5BSFzqsKh1bwfZBegC6RMo5m65ktLpTGZnoZ70VIGRChsUNwiE1FnWYJzZxR/xuRXVQqaj/3bAnVz1E0T3mVFly+tFI0/rc6zhky0Swyr4gHctMgDBX608+BUZpvYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466230; c=relaxed/simple;
	bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5TGhbdXBYDTTTy9Qf9fcXKSXO5+YzrdDxnw6x7aa7rRkxSNtfigcImq8eBzvWiqr1K0+tKcf0Y8XbHiiuGWzG3WyYCYvHxIy3eaKwh5so/Ys/zAnvfwEMoyLf4/Cqc6OqdYbx1iq4DFVZ9xFXeEsBfcel/zbeEX/gKYcZ1P1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Nq9FdoLS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nq9FdoLS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-457cfc2106aso20362011cf.2
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725466228; x=1726071028; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
        b=Nq9FdoLSV450tWVN4LbUDtrAab16LjGo1S4g43x/ImfP2gTYLq5Kt3yU8vaRbyUxyB
         35EIT0kps/UazFyFN5EkVhNwRCAMqu5lNL1xnJv5Hor0NUDXcOqLKpMbXAJJs6gVPWzI
         Qvl++HgXTMxBeszca5EJv43lRUPfdhWfE2OdDJIvExVWbItatYGM42mkCtko6QYvozyF
         nRFaHMov74yc1BT6/cV40GhGT8HVo1OClnpWPXw6t8KluNwKUKpomR63IzF5tFcKo0uW
         srs6ZKZXdU9lo1eZgD+0WQ4qr8Ak/6MdzoqHTCXI1r2nh3rCjkvYqjqkqbHBeQLmvrPU
         QHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466228; x=1726071028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
        b=HAA4WT1+jkjD39iUrNpMPQ6/ys0BdAMAmM8BnUR36LD5fL8E3XBBPPOluQyPOdx7an
         KtvshawGCwpo1cmrTNKvrKlIjNxAStOeSF6e8wvPXLq3EhEdLudykQBUYr8EOGo4fynm
         yGzsb+YUHIRH7bV1v4CZcpq6w01m5qnsKZ36f4TLDhARf0+Ki+L7rnDrTzD566f+ccKV
         rHZHmWZV8hMMFlxa8lbNvjzLXISEYnG+eMajq69C3V8/BhM9CJck+avgZlpSMkQpRVfM
         BvXExwmivLlChxL/fyxLSK5OUcrQRW+bRLRZCKLHekYRXTJZRR678O2h33LDzI6fj3/M
         f3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXPCwLAwji65FdJRmS0QFzy/ZFDY+ieFq9Y+zWOn7GOxr4Ba3lBd4n7r1Sp+hpt+Fgn6ICOpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf9QBxbV1mrK6iADNYH5LGcULxOkT6/sTyS5rvAZ4XRaMAnIQE
	hudJZVwjVPYwghKqyqvYX7vNYHN3/8jR4/UjmoIAkxtVFvcI1T0uktaKbMQFQio=
X-Google-Smtp-Source: AGHT+IHK4NXjBOWUCjPvBi2kpRLHdj4b5nBYnVLrUwbShKXuSggGV0DYJ+x4RGFMamYZLzah7RbD6w==
X-Received: by 2002:a05:622a:5109:b0:456:7d0f:f426 with SMTP id d75a77b69052e-4570540f463mr152174381cf.52.1725466228062;
        Wed, 04 Sep 2024 09:10:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce5b05sm60158851cf.51.2024.09.04.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:10:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsaR-004kUs-1e;
	Wed, 04 Sep 2024 13:10:27 -0300
Date: Wed, 4 Sep 2024 13:10:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest:fix a resource leak
Message-ID: <20240904161027.GD1909087@ziepe.ca>
References: <20240903200806.9803-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903200806.9803-1-liujing@cmss.chinamobile.com>

On Wed, Sep 04, 2024 at 04:08:06AM +0800, Liu Jing wrote:
> If the file fails to open, not only return return1 but also close the file descriptor,otherwise resource
> leak will occur

Why doesn't FIXURE_TEARDOWN do this?

Jason
