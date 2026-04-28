Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430543634E
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380706; cv=none; b=hpM5uJDc2kgiEvBJRutQ/ckgtWYWaxFR75f43WQqufbH+9r2kLgvS0q0u2kIoiFnL79KyEdSumolJaKd1Iu0EVfUJESkYNXTwsiDYV1tM7FslXUsA4mykyf0UmHv33AU/C+qzUYZbvsrHfoV6M7O7MoGvUYsjkNaT/g4KcCP/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380706; c=relaxed/simple;
	bh=4XG+PCIQwOJKk8xLMKdZNztwTknX7CtucvqG+I9Ex+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=czRERZJL1HZGNoJu6ZDaf/qyFHpFqun3myXuI4jOHW21AW3TG/loe8o9NvTyqhCnpNvYG0qmlDDAVzmHwviYX+Qo2gmDMVKPNGvgnSV6c9XNdLF3RCDJbXW7xWWYvBdn5kMkszVqZTRWcbMV1r/SmAhLZwfF+p56oLizV4nQa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cev3lXfT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cev3lXfT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f220f1dabso8402091b3a.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777380701; x=1777985501; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0A//i6lW9ZgX8m7SfE0ctPZGZR9MtJ/Dk2v1dp0dCk=;
        b=cev3lXfTPYNPi4BYJJyLvsMwopz6GUN+P62KTN2bUPdBmMfnekgR+ZJOCIERAbyaER
         9mJfSZLFadKfUPkNb9w8bgD2CGV+0oU1gs4sJsI4jxk00Z4D4C7b0M7QDsiB+RKiahGZ
         tPU+nwgj944W9+/58YDb5we/Yr5/K8NkVNmtc6qxsUkFmysCVNYeCH+AlgedKpVILWuj
         8+xzXtwbuq2fU6VZtvJm4CmPqcYW6CmQI+Ad/hEarTRk7O9x+RxV2yGWDQBFJLxwf5uB
         lwK3jY1o8wkGyT+RxB22ISOov8I+LXh2hO3H7ckeW3sfQX1s3D+eHo0uCzGqVOCmIol9
         /p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380701; x=1777985501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0A//i6lW9ZgX8m7SfE0ctPZGZR9MtJ/Dk2v1dp0dCk=;
        b=FpmEj9msDt9qjEcjxdVZkHGLzuLa6lTSeF+46ECo8keYbhK/0FdOHhSGuc0LWALk5L
         H1rxdC+fY0F4rQRadix8zKvBJsUOR5pMhN4iYKb9CWvhZr+m5LAaGpfE1HzSdOa7Krj/
         boFQ6XU9E9GfKbtPavptqxnS++3c5AehlPXlCwIZqIhxoXsoZV3zVRqaqFmoZq0GXkdA
         qdu5APechhDHWqEQ/XXDlTA9+UNQIFKysZ9Hqnx2BVJfPq4GPE/LhItviVFrmchycKhL
         Xv80z07M4T7UVIqvbQTdEnQUd8+nVbfz/kE8KLx0Vj7FspPKSbBqvaRI0vbt84pKqpO2
         dz8A==
X-Forwarded-Encrypted: i=1; AFNElJ/SZlPRCZQjfkF1IUiDyyNWFEn6gK6mCWSm/2jBn3nLyPycwN1xVou/5i93/aqiQB9BQbW5KA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHW4TI/AqCs8kWZ/rXZYcFXcpIoeqZSdiYsmJ367/LqJA9o+wM
	fOCLKzjpbebUypay5s4cuTXilswrOx10IwtcBYHWxy/ABH+myUqdDZirCZH1j9pOKFWxtemWo2b
	oWFoHbGV6QxRNvT3w5rRqHvAKIA==
X-Received: from pfna24.prod.google.com ([2002:aa7:80d8:0:b0:82f:5576:285b])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d8e:b0:82c:9897:70ef with SMTP id d2e1a72fcca58-834ddb9b440mr3026357b3a.27.1777380700900;
 Tue, 28 Apr 2026 05:51:40 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:51:39 +0000
