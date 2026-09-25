Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8AEEC0
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295443; cv=none; b=fTveGNSzfO6sCqTOqrxaeStN5R7HLtgvoOwniIS7nRTWDjQg4HQSzePYKeBqZGoyT7Fl3YsVBoq4RPHbouWb0PWE2gyRvkl/eG2cyVuoqCqtN8HWnaZujHV+JFuLwAypG34RN7cur6Wcdjc4ZcBF3cWJPWVYnX7WpSFVkZ83oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295443; c=relaxed/simple;
	bh=c2TrKuIQdHJi5ac6cYTcR3zsFbJGNSqnfxt3US4+dTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiC72P4oRbm3FUF5cx1sdkh+C8fqSaO4ZlwrLamoQcIKZOnq7DJtCZwKjIW0e9Sq0MiPjTXfxoglFqJv9I8ztRQ2JMzmEu+nDQVbP/N8VT/Mje3PZYQ9fmq6yeMewWdEO3lFVyXycU/2xBPSzQIa92BRQmRctahTiuvpGJcac7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BD+uPELz; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BD+uPELz"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c3735125bso152349eec.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790295440; x=1790900240; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bBP41wsUfxAtNYlcp3VvzpWs4GlF6loBq2EU7rP0+w0=;
        b=BD+uPELzd1tZ8Zg68DiidvZOhMsfqB28i9XQ5GhivaxGtAKkwOyi+9gDSDHcakcCzq
         ug9+Iuk12Ifq/0dNExEGzMyCO6P+vLpmIN+yyqaZ6t+ARXixKFZsRzvdn/7gTTUil0KL
         XI9Ym3h6GUE+CTMQPNfXumy9+jICLqcBBwN++NeoxYisV+fpDflQzFgU6xFBzDLq7Ykz
         FxMoS2ECJlYJOUF/Bg8WNpz5zRcb1jEJuibvKGhJun0AE9KouviTa6LLplx0xg50AOUx
         sECy8UNVLd6mblSsy1GCueqeipcFYricj0X1g20Z1RYGvyj9d3bcj77pyMn8bHdrTgtx
         04aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790295440; x=1790900240;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBP41wsUfxAtNYlcp3VvzpWs4GlF6loBq2EU7rP0+w0=;
        b=sE0E2Pu57+0QYMXtzpo3NbZPI6FQ5cIBmZehnu2DFawHKH74pEOl8IbXeWC1FDyily
         Siorj0KciU1Z8am+1WFA83XQ1R6IDbHLiYrko3hZAHSE6ZTRFJ412DFP3vNrfybf7GAI
         gcT32NKknaCYHw+cYTIUp0Juy16f8loVIGoelceNmKDMFUMyuOcyO7BqzRv2xAVHjCGU
         0v0DBTmsHad68woMNf8Pa+6jVwIvWfKN/mX03XGalUuBLPf4/sJD4wGdpEeIi1HaVqpG
         j5ZX45nhQhYIPD2l7ViazpbBoDpLt398g2+BQ9ifV+zXrzm5r1br57+Y8eqtQwNwIQ2r
         u+8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxq4ZTY3qleJA5Lmwy1rTaGBGaQU9wRkifgCvDt7EUI5OgX/ztNvFm9PNsx4fZso5cmJDrh5A==@lists.linux.dev
X-Gm-Message-State: AFuF++l4A/Sg9M8YD9Iko55xZtLjwqo/EXPt6f32TQ/HZ//ljVeXI3Gb
	B//iN7yXJ0Wzn4trrvUTiIRJBciqRv/xjojGEsCTecL0UWnSvTv8eA2TGuc4RhmXALw=
X-Gm-Gg: AYBFou0gWtqSBxULWpbhkLf9JqPSQLdrOreatEz83WE7flnUInPkBA2LaqMU+FczQ17
	AtBLJVLmyMYf47ENB63T1/gNT5M9/wxdHjHMj3Yq6Nk+s45YPKOnlYh0hEs05b+oYwj2lrNzaWH
	dFrqQLfIFxhWAe7/UpxQbugZ6Oy6Yc8TiXPVj02McrTb8OxSGDOoJIMuPs186frcKhxAd1skuCU
	Jg1gnQOa2WM24BSSLTbF7mzE234x4qC+uvvCLh8uBwiANdZIymK9hJr24eblWvYgT9+n3WNYUJP
	HuCXe50e8YLcY5TL6BLxFPgsqw58mX2QtDubHYAV757e/Ti9ajGWXWFdHO7cU2RqHBRdno/Shvo
	F0y22xlyoXULCNNWN7XJl1dRfqeGMnnpQeSEi8CGRm8H6zlB6Zt88FCQT97ixhqZB5rDIQOMoH9
	+ur628vZnXDRvxd/nRhpylKzN6NJkSs/fGDPyhXUT+HG5R
X-Received: by 2002:a05:7300:23cd:b0:33b:ebaa:e03b with SMTP id 5a478bee46e88-340006437eemr4655606eec.22.1790295440228;
        Thu, 24 Sep 2026 17:17:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414456b496sm1830997eec.11.2026.09.24.17.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:17:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9tcs-00000000j4H-2AoY;
	Thu, 24 Sep 2026 21:17:18 -0300
Date: Thu, 24 Sep 2026 21:17:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>, amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260925001718.GC163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
 <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6ba6f3-4d8b-4d67-8e5a-ffbe22126464@kernel.org>

On Thu, Sep 24, 2026 at 07:03:56PM -0500, Mario Limonciello wrote:
> 
> 
> On 9/24/26 5:50 PM, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> > > +EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
> > 
> > Last time we hardwired the GPU and IOMMU drivers together it was a
> > huge mess to undo.
> > 
> > Why does the GPU driver have to request this? Why can't the iommu
> > driver know that this is a special device that can use this magic fast
> > path and then auto set it when identity is asked for?
> 
> The reason was to allow an "opt-out" path on the GPU driver.

This seems like a very poor reason for doing this given the past
negative experiances.

Jason
