Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789E19DF95
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221679; cv=none; b=or2ED13YGI2XWo1oU8TtBedSn4fza+njtsAzMOQS6F6LND05Tr0iiPwKCNY7uixq2PI01PVtn0uh0hdihD4Z8H2A751E1U3XzpGyI9qP8hd77I70vNJRq9pRGV+9w4oEiRcX8W+uDhaPEA3VzXHqTQubRPMlhnAXVLvitmail78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221679; c=relaxed/simple;
	bh=vMlcxqhH9M0oMBn2t50QyORix8uNGB6ufNOx9xzdqRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARscnN/Sp7FFyuyCVda9EmvQR+AZkPX1wBJgqFoPZvbjsUrKBMxEggn2+wddMwdc0C2eKXEh1v7XxjZQK6a63cRS9dFUmls1Yy1uQB1VVVj+2pY4KVXWTKOYrrfgRSUgSINRHXiC4mgZCoBJn3PRNyB5XnWFxi4+mwT++XerPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c693b68f5so61901915ad.1
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 10:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221677; x=1730826477;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMUpO4GHw4JTvBKu5JvINhynu0MBcZcJA0tvXvTxH3I=;
        b=XYB0IEziPgdVjKToxDayr/UIZkfbS7O0ZR2ByOjOGvj2xG+zqkMpC/cTSWfSb58zEr
         0SgWWepQbwF0GU+4/f/VOrgUn3jldJCwn0n9a8SE4TSe6jUGrN5L1Nub8E4GwIPCekW4
         ugDMfzePkfQycDF4mA6UJv9VdgrmeekP2rY26z+rOb2duB/8OEQtg3VTk0fw43l2WPsb
         UNEpOtbJFR654/A22G2b7vs1JlwWufXGIL+49Z4FN7QnvlWhNgw8HKVmdeM5VgTFPMjc
         tIgptdrPRv1KoysUtp4xDP+bGa12WX4Ksk3fS/AeBy5//zu7rm+8MUGaBSvNOKl2DiX7
         nu0A==
X-Forwarded-Encrypted: i=1; AJvYcCUfAo6pE1vWKZ8c7415n6+h7RyhesYZ8Kvb/F3oITD2q5kT1Zw5U4hHXPeu0FsWgCNZmsDjCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzzFXlkwT0r0H2zLKP3V2OvcD5t+pAwlnkzJWk2S5F33ktNbgP
	t+/swZ6ZkO7j6Gw/KTT2k1QQsrQbYvNX6xtc/4xOQBbW0omU0SQTuOQs2SwntNc=
X-Google-Smtp-Source: AGHT+IHQ6hqt2GFIDvzxzB6z/d1rlXeJz0yqkXbJH8u2AzK+uLr+X4awDkW0ZAHg6kt+Bt1a+fJPTw==
X-Received: by 2002:a17:903:22c5:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-210c68ab683mr167590195ad.18.1730221677056;
        Tue, 29 Oct 2024 10:07:57 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf46cd4sm68256225ad.41.2024.10.29.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:07:56 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
 laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
 andersson@kernel.org, mathieu.poirier@linaro.org
Cc: hns@goldelico.com, b-padhi@ti.com, andreas@kemnade.info,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-media@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix omap-iommu bitrot
In-Reply-To: <cover.1730136799.git.robin.murphy@arm.com>
References: <cover.1730136799.git.robin.murphy@arm.com>
Date: Tue, 29 Oct 2024 10:07:56 -0700
Message-ID: <7hiktasuqb.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> It seems omap-iommu hasn't had enough mainline users to avoid bitrotting
> through the more recent evolution of the IOMMU API internals. These
> patches attempt to bring it and its consumers sufficiently up-to-date
> to work again, in a manner that's hopefully backportable. This is
> largely all written by inspection, but I have managed to lightly boot
> test patch #3 on an OMAP4 Pandaboard to confirm iommu_probe_device()
> working again.
>
> This supersedes my previous patch[1]. Patches #1 and #2 are functionally
> independent, and can be applied directly to their respective trees if
> preferred.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

I tested this on am57xx-beagle-x15 where before this series, I was
seeing various remoteproc drivers fail with

       remoteproc remoteproc0: can't enable iommu: -12

and now with this the remoteproc drivers are successfully loading again.

Thanks Robin for working on bringing this back into modern times!

Kevin
