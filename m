Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA414206F3E
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439940; cv=none; b=azPXO8xLc5hqJhjO/ukxW/3W+8XdemtwrcVVRI4IpFIGwjX/vBmEGX5ksYESscIoqUPosh9/KQn4tS4CAOR9QKa6kN8S5js3N+NlMovjiEkMHNub+HzpaxlH4eHJv63tbhNkO0R3rmmJVb7tJPSl6MbpeQTenW5gbsmNyVQPpl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439940; c=relaxed/simple;
	bh=3Ilo/X3a30c4xDyqJmeIBjYKRtFgQM1sP1z2Knqi7Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoJcKV2ps/EE3i/sEkcrFPfu4cqBjpQDYW35gdFd2URXcbgYStllNGCe98qqdmvWOEff/IKxB3m8JIAJAQAiOr0+rZLixsfScH1b7aL2OX1piJFJBPVkIIU9l8I3v0f/MhZULChcO1nM+JAYv1LY8WCGfRbJRLXAlt6O+aI4Evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFGrvy+j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFGrvy+j"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4395a917f33so9495915e9.1
        for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739439937; x=1740044737; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ilo/X3a30c4xDyqJmeIBjYKRtFgQM1sP1z2Knqi7Q0=;
        b=pFGrvy+jTedsek6US8JEqYdSvMtIjn67hBUk9mQP0R2T1lWyez5MsNnaKlTimzQqw6
         F+HcOn9miOYPkbSHvEKUHnPeZSLOVxZqWh0zYagfZKN15E+T4OJMLBEgMAq6Djx+BpbW
         t32AnBdipXTxDysbH11gx5Q9E1q9mTX8eBs3xjd/BxNWacjuAQTrjig42aESX/pQBmvQ
         FWXxTGNOuRbEnYtwMDQQ4qd6YJ7mpI+xfjes05MICDCyNswGb8U1oeFUOxejOAMrBM83
         8DjEZsyxNMmpJIS+jG1em78dfaAf7hoWL4gDwtBH4n+vXHy6uIDfE/6GeyBOU6IgVxju
         qUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439937; x=1740044737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ilo/X3a30c4xDyqJmeIBjYKRtFgQM1sP1z2Knqi7Q0=;
        b=GsaCBHqtx1NyUKYwCHwXg/1+nOBmA1hII0AV4D0Z4e7GY3Gw7eOqMP6mYXTkOQ6GaQ
         Oz/RVDf91kuwvlQUXi/cx/ToUk6pD5Vk8PpvQOIC0gb6jEZ+8nWx/A+XZgNBy0xMP2UQ
         B7Xq9TOFdiVefuvJaiev31xFbZIWe7LAJH4wdch5hb0n/fslX+c/fh91NNJ1YThZxIRT
         rG8FNvofthort6d+dGQIOqgnMxw1wLrJo0tm1RG7mZfq4FqUcEuy1604+rA0x6G4W0hT
         xuylWhYI97XIbsJ68E/k5k8P3WRfKfVmWSwjtglRNJ1vlUyIjtWPXOYBp15uSYm4NBHL
         18vg==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ9fES3YXDbJ7CZdKPJLCCzOgHvMBU/Azb+4d2JmtX5x8eTO3bZBa4WzyRC75KAUeJVdTow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKFIA+2O6ElLqr8MN9oRyQUpFbmyZgSrqPf7y++Vm3PHmg7S5A
	A3euV3672zofIGUFa/pmj8EkCytNXEduBvqZIzQ5ifl4MT94ooaTN7fSHu1W/Ws=
X-Gm-Gg: ASbGncvjqtDymw67qBajyOiMOFfgPHnRHmZeQ+EnDlf23NhzBvSQzDEtH1aYD0ORCSI
	6wvi5RHbKEY8o0lpkQSSXXQNwHFewbvgifeEBVsfOKr0Gm+JrjJIwvJLlqUpAR5R1lzOlTN3IaE
	+xE+/JsgLtneC3x6VEyyhCWL92obwEzQkopczbSbhNly9+ZNKH0O1UxQpJvpk4snryvHHFrGgUV
	Wb7+ZEY4fq4T2D/yi0yb3yg1MyTwzqSqWswUgEscTeMjK6YpKFq8aqxJtsWd3vPm0usyFtV8Il+
	jYccvuOYcQSrCA==
X-Google-Smtp-Source: AGHT+IEIeCgAGFBXoUwvmjdG4kaT43lYwV+Fkp3fDkVeP6qXvOFBGNPRA7BU0T2qf6XHumXXrDCSDQ==
X-Received: by 2002:a5d:47ca:0:b0:38d:cc9c:630c with SMTP id ffacd0b85a97d-38f24f2c099mr1998761f8f.10.1739439936845;
        Thu, 13 Feb 2025 01:45:36 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b41b5sm1396930f8f.14.2025.02.13.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:45:36 -0800 (PST)
Date: Thu, 13 Feb 2025 09:46:01 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"zhangyu1@microsoft.com" <zhangyu1@microsoft.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev,
	tina.zhang@intel.com
Subject: Re: [PATCH 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250213094601.GA243081@myrica>
References: <0-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <3-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <20250212112235.714b0a14@DESKTOP-0403QTC.>
 <20250212233053.GV3754072@nvidia.com>
 <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>

Hi Jacob,

On Wed, Feb 12, 2025 at 09:47:23PM -0800, Jacob Pan wrote:
> Our code and backend support are still in the early stages, that is why
> I am attempting to convert virtio-iommu driver to iommu_pt. Not sure if
> anyone has done the QEMU part to support VIRTIO_IOMMU_F_ATTACH_TABLE?
> @Jean @Eric Do you know?

As far as I know Tina worked on this most recently:
https://github.com/TinaZhangZW/qemu/commits/virtio-iommu/vt-d-pgtable/
https://lore.kernel.org/all/20231106071226.9656-1-tina.zhang@intel.com/

Thanks,
Jean
