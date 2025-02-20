Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5E1581F9
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013431; cv=none; b=qBViYdnkuROFESsG6nl7rAwp8Pg2I3TQR8bZh+ciiZ/5GQHqlIaFoXScMgztvMcEHO9avbRRbTxZ1rVbOSqbFqQSgEP54MTTfSfF78mJqqhXu6SObYHkKIopA2jA7RAnx2yWjmry1ki1lRaby2s4fYlIX3jJMrT8YfjvEbiYEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013431; c=relaxed/simple;
	bh=OcRbs0Mux2+mvsQBoP/SK/C35tNLoYRRWX6CXINx8pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/sPkOPLB+pDOpb1gr/rheqAuus2pgkt9eiAvX2WcLnCo/I++lsu+T2x2LxUKICZ1WAJKe+vAv0FMlOtxJZGTq7fuVLVx87sFyyuPNKUqin+qhF6u0iiN24tScOGW/z1ztz7HmBuam9UIcqGoolp8iJM3+nhikaVu7A8b8VaC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hVf56ss2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hVf56ss2"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd1962a75bso2603166d6.3
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 17:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013429; x=1740618229; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8g0odvNWuxjBdKX0oyrseDQK/1N9fYZ+BlDhaPQ2UqA=;
        b=hVf56ss2kI0OxGHefUo85Vv0Y6YhfsJHMZtakTtIiQ3VWwL2ODs0J5j6D47bjqISrV
         ZLiKSg+XyEanGWz6mnQavl/A6/2XWePJp860E3Vx+6VSC5okfxAqz+ENLvL2HA/QnCKC
         rTmJjcoFiGZAudQhRq8PrGIdW0cPl2MawWjgi/IZ/YNSVCMzAnjdBN/Kwy961+vYISYX
         N76iHgAE8YxKy5zQ3iW5+5xQdrZZ2HEjnqa8eUCp8z9bVQWktgmds/v+OYk0DVPt/Ar/
         +f4DDgEEjUncgPtexeJzvJHsyzPKq7JeaPl2/zXnk3PcNBdwZlWTc8JzWSmPEVCKzjbW
         WKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013429; x=1740618229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g0odvNWuxjBdKX0oyrseDQK/1N9fYZ+BlDhaPQ2UqA=;
        b=UmkHnsSvp4PF5ro2Ts1XHGNAPkgtrE77USXOhz4JnU/zxZHeCvYHwRbQSQzn3B9uTa
         yxYEgKzQqiJs6he6Z1o03KBkHXVFsPOK1ReFcoDXl17a5WlblF10B+PO0Vs2Wdka7ZbH
         K2i6umT/BrklhD62HsZ7tyf9W2MlQkRW3S7vRdniDGUwUaSEfaRrrHKRPGlrcagVGm/L
         WjlZ4p8JAyCRewM7O5V7jOzNJ+Mkz+gStpsLnGgi03bDK6Gdrm2to3JBsCRN2p/Gj7nC
         vGb7ifJrw0DanFHdSFYNKiS7Zbriol8cpvP3gi7cYfR4EXTpemo+gzyNtqtIbvwFKGhs
         e9uA==
X-Forwarded-Encrypted: i=1; AJvYcCUmT2TEtw/UEqnQPDxEt5nmbcTyDG7m4jABhf1cW0DHJkr06vd/oa5PGYggUmykHHSPuyacTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqNZoKSXx1hGyPVsc5D6WokC6W31LkEylbhllJ3fBuvMBf2EH7
	MCal0KNqD1uxqVkUT3KaRXtVibGK4Zoex86lO+Krqn9+J5yOcHpFkqh/Uh2Eca8=
X-Gm-Gg: ASbGncunws0hjgDzgeH3wpMZ/1Q4DY5n9i8OKfzufo1MqTgLArNcUguSK1i/E5JdThr
	sV+sIayRarYlsdoHWLcaEFl/S5tBgDa4Kj7taZmyjytaOLIVeG2LM3La6/iBz0daMATGSG/Vyj9
	HLkI9eJR6LtdJ/qgI/8+pCFLDT789VfzkzS0XWkrecp1Nf5eSxvNfbwrjr7j4R7j4d0AOAYlrke
	E2IiSLFTVb8uzmTNBepndFAAJRAen9k4weNqV56UvmMf0FlXNztEtSZDwccs89ZFNt7ugtq4U32
	UZlcY7tEA3yvad7PR7WK/HGcvODChgRoO0THSczH/XLn3pZsP4NN547lPFP/dk26
X-Google-Smtp-Source: AGHT+IGQ51agWvygAJ6arkMUSoXHWOrR8ZGhqnn38CdfbtD8muJx789k755yxRMiQLjZ9SKySGEwnQ==
X-Received: by 2002:a05:6214:5190:b0:6e6:617c:abb6 with SMTP id 6a1803df08f44-6e66cc7febdmr308640816d6.6.1740013428938;
        Wed, 19 Feb 2025 17:03:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785bdbsm80468916d6.38.2025.02.19.17.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:03:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuyh-00000000D7v-41Ib;
	Wed, 19 Feb 2025 21:03:47 -0400
Date: Wed, 19 Feb 2025 21:03:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <20250220010347.GS3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-11-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-11-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:02PM +0800, Lu Baolu wrote:
> None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF anymore,
> remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/misc/uacce/uacce.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
