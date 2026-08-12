Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58D43B3FF
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538950; cv=none; b=hSWyKig5UvOIE9bkj7aiGZZgcWWao6EAQOODSoCy4jWzJkfeRQ9PFt2mua8FvijQUFiUQ5Bp6Hy+UdzswzLpihO2v/iXwONnKZVELLNRoixflPyI8lvozXl3Fh/kJLDhACG17Ik+K4iO40RCyot135Yawa/Ze82/D2e0KLhELJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538950; c=relaxed/simple;
	bh=R7P9GJg/MAi+yHuvn1qTceQ9Hb4OgtvyY2bPwHpj89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brz/g56+TQiGhvvg48Lmxch/qq0Z4tbBFwlKFZQjoB4mh09N2V6yxofDKJgMMrUVwqHuByt6hiNU0mNW2rGCweg5+D4ax+o0cYy1jAfmBDRfHgxsLy5MQFYNemGPC6k5K67WcyTJdsaRnk3pZJC0Up3xf9TqBGyeufdEdzDK69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYomQ5rp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYomQ5rp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4994d41ceb9so593975e9.2
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786538946; x=1787143746; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1u30g0AMKY150GAPKUik0QfLk+MxUjv8vUartSunHuE=;
        b=CYomQ5rp39npwS9Sky0FK1rnhWO10wvJPgRlsJGGxo1zFKpciFXMwTqGVjSYLd2QX5
         QjuXKb401tVRSaiYiLlXmNp4+E6KYMzBKoYzbcjn977eZlEJCOf3W6ryEvBklq71gdoU
         bh6xqWOwS4LV8a8x2Q8WP1ww7CHSf5na8/8s9jqHw2VVfzOrawk3WWlc0q6dwHKtE02k
         mtRFkiYy0n0TLAy7tPlZKR1DaOM9XBL6d8yzNMnuzuzvUxJjShgvSr0w8fhMTYHWDA49
         jJOETW341cXbngr4aQUDUUcmDAtLITqszOZ9XUdtNxR+A1k101KItDjj+s2cH+Y8pJLx
         IiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538946; x=1787143746;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1u30g0AMKY150GAPKUik0QfLk+MxUjv8vUartSunHuE=;
        b=S5TKCJyNLkK8L7zMohJFlTnotRc1kpkMpY29kuPOvD5L9e9XRMDU70QoxAUbJGqSv7
         hZtrhyI9/zelwYxUfCdiOkOuwgKEpimCPcv/BIXWWZRb4naaHUYNaXD1107I1gmTKQZw
         9xQX+qfc/aVujcYUMQ9HNXlemYOyD01bOzKZbsd0IotTaJwrMP2tkUfadOUErThk09tt
         eF9pb+6+OTOtAiIYAbT3DsBw7dXHQQi+QQG+meho+bs/20xu1n1BbZXiYipHfSCKpRKa
         EIYZ0GCzab+cBTtFRwCi+eEwOyGSwnAOtDneUi3btabxKcu+ja/fjdo/WMbUa1sDXBiS
         sm0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq/qQFpClMg9yNzvNP90yH1tyuZs2OmU/JP/WgKYJtMNB+j/J938FRlU6vaMUKGNFyT4p5bmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+NInuTWR3O1UYkTHIETWQ3bmkVfSa7Ddbuj4gGBgJ23lTequx
	TiN9lt5f3i0ApDqWM0/fbREOWil+PBjQqvzcJkeKCrtvFlA5H+bg+l8a
X-Gm-Gg: AR+sD12AZXxWYfi4xy4lbZhUWzq7Jtdq96HhHpkvrpd3Gvmxk6fHCpFGq7gB8/CyCWW
	DekidKoVWWt+RftPpRvQlhDTIj+Ur52D+cWyiKbaseVhjqhNk42bj512pGHm3TbZt0GfD9FhVfj
	8q4hRs72V5Z/lGQ2WSnw1w5v9hkWuFNg9TSFs9iJ+78wzIbxm6A4/ETwQZWxjiuQ7fIpINUQkJz
	lZI4NQtJ68cmyGwfO2r51JrDfs+ozq1IuqEKSul+CpUpk3Fyyr/qT3CCamHwmWPzpnlAku9vBWW
	g9b2cZeUS4LMHd4ZmcufJZPZfyzGkIVR2Msfp9kjfpLup266GfWkR9M4iDBH8LfwRbnmG1PAES0
	GgSkTk9tU8p5NpkUze2vicVOCAMmzTD7ljd37moeN2za0xaNRNatkAnTkkArafaXeBKjKTKCyOk
	lNYh1Whh3gCcp32gJe1lMtdShlWKOxeAdhoJEkrH6jJ01TzmJgx5yMaFlITOghCWk1zphlXkomd
	nDNLRwe9EAxbueznysnXj1jCt7cG0ndkboHAWMS2GfcQj/xbHkWId9LodOPgjK74I9L
X-Received: by 2002:a05:600c:3b17:b0:495:71ff:598d with SMTP id 5b1f17b1804b1-4997c0ca479mr29063825e9.1.1786538946151;
        Wed, 12 Aug 2026 05:49:06 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu. [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e260sm7247226f8f.17.2026.08.12.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:49:05 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: Igor Paunovic <royalnet026@gmail.com>,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 12 Aug 2026 14:48:47 +0200
Message-ID: <20260812124850.6597-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812094106.1391698-9-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com> <20260812094106.1391698-9-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Two things here, one of which I think has to be fixed before this
lands.

The first is a comment that outlived its subject. This patch adds the
following just above the PC_TASK_CON block:

  /*
   * RK3576 arms the same DPU completion as RK3588, but the interrupt
   * never reaches the GIC. The completion itself is visible in
   * INTERRUPT_RAW_STATUS, so sample that instead. The tick cap bounds
   * jobs that never raise it at all, which is the same open problem as
   * the wrong inference results.
   */

That is the v6 comment for the poll. It states the premise your cover
letter withdraws, it describes machinery this version deletes, and it
has no code under it - the next line opens the second comment block.
Left in, the driver would carry a claim that contradicts both the
commit introducing it and the register description two paragraphs
below it.

The second is placement rather than correctness. This patch also
factors the completion tail out of rocket_job_handle_irq() into
rocket_job_next_locked(). I read that as behaviour-neutral on RK3588 -
the return that used to leave handle_irq() now leaves the helper, and
scoped_guard drops the lock either way - and the numbers I posted on
1/10 bear it out. But it restructures the shared completion path in a
patch whose subject is adding RK3576, which puts a bisect in the wrong
place if it ever turns out not to be neutral. It would sit more
naturally in 1/10, which already touches that function, or in a patch
of its own.

Both of the things I raised on v6 are right in this version. The power
domain list is attached before anything that would have to be unwound,
and the comment saying why a plain return is correct there is a good
addition. clks[] grows in the same patch that adds the two names.

I also went looking for an ARRAY_SIZE(core->clks) or
ARRAY_SIZE(core->resets) left behind, since that would walk six entries
on a four-clock RK3588. All six are converted in 7/10, including the
two in rocket_drv.c's runtime PM callbacks, which are the easiest pair
to miss.

Igor