In-Reply-To: <d860b6a9-e4a9-494f-821d-8b0a347e1591@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <d860b6a9-e4a9-494f-821d-8b0a347e1591@arm.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428125139.1627369-1-joonwonkang@google.com>
Subject: Re: [QUESTION] Is the ARM SMMU v3 implementation designed to always
 ignore SSID when SSID_VALID == 0?
From: Joonwon Kang <joonwonkang@google.com>
To: robin.murphy@arm.com
Cc: baolu.lu@linux.intel.com, cychu@google.com, hhchung@google.com, 
	iommu@lists.linux.dev, jgg@ziepe.ca, joonwonkang@google.com, joro@8bytes.org, 
	jpb@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stimim@google.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

> On 28/04/2026 12:14 pm, Joonwon Kang wrote:
> > Thanks for your prompt and insightful answer!
> > 
> >> Hi,
> >>
> >> On Tue, Apr 28, 2026 at 07:38:59AM +0000, Joonwon Kang wrote:
> >>> Hi team,
> >>>
> >>> According to the ARM SMMU v3 spec, I believe that SSID should always be
> >>> ignored when SSID_VALID == 0 and the current ARM SMMU v3 module
> >>> implementation in the kernel seems to comply with this without exception.
> >>> For example, when handling an event from SMMU, the implementation checks
> >>> SSID_VALID(SSV) first and ignores SSID accordingly. If there is any
> >>> exception to this rule, I believe it is a bug.
> >>
> >> Indeed
> > 
> > Acknowledged.
> > 
> >>
> >>> Is it true for all the current and future cases? In other words, is it
> >>> **mandatory** that the ARM SMMU v3 implementation ignores SSID when
> >>> SSID_VALID == 0? or there might be some cases where the implementation
> >>> needs to refer to SSID even when SSID_VALID == 0?
> >>>
> >>> Asking this question since our HW may not be able to clear SSID when
> >>> SSID_VALID == 0 and so there might be some garbage value in SSID at some
> >>> point of time(the HW will have a correct SSID when SSID_VALID == 1,
> >>> though). If the ARM SMMU v3 implementation is to refer to that garbage
> >>> value for any reason, the result would be devastating.
> >>
> >> At least according to the architecture, SubstreamID is ignored when SSV=0.
> >> The SMMU is allowed to propagate the garbage:
> >>
> >>    7.3 Event record
> >>
> >>    * SSV: The SubstreamID validity flag
> >>      - 0: No SubstreamID was provided with the transaction and the SubstreamID field is UNKNOWN.
> >>
> >> But the driver will ignore it.
> >>
> >> Same for PRI queue but in that case the page request wouldn't have a PASID
> >> TLP prefix.
> > 
> > Although the PRI request without PASID may cause unpleasant ATC flush with
> > SSV clear in this case, it does not lead to the implementation referring
> > to the garbage SSID. Is this understanding correct? And while this case
> > seems to be handled solely by the ARM SMMU v3 implementation, do you see
> > if there is additional care required on our device driver for this?
> 
> A transaction with SSV==0 does not have a SubstreamID, therefore by 
> definition there is nothing that an SMMU could validly attempt to do 
> with a SubstreamID that does not exist. Sure, implementations can have 
> bugs, but I'd expect any such bug in this regard should be sufficiently 
> obvious that it most likely wouldn't get past architectural validation 
> in the first place.
> 

It makes a lot of sense.

> If you want to know the exact behaviour of Arm's implementations then 
> you're best off asking Arm support, but since this piqued my curiosity 
> too, I can save you the trouble - I checked with my contacts on the 
> design team, and indeed our SMMUs should ignore the SSID value entirely 
> when SSV==0 and just treat it as 0 (e.g. in event records).

Thank you very much for saving me the effort and confirming this. I also
acknowledge that it will be best to ask the Arm support with regards to
the exact behavior of Arm's implementation. 

Thanks,
Joonwon Kang
