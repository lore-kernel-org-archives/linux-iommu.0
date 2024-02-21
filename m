Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546C80601
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529199; cv=none; b=HjtesNO8YpoaQHuX3vW9C0HRHlOpBMofyaZwtrSFrxsPS6X5s+L2DA3hHZ349XCl8unLx73qPxX7/kE1++Ao7/u5iCojhiJVdWGwaw1wNQ5No/vTmOBSJyCP9yC34ntm7E8G7t4G+3iigcwsrgs9XGXLv8W571YcaW+hvyDEAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529199; c=relaxed/simple;
	bh=1vQ0qVKigz+/kTXg+CH8iBbZfUJZzhzN16scoXvXRQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZuXQ/Ng2+wv+yriQh+8uVWvRh5v/gYpZue72ikH0uORAuvwDSsDcIP8rqYmHLcnuM6VDtFOQlT6jdOPASl8gPpaWPZI03XWU8eOsVqYhOamF+20a/qEbbS739rCfYWR7/MXT5NfyXBEfp+NGNnLeSTx+S4kG7hup1y9AexTrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntGLnzXc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntGLnzXc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so2320412b3a.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 07:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708529197; x=1709133997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW/wH8Bxvy6vIw9lSkZQNzRLcUxp6rWTmo8sEe8KFwU=;
        b=ntGLnzXcj7HN+d6gEZfZ7is6JzhkAUcUf86i+CiBl6OBEpTlzDBoTmE4iVf8+XBvvP
         i8KLdPMWm2Q8rR/iMj5tn+gWBKyXBEdZ85W+ret9i0/URhYSONc6pm28PkqECgSgEGqT
         jGYSFH0eN1RjoySKOdIpDRYoNUEgIlMuq0VdG0I4xUS4oAx/jWpxrlhUu6lsHgTZpwcb
         a/ImFY3Y82CPtPuDVfoFPZLk5zLRbcVSQdA5zRJJ+1tr63FsKqNMuZOLTMX8Qy7+fBcN
         EZcs5hLELD7VzpgCEpSCWyuoMIV7Zjj0lFQdwL6PlvMbZoPSIOuCkvK1k3SeyIZjx866
         KLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529197; x=1709133997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW/wH8Bxvy6vIw9lSkZQNzRLcUxp6rWTmo8sEe8KFwU=;
        b=VotyjP2+ybXCqjXXtJqboXVV0OpMvE1FFeGnLc3ymnNkFHNiYWMztykkeeJmH7R0L0
         uutFnINqWsc5+m+kTpZLk3TzO+vFpqusl2/c+7N9MOX5YWeJkr166fODoxucrxJBMVZ8
         +pZ/eXysx3BQeLRDFx17ESGoU1NVs9GZimLZygu8P0rGs3lS4oPG7VS6uSVsyYujfSXo
         +DXe8KT//62IpPZgKUKO8of45/4BVBhWXg85oqfBzIntxOkbOlirtPSU7435yOVTjxT1
         tn5exlXZaNDi1ZrCOs81cs6f6+8UGfbVHpn3FSCJg/ZobI8yJKCwUtaF6Ag80WKfSG+5
         ilKQ==
X-Gm-Message-State: AOJu0YzX21f+y7zENk0C3jRbMqVO6Q3sT+b3B3MvnkAY2TUZBMvjvp7G
	zZKqu0x+IN0Nokeb0vnw8sLJvTyuxn725lswXiIhOgjoCE7pyXJG
X-Google-Smtp-Source: AGHT+IEt3BD9AeWE2Q2VZ6pJE2NucbpYuT5K2Ta/OzpXuZ/4vRBzk1AoIfF/xKdkIbIGN436T6HTyQ==
X-Received: by 2002:aa7:8652:0:b0:6e4:6163:7e05 with SMTP id a18-20020aa78652000000b006e461637e05mr7953591pfo.6.1708529196847;
        Wed, 21 Feb 2024 07:26:36 -0800 (PST)
Received: from nilq-virtual-machine.localdomain ([60.24.211.11])
        by smtp.gmail.com with ESMTPSA id ka36-20020a056a0093a400b006e48e0499dfsm1619085pfb.39.2024.02.21.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:26:36 -0800 (PST)
From: "ni.liqiang" <niliqiang.io@gmail.com>
To: will@kernel.org,
	danielmentz@google.com
Cc: iommu@lists.linux.dev,
	jin.qi@zte.com.cn,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	ni.liqiang@zte.com.cn
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is successfully written during SMMU initialization.
Date: Wed, 21 Feb 2024 23:26:29 +0800
Message-Id: <20240221152629.3656-1-niliqiang.io@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219091709.GA4105@willie-the-truck>
References: <20240219091709.GA4105@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>  The SMMU registers are accessed using Device-nGnRE attributes. It is
>> my understanding that, for Device-nGnRE, the Arm architecture requires
>> that writes to the same peripheral arrive at the endpoint in program
>> order.
>
> Yup, that's correct. The "nR" part means "non-Reordering", so something
> else is going on here.

Yes, the SMMU registers are accessed using Device-nGnRE attributes. 

One additional point to note is: in cases where there is a failure writing to the CMDQ base address register, the testing environment was a multi-die, multi-socket server. This issue has not been observed on a single-die server. I apologize for omitting this information in my initial patch submission. 

Over the past few days, I have referenced the kernel source code and ported the SMMU register initialization process. Through multiple stress tests, I have attempted to reproduce the CMDQ base address register write failure issue. The summarized results of my experiments are as follows:
1. When testing with one CPU core bound using taskset, the initialization process was executed 300,000 times without encountering the CMDQ base address register write failure issue. However, when not binding CPU using taskset, the issue was reproduced around 1,000 iterations into the test.
2. Without CPU binding, I inserted a memory barrier between accesses to the CMDQ_BASE register and CMDQEN register, similar to the modification made in the patch. After executing the initialization process 300,000 times, the CMDQ base address register write failure issue did not occur.

Based on these observations and joint analysis with CMN colleagues, we speculate that in the SMMU register initialization process, if the CPU core changes, and these CPUs are located on different dies, the underlying 4 CCG ports are utilized to perform die-to-die accesses. However, in our current strategy, these 4 CCG ports cannot guarantee ordering, resulting in the completion of CMDQEN writing before the completion of CMDQ base address writing.

From the analysis above, it seems that modifying the die-to-die access strategy to achieve ordering of Device-nGnRE memory might be a better solution compared to adding a memory barrier?
