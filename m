Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17346C4A9
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439957; cv=none; b=r8b6KEcdy9j2stDfsuCgLfKYxyohuRbX9lPKSsYGXxc3TJZgZC0vhw8UZczllynZWmFrPQPxDoF3JbSDpRsek1uDSBowSoUCaAf+abyN2mzqFPpAYyINLOJuSVo9lf8/sIgI9calDl2wTUDja7cn/MZ/KEBl6X72gDw1lZnN64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439957; c=relaxed/simple;
	bh=FVAkC+7LmP1MK7FCjI0hOZYPokCItuic/3GUX2deHnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8BrKMpv30XpX7uAJGRiKnzHzTefU8RsLkJvgnAlt0QMns7nGgU00oZwVMqNC8KBM8mdTa9lHe2MBF82GDx40hiAGbpZNmcPLGslUkq9n+o/rk+fiCRUivAvSCbH6NZjthZi/CA/xJBkNMBVNj68cIvOB1NnUWi4WCduMB/59Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUvLVpNj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUvLVpNj"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848593533cbso197049b3a.3
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785439955; x=1786044755; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaufhRrPIIlGU9PSko9eDMbVVZpm59g+vXiWTKqYEnk=;
        b=FUvLVpNjoTn5ruVGMVG/8z7LzVHmJCTc+xBXAYczMSQihQU4UIUgjcG5mT0mCFEWE6
         rcJd13hx+mJE2ZT4zGpHVP7swavHEkeZDsj89WFRTJKM/NUdl+1TlQx2ICU+w8W1hDYe
         raGRKYDLfiEaCjW2mIiPmG3tkENMFxy5/lcArLNaemFUOGrwamrDT7KyI3Z3EUu1XTX+
         rWdqX1fl0zOfkvmMnUNKrRRQm0vZzTneEb4fgRTz81j26tiWH847peDTIdELGOS4wpPm
         d1htbyDDrFi+niO6clImBBJtG1hFTJUQkf5xK9ZnJtsh3eWPyPwnpcTk0hmxYaZ1Ii0b
         M/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439955; x=1786044755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaufhRrPIIlGU9PSko9eDMbVVZpm59g+vXiWTKqYEnk=;
        b=Xe4vks1VpScgfTjNEfBvpRwiz7/g5DdcQVtvZo7MSl8nmUWPbqnchiHpUEv+7kLGaJ
         cIIDu8F6u08KUvLSU0XJqFiqrb3OiH55c7+DHySYFggsBJ/4Gsr19IHmOeKmYTEcT7+3
         3eeG06E/F/zrg0Zg6sZkpDX8wRYDKvxSRr3t8hI6kZWiQ/mFgyew9udBT5i89OxQVLLZ
         uXNiDMBeETF64Bvbawy/8d306WDqE0EQHALRwoe/HhhOoF/wYQ+FjObBJZtFde+ugr3T
         5all+ru7hQKvQltqRL5hwVj97HMmy2ly+i9UVPyAsuexaQnFU5Zu5B4peof61dDUanQZ
         XvsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmPC2olzObQ2x8izAJJrO0DJJml8cw6DSyTzFWZFLZoLhB4Econ3OcYAKgk1KtGJ0nwrthtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpWXinHrDE3nHF4U53l8Xm5pzOgVWiIANWcBDsULhMmIuwOqkB
	+J6fXtPw+Xo2wFzr5sdetXczohv7BRBsmKyDsMISqpTLmqNPvGRNm95W
X-Gm-Gg: AR+sD12f4M7sm1B60zraYvt3bUtgHHbQteC4WzeL2KPkiNhh+vvFP21imLgOO+MNB6s
	m/7Yym4qxLnAzdvuKWAWh2cb7eHVwPqM9cA5UWz0N+vrGVMpwkhxvvXSiBUwXTWoDFix0XaT8Dr
	Tsg3VnoDgWetRct1/FWufHdrZhoc/lmfdtBmUpibdA7S4KNmnuKbSNwLwUJ3Ij/xOzxTLW/Okt8
	ENYX9K1/MlDPz6PsbpbHyj3dqktAGutjmD4k5KbGTpwma8Oi1M36msOjX0k2LzEzKpbuEmNus8F
	UOfrm4cx3yqsK3sFNJoOfgpz0UaCgU1epzoGOPgNcHztMMvZCTPdePj7PwgRty1sCGXZ9nsaQVb
	NOPLdWB1IOxbWbG5JaJ+k6pgInOKwLDzAsaXV5ZeQBoXa/vlxizm21Cg4yOUJDYCyY4mbEhj+4s
	+5Aj3XlJfgurbn0hwKJvUKf7UQkhFU1ul2BrY8BcP88xRqBo7xDIMPmTKDLrVd
X-Received: by 2002:a05:6a00:c82:b0:84c:518b:d915 with SMTP id d2e1a72fcca58-84ebc4022b4mr3494498b3a.65.1785439954744;
        Thu, 30 Jul 2026 12:32:34 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe240acsm3526682b3a.7.2026.07.30.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:32:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 03:32:26 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: will@kernel.org, joro@8bytes.org, akpm@linux-foundation.org
Cc: robin.murphy@arm.com, nicolinc@nvidia.com, cychu@google.com,
	hhchung@google.com, amitamishra@google.com, marscheng@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, kpsingh@kernel.org, mattbobrowski@google.com,
	song@kernel.org, jolsa@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
	emil@etsalapatis.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] lib/sort: Clean up sort_nonatomic() and
 sort_r_nonatomic()
Message-ID: <amumyk_cHcffv9CC@google.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730181216.2709088-1-visitorckw@gmail.com>

+Cc maintainers/reviewers of kernel/trace/bpf_trace.c

On Thu, Jul 30, 2026 at 06:12:14PM +0000, Kuan-Wei Chiu wrote:
> Remove the sort_nonatomic() and sort_r_nonatomic() APIs from the kernel
> library.
> 
> Currently, the arm-smmu-v3 driver is the sole in-tree user of 
> sort_nonatomic(). Because the array size being sorted is small in

I just realized that I missed another in-tree user: sort_r_nonatomic()
is actually being used in kernel/trace/bpf_trace.c.

Looking at the bpf code, the array size there is bounded by
MAX_TRACING_MULTI_CNT, which is set to (1u << 20). I guess sorting an
array of this size in a single go could potentially cause scheduling
latency spikes on certain configurations if we don't yield the cpu.

Because of this, it seems my proposal to completely remove
sort_r_nonatomic() and sort_nonatomic() from the core library was
premature.

Please let me know if you think otherwise, or if there is any
alternative approach for check_dup_ids() that would allow us to safely
drop sort_r_nonatomic(). Otherwise, please disregard this series.

Regards,
Kuan-Wei

> practice, there is no real risk of triggering a soft lockup. Therefore,
> the periodic cond_resched() calls provided by the _nonatomic variant
> are unnecessary.
> 
> With the only in-tree user updated, the _nonatomic APIs are no longer
> needed anywhere in the kernel. Removing them effectively drops the
> wrapper function and eliminates the may_schedule branch from the
> innermost loop of the core sorting logic, slightly simplifying the code.
> 
> Kuan-Wei Chiu (2):
>   iommu/arm-smmu-v3: Replace sort_nonatomic() with sort()
>   Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
>  include/linux/sort.h                        |  11 --
>  lib/sort.c                                  | 110 ++++++--------------
>  3 files changed, 34 insertions(+), 93 deletions(-)
> 
> -- 
> 2.55.0.508.g3f0d502094-goog
> 
