Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8A360EDE
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370950; cv=none; b=T+Mhad6DJptesd7UW8gLL1TPN4eAopvmiuPrdIIBheZrMM83jqwXepUgsFAwpnaf/CKL+cTuQE4AFYifGjL7BEuofaJ2KeVHQk8+nwkBSlLDcetkiU22BXNWC0sYKAzQ9LOzLUuUUdyNR/Y+wYRAYapJKM6trsaKKV/3yVIU+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370950; c=relaxed/simple;
	bh=xcxZrCtO2B/qamgwFEkX9bQjszietMHddUjqkr4Xnsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPNGGucfgBNYnw00w0aqWRjpd5sNodcvkGZcZQk6uM0ilu7YTu/mW4tS7lLz3MFRos8s/whom+IH08pvQdGPWEaKE5tchjxUlQPhJSHDjyWuKcFLBfQcVR/XRp2rk2qf3OV3HWQHR2vm2Cv6OyejvkIIwlZAPj8p5dCFr+Z40LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cztye+v8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cztye+v8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b1a48855so25ad.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 20:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780370949; x=1780975749; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9iT9NiZ066lEA6a1E5mdikMGDXU15Oav2UD45+kGhYA=;
        b=cztye+v8cssrx2Se5jhzQhN4jTAUtov96qTakGvflM3sTLLcjgrUhjSBI6rKv/nM9O
         dvTEnnO2Bnk1W0y+Vx7zo72eC6szKNvK2JANTKerAXHvbGniNsEPMZZDxr3DxjCxyMnv
         jUn2NM8jYhqCbHW3mPlmCaW+f6EuCyaalpDlgCN4jOM5ZKNxzhiDihk5dKhAbIpaxPeC
         p2QB52RkzERuScDd7+G8fCu4Or8d3Vy4OpXiqrrNWEDUsh6ebX/4vxX7HMXw2+0zjkqK
         FjaT6PkKlEZi7hKkcGHv0l1NlSJyVMhDdSPa86EOvCCKd5KwXbjI7iXXTJG34HAAAeck
         DgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370949; x=1780975749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iT9NiZ066lEA6a1E5mdikMGDXU15Oav2UD45+kGhYA=;
        b=WqSkpE7HHxpJKNp34bQC54fi04/MXyUCPrFQiQS82aA3aWeUzKjog90NIUaHkPIrjX
         4mXTvUy6O8k4h7MwhzmqRFkcT8jwTbH6zVw4xF88f69AuX+NahS44KRL6QCzVpjx6LG/
         U+zyoDDFeCmvrUNr5Vg0XfT7eBZc498WpSo00XuD//3AZv6bV3ADEdtwwKG9Dsjd3x+T
         u00Cu/wfZF3eo3Zg/Zn1cebt3dihOB/byF7kN9YqoRx1fAWKsjdL8SSMJNnIlqTPmcQ0
         LiYAFj+Xov5nrjE/oeZl+w4hU0b6hKs7+S90l9qigxLEpjjyFQQc6zf2ZidkQgLp2h3Z
         qsuQ==
X-Gm-Message-State: AOJu0Ywo/SMHXrcWX9iPXLVazHtiPTr0H/ifBifGxR0gmoXdBNyw1QfU
	CRMgDsTDoXBU4QBOvtjcEsMW/oeRUsu5bSCGvxmLrSpNc6NcecQLq/hKBV8gCtC589BR/fwUdBW
	uMiihvg==
X-Gm-Gg: Acq92OEM5lPfxG9a+5/b+IL1NfpDZR4OO7F3S2L0+cnbB9/kOE05nH8WY/E8A9XIx95
	T3vHWdEP+Y/oHcoDY9Rs5F080dHLYLk56vp2cGnjnUae3BpRyjTtAHXVyWS4BDhCHZjFzcPNEqs
	dOL4IZHCs4soiCCmk5wUbR0632vpnMKVQkMh20gDifcOTz3SS5sik2wkbau0OK6dLvPIMoLaQXl
	2DrBIKqi6Y2/19MYPhF2DUkkm4b70nw0ot1rIpUc60HCMkKnjiTlpJ01T46SRzmg7BR2TBxhFKk
	c61krYLUahb3RgW9qWG061h2Utd2eguVa7F988SQD611OJiXleHl202JPK+aJsH6JWlRrdKirSs
	AM0e6CHhggPcX84vNw0B7j6RSb4VP8iGQRxDQDYGm6U9ZF6TcD2FZlu+/9pw0eZXIrJNTHBYNri
	lxD59niA44rrYHcdbJp8beFarzQ1k+UietiTsOpUYMuKgYKEWtUZk+iCIVIGob9rRy+dxX9oc=
X-Received: by 2002:a17:902:ebcd:b0:2c0:c3ac:fdf9 with SMTP id d9443c01a7336-2c10eb2b85emr1851245ad.14.1780370947983;
        Mon, 01 Jun 2026 20:29:07 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd918f856sm1045999a91.3.2026.06.01.20.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:29:05 -0700 (PDT)
Date: Tue, 2 Jun 2026 03:28:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <ah5N-3s6NrM8dJrA@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-3-praan@google.com>
 <ah4f90HTmum4ZxbR@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4f90HTmum4ZxbR@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 05:12:39PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:58:59PM +0000, Pranjal Shrivastava wrote:
> > +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> > +				    struct arm_smmu_queue *q)
> > +{
> > +	struct arm_smmu_queue_poll qp;
> > +	struct arm_smmu_ll_queue *llq = &q->llq;
> > +	int ret = 0;
> > +
> > +	queue_poll_init(smmu, &qp);
> > +	do {
> > +		if (queue_empty(llq))
> > +			break;
> > +
> > +		ret = queue_poll(&qp);
> > +		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
> > +
> > +	} while (!ret);
> > +
> > +	return ret;
> > +}
> 
> Hmm, this is not the unified arm_smmu_drain_queue() that you sent
> me lately? Do you want me to change this function to that version
> in my series? I thought it could go in with yours.

Yes.. I thought it could go with your series 
   
If I were to include the full unified version here, I'd essentially have
to include changes from the PRI support, which is still in its early
stages. I'm keen to keep this RPM series standalone to avoid coupling 
its progress to the PRI review cycle.

Anyway it's just a clean up?

Praan
