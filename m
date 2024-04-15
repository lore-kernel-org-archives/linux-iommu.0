Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACB1FDD
	for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198720; cv=none; b=eYu40gvi+r3dqapbaqe3+/cN9AWRpzqo5fDeewd5Vi8f7uYBpb/o3cwCUI0CNhjSeafrzxeFtxQhCsYjR0KLYoJTZLaDrgq8YgCyY3u5X7DK0Xatn1nUBsqWj2z9noSTR1Ov5v2Itp4iB3XGRy5W0XAYBA4hlihAKVIrpsdJsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198720; c=relaxed/simple;
	bh=zDDgIpy5N7xLBr7DtqrgxVpWSUxp5zbXxCvvF/CXoxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQVsVdnymTFp6MR1BnoUm0QIz8udwBD/OVKpw77bBHx2PAlgfJGhtlwq0quTVYgsiJhxGw94OgeOUKrIcLa/DyB7mZOcwGMZ7NDaaAVStevMQlaPorT16oMK09trKW43HZ4Jf/0CYb6WuvwkZiTBlY5Zbqm30Zus4bo9j619z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=odKszY8Q; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="odKszY8Q"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b4043b7b3so15747526d6.1
        for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713198718; x=1713803518; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6uDrxd1LuGun2rXxCqlhNV+bZCg6ihMUktEllK1boI=;
        b=odKszY8Q8kFJ9qtDNuwNtjDLViG1+tjgio7LbIirOtnLvjjmdH5zvwRHxuxiplPKx8
         VU35hbQVSpBQLVGBxrrmXF33RTJyjCtylqKiHrGVD7Xgyu1sV7li6NhOnJgU7qeGxfQx
         xhXBebzXNcHAivYnDZ5NG4urobbXOF2nR7y6Ihs4FQabIE+Yx/svPZ4rmUrIig0MXAjl
         /U5iomr+cQ95C6WZyjLnLiUS0dAwDNNemsVex/QrYLEzlH0TdmU3B5kVOXOk8rw83obU
         MetpEu9HjHiYQ2MOAC9zIxhYgfcBQXXPpzeUakSj3Gnnc2EQjmQc4yrFAzlXsWtOlWmb
         tBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198718; x=1713803518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6uDrxd1LuGun2rXxCqlhNV+bZCg6ihMUktEllK1boI=;
        b=HgMIlRv6h+kiZe8wISFVZMC/nZxDgglOtRGYdXup0zkkkLyKE4uhdRYFpJnjrhG/x+
         +m/nxM1hWECYOgoOrB6+BDlWEO7PG4ipjoPr27gZtLQySmbMSP9PAOFtrjK54ZB3mSD9
         lChhbGp9In+KFsQR7dgFSzRE5wIoGY3t+pNOmRAksXEIBrcy4Z8gFtCGZKlWqqa75t5M
         au6TOXcQx59Vhe6OWTxmZVnAiUkbn/OW7+vFyZqiBM56IMl72sbBDU1voUni0ssUFEn6
         h6mXsv1NL4OlcjjRJJI4nysOAZV1oI7/6f6eTVCOOzWhCyS9KFO0oZ1Q7OPM7rVUq8hd
         Im/w==
X-Gm-Message-State: AOJu0YzU+32cGi5cfPj1dkfSiQ3+6qy+3lXuR1IY9HWlDZH5Q/TR2BT4
	M35F1/+cihLO6/xAGHpr8w4OA7wwpT1aC1JHfKM7WuuBG7rZ3ivjpqKqYNHt+fE=
X-Google-Smtp-Source: AGHT+IHVq5hY+GNFQ2IMoJ/qm3S7ScfSdhVXy5WVNEqLMFjzgGG9jH1WHbxQxmN2mvwrSp80JLklmg==
X-Received: by 2002:a05:6214:d09:b0:69b:5475:b9df with SMTP id 9-20020a0562140d0900b0069b5475b9dfmr13767033qvh.47.1713198717859;
        Mon, 15 Apr 2024 09:31:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id v10-20020a0ce1ca000000b00699427d1611sm6392605qvl.40.2024.04.15.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:31:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwPFM-006ENU-Tv;
	Mon, 15 Apr 2024 13:31:56 -0300
Date: Mon, 15 Apr 2024 13:31:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/intel: Use try_cmpxchg64{,_local}() in iommu.c
Message-ID: <20240415163156.GQ223006@ziepe.ca>
References: <20240414162454.49584-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414162454.49584-1-ubizjak@gmail.com>

On Sun, Apr 14, 2024 at 06:23:11PM +0200, Uros Bizjak wrote:
> Replace this pattern in iommu.c:
> 
>     cmpxchg64{,_local}(*ptr, 0, new) != 0
> 
> ... with the simpler and faster:
> 
>     !try_cmpxchg64{,_local}(*ptr, &tmp, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag, so this change
> saves a compare after the CMPXCHG.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/intel/iommu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
