Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7A1CAA87;
	Mon,  3 Feb 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608520; cv=none; b=La6JoWW7tqsSFLxJXjNAyTzm82C0K5pHkGFsfrC5EtpM4K8aNB5z/3so2+H6+UevDdPKRJc0Z3Xt0WetLAeeLL9eSoiHoQsNsNX3UreaTAedaDAUaAodxDaIi3aZVksMcBpnvKdiCIeXKL79S/lUMvQzCpkuFM4lS5vtRAdwo8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608520; c=relaxed/simple;
	bh=YFnj24VvreG7lG3Pu3vMo/s91BwtpspZy+voBLJyXRE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P9Am2o/KkSf8NkwdNkw+Y/JeK7VeX0ioslq5V7i1TdoMzgTquiOQwc9duLfZb2LCXXd4e7OMtvTLLqpIpLNA/TQThEAGmYu3uJSzlJpHyFKrcRTe0XbmmQgMMNMYYBChDk4z0HguIbyITh3gzzPq4vj1E22FiYDAD/DfYoxXXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=yiR3wKc6; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="yiR3wKc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1738608493; x=1739213293; i=linux-kernel@simg.de;
	bh=YFnj24VvreG7lG3Pu3vMo/s91BwtpspZy+voBLJyXRE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yiR3wKc6N+LWPS067T1xEU+aA9y6KP4KMhzLXslFRPH5jN6atOAmeUyGOgDt1upX
	 DFQ6lPL12Tqm8w/ieZPfdA4Mr2jaIs9TubQ473itbQKpz/EDdEjauO+Cp0NfAOnEV
	 rOr/mf/M+4LQL6VAJvL4D4nnvce8HLDS7/Kw7ybPL7TrFfkmW5ffeT45Iw0RYDOR1
	 7Fj+B8NAg4UjJMRVwHvwJPOL5o6Ddlqlo3/0H9uPQfUElW6zi2j/v4oby8T0pPDnh
	 7pf008CFkuGUCcSImsUOtwYuZ4V4GZYcup4dvVcCVD0a+Cm/xiIKEwhC7idDPrsjE
	 fViNGSeWiFU1q+0Sbw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([87.158.47.249]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLi4W-1twgrk40Dw-00J9ey; Mon, 03 Feb 2025 19:48:13 +0100
Message-ID: <4270c0e3-161e-42d5-a6d3-f16b7fbcdc00@simg.de>
Date: Mon, 3 Feb 2025 19:48:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
From: Stefan <linux-kernel@simg.de>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, bugzilla-daemon@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis <linux@leemhuis.info>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bruno Gravato <bgravato@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
 <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de>
 <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de> <Z5jTKTfKUeLm4uJT@gallifrey>
 <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
Content-Language: en-US
In-Reply-To: <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f9RM+83asFATTdzAoEoXNJJMSOExToxSRQTNr1E6qWGNJeaLQyF
 S57KAWJOB+/4BcEw0KqA8LEijhiaROxGbBCO9oNzEdB+I5IZMFZjuAyPDC0tKYdxmsazgxp
 ysc7W1hd9y19As35jwU7UbrBmNWD/rCMXhFwW/te2drR5fFK78p63usD/fHv29p60YV9224
 FwJ7Qv93NOltqeL7F9e6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2xs3pvJSyk4=;JuSnkWSq5ZJcSuUA2ef0ZXq5+QD
 VPYJJN6027rReFn8B88BuG1vvhSS2i+1Q590jL+YMsbv7HIs30TjWnI1UrkeEgIPXei7gzJSa
 ORpYgs/q6c9PXLtzgVfLKBkXV6m9HlJGxWwj6TX0zkKeDURd/wStDyWdbDAwykSd87amuYb34
 /oQDSM17OH+9UTQv8Ms1neV/XX0sGioTuE8PDdPK4Dieeq91lQ/feXYiJ3J4CYHWARBL1qhZn
 TkfTsks7/lpSlxOMEgYUWs61eBNFiBHP0BhO2e7jqKT5s37EN8iLKMtDLzGAStFWOKdIpHQgS
 k2TBu7gqeQg5F9Eam+GfAegQmCxOVjJu3j+eyKLDjUp0rFPtbOBGN+Y/upciBTODiC1WrPEAv
 qw+SkljIZHPZvO7K0yk/M7g/QVtvuRwgbJ1Prqmyy7f58y4UFrR9tXXERjszjj+f9ENN9Aj/C
 SjOcYyXWil7G0B75UoP0yfe6DUdAoDsV82Zn4VvgLNdU5GKXXwXBjXmgHSmUhO2n25lFt56P0
 u7eL+V7IVCV5ti4fzx/l55ObG5lznIx3Ha+5unIGJZYsK9BKWqx6Kd+vJtM7wX9uRUak9DGqG
 cmGPxo2yPn20bSUb/rBIjo5J/FHzm8zmrguObQ75kIDZTKJ+B1HVnuXQi8ABqoQ5bCYF6wTyE
 hDTaMpQKV5ACXYbwugpE1Bru1j87KCqsg7rkMv1jrJvTDHwkSOmJd8iUHy2jDp99apx5/JshS
 YKQ/EDUJxIBregjnsTm62ZFrqtEc5xLeTvs6Xpjvz/W1iZJ80ylymKNeXzwwCByhE2ZCxNdQU
 THznIZPBG6in2X3qNwkvDuK9f0Kaff/AmroN0YpDbRBlFTHfEplHJQdvHoymJ5PtjIt5xVCG3
 iluRtHgEwPGXjIrmLMG9iwC0Jp+HBWF6Hw0mS4GpDbnLSi11eqAVAt22p7aQsj07o7XvEg8NN
 Ja+OZsugjjk+X+L9gyixyMgoyL5W8KR1bYsvPZxEw4rk67gzgn7xeDEMOx7QOJvkS78gggD+Y
 azdgNNG8q+zB7TlVYpce8orMjIc7ljh/Rt38fV5b6Jnveh0fKD4z+um5KLudCb8mkr/ue1UxE
 08nLbAlUgxFlJJyEqlg8HwMeVeYVNWnesqUJ6eRLumNd0633xJk6K67vNHtQbISYfLNyByt7w
 bXYc80U+6zrwnpQWgAjU7TToOuD90Uq5m3/P7HFqK8SMaAKF26255VoCAPBukSRZkAg3YNZKt
 BL5HyeAW1qZy4JMcTOrrl3nGu5dEaaoodslX3koylONNCHGnA+Cw8m0=

Hi,

just got feedback from ASRock. They asked me to make a video from the
corruptions occurring on my remotely (and headless) running system.
Maybe I should make video of printing out the logs that can be found an
the Linux and Debian bug trackers ...

Seems that ASRock is unwilling to solve the problem.

Regards Stefan


Am 28.01.25 um 15:24 schrieb Stefan:
> Hi,
>
> Am 28.01.25 um 13:52 schrieb Dr. David Alan Gilbert:
>> Is there any characterisation of the corrupted data; last time I
>> looked at the bz there wasn't.
>
> Yes, there is. (And I already reported it at least on the Debian bug
> tracker, see links in the initial message.)
>
> f3 reports overwritten sectors, i.e. it looks like the pseudo-random
> test pattern is written to wrong position. These corruptions occur in
> clusters whose size is an integer multiple of 2^17 bytes in most cases
> (about 80%) and 2^15 in all cases.
>
> The frequency of these corruptions is roughly 1 cluster per 50 GB writte=
n.
>
> Can others confirm this or do they observe a different characteristic?
>
> Regards Stefan
>
>
>> I mean, is it reliably any of:
>> =C2=A0=C2=A0=C2=A0 a) What's the size of the corruption?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block, cac=
he line, word, bit???
>> =C2=A0=C2=A0=C2=A0 b) Position?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e.g. last =
word in a block or something?
>> =C2=A0=C2=A0=C2=A0 c) Data?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pile of ze=
ro's/ff's junk/etc?
>>
>> =C2=A0=C2=A0=C2=A0 d) Is it a missed write, old data, or partially writ=
ten block?
>>
>> Dave
>>
>>>> Puh.=C2=A0 I'm kinda lost on what we could do about this on the Linux
>>>> side.
>>>
>>> Because it also depends on the CPU series, a firmware or hardware issu=
e
>>> seems to be more likely than a Linux bug.
>>>
>>> ATM ASRock is still trying to reproduce the issue. (I'm in contact wit=
h
>>> them to. But they have Chinese new year holidays in Taiwan this week.)
>>>
>>> If they can't reproduce it, they have to provide an explanation why th=
e
>>> issues are seen by so many users.
>>>
>>> Regards Stefan
>>>
>>>
>

