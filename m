Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222C345734
	for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829174; cv=none; b=iJRpQxlCwKjdAfVV8E/uhMtRTMJpfataI63LLVf+kh153u8qKllhpKTCet5OT51A4jdb8hZQFK5Na/aOG/Qc+btz7Jxwx1YMAAMHYNxhoi3GiY/YMGR3ySJw8jY6srRsZvHIUJtgdCZo1uOK+CMqCqGFV/wfsdF4bDRykqkIXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829174; c=relaxed/simple;
	bh=XnQwEjUYkDC+FVF7uOdWyQY2HEJi5umGza2+J08VCEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Sy1bpa3elQsAiqjb7xAB3cmAFdmOcObu4Z6jSR1MOVor1K8BDo6Dg3dKElQtrgsnvnffTI5WIKdEJSxBeUHzLcrVWRYcmS1DOrakeLxXrB6iA9Yk5Xy+/Ckn9KHYgv7mYNaAUbo5EAYvUx7C1P2G02kq0wokh5Wl8E3/8WQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTFlmxhe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTFlmxhe"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aad8123335so102655ad.1
        for <iommu@lists.linux.dev>; Wed, 11 Feb 2026 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770829172; x=1771433972; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bAMSBrvK4JW2RP64mGnR+pd6rmCnSQHvODMr9ePslO4=;
        b=GTFlmxhe2OKjQDSu7efAZLAC3ftu+3uT6tjJJQiG8y2+xhVCd1zUMMtfMJY11kk6ca
         jQegIAC6GxbB+m1MKXAm7ftSV0xhm9tTfCmV5x4N1WInYabhqmWFQ+7v3JzRgNt7G1x+
         Lb0GQWu/ayD/ILIt2QCiCzz6cwAt2qYcKZpTMQRQ8z1buP4VKlYUvwiQXltfAU2SENZJ
         xdnrnzssiFE/1EFRW0cKR0sULENDZ+Aur1J4Zt+Pw8g6DiWO0blAtsM4nFLuGmpfEGM/
         3+GbYD3Rb6hCrrNId4/CVdco5ttZNIEZ2IhjE0xGuUXVscdNFRnLZ1r7DhBU9VSGS8vJ
         +TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829172; x=1771433972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAMSBrvK4JW2RP64mGnR+pd6rmCnSQHvODMr9ePslO4=;
        b=VrjhF3H6o/Ye1UCA6xsB4+sHABaSbGdVr/wd5SPpp+qWILHdYQVg8s8304BdDySHLr
         KqlR5mqVrSt+quQhOTziiBkhk6yVTccg+PgDIpljKRXIVtLwIRz+5G2kL5C7CQ1J4aY6
         KEBX2tNBnOLoejodzoTQl+lcfbCfzcDNnrIILomxs+H1YQXvkIe5lbWIAV/mxrNWk8D0
         o4cIR0eRDZYgKECeDXGgnlCHgAsuW+TuIgIWGu4R6cbc5rv8LycR4N3xfOazAO62U2ke
         4m8qZikKWLO9qN591iM637vMI7niLr2RbY+AgbnYnAfnuZ7WXCOxqfNzPwMH7UXmHezF
         sihQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvg+cstwpx6pDcQNhgYQeJDZ+QS5NMnMrH1FQi5DEg505bUj3NIDfrW9bd/7EeTZTNpHWWwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxbxx8AzR5Bjwz6Guj5prwuSZkb6ykIJ3gMh/DgbaBhN3Jy8VMR
	Oq+7oN2FH8SaZF6sBpQEBBtA0vwqmS3PQn3SpaETzV4rmf2JwZOFwebbR5/0YYACDg==
X-Gm-Gg: AZuq6aIqdz3QVA4/Jm64EcFg/zEPZ1F70irv6/4s5kvly/Tw8m8abYAzeMftySjLrJU
	WKjLqQuXhIkJlZLqaCuDMVr2T0eiwautvl77nNEN9M0VUH8JQQSWJ/Yzhbanp9tZGDh02KGZs7A
	YyIq9qiz0079adD9ZF0tATyLH9JbxQO6uK4lfapsjMdNw98qvsjYUhWZfmg8MzU2ywxhYuyr78o
	IgQP8ecv37LexxbYyVo9mNCGgX0sKWvMVIEUOVQsHorXaqfJtFJamT7Qt5wpS4h0LSdjXLqi77H
	MB7EKqaEYvt27gI17XT1iMnLH42Mt3MJcrku3OAYoJ8B6aM0dHQcRCzK7E+PWSyuntfSd+ZlSyD
	wWo2/7DrI5hpXc1Jf9Sjg/D6onkx6EVugxZQlN773V3cPM88TcmsEBVVBkpK7t5NT2zIRHAPPNP
	xymvPA0ojS5jJlhaBsGBrZzrOWFdYKkrt32F+q+oxck1p6gIJZ06s7827OXqSr
