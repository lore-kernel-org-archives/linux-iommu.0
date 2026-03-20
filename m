Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD22367F23
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998920; cv=none; b=lPgFUr3oh8+GIUM9+01lto014nPa++yk7GoTrFQ0Tl5B8LLeYWmXy0R3YMbkwkzZI3UWqYxETL6K4QmQZKgOw6bDtM+8+NtbXrhd5q1oeH90x3dZH3tGWSktSXkHFF/1lgsGTydXx0wV70kl4H/tGOwI6dp4ZO9XvKKn0VU73Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998920; c=relaxed/simple;
	bh=DpDCTJXegbg2cBFxSiSI814EG9RKRIOvAWoZV93niFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBCpPOEV7fxLZZKJ8xAoSsqk7GqOTdeN8pAU/vK8awJWHyCHAFBhqg86RPSNH36OG/DQUR+Iqrl6dvLFxHw93DwkNXK1FL2KSkO6EiuiUed+GZq1WCS38tdLb07Hwwat21rOC0pSr5oD14LPWVKlhHzHabLXFCySPxBins1Bd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFWQE+M4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFWQE+M4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052562254so73065ad.0
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773998918; x=1774603718; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfFJWDO2bwhUd92Uo4pePPcCXizTvYm07yIGqhjNLlw=;
        b=kFWQE+M43Xo0EhUIVu9vC/wXAHvJYx+yKtTz6MHD8dIpjA7vdnyoxpgp6lFGka1FFS
         VzRWJ9o49fhbV1w//YyD/gC3qEKcQnpa23QJIIZc3gJpOLjr9aVbMCyprxAuK2G5Mv0b
         mzduxk8GwIb7C2Pqt2KPmVtJUVLeBTOk8bQ3Ts05WFjd8dYxx70ZjXyt/hImB2TjTvOY
         S703zntVjIad/sYBb97RE55kZkcVf2Ujv/8boQcZOviL85vnEPelVFsK5+mzJiJ7Vc1Q
         5yAwbe9n90tChQ+187+W1/zC4m7jFDP+sG2d+9/nI/mWvsttvTRKiffYzuHjIVmhar9D
         amKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998918; x=1774603718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfFJWDO2bwhUd92Uo4pePPcCXizTvYm07yIGqhjNLlw=;
        b=C2YO80xdKfH8qt7qww3iVspagKa3BuBnVokx5q/OFwEwraM4rh58ieOiF24MERI1UT
         6A3dnFuLKM4HZxRB6Iyl8CTH2kosj7bqQR4hXYIJVwauYeAOwl3H+o6H+RAu9MR9LXwM
         JsxNQG3B9prxIVJcbcCI/b33hP77wPx7+pqRb9vK78KCGHEuzMxw4FQLXXr/uJYG28OG
         v+12fHONOuJjKowb35B7y5I+SINfzz9s35Byy2HD9VykmOTkKkaZh2MfspuSJcjejuEI
         96jl6fMHDyu+tZ5xPoN/DMoLlRnyqNrsyLwf8KSx5PRb4pGnmrVHgCbHk1GpnkD5J+8B
         jvaw==
X-Forwarded-Encrypted: i=1; AJvYcCVpJROhiErJMhJMY0PKYho3RvR3a5oip+VvswziaINeZDR/BvZJUMm+dRTiT4KHDUyPFNoAGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxenEw2nTblv4RYFO0Q5TOhI6sWBQxIZDG4SSJatxTPwTlC/hh9
	H+gTovoNUrKAGXP00P6tLaQIJEQ3KlDGuy7jC3aiEDqROK/TeEtaul0LZZuzyQbx2w==
X-Gm-Gg: ATEYQzzP3nMe445+9arqI3AVZKEylPOksO75hv9RQ24cTSs8Z06FVUFuECOCQ2TQV5n
	6eWdFFdZ7QAzKyx8tbVTaxGsKj+GOuXmr3jcv71J77NlH9xAzmzHiCl0hgx/Vp+r7DvfJ21rTmc
	uEZH8vts3/WzhRIy4uGF+pQhmmEizEDCzAV82GkOt2FmK3kzU6IhNDa1Gu4O+g5vl5TmIwisT/F
	FxtMLw8t8QQPlbqf4mybH6KbVdv5H8dI6bRGuikSR6mImFxPX9HQc3d5zPmCWkOB3P+U1WepHal
	624sXoahdvk+o4twpqTqHYPrYFbH7zxZ9COkVR/QxI3zBXoOlezxCr0yaQrx8xRABw9y6FxQsOX
	4p5jnpCmvmxk7U7AXKI1lk/aTThCrFuCkQ51X9kMmcq1gjCvYoTi2p36KUMz17mNfI5fDhERvJZ
	kydL3LxuV+MzUhMREqk7RkS2mc/QNO7hj0/aPoBGatL3eQAY9lVGpzdNtIEA==
X-Received: by 2002:a17:902:e750:b0:2ae:44db:570c with SMTP id d9443c01a7336-2b0828a93e1mr2454385ad.12.1773998917324;
        Fri, 20 Mar 2026 02:28:37 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c0f1sm1652552b3a.38.2026.03.20.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:28:36 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:28:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab0TPFo2esHZ6RIb@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317202925.GA2582517.vipinsh@google.com>

On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> > +
> > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> > +{
> > +	struct ioptdesc *iopt;
> > +
> > +	if (!count)
> > +		return;
> > +
> > +	/* If less than zero then unpreserve all pages. */
> > +	if (count < 0)
> > +		count = 0;
> > +
> > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> > +		if (count > 0 && --count ==  0)
> > +			break;
> > +	}
> > +}
> 
> I see you are trying to have common function for error handling in
> iommu_preserve_pages() down and unpreserving in the next patch with
> overloaded meaning of count. 
> 
>  < 0 means unpreserve all of the pages
>  = 0 means do nothing
>  > 0 unpreserve these many pages.
> 
> It seems non-intuitive to me and code also end up having multiple ifs. I
> will recommend to just have this function go through all of the pages
> without passing count argument. In iommu_preserve_pages() function down,
> handle the error case with a "goto err" statement. If this is the way
> things happen in iommu codebase feel free to ignore this suggestion.
> 

+1 to this. The current version of overloaded count is counter-intuitive
as it expects a back-handed API contract. Since we're using lists here,
I'd recommend using the list_for_each_entry_continue_reverse() helper:

+void iommu_unpreserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
+int iommu_preserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+	int ret;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
+		if (ret)
+			goto err_rollback;
+	}
+	return 0;
+
+err_rollback:
+	/* Rollback only the successfully preserved pages */
+	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+	return ret;
+}

[ ---- snip >8---- ]

Thanks,
Praan
