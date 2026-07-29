Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913303A6B71
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303993; cv=none; b=Ldh7zulJH6bfUm+JrFI3b6syDivoOvSSk6bYct9U1vkrXc5zeJaG75QsiVd4vwVmfKHpn9QVy7hQJ3LH77oqo8haW6UK9xOOVFdDtEn5eIzL1mIcFhcaRr/XUDT6IxFV1/rem2Tjy5v12NehvZoAo/4Y59/LIewzpoPmz4SwL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303993; c=relaxed/simple;
	bh=ydP+87D/K348FSpdC9NbnctdfuYDb3MlvkZ+qPWf4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB/kWlcWdPLl1aISI2tJ/Upaz6y3kyzYqijnpvOq/iSpgSNvZPfqK8UR3oEekV/JMYAgwxasWXsr/sc67r5hm5uGik0IKoFJFh4XA3pbWwPxN7qz9tkbJzTYs0l/9at326FnJyzl5kZEafmg/5JfJJEdv4dRvgKQH07MtyFZF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hc2SrVDY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hc2SrVDY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso73085ad.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785303992; x=1785908792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KUrSKghuESWPVo/dW96oFPOfRQeq5DnIatYi5FWLDOg=;
        b=hc2SrVDYiRkxEC6P6Fvkcme7YMbaS660w74hw0nzzVfya72V66+Ias6m4AQBQKN+tG
         +/jE3Ra6yK/YvDZbYrIKyViIKeVmjmbl829RTytcm2caNghWBrM58nCYS5PrQqkRRgaI
         GVHN0YQUW9Oug2ZW+NbZM/YmdHiryoQI4YVqaz9iur5NAQYumsfKrOdtHMbrZCKoEk96
         UtZ21xTvWGuP5dH+cBsoTt+13wAbuLQup2PrCvRDSQ6aCD4iHJaa9SnNWMXu8ROXsaHm
         kC6Rpytij3vUQhS+Qx6rJyUoHCOBMWLNOj1PySAJWnpW5SnLeHW02Z8rOdB1phjAeZiq
         ucgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303992; x=1785908792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUrSKghuESWPVo/dW96oFPOfRQeq5DnIatYi5FWLDOg=;
        b=delrIm10aGV3MGSxCL3nfB4E64uxD9QtnXr6PJQ8agkNe3ZEIZnzbYodDpfY3j5Sc/
         v3g783ebGXSXh19RflqZ+koonklwroRKzIqzYnv3NFxi/lWOdYYfkgksKjKQ+3pACFYq
         srj5o+etXMCHuaI5DdpVLcyE+PWLlZ1W3BF3P9IiEKWDpkRqGvPksMlcEQJnVHiAheKa
         w6ykKZ0cWLi8CZhVrrN645x3xe19zEcoxIye+9SfgpUR/eenLjG9OdmDdkS4sGIHHOfL
         0jxqn+EKDCE0Fu9d5duOhIEnPBFwfhxF5wNEPfinmKxFdOq8flnZp6XDdmvufzCm5TYk
         7Grw==
X-Forwarded-Encrypted: i=1; AHgh+RrY5JU1ZRL+dsb3d0HEAXVAgrmuqaDWPZg5s2uhE899yyZWeMghGDjR8Ici4uyz/EF+/pJoyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPXEc+hs/uWdEVlAil2xH3milO0NMrIx3JUVP7MHfVvCvUGbtS
	hkDXA8fDhyriOI7EinQf/xtyUB/zrcH2sGbi+sCvqnExILHCRH023hqPOKAJJS9bYg==
X-Gm-Gg: AR+sD13C7XETOzUHI200rQtKOIk/LQV5KxdkYiZgJPC/MfqRvNQvm8QKmLNe6kug3rh
	gfLPcHv6GnWH1LT8kwXSyvL1X3fkD4AP+I2HyWzsiFzfhmYF4YBdAKkskGiPPDjI8PdNGlTIk+E
	j5REvqDIvTCIfc3quY3Qx8mmgDSxXMDkd4MZzNpUHD2xnepYk1N0tG7GHhxKv7WUGoiSMNXL7BH
	AU5Az4Ly+RRaAVJkEkOaw0sxCUXyPTgyY+/QLQzXQ3vxcwyHPhtedVVx+bjiOxuuBZlUX+sObNG
	ERHV1udC7UJ5bsL4yz9j3Rx/8LzxK0t+cMnjLC1joVQRPiwbXcsoNR941mPnVF4ajtqCgZR9kWG
	aSgCr/EbLPWi7b0o1JJNQHwNIYvHgI4EW6RNqr1f8mSQOVz3Qx89d+opLMeKcHVfv4hWLoP0LTJ
	T0C4DvPtUpCrIKYqBGP3HviDVSdsmOxAOz8NOu4lbS3rCDrAuCL8yTAY6sjHyamh5bJJwM2ijt4
	zI3Jgt3h6zJwpOaBvOeRdc=
X-Received: by 2002:a17:903:4091:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2d026c4dcc4mr1313315ad.0.1785303991374;
        Tue, 28 Jul 2026 22:46:31 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f642fbf74sm2219437a91.17.2026.07.28.22.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:46:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:46:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <ammTr2kvjpiOHkbT@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
 <ammMf5z-Gl-Wygk6@google.com>
 <ammO+4W/dGC8kTCr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ammO+4W/dGC8kTCr@nvidia.com>

On Tue, Jul 28, 2026 at 10:26:19PM -0700, Nicolin Chen wrote:
> On Wed, Jul 29, 2026 at 05:15:43AM +0000, Pranjal Shrivastava wrote:
> > For PRIQ/EVTQ, my only worry was the HW producing more events,
> > say Device A is detached (we call drain from attach_release) but Device B
> > (still attached) starts an agressive DMA with multiple PRI requests/evts.
> > 
> > Maybe we should go back to snapshot based polling for that?
> 
> If you look closely, "pending" is the snapshot, regardless of the
> growing prod.
> 
>  * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
>  * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
>  *
>  *   cons0                cons                 prod0         (prod)
>  *     |<---- drained ---->|                     |             |
>  *  ---+###################+=====================+=============+--->
>  *     |<--------------- pending --------------->|
> 

Right, but we write back cons to cons_reg only after we see queue_empty()
We have a do { .. } while (!queue_empty(llq)); and then we call
queue_sync_cons_ovf(q). Same  for PRIQ handler.

IIUC the helper relies on cons_reg being updated:

cons = readl_relaxed(q->cons_reg);
drained += Q_POS(&q->llq, cons - prev);

Thus, if we get a storm of pri reqs / evts, we may never leave that loop
and queue_sync_cons_ovf(q).

Let me know if I m missing anything?

Praan
