Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464531C861E
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076273; cv=none; b=detQdS4+GBTSC/xl1AgIt/VCtPFmsOjCPV2ewGX00wboVbr+EoLeTcWOMPnqet2B+HN/uTI4lMlNoP7QER/00Pw+EYwcAboWyLvv9l+XEJA1o7Cdi85QXceNfVFlXb1kpCiE9SeBa3F7WqGoaWOBtMHbWLrqLgsUusuBHol2CKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076273; c=relaxed/simple;
	bh=4NsQQGoXB+8CIU5r5rG+dVQijR7Ntu1nN5FG2RuMAzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIvCLG460d0vQDpP8wVywL6X2UzloNzPKjcwtSCtfcs37vIfCOA8Q1mPoc+dd4IGcijbITsmYHDxX3kZEVt6Qchb9KdunUzgrkf4QaOUWNpOnL82baA30VjtBHwo5Yj6ZrnGW7osx1Gf/VSCPoOvaGmHNdsB2r0Rf671/R3LYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvevNIi1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvevNIi1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23dd9ae5aacso175465ad.1
        for <iommu@lists.linux.dev>; Wed, 09 Jul 2025 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752076271; x=1752681071; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bk2Xq0RnuBxeFm4d5rMpKxLaUaglZ4i8wuuvA4Eo7g4=;
        b=wvevNIi1CgDIEhxSe77dqwXLBm8m4/nAiW3Lb+LN3XDc9B6fEe/+9rQKnMQW9EPYKy
         GBRVuiR693rKjVNuXHMHcw/Flf+5OwfuowYu1T3KdzYJdN7kOSO5vkCMckoCHKZIb3P5
         gwaRaHL3pSFWaeVnRKzimSEgoqyBTioFBiAhn5Eo0A4AfFzPAcRjPkL3NSJHKSzeJcqF
         QTWOnox2Ez5CH4ctuOgAVVN08lKMRNi2b3ppodn1PttN3WWrNXIw4TYDRK5+mWMHbtza
         /1iOgY6ea/viwkU3brnPjVP9VRAdHFw1mpin3DTb4iYwduiXL/7oeRlaIJMOvpWk7Nvl
         MhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076271; x=1752681071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk2Xq0RnuBxeFm4d5rMpKxLaUaglZ4i8wuuvA4Eo7g4=;
        b=ARTnE4GTn3JVg+vGMXbUf4/71t6Cr3VIEZn0LfLqL8EDNcdF/F+hj1jkhICkEXA97t
         3Px0pl/rKp+kYBTwhxtMs9mSp5HB94u7RpWAlKK59AycrcQT/tbPivHF8WzhZIKRoV4x
         XvgjiqgEcifE4NnLEt37KOrj9oNVXaBcVris1G+wMyaAcD+fcFBSz7sbE2V/m/lLUsuX
         qG6hLPGRESo+99qTiUDIEkEx3xkS3dBijBfwhE7YinfXU6xuxDgiVn3uIK6A6it5LJGd
         zIgLV82OZTSWq4hejvHzrRhNPEQ1PYR7JVq0N5vEbw0n7jkms8akqbjE0yIP0i+6qRDA
         iVVw==
X-Forwarded-Encrypted: i=1; AJvYcCWKYygdzlZJGZOl2q9bm7BT6isNgBiEVP83wjCWwUAqSMLIfV8JVPqe5mPH43Was1cczvbbIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7F1sokAjAgUXm0eipwXqKTB5HPwQIwasLmAi+U/6MqDH4z+ge
	NQk5dHtYl9KNx46HlKAXcFvCBP0AT1w5qruFWEgMFKT9D2fq870F7Tf7lqB7yAjSBg==
X-Gm-Gg: ASbGncudwdh0JKzRzgP+9959kVsoF8KMBp/mYHcACRkYzqYAkAqAIHsGaEr41a/vGsr
	Mr513EdJ38FahH820sM+IdCk9qhH65spBAn0bdGl7nAnBFBLPCGUTkpL6i/ISQLpV0NCQvdMdc0
	UUQoA/uxwrUAXTHra9jdXGExnkvFTe+XtuSNh4vsVOYYFoijCdBLkV9mTtkFLrWAzd79iKvfBtA
	/fy6S3keWxiYz4gP4qPLPljQ9b97Ei5DRJK4DHA332Itp1Yse8DCK8QI4AWr5oJ09PFNiQdntTa
	D2ghn127DTOd14K2NEA5EO795RzSbaHIDEvIuWi0Qlz+PP/1Xf7FdtExCjJkmrmA3EyISppaZd7
	rAuYrBQNIbBjpTBGPHRyO
