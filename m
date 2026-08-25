Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746448C8D7
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679474; cv=none; b=Y0xIaRleZ4Xi3BU5d8GoH4dZJmLrSFGYG2IhMSeVnIcc6aHpImue8EGoo2GfY2xRGE9ZI7MvDqMgw5LDODjC3he9wXd84kCIz6vlML5fRaDR7WOXwzxaY8h0pJt4XF3paAGu205/nJjnxs7AFjM77XKXZAV+fx+h7mG222Eoqzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679474; c=relaxed/simple;
	bh=r7MuP9K9u4qcC/4Fo1+uaOskLIr1S1uT7N8+Pd7bDqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDtnOx8P0mzSe7lSDLc/ymt0PUTi7XEnuNwBKjt3Ujj6AnBJcEr2ZDew7DnFoa6rLjdusboReygAggM4Q4NTvqhJf/qr8O/2V8gmAKAopLVoGARSLy4OJ2MWbSGzaYqSevOJGNOKktCYv3PsYNStir9qtPxLA4g8UR8+EOFnXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCiYKauU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCiYKauU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso10645ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787679469; x=1788284269; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yr/D5ign98BDVCdT+Rpq/9PzvrLTk3CogAV4Kz2hZf8=;
        b=aCiYKauUqNumsvhjlSeFDcGnaXyl4sN6w37fEj5OLoa45AtC4Ca8O7dPWmA1Lo/C5F
         AHJA7rJKFIU+a10GAMtFxl5BPa+id71HYovsSxgaHnBJxzidU1wsQ4gADv2k1tg70m7M
         6V0CIHjl3NVJ00e4dgwvFY9gxipijULYIIJluljqnyyRPgllmi207d/d5xiBf1LEWxwI
         cWTftAKdj6daVRIxG3azoQiAJVdNkX00801KPeVuKlobyV8z/y16Va5MsjanKBtLL1XQ
         UnMlugBQCA7A9JAMgCqmLSQgUO3r4TwK0OuF96SjsFpV1R2R/At3r2EVhOBqYLBiV2q8
         8d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787679469; x=1788284269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yr/D5ign98BDVCdT+Rpq/9PzvrLTk3CogAV4Kz2hZf8=;
        b=q5GfqrOtxqGlMCBhUiCP5iEm4Zva05+2J3WOcsHmV+9qUoXoBNMqvBrTMuqQoX8xqY
         bwKtSpx34ENpw6ndbQheMgsqLPPMBkDWy8fjXfi+07x8QPefXxO/zG2OBcOgt3Sqc/1Q
         imj58LjqR79Cod3N2PlIdbAByzEzr9yQB3py8cAqadnTytV365NFHQcoMt8pp6VFfJv/
         Y6TwoC/AdP/VQrB92d7v12ouFi1bzfEXbxNco6sCAoV5/bwRoMnFH5OWf/pnFObuOvuK
         ctigO2PmtfVZBk1rtGNiE0kBhFppJXgXZsUxzdTfQF0kS3GPLZlrTLw/qQM2qGxf3/SY
         KTRA==
X-Gm-Message-State: AFuF++nVIfT8CuDJG7EYmS269qYSp+O76aezRKru+9R6vqF185qSx4yE
	OO1WvnPLX0eH5q3YyeQEfvgFgU2GfJkVL1tNVjN2FDDDyWhMfCx9I22Z+XrEK/dTkw==
X-Gm-Gg: AR+sD11M9dm7UO7mhJO3L8OrKlPfg/lZBZJz38+nVByACFhQk+Ivn+Wcmg0XtSbsF+5
	yxI/KMPMWkmsnD6la3PC6ZV+8gYB7Vv+PfVglRS4wsLyBeVaaSP4jZVMPzyp+XJNwLKEhzT6A3S
	Crl6P6pzNGuNOPwUauSHYMEB8D2RoPKPLjLF/wOpVZS4Bo9kXQSwi362hpJOO51BEEZvbIy+Heh
	THkE390ChRjL0TWlRANWKP2MuJRhyeayMlcUlmarfPTxykmQ3tMm2kRhL/a/1RtGk8tjUFcvXbz
	wgiKBmbsY93nfBJ+62GTichwyRYdtKseYTiRmOji6Kr0aBjW2PGX/+MERNpRN1KwmJAGG6LWfaY
	NuVMnO6iEGI/JgyPRHqiFaMp6UWuRaCOKuw1sE5/4PHqru/u5dPqrSZyAvbdcwoV8scy86qw38h
	RckSqyYrnOMAzTshWS1husXxJfJfkBK38CqrMKVXxCAIzY76NgcCjR+spyCrtvKC+xemBpbV1Cv
	nLoMuo8tqHM9ZlMoxhf23n4Fw==
X-Received: by 2002:a17:903:3c4c:b0:2d5:db3d:1a43 with SMTP id d9443c01a7336-2d6e07a75e5mr8544665ad.16.1787679468673;
        Tue, 25 Aug 2026 10:37:48 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704bfc5aasm970305ad.61.2026.08.25.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:37:48 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:37:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <ao3S5ickm47p1QWa@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-3-praan@google.com>
 <178767577112.3356902.15184998673790345568.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577112.3356902.15184998673790345568.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > [ ... 36 lines skipped ... ]
> > +		if (queue_empty(llq))
> 
>  [Severity: High]
>  Does polling for an empty CMDQ actually guarantee that commands have completed?
> 
>  queue_empty() relies on the SMMU consumer register equaling the producer
>  pointer. However, for CMD_SYNC, the SMMU advances the consumer register
>  immediately upon consumption, not upon completion. Suspending the SMMU while
>  commands like ATC_INV are still in-flight could abort them, leaving stale
>  translations in the device ATC and causing submitters to time out.
> 
> This seems broadly wrong, but it doesn't seem explained very well,
> maybe put a comment above the function something like
> 
>  The caller must have ensured that no concurrent command submission
>  can happen. Thus the entry at the PROD must be a CMD_SYNC due to how
>  all submitters generate commands. Waiting for PROD==CONS guarentees
>  completion of the sync and all prior work and thus idle HW.
> 
> I don't think the other substantive remarks are valid.
> 
> The Werror thing is right, every patch should compile alone without
> warnings. Sometimes people add __maybe_unused to accomplish this..
>

Ack. I plan to add __maybe_unused here.

> > [ ... 19 lines skipped ... ]
>  [Severity: High]
>  Does this logic miss commands routed to secondary queues?
> 
>  The driver supports routing commands, specifically ATC_INV, to secondary
>  queues (like the Tegra241 CMDQV virtual queues) via get_secondary_cmdq().
>  By strictly hardcoding the poll to smmu->cmdq.q, we ignore secondary queues.
>  If the SMMU suspends while ATC_INV commands are processing there, they could
>  be dropped.
> 
> Yes, I think the ordering is wrong, to keep them as different patches
> 
> iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
> 
> Should come first, adding the op callback, then this patch would have
> the hunk completing the function so the newly introduced function
> works completely.
> 

Ack, I'll re-order the patches.

> Otherwise the approach looks OK to me
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Praan
