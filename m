Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828449;
	b=JTnkW2ROrwoa7m13w9xEIoAjpGkvaVxcJREl0JM2UCU2Af7UbMEbl37jX1GqVmIfPatf
	 PEMoSCLXAWWsb3LU60NyiK8qe6mSWgU9mzUkVbUCbUc+EclQ9faxR55Guf0hMO3TTShmP
	 F5ELF4i6LWF+odJgTBlnDGgvBx2hLallStPECErjAe7gHHid7dShjr/VZNl6mBqSeP80p
	 gcKCeaKHdZoIGFmegD48oB2npZe61Vi8d89H9Ka5tpBdaWD88gGFpkOVS7qC2SPN9oLYT
	 3PiO01HSEmILWkWRr+7Wfsiv5ZUM/i5Fap21lHHN6aqkW0Tgd6oOMGwYh//rTY/HpoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tBRyOmfVz8NGvUB6443p0uDWKpLMKwEn7oh7YasEKJg=;
	b=NkwWdynkOCS4CD3e3PlawfLYWFnB7+KV83GVyMYVhNmcDy9kiUVeYsIzPOszpfupuuPL
	 lggiRZ5hs5HXlG6tY0/Yr8Rcp0mAUf4teXiF5SQo+oVfHXgZCd7dYZqRLKto0VVDjeKnO
	 fcoSL+qEYCypqMxTrDfKt4kT3Mzhw9YMM2d1jHIzA2uxlqu0n1vCWKeDC5psgQXLiDMJo
	 x/S7zNhtVCsD/JRm3E0xip9VBOQVe1UKRCSfXQky1eAmCxVExULWFR/E2kx5dxFhtGCPX
	 Jek1OqgjEX9/+iOfO96oBk8OeZbMvxHgLVAj6nSlVDG9V6Pq/zP2HnOsA+EFDcjktzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c3BB50fS;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7D606A33B
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF7D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c3BB50fS
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae7fc5681dso5584c88.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794828448; x=1795433248; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBRyOmfVz8NGvUB6443p0uDWKpLMKwEn7oh7YasEKJg=;
        b=c3BB50fSitxuKPyrV02hjBHaifPpc3xh+4XeSuk253qJ/fOaCuFJoO5fYpryNamg0l
         yWX5yFXW/rc2cLOSa640E5PWmsPoxAX8Q75eHyTasaaER3Ax19tYM468PJCHsFDQbWfO
         iQA393SCk/DaREgR7+HYN3/OQ3xPAMb844BdEqvMg5jE5IIxakRZZd+hkOo/hupO7vmt
         PW+JIajGUJc9uom8KhX+Z/5cEJo6ZW4JoIc2ZD1t+iWh4QD3CPt5bAcDZukV1y8CiXhH
         EigG+0RVW7G+veV5TjNhl+g4fxeMgtFxDZT7xXv/Jj+ktpNGmk/s0J/yQGwPFfYqBr+o
         oMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794828448; x=1795433248;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBRyOmfVz8NGvUB6443p0uDWKpLMKwEn7oh7YasEKJg=;
        b=UmsagkklhyuAgs24y7kN1EzOFAo3CkfDrewyO/+H1anbhAhKlhxoLW69B3/+xxjDk8
         s1YBRMcsXP3ChMC7mV+3/xkxNtZ3ZUdYfiFoY1K5XaBTRHJMvgo0ExI59/aoszPUeOlF
         E9fiaTVgvmk4XGpCTCdGSXeXhKu4VAFhzn4mvBhp9XNYC8JagvzryTCqdaeWC6OAUyL7
         d0Apm+HZmLrYdYkAt8sPBhjx7hW4BKRaE+pz+IQsmgFmfCxFxul+PnbSd3ZOKcAXfs1Y
         BbfvfoFBf6HH/0Jom+NHWl+qqSowN0WqplLVF1NpIv+J8ZI1S2hkIl30+tCD/ZLssN86
         TV/w==
X-Forwarded-Encrypted: i=1; AL+hErFUTi9bWFhbiqPbjJ7Ph68q9+hzzRZMzhSuyWa3Fzx+1fHlis3jAIFVcm9IH0tIeBSM4ZZk0A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9EMss2axM/OGjbvVU50qhQ4qtJKL2GWb6opwrNPxDHUKttAxqz
	k1q8nTK9/GRigQt1qXYCzsKRCYTaRrEgaw/OcOc+yDGJCAn535si3rpjnrVIzFwxGA==
