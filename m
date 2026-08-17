Received: from mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599444239E
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982808; cv=none; b=ru0brxaZZtWl6uH962vv2sWDwV2tjzWyxf3B6QNzDiQHmMD73VwoEJDxwrgCSbF4iPX7+jMLmu7akEEE2mY4otthhjaRcYUi/mZhoeQmCWu0EhbC2xya2LD31wpLyVIg2yVJgnG05+jxl1uWKmUC73tPVvNA8tVN6sv4tzLVn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982808; c=relaxed/simple;
	bh=CgqZe8Bz0XwM99muFJKusVR1o4fnvZ8HiDN7HUnr2rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgvJ3uubFizCniWKjzt52/7gxxoAmgAWJH/ERsXj2qDO6BGloeNCWB4EklHlDAyHsxNorg2cHxHy07x3aTFktiP+t44+FbQDA5zXxzFxOgKDYESFuPeiA2qpoH2dUG0hvgayZUSmMT2zCh2DIXGRDQF8JzytPU7eYqSfecDjCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WVasJwAc; arc=none smtp.client-ip=95.215.58.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WVasJwAc"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=CgqZe8Bz0XwM99muFJKusVR1o4fnvZ8HiDN7HUnr2rw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786982805; v=1; x=1787587605;
 b=WVasJwAcCohL5sID0YzwEc3F5D+dXtNXHXGueVcpIteC3z8w/9bcGI6gnqG/UibAPRZUcSDB
 m9UOO130pO+qx/vjCJ2CZ468EqnZ+7qeOOvSn01I9T78BsPLrXMaZUVMKNQEvNIztG9yicaY7fD
 P3r/HdqOatjFTowsLSAniTlc=
X-Envelope-To: iommu@lists.linux.dev
Received: from localhost (2a03:2880:10ff:5c::)
	by mta12.migadu.com with ESMTPS id 181de17a528cb54c;
	Mon, 17 Aug 2026 16:06:45 +0000
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	bp@alien8.de,
	Joerg Roedel <joerg.roedel@amd.com>,
	samuelcrossley@gmail.com,
	"Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on Family 0x19
Date: Mon, 17 Aug 2026 09:06:41 -0700
Message-ID: <20260817160642.418302-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <697be383-2de0-4c6b-91c1-9887d23ddc9b@amd.com>
References: 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 19:28:55 +0530 Vasant Hegde <vasant.hegde@amd.com> wrote:

> Usama,
> 
> On 8/13/2026 6:48 PM, Usama Arif wrote:
> > [You don't often get email from usama.arif@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
> > 
> >> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
> >> Event log and PPR log buffer sizes to the maximum supported value (512K)
> >> on affected CPU families when SNP is enabled.
> >>
> >> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
> >>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
> >>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
> >>
> > 
> > Hi,
> > 
> > This series seems to break kexec in our production on Milan hosts with SEV enabled.
> > This is on the 6.18.43 stable kernel backport.
> 
> Do you have dmesg?
> 
> > 
> > If on top of 6.18.43 release, we revert the 2 commits, i.e.
> > Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
> > Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
> > 
> > kexec starts working again.
> > > Could you help in fixing this issue?
> 
> Sure. We will try to reproduce it internally and get back to you.

Hi,

Just following up, were you able to reproduce this?

I was able to trace down the hang to this do while loop [1].

Could this be a firmware bug? We are currently running 1.53 (below
shows up in the dmesg).

[   22.245942] ccp 0000:41:00.1: SEV-SNP API:1.53 build:5
[   22.308933] ccp 0000:41:00.1: SEV API:1.53 build:5

[1] https://elixir.bootlin.com/linux/v7.2/source/arch/x86/virt/svm/sev.c#L1017

Thanks,
Usama

> 
> -Vasant
> 
> 
