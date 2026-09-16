Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C714E2349
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565336; cv=none; b=S23bbTNtJ5lxqLUAx0gD1RxnhOKe1JnCwNYuAHp0DYno0CEjyq0c6sCzPLKLZhDuamqsuvXctZkcfOk6oOCJOYechvojVIEBDi4SAbXTvzfe0rQasfIvPjugUSMSAsx3uIMgtwrIDskmGIQf/FPgLPb7h2tTU0/Xa4M9mCWJMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565336; c=relaxed/simple;
	bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oot4QvJbTs/n7vv2RBQwGMxxNg9BejyMjwCG5egZAlIGIcTc0CPs83Ox/ZCyMHE84SEVAD4rhQc5fSyHFJ73PpTsJUOwq3Unt8e/sxhHedMV70zHOzgF/qPsBsBdyzB4zFohKQUcYWosx0OyLYGiIiHZhZhiMAySVbicKVSD5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDIY5hPn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDIY5hPn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7c6dbc60so395325e9.3
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565333; x=1790170133; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
        b=jDIY5hPnBSIAWFO0AYjhn/q2cpndDcBj/UiDN40Wrovub17jLmk9mTB3pKUprgA824
         poNK49bWhFh4tTwZPtVoyUKJKRUs1W26QOHE0L4rsZypuGGliTAic5DkjY/sZ+l0WMcK
         Nx72Drr8iC3jF4MrPcxhvWarVafN9Fm8BFsVKVZVwefLhAUaDLXylM9YVdnZK/nyqtmM
         LNgS2GjicZD2rq6wNItuvvJytO7rDg00xKP6liEzmlYrSIwt3RGX/86sDAnmrzPN6nUe
         UCsIsut+zQREs5kxApamvv5iO3JS4TRSi/6KIQSfYGtFNnmug1Agxz+xWmO039Aucq8U
         21Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565333; x=1790170133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
        b=j52V0mwOw4+dRlQ980fbmYMN9+JFzf1PeTxs+RcUG1wL3n+kE3bJOwzTgjgXZ4rg5p
         WBFIVtheBHVm0lCQ2p65ODXPsFvflY47VSny9Gs4Q3xsOsvu0DCGiGwl4kMFDFETzH1O
         tg73evOIQCxKcSzclrQOqIoKsAxxH80nj4gphNwVqlE5H9T1qDzhkTL6FDL7FUE/UsbC
         j26cgihog4QAoSf/QjLJnqOomgISUAZCvYcwamCuiaj12hUbSO6VWpzCCKMH5Miru/JY
         g5F08b9Vl1xPSU7iVxdx4lR9+u4v9saSJnrSg7aWmx5fX7L1fKXBYqevihH2MdrG3v/D
         HdHA==
X-Forwarded-Encrypted: i=1; AKwUvBwM3jwlHBRt6354rKTZUA033YY1U+W445XAamdEPSAP0YiFHgYQ2Vv+nC9Ff9osrkqftKpwiA==@lists.linux.dev
X-Gm-Message-State: AFuF++kCHvNccEFpuZf+G2Z/8hoaSMJa2CqpJ/1uuV5aNNBvCqpZmPWp
	YMi4eS13Eanusg+UmXwzf+hOyyVxj8VQBnZjm/epZ0R79D/08iCjpbz1
X-Gm-Gg: AYBFou1So6MK511rPtzcJNcG+/UM1fWsylsgqEtg1ET4loQYw2Lg/lKKSvuhTwAYFCo
	4SJlzJJqzn9QM+BQMef55xa6xDDNPK5id5lMVAyRlUphswOjEzm7vS/7iE/plpA0apgBgfwCoZP
	Raens9LSNokd/qm/LPWaqOL1Knrh1Dzcau7wIVZFxlue5Ra9vg29TY9LsIjR7A+DL7Xf9nsFFkr
	rQeAH30Rk2QuGa35+e/ajA0GPyKMoMKwP1aggNpEIo9gThO/aUUaPUVNxLoVd6eaTHn0KjthBML
	ea5wdey4F46YQgHlb04VKRaO8nHRMRlCxiH2Uue8pGq9WCxzLqHVYnFNWHaTtDl3HhCymeZpS9b
	lLw6yKw17NzX5wAZcKzh6MyQzQWw7buVhnPVpWj4bEhz+ZAugLyLu/7RPapMce0a5SGbLSCakIM
	zN87MfPFyoG27YceDM7p0qFNIAj30N9DODOXCUpSwQrTcXxSgIP9deQPi4ixSf+fskUO/ySzGGX
	W085dqbQZcd9/OJf70W2BTM1zR7u/d5fliHN7rTBc9kLR+fAEe/1MMrmmpNKpq4dLy+YXlhOAcR
	qlw=
X-Received: by 2002:a05:600c:4e89:b0:49e:745d:5768 with SMTP id 5b1f17b1804b1-49eac4112e9mr27160505e9.0.1789565332521;
        Wed, 16 Sep 2026 06:28:52 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8E02001A623C292D45A2B3.dsl.pool.telekom.hu. [2001:4c4e:1b8e:200:1a62:3c29:2d45:a2b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847da0cdsm594135e9.2.2026.09.16.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:28:52 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Oded Gabbay <ogabbay@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Alexey Charkov <alchark@flipper.net>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Wed, 16 Sep 2026 15:28:24 +0200
Message-ID: <20260916132824.13527-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915104328.45901-4-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com> <20260915104328.45901-4-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

Thanks for flagging the job_lock change in the cover. I re-ran the
same protocol today on v13 as posted, 2+3 and 2+3+4, three runs each,
same board, base and config as on 12 September (JOB_TIMEOUT_MS=2,
PROVE_LOCKING, DEBUG_ATOMIC_SLEEP): 73 induced resets with nothing
from the driver beyond the timeout message itself, no MMU faults, no
lockdep report or warning, and lockdep still armed at the end on both
kernels. Of the 126 inferences scored, 118 matched the CPU reference
within 1 on all 48 channels, and 8 missed on all 48 with the channels
the scorer prints reading 0x80; in the two runs traced with the
kprobe, those 5 results sit exactly where the 5 -ECANCELED completions
do.

The limits are those of my 12 September mail (all resets on core 0,
one client), plus one more: the model is a single 1x1 convolution,
which Mesa submits as a one-task job (one completion interrupt per
good inference), so hw_submit() never ran from the IRQ thread, which
the race you describe needs. So this shows the lock adds no lockdep
report or hang on this path, not that it closes the race. On that
basis the tag stands for the v13 form of 3/14, with the same comment:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

If 4/14 changes shape in v14, I will re-run that arm. The scripts and
the tallies were prepared with an LLM assistant; every number above
was counted from the raw files of each run (scorer output, kernel and
serial logs, kprobe trace), not from the scripts' summaries.

Regards,
Igor
