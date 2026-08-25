Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B32403B14
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661941; cv=none; b=Zy1RfU4qKZSROIy64azG5RP+GCTzOzKJ2G61xPgnFrmGgNXoAE32eXRlj10bSg4o5b+rhdFezReJMUBqqmjKg6OmCGKMDgXrInKcDsS23lYFDk2tjhndHQE3dQDaRCc0YLkI6I5mO1etV8dH1yWQ6gQW9+Pf8q711pdLGvFpTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661941; c=relaxed/simple;
	bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfWh7WFJxvXGRvosG+Ai2aYmsk4VnMvkrToOCpVScx+g0tstt9GJaheKYqeJFAQc/mcJLx6rDutjuakeXwXUZwjMszqgA1q1Vj5LcXbeu1LqY1ruIgLm0etgkUmkTjnwKUUY9hBh91NVzHGnGEsoG3ou2I1EWDCz3aQAvrOzwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No1ZZgvS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No1ZZgvS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1676648c1eso38503766b.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661939; x=1788266739; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
        b=No1ZZgvSONoxbnhPAZcr9BJaeaOIdNTelldrHf5QfF0fbHdbZ8LxO1FeVcB4uIsfsx
         2yfx5ioUAez+ckqVFz5EZSFTJ4GdvTDDW1MvOlPsYrYxbLSx8HOB+yJlfBmcc+nqGGwH
         /zHq1Wr8oLINS09bCH/g77lH+Q5qRimlTHYPF6RItdqDuqIVas2ygqtiuQ8jywLYF+56
         MGHkY1m5eTxRNPbQNBCnWs8oqouksO4JlAlpIbP5ooplaKyOD+jkw1ScqlPsF7AizeAV
         lZ2VSuwjycoHR5jydfzWtekzFkY1UjtDkQj0RQk43B38GEsEPg0fLfFIEryTsnlKSsT6
         GGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661939; x=1788266739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
        b=bs7lNeGqczQyIa7V2NkqqSIxmvia5N0pB0w/GF721FB5NP9tvx8ecMGp1TE1Ai04WY
         KD3K7nPLWVr1Iyh8iv3me3b6JRHB1daRf4vexg8BZ6ESuASOGMeTI0gLA70/8/HjadjH
         /Qn8HvpbOP0z4NXV/5LEwro8ls+cBjG8LEUuuLM5hCU+owsDgGkgmYYfuWE44+hn3OTN
         nN409axYjjnP+gNwJ+ANS4WDIsZZeTzyu97JfRKSYWgwEhDtoG65spyZOTqIS5DyMgr3
         bVR6E3M+6gNRc32A0PiK/VRBtdMSSYCDPyShg1Bib5gMBmlDlWYjuFYYZLVD+W6aJsOI
         K/Zg==
X-Forwarded-Encrypted: i=1; AHgh+RprBhCZ9LqifO8dfAMscUyQYQjuPRLRePDGPeXfSPCHUhfWXLSU1Un8QIp0bHCNTuPq7Hj4Gw==@lists.linux.dev
X-Gm-Message-State: AFuF++nzNQzc0u3bugCjtDdaBRpzn/SEYn/Y0tWVx53C4rS5mmA70gQG
	ndf03CrnaqnEieTJAO2ltoxY52BzYos7ESNdaqF8WxPdzJkfZRwqFASY
X-Gm-Gg: AR+sD12PBc0CCl6KaNDcmjQ3xWqLR8pXdd37vqiUS6jqoLIg4Doy4HDcqdtBaNgMpb6
	4d1oUBqTYlRmHcO9kLv/RA00Z1sgVxHDTle4EA5QyOJKkk7NQen1BA3p5hcUMGWLSoyGmcRjDbG
	cjkZ2FB71BgHu0Dfm2SQDhD4iYX8Maa8XkWNqM970L+3RQxUJ3n7eJN54UmYajFYWSSJiMqLuO9
	C/Hae190dyO0KhBlSNtx/DHQUF5nwqe/PEqlFg6mmAgNcYp/dPFXbzus6vOr0yk44c1r30Vw6RQ
	J4XMnJon5Gt3P/lxaNdu3kEw6NfqyRqgRfERKr7iY1qYP5QnrH/JUI4tVwJZFnaPKnjRNrqHnE4
	1m8T0/gAHXfiUzTofh8MvpAgxw1K7PJEafSTRmB9+X1uuMEnfb1UD+GmJMXn87MWroGJSwtaW2m
	KJDcXTPYEyRvVQdTSgUsL8xGDuTSE0uUapw5xaffvH7G6uIJeffHS3p1lnai9XytcgGB8m/dyxR
	ZPvVL6CDSNft96ZOSni+Xypnm34GNUtUIWiuG4/sWjFtYI=
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id a640c23a62f3a-c2469f96e84mr1943665966b.0.1787661938300;
        Tue, 25 Aug 2026 05:45:38 -0700 (PDT)
Received: from OrangePi5-Plus (178-223-53-162.dynamic.isp.telekom.rs. [178.223.53.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249673d43bsm1646329666b.47.2026.08.25.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:45:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Alexey Charkov <alchark@flipper.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 02/13] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Tue, 25 Aug 2026 14:45:05 +0200
Message-ID: <20260825124509.11657-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
References: <cover.1787568658.git.gahing@gahingwoo.com> <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com> <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My mail client wrapped the tag comment in the previous mail, which
would truncate the disclosure when the trailer is collected. Here it
is again, on one line:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, differential base, JOB_TIMEOUT_MS=2

Sorry for the noise.

Igor
