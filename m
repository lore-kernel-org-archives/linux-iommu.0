Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67C372
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906421; cv=none; b=pJsG16HTbcdIz3yGfscfCLqk7h3UYy3IIhen6tq6fcHp7t9aHqqJ8Iwgx0U3IvxS66b1ktdT6KUmFaiVV9gnsHHSVq2I0o0LosmmyTOfoFksk0hAVpBnZz8lwbdVwURW6H4emnKyrHLmZtmZaT1pKiMJsO2F8xt35IzyHvrQeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906421; c=relaxed/simple;
	bh=tiNLSFbwmrWL1v63VmX/iUohS0tBAcIcwEX2+ScDvDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sd8CAkUnw3x39XFDfxXrp/lBWnjouEU9mTi8a/j5wT4cZ2vV2OS4rDiYcKQydpj3cgj/HLKIW2lMjmN0l2GBAkua+idkamTEZR357qJ5YdwkUl5QxkZ47I5boMIhG7dkhFyr3rF3dUlRO+LN9LcG5mt5ZRdqLQxV8V18rZbnZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z1fL29bJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z1fL29bJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=KwZmn1pJYr2O5Qca6G76MJZXUctSoTUPbm/W3gWQWEo=; b=Z1fL29bJVdaWjscaXZ5px1oezj
	3STth2LdkVkXfHrX6QTIsNZsbWjGzaq3XfA3tdBOSdEuO/aqFgE7nBdCqoKcPRsB9OtH0Q9X1B9B3
	tBfYDXJXJSPJiWc5R8aqWJgoY+NJVvK3ZNyzBJ/HIigfPlv1jJp4IZUQpIcaXd1W1ozSqygeK/z1J
	OrgYdwb7cWeE9JiwIhS8CT+YVGIcU6VuzmbJWH0bUW5WL4uJvCOPMQWHajTrbhRKmNS4pwY4HQef0
	2P25gWMWJTuqG4APQ+brxfELuJeepP8C7kBckDeVLB51/BzN77ewGqC8vaetPHd1y0bHoktD70Rs7
	ZX9PbkJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYE7-00000005u2D-27Y6;
	Tue, 02 Jul 2024 07:46:59 +0000
Date: Tue, 2 Jul 2024 00:46:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: lack of permission checking with intel-iommu?
Message-ID: <ZoOwc7O5W0PUeja5@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

we've recently had an interesting case where a device unexpectedly
modified a dma buffer passed to it.  On AMD systems this caused iommu
faults because the buffer was mapped read only (DMA_FROM_DEVICE), but
on an Intel system everything worked fine as the IOMMU did not trip up
on the device writes to that buffer.  Any idea why that could sneak
through?
