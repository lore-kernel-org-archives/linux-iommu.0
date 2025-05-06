Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E197C8FE
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545663; cv=none; b=fFbLfhpY2+60wy6BV/vBivNf/XstT4zNZ+6lQeiHTtwFcOCjI9E2xDzjJ3pkPqHKkCfhB8mJ+Gyh74diKE6npzt1yuNq4eq7Gr2oi1eRH64VZSOw/a50jMlCdQnSD5ORfetlhdTM03FFLupfnSn95V16/HJMLSldjFl9H92BFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545663; c=relaxed/simple;
	bh=Ov/02G0Dcbs71zqBUcZd01NdKb7GrwiBG53tzfrEiqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlxdwXNqvXWJzejIAb4s665ghYtjzdAbDin6tcy7bYFhJBKmSEn9p6abPeZonEtHeNFNBRh4aUa7133T4Vk0HvlgKk+zxX+HIcQHTc4SbehlHJffHVuvYjUCf0j/N5ib6DwLf+M0Z/RanigfwJsY0HsLUUYpiCkcfPit0IbfIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MKSpsvhu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MKSpsvhu"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47686580529so67794921cf.2
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746545660; x=1747150460; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEL0BdJeiWhFSL0UHqew6wK9zUeiS1/Nj6MKOwcN1sk=;
        b=MKSpsvhunLdIc23WIfdZ6VKKF/neUO+pGo46F6Id+Yl3pAb/Hy5bonx/Aa8aHUSQrp
         AtO1HwnKcIofnpD9Dreg9HPb4ZscR5R6pgzBHuVklRny7nramAc4hRGKLK1rQMFSxxxv
         5EbwJNa+PN6Yu27WrUlERQ7wLnRkMveQSTin5BXredaap1Kpf01Lk/pQ2GtlkiZ611Km
         Rq4UkBURxGN+QY4jfuSVnNAXAIfpKq62ANIo5d8qgqs3i3LnAbV/NguWyxao9T5kw2iB
         okynBSFf54CEvInCA5dCcghd2g7M9NCFCSK//eemriTNrrqptDe4DjSW/Ih4LXUN85Kx
         vvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746545660; x=1747150460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEL0BdJeiWhFSL0UHqew6wK9zUeiS1/Nj6MKOwcN1sk=;
        b=hbzqAfg9BmRSispq8u9b9wDuKCJOdiqJfTUuyI8qiW2dzBj8nDmsQ9hwu0jONt2+wA
         1OG9HGcrsueqcRD2eL2aXmMrKDrzhzSwPgXxF24Wo2QKqtD8R3BccX0z+NaAeFEe/q3N
         pSOQIH8cjnhF2tIOR3zISlLzkk2isOcUxe7rq7PTB8+WdOnJaPJInZFgbMtE0I0Qgnfb
         AA+YU+GrT1raCi0lFNU4KRGZjQqpsFbWHHr8Ta+RasPriHW2y2lEudX5IzO5b3A/5bvL
         dEDPRrtQADY0mnRjW0zLQO9+s3xQMFWcOozhsmpdkzyXFNW6Efv65ef/USDwAm0Bu/iu
         CNZA==
X-Forwarded-Encrypted: i=1; AJvYcCWt+rSDWi+TjDwHgYCSPudTaJgoCNHbukj4QdGgwBt050DjBzVaIyEKqMlyq3f1PqqoZnmtYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuVU/9eboP83q2J+rrjReuiPEqkqBLA227d0BVASUt3JB/+3g9
	sRozkfqAb0TmnGYfeK7cBlCJmmAutrO4JyrsKSEqWAnXS/K6slT/mJUr1I+iFZx5pZ8o0t8zSHo
	d
X-Gm-Gg: ASbGnct9RADEwf8zBtK33tXo7ca6T9+t2deu40BFVsx18Y1N34WOadjGtOfru7oRRGu
	mnIUxzGjnMyZE57pbF+Gm6xzRVCglb7BQMLMrXOeUigIRniMLuonJyTYqxvIm2LqqmNc26uDNMX
	8qKvo45ymk+YDEK72AfWNEbzCJIqOt5nAVoHY6hGTnwoDKK2WSxXaYbpCvMPhU8W3OZ3o/pHwCz
	GLIDky6rpl+W3DsQz6ENMK7cS7ctcWtPmlwhWaM6x4mu92G9hcCpSgGzijSYnQj/D5GbRizL92U
	dpnE+uZAnIa+61I//7AUpYCGKwnzaHSV2U/iaATu/8C9oQxyR/zrBN0ZFajib3CTn4n5pAq4lxa
	hoJXqYtwIWzK69thJUc4=
X-Google-Smtp-Source: AGHT+IGjVla9v9iPysAsiyzPvNdcdtY/Ygl5ECmnMcsCIIpAcHMP5wxwPNZpIf0QEMUcDCXVQaRW9A==
X-Received: by 2002:a05:6214:5086:b0:6e8:9086:261 with SMTP id 6a1803df08f44-6f528c3ac16mr186250976d6.3.1746545660278;
        Tue, 06 May 2025 08:34:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f4515absm71401096d6.79.2025.05.06.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:34:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCKJH-000000008YQ-1aOe;
	Tue, 06 May 2025 12:34:19 -0300
Date: Tue, 6 May 2025 12:34:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/fsl_pamu: remove trailing space after \n
Message-ID: <20250506153419.GL2260621@ziepe.ca>
References: <20250430151853.923614-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430151853.923614-1-colin.i.king@gmail.com>

On Wed, Apr 30, 2025 at 04:18:53PM +0100, Colin Ian King wrote:
> There is an extraenous space after \n in a pr_debug message. Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
