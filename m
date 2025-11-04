Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5451184540
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285052; cv=none; b=Bag06HY6tm5GMlMzMSSyMxmPyh8cBcZ2jRGG07x/Nzvt4kslrXu7pe+dkDEKhFuwCcOsus3HHCpJJQ40QR1y1FFm/bMYW1i2ahnYkL1fX1o1mrshHOd/QD/M/SwcbF0gJJ6nYKXDyrTCV1cewwh1x4G8dgvHPou4M6hjllA46Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285052; c=relaxed/simple;
	bh=hj4gK3suMwSqFwLsdPSXTOmAGsGI39w2NC9u5ACsNQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoV/A+NrqaxSEpQXz6hVMJ2ldWnHLyY+GOL7ATDwd7EBRmj0nJ8s4x4ZKZkgx/rc8mDi1d841K3PRujcb88YxyypSs1UjgrMPkGjyLa9//IbtutJaaZBQz9FtO11Tcutsfc2/QgzGglKY5c9s3Cqy81oHX7l0phAxzdsB8SWusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WmSnUpMA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WmSnUpMA"
Received: from localhost (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id A7CF6200FE5A;
	Tue,  4 Nov 2025 11:37:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7CF6200FE5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762285050;
	bh=A2Qx6X64Zj6TSyldcGb1H5NxOGmulgLscxHvDKJ+aaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WmSnUpMArDeLYsAdqY1lirHXLX7OOh0MHpidrzrQMdw2W7Khnzw0iloGPO3cqxo5o
	 m+Z4tc0x1ZjlU8hDdiCwbOzcaIDONDHNYxUGDPGfFpisWrHTNr+Z9l3shjuEyZ4oW8
	 QTNx/1OxbJKePPOh13/lM3yn5iwpjxoQ3cne/EYI=
Date: Tue, 4 Nov 2025 11:37:28 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251104113728.0000568e@linux.microsoft.com>
In-Reply-To: <aQpKf2IPD5xeBu1K@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
	<20251020224353.1408-2-jacob.pan@linux.microsoft.com>
	<aQPptXsqzt6kJS7f@Asurada-Nvidia>
	<20251103151631.0000703a@linux.microsoft.com>
	<aQlVjtTiqd34I+NC@Asurada-Nvidia>
	<20251104102539.00001110@linux.microsoft.com>
	<aQpKf2IPD5xeBu1K@Asurada-Nvidia>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On Tue, 4 Nov 2025 10:48:31 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Tue, Nov 04, 2025 at 10:25:39AM -0800, Jacob Pan wrote:
> > > -----------------------------------------------------------------
> > > 
> > > And the commit message should point out:
> > > 
> > > The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit
> > > efficiently nor ideally to the only caller
> > > arm_smmu_cmdq_issue_cmdlist():
> > >  - It uses a new timer at every single call, which fails to limit
> > > to the preset ARM_SMMU_POLL_TIMEOUT_US per issue.  
> 
> > Not following what you mean.
> > The original code below does honor the timeout of
> > ARM_SMMU_POLL_TIMEOUT_US  
> 
> It sets the timeout per arm_smmu_cmdq_poll_until_not_full(), not
> the entire wait-for-space routine. And that's why you moved the
> queue_poll_init() to the caller, right?
> 
Got you! will do.

Thanks,

Jacob

