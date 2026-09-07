Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143584908BC
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784113; cv=none; b=QLlDGwNe9jk/ELvQKXeWs0mwLGcBTahhlG9kL6LDyg+pto4XsyKTz4mBJMuq5jt8DYajGJQvfcQfOiopGqEu5zy1WPkzYDLSdVVT3FVXmjj0+JAntzPlI03n32YjkgXD0S0t5Wf/9ciD3RCFaJvojnw0t0v13W5Gf86ciLWDOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784113; c=relaxed/simple;
	bh=z7v/kmNec9IA4rwzn52gnsYGYmHKBsJPvU4XU2Q46/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csgk8SuHQTwMi64znf3gPcgKs7hb5w2nezC6XLw1IUP/632sFWGo+l/EhhE7SMeiIt/l0mwxcrudizyBXOWXTwGYLGCAaWyQsM4vBkMH1KjEvIEUB9yVHeGCMu4m1l6tMOEKgYkSbGOJmLs8Y8S3GQfGh608TlkjEt1HDaiTu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8F82D209F7F;
	Mon,  7 Sep 2026 14:28:24 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:28:23 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
Message-ID: <ap6tleS-DuRr7OOT@8bytes.org>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814104029.71021-1-vasant.hegde@amd.com>

On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
> Remove the iommu_group_mutex_assert() call from
> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
> release path is a legitimate caller that does not and need not hold
> the group mutex.

Jason is right, there is a race around pasid_cnt. Either make that atomic, or,
since it is never read, remove it.

-Joerg
