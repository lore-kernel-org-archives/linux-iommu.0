Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC137F8A6
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875038; cv=none; b=q/xxp/wWyYmCTKNPp0WMs5qrRPjyLmfCctMuOZ/IejOrgehejydK352zzR00koo8yEJ/KFy8McTgGyPvCb8JXxhW0SO0PYkNaVV1/tdxyxE2HXncwSkNax60C2hVU3v5aCyI+J9TgzANdRrHGCyWSWswiPrcDXVVgede0BIVhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875038; c=relaxed/simple;
	bh=mJ6d2Fah3aKQlTGOKzy1eP534rswevmMBGeouEh5Da0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc3ll6g9xhtAiurakUC+yHMiZeb2+T47PXJYSPGAy5vLGTT/CtfJlXHA8WlY0WQHavBXRoN+QTk0bG267zQeN4HuseE0LyzVa/2X4MYYNvzTpnSYbbZMuKi/CbkFMfI0aXmuBXEzO9bejTR3lr75XzHkZhmHupAjo+lY2bEUeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pu0D6nQt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pu0D6nQt"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a3342d301aso55962886d6.2
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776875033; x=1777479833; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HbtIWJEEQfl5xMwb90/SLKx0MmSnbCQLKL8UeHi8wE=;
        b=Pu0D6nQtDFdj+wm5dfo1WR4h0f02WX1xVZT/DwDfjij1qw10L2hr+KJo+A4LCJEfEc
         nn/l7RbGW1+XjroNXnToGGiCMbDYzDQgzBOrvJ8CkluamW3CSfPp71ketwMS/rvpCCD4
         GVt+HNcGMw6SldcAIZBgomxWqWEaIilJ8nSWEDtEV0LBJ7MYFVqRGKTAPkPyQ3vDKVH1
         7jr8rJXAEVhZ5SX3YtbARSvmkPb3MlHMrmYC5udLeOpvye1l5jNex3cLWNfsiU0fUsxF
         O43/IWhdHux9nBwrbxJz3sAY5jVshvOg65x4SpUkiU3cUxPRhyTxvlVdGR528jWGevYU
         4+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875033; x=1777479833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HbtIWJEEQfl5xMwb90/SLKx0MmSnbCQLKL8UeHi8wE=;
        b=nmQ2h8uuM7ehEHDW4pm4DeqhjJCscGnTLhQ0y/TRZiI9jwt4ce43RkS48YdZDqFYBV
         PQHnMtfkUbmxn7Hy4THlV/l+gg3sgV7VCsfVZ1Shsq/RquwWrl0WsBL4diiE50oaG3gU
         9claMl9iBcv/qUddk3SxF/BeJDRCCLJnG//e251B6u4jm72Vo0KNGavcgn2YnKariLds
         acSkir5RSOr3K6I9kP7lr9ByfQPuGTRVJ4f94J/DD1Fom/vIaY29CWDH3z20H0ihop9M
         y6mmNqOBTbdtwPoHPkMMFO+9bmWoB8FnvL4sLUYOt+IUF98MgFIQqtgJSeKWpZitsKaq
         epNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xDn+g/+qTX3mcnlA3gF2k3yrZDSrmDuleVhf6wUTlg21Ndrs1k69ipIDbvUKx9f+2cujXyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOdgu99SYuk/r02x+Ktk1FXRpfHB60zPEix8NZLOj+yrDW/unt
	2U9nRzFlM1nvP31hyksKtfsW+U3heVM0DuMLgo5Rh4DJWJVlaUIRjNjDLLGWccPCcjc=
X-Gm-Gg: AeBDietjreoKV6L+4/v7xOE88E6QjxOVIM8Szsuv2l38fSICt3EUktyT1OnHPWzQoqz
	N4FSxtgTUL/LiqOUGnsGr701Q8dPslBhIYyuiwcTn9mNhBndhp68TmII8kwkhIPNgQBjO1rNcxj
	tGJsGNDrvbj+/JwUMW5lOSiY2dOVOW5R4MwbN25ZOgEwE+1tMHH96w28qjsiEFIS4kUEfFdd30f
	JGA+31Z9dKwfQ86wUeTa+JSW3TFqNlPmGfltWfq2GgYzrQB/JOTci+9bMYUZRZxpkKn7kL0xlbl
	wImAWUcWy/uDF1U4GGrY5jwASd9e6yoLSpM0fUanMZTubGePAC5EZfewM/Hn2gSrgyHTL6Y5e88
	ZOq0YpTItam4DXfhuuL3zTih7a+uHgKi8/wKgD9yRf/HgOhwpY7BfYnqTDOu+1r8VoBRyKQwoyl
	wvBBmX5Ux/XR8yBJtLYmsAWrwjK4AuY0SsqO4mwaGzFANGpu4Ppw8f60hpGkuYYuzBOkEEinzN6
	Tew2ho4yru/ZUot
X-Received: by 2002:ad4:5de7:0:b0:8b1:f5da:f7dd with SMTP id 6a1803df08f44-8b1f5daf8fdmr109287156d6.43.1776875032883;
        Wed, 22 Apr 2026 09:23:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm136505886d6.30.2026.04.22.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:23:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFaMh-00000008ahB-3LYQ;
	Wed, 22 Apr 2026 13:23:51 -0300
Date: Wed, 22 Apr 2026 13:23:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260422162351.GK3611611@ziepe.ca>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>

On Wed, Apr 22, 2026 at 06:44:31AM +0000, Evangelos Petrongonas wrote:
> The motivation is live update of the hypervisor: we want to kexec into a
> new kernel while keeping DMA from passthrough devices flowing, which
> means the SMMU's translation state has to survive the handover. The Live
> Update Orchestrator work [1] and the in-progress  "iommu: Add live
> update state preservation" series [2] are building exactly this plumbing
> on top of KHO; [2]'s cover letter calls out Arm SMMUv3 support as future
> work, and an earlier RFC from Amazon [3] sketched the same idea for
> iommufd.

It would be appropriate to keep this patch with the rest of that out
of tree pile, for example in the series that enables s2 only support
in smmuv3.

> For this use case, Stage 2 is materially easier to persist than Stage 1,
> for structural rather than performance reasons: 

I don't think so. The driver needs to know each and every STE that
will survive KHO. The ones that don't survive need to be reset to
abort STEs. From that point it is trivial enough to include the CD
memory in the preservation.

It would help to send a preparation series to switch the ARM STE and
CD logic away from dma_alloc_coherent and use iommu-pages instead,
since we only expect iommu-pages to support preservation..

I could maybe see only supporting non-PASID as a first-series, but a
CD table with SSID 0 only populated is still pretty trivial.

Jason
