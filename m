Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A94367B8A;
	Fri, 11 Sep 2026 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138684; cv=none; b=o6if+16K3Ek/fdppSZuVK51NkvNHQ1gmdqIOGMI26gKA5l8LbsOb/p37iw5+WhNpkn0Q3iuLUajXyTH0NZSuZFK2OspF/Swfq9B2PJ1O2Rwj1RrwCw3Gj+cZQWIEY5J117pBTMfIYli3or7vj4CAdlcBFDiMzPn2xpbbst3JYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138684; c=relaxed/simple;
	bh=sWJ9/QLmlJdH1a4A4ox4tvmelMsF0lXR1XmcXFxvJXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9y7hOSluJ+cu5V/xOBoS+Kbw4mXTlwcNLA0j5iA5b5HjgAl26pUb7ZFxxxEYRE0HJsM8Nhq0a/bNcQsw9wzz7kOr8sDGkE+3JIm+tjYg7dHSBO1mJU54NIy51lCc/qABlxjZQ7oJ9xn01MuK7sm6D7hbhCvfbApWws5RGpjUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=c4MZ28Nj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="c4MZ28Nj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=sWJ9/QLmlJdH1a4A4ox4tvmelMsF0lXR1XmcXFxvJXY=; b=c4MZ28NjcGLoT5gvFsqSD2qxTd
	JvWNXyAS12CEm6CWfG7BXBPNpC0fryaEfoHNgwjdrsSDuyKz+xMNcPZM+6KSyPeJhcr20f424vkS4
	SgTiY+emYvLRLhi/z8TGHUcRPD7CvP7aE0CbO9VBmdZ3HxGv0ZCej8qCUQNMM8WAKykjDDvSk8Fmd
	LzdnLW9Tfv4zw6Gj/u2GgZv4KmdlZPwY/TGMXHhqwn29akk+MG5hjHhX3RxEDalhYKBXdxPKCsxvF
	7OD/I/qRRe/5+AcMQ7SB7q6mINlTLpnv62Xzuu4J3Di1162En8H69+FJNKtPdfGARVplpJmuq8Uvb
	EO+NpenA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x52hN-001MsA-2r;
	Fri, 11 Sep 2026 14:57:54 +0000
Date: Fri, 11 Sep 2026 07:57:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, catalin.marinas@arm.com, mark.rutland@arm.com
Cc: puranjay@kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	kernel-team@meta.com
Subject: Re: [PATCH 0/2] iommu/arm-smmu-v3: SMMU hitting kdump mid-air
Message-ID: <aqQWrz74_sOmyZrT@gmail.com>
References: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
X-Debian-User: leitao

On Fri, Sep 11, 2026 at 07:54:43AM -0700, Breno Leitao wrote:
> I've found that kdump does not work on some ARM host, such as AWS
> Graviton metal, and the SMMU is what seems to kills it.
>
> The capture kernel dies about a second after it resets the SMMU, part
> way through PCI enumeration, and takes the machine with it.
>
> There is no panic and no oops: the console stops mid-line and the box
> reboots, leaving no vmcore, no log and nothing on disk. Crashes on this
> hardware mostly produce no dump at all.
>
> This is my theory, from an "outsider view":

This should really have been tagged RFC — apologies for missing that.
