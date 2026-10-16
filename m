Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AC440633
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141355; cv=none; b=BvaLizIodmFfWc4qy6YVk+IPvH1PnLUXXEdAMCaVisgT53dNtu1OCgA/qL8eF7X4nRLbasrTQtRx77NO8IWbmjv/do5dROFwpumixltROzZDy1X7i09tqxe9wT/ZuMr/Z2NvIgNC/ZIokf9sdIbi+amp1HqE6LLJ+e4OegUTr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141355; c=relaxed/simple;
	bh=EAL0w1drlk9iRFR44y1KTfcczLiGqgrQS+sQXndKFGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6WNC0+UemWFbxD6DO1Kgb4GWQ9ZW5xYZRrdCVzn4XzWnQzE908mqCgXQbKR9aqSuf0uAKsrsQkW66p8uoU6SRajFoVXO1D2+c1UQ9ncUX3kiKHTmC7jr/BX6hZ9b4Fq3t7uiwFCEJsSuux1AZUIdDB5Q1BRh6nfxhE1HX7lTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwXlea5E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwXlea5E"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso28451635e9.3
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792141352; x=1792746152; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0+d5JuI7cYWqs6zSvGD292VqwhHrlteYqsYUHwcriY=;
        b=PwXlea5ER/GZLn/gHN1dPY+F22/8KfyUzzeClulvYxBooD6HODc7Gr+EM7MDQLMJK7
         VHNjZHXuqdgKPtLXywjyYjNP/Y/IWJ7O2fBH1g5Uz14XhzZWiyrzdp4e5y6HoyUn4Xl4
         j16yklk+9bdMS/QSftvFmJre9jL8N3vrnb1eb5fAeGb8ZYqP8a6bmWSFwR8zqFQP9afJ
         W/49EvNd9xgrPhxTidl0wBQN/DCKDIugSuo67uH/Y8SNlYGBkC5Y5oyJTsQQ+lUAZ5YA
         lRd5/cyx4CFSYoiTCzovnGMQPYwQ0mwr1S3+YjtwO8YBoOIiCF1OMCEX3YcitPgq5Nh4
         LBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141352; x=1792746152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0+d5JuI7cYWqs6zSvGD292VqwhHrlteYqsYUHwcriY=;
        b=02+v5hWQbDzAEYD2q5JFMxIZ4Al/0AsI32IzTtd2jXVj8bmvCOU9qDQNkDi4bIU4ax
         TfG0xhCcQlKbAGxYZl2ZMw+PubTtMYrCXr9B6CfrUss1dHX652nMAGkdyIANs4n8w/m0
         OX3uthnBKWkmPmC1FVV6FWu/UKRI1IZUpQMIbN71bgg6ynUo+pD0/rFXrRqjFGrWHDWS
         AfOY/PI705L22GQRj+M4J0QrOchJrYJHwVvY5txp7XfAYaZqdhY1WaEkH26QIaOPLLsW
         tQp3K03EuVMHRxhfjC7p4GMMh+0eIm1I6qAPVc6KzuyyRwA/lskzOET/RzbRkqS1qd7Z
         0QEQ==
X-Forwarded-Encrypted: i=1; AKwUvByA8Ssza7wC+Zlt+EPSt0PSd85C/ZUVukBJkGkFyLOdRtecVGko0HQ5e/0rDzRWjLQ5SFzbZg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIiJKSY6a2lk6eQSHYzO7u3pNxLg2ffe2pNP44P2SAHwN1iVq/e
	sgNSlgCxQi9M8//jHhcokshFN29d+WKrx1CQ1i6hYWQLQMFRVHU1JLTh
X-Gm-Gg: AYBFou3AtWqzfCq9oBeExw7RETrSmkbUbQls2Xa6OqAZP8wLar8wQQwIdbad/SimedK
	t3L4gMctvMfJlvSJKEdvtxXKkQdSQI8LqAldekZif8mLyBcWFU2TlrhkI9PS6bsBNZnAS1aeivc
	nmDBAkWbAYFZsP4N0ySooUtdkQ07lBaO5HoYwo51CzvgCfiNRFhFMgfnM6Bt/6ws5pP3IwXokU4
	90rU7Lt5bGrvfPf97B13I9VMimm7jbcecWKc5VGYmfYEM0NbLepcRKKliO9CuUogVHRAhT3wTB+
	j423bNk79p9UN5L/k3qg6qq7ilSfm7E3wVOgU6PMQrsmPjBtroPQY+PA2l9Pq9p0yYNKkKSlbdk
	TlmtrM99UNBktT+J4rZNirs9BmSoxVPyQWctobaeb4tJ3+yRlMMQho326M6/A7yMq2rBBVIyfW5
	3L32tE8tSahgRCta74oaeV/UjZQQr3kBUVYVGTuAe7aH6AgYp2DYGJ0QiOSV5H2puzPqaD+6t7/
	SgFJH/i0/w7q0/cIZcEHkk2giylli9to5Z+LPVFF16Z8g==
X-Received: by 2002:a05:600c:46cc:b0:4a1:688d:a41c with SMTP id 5b1f17b1804b1-4a18e4c06a8mr416698625e9.25.1792141352107;
        Fri, 16 Oct 2026 02:02:32 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca30aa4sm16138995e9.2.2026.10.16.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:02:31 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iommufd/selftest: Check dmabuf MMIO mappings filled from another domain
Date: Fri, 16 Oct 2026 11:02:24 +0200
Message-ID: <20261016090225.3824-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015172243.GE13920@nvidia.com>
References: <20261008125206.11990-1-parri.andrea@gmail.com> <20261008125206.11990-3-parri.andrea@gmail.com> <179200036595.15213.9864724554843977359.b4-review@b4> <20261014211608.291608-1-parri.andrea@gmail.com> <20261015172243.GE13920@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 02:22:43PM -0300, Jason Gunthorpe wrote:
> This sounds better, but I don't know if we need all this code just for
> a selftest.

Fair enough, I'll drop the selftest.  Thanks for picking up patch 1.

Andrea
