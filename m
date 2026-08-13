Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5A369D5E
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627130; cv=none; b=oZZ4NY8ItJbe2rlfyqvgU57ksqneWAjII2ino1pgsEmXol+6feFCo0DVA3CczNBfZcLQTIaRd3asg0cbs/RPcEGCw124dB1GWhqSY8yiTLg4lH6ZQ1JW93xO5aUwSymwn3CfH2FBDvqQM2bKR+7eUh2jdhmcREcxfDk0ZeTqqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627130; c=relaxed/simple;
	bh=ff5AGyvZulscsyV7vUU09eM7F2uqaJv9yHVWWZ2Uqjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxtj6nRUKTuWESl6vPPcWf9+0W7wTXBI5P611WG4E/UFBk4+TLBBlF7Ff90n2nXRkhUq0dyasaPfr7RsIt16HK3gHZGrIAgepmuDxg5MRM6E5i8fetwLDfTcvuyRru/FpqVVz0SCA0z+rNzELa6sZVO/aL3lM1gIDo0UFmJ+Io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtMKwiHh; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtMKwiHh"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ff5AGyvZulscsyV7vUU09eM7F2uqaJv9yHVWWZ2Uqjc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627125; v=1; x=1787231925;
 b=FtMKwiHh0LF6nelQ5KUIbY2Mzlhn/AbddQCJMoJG9gzGnuGLqkdk+PV2gdZox2XwKifLfSPk
 PkGuUX2RznoGgpoJByY6Tn2hJ5C0ogIGsKjdxL+J3m48ut+X32JZqgHTwifvrRVfFtxIWiBZ1rV
 MHr40YbOIaWkVFLl4D5jhTVA=
X-Envelope-To: iommu@lists.linux.dev
Received: from localhost (2a03:2880:10ff:26::)
	by mta10.migadu.com with ESMTPS id f5aaa5407b7e8aa0;
	Thu, 13 Aug 2026 13:18:45 +0000
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
	samuelcrossley@gmail.com
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on Family 0x19
Date: Thu, 13 Aug 2026 06:18:30 -0700
Message-ID: <20260813131833.2808948-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420084204.12263-1-vasant.hegde@amd.com>
References: 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:

> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
> Event log and PPR log buffer sizes to the maximum supported value (512K)
> on affected CPU families when SNP is enabled.
> 
> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>

Hi,

This series seems to break kexec in our production on Milan hosts with SEV enabled.
This is on the 6.18.43 stable kernel backport.

If on top of 6.18.43 release, we revert the 2 commits, i.e.
Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"

kexec starts working again.

Could you help in fixing this issue?

Thanks

> [1] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> 
> Vasant Hegde (2):
>   iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
>   iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19
> 
>  drivers/iommu/amd/amd_iommu.h       |   3 +
>  drivers/iommu/amd/amd_iommu_types.h |  21 +++--
>  drivers/iommu/amd/init.c            | 123 ++++++++++++++++++++--------
>  drivers/iommu/amd/iommu.c           |   2 +-
>  drivers/iommu/amd/ppr.c             |   8 +-
>  5 files changed, 110 insertions(+), 47 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
