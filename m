Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095733DEE9
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372801; cv=none; b=AHQMuE039Fq1ONzGmzZFDV2cm+YwEwYBFU+Ib27Qn9NnwBNwjd2QLjYgxEzwyOmRMEF5lS6RSIxb04GfdCcd56zj3CjZOgv6gs0Epwh++f0eS6tiQpk6KEaZnvyZGnKPTRUE7LrbbBdKtJgmxkc6htZo9yKdzrup5bwRUUiMRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372801; c=relaxed/simple;
	bh=hc/EUR8HjFEwpJsJyqjRro/tpDKXoGWvdUQydwlaLo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyCBGU8OEmCFQv6ybJExsdaQvoYCX7gkmnkvvsGUENkD3aDdk1sBnb7tWLvUj01fQI2hvNT+gh83qq2emmVnYOpDQgLkbt0Mn418jW8U6UxDiylK21RF4FbeE+xd6KWiPAOHInPEbcWUT3LBMV0pnEXm4b8TQViovAmq7EG38x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLLfc+ZJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLLfc+ZJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2911f93cso1845ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780372799; x=1780977599; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeVwboJJee/PFYlolYYVyKzaxGvMwNKFwWXPyXPPzMM=;
        b=wLLfc+ZJVOUVNKMQxph6KtlRM7bi2ErO+h/4oGp7whZwXRelClImiHTNnxukke3nq9
         RC5l50XreUFbKsSjZ2VcYqBoZs7EKlzw63cDmQvbMP0TSxz5ltny0oHnBxulkaGa5vcn
         ZRSK3uqSTR9TzTrDqLRacp2yjz/r2cWBfWNHKPJvetVoqTbr2eHV1lYBd4l6VbhXMeid
         4Db6Urob4li7VaXgA32hWmNV7QSCqvc3gSuXHh8VOIEcxOUxr/PJJ1vnVPiXiMtx4zZ6
         7htG2fb7/SMC6ZhuT2broelxKTkZ68zI5D7WaybaIsrR5K3X6VjIOPKxRbSCzrrLFmOm
         3Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372799; x=1780977599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeVwboJJee/PFYlolYYVyKzaxGvMwNKFwWXPyXPPzMM=;
        b=sVldNF/CIUOtEqsXu8P2mJzNiQjHgFjW/isR5CnNUat/5qGmkwbvzMfNnHcRFyhMY5
         0aYmUP064xWC93uvgAiLivPh0FQikXpPuha/JERHPRhlVMzfv8rH52sWZURBm2unXoAK
         9X6v2vyVGSULvM4XvIfqo5hfLnb0MievzS9e/Bmy7rFsKAbRAdraaArGtrboHR69kkud
         OMNMjkNC91eqJ3YMrN16vmMxFSFqRWk+c6Ho9psZGFMTjOvk+twq2YYEJ71pw0TpD5S/
         WrXEH1e3G4FxBKa81eFZjEUrr3ubV5db0za3MQCViwFB85usAXTwhvGhPwb9IwosBWRG
         OqkQ==
X-Gm-Message-State: AOJu0Yw0OKQNIYvSQuTzC5xFZeaksRSLv96i2xX3P8bUjdO9benbZ2fM
	c1C9VT1CJN5XPHLzPeLRdTvcPr/dGyhEmbMfp1HiNU9SIWRD0AYFVAy9H0TrHAYsGXQsleD0pz7
	1OFKdlw==
X-Gm-Gg: Acq92OHf9DvXC2FYnPwb4u3c9sDl1+PguTclO1r/lxj7VarRxO31bW/rnAvJ+zF91h2
	b6q74raYi9ek2hG//qQ6n3CeqGHiiBK8tZUjzyRLhcy3tZMMxDPstNR1ua12MG2LQvZzbN1HmRe
	gQIRuY/61fXhtkLq8ABk6GMbxU9sNL0ejhO9jyc9q/MePWQWzyowJb+f7QltsGlJp9ZbFh9naj6
	Ky/Evtrqcz4u9i+NwE7PTWwrlStVl8KMUZIlJQm6AQdFD6zsUn/sR/PWuLo7umhkD9cLA9Rfv1G
	V2nc+1q7B71V78rrinUtL7AwYgz8B3x3nA0HIJ7YbNBzec1Hp2xW9EaT01+gsFUUVohf44oGx4I
	rP0MUuWSmUMNUZXQk+TB0BfNPY9+32gUhcMhujJ3/gq8FDPU5PSZ2q4wcqfc1SeNO4hRv2tBoHQ
	8jvbZe9eyYcxv/aGKE1/RUmhByrSAjQ4drc5+MAFqnGVg5MCgxhCltXCFhTr7tCDAjIa2R6iA=
X-Received: by 2002:a17:902:ccc3:b0:2bd:6727:d689 with SMTP id d9443c01a7336-2c10e88445cmr1839125ad.12.1780372798814;
        Mon, 01 Jun 2026 20:59:58 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84233c08eefsm7393253b3a.4.2026.06.01.20.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:59:57 -0700 (PDT)
Date: Tue, 2 Jun 2026 03:59:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ah5VOE5vuEPwr4oQ@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-12-praan@google.com>
 <ah4isiGhSScKMotO@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4isiGhSScKMotO@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 05:24:18PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:59:08PM +0000, Pranjal Shrivastava wrote:
> > -static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
> > +static inline bool arm_smmu_cmdq_can_elide(struct arm_smmu_device *smmu)
> >  {
> >  	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
> >  }
> 
> Can it be named perfectly at the beginning?

Ack.

> 
> And again, should it check Q_STOP in vcmdq?

I don't think so.. the primary CMDQ's STOP_FLAG should act as a proxy for
the SMMU's global power state. Since all queues (primary and secondary)
are gated synchronously during suspend after SMMUEN=0, and ungated before
SMMUEN=1 (i.e.before the caching can begin). Checking the primary queue 
should suffice..

We can also decide to drop the can_elide checks from invs_array and
atc_inv_master altogether, leaving gerror & page_response the only
remaining call-sites, both of which don't use secondary queues.

Praan
