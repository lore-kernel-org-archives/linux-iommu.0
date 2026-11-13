Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794556616;
	b=EHHIzEZuEnNmzcvw6o+VbOiTSGc5/9WQTfUyPszVPBoQd1lMqoj1VLfyKGMZCElbv97G
	 PCrTJOc6NIND+p5rnt6t693B6fVpWglzPTw1PVrKL06j1i6GhUg12+qvy/TuEU5N3mDbJ
	 +lgUmPTiIQgGEhP09yfiJzsFjs8RZkUTUcdKeMuSKpHDWxEY1NwYn/kf16Qv84ZrpjYKY
	 M+kYvQx1DhI5gZOIsM5zVRgij0gn3SZgtIauovmXejIh0DPn/YNorwfxQOfEwkbW3ahGF
	 x2IjA4z+2WHKYv+sUC+SZwMiPwb9tSEiFNJnbqHGp99npkM4NmlSHDefhhXZ9QL2I5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QeSYZZBSKoLuliFiah1nYjHZ50+xCIiYrRcjsFJbOlU=;
	b=BzoUFQz93Qn1a7UOLW+tUTftaVKTbSqsaxgyAQ9KuLZegSMOUEPUJ/hu3lm6Tae2u7a1
	 iNrBFmI+W9gbSmyUVDLvDq182yZJTKt/jLrXoatubaxB0ltqxkRqa/V+gs1gnsa7tFMrg
	 th673mTEq6Zd1qgBjfU9yI1fDQ1uWUDxgGr/iNILbwOrq/gBYq6asZ5Kzkwk7iZFF7bVW
	 i2d0UiJw/+PQeK2lhziFmxoH1rDNLC3ZdqpffwgH/dBkfVxoCHRCQwGqTLmFQvf6Hl+1T
	 2he2c4YqO9uNMKIWEPCCo6WeNsxTV7sUeJvL5f45trQIhLd1x8wgi9vr1/jZO0Fj7bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+Ol474T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A52606A332
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 07:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A52606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+Ol474T
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c154a41f8aso70195e87.2
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 23:56:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794556614; cv=none;
        d=google.com; s=arc-20260327;
        b=cLNf2dBJU43kqdjXvbZ1sWplm0auNBFWtz2897luciacIRB3uCnH5KJFyG8rLXqNTL
         Zr2IRHRM9RUqLmbhwnfpF6UITgd8B1wx6hiIiaVnz91aPhkGVSNLdDvR63P5KSTKC83O
         bBQUdw8ea7Nzmxb0Mor+lcLr2x2vNpM6veTFMJIQs6ZlwOK9dWBbGWUQu3IBBdDLS4x2
         qC94ZTCtQZV3vsSEeExj04KOtq/3U8MPLfggBko1TUQxPO5C2+C9rrQVPjVC3uiXHR0g
         MrlAVeYo4nDIQN1af5GUZ98VdJs4lp5SEFXZsnwgtTSNrixKmIuR8vE5m3y2FCiD2QrT
         EAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QeSYZZBSKoLuliFiah1nYjHZ50+xCIiYrRcjsFJbOlU=;
        fh=qM+PmzR7if1bFqMuLRx/uftfpEzIxjEB/LMjD57QdzI=;
        b=mazTpfGFpgz+HIpUPiwA3FbwyccyKGmOUrpGQzNEgfA3CNzXYL/tip5dv1OeuQ6qYO
         UegClD9fnIRU+/oi8SkfIDNN4+sZAbe/tRVaws3Z5x1cg/EGG7x+9NjuuJT40p1tKLbw
         ymZxJ3tjBaLniadOVnLtkKOs9OMCkV0d0PU0LHdRURjGZJoifwzLAfVdKG2Dd+hmsxPF
         mt33JYfZ6QJVrlSFykxUCmr8Mq1U++N2J99OvWSwSVM8vkwwtCOfPHcUfB9msx2tfqjh
         d7wQ03HYob5FEvoBJtcgIc/7DRrjuTBWL+hUPjFddgR8lj+7Y9HozmXW6wH4K15eK+al
         xeIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794556614; x=1795161414; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeSYZZBSKoLuliFiah1nYjHZ50+xCIiYrRcjsFJbOlU=;
        b=t+Ol474TiHXR64WV6DKYk9zkA93L8gQefF8fgX5287fzDQ/BKqWIaxBvQWxZw6hvYn
         ITvxhZAI8Za2PmToBFvh3V6f3BxejsWQgIGDnQHcmySOIU/D5hAGJPtEkz3WBQhbMn0j
         C6Izgb/0KAk28euBbg9SyV6CgnN3NvEf2iB9jHlj0YtnTDdS8zJwQMgwykNQdO/sEd84
         u1wp+LaiLhr44AcJ5xNMldi475/OXVY1Fm6AbY6MV6QliPa5ZCUCOdtA5VUTBJ6et47P
         M8iPNS3MjHNji2l0kEF3C3C0xhzaC2HM2k8RMLA5pZXriAbP2UU2HVjYqwgpPW94SmFF
         duAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556614; x=1795161414;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QeSYZZBSKoLuliFiah1nYjHZ50+xCIiYrRcjsFJbOlU=;
        b=SInK694D3Kwc3FvHb9nU/Y0k7Scx6H/FbJDreV6hC/SK+fJMmHX1YWhtEeiGUpuvS8
         qCNoym10b9ee2eDJ5xJqQowaEpmm7bQsEUVMJRuJ1X7p29GnLG8ncHNBvfZG0EGEZjDc
         U+TIN0s+mHswJbGNRyK6cK9S95sROK2S+f7n1Hl/EEd200bprIvZNOIdgZVZLDAiHEYB
         ksqF3jK/9+HqnegWeKgSi0EAzZTbtWugz+d5GiVqGm/wAk4MPTV9xshE/FaNbs0tQ4tE
         GONTtgcGdSevvZJvKoLIocljXUQfpuXhBMMM5mQ5YQaRc6VVNF2z1Qhm6PBIY3zWyJuf
         nl1Q==
