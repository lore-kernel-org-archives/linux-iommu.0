Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658358467
	for <iommu@lists.linux.dev>; Fri, 31 Jan 2025 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738283782; cv=none; b=IfHDwvaQ00pHxOWzUCBLeakxtEZ4Zq6dN1V4woE24nmV6yemkmeEwy0tKJipwei7WNL2/Yk6jBtbakRHWuTfHEI+sPC78jSPJl+9A7OUkK2T6H1QOcXgbStOul3EVu5t/z1H6bUVAeqtDowobOmJc4TGe/fdgdQKgwqMfPm5KDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738283782; c=relaxed/simple;
	bh=kI9AfXobCAN5OK389jRqqGv2IIj7d6c0IeGFW4d6GlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn6txgU23/vSHOyybS9y1h1FQTO+29b/TsyFZ/52eFUSxv9k1ocpSiV3vdPZXalVM3iQ0qLm5+A65isLiJGdRhvLBzeV3AJrtabbdQh2B2gm46eyt2w2uM2wvdqCOAurvdPcFw9LRwCSpHs3Q9w0NXJBqJkYfTiDyFM+QahUU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XdJ/L9zc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XdJ/L9zc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6edb82f85so200755585a.3
        for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 16:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738283779; x=1738888579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqldt/xcAytwXtteev0RCwhSZB7KS4Y37ipxJQOWiro=;
        b=XdJ/L9zccnTOOYd5a4T6d4QepLQ4ycdwRlRXlskcnbjsYba8yxckvoxbROpSrJUzSI
         Kj3DJSfnMPvEGrr6mcf6ki4F5/TjdsTpIlLrB2JL7ef2pHcOjOSQBXSfbs6orgEq2HnY
         7LF/2rgftiFMR3ogb77oEDEytndizwE9zApbRp7yAPHm1en2061uYeVaqcsMVQwMPxcS
         7M/EXg3Z/ZrBFnrlHw96y/rG+7yU4dHfzoSizmNy5pQ72Y/rQT8Vcm+cqIosQ35cyko1
         unMrm61Bjg7ZhKpV14ARN5aju8roFNPwiC+9u6oULzm/yrvz1rebeF2WViPvBGWVJcok
         9BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738283779; x=1738888579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqldt/xcAytwXtteev0RCwhSZB7KS4Y37ipxJQOWiro=;
        b=Vgridv0J/o0S9wyA5YgaCGfcHYoCbBC2Vf+ezF5mf8j69ktxk+Vj7TEiRy0s7U5O6P
         wNvGvvXbbomV4CE77xhe0BnPvKFAOxS6bVSevJZ348SAz2/YheTUOm948IH/rEwC30kE
         SGLO3lvFvJ1HBxxSRYlzsQ0i9+a3muUW9XPAEZux1zvL+eLDlnw8PGhkRfXgyp37S6PM
         ikH+5T4uyjgYtAgM1Q2ezG0cTfkL1hH2OeJDjOQkC8adIV+HEnsprsv6kIK3Et2Xn2DP
         0wQ/SHddmqTau+c0baeSuoASqx5jU5gqUQfyctSc53i/ntv+wk/eJybWuh9hyV1OUzcw
         90Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXLndp/wcUjyurgBDWbP7hvG4xJb9Cxdyt15y2gYs0PuMlXHXtY3uDguFJkPdu7fD/doeEuNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydiGc5O4tR3D6CgK4XPXymwilyDkvB3Qq2cZ+ZulJI2aXvX0W3
	2mIxENsdUaSU9tedg78bUTdxmeMtdXkd2C+B/YCPv59W8Xbc7RVl+K5ly+MnGes=
X-Gm-Gg: ASbGncsZ3b4hI6z0ul1fjbcMkPvCkYE/UgUCr8PieNGI/TRKcDjtqK3TEvR46Ed4yew
	OnY29xU0EZxrZMUf7P4ZVYA+2marzWsEC4RNDmBPtcJ4Zqt7DaKKTj232XfydsfiviK2H0/9twP
	keBY0SL9qWYm8ixpRcOe6K28ekHy6yS3bfMOfnXmbkwMzRWUME1Ai8qbgo4EDg+4y6Q22v6pqBV
	U9lKfIcHLbnmQdsXGmBXQRwki1Jv7dh4Bv+pmZwxiKEiCFiApq0xyQs7VmDqb6MoaQzQFeqbN3u
	8nAJjTi401sI/m4ziey2p80joKCnNkhyW/9z9jVszJbxfcXRo28AZ0yr1oGrbcRv
X-Google-Smtp-Source: AGHT+IE07V3qiTAW6EZ1X13h/qc9229k1AUAAxkUW5w5v/ZxDuN93Om57N1kexxou5u4vA0fw80BGw==
X-Received: by 2002:a05:620a:3723:b0:7b6:cb66:ad74 with SMTP id af79cd13be357-7bffccdfa82mr1548427185a.18.1738283779269;
        Thu, 30 Jan 2025 16:36:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bca3bsm130417385a.13.2025.01.30.16.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 16:36:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tdf18-00000009rfr-0aTF;
	Thu, 30 Jan 2025 20:36:18 -0400
Date: Thu, 30 Jan 2025 20:36:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250131003618.GB2296753@ziepe.ca>
References: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
 <20250120142643.GM674319@ziepe.ca>
 <67901659.170a0220.20b206.f1f5SMTPIN_ADDED_BROKEN@mx.google.com>
 <20250122001924.GT674319@ziepe.ca>
 <20250130232137.GA14836@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130232137.GA14836@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Jan 30, 2025 at 03:21:37PM -0800, Shyam Saini wrote:

> Unfortunately, it is an HW issue.

Well, that's pretty bad to have built HW that can't DMA to low
addresses at all.. But OK.
 
> Are you okay with this passing custom MSI_IOVA via DTS approach ?

It isn't up to me, but I've understood the DT maintainers would reject
this as it isn't is describing HW but just a random Linux software
knob.

I think you should make selecting the sw_msi dynamic in Linux.

Jason
