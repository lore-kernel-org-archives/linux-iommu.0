Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17304BCADE
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580466; cv=none; b=DpMuWbUdaRvACrj8eFaa51xLCNwH67O1lBLcsAJMHMTwV5D6lJEP6vwUqSmy4pH+oZL62qBTpVacD+2lQqQOFlA00qxHxLzCIBSSAKFA0z0y8C3jj3FlUpAnpQGXBpDGH2yUdwLjz166qalsINM41n5knKOYDSpSGS9gnuOLJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580466; c=relaxed/simple;
	bh=UZuNloMwiW+tHrGQ6MZ2lLA+dVPzlHThABVURqhAJtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A/kWIh+6Gtu/gAO+SAdy1vZg/ECuf4+ilQ4UfGi2ReAZfVw0heP+3crp6lqw0zmbHZSXw/gj1T4Sv9Sf9TX3ZJNIXW+5y6wa4Mvcy8kzshPlJct2cOkqPunDwaagR/6rKyFRX1nk3Bx45WgTFcHqrRF3ETs8HnwWUrIJXNXz7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NPXzW/vd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPXzW/vd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba5f794825so45299245ad.0
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778580464; x=1779185264; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4BRCH8Q+sSIoCslEFIamY+nsMlk/tKqIeqWpZmZWSTw=;
        b=NPXzW/vdbYybQ6MdX+pyZmXLUNmciKJPL84ejf4fch6mu1KcYoxDE3S+zSFeOwiPEV
         tvvqdn4ugzDP3RQox8wu6WMwxWQQS/7THLXOyHdALjRoqJddtOhzDIEIjd5gN2ZcdBZP
         0ILS+1i0felGJdkxlpr38tEtUmqZFWSmm7VEe+atlrkaC2qMszQer/WCDaUk8W4L1AR9
         VnDvK47ltnPHO+CqXDXZpiokBHCx+xmsMkfefqeanRK4RlSeUxiXA+xBsO2DQf6Rf2m9
         qJHkYiSE8+u28HONZg1b4R97diDHkaLLNLkh8Bzjqq7FSzp1x4F2YAvf37y65EJh7E8d
         W0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580464; x=1779185264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BRCH8Q+sSIoCslEFIamY+nsMlk/tKqIeqWpZmZWSTw=;
        b=b3s0f0LMAhEyg8uw4EIMiREZuHyjx+PrGT9qFvY3mZb/onn8n1xX9Tc2JjSGFbzR1s
         kQ32/gajIcXS9NbGP2e0nyX2lxyjQDsl9JEYuIa/Fn+fJpVfX02LC36RHOn/JUjlVoBr
         MQpwAexW5mHy3fpkmGKsQp9VxVA747FPOns1TWbCRpB/b9szFS88FDoE7AuoUi1vNP+X
         ph2AdYILwmFHPzUsKS7VbYglL4dZtOz0cNCIZzBk7GHSKcZYExOd8FmDhqzUOnnGmBWD
         CMwxrsPwejZ4RS/ic0SvDNTGcPXFnCnKmM+pqqhkFswxauGdbT05PBl1K2boC+nhYxGj
         cfmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t3bOcV6X4SE8sv+B/Zcwq5tvlsffJgrhFsaSSGJdFxtbAzqj7gKfFy+80nGBJTXvPc9ebcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJdaLZwbkH2ON2ybsgjLNX7Lk9Sm0FEd15EG8oe9//oVHorKF4
	B6TXyIl8KfQ+c1H+4ym8L7OMG5YKwBA11g/SZlryt4HnT3UQavdTKE667/e/hRO1ISh5WZnoeZs
	agcXS8bmGPI/jBIF2UzBFbHQ1qw==
X-Received: from plqu15.prod.google.com ([2002:a17:902:a60f:b0:2ae:c329:bddd])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ac3:b0:2bd:7ca:e67d with SMTP id d9443c01a7336-2bd07caea66mr18092335ad.29.1778580463897;
 Tue, 12 May 2026 03:07:43 -0700 (PDT)
Date: Tue, 12 May 2026 10:07:42 +0000
In-Reply-To: <20260509171013.GF9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260509171013.GF9285@ziepe.ca>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512100742.2522825-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, joonwonkang@google.com, 
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org, kevin.tian@intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, praan@google.com, robin.murphy@arm.com, 
	smostafa@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > We have multiple processes and a single device, those processes want to
> > do SVA with the same device, and only one process will do SVA with the
> > device at a time. Though, the problem occurs even when irrelevant
> > processes allocate the PASIDs from the global PASID space for their own
> > irrelevant purposes.
> 
> The only way to allocate a PASID from the global PASID space is to
> establish another SVA, so you have multiple devices doing SVA?

Another way is via iommu_alloc_global_pasid() [1] and it does not require
SVA. No, we currently do not have multiple devices doing SVA. But, the
problem is that it is out of our control when any device is to allocate a
PASID or do SVA for its own purpose.

[1] https://lore.kernel.org/all/20230802212427.1497170-3-jacob.jun.pan@linux.intel.com/

Thanks,
Joonwon Kang