X-Forwarded-Encrypted: i=1; AL+hErHwulEdhNWaFfVsx0gOOho27sW5Tl18sHvNHwf/8HN8RU727unEwnLAX/Z4jzKIDPBf0DXJYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z++MJgb+rUyZGz/lYBjDNbgTX9R0FqS1wtRWmTwwVmsxnSsa+zQ
	0R8gWb2TRmfoZQwepWgQgVrvxI1uCyXFpGiqgNbjmXjVR3YFQPEnuzyKCYjI52G57t7qD3A9Mu7
	eS4WqYwOE6dF+cA8o8q4gHOhUhOrPqtM=
X-Gm-Gg: AYBFou2oV9pAMzYcqbQVaJIEu7akpjq4QXDckBfFS8afDCTk+a7U1baDl8ENoB5FbDs
	Bu22Rjzd3U7k/QwIt5R+R3s+E+USZzZEcYfrzrXK+VK5TLZttZ/GW0QC/K2dg18u/zerq+AfvC6
	NG1NUdyIudbD45+oZg8/4UMP8X158Bb9AYDkMU/tOuJlCcF1Z0ErDUWJNuXDCh3kUrQCm/UZXTz
	2fp+oDJ9nv0AmRK5HKkBGBu83bmwbdslgViV6SMY1MqVd+en8r/7KKg3tQSnnCp43dsDpGPDICx
	WNoz5xosKQA48gmFRunFd8vnJrVq/5cZdws2gL1fxfk3ynaei9UwYDVDDANaTPXHIehuTlBkzqO
	Iw1226adwQbVNwLiCohujhvSbBrFCYHBqgLHNtGNCgrCU6nne1RcIzaxo28cyaRWWGBEpSzo=
X-Received: by 2002:a05:6512:39d4:b0:5bf:a48b:7827 with SMTP id
 2adb3069b0e04-5c1705f074amr884635e87.2.1794556614399; Thu, 12 Nov 2026
 23:56:54 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261112-smmu-cmdqv-leak-v1-1-7ea8e34277ea@gmail.com> <avXBEbkBJ1ZMZ00B@google.com>
In-Reply-To: <avXBEbkBJ1ZMZ00B@google.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 23:56:42 -0800
X-Gm-Features: AclHuK9R-O6Gj916v_Gk9doDaM56nfSpW5aT6J15ATtqrTQAWDgJ4XngFSKQD_c
Message-ID: <CAEy9hNX8j9FUrZBOBo3aU41RSif3_MvtSQaq=eY2yXTK2yxJnA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Don't leak the CMDQV device on a bad #iommu-cells
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Ashish Mhetre <amhetre@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> IMHO, it shouldn't be worth it
> to fix as the FW can do many other harmful stuff to the kernel

Agreed that it only matters with a broken DT, and it is a small leak.
I'll leave it to you guys as to whether you want it.

Arun