X-Gm-Gg: AYBFou2ssbSdlaiG9EcTr7Ye4SRmPREL98NGqOYm9xlP06VcHA4Z6bN1UlB6+koory2
	V+61sc6wGQNJWwh+xT+lkBj2FYP3EZu1iPjZF2IpZ8q4T0+rdAVri7H5KMi9oD7PKhJX7RDvnRn
	QNw55eL75mESdhSCRkGA5emvVAfUURTFV2pQNUdGcWaJZS2RU3G/AymQ3tDUFcpdGJtC3F5rmWl
	q4w6n59uy55LzzwfdZ7/JW/Py4Glag2JwKJU8fo37eXwU1PdJL71q4FZ3UAGD9Wszvw12SvFknj
	2mEyWFWqRSbJkdSe0XCWSKoupwx+s9wAdE7J/aZ8HMQmNGorVq+RpRTcvhEM3D5KyLyegT9SgCT
	wOENGophD8uXwhxuSwuscfTdJXEoys72jTp3WtYEDjfdrdQ7eftyHHmGNuFxXxlGMypB7WBIkUv
	zLszumVruV14nWju+WrjaPetXPEhepRhvg/c4xB2/i1sF0mVFklRGfaP+S7Oy0H/RfsiZ2xfDs3
	qiiUGf2z/qFir47YrwW/xOyVRDjOLuitqM5t+Mr0nlL8iVaBXRYIkJ16Q7c/EmHsr0E7eJuHj/B
	6/SilDnhwPmD2BGORDWfMZjjt0T5w4mDUelRb/xepdLR8zHvTdPMUJ/PbwoFomyjAdc=
X-Received: by 2002:a05:7022:219:b0:138:2d13:e32f with SMTP id a92af1059eb24-1b519894d4cmr561146c88.8.1794828446816;
        Mon, 16 Nov 2026 03:27:26 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm35874984eec.28.2026.11.16.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:27:26 -0800 (PST)
Date: Mon, 16 Nov 2026 11:27:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <avromFJ6opeGEcT_@google.com>
References: <20261112151039.2083705-1-praan@google.com>
 <avdO5cBwc/2ysstZ@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avdO5cBwc/2ysstZ@nvidia.com>

On Fri, Nov 13, 2026 at 09:54:45AM -0800, Nicolin Chen wrote:
> On Thu, Nov 12, 2026 at 03:10:39PM +0000, Pranjal Shrivastava wrote:
> > @@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
> >   * @data_type: The data type of the @kdst. Must match with @user_array->type
> >   *
> >   * Copy the entire user array. kdst must have room for kdst_entry_size *
> > - * user_array->entry_num bytes. Return 0 for success, otherwise -error.
> > + * user_array->entry_num bytes. An empty array copies nothing, though its
> > + * @data_type is still validated. Return 0 for success, otherwise -error.
> >   */
> >  static inline int
> >  iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > @@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> >  	if (user_array->type != data_type)
> >  		return -EINVAL;
> >  	if (!user_array->entry_num)
> > -		return -EINVAL;
> > +		return 0;
> 
> TBH, this doesn't seem very necessary..
> 
> Though I don't have a problem so long as Jason is okay with it..
> 

I know it looks unnecessary in-tree, but zero-length is the documented
way to check if a @data_type is supported. Intel and the selftest check
entry_num before their single-entry copy, but arm, the only caller of
the full-array helper, didn't and returned -EINVAL for that probe until
your patch [1]. I've seen an issue downstream where a driver called the
full-array helper on the array as-is, and the probe failed with -EINVAL.

> Yet, this alone would make things inconsistent:
>  * The other caller in iommufd selftest isn't updated.

The selftest hasn't used the full-array helper since your patch [2]
switched it to iommu_copy_struct_from_user_array(), arm is the only
caller now (unless I'm missing something?)

>  * __iommu_copy_struct_from_user_array still rejects !entry_num,
>    and its callers (intel and selftest) aren't updated either.

That one copies the entry at @index, and an empty array has no entry,
so its callers have to check entry_num before indexing regardless. The
full-array helper is more like a zero-length copy_from_user().

> Also, please don't omit "linux-kernel@vger.kernel.org" when sending
> a patch, as linux-iommu doesn't trigger Sashiko scan.

Ack, will keep LKML in Cc.

Thanks,
Praan

[1] https://lore.kernel.org/all/5223275dbc8ef00af233f3fee01efa09e45f26b5.1788127877.git.nicolinc@nvidia.com/
[2] https://lore.kernel.org/all/535f3b97e16c437f1df0c988a96229f623142ee9.1788127877.git.nicolinc@nvidia.com/
