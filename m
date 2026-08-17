Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F83E9F9D
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971225; cv=none; b=PAjpBjkd8IjaVUvaMIwu4Zb4vCYPry7h43cj7Hvke2QPqPXibwB4zetmW7pcjCNZUQOxPPv+yb6r1/1TQbr+r/kQyId5U+sSDb9+ebI1BNegHO45+goHDJJAfvQKCrgkmN5ci+/AADQ8UaQb8sAUFl/V42+jviMa7EGVADiU69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971225; c=relaxed/simple;
	bh=92/LJ9ytiCnTo9nxdyNCfvLsbqsb1dRXtZFbNV2qfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN6cCLqDrm7gS81k8R7xWrXckrGDEJXQHF3mm1t1gWMe3fV7JiRYpToa/R6hBPxeCDJCPcU+ijCkVMJr+y4mn/TxitJ/Xk22SW0ncN6/rMoYIpBjR3fb5VPM23Y6NyVjOjvp2bWYycNB+YN+Bm0WbbE7iJE77xoMoOzB4SQRbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZbcqjKU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZbcqjKU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cede6375caso261885ad.0
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786971224; x=1787576024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/HO5352xrmxomcN/usyEVXCVrY50VpsMFDwsFMZfKc=;
        b=wZbcqjKUE+rAS5SW1yW1xTPoLHicSRTAkptMqvdGRmwaLRlNf+vhFNMi0oTDYAEkTJ
         ggEq9heUJuuFDiVaM8QffDgXvJK8U79eXjpnl9eHOiM4k7RAlFGWhNzd3krm+7bEOUT5
         9fV4KoY3fP+wkhiYAfa2MJnUJ93ywcfpFZWSXGyJY6QdbRcAdsK0oTkxijQBGFXgYDeo
         MV+mo7iXurADe4FwurGvXSVrqwOvCIJ9AB/cJzKAbh5U5+JqyY3EMRjeR+KcfWocK5lY
         Vvkz4XuT1/Z/ccLPwBpoQnr4Gm6Me25HF4rkDm4MAVkDJbEwtm6hlKpHWT4AhJCMMDWA
         8Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971224; x=1787576024;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/HO5352xrmxomcN/usyEVXCVrY50VpsMFDwsFMZfKc=;
        b=NwoJanG3VlEnnnlgysxdiIqSaAHpLNaoXpV6x3DO8ATMfw99OSCbQFpo1u6DZUtIQI
         W7PQobO+3lKxVve17pZkPhKFSYS6PfI0HW5WH60VtLQWni2lS03dCZeNyZHHy9OBkLwK
         ZLUl6yHCoQayyqSVWAUU+wuCSQ81KXa2AMe4t3hp8pt47vcVARQOj1S8wqXbsxL424uq
         E7P+oihQ4XAOw7EJkFPqNYhtmydnmehoz/azWFK/lymn7bC1dBgN6OWhBMftPRCIx089
         UcJGUFvXNL1NDeEf94ISqtchWRyrKlGJhRtdb8iTc/SY0XmM7KLyjBoGGD0VZOiID+8s
         yH1g==
X-Forwarded-Encrypted: i=1; AHgh+Rodu7JrZklMNHg1C8D0OtS0c6ne3VVOUQVop9aPe84t8raedJCRx0jFzMFWqGnmmRXPuAY6cg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1vFmwYwI9IZCOO+Gdrki/d9yWZNgASm0GvkrMwC5SiVPC04G+
	Ze8vKVpVsDB8z5jHQfhndN/I2m3meD7CRuw6wg4vaMnYQWx1Rx+I71qom/P+i2NOMQ==
X-Gm-Gg: AR+sD13TA+AvGDsMyZVpuhkBB1Q+gtcNEASkRYD4CYFya0fSf66sQ24bIsS2cUutCz5
	E0a8rd1YK76b2EYkUYuMq/5pSPNkY+9LcmCFop/mCN9D1J781vTncTy3PTEpUJ20qDDiGVVFclb
	wHmzQNJx5I/grpt1tc3TdusC3b4siW/oHL7MVRO304+c3mW7T14nzTPVS9bVKbc0pKjqjLBl0Xf
	m9yMl221GJW6ViSiGDRtgVtGmVXKpWFxDk6EpZUs+3G+VJhZyvHYgwRrleK+uqi5vl5WwnWTnWv
	Qo7os9VC19ipEn8GTOVh+BctQPZRVoDOq+6LtwxJfqTVRDUiPX+6GJTzrlCyNTW9yl27PGTCWfx
	QAbUnaPYJ2oLuq1sLLVW1dPP/404191PdBSTKj9DbNKmtvPMVMea29s4Qupe7qQuIsmAKjzLT8T
	EEw6UvLU8qe7SVkuXErAuYOU3k8XgnpFZ6DEtwDxrSLUpf7mIvHLc95mALeritEuvAWvOiTlAhq
	5CXgz1p8QsMa/gim8MXYfE=
X-Received: by 2002:a17:902:d983:b0:2cf:41ba:96b8 with SMTP id d9443c01a7336-2d590bad516mr5207305ad.6.1786971223287;
        Mon, 17 Aug 2026 05:53:43 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499d4bsm5258655ad.4.2026.08.17.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:53:42 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:53:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmitry Malkin <dma@nebius.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <aoMEUDQKlaWzvE8n@google.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <aoLtgeYLpYobpyKN@google.com>
 <20260817114407.GB1175472@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817114407.GB1175472@nvidia.com>

On Mon, Aug 17, 2026 at 08:44:07AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 17, 2026 at 11:16:17AM +0000, Pranjal Shrivastava wrote:
> > But, regarding PCI P2PDMA, you can still enable it with ACS enabled in
> > the upstream kernel *IF* your hardware supports TLP forwarding between
> > root ports.
> > 
> > When ACS is enabled, all TLPs get forwarded to the host's Root Ports
> > instead of getting routed directly through the switch.
> 
> Generally nobody wants to run like that, the performance is
> terrible. The reason these systems have a PCI switch is because of
> performance of the P2P path.

Ack. I was assuming the enablement was the major challenge. For perf we
definitly need to hairpin at the switch. 

> 
> Jason

Thanks,
Praan
