Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689684DFF
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825298; cv=none; b=XdzB4TeDm/nQxr6WOqyEYNAgYpQ9TfdpiMUh7l58mbDzqOMB5pFmyIntHRUmpVtigGOhAcYhgpmGMoBauUTJitaFKo3J9nXQX5j1JI/fplxVrY0xSpHJU7eLOTjH67joL3DI/LD8R+obGimnlbgssom0pfjQYhiIySPM65JvdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825298; c=relaxed/simple;
	bh=pKtmEUrQlTA0F2ac3541cFZOBFkYUhrUldNV8WVF0HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFLdnw9rrgdaF3TIGSdvoOGPsji2c4KsvnFs9R5opXt8WWOKjnI7RphWlB4Or6EBuN7n7+FVcyNhm6nq1TidIH5JBiMhmAZAeSIDlThf31aOwA5CSObkwEXJnfGXzPuSmcd6Ay3JSUTvqYzCiEco09mPegCi1yxDj5F4gUm9Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dqpbliDg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dqpbliDg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4c7b022f8so19299355ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719825296; x=1720430096; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKtmEUrQlTA0F2ac3541cFZOBFkYUhrUldNV8WVF0HY=;
        b=dqpbliDg/H9vXJxWKwInh/n76DCREhQt32ljxctYgS2FU5dV+Rft+UD+DUsNGrbA7L
         uBKElQJVzIkSxkTnNY2z8iDprkH/VD8bkkpvN+gCzwO6ydIFYjidlB+TyVzGGs8Zt4tJ
         hoStweQsckkiXdghIUUzB4haNbRZWjN+1JL5Cki0WDu7cYAkfmEbvD5TMnVkzNF8Ete/
         CuIjNpzwSvZvLpQLuYepmmvNSJe4tHqPbNoGNQX5aRP95I4ZTJBUHU5bkY/USn0D8dBr
         +FtjcbnGG6zdWudFRQItDjN8g8BG34AZISzf2u4Xo2GgIAkK/UrkxqJCtDnr2Lrd35JL
         wn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825296; x=1720430096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKtmEUrQlTA0F2ac3541cFZOBFkYUhrUldNV8WVF0HY=;
        b=bVm8X4/T6PV5tQJ8ndBXEi/3YYlrvCFuEdSHb6cHPtIYMPuUkyRljl51uFIm4pD7SR
         t58r/ZI9Tck8cwRoFOVnA42jl3tuQaRB82tVQbTGVhvNEbI8BMY3WLEDxKUi6+aNvcU2
         1rHydPs7pOpXXayB8l+ygWDzNKOA2O7AAF8FByWoeMXdYnHt/I/xvjuouhj8xiqK8KW7
         QoVqtXgNE/vP3PXny1RWLDuQ6o6PImiNt10MnRqywkLLcnhgCZxajovTM2WuciGKTc6t
         MaXiKpTUmi/1lw+xfIL5iiVHVmqZIgmTRrNuHPKbargvWKoERepBOItYIIGYbIVF984F
         81jg==
X-Forwarded-Encrypted: i=1; AJvYcCUP47qpWKf3dlVak0gBa8fHJhsdKbbI6Lfq2DSt6WCV2bBoreftj20FMTrkSeTxKAxmOby2ai/q2JiBR4o27KqbJWHSmno=
X-Gm-Message-State: AOJu0Yz7bsR00jTQHdtSbhXwSyHczr/AFJZLjNMYIpXY4iTuVsP17Ud5
	kRcHo3+MtQ8L4vY7tB88excV3QTHxOdZj6GmTCiHZwige8wYfSlfjjkWr1jAiyLqZhFvsPO3spc
	ObkQxMSTPuhfDziYUutYzWB/q2Xz08iQQOGvZSQ==
X-Google-Smtp-Source: AGHT+IF9jQpQKcrxcoLFI513tP4pa+3WxK9vkzmTGRABCk37DfpNT9a0kMZr3OJoZGwOYrQPiOPna0U7ATKOrjtwlnA=
X-Received: by 2002:a17:90a:fe13:b0:2c7:ad68:f99f with SMTP id
 98e67ed59e1d1-2c93d77c93cmr3483555a91.46.1719825296558; Mon, 01 Jul 2024
 02:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
 <20240701072908.25503-2-luxu.kernel@bytedance.com> <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
 <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com>
In-Reply-To: <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 1 Jul 2024 17:14:45 +0800
Message-ID: <CAPYmKFs-R4SfjZOMyV5wxjrkV+Eawc-zRWKgAZNFpOezZ6JQDA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines
 between iommu queues
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Oh, I think I understand what you mean now after checking the
implementation of riscv_iommu_queue_vec(). I apologize for not
understanding the meaning of the code before, please ignore my
disturbance.

Best Regards,

Xu Lu
