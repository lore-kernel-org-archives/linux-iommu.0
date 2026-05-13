Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AF30DD1B
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691817; cv=none; b=djQjCLGEht46Pv3osWBXk58xg4kvJQz9yLObnGqS0Qcf4cqczan8G446ber1vqp3fkb/MIE29JPJY9mZshwTHn+JbvrR3FoWEn2QqzjaxFlzhT16j6PDSfECFVfBg/udB6G/8dGdf59DSxtW1c6Z4G75r52AXnlRp0zJKCHRz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691817; c=relaxed/simple;
	bh=CgWakxMq1PQlgdIp9azFXsj1Hh4Z/jvIAFgCTQdI11M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXwkgLRp887bNu3+8OuI15AWXagcxzmbOagMAiqOT6DR+cQA+BmOi2CTEHrpXvx6XZGLISchTSQ7V9nx5WtyexckLNM3tDTc41E7QH02hbVih7+FNitkZRCdGhtW4KRRadN1fCjX2vOQHtNCRVZ+zwM/Ur6m+mJOQrXYbqoTbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqYSgnnZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqYSgnnZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba718173d1so120950435ad.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778691815; x=1779296615; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWwRMJn4ysC40SZu5iEtoxx7CK76uQCrAvLKY0VkjCM=;
        b=qqYSgnnZ9hTPyFNzIz3lsm8jLtM/5lmSziHNtxLLXGRvll9nXFdkKsG3jtONx11Qn1
         9Dnl0kqbKrJkaeZkNxvy8zAzkLxPLt/oCbWRm+wIZoFybATS5DtZQPkjqdxdfSKImHZW
         vddbUnYrd39y3HzP6pePffx/CJ9ZfCWpM4bu7IG3lXWi+lHxOhu18se2/aBu7BfebGTj
         1w4ZmbYOj4bx9MVcwKRc1M1FQqUZE/DmepUP9b6M23YJbRVrCVDHNcPTDKvZ6wp44P9N
         BX7dVfEW4hYWFs7ZwH6InILiE0fvkAhNM1cZ61nMCycI5XITk2Fa5GxQLp5lqymDrHqe
         tX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691815; x=1779296615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWwRMJn4ysC40SZu5iEtoxx7CK76uQCrAvLKY0VkjCM=;
        b=JRmhH3uxsa36xhGGvO0/kODPiTovX3Yet/Tse1x3tsDW4UN7SaHgT5ynB8JwUyapOO
         +Ir0CNG71EiaFEELtQE0GGXB5orr1SKPSWxPHq4AvDkvzBbB2BOCDOmL6sDwaXPwgFuf
         ryu7tXUH2iWSBteZZzF81zbuCpQUICTstPyKppql/ctGzLZ61JgSYcjkPbgqdSfWbsXR
         R34bXsmtcxTPsBPDmr+9vDMYejE/Iz+dqLV9+woT1E9s1OHEfyNR6jOyZsuZKxdPmOs3
         OOEOBz11XFItNv225bH5wJ8mH2/QplbSOPTZ5rrAd3sbHaxkkY4s6mlMmVQaOL126Mli
         jS4A==
X-Forwarded-Encrypted: i=1; AFNElJ8tlBU5fA17De6YyFqWCP+oRpsvNJji4m4eAYYcj7l8PHLi6Csfq8UEe4Eply8WJzik3G/Ihw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOZWfdyRejQzObW6ACJFUV1udMoA1ZjotEEfTjorDwSq3J63zs
	L0rIcIhmoG2kzfgBsFqVU8Hdopw3NSuPQVI7EUhkM3I7FYvkKZ1cWuyBNY8Wpgj7deLtJK21Ass
	72k62FxnC0jgtjs39UwjiMnabSw==
X-Received: from plbkf6.prod.google.com ([2002:a17:903:5c6:b0:2b9:53bb:4a09])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:46c4:b0:2bd:2de3:51ad with SMTP id d9443c01a7336-2bd3043ca95mr42686725ad.34.1778691814901;
 Wed, 13 May 2026 10:03:34 -0700 (PDT)
Date: Wed, 13 May 2026 17:03:33 +0000
In-Reply-To: <20260512151133.GD7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260512151133.GD7702@ziepe.ca>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513170333.1235601-1-joonwonkang@google.com>
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com, 
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, joonwonkang@google.com, 
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org, kevin.tian@intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, praan@google.com, robin.murphy@arm.com, 
	smostafa@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Tue, May 12, 2026 at 02:51:38PM +0000, Joonwon Kang wrote:
> 
> > Appreciate all your clarifications here. So, my understanding is that if
> > our system does not support ST64BV and ST64BV0 or if our device does not
> > distinguish between the posted write and the non-posted write regarding
> > PASID, then we can lift the use of the global PASID space. Can I say this?
> 
> You should do what Robin said - just have your driver use a per-device
> PASID that it allocates and never use the global pasid allocator.
> 
> To do this lightly re-organize the SVA code so the driver can supply
> its own PASID, and in this mode we wouldn't activate the ENQCMD
> features in the mm.

Ah, we could actively disallow EL0 to execute ENQCMD-like instructions
when the device driver explicitly shows the intention via a new API like
`iommu_sva_bind_device_pasid()` that Tian mentioned earlier. And the new
API only uses the per-device PASID space. It makes a lot of sense. It also
means that ENQCMD-like instructions are only allowed when the PASID is
allocated from the global PASID space.

If a process communicates with only one device with the PASID allocated
from the per-device PASID space, however, there should be no blocker for
the process to execute ENQCMD-like instructions, technically speaking. In
this case, should we allow the process to execute them? and later if the
process tries to allocate another PASID for another device, should we
disallow the instruction execution then? I guess this way may complicate
the implementation without much benefit, though.

To allocate a per-device PASID, I think we should do it using
`dev->iommu_group->pasid_array` instead of making the device driver
create its own PASID set since all the devices in the same `iommu_group`
are supposed to share the same PASID space.

Will create a new patch with the establishment so far.

Thanks,
Joonwon Kang
