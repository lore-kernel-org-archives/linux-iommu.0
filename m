Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F2223328
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661965; cv=none; b=dTMJ0csTg6dmM9AsAQmRDCFJmgFnRRyVLbEpBtS6ugR0iNQSWsyIAbpUik6KLHmpY1efHgb4D8InstdqRgJbb6hTa9LCpdwoPMns7vNHt62OEe0B13ld5Fw3At6TTR6csdfjdd47xWoLAtAinw+nKIGPtsu6kS0wgWxvn0vBcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661965; c=relaxed/simple;
	bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJT0kpxrZiEMJWHl/K8BWRuaX8rDuNYD6ElEXHWIxapw8Zomspq9bOIhYI7OwKp8vTU8vIbbGjGdLoaAPMN0NKAnkokAj9swkr2SF/DY8cG+UhevCJc7YzhYmT+8L4NTOsVD87jPQQJWK4zIP0wtnFiL5N3Z6IugBX52/8QHfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzpOCFZ5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzpOCFZ5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b51ba80dso39194666b.2
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661962; x=1788266762; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
        b=AzpOCFZ5+cHg2pSMVMRNZZsPJKk048DYrUJc0ejoAjohtBNfZZi6NYjSOMcbVn+7p4
         W4h8dxw2OSDNbtSUlywMQiwVhu8A500tUabR9EaL0KeSI4LXoYqeE6HIPsnfuubaU3Nr
         3ZyrsOeSFqnpV1WL/6OvamwWwrHmyBtzNwLMrU/5kAc5sQ3r5k9moJpWFH1zmzismiG7
         VdWiCFiy16DtO4sTuhbKT4wn+paIOxEO3sRVCGyUPrPALVwXoED/tNCHCSgBeMW9tZsp
         O9bhrsy5IpZtTXDOdzj0/bkOZmbrklVlolgHRWqZjY2dnwTE9SytZg4tJHgJk2RUDv2M
         0oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661962; x=1788266762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
        b=AORWVIdclWFGfDiiRsXtuaO/j7A42LM0U1yr1hGBzyywt/TOjpGOVw1KKsVhLA5pPq
         KhRKsNmHQXRfYbAYiMoGLMcKhFVVX8GfvRElQ9rPTxtGPC0cUtbvvQIXEYelKoXXIpUK
         vy7xR5NmLJPYB2UGHtdWrHSJZKzjjvuqB95HizvaRSgvfIuzirjlFDuBRV2MOgGocbRQ
         YxkT190eSF3qDMf9nk06L2vmIG6dVsDJDrKRGdFGyLIAApUXfg/p+40mlMrfSXRg0FCs
         /pp9RfUiYXbtqC7AHYw2m1PZ3eJQ55WGPLBZ5VtGtstoGLNraIz8un/0g0QWuJryNNRX
         LxPA==
X-Forwarded-Encrypted: i=1; AHgh+RrL5rvxfX1HIQQcfcw2r9301Fw5IvknnyVCBu5gXF+BwZc476CsPPDA9POhRARzdbWXQIfADw==@lists.linux.dev
X-Gm-Message-State: AFuF++kQ2yu1bEKiPptPaNAKwVs7kfy3zI54i6+iyZ0zTVup0rF+VrEM
	sFwxi+goA5UDbPiRThvet0alyWA+Hmm+lhPg+pAm/Oj2rZiTDskq+ZYZ
X-Gm-Gg: AR+sD11B1KDxwVbIk6+TIUARaW0FC5ByfjtpxhPRfzkSilb71fSI5N5ESJ5nBBxd2OH
	6D2KpGxSC4Tf5K768qLfqKNeQhesDlbAWI2dohJnf34+xhP1cF7he2P1vUpCxyCPEws79GuYpMU
	S8LhM4KXG986d5hpvmG1SaBFOJbsOaNTbFO4WdRQ+QDvI5oH9sJIuWn/V5EnwaWPHbub47q7mYQ
	hoWvMnXTJd4E3B1WkHIurGxWcT0ohrD3KitYeVRCjb4puP2aAp2uw9cZ9fdrNbIXRZSKCcWozuI
	toJqoEi5oqMXKfDMuCjBcqGVxLKuirtxctjhenuo6yNPFTpAysMfG8mYOSUNcpTFHUWEtLkrkTg
	hXYfFiYTwowI2DXeJqYpWTVeQ6Q3jgZhJxWcmvr3PquP7gOF9I8zZqsVmvDBcntKA28cKvAngCW
	/7IpHZOLq6SGm+5U7eRN6QTPRG6CJtm91FAr6vTY4OPPSI9poheYnSr3LPUGks100HNn3frxG5p
	OZ9VvzDi6IrkcZQB4+4jO032+/Dn/5IARg8
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id a640c23a62f3a-c246a65fe29mr2143386466b.4.1787661962050;
        Tue, 25 Aug 2026 05:46:02 -0700 (PDT)
Received: from OrangePi5-Plus (178-223-53-162.dynamic.isp.telekom.rs. [178.223.53.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm1824340566b.23.2026.08.25.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:46:00 -0700 (PDT)
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
Subject: Re: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
Date: Tue, 25 Aug 2026 14:45:42 +0200
Message-ID: <20260825124544.11766-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
References: <cover.1787568658.git.gahing@gahingwoo.com> <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com> <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
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

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

Sorry for the noise.

Igor
