Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5E386443
	for <iommu@lists.linux.dev>; Mon,  3 Aug 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764246; cv=none; b=DSB6BsOjMmQQK9JGP8k+abKODeDtilxGFJdYThaWcXiIxV+ifRcaVoqad03CCYDxeIvx6nzKkxfvZnSMdJStsM7PIe0hBh0xErpIXqAlIk1jBLfvjnShQT/7ifbaTkubHATkZJOBuDg5FdNMuvrDjYlYwxJUhOwydwtoHi+N/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764246; c=relaxed/simple;
	bh=Q3lC7ph52pwscqvZuwjZ4AiZmrJuilR445nvJqXc3vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL71bhSN6vxmum/s2/OgGykWxLMw0Kl6xhnSMyY0qwh7uN5+JLEzSJrHNHsVP96SBbU8xYojkGqhZQKC5rbGb6YfhqQHo3Vfnt5xSP98yLyqf1jCv+B/sPhHPtgY6dbm7M/UzxQChi/MxbsO8KyqjFHew2zku1iyrw9xzgqnXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PffB53rb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PffB53rb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacef7d299so132185ad.1
        for <iommu@lists.linux.dev>; Mon, 03 Aug 2026 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785764244; x=1786369044; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pzkJ11PcuZctbuKF6H3B97Fb0rqT9GRSf4tUaQ3n42o=;
        b=PffB53rbdXVi15/+ftvsCvJOTltyjUdqBzvWPKG9NeJKf8k05KSZzy3dP+WX7Tj5qh
         Qyd4tDXKkOx+bvnVDT9ZDCr4nGkLM2pchPmnRPhEYYHtFubwdJZAss9Pee8pB0weFNC0
         VK6ybPIPohjo/M+kksj+TYP2BhpB/XFE/AEwyn+vYGycYqbkUXHiO2W3cv5NBmLzHuQM
         2Edp182zb9EUkSWI28QaaORvNBrX25bUk1fqq58vGEYfWhXNvwJCUE7KO/gsRv1tVhcH
         fZzC3jKGhdjCyufy96IV9OFb0tuga43LvLg+h6s5hYQHjsdlUoydjJXA2WoXvi8hkBfH
         M0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764244; x=1786369044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzkJ11PcuZctbuKF6H3B97Fb0rqT9GRSf4tUaQ3n42o=;
        b=HZD9IBdT3UYgODeoe0KRJy6nZVfp4Y4vZ+BrpnxAyQHeGi5iBnBQdqEEVQgd2RRNcF
         OQp1mUMKWSsnMPtSOnouwiih+UiQeoHryHxUjf+fmWd1zPUUTA3bDN9qFDWtw/Y4moYB
         1CFuKzR5UXsxu1mtnd90M3pP21Oir/JPnDJG6gn71/HA9ilSHyObfvrJm2bNqVD6T2XW
         oBdEC6FCuEYPCtAAzpNRaOVGpeSerHJWIMh2WAFZ+SHitxyzI92MGpPLW85uZR1KJYCn
         lgGhELJk/C7IfuyXlGMWjgz8C7SrSI/WLEYkBRFdKkq8yj4/V+5wMe6LMAxfjWG4on5z
         CHSA==
X-Forwarded-Encrypted: i=1; AHgh+RpVhp7atVgKFFjavVKhDi9+DXndYB66oocORXgIe4jRwVPSNvcaSfbDrt9kLnF5gthAujFCuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnTzvsnedIDrAhxq2DwZe++jyU37qFF8D3Iyq+ffCb/T+cSBvL
	o8diV19qlQQ8o36Cri901CL/FzZvVkg59+su0I67S1oSp83CYqAAwbeS6lJkI5ZX9Q==
X-Gm-Gg: AR+sD124wSigdWWCvh7OkblnLHI1O4XmmgUmBxynwm76Y1qEHvktrrEH8wp1bTC0Vr5
	tzhB2xZ8FmWT974I85kNGs9dI1HIOvwbph55wA2GbY2pPrRgFNwY+y9SnjMuipz5AtWnLyH1tH7
	x3EGW759Im0R9ye/qrNEVet3kHPaAI8lDrkpM7W5V849Wk0/OjHmtvekEZjrl+AvAbixWwyNdub
	V4C/RnAAvD0r4/1eP3Sh9qYpDB6F90De/5XyehxdUfsprzyBw/WomB7M9T31Gr4RjqZJ34dWTtg
	zPCyhn/4nPiEfl5gkuVP5XtjG5NZ08hJvagn1bFE5HOYQq9uEcBk/WcXKtAjiAgl53lC4dDurfp
	sZV2m2Inok9JZGdzyIxR20Z6UaaU4lWnnow56rYY/Mtm2WlfAefsrxvi4TDUkSRbyfJB9CMhrxP
	elrPXVOtl9aGYhN/1yUORsmd4sSxSafECsrXsHYirQhTFAX9Qj/mCNj0vl2+XZvzmU8CtThsRtA
	OriwHAN38BZv7X8I8WCKr8=
X-Received: by 2002:a17:902:d2c6:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2d0545416f6mr12684095ad.0.1785764243858;
        Mon, 03 Aug 2026 06:37:23 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2e11478sm3955257a91.3.2026.08.03.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:37:23 -0700 (PDT)
Date: Mon, 3 Aug 2026 13:37:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, joro@8bytes.org,
	akpm@linux-foundation.org, cychu@google.com, hhchung@google.com,
	amitamishra@google.com, marscheng@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Replace sort_nonatomic() with
 sort()
Message-ID: <anCZjMybqHA2n13e@google.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
 <20260730181216.2709088-2-visitorckw@gmail.com>
 <am8MpGR14HAg58Gd@willie-the-truck>
 <am+CPy4+gcGPtR3G@nvidia.com>
 <00dae86e-cbc3-4d6e-966f-39afd4b8c2ec@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00dae86e-cbc3-4d6e-966f-39afd4b8c2ec@arm.com>

On Mon, Aug 03, 2026 at 01:35:52PM +0100, Robin Murphy wrote:
> On 02/08/2026 6:45 pm, Nicolin Chen wrote:
> > On Sun, Aug 02, 2026 at 10:23:48AM +0100, Will Deacon wrote:
> > > On Thu, Jul 30, 2026 at 06:12:15PM +0000, Kuan-Wei Chiu wrote:
> > > > @@ -4047,9 +4047,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> > > >   	}
> > > >   	/* Put the ids into order for sorted to_merge/to_unref arrays */
> > > > -	sort_nonatomic(master->streams, master->num_streams,
> > > > -		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
> > > > -		       NULL);
> > > > +	sort(master->streams, master->num_streams,
> > > > +	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
> > > > +	     NULL);
> > > 
> > > Makes sense to me. Nicolin, did you choose the nonatomic version
> > > specifically?
> > 
> > It's probably rare to have a large multi-stream array, so I think
> > sort() would be fine.
> 
> Yeah, probably 99% of the time the size of this array will be 1. An
> exceptional value of "large" might be something like 64 for a massive
> (non-PCI) DMA engine with separate read and write IDs per channel for no
> good reason.
> 
> If and when someone ever were to report RCU stalls here then we can first
> ask them what the heck their client device is... and unless and until then I
> wouldn't think it's worth worrying about.
> 

+1. Agreed, it should be fine to use sort() here..

> Thanks,
> Robin.
> 

Thanks,
Praan