X-Google-Smtp-Source: AGHT+IFwDh8x1kT+QWjCV9g+gZRFQac+2L+jdLN0eorJGSJLxLyUeLU0XqvQDHdm4WXIUiSxaTHToQ==
X-Received: by 2002:a17:903:1103:b0:223:ff93:322f with SMTP id d9443c01a7336-23dda3a7517mr3583765ad.2.1752076271247;
        Wed, 09 Jul 2025 08:51:11 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d69f8sm15518945b3a.179.2025.07.09.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:51:10 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:51:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aG6P6F-MEvL4SfNz@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-6-praan@google.com>
 <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jq7DL4z+q5XKcVUZQgojcxA8DgrMFncs1Z6skm+PVEmA@mail.gmail.com>

On Wed, Jul 09, 2025 at 08:44:06AM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 10:32 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > The existing opportunistic helpers like pm_runtime_get_if_active() and
> > pm_runtime_get_if_in_use(), are too strict for certain use cases. They
> > fail if the device is in a transient state like RPM_SUSPENDING, which
> > can lead to drivers making incorrect assumptions about the dev's state.
> >
> > These helpers don't suffice for cases where one wishes to elide HW clean
> > up like queue flushes or TLB invalidations if the device is powered off.
> > It is wasteful to wake up the device in cases where the resume callback
> > resets the device well OR if the HW resets in a clean state. Thus, if a
>ppy to hear your feedback or any alternative ideas you might have > device is powered off, it is preferred to elide any clean-up HW ops like
> > queue flushes / TLB invalidations when the device will resume afresh.
> >
> > Consider the following sequence of operations:
> >
> > 1. The device is in `RPM_SUSPENDING` state
> > 2. The driver calls pm_runtime_get_if_active/in_use
> > 3. Depending on these API, the driver elides a HW clean-up op like:
> >
> > if (pm_runtime_get_if_in_active(dev))
> >         invalidate_tlb(dev);
> > else
> >         // Skip flush, assuming device will fully suspend
> >
> > 4. Now, another rpm dev-linked device wakes up, causing the device's
> >    state to bounce from RPM_SUSPENDING to RPM_ACTIVE without invoking
> >    any rpm callbacks, preventing them from resetting the dev correctly.
> 
> This never happens.
> 
> If the status is RPM_SUSPENDING, the runtime suspend callback will be invoked.

Ack, I believe we're talking about the check[1] in rpm_resume here:

	if (dev->power.runtime_status == RPM_RESUMING ||
	    dev->power.runtime_status == RPM_SUSPENDING) {

	    [...]
	    /* Wait for the operation carried out in parallel with us. */
	    [...]
	    finish_wait(&dev->power.wait_queue, &wait);
	    goto repeat;

However, my worry is about the following situation:

  rpm_suspend			   rpm_resume

  rpm_status = RPM_SUSPENDING 	
  				   if (RPM_SUSPENDING)
				   prepare_to wait(...)

  // suspend fails
  retval = rpm_callback(...);
  goto fail;
  [...]
fail:
  rpm_status = RPM_ACTIVE;
  				   finish_wait(...);
				   goto repeat;
				   repeat:
				   if (rpm_status == RPM_ACTIVE) {
					retval = 1;
					goto out;
				   }
				out:
				   [ ... ] // put_parent if one

				   // we return without resume cb();
				   return retval;

Now, if we rely on APIs based on pm_runtime_get_conditional(), which
might return 0 if (dev->power.runtime_status != RPM_ACTIVE), we might
end up eliding some TLB invalidations in the period where the status was
RPM_SUSPENDING till it's back to RPM_ACTIVE due to a failed suspend.
This can cause some severe address-aliasing/ghost hit issues since the
TLB still has some stale entries..

Instead, we'd like to ensure that the status IS suspended to make a
decision to elide the TLBI or not.

What are your thoughts on this? I'm open to approaching it differently.
Happy to hear your feedback or any alternative ideas you might have

Thanks
Praan

[1] https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/base/power/runtime.c#L808 
