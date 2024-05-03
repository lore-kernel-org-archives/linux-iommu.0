Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885315357D
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742486; cv=none; b=K3Ei18wlWVxxIJMZ5WVT/5DTxJS+bna0jhMfSTUmr+7sJLDpJxpZCfEH9LYM4yZoSovktukAFFpyqyaQlM1gjDUjv71dKByoiSoMJX2l7O8zsLj/Ysjv9LS5R4gm/Js+Kb92SZjBdFPC8eK/QSXyGYtjHJzjWDja/gKkuzW1etk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742486; c=relaxed/simple;
	bh=ROkMIunr5IWq7zIAC18jbRmPyfymgcw3ladszUkmHpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCpdAK/F1jRbxG6sPjgduDEgbUM773wZHVqUF4JJt2ww43zkMQeGTZq+MOurOJ9HWCJRfIid0/dszdkzSMTf2cqg+090YfFF5Im3xomalqMUnes2dAxdACRRQhj1t+RSsro1ox0zv9upu3JjQLpRXmqXJmq5PdXKoti+jjB7TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OMgIwyIP; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OMgIwyIP"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C40E71C0B7D;
	Fri,  3 May 2024 15:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714742482;
	bh=ROkMIunr5IWq7zIAC18jbRmPyfymgcw3ladszUkmHpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMgIwyIP5WlFMzm52+Egy1Xdkcfl5wuWscTSt+cladqMnQ2GeMHkg5wNIQUPcEf7c
	 hduw/+2X06XyoMiHnAE8qo1OXwKurSqHcfcLzNekIOltqslpiKpG3qL5WhAQuzHiv3
	 Y3igQge48ovkGau0PFnJ+AP06yIZUS39PyffCpIMph6ugYPfoTDG4/eLIjMow43gc6
	 +3k5EvqPV9su1tRh68yM6XZEzk2kZuhlwc0b6v9sJLWvoVggvE5fhaPsAlmq5xzUEb
	 9GSGhFBlDVMUgur/5/HwvVvpc4P/mnYCAYYTSwyVPgakzvyp4NdY8pjoSRuhXIeBZf
	 dacqsTp+NjFmA==
Date: Fri, 3 May 2024 15:21:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.10
Message-ID: <ZjTk0YG4aJZiF0d2@8bytes.org>
References: <20240503111037.GA17940@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503111037.GA17940@willie-the-truck>

On Fri, May 03, 2024 at 12:10:37PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.

Pushing might take some time, as I temprarily lost access to my
compile-test machine.

Regards,

	Joerg
