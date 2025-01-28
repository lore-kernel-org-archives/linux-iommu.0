Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAE1684AE;
	Tue, 28 Jan 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065667; cv=none; b=XkTbo34Z8v12SYCs00kBrGP8poKrBp4OykHFn7AjDb83s9KfCatXDpqHj/G5R9rtUzrRDyj7ESeee2XCGhXGeJxS4dwyKlLBVIbHfq89M0PhvCGPXc7P6S4m+fhL7ERZVXSQVIjR+T98+32RLtHvxJwniF4Pj3TK+UliRalwpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065667; c=relaxed/simple;
	bh=xpJTzOmYjLgkVVj87rSt/7PYVQyiVHH5fSaPzykcEVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/UZ1Zu8Uruc0E+P8Yn1px16iHZMH/hak0TXrf/YohwEKE8z1QLNk9MYbtlWnrWwsUkMvE1Xjtop47cupgNyTdImlN2Mk5005rmj6IeLnuWzpFJGRwZPAQlyEVe3kL2XJjmUerMz1ZEOTLIz6TUha84614+dFJhZyYOA0xPoBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=JbWxxUPx; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="JbWxxUPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1738065632; x=1738670432; i=linux-kernel@simg.de;
	bh=U0/x5qe5stDPCwqHI+p3L7oSyuu2H8sxFQPnb/V3wPU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JbWxxUPxfSVsJmghTfEpkJ9UU+CkTnC9IMCvkPJD6IJNRDRuyKut62E0xjld1hx+
	 UWKqJmS8HwlrBNMGigWSwosqtsUvC+xMZs3OTYgiAWlK0PR5gimXNB7O3vVTi474H
	 rkTeu1bkfyhu9j6/Bn2X6SBjWPBjWx6aaXJ/xrI7/+4Oxhij+0fPkpzbbB/FOs/U5
	 fN+oVSIiYDQeVGTzMYz/i3trk6rSVl/7ni3yYJFiPIdBCs3H1L3dd9hH6KIHnexF6
	 3hT7fALmILiqEaF9bXhEmKDU0+mVRQSInxdwkk6wjtCswXNYx4C3lN/kzyM7s/xvw
	 VJadncsAvmnJtFpgRw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([93.217.97.102]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFJfN-1tfHVB1XmT-002zRo; Tue, 28 Jan 2025 13:00:32 +0100
Message-ID: <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
Date: Tue, 28 Jan 2025 13:00:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis <linux@leemhuis.info>,
 bugzilla-daemon@kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Bruno Gravato <bgravato@gmail.com>, Keith Busch <kbusch@kernel.org>,
 bugzilla-daemon@kernel.org, Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
 <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de>
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <20250128074133.GA22435@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0xCJAfjMYubxbGEgPtCxqzctYDQxN3yrAIYAvV6PMdut0Wwj5Dj
 a2sMyX5o2R7nDakd2nh43sLhcxf/3TEiwpMny64DR/wCGKLSEa5UVkttqN5LJIjVV1J9DTP
 ggiwDOPyHU1MDyky4X1R21uuZSdQtolNKyp3mbVRXtE778ORjFtQE1NjVnw0o62THIZMlyJ
 PbXTWCGzg2hqCo0apKe5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fBzJnF2uaQ0=;LOr3gsDGCslIx0onwALY7WEb4rg
 s8CCiTJVWnC0vMK1qzIjYuexXtWU1c0gCDtRKLQjOwzcFi58NziwvC77Ba6+v99MqDjdvwKCC
 3oMmlAWinIQw1M2NmwuRsB8oVVot/bZNuUscnMO1m8v0LrqT4J4HyFJA0EtyH9Z88/Txp6PrR
 I32htEvXH4H+Q20Ot3D7Z4nN2R3PKVPPft8kJDHUfNPl9Jd3NTyRIchxjdIk+MrgMPgQI4XuS
 BD60h0z2lFISx6YPBfaZZKAAqPAptpG0vS74ddIlyEW+sc9PYcF3LVOwbpL32wDiqSgtAOIYb
 sqWXPBfCiM3CSZuKbQh/5kHhFIekM9Le8DCeeNZdIfEqn9mJp6BFMnRn/MkVijGWIQECqxTiD
 oFzmGuLJtfgrOnfUXL2Co2v7r2+iRDjYVtLDuiO2lO3OOBiDGzoSy2wypQl11uWqW6ED35BGx
 W6AZ4cPpbpv7e7JMp8/J8YABa9IQaeV8KbDUo5QdDEI35qcJBtZV2AB26cSlzt3tUXAQ13444
 mNWZe91X3xU6RJOn+cesyL6M8ZLuYVkdBpqZ9vRBdE1vG9tRa6KS3bhTZ7Wuolc12rvguCJbf
 1Avf7laZCMeQAjbw9519F5PYD/DEBF2YBKvjqilUdSXshss7ZxzIoQq1sTxEyQtkhcEaDgnWo
 2wV/8dHvUCjxAvbCdLJZ5zMCdy+DDTwvHJbRqCh10kg5pXOpvIZYzzcdxuNxWslcmSH90v/V2
 dukavZEvSE4HYUoawemPI0QtvfChhSMYq6Uj+fCOaEmJsKlmN5Qmnzggn+nXs2+u30R7P0Un9
 FLZHCNjFjSNjIw77kritfinQ2GTlAzhh84zULWNBu4unJeYYBUeITPYue9hkMGgVzxTdxivL5
 rrRxXQ+AuGyyyDFzKCTfJPmYfdBZozzHjjD+CjO97NiumD5lg739Ic6oqNVxL6QBAzd5s7H9v
 MA0em+WRBOz9d9ANCDL/TbI3OzIXY+yJqjbxxb+cnYkKqxy+6IQpQ6wdcD5QKuw5Ufnejl7fl
 0gbC/ccvkjsednPE74jjplX3Mjz4j/AoJ/Zg9L7/Vk02xsWTmLYnl4McoIBNk2m/aA2ogq8p2
 Xp9oRBuEOCjj6n5DuagNQpLshJjSP/106kBf7FkZJC+yq/o/19uG/qm7dQpXsVc37xp/nZaMk
 =

Hi,

Am 28.01.25 um 08:41 schrieb Christoph Hellwig:
> So basically you need a specific board and a specific CPU, and only
> one M.2 SSD in the two slots to reproduce it?

more generally, it dependents on which PCIe devices are used. On my PC
corruptions also disappear if I disable the ethernet controller in the BIO=
S.

Furthermore it depends on transaction sizes (that's why older kernels
work), IOMMU, sometimes on volatile write cache and partially on SSD
type (which may have something to do with the former things).

> Puh.  I'm kinda lost on what we could do about this on the Linux
> side.

Because it also depends on the CPU series, a firmware or hardware issue
seems to be more likely than a Linux bug.

ATM ASRock is still trying to reproduce the issue. (I'm in contact with
them to. But they have Chinese new year holidays in Taiwan this week.)

If they can't reproduce it, they have to provide an explanation why the
issues are seen by so many users.

Regards Stefan

