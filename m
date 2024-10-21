Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820A1F429B
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514662; cv=none; b=fgPawTxb3VDTJknhOiHPzECtmBIBN9vSAVH9xKWtj39vwp5maXWW5Q3QjxI/Asf3I7KQcrQbsBVrQOCqt+Tb7DevsmAuQFDlizepY/t4i6q2YV1wLwE7yUN2waIT7vrL2jbJsld0aIkL7TAafveBhnSVDEwvLSvp4AYUiSP6txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514662; c=relaxed/simple;
	bh=+BOH6oOyd5oDIqKQuziHgWQPT0ab4bBLELQRKxd1Eg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxzmWFuF6Bp27rtwWKsgJ5oy2NMUDhdhpnIDxh/VzPHyW9yyA3gs/Qfie/5uiHcKhIKwfpuk26J1urLsvwY3J0GrLvNVI+9krGIIBXLiJd4g237doH7rFellnNNgYf3GTV6fCexgLPBET/5A0iLOmEDdpdKlxdUMCluY0mN017I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y31KI1KL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y31KI1KL"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b15495f04dso301786685a.0
        for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729514658; x=1730119458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9W7G1s/17nlBu2nyfJGMmvDTBLsYC+PG5KaQtDhVjQ=;
        b=Y31KI1KLXpnmHCDLKrbZxQlcvtotEDF6uFWOau7ZA+ZXJGhMPPSrTgCW+pPT4exBGc
         XG/WLdm0BSNGRXIenx424UWMkMSTiI01v0P502wnofoPlg9Fc0U4OiLcRVCPu9PZADol
         rE87XZ04GJHKxUGL9GAWKhIhvyG4s1cKsyIU1oC1H6/FFUIF37T9uTMESJDiRIHEPnmL
         KBmtrV/1WTW0MXWvzi3tsACfItwHpcfgYja+6qo277sj/vZwhMyHf1gaundY5pUUPWyB
         y9LbHF3hkfhTUAImnycqlcubbPtQVdsrlR8muFCjra/sXDfmpNXPGVmyfDBaRX4mRi5S
         McHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514658; x=1730119458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9W7G1s/17nlBu2nyfJGMmvDTBLsYC+PG5KaQtDhVjQ=;
        b=rOGKWcix7vJmqI5RtfeGxgEwr5RP3UM3P2qYiE4J0HcUJzntQSlWeti13Tjry6Kp6y
         qgWxkpgOzMQrkKNuv2/W2afSfk/CwCFRxNW3rFcDiWJd1b1fuk1GI5V9ltPHrJTn1ZLT
         OkG8WVrVY4iOt/413ZYFxYAwH/ZyFUPq1vr5S9zaFrvUG8cgZ3YYsW431HdReW+6d2qf
         3UGZAdZtui4qIzwUfip1pMSKbpQTVGNjwJLC4CWa58eMxZtBUhVevFhkVQbD5y5xK3mm
         dvt4lCp8jlFl92xlsoQh1sdxwNhjpzus6/QTuSi1p0XtvQrdiJhkWefSXwsB4pVz94q2
         S5OQ==
X-Gm-Message-State: AOJu0Yx6FgXPTTGCwj4+3qQ7etLDzoEhn2Cr7Mdot+K66bbKAqFWh+Oo
	I+MHvPpjJ204W7brXLvY3VrEm0GB8aBF1UjKT4/8NITyJDDmyB6RHvI1N0os5rM=
X-Google-Smtp-Source: AGHT+IE4qA8alqP1kwri4/koenk+ctTsb20wMxCEVTPZXERpjMTtxelCiobHbzlHXSN1WMyhJ8q0ZA==
X-Received: by 2002:a05:620a:4510:b0:7b1:4fdb:6eaf with SMTP id af79cd13be357-7b157c11ee2mr1669848585a.65.1729514658588;
        Mon, 21 Oct 2024 05:44:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a0347asm161962385a.59.2024.10.21.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:44:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t2rlh-008H8r-LC;
	Mon, 21 Oct 2024 09:44:17 -0300
Date: Mon, 21 Oct 2024 09:44:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241021124417.GB3576661@ziepe.ca>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
 <20241021085125.192333-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021085125.192333-2-baolu.lu@linux.intel.com>

On Mon, Oct 21, 2024 at 04:51:18PM +0800, Lu Baolu wrote:
> Add the domain_alloc_paging callback for domain allocation using the
> iommu_paging_domain_alloc() interface.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
