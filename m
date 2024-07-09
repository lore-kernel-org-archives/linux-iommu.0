Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8A153512
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526438; cv=none; b=FeVHz78bW81RCKrnAbKPqjntnxVaqztHY8B1pX96eyMpk6pV0ti632+5LVUK1sG8iZdz9SxnGNU0m4HBa3P8ay9aMNK/3wduW9uIq9AiJq7QOvmhWnHFlv+mtz/smmJkAhObtd7rspfhOJZ8yfhjZn1XW8im3juA6uygkgPAD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526438; c=relaxed/simple;
	bh=toLUgIpyEQcnggCOrjlh2mBjgYRBLgNBZT0YV/Q8KNs=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=baQfR+FCYPtHv2dn5G8qgYAxifKe5saXogWEZBhtwHFw612sGpJk4cy0BG2LVopnltxTc9ANo9sjjZ6lOgoHoN/Wl5U+hQWx4kngNeWvCrA7XUjGUvcxXEwAFYNqTbQJj4uaDXT5dzV/Iu/wGUmuo+edVokyHUhxXNmc2zsJxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=N3Til+P/; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="N3Til+P/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1720526423; bh=dbZ64BHIp3yV5qLdTNmAqMVYcS00HOsEU1NdCCEBITw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=N3Til+P/GAGjMPv6g3QVi4YwXX2cspCzVWiMoDj7et8cgCGyksjBNhsoMp4rjJrMs
	 SC/y5KwhpauDnhcO2zcOIgZ31BATLmhDdeZ1xwSjgy/mgsm/SmJIvycZ8ofeuoxa5a
	 fo9N14dWil+rsivqjK7g9UuSiwNDxtht2QPaKMsg=
Received: from smtpclient.apple ([2409:8900:18c5:1529:4c1d:7b9b:d874:a197])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 9EA148BC; Tue, 09 Jul 2024 19:39:42 +0800
X-QQ-mid: xmsmtpt1720525182tcupajwad
Message-ID: <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
X-QQ-XMAILINFO: MzViUhZOUTdXszP74t4hmOuQJf9OlpdPQ4A8jb9t7m3DXXgCBUtgrL4b7jRWa2
	 1QGxhWJvQvf5YOJokawhbkTx40VOhQc+hKWW0n4ng0+v+/0qMAV5+G0VbR4XZJvclCI6q8FH1leq
	 eAAOkMdUcqDrUv9OHK8cRw+x3rPPDgcXeF79z8bKI5cX+ORRludL55IsgeBu3mJAF+Dh0v7m1a+6
	 rT+N4c/xQIiOZngc9OIUbWZfKPg8UGQnmpj1iOKrfSYHTWz3+lUiyLpiCu0Ix/cZcTK6ZxQNsT93
	 PHhSKcKC3Cl0IRZ91one71dBjUvbb2Rojxx9Sdi+Z42+R/Q0PZG+YFOWhPHZj3RQFfi+zyG6vKo5
	 dACIjZrpI3dooip0AAfpIkpfRq3lXSfM63AkcWZjFAiQPAdeEjrPIcZ7MwYW1KwtDb6EXle3fAa7
	 8zvlz9SPwVpCtqiV1R3olAJkD1dfDRvWo1IdgKYBdjZ5bJxcwuPY50lTUMELrdeSz7QtN3zL1S4g
	 slzK1jZgHWrau9RgL8eU7PFlBm8of+FO3z1F03BzjjTi7xKaAQ8eDNTDzFcptNxIkXBrXX36v4hT
	 g3PtgQWdd4/RVllZHkpowRLV/PdqSeKsQ1R2XSEYUVPeESv0HRrjVUeINVqtnuPj/5iA7Pn9DEWC
	 Z+4Em/ovrObXrbiecK56of6S407wj6Sd14B2wVjxwmkUg3FQdPAxHHQn/FVTsAnDbCPlLqL4ARZH
	 pcGVuiSNQoH0Y7N5hNzwIV1D9gDdwHEgIpZXyTuil+gXznZ6veEwCh425a0lyQEOH1jBTbMLQ0I2
	 JFO9rX6AFngpnZqQUdH4QqvF5jZ18wRP2YuiEFItAasgU8udJcOwVuvtXVvE82dDWYQUykPALOpU
	 O3oB1qKn12ZBscUjCp1nyjR2Z4q5fpJL57jIuD+WuJwZ0qdYRSZrYri/GfB7IK9OIYNFgdsXJY7i
	 4WqmFEQfJuQ1/FRrECvCK4vwqMchGn8n0CWEp4fdY0qr9xU0tavEQU74IbAWs28/B1R/KTXzQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240709111901.GC4421@lst.de>
Date: Tue, 9 Jul 2024 19:39:29 +0800
Cc: iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <701519BA-087C-45FA-B897-86F1CCD442EB@cyyself.name>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
 <20240709111901.GC4421@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jul 9, 2024, at 19:19, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Tue, Jul 09, 2024 at 05:25:29PM +0800, Yangyu Chen wrote:
>> Currently, we have some code in kernel/dma/direct.c which references
>> arch_dma_set_uncached and arch_dma_clear_uncached. However, many
>> architectures do not provide these symbols, and the code currently
>> relies on compiler optimization to cut the unnecessary code. When the
>> compiler fails to optimize it, the code will reference the symbol and
>> cause a link error. I found this bug when developing some new extensions
>> for RISC-V on LLVM. The error message is shown below:
> 
> Same comment as for the last one.  I think your compiler misbehaves,
> and the typical reason for that would be if you disable all
> optimizations.
> 

The reason is that some optimizations failed to apply after adding
some passes. I will fix the compiler later. Whatever, we should not
rely on this optimization to get the code being successfully compiled.

