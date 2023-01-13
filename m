Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777B2F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 15:35:48 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id g9so4675983qtu.2
        for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 07:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYVvKGHEE+oYnjn9skOttBAneMTWe58z8SoKkGSeO2g=;
        b=AioQo+qFcyZG3CO2jiZc3Oky6EkI6b7DYFOaA5yUUD+57NQVLhlSpIYuX90mAKOkWn
         vZQEZ5Aivi6SFgc+gpMXuTS1GLAt8mfhj1UJjbi7uXRykqdIrhhjq/dc3b/jYL1OOZ6I
         mmA3n/Teh2lZPVQY1OV4p6XFNnhcLKLAVlhhssJA9E2oXosvGpIKSINbi0TjKQEPocQh
         1sBa3PhHSaCR1w7IB1KlLBSy1pEd56tnZgsztraOvMr6uc1BoGUpTyS31W7SBEJ/n0A+
         WrgqigH8xE4y9+qGZfuRssUMSfZCpJEixzgcrAaxpjYLWtp7TpAVZYNn3UMH9UpFf41m
         AmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYVvKGHEE+oYnjn9skOttBAneMTWe58z8SoKkGSeO2g=;
        b=2z5kqJmFXMnNv4QhgJ89rOB72qCsW45iY4qeTHzsA1jkvGR6vx5AbdxW454Mmy85+G
         ikGC9j9RGmKDcbae1vbWCENe/eovrjwnD4ib3zUVAbt0HkJWksYviza2SFLYuX8zI+2g
         zklHX7UIQ5knxAV+/eyTog6eYxTFW8gsEPakW/xSV+TgRixfw/elCYjZL+cq3aWqA8ja
         m7M/rH4Ib5pCKYzro0iZhSMwjrVjjq7PY6IjBscjHaeandqrOoYPLBVcECY/hgWTzgRT
         0kmF5Rj4q7RzpKkTXmFoqtY2awubkDyzzwpsSDwGEz+wIZLzXy6qEaZ81NzF3Yus5pao
         Fmww==
X-Gm-Message-State: AFqh2krkT/8tY9bt8wTuJ46Yu0My/Q7t/AyUFdRnX1xvTvi16UcQ+qL1
	EQ2yVxWpvDs79t5+M7t0nia/tA==
X-Google-Smtp-Source: AMrXdXv/q++WAk09vRl8JM5uJg5HSfaNv1rW3L1eILGDWoEFZU1DLcO+a+YmZ3RNsHsAmqh8/AdE0A==
X-Received: by 2002:ac8:6c7:0:b0:3a7:f424:d1bb with SMTP id j7-20020ac806c7000000b003a7f424d1bbmr19820385qth.21.1673624147503;
        Fri, 13 Jan 2023 07:35:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id jt14-20020a05622aa00e00b003adc7f652a0sm7087732qtb.66.2023.01.13.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:35:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pGM5q-00AJnI-CF;
	Fri, 13 Jan 2023 11:35:46 -0400
Date: Fri, 13 Jan 2023 11:35:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, ashish.kalra@amd.com, thomas.lendacky@amd.com,
	vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Message-ID: <Y8F6Uoi73BK6R+mc@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110143137.54517-4-suravee.suthikulpanit@amd.com>

On Tue, Jan 10, 2023 at 08:31:36AM -0600, Suravee Suthikulpanit wrote:
> Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for assigning
> a KVM structure to a VFIO group. The information in struct KVM is also
> useful for IOMMU drivers when setting up VFIO domain.
> 
> Introduce struct iommu_domain_ops.set_kvm call-back function to allow
> IOMMU drivers to provide call-back to process the struct KVM
> assigned.

Also NAK

Connecting the iommu driver to KVM has to be properly architected
though iommufd.

> @@ -1652,6 +1652,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>  
>  	mutex_lock(&group->group_lock);
>  	group->kvm = kvm;
> +	iommu_set_kvm(group->iommu_group, kvm);
>  	mutex_unlock(&group->group_lock);
>  }

This also has obvious lifetime bugs

Jason
