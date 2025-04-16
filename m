Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9957248176
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804976; cv=none; b=eZHP6XQ6Qt30kJ8/6mYW4HMotcpHqQq3qvV2ltVDabFEIF/zeDLI/lU5rRfFrm38MdfzdwLtbEvMx7fCyqxw74K11OCch4DBZU//wExaZNvrBwPPS1KkyN/zBpZkhAKYwc1PVXz62TaAjW4ddUM9K3kx2YK6huZ4FMm9KHlrcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804976; c=relaxed/simple;
	bh=euHf0BewsytW2FMBgqirgPdz8pkhRvtyI8P3kHLLGck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJNQ7MSDzY/KGgw6ieKhva/sdUkDGYZbpFx4AnA1zi+jx6dtxfTXT0mQlUxjPeguXet6WH1Y1AMTii0VGA0e4zyugCLktNkumZ/BrFDXa78fciVDx9ITBmX+67kQiUIpZv7IK/yoZkPdXMs20DjiQ65oqT+USi7kn4Qhx86x6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F9DOu0Iz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F9DOu0Iz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5e39d1e0eso645798985a.1
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 05:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744804972; x=1745409772; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euHf0BewsytW2FMBgqirgPdz8pkhRvtyI8P3kHLLGck=;
        b=F9DOu0Izi3PnUGtPtpO6JcUSLZcjax7HSd/LfbCkY0ooXNdmdF9zbj6GlOgY+1Z2Q4
         gwwQ3vCBi1zS59t9qCXO3Vv67D5/1fi+oK0QmLTgi7PrnA9KXBzqtQdgPH++mjp8rUcq
         2O4s2lIVQPcL9t2uKC65xfByRZ3MMTyExeJCZq7h5d8M0TTEszZXdAgh1vajDWHbd3zD
         qbEPPblE5BL3hp8BadFODpplor0fMbSE8MP1rugjzEKKVBEc9ZLATQQkqc9lqa+HjfnW
         gDfPBr0Zf5+6nNnIvV0HVIAjLbfe3X2m6l3FiRYRLd8AI/VVbClszQ3XnjyG22+4oH+L
         kNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744804972; x=1745409772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euHf0BewsytW2FMBgqirgPdz8pkhRvtyI8P3kHLLGck=;
        b=mHb1pDXBIaCwz2lbtviPFR4LhTYdIYi/Y6KdWBwNOjTfQBxtqwjENjRQmgRrDvzgkE
         XSIbnQszD17BnYuwwVMRH0KU/JZatk+kPi01fHFO0JanWy2RMYY1A4B2U+2Aa1BK7b29
         UaiGWwHBGA5nhzE5meywh7wKqZGkOB+wmNQttLemxIdkn3ggLwbzS+kK3JzcDuNgWbPa
         xbGh8VVLgkPGz0++0P0ve9C22nRXl9GDtaNrYX6arrl+WuA6nSSwfP0O4uIgxQ2J1fcI
         KTgRiJk7Afe+AL+bH3mk7gcSarxDv9ziA/s7rLqko/TJShCUzapV9e84xo/2vZVGP9O8
         Tzrw==
X-Forwarded-Encrypted: i=1; AJvYcCUrWDzw/lNKJ43/buodBtnLVjAr0fcMnp1ZxePxHn3/deNgjzKHHJx9mnhm9scCiCBrM3tUPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF+xVVTm1+R77QEDwBApFJGwI3bZegg77kXA0egw3X70ZZnA3J
	yo4QnIOWJCYLM9jMLqB+oRJv1ytPySIos3tlAgojoLjOx+qGE4Unj8ToOcoiPT4=
X-Gm-Gg: ASbGncvbMYH4mcrVxKgFHRemMUMvOlLXXZmr69bvZhRXcr76docfB29GMrPagkguMiU
	+K3qGXY+HDCmVk224mTzNU+/89ydXyC1tRJ83sUGqHIabK9yrSA+sG9B80aVcGP6Nv6+EZxXP0b
	iZBpiJ67JY7+5R93hjeoAShmI6KWrHGM7oMjlymsOgy3xku9r3T1UlQfHO/cd0+FeefqiYiVOXn
	ZeKHejg3bUkTB+qGKqBzsFmWvl9nF+3duoOkZ8StnnGI8w1ORg9XGleBomF1lfRzTnkWPcDIAEZ
	UPgKs524Yd1jOIUNK4M9dsAYUhQDwhTvsCnCRfX57Kbcw5STjyyBgoPiLBeoqvHYT0Zh9Gx7iqF
	Rnplp3c/UpNbJQv6Ja9g=
X-Google-Smtp-Source: AGHT+IH56lyQte2brkAaaqDxwcDhg4Ea+sAPcLLJ5SSNKQj6WK34xtAkzSsbn351BszEPfh0Z9pLsQ==
X-Received: by 2002:a05:620a:29c6:b0:7c5:e40b:caaf with SMTP id af79cd13be357-7c919002b2amr215239985a.31.1744804972471;
        Wed, 16 Apr 2025 05:02:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0edc8sm1052651985a.110.2025.04.16.05.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 05:02:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u51Tf-00000004JDK-0sd4;
	Wed, 16 Apr 2025 09:02:51 -0300
Date: Wed, 16 Apr 2025 09:02:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <20250416120251.GC493866@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
 <Z_-FdLizyrz2_ovi@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_-FdLizyrz2_ovi@google.com>

On Wed, Apr 16, 2025 at 10:24:52AM +0000, Pranjal Shrivastava wrote:

> Also, this would mean that we'll have to take care if the Guest Kernel
> ends up touching the mmio region while the SMMU is suspended?

I think this is approaching it backwards.

If power management is supported then the power should be on unless
the VM has activated its own virtual power management. VM virtual
power mangement would flush the cmdq from the VM side then signal the
host that it is OK to power down the SMMU, which the host may or may
not do

It doesn't make alot of sense to power down the SMMU while a VM is
running...

Jason
