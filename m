Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879625484A
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017810; cv=none; b=eMJJXkVDB1jeGVZEraeCIemRSmVH4cj3k3RjUj14iE+kUBLVGnQaYOdjJynfdbWPV46JLpuxEL54pGb5X/8n2do1Yb+b042QmdEaGCNn0dfcKB38o4ig7hGinGhpS4zyOzxWMf9sBtSd45AhzD2xf0woej05/y85Xx4FZjkpOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017810; c=relaxed/simple;
	bh=krErKrCpoIhgwIlpMLTL8+SjosyfecOuympYr4PltHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhbWNNO6w5wUeudG7bUytJ69tOzhOtNNarffECjIC+qJWPPhjCQmPYBiployKWUEbp4OH4fsZvnFWjIZQ/8pyly4iWqr46CxjntVGdTH6dl5dqx5XtbqOB7qfLEobACg354oxYBwLb6mJUtc1SwEh++RnVABAHvXuWZ0o+wguz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twb/RQ+V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twb/RQ+V"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so40825ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743017808; x=1743622608; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m36WW0pzCgKaekw0eAQiLyg4+RiOXGz7sDjnundFbrM=;
        b=twb/RQ+VenwE7Ob1gJwTfBizzwxbyN9rmi1IqEuYi9l7lKTh9ndV+h7+aoRcfb8RMo
         uQW+8L6uA7OxssFeLrlYNx/zbxZW2mO4DFYvNMRMPodoLBAJfrn2/0uI/wWe8qcveeS/
         rmU+FObPWi3I5wfYqUQSud0Lca/rFt3+JM3aAoYGG5sMMFSGvbcy8xtvggW4Tt4jvYss
         bSPepYZiCCO9oDrZEfSk1gEppGXGFqYJmZkK1SBYxT3rLTsJcmiUPV0NZWPrpMTwAsOW
         zn13qBWI+CULL+Baih00ufkFq3D3k6dZSm3BGu2UdTkl+8iPQMqeEz36ceWhmDk2G4Eh
         hdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017808; x=1743622608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m36WW0pzCgKaekw0eAQiLyg4+RiOXGz7sDjnundFbrM=;
        b=DczsYN5a33/h5snpua+wv5RoIOOLA6optRw5vkr06tSk/E8Ajod5r3K8v/UwZAPy2T
         NX5WwHhvz+qAFexrvE+gd5pL+A+1Yg2jaHTM3ZdCLcHK8rIGLXy0XLWFmX1SShhfzRoR
         PJlnqzBF+JCoSW6OPxOrPZFWKXseI85GcfWjOj/Rus0Sg+mdTscubsRFmtv2rn1l4Yr/
         VcOe0ABqbTqSYBH6ZZEYVHs+j1AgzOyUqTaN9QoOuuWg93j7t6Tzo4SkJMPbAtM9V2W2
         5focQgVar3bSSQel+zCneoBoihXR3KAmZY8mcd1xixXnuXHwQhYyps8otdB3KH6JRqRK
         f08A==
X-Forwarded-Encrypted: i=1; AJvYcCXHYgXZaHSzkkfmTLtPSDgYStoNVSqFZVXlbTeuHpKaqcKYw02BqaC0Cz+RV6E8HezrMzNqSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBMGQNOcVmipAin6YvclYr7NjsDYrjN4LltnSwTBjFWC4dlfTR
	7xOUHoIsi5J5hbllQaBk4h4udl5EinNy9AldUpSkq+5ukvX2LGNKOzrWdY4C/cUt+8M8ZqPuOq6
	PgA==
X-Gm-Gg: ASbGnct/yYkvPylthVryzjFL+2Xjbrixmp3g8JY1OFpgLY7zvPw4KIxQ/rmt/sO3uhj
	OfAA/1rkLwKylJuaVW0YqF01uuoslPBpAKO8J59ZPFvg94jcQtPKnSUWc5tqzEePRzXI4lF6FZZ
	HJGPvggFT0kH/6MdUkmzh05YJDXNBbEl6kpaCTEaCBEYz5XWsph8SpG4jhVNJRc2fMhvpkgDbee
	25gH5pRmF9JJaJdXchsHP1BMFhnJx2xG/Orne4KedICk1Uz71wfyAc46meGUEoO1RKQ6Jgw1mM+
	SoIBiawq8wqHqsRZeMplcBDQTSajzMNbf24qzXFT3YMhUslbNkpN2tPpsyrS/cF+jO9aYFNifZd
	mWRw=
X-Google-Smtp-Source: AGHT+IFYWtCUsJCzT0LTJohUKlzokjpjTufZfP8Qyp9BzKXDkyd2v0siuzDndIAPE9wQ9Qqe736/yA==
X-Received: by 2002:a17:902:e848:b0:220:c905:689f with SMTP id d9443c01a7336-227f442809dmr3927825ad.25.1743017807550;
        Wed, 26 Mar 2025 12:36:47 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a27db649sm11295827a12.10.2025.03.26.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:36:47 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:36:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till
 cmdq drains
Message-ID: <Z-RXSLOb7WmcBzUo@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-3-praan@google.com>
 <CAE2F3rARkn_CwxeBOGsivC+ytX1=5DWmi6LP=rSndiFo4fj8wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rARkn_CwxeBOGsivC+ytX1=5DWmi6LP=rSndiFo4fj8wQ@mail.gmail.com>

On Tue, Mar 25, 2025 at 10:50:34AM -0700, Daniel Mentz wrote:
> On Tue, Mar 18, 2025 at 5:43 PM Pranjal Shrivastava <praan@google.com> wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 80362d9f293b..f65d9bca0392 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -754,6 +754,30 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> >         return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
> >  }
> >
> > +/*
> > + * Wait until the SMMU cmdq is empty
> 
> nit: There is an existing comment that reads "/* Wait for the command
> queue to become non-full */". Align with that and write
> "/* Wait for the command queue to become empty */"

Ack.

Thanks,
Praan
