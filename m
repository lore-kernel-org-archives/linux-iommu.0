Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF947254B;
	Thu, 23 Jul 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807081; cv=none; b=je5Vr13QJwmnsP45wsGdOaEfQ6iiZHkxZSha3Ja6tpckQOv93mC0N49QxYjMbd/4KjCFs3DtQOzsbT8ArGLWiPE07XgKIIh3rDYepaYl54us0cfmOy2A13vWuSgfWWL1YxWFSpNcbcgsYcQdyrsf4L+hRGkEFBr5E4ojeIVsc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807081; c=relaxed/simple;
	bh=faN5FLxrifRz4PphzzLpmeGAPXxZHRR1gJE62V7Awnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIcy2VoFtq/S9OcnnBf21mlKy9ncV/TZ2jiZ8RSTWkj70yb4/pfR1Wb2TvK8nFwcsFfiQg8HN5ThE8Vc2KiCy+UW8txkyeNWqOdp9a5GRBkom5/ChjTnSsxs6XQVf2ZCzQtf7y5p3cI6IQpRNH3mbwueiwOfwieWDtV5gni46ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln43s12Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln43s12Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D31F00A3A;
	Thu, 23 Jul 2026 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784807075;
	bh=o/DcFd9/mnZO7b3nnVmoZyOJJ9tOaQwy/piU8sLT4a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ln43s12Y44AFoc4g5LllpSgsZfo7p20SNLUK31snRDNNVdfR5jrTPeNm/3F77EDRo
	 hSjhovfOSftQ4fVhiOZeYnyMjWZ1k0Chd9bd04nO65sXvBE6y/x/Am6CR/E33tmgO0
	 uu/u+kyalq1SprJUurDLVNenh+RwyYyGDymJH090ITKmp/VzPobCZoLaXCjSM4kQTm
	 XgLEbpkTKfaptZBPIA2ET+aVSXvYw7nwTsPevr7Kuw5nQQFWqKF1lUn0mVhsuqH6hU
	 21wtETB3K+mRtS0GzVJEXsGuwHBsBXr7xW07gOrCXTnAIiQ7d9FaB97Ovy2Ae5JiyS
	 dW9E0zWyWeN8w==
Date: Thu, 23 Jul 2026 12:44:25 +0100
From: Will Deacon <will@kernel.org>
To: Xiong Weimin <xiongwm2026@163.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Probe fixes for proper driver state
Message-ID: <amH-mV8IdK7lwVk5@willie-the-truck>
References: <20260714025913.2042-1-xiongweimin@kylinos.cn>
 <6A61897E.2B9DC0.17686@m16.mail.163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A61897E.2B9DC0.17686@m16.mail.163.com>

On Thu, Jul 23, 2026 at 11:24:46AM +0800, Xiong Weimin wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> Subject: [PATCH v3 0/2] iommu/virtio: Probe fixes for proper driver state
> In-Reply-To: <20260714025913.2042-1-xiongweimin@kylinos.cn>
> References: <20260714025913.2042-1-xiongweimin@kylinos.cn>
> 
> This is v3 of the patch series. v2 is now obsolete.

Sorry, I'm going to ignore this until you figure out your mail setup. This
is a cover letter with no patches in reply to it but meanwhile you've also
sent some new v2 patches at [1], one of which has already been rejected by
Jean-Philippe in a previous (identical) posting [2].

Will

[1] https://lore.kernel.org/r/20260723095100.1-xiongweimin@kylinos.cn
[2] https://lore.kernel.org/all/20260709095518.GA1752964@myrica/