X-Received: by 2002:a17:903:4765:b0:2a7:7ca1:8622 with SMTP id d9443c01a7336-2ab2967a7camr2352955ad.11.1770829171698;
        Wed, 11 Feb 2026 08:59:31 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63besm2542439a12.16.2026.02.11.08.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:59:31 -0800 (PST)
Date: Wed, 11 Feb 2026 16:59:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <aYy1bmorEGWhduHU@google.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
 <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
 <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com>
 <aYEFop8CJiLYzhLw@google.com>
 <7720d215-9f92-4f0f-83af-c992e1cbe531@oss.qualcomm.com>
 <aYsvacmKoLroXlrZ@google.com>
 <53c051f3-3a72-4d8d-917e-3b9d1537443e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53c051f3-3a72-4d8d-917e-3b9d1537443e@oss.qualcomm.com>

On Wed, Feb 11, 2026 at 09:40:29PM +0530, Prakash Gupta wrote:
> 
> 
> On 2/10/2026 6:45 PM, Pranjal Shrivastava wrote:
> > On Tue, Feb 10, 2026 at 04:39:56PM +0530, Prakash Gupta wrote:
> >>
> >>
> >> On 2/3/2026 1:44 AM, Pranjal Shrivastava wrote:
> >>> On Wed, Jan 28, 2026 at 06:44:35PM +0000, Robin Murphy wrote:
> >>>> [ +Pranjal as this might matter for v3 too... ]
> >>>>
> >>>
> >>> Hi Robin,
> >>>
> >>> To weigh in from the arm-smmu-v3 side, we’ve attempted to address the
> >>> "can of worms" regarding power races by leaning on these differences:
> >>>
> >>>  - Threaded IRQs for PRI/Events: In the recent series[1], the PRI and
> >>>    event handlers are fully threaded. This allows us to call 
> >>>    arm_smmu_rpm_get() safely, as the handler can sleep while waiting for
> >>>    the hardware to resume.
> >>>
> >>>  - GERROR Handling: Since GERROR remains a hard IRQ, we handle any
> >>>    pending gerrors in the suspend callback before the SMMU actually
> >>>    powers down. Any GERROR interrupts received while the device was
> >>>    suspended are treated as spurious and ignored.
> >>>
> >>> Thanks,
> >>> Praan
> >>
> >> [1] refer to case where SMMU state is not retained during smmu device
> >> power down, this I think is equally applicable for both context and
> >> global faults.
> >>
> >> Since the ARM SMMU runtime resume triggers a device reset, any pending
> >> faults would be cleared during resume. Here the solution can be to
> >> handle both global and context faults before allowing the SMMU device to
> >> suspend.
> >> With this approach, any hard or threaded IRQ scheduled after the SMMU
> >> device has suspended can be safely ignored.
> >> One concern I see is iommu fault reporting to clients while handling
> >> fault during smmu device suspend.
> > 
> > I believe by the time we've reached suspend it's safe to assume that all
> > clients have been suspended. Thus, we could simply not report the error
> > and instead scream by having a dev_warn_ratelimited about the situation.
> > 
> 
> By reporting error I meant reporting the error to client with
> report_iommu_fault(). I agree that if smmu device is being suspended the
> dma devices should have suspended by now. If so, it should be safe to
> just handle the fault excluding report_iommu_fault() in suspend path and
> complete smmu device suspend. Will update in next patchset.
> 

Yes, that's what I meant, since the client is likely suspended, we can't
call report_iommu_fault() because the client might've registered a
handler which touches some MMIO (accesses registers) while the client
is suspended. Thus, if we see a fault during suspend, we could
potentially log it at an appropriate level and not call
report_iommu_fault()..

Thanks,
Praan

> > 
> >>
> >> Thanks,
> >> Prakash
> >>
> >> [1] https://lore.kernel.org/all/20260126151157.3418145-9-praan@google.com/
> >>
> 
