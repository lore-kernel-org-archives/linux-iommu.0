Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D63156C5F
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812145; cv=none; b=ZVSFzoTlYwdhuUMwCt+HaaLl4rfh6yi8/d054AaBihiI+aJOmVKzkP1VczHJaFiD0WxfDFKs3P1flFeLPkbeIQR98U1+c9ms7bY2t5i4nARV3ZZJfi+hPXNEzcyM/jzyR8+/tMIVDc7LvYSCfBELKU0v4yDNd7n4inBVLXwVT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812145; c=relaxed/simple;
	bh=gqmsV2wQyLRTa+dMlIDvFO+HmlyFWBidO1o5Ifz7Rpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prJxJLshQLXEJnqDOEqBB595oHe40q4DwsiUve9onrGB7UtwdgO1qaqkS+wCpDD9EuVI75+c1nBbGHTxNBPbZq4AOADSPYul4Gk0GtYmX+nDPROiJz1eZdMZPo0LBZXLDbw67PnO5r7kLH1Scsvh4kOTgACJ+4xR4aqnpm/8e+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Wo0qG7dG; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wo0qG7dG"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8d0a1e500so4961220a34.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718812143; x=1719416943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaUP1kZaDzbLlLlrnXpwVvSSBYt89/ufOLldJsnhc4U=;
        b=Wo0qG7dG6YoPH+EJEvZbhGdXX07d7IUDr9cLRGrOXw9h72GuUoWu4HOfzHBHryov7P
         b4ozPs76jY7JNfaFJvZsBvohALOoy2/g9NGbbFePAke1WqQtoXdCxIkueHGGGgrcyGd2
         QZrwTDi/6OY9yTMpFKtWvjF9/ILKaS0wRyQCe4AZTDyM9Gx7P/BlOe/xJY58zBhld7MJ
         nwvU+K+DcmkQMPMBTVpmkJvDIDQr6frAT5saljxgmUFzComE/rQCqQyypcuxXrh8nUZ/
         cN18QeSysHZs4djaUNHfhkzdvjM7kwrURXuqmeBq1iOLy0xHTRrujBUR8cjjQjkYm9YJ
         twqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812143; x=1719416943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaUP1kZaDzbLlLlrnXpwVvSSBYt89/ufOLldJsnhc4U=;
        b=oKbp5OoKgjLq5u2J61XCgIIcbGbmiaNc9kHgjjw5wZQySwGDXBvHdEPnoYALK6J1oQ
         MEA7tVPjw9wEimkRXxj0xMr5Huo3AgpfsExG3e8VH32h7idPLpMO5XVJ8dApxG/yNbN4
         i9gy0+/XNWbEjWemnENwu/bS1556gfYdBiClsQ3j8M3RzGxhfNsj+DqoBCJpgUyv1sqX
         HAe39UziscSFcZYsLuRZ1AHNRzC/YydoD1ayn3pO+G6uLsABiB4u2ZqaOrdU3KLsVrey
         sFcv5CR2dRsT+GLfrzaj7RM4Wrk20zvrzk/nIydb1tlZvZ7xMrALPKpvpMurNXyg11Iw
         3TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5n/JlUrPbUTbBZzOFh1+YlRwwAxtGdU06pbB/Xo4oIwaLknTw/S46sOJhlSTxEV5Cfm0ZbNeQaMHXGnbpHccQjgiNTwU=
X-Gm-Message-State: AOJu0YwR6/+hwyd0iuUIHuuvUmhL58BJBKFbC7ic540GONarhcdkndmj
	O79aYEp5t7dtLQup1KV1YpcNZMBokDSlOEDgyC8RKVmXlyfehRGo5YBSiCnhymReaKVegur4UNr
	q
X-Google-Smtp-Source: AGHT+IGiKyWuqgAIxgrEV+lA+jwRvALxPu8Ex4GA8h6qTDbq5CrrDib3WqnWy/fQMHVAIh7lZU0CKQ==
X-Received: by 2002:a9d:7e9a:0:b0:6f9:62e9:9f93 with SMTP id 46e09a7af769-70075a747edmr2788040a34.35.1718812143157;
        Wed, 19 Jun 2024 08:49:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b4fcf9ab77sm15777616d6.7.2024.06.19.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:49:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJxYT-004xTQ-Ic;
	Wed, 19 Jun 2024 12:49:01 -0300
Date: Wed, 19 Jun 2024 12:49:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 06/10] iommu/riscv: support nested iommu for
 getting iommu hardware information
Message-ID: <20240619154901.GN1091770@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-7-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-7-zong.li@sifive.com>

On Fri, Jun 14, 2024 at 10:21:52PM +0800, Zong Li wrote:
> This patch implements .hw_info operation and the related data
> structures for passing the IOMMU hardware capabilities for iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 20 ++++++++++++++++++++
>  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
>  2 files changed, 38 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  /**
>   * enum iommu_hw_info_type - IOMMU Hardware Info Types
>   * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
>   *                           info
>   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> + * @IOMMU_HW_INFO_TYPE_RISCV_IOMMU: RISC-V iommu info type
>   */

Is there a more formal name than "RISCV IOMMU" here? It seems like you
will probably have a RISCV_IOMMU_V2 someday, is that naming OK?

Jason
