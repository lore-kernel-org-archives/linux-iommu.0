Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D324E601
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M3jqpkKe"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-77f2f492a43so263750585a.2
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 09:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702316308; x=1702921108; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx0kCWw6AOe/lnc+LPzU2mQddJvJBaAwvlRTrYIYzPQ=;
        b=M3jqpkKeiWmi4S/4oPMMkVosqVTl8XJTnO+RX/JRz9ymvQ8cNB8pk3ZnYfM6ZDXGHW
         Ks9xvFGMKGd+AvHX5rPhDeB3Hqm1Svfuo5R0tf/5Vyty4Zx00hlTOjs+nBhDmd81ak0o
         WrsU1zl3sOTmE/c6CfXrlKzrtf3Q+BHgbP2slmQelTIlKfWhjlS9RqN4hblWvebONxjG
         IqImRleL31aSre68OXWoVLVP3owkUd5FpPWRRpwrL10wGjfq557kz77CxE/uDX1LzbOV
         fNmnZ84RdZHFcsQxf8dfKsuW8k+suOkn+qJvTGrn1kbj3ZA2whh3CNzrJdPzIzTGBD7P
         LfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316308; x=1702921108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx0kCWw6AOe/lnc+LPzU2mQddJvJBaAwvlRTrYIYzPQ=;
        b=NmI+JzCEl0Fwev6WMYJxMcxUU5zvYUwGpfL7VjRuN6Do1PXXkJY38G9XnZHTS0WBMV
         EtjkdCAbdn2raMuT21SpIDue3yH6+3x/v977DT8fYf/hs1CeouG3BRNPy2EgUunx+7Jg
         +vWRAgwPcsM3hKS9p7kNuER1CC/Xqur3H+K7YIzvlPLtmaKXPcoIWzP87aLzme2R/URf
         1ZMcL4RWGHh+8a9ORTJCRG/dSlj2Pz4MH4cBuo/D4JwtDmo7bGBEH7fDsv1IPyUKW0OS
         xlR4DKlSjkw2LqiRhfaXezBDMQ1vnuf3RVRUUv2UVtcVSNd1lM6XyMqGcvuRSdltPkIP
         VzqA==
X-Gm-Message-State: AOJu0Yyri7VurLVD9f4ZMXSrlGFUFEOlQw40pcZlkXiM3vQe9y/+nRle
	BPhUXV6hMixtiEPSZ/H0hayV/Q==
X-Google-Smtp-Source: AGHT+IFfc5Hv1E6FHOf1r8yAaQaGx0V3DuKRi/AlGBDjSOBNiyD2/IhGz/2tIGlgla1T0f8Y1D++jA==
X-Received: by 2002:a05:620a:95b:b0:77f:37b2:21e4 with SMTP id w27-20020a05620a095b00b0077f37b221e4mr5503877qkw.38.1702316308081;
        Mon, 11 Dec 2023 09:38:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a04cb00b0077f529e7d23sm1624685qks.29.2023.12.11.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:38:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rCkEc-00CdZD-R2;
	Mon, 11 Dec 2023 13:38:26 -0400
Date: Mon, 11 Dec 2023 13:38:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Message-ID: <20231211173826.GE1489931@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205012203.244584-2-baolu.lu@linux.intel.com>

On Tue, Dec 05, 2023 at 09:21:58AM +0800, Lu Baolu wrote:
> +/*
> + * Get the PASID directory size for scalable mode context entry.
> + * Value of X in the PDTS field of a scalable mode context entry
> + * indicates PASID directory with 2^(X + 7) entries.
> + */
> +static unsigned long context_get_sm_pds(struct pasid_table *table)
> +{
> +	unsigned long pds, max_pde;
> +
> +	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
> +	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
> +	if (pds < 7)
> +		return 0;
> +
> +	return pds - 7;

This seems like a convoluted way to write 
  max(ilog2(table-max_pasid) - 7,0)

?

Jason
