Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4A333733
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610968; cv=none; b=qQClCGHNLSXtcHlwZPEURRJmU8TmzlHKTFxFnBCrGG6LPzDjkyMueAOA0O7nwyj9crJ8/RTUZ+llckTpG4tQ2sfCTSkWsRbpViHb7Assbb/0HurI+WUqBNsFIbgwK7bQ5/vf/5uTt/xrgDdS8wql57JVrEjVoNhpkod/yDehuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610968; c=relaxed/simple;
	bh=WCo4kWYtIp5VVkDRnYkbOwPA/iZrX+cizrTFa06dh5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr5G/Hf1sWuEIVUj1KqbuAemSZep2s8nJa4g5XPhGsK8ukaRw+r6b66gbT51L1GjJR+FwXmsIK7qN1/WS6jeQy3EebljRHpwIeRXgSLbcfSAcnrmjJ4LAT6xSHvHkVGMFEeoqMqooWgPeL7hRAK4yc9/VtJegdSYbY7/k3KYpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FMcZFgb9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FMcZFgb9"
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6C8A1201551D;
	Mon,  1 Dec 2025 09:42:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C8A1201551D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610966;
	bh=WCo4kWYtIp5VVkDRnYkbOwPA/iZrX+cizrTFa06dh5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMcZFgb9YmR6wm3vmRwjdcLzvTQSwgvKZ/Z+3frvFsG0ENSU3LRtPovsASoZtcCLQ
	 m9vsUuJdUWdN+nohNX6gLKZVbKp4wbep9btYk2iGheRc/CsyUodanyIfw20o6SVJaQ
	 MrO6ZmnUpP1f+Y/3RFGP78ut31I8hpCn0Mo68h7w=
Date: Mon, 1 Dec 2025 09:42:44 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251201094244.00002463@linux.microsoft.com>
In-Reply-To: <aSXlFDAa672dZGVm@willie-the-truck>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
	<20251114171718.42215-2-jacob.pan@linux.microsoft.com>
	<aSXlFDAa672dZGVm@willie-the-truck>
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

Hi Will,

On Tue, 25 Nov 2025 17:19:16 +0000
Will Deacon <will@kernel.org> wrote:

> I'm assuming you're seeing problems with an emulated command queue?
> Any chance you could make that bigger?
Yes, it was initially observed on HyperV emulated CMDQ with small queue
size, which was chosen for latency reasons.

But as I explained in the other thread, the queue space polling timeout
detection problem is not directly related to queue size. It is a
code logic bug IMHO.

Sorry I forgot to directly answer these.
