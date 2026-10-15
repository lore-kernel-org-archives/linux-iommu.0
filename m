Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6C39D6E7
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079553; cv=none; b=AjgmuauO8N7quBAZteFOKcKpV3sZqS8ERuB0AdNnCu30G7uW4BXE1ZUx9nmyL/12lxqeJV2SnnjhsUV/RgwB1izLH+1Lomx5IDIIfP6Pucp846QALXm2z97RPh0LXtQlWQG+9EPxj/9MioTWP+fiyHVswxI/6uy1wV+1vbezupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079553; c=relaxed/simple;
	bh=8+TCZ/zrpvva3iiL9OUxATXfSB4Da998tMTbnuEx5QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s75D4YNQr0PivAByxQyMCea0PzIxVytitmNlezgcp5Zlmp2UE6gxO5+a+S59IBBqkXGyluDCQxgXjoygqaaCixfSMIFHnFeY0SHs6IuymkM7vL96OAGRtr7iDKWAlJw++7zIUNSoWG2JNTojQT55/DN7Q6RuQkjnniR4QhGUDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHUfqk//; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHUfqk//"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so20453025e9.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792079541; x=1792684341; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHZqp2tUL+jR2ac8WD4oADqX9Z4sM0KD+dcaF1HV3NU=;
        b=AHUfqk//nw3MXf5G5w1ki3SA2JZL33Uv+Stf9zrsl2OE5Odltrso8OsRiWsg4sPpPi
         2MK/MCPiX9d+bJaVJ66BP4C0IEDqeFEUmn8s19UeTYpc1hARbqKeWiwKF9TnPwQ2TLje
         H5rvAUSNncm1JXfnof26MXNBIqyulxS7U+mdVUDip75iC80jIHn3VSbjTC1+zjB9g+MA
         8dcjKQLzRUF9VsgqsTrB7d96ZCk72pAuVZSAtMHr/7H4l0qFQEPkDQ/qkwl3AosjOkP7
         YnMb5rRKAWxGIAN3DpMu5W6CkVFCdrF6Y4LFa3WNlo0KcvRGPhUyGE8WWkUPO34XVTNP
         Yg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079541; x=1792684341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHZqp2tUL+jR2ac8WD4oADqX9Z4sM0KD+dcaF1HV3NU=;
        b=oYAXiycSQRvOe4xXySbxXdx2gVzYYaN4crE45igY5qCGafZL3gJagHNzy+IZWmYyxp
         Uy2xomh6n10C9mqRZUbUgdoCJ6pLE4xqZcrJKDp3ybX0aR+nFEdTEDP0lil0QTDu65mb
         6DRBLMAnn7Ge50vhYzwr+cofHQmfKbE+Hni0///ut0sK4iDIlzrjBgfmwmDSKiXbcAc2
         TKsyDK+hO6ndkSgtjgs4Uw3q84ipTQMRXzIi1syy42Bv/1O3HoXmOVr3YGBt1qZkqeME
         l2HYvu1kXeDWnjV7j27U9RhklqxTFlZZ2xk+OfxTttbPsD3q/7U0NUbQSGxWdGU6iXOG
         q58Q==
X-Forwarded-Encrypted: i=1; AKwUvBzG1U2wXxc47Rus+o8evZ3TRZ/lLjln7Uv5W8OV+lQY3uXtTJiO3/TLd4lWoIqyoa7t352jYA==@lists.linux.dev
X-Gm-Message-State: AFq9FYID7cpr6cMA7AwOD7q/ieJAPBwdk3PvN17VWDWsK5mkUpdxSNQK
	lmd4ZHSKTOU46pV/dfxrwpnPUwGcSqmEf4NZi2ioAg+pg+GUv7GENmhL
