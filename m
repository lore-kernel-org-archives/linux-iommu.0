Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20991A2632;
	Sat, 12 Jul 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344587; cv=none; b=h73riY7SVKKjqzi9NPjwRvmgWQ3Bb2RzMWnp84hAIioPsh+A1ps/AoGiSpHTJBS6yLuYxeKAN8lTyHWbqsyDzRNnBq0eSv6+FlCEzlX+bRsrSor/jznVWaoySv1x+3USqgiTo+zt3U74hBYjdSwFQV4GUrb4AY1B+2SvHk24kZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344587; c=relaxed/simple;
	bh=b+Bs7IErZJ67yIW9uXaQ0UvYB7JXe58jAhj0T8hXE7U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WMHIi/mGnrmhfERkAIEYkWe+d2dAxOAq16Pk0S3eCndMxIdX9y7xGnTu9l8Y+mXKhK6euKSnYuX6kNghD+JUCYk+I+tn5+RjLqhYINPm9c5kbWEgEWVRiG04uPfB8NbH33O+BS1cJ2Fb/LgWO9XABIKBR3d1nFfp3fWfrAWuj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DhFbAwcZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DhFbAwcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752344540; x=1752949340; i=markus.elfring@web.de;
	bh=b+Bs7IErZJ67yIW9uXaQ0UvYB7JXe58jAhj0T8hXE7U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DhFbAwcZ/OmSvFH/R/jvmAMR1Jq+ZEyd+Gm48Yg6Gpo1MhgywwBxEOQrzbnIDXcg
	 dBt870M4FGSjqbqiPPM0YTqd35AV8fxf7S+Uj5fw8PiaQI6H9zr1es+PD+9zGmBvW
	 jzkbYXnuRit7+YYTDWzO9WKfBZlPijZ3vnIR4/cis3jON6nA5aQXfO8K9NeV/f5r4
	 SsKrRFBVfMQWxIrnS4Ybres8t0S7t42WZ5dh1gtkE1ptGaIGOBg7o1Hk7XSz5h6LU
	 sKcRFYaaNV5FD3Nir1JbmfeQmZRwDbnlT6Iume7+VYtohn+TBXyVJadMstUtqm8mk
	 2f4obL+mxGQ3LvVhBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.234]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M76bb-1uZIkF2fEd-008zWN; Sat, 12
 Jul 2025 20:22:20 +0200
Message-ID: <0fb8863d-24eb-46c5-b52c-20313eeba5f5@web.de>
Date: Sat, 12 Jul 2025 20:22:13 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Shurong <zhang_shurong@foxmail.com>, asahi@lists.linux.dev,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Neal Gompa <neal@gompa.dev>,
 Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
 Will Deacon <will@kernel.org>
References: <tencent_22664B08ACDCE35DE10E5546C2FB26B59605@qq.com>
Subject: Re: [PATCH] iommu/dart: add missing put_device() call in
 apple_dart_of_xlate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_22664B08ACDCE35DE10E5546C2FB26B59605@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Pe6yXbnwhB4shA6wg6JB/d+e6tqUGqjSO6FJF4QxQFdwjypJor
 tU2Zr3uOtYSZMgBTlERCZxgJQop3PZVmTW5KOpIUtv3fmRHcOYEmkIUBo9xS8VKj9LETL1x
 HuoWZPoMZj7zUeWtrIw37uxp794pA5MOj309vNRdjsnqa1dBVhq6GAdVuWvEqXdA5eu6Pox
 jgVA3WaEU8PAN5gdHIBMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tsooBNPohCE=;OK1M4EhaYLfgT7yg3RO/lKuuxt7
 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
 WSz7WxdKHPk9nrOjh/HOsElU2jMf89uSkE7

> The apple_dart_of_xlate() function obtains a platform device reference
> via of_find_device_by_node() but doesn't release it with put_device().
> This patch adds proper device reference handling to prevent memory
> leaks.

Will another goto chain become helpful here?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc5#n94


Under which circumstances can the application of the attribute =E2=80=9Cpu=
t_device=E2=80=9D grow?
https://elixir.bootlin.com/linux/v6.16-rc5/source/include/linux/device.h#L=
1140

Regards,
Markus
