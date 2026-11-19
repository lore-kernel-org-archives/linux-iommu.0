Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087089;
	b=GupKW7fUALZw+yT/z1J6WrPu/cs6UROBq1RcneZZ+ZnRAnjjtjccq2cp+wFaKb6O8wE3
	 DyUc09T1nQXrhF37L9HJ30A5PJzG43EGKU4DDticeJmL7S2QXN03lR4hcnvyegAF0NDav
	 3dtSMfCSjxCAxEy1bWn7dqPc0TxKjjH9I+YNb2kHNUbQKyghBz2kqNAcIICMHGcxbW8Ge
	 dmPwC7l2y7ld0bI8Xex8gnFSC/3+xeD6oqptpz0mW1atlvaGvhmd+wT8jstzGAWjRKoAS
	 B6LaCAc1pUYRirrVAG+Bo/7ONlRTBpFJ0EhaZk2XZV92DJRsIEfs7tW4x00QVibtidw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fY+Pd4NWLtkS0HB6qP6ih+nJNWbdv9Us893L8bxy/2g=;
	b=iEYo9sxsZieubvBnJ6XZW4D9bioogPhDGuMKYAyhHmu9XsVQ0M5CZlp2sGG3RibqKzgl
	 9gciSdFfs4a+p/1pvFVQbumcPq9jQBGowOOLY/m4dDscx/P8Xd+vfdLjmrASpFXXZbqjf
	 sChYtL52bLOrIgD5pFOLPZ0rI56mW/29ft8Fvx1WI1ACWP4bpTnQLiRcPOI7OjDz8oQFG
	 cJLrUyVu/oMwy9UzW1b0GgjBnyLm0A6QjnHB0ZxPLmqHIwcTIx9KTDcwL/Picq50OM8jw
	 j+Koh8J74FyLTiMzG7dbvoEIamWIjn2P0czcYbezTJxpejw01grCT22da7d1HjbTrZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WA81r6MS;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13F606A324
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 11:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C13F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WA81r6MS
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb6860f867so38125e9.1
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795087088; x=1795691888; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fY+Pd4NWLtkS0HB6qP6ih+nJNWbdv9Us893L8bxy/2g=;
        b=WA81r6MSiZyL/7N4cerevc+t1AZ7FUivSwelz4OSyQilRMCalwUOa8KzpFCsVhR+5U
         PFl6htnT0KWEfstnPd3UhDmYOETvDb+pza41VeqL6FuxyB93q1Qbi4hl2yfHSteaEw7Q
         N0R+zQ4oDDTRnumyC79V8T9t0IXEPEnFJOe+OyJ+AUWBe5+8yl2npv07OVADapFlim2B
         PeCUFJLvXWUurB/SWs3jLUNT3H6ywtoynA3Hb28H7B8EO82HTFwrbn3pgKVYYK2GwGcS
         /+EOJSvjzJLvtwHeKi24BolhXdNK/uw9ONKFWibbxdDgkibHnv6lowvAgxCY/huk0Q/U
         FwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087088; x=1795691888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fY+Pd4NWLtkS0HB6qP6ih+nJNWbdv9Us893L8bxy/2g=;
        b=jIajn4d7ifSPGdZJCtx4X63n77fuGK6R4VEGpoZ/Vj/1/qs28irPRt5QaLSF0Z0+J3
         wbJlMczW9PKYtYzO1HXuN0gm+UaAPet5O8KvOczr4dcOPl9Kvgnif+bs5Av3yi4bsKPI
         IKfYbPw3cre0TjAv6MsZAiBo/byrG+znH47nQXnD9Q3b2v/i0dvAQ8yx5gtNyhuNnh5g
         3AUqNXh4GpqjQGWQ3J9RPDPXTJXYojLWPyBRLKZH8LFqdMqeOTfvJ9SivlqiJnl7U8d+
         oWp2/vjYbphZ1DszTXQ7BWFnA/bLHK0TbGDqMITq2wK4JSGgG1WzTMsqMe0T/Tgv2xlH
         kvvg==
X-Forwarded-Encrypted: i=1; AL+hErEBoBfEStZZXDT0ngzJ5U+HKXj4kzzpFfDXXW10vrF1mROaHzK2qovHSRidQgXdRh5oa9It/A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/XzX+MD93syTW09/uNEHxjaxkXp3fAPA87dyltuhR1wHF60wiJ
	HbQqtLcHgQVt9ja9gzOxs8XNzEmOMgxq1tJ8wZTkbd1uU5DxPKIv1c8Y+xV7d4C5sQ==
