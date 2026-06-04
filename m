Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45A3AA1A7
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557532; cv=none; b=nf38MAtxe/bipgUHWRhOk87LlM6hx66MxSxIgJUUUNYi/Ivkz1HjOiJ1RkG+YFE8o0tpfD2tVKO8Be0reP3WlgfZaFXj8EN/w4L/FXjIxQddv2Whhw8AuNxmhCrNbhcXv6yAm4mcpqmgrUC1Gb5kJFcOLgajUlkDZQTFQ6r3QzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557532; c=relaxed/simple;
	bh=Mek9MHCQBbXXGK6/eSNX4Eb33fxb/1kpt9PPEYxNQhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnjRJhMk7xTc+HusYIRlSmRX83wwK2d4X1FEJUfr6Q99/nS+D/t86Es0dpJvjS5tF8fQeZz5q40jz2DdRB0atYYB0RTcVpja8NNmaEI3kFSKpv+gtDQasT5M0XZvqY+szNb1iCr6BRovzziAN/memjYun/WSUlA5cjNAMTvzsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXP3Tzac; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXP3Tzac"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so82995ad.0
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 00:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780557530; x=1781162330; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SoO6lBeFYolYcKoclvlxOZ0nr1TAmQMvAGC/ju1rkIc=;
        b=SXP3TzacYLnNxPPUJttKGNwd5v68FIRnQ09NEp11vlH6JhkB0g/Afm45p8m+GVBeyZ
         IddQSizUYkfdI+M8uylzcicZd+ej0nz11wh32WhEmthDaAqpgfHYCBXTT42mT5t1BHV+
         el4S3rfl676qS1EU9GDUDPwRK7biab36NcgJLh529LlsXi5iFCrJLoH1ci/Gh5JHPp4k
         uthXRrz/84xSetoe1efvbcIRyVwwsZ4z+U6kTaJ7orBgOkmg/887oN7vp/q3PLYqriUm
         hv8zRODSIg5s5OYYE9gVqvwa+PGjjjAAjb4szb266D5GSWFbzRLzP6ahj+rgLX9lZ/tv
         qGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557530; x=1781162330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoO6lBeFYolYcKoclvlxOZ0nr1TAmQMvAGC/ju1rkIc=;
        b=EnYkXCsJ84IGOIVhLB41Ew/ARPo+KGJlg3yP1TdYFhAPi0WwG7TlAnUxZqR4cx3Kmm
         IAH0AhKQuF9+UwWLOIjyPSVR2GgLWElPFguspU+LpGK0HcEqaM3nf5ioM0eplMWKLi4k
         CI6hKSsuHTkmtbBA1ud1Sex4utdDaO29GCmkCryjJMgsyjmIGWrUnY+Y3xyldyCsV5gJ
         on0lKjbbQjpBlF8LhXYaMGmp9YVMforHISxwsCV2cVDRZ8cENnQzeY1XfwrZe2eGFIiT
         nib1nTqp/gZctxg5UBKWesATTbbbGrZTgb3hTV5FNIifhRWeshWIWqReDAWmJ5ywrpxT
         GeQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zJryk5b1E/9Q+y4Lpuz0omsyHzG1HJCPRinPsuIq7dRjnerZcGqbNjHLlVEc5sG+RPoSGqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX1TwE1NKTT2v3AeEJYCBzFnUX2+fgk39rlAgYAQzQZbRuD5tX
	OVDJlbABgWr2Gn6e5/gdqGGAnYqF60w1HJcMNrQa+L1TE3h5jSBqiEx0zVjxa0c7HA==
X-Gm-Gg: Acq92OGRgCGyqnDEtNFuQ0N3sC1qZ7MZQC5Ms1Ea2wGRwkG9q8eTMkWPjKhbDyqZTXW
	hqlgbVd9qmj4/jbIpxl+BY9Ex32udbRnml0i72MHwtutNLuXZARS+SVZ+NfdBJaTpF44PzO3oDY
	vRcyvQn4dO1EYTmS6BM04+PW+3YWNV7teb+soQjbwSMXtN5aefvqptc2X9JO48SdzDGxiaWN6v0
	h5xgo4LcaaFVxbI2ogkiPacAM74sz9RihS9mL+Atq2bKBJBfs8t0djKLcJe06CurvMTbmQsjYcQ
	xmvmMeY65hZ7aqu7e0NsLAxs9kjQXFORVM0nEl5IiTJ/aR9YVA1WUUt4Z44fsrYE++sXBlQ/xKw
	PQg6tbIsEjoWU/vW5SF1IDWc2QrF69kxymFHNCzY95R9aMRiXDu1rfiB4xaB33VMI86xporNsp8
	BlSdClTqZt1BLa6qg8PdWByXOAWjPxr/x8QPy7kCI4rJUNL9eHPkUccvCYugknUOc/P8fduKCS9
	K7EkjzNMw==
X-Received: by 2002:a17:902:e5ca:b0:2b9:a39a:e5db with SMTP id d9443c01a7336-2c1a1a84726mr1636465ad.7.1780557529331;
        Thu, 04 Jun 2026 00:18:49 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a61b3sm4268319a12.17.2026.06.04.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:18:48 -0700 (PDT)
Date: Thu, 4 Jun 2026 07:18:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <aiEm0yuNtG3PGJ4D@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia>
 <ahi3uY9YZZtR1Lq5@google.com>
 <CAE2F3rDeZe+w7-V6hyJtSOwCj619E5SNtjJjZ1-yu1sVdf=35A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDeZe+w7-V6hyJtSOwCj619E5SNtjJjZ1-yu1sVdf=35A@mail.gmail.com>

On Wed, Jun 03, 2026 at 03:18:32PM -0700, Daniel Mentz wrote:
> On Thu, May 28, 2026 at 2:46 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > > > TLB and CFG invalidations are
> > > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> > > > the arm_smmu_can_elide() helper.
> > >
> > > All the arm_smmu_can_elide() call sites here would eventually elide
> > > the commands in arm_smmu_cmdq_issue_cmdlist() that is already gated
> > > by CMDQ_PROD_STOP_FLAG? It doesn't seem necessary to gate again?
> >
> > While issue_cmdlist() would eventually elide these commands, the
> > can_elide() check is necessary to return early during suspension.
> >
> > This avoids unnecessary stack allocation, cmd building, and spinlock
> > contention on the cmdq->lock for threads that are anyway about to be
> > elided.
> >
> > By dropping these requests immediately, we significantly reduce cacheline
> > bouncing and contention during unmap storms. Furthermore, the early check
> > also allows us to specifically trigger the WARN_ON_ONCE() for broken
> > devlinks.
> 
> Hi Pranjal,
> 
> Have you observed unmap storms in a real-world use case, or is this a
> preemptive optimization? I would not expect a high rate of map/unmap
> operations while the SMMU is suspended. If a client device calls
> iommu_map/iommu_unmap (directly or indirectly), it suggests the client
> device is RPM_ACTIVE, meaning the SMMU should be active as well.
> 
> I am in favor of removing arm_smmu_can_elide().

I saw some with DMA_FQ (fq_timer does batched async invalidations) but
the early ellision doesn't really help with perf which I agreed to in my
reply to Nicolin as well. 

The early checks were dropped in v8 (except for invs_array and for the 
WARN_ON in inv_master).

Thanks,
Praan
