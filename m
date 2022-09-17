Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA238E
	for <iommu@lists.linux.dev>; Sat, 17 Sep 2022 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663433323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2q2fuQudziyZqHxR+TIXvjIEfB3VdruVjQwZRbadT+4=;
	b=Mm6qSlpBgQU/R9GLKL5PePpe+sqCxz634ZHjEvDusjZk8It5z0P6b43w/DXMSjKPT5OddS
	Xsemct/ZuDaJWA0Ux34hzbpVo9zQU2ak4QEkkSDq8xb2Uo2bxN6qSnCf30rKKDctGdPfVl
	4fQXx9A/iyPLw/pP6HfP1zqf8dtqIDY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-ImQORcvvPDuzgPV-QDQnhA-1; Sat, 17 Sep 2022 12:48:40 -0400
X-MC-Unique: ImQORcvvPDuzgPV-QDQnhA-1
Received: by mail-pf1-f199.google.com with SMTP id 2-20020a621502000000b00541081df73eso13884812pfv.9
        for <iommu@lists.linux.dev>; Sat, 17 Sep 2022 09:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2q2fuQudziyZqHxR+TIXvjIEfB3VdruVjQwZRbadT+4=;
        b=48RumOV2dEgf6WfVwuj8Nr056peP7MzbZIB2P3g/HtQG+s5AVTACyp6aFhNLyYIvK8
         P/kykdATV6qxg+jonSWDeHGMp1CId2lDl0ZOQpKTuGfw7w3WXY1d3r/zzkn1/6EFU/zz
         4kN2lkmHgKmWqkrGsFOgBSm4MA8GPW7AD4e1Z7wLQ8UrVb1dhp+DatSoAE3p3vkVRo/D
         eO+ILykqnP5kSCIRAx74wmgKKAD6wb7COYjU7UAgTSKFe/u7J1ZYRY+xTSxns6xhFQwp
         eFQ8lbQ6jrxONyOvPC8sjCWAV0LNUEZgnpxdFSBYfqydySD2wo8/q9iATYdkr7PTBREM
         NwuQ==
X-Gm-Message-State: ACrzQf3DEaeAf85EbxwcELu35obTDDIbjm3kkl5zCW8DDn9afEyU5+H4
	zONUkuji/nzdtbEtpgqVFavHCa+3h1MLfAXP3g9fp5HCRV/scVOvotNJGBA1yFb8q3idvEfoM/o
	ZPNgWuNqj9g8Tfh0=
X-Received: by 2002:a63:4965:0:b0:439:7a97:383c with SMTP id y37-20020a634965000000b004397a97383cmr9122294pgk.462.1663433319493;
        Sat, 17 Sep 2022 09:48:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+aqXqHbZPBWyO1JH0ykRRbMffeUC72jcvYm76UK7CXgGbRg5+MFm6kN2n3V2w0cC468ugFg==
X-Received: by 2002:a63:4965:0:b0:439:7a97:383c with SMTP id y37-20020a634965000000b004397a97383cmr9122282pgk.462.1663433319252;
        Sat, 17 Sep 2022 09:48:39 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y34-20020a631822000000b0041d6d37deb5sm15453492pgl.81.2022.09.17.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:48:38 -0700 (PDT)
Date: Sat, 17 Sep 2022 09:48:36 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, baolu.lu@intel.com,
	raghunathan.srinivasan@intel.com, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Check correct capability for sagaw
 determination
Message-ID: <20220917164836.qjmbf44au24bum4a@cantor>
References: <20220916071212.2223869-1-yi.l.liu@intel.com>
 <20220916071212.2223869-2-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220916071212.2223869-2-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2022 at 12:12:11AM -0700, Yi Liu wrote:
> Check 5-level paging capability for 57 bits address width instead of
> checking 1GB large page capability.
> 
> Fixes: 53fc7ad6edf2 ("iommu/vt-d: Correctly calculate sagaw value of IOMMU")
> Cc: stable@vger.kernel.org
> Reported-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/intel/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1f2cd43cf9bc..664499dddf0c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -399,7 +399,7 @@ static unsigned long __iommu_calculate_sagaw(struct intel_iommu *iommu)
>  {
>  	unsigned long fl_sagaw, sl_sagaw;
>  
> -	fl_sagaw = BIT(2) | (cap_fl1gp_support(iommu->cap) ? BIT(3) : 0);
> +	fl_sagaw = BIT(2) | (cap_5lp_support(iommu->cap) ? BIT(3) : 0);
>  	sl_sagaw = cap_sagaw(iommu->cap);
>  
>  	/* Second level only. */
> -- 
> 2.34.1
> 

