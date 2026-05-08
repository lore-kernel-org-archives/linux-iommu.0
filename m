Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D7282F23
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232381; cv=none; b=ui/LCJSN48sW6gMxUbsv+MnAYbQQAXJQvFthLwt2sZI0TciAkwtE//7/SPOBwhEvY635Jv1gSqKJz45mKf8NY7jwRpbsUTgG9H8k9oQlUQyp3M4cFf3yVW0t73O6kh9gmkDKkp69RyxrLvr8Kyixtm1MxUoesCvOzsLUNttgrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232381; c=relaxed/simple;
	bh=a69fVEIS2hcYnXuKu1po3P5vB5uzlgae97LtTNj3uDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CePB1uERtEChfMExQk+MzHkJeJZyuNmDUFgWs/M+zOjkviGAtBztxiaGTehHtDaK08/ZSSBx8ShFwT9dHecfRGm5wdHeZY5r496lg34YBgX1BLyUB7fuJ+6W7nwhD8MMUJlv+1rJm3NRkye+6Q0awheawlP5opWle9WPHFG0vpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGZ2e9pC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGZ2e9pC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so65195ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778232379; x=1778837179; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z6CQ3IeyoNCQzM4n8QUnxz+E0eb5nkL31cz1hZskRQ=;
        b=oGZ2e9pCU3bHW4DHT4e0R41vrffjiB/zGMgnpz3c0Nu2gGjXtWpQqmOLu/J1xHmu+P
         1b3nveFoYVsDstg6svUlbk8HW8B4GanWDxHZ0JZ3lcudgz6YhXPlHfv8JS0HZQnWbjKI
         OORaiF4srEMnJj9CAQ1eomTqOvsH3uE3w/thExwrR+XfQQkEGi/BvQgzTH+bNDXAMiM9
         TvGDf0BOlxHTyr5g16Zjlwti8NgCUc1aRqc2m+F4CgWoV7XgSCNVPS6chSg49gL2ch+z
         n9gmxH0b/AN85mZQcEGMJx4SFfxZDZOt/4MXiGqOVkqjRCKKTAfCrIYH+I0QNdD42udV
         nVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232379; x=1778837179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z6CQ3IeyoNCQzM4n8QUnxz+E0eb5nkL31cz1hZskRQ=;
        b=TZ+RPK3OsVtKhbJKm6gkVqBlu5VJd9UsQSny+y7OucSd9A1jSE0kFgJYIkUyTszzg0
         +TObU945IHoHERJaRfzZfi4fcJHsVmA1Ms1MiVIcilLqj6v3W7wLu0HMVyLu0ykq63X1
         X/4b4P28ioAlJpfySgPzq/0b/e1PbxF1mjGpqlNvp8MYoihmu9T5nmv694W/ptPm1tiq
         PAYi6HkKX2nx4pUVJYRv/2k4pxGF7UvKiQA5kphVM3Hx5APPAk39PeqQL5vL5e67C5un
         cM1IBKOSdHPu4iVpKuNU6xbJYFUL8D+V/m7aoExfne206Ft6DH3mtHKb4icUJo4gSwf7
         gl5g==
X-Gm-Message-State: AOJu0Yz+dEZjl2WLbCo1f9vaDOBxnMs9B3pe32AtoT1tt1xojOGgULpJ
	BUn+jwLGxSu+EX09B+7OFkorBl/Z21PqOD/iaRhV/MCQb03sO1bqeVz/QMidkO06oA==
X-Gm-Gg: Acq92OGxptAzHgv/rNdE18AuBpCKDYMUuUBrW6Ji49ZuC4adVN/lO5PkLdzGDGxQtoJ
	LpeLc1sKV8Cq2z0lhcM5uEQd4Aa4awjO2ioKHPnwvfJ3ole28yGbYvUG5JvAzHJBA/hf15IvsDl
	gzZLASN2rMKs/iranGCik1sobUEoj90zL31yWHLswcVmIFBUMuOMLd8qZyA0hb2N/p6NJOwvx2H
	URhW7YyZA41dRRrH/xOpRtXT4SvwVHank1nA6d4I3mHqYTJknFoHQFoYntNdLqyBU6s1Zk1cGQR
	2WFAc9V4qny1jDS5SG7efbvUNdzEpPZCx5u1zcSSWrCFfmLQ4tjH5yFlHpLGm98WLmw0S+ZvoKt
	w5C9H3IE/x6dJaXaHuIXpTCkX76+pHYl1/rFazvj+6N31M5oHa5DN1C5J4RpAAyySzeZmcO8YSy
	8RcQNUaJd7VmpBEiKpwbxSEnB7U4NH2+t/ocivQ1QTzu/oLLxQvqRexMDFSTs61wUTsJOj
X-Received: by 2002:a17:903:22ce:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2baee828aaemr2177755ad.13.1778232378829;
        Fri, 08 May 2026 02:26:18 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm14866545ad.72.2026.05.08.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:26:18 -0700 (PDT)
Date: Fri, 8 May 2026 09:26:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 4/9] iommu/arm-smmu-v3: Convert arm_smmu_cmdq_batch cmds
 to struct arm_smmu_cmd
Message-ID: <af2sM-NtNvzCpvyg@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <4-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:13AM -0300, Jason Gunthorpe wrote:
> Convert the batch's type to also get the remaining helper functions to
> use the new type and complete replacing naked u64s with the new struct.
> 
> The low-level queue_write()/queue_read()/queue_remove_raw() functions
> remain u64-based since they are shared by event and PRI queues which
> have different entry sizes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com

Thanks