X-Gm-Gg: AYBFou0dBMltUXd/5KEaEThYX40aNqu4IWlBLvxx3jMjR7IKuyNrppx6FNm6Fy+dwhB
	BcAlnTQ3v3K3BvHEoUBuqq1Reyg7mV1f/CSVc9JoGaf4TK7y0AAkH6NDkhWBeNxE1iYXFaz2nrC
	DdUxwrBCRDCpWgHC6VLD8xBSUGlj16rnTf8e6XGwhbQFvw/Eq6rMMASrvw8fbtcl9KyzKT9BaaU
	Aa7Wfp9CyYz1F28+UFSfUXz0aNI3BcI3naNMHOa4RR8poj/g9/m61XJA0JHmN1MtJ2ZTuNNQEHZ
	H/HSqGAyMTtJ6X/A7ZRGN48JbGoHcBHcZR+TYBHPUyQY5v3fGdUg7pbsfn79/T7jx/KVgWQ8gis
	VwDfGgR4vIGCOwWHW4xM8bz35wOYMim1BjQkF1EAEVi3/8s+ztc+pxuNMaEoM6xPwGYCM5faCPK
	mPD3fD7gss8VCI2KV0MbNgnppPs6636TBxgASDsC9xGEpArDoqrk66Bt6OGgJxdZRa7dEbKfSEF
	PJr34G3v3fbUi3hCVHo7s3dh8os2Tsqioe/c2yJ8CaoQk9ePcoriPIityeXBE/FUJDFzqPGOL33
	E/FZ0pNLb4wVMReMTA3BmSIHWN4tnKgyhHmQXF7UrqN30OkBG8MSyCzjWgNdVYpsuqMLBak=
X-Received: by 2002:a05:600c:a10e:b0:4bb:5e6b:2dfc with SMTP id 5b1f17b1804b1-4bb851b6663mr297035e9.13.1795087087341;
        Thu, 19 Nov 2026 03:18:07 -0800 (PST)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655db6d45sm9766011f8f.33.2026.11.19.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:18:05 -0800 (PST)
Date: Thu, 19 Nov 2026 11:18:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com
Subject: Re: [PATCH v9 11/25] iommu/arm-smmu-v3-kvm: Add the kernel driver
Message-ID: <av7a6RNSDSFH8t6m@google.com>
References: <20261015200903.2735565-1-smostafa@google.com>
 <20261015200903.2735565-12-smostafa@google.com>
 <auzvygiGRTWgJXzF@nvidia.com>
 <avGk0ilyJh3obmKx@google.com>
 <avJidXM9yQOX4VBJ@nvidia.com>
 <avL016l_xASN5paR@google.com>
 <avNhekBYqiiZ9IM2@nvidia.com>
 <avW_9A48mtnK383x@google.com>
 <avdI5olRpBdKeE9C@nvidia.com>
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
In-Reply-To: <avdI5olRpBdKeE9C@nvidia.com>

On Fri, Nov 13, 2026 at 09:29:10AM -0800, Nicolin Chen wrote:
> On Thu, Nov 12, 2026 at 01:32:36PM +0000, Mostafa Saleh wrote:
> > On Tue, Nov 10, 2026 at 10:24:58AM -0800, Nicolin Chen wrote:
> > > On Tue, Nov 10, 2026 at 10:41:27AM +0000, Mostafa Saleh wrote:
> > > > In Android, in that case, pKVM clears the FW (called pvmfw) that loads
> > > > the protected VM and authenticate it so any protected VM knows the
> > > > system is not trusted. This part is not upstream yet. [1]
> > > 
> > > You might want to double check a dual-SMMU case, where one gets
> > > accepted by pkvm driver and the other fails and so bound to the
> > > main driver.
> > > 
> > > It seems the pkvm driver would still pkvm_iommu_register_driver
> > > and carry on with an untrusted SMMU. Would it also clear the FW
> > > and mark the system as not trusted?
> > > 
> > 
> > That shouldn't be possible, if one SMMU fail the whole thing will
> > and the driver should clean up after as the probe is done through:
> > 	ret = platform_driver_probe(&smmuv3_nesting_driver, smmuv3_nesting_probe);
> 
> Hmm, if I read __platform_driver_probe correctly:
>  * __driver_attach() doesn't propagate ret from driver_probe_device()
>    via bus_for_each_dev to the caller
>  * bus_for_each_dev(..., is_bound_to_driver) at the end also returns
>    true, as one SMMU is bound to the driver while the other failed
> ?

I double checked, you are right. In android we have the following:
	ret = platform_driver_probe(&kvm_arm_smmu_driver, kvm_arm_smmu_probe);
	if (ret)
		goto err_free;
	if (kvm_arm_smmu_cur != kvm_arm_smmu_count) {
		/* A device exists but failed to probe */
		ret = -EUNATCH;
		goto err_free;
	}

We need that also here, I will add it in the next version.

Thanks,
Mostafa

> 
> Nicolin