X-Gm-Gg: AYBFou3uDT7wH4vEG1rHVxNjmYK6Tbp2ZywHOWticxf1s9uI2lQxCCIbhrbmGcbHXAK
	TOeW7GxTqA7zExAXhlnExEjtMNaUTWx8tSjVQCFW6CZOXjmEaHCwHJWpF52VvAPLgqPX/+fthuH
	Wre2eq12+hBGSuGnJpVXi0P86f0tekUn86PFe7LTU1iGPhPXzGo9rvhczLEA4+wrFbWRX5jsG6A
	RZJOa6XeVqBk5XwmNtRutkqhaeWvq3oFqbz7ooLGeCUUaAa+mdCDVMLyhLiWxijJ/TfzYXTHI80
	mXieT4zFdC4nRIQ0LqtTyw87fXdeordMkWPjEcMiPvFnq3vIXHoqQ43b1gqGMOZLgL0JwyCKdtX
	VhUGkLhQ0vhFZeiVv4aYhUaN4guyNjpTjOjnRrzRXHNdRKY6FQ/R0/4C2s1BccETTZXBiLQKgvz
	SgJJZ4P1HUOXbag9FhNuE9YEEozG992N6wQmaWB9o8YDLMwVrsoNbzE7njEqUjmEUXcdiTYwbwW
	oqImWiZf0h5FQ7n5WyTlmzf2YvX4nZuP3xsh4GqXPlDGQ==
X-Received: by 2002:a05:600c:620b:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-4a18e4d12e7mr366480965e9.31.1792079540501;
        Thu, 15 Oct 2026 08:52:20 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd993caesm157053315e9.12.2026.10.15.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:52:20 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] iommufd/iova_bitmap: Clip recorded ranges to the bitmap
Date: Thu, 15 Oct 2026 17:52:13 +0200
Message-ID: <20261015155214.472218-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015002647.GA3575173@nvidia.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com> <20260925161142.189813-2-parri.andrea@gmail.com> <20261015002647.GA3575173@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 09:26:47PM -0300, Jason Gunthorpe wrote:
> If we silently truncate that to the range of the bitmap, like this
> does, then we also are silently lossing dirty marks. The userspace
> will call again with an iova range stepped ahead and instead of seeing
> the early blocks being dirty they will be marked as clean.

Right, the clip turns an overrun into silent dirty loss; failing the
call is better.

I also saw your reply to Samarth's record_dirty() patch [1]: with both
changes, a dirty entry that is not wholly inside the bitmap fails the
call.  Samarth offered to send a v2 of both patches; I'm happy to leave
1/4 to whichever of you prefers and rebase my tests on top.

A few things I'd like to check before I rework the rest:

1) The dirty bit is still cleared when the record fails.  In the
   record_dirty() you proposed, as in visit_dirty() in io-pgtable-arm,
   the entry is made clean unless IOMMU_DIRTY_NO_CLEAR, whatever
   iova_bitmap_set() did.  With start_va rounded down to the entry, a
   query that starts or ends inside a dirty huge IOPTE now fails this
   way too, and a retry with an aligned range sees the entry clean.  Is
   -EPROTO meant to be fatal for userspace (e.g. abort the migration),
   or should the clear be skipped once bitmap->err is set?

2) Could you point me at the patch that adds bitmap->err?  On mainline
   iommu_read_and_clear_dirty() ignores the return of
   iova_bitmap_for_each() and returns 0, so I assume that patch also
   changes this.  Does it cover the VFIO DMA logging path as well
   (vfio_device_log_read_and_clear(), with mlx5 and pds calling
   iova_bitmap_set())?

3) Patch 2 tests the clip, so with your change it fails: the 1M IOPTE
   at MOCK_APERTURE_START is rejected whole against the 128K query, and
   bitmap[0] stays clear.  I can respin it to expect EPROTO, keep the
   guard check past the bitmap, and add a query that starts inside the
   IOPTE, on top of the bitmap->err patch.

Patches 3 and 4 still apply, I think: iova = 0 with length = 0 passes
iommufd_check_iova_range(), and __iommu_read_and_clear_dirty() then
walks [0, ULONG_MAX].  With your check nothing gets recorded, but the
dirty bits it walks over are still cleared.

[1] https://lore.kernel.org/all/20261015003412.GA13920@nvidia.com/

Thanks,
  Andrea
