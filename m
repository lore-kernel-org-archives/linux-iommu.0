Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0D2DEA61;
	Thu, 30 Apr 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568069; cv=none; b=uolsS/5N7t9lbTr26Kfe+uYeGdJSq5ywsssaM1pSSxjEEn42z1i2Ca0XoraCvPFiQC0CJw3O22Y5ZLa3s5gtxcC68Yvd5ho3JcHiVP57/EStn0zSHrCuhQE8aeKy6DlcABy/7oBvh2R4Visn8ZTTmlPpTQC4we9Y/aRAf/vlS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568069; c=relaxed/simple;
	bh=kL1s/oOPrvI+U0yMcAdhPsvUAzlIXr058tup6YODNuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE+86j8LKEV4OFwBS85dF08oLtp4xyMEJUnSKmLVT6ZdZDtUNy9Ari5IFNgizl6jJzVHof9CpW9mvA6lniWYcVtdF3kNw2aUcunPTo/RWxGkCwVVYF3yYWEFGrVmV2pW3TMKm9Chpp2J29hk51unUzQcYkX4+StgeMNoQe1PJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oEqQXJYk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oEqQXJYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C736C2BCB3;
	Thu, 30 Apr 2026 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777568068;
	bh=kL1s/oOPrvI+U0yMcAdhPsvUAzlIXr058tup6YODNuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEqQXJYkOshCiOStItTTG0IJzuoiDCFSBYX9v8My6c27TuLs6XczYnbT7QIu5hR+x
	 Eq8quhnemUcSx6ORwfqDlucasyE3NIjMGYnsw94YD30OGst67rxwc6GdogxFkUyYKz
	 dkGaoM2dHfhDd4YC4Weg7978umMLUmuawt0a+Sv4=
Date: Thu, 30 Apr 2026 18:54:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <2026043015-dayroom-engraver-3176@gregkh>
References: <20260430152658.60745-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430152658.60745-1-95986478+SnailSploit@users.noreply.github.com>

On Thu, Apr 30, 2026 at 06:26:58PM +0300, SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

Again, a valid email address please.

thanks,

greg k-h
