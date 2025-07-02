Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8330AABA
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468020; cv=none; b=hILZYsZgIrlQ6QCzv4vaFMvIpDbJWiq8SZaBav5wSsY6Hxxr26Fh8W76nilqT0efFI7Z6mqN5nSQiz4qyft+EBPil+uHEwTBF71H/+ETcyUIPMhVJzX2Y8w+oHnDe48AMkyE2JYx2YOmdBFXKes0O2LMW2iyy1qnUy5wVXoeq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468020; c=relaxed/simple;
	bh=beP7drDYJiC2bUAZWTxtY2Y/4PtwO1+nbUvqiOO5/vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7aqPUc3SMpEbAIi6aW88qOCs9RUVNI677edvKUgDlt9bE1W708Ya9R/RHgE1czzMK8FWCssQ2lwoX49XPuqGEsFhwRyGqCYXOqO1aPs7CgKjIFtFztdPf9+28YVROUh2P0UWzOZph1ADrBMOOum1QzVuSl3LZNt1Im0xDV36U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKRX/Mxu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKRX/Mxu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so7156027a12.0
        for <iommu@lists.linux.dev>; Wed, 02 Jul 2025 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468017; x=1752072817; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPM1T2LNHQfKhij9F/iyvK/25eoDUaIBSajpXKOmcoE=;
        b=MKRX/MxuvqgetKuXvZAvtRODEpJxY3/R9ouFWAMe4NAbVUPrItGMJoPQGSh5dyGYDt
         i7VtCnSQeb8X/7neFmJnR0vBesYimm4k/Czn2teC5lis9UeGIRvU2DvcUyp1OQv6VY8E
         ktzBWOT27Wh4TdBe6Iy++caQOVZnd+azmVjOAcBEb6ZPIjZeG52GkB71zqCPs64FlcZ/
         LnWVGuxit+KOV5aH599QRuixIXwJhbDzIe/UDcIVpjA3xlSQ0jksHX9XYEMadKMPcMWF
         ZT2IibH2vog3fV19VbIrs6ZykNHojP8yI42VH8HCBQGgFO6dZu2PjwWVAMg4Ijbp120h
         0WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468017; x=1752072817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPM1T2LNHQfKhij9F/iyvK/25eoDUaIBSajpXKOmcoE=;
        b=CUZmELoWmIbfeyYWKbFTyepWHwztzP9tQhnAt4TNyzOA/MyNf+GtaKpx9c4JTi6iju
         dJ8OoGqG/Vyut4LpVzoLpuU13Vwg5tOJzydPWZVzAAZsXjRB/YG6maDB+xIu8ThXuk9c
         I9iqS1jmFOnfUYFWYKgXDcKcZEmY8ePoJ+N4f7qbVWcqMkM4RyTXxqfltwlxqcYGUo2M
         CCncPwnb247DPBtvp5BWTc93NwlQDVLmoTW9UUqCHtyLYiD8mK3PuaVyuEc1J/sDQlD8
         lKvkiBocEclB62QbEGr6sc8/XUWrRJONoPz5T5B6GHWQbQPd3gijH0HWPcOw1/myPwVt
         +6gw==
X-Forwarded-Encrypted: i=1; AJvYcCXuTflkjw8It5u0S6XDAxGQ6slTOYqPEEEXi4aEK/opw9VkpDa4qKIWQmqVCZoLwv21R44+aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrOX2u/CEouAD13NUmLgxq5zYsFjZqxQ/YE721gTdj3h1EH8Ni
	mMZV1iltiqNK8nFswbRBfqhz8PFiIOdBkaG4LxU1rTr/ACOAJPe64cru/oT5wHwQqGsCVVxVWci
	5D2W4544MsvIIpOi37N71UHDlT1GNuNg=
X-Gm-Gg: ASbGncvGC3ENhEMrgD03qrmukbLeb+16PtehcT6SE31o5DA398rZTf5qvPScuaTHmmp
	QBrtvglPPaI6h9G7NaXIHt85N3KivKsx1tqaqcLxQlRimEfRrvMSZzBok6Orn64JsWnabZHnySW
	Vpif5OQssop37oVCEOnjPewJb18kuxlKH8a8N+NeYaUZhWehFr6xYPd1681PafE1xORKDkI4YWB
	g==
X-Google-Smtp-Source: AGHT+IFmjVcaAlwKjAztbNsqFiGATow/TiLkiXA3EwSVpmOxrMIFRhzcapgfz5nrrTRgAUyHU/AqUz9S6WnnECsyKnc=
X-Received: by 2002:a17:907:db16:b0:ae3:cab8:d9d8 with SMTP id
 a640c23a62f3a-ae3cab8d9f0mr175432066b.41.1751468016986; Wed, 02 Jul 2025
 07:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
In-Reply-To: <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
From: Matt Mower <mowerm@gmail.com>
Date: Wed, 2 Jul 2025 07:53:25 -0700
X-Gm-Features: Ac12FXwmRNy0XV6HfwF_miAtw-Zu6Zd6a4pUwqmVNkw4VdKWa75ipABJl-DtuBk
Message-ID: <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Matt, could you help enable verbose ath12k log to verify my guess?

Here are kernel logs with ath12k debugging enabled:
1. WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
   https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x100301e1-20250702.log
2. WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
   https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x1108811c-20250702.log

I captured these after setting CONFIG_ATH12K_DEBUG=y and running "echo
0xffffffff > /sys/module/ath12k/parameters/debug_mask" during boot
(using @reboot in crontab).
