Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284F1F417F;
	Thu,  6 Feb 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857496; cv=none; b=UU9z38z5kYzcBNCGmIuvNokQij5H7hZDYprOV1ahwpSdOGP9HZFV2YTISeqx30gpU1z5jWpbvhrP3vNLIToIHb4p237NNw4ZsuTOwbj32fWKFU4rtVZl91T1eUOioFeOMg0nt76UtSKrC2BTSi/fld1xniiagXxhcoEuxwfsj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857496; c=relaxed/simple;
	bh=gWHYsRpoJpRnvV1mzCDmHcNTyR3nkauywhnXfvlkd7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BTTIzLYe9TxydiS+/LkiagvrlhcYXLJtZ21XB2fxlMTP4e2BSUVBStufUX3erwFVO3rrN8zLRVJeceXH/vMMllMfKHVUdLy8Uc25Dh04DA4QBSIg7GAXymdBVnm3ZKUCAhkiOT5xZC87pyn7IBs0/nX3pMRwqqYYnP94HmjWu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=g/2uuf4N; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="g/2uuf4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1738857482; x=1739462282; i=linux-kernel@simg.de;
	bh=gWHYsRpoJpRnvV1mzCDmHcNTyR3nkauywhnXfvlkd7Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g/2uuf4N41dwRDdtE5XovlH0pNJ+3JvEL2n0YhZf2Q2I/d3kHdtATo6dn37MwQOR
	 PB2O2srh2T5nUf140Bl7tkeRoXoFqifWs/Vhfgw5vB3b1a/IicaONZ0mof1H+6Rpb
	 5qxhLxcnI1FZ3NTK0HLSk7XK9o5GLeiWDvoR11Tk4y+KiEYwdY8RZMjN/ZFHeHGD8
	 DwsxbjjZZc4CWDXq7ps3nrFnMMH+IL7KTAU1BIMqqkWs/5aAP415KJddziLqRgzyb
	 fpQZVXwo0IgYLvd3ufAPc1G3RePSPYslluB0EhFCKgqV1wRLpwG0fGpDhDEQvCId9
	 M0bxJQ6i+suW1AoScA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([93.217.105.49]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4A1h-1tFm5Q3XA9-00uuIp; Thu, 06 Feb 2025 16:58:01 +0100
Message-ID: <45fe8146-ef86-40dd-919a-eb6c9438dafa@simg.de>
Date: Thu, 6 Feb 2025 16:58:00 +0100
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
 <4270c0e3-161e-42d5-a6d3-f16b7fbcdc00@simg.de>
Content-Language: en-US
In-Reply-To: <4270c0e3-161e-42d5-a6d3-f16b7fbcdc00@simg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1tqh76+Har6RGaz/VaE+uZWjGChocgvAqDX3fJ6YM6Xm05pPfu
 u02LSLCjBUwq963vTx14rAiS/9tuyTILfPvBfZfEfOzEcwFpVJE2UQ2NGGG78ArPXis3ono
 Cp4PqPu7HldeU13zkGXnsY7dAKRLfc2xPtA5zaDcn/lRBWRoxpzI3/3sZbaySecooGwSwGi
 Qvc4UY1pS+0WAxj1U/auA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aJV2oV3/oPY=;3FuGEm5c0qzlztPwYlDxEaf8mJH
 LVd9FiAkoy2Wxy1jQaEwA0Yw7HOl+pq2bzZNm3dNcr70V6fMd0jM3AlzCZw0gEilhioUBOHTL
 rQFeRpALCp2FYGP0KUln9E22IIrCdwcpbly5gsLRmgBa0AE8krEdyMTknv/zbwUjgay0ORjfX
 6JH29MdTN4M22Sj2A+WoN+1cPgxXt7NZ6n2qYNeq7gbYBtrrnoCxZDyfdX150angd5wNju8Ab
 d3ddZJFLUN/kyWtGv4N07XOGWFdJl0JQERIUtHfbLiKJA9KTOFPPsJM2lNOkMgBtfvqBFDxEs
 t3CHkTpsuQs7NAn/bD940ipN68zT1yURU2XpoM5fX1wZ+2AtySUfxdjB4S/b5pQnVej+AczfQ
 mk/tQLRmDskFEpajmSVFMsForIUALL52IL57q+gwVKVNNxy2y0lgpKmkw6Mpc8XNcshkOhyZT
 uwHQ0meZ3CX1m+OZRIFNTx5/QoIDX+E2WOXfSCWQvJJGmRUsV2SB8E3mODqYQNfJzWbooe7XH
 4aJ7QSerllN098muhfqgH9PSF+EV8IBP/pScS6i2hqjLcaaMbNU7bM9QgfKtrPLPn2F8WD2it
 7jI5OGC81JQAHQHEMuXLrlpYpILJsNpKSXsda1siW4V9xhdVEB4Qfx7wZl41Cuo08cEQPxODP
 iFsbng3AAhsHpaQbpd/JlFcdX4qak7N6Bih4zVSqhc+F66a4q4a4gc7VwhHikZrgCFxQ3CkHi
 QR0Nqv/zFg1MHlww9wdNxzzKUbbAz0xp4dOerq2YUQg7c2WTOnuC1KHUy72KPk11bs80IIWhO
 4DIrFygycqR3MzaNyHQ+CKRfFt9FLtyjX1AUEnrVfHNQQFQ06hkqpKykxQ+PHP4x0LV+TCgcJ
 vSrTT+NgfVJvb1WqDJqlODSc/iZTK1aDcigUWBPLYO0oRVZJN3DjGCYaB7UmA+i3fiea4ndtK
 d2OnCz7I38w8TavHM0w20AHEcSN7esOuqi7rHhr1LEYZcMFodaNvT09MnCq/eZymleiNel5uy
 dbeNHUMie6DRNA5f7KHunct59Q/C+htaJriCN7p32IJe3oBreoTNDCtGXY+u5p0IootktNeGe
 bsqdFZmPXNkf6W44/oYoupIPLK5MXuyJ9sEN+RHGlur+XOhNLDqAgvF896JT9ZWUDZ9hj2s4s
 GMNHrLp/X452/sZSm+cURzh3/f917v2ib3qGASVsGlHs4a0G9gooCkl4MIf2LbHFTLDu0IiQ5
 KD8KxgdcVbZdG/1BbS3vUJX380T2CBKK7jngJ3ahrIwm8GmAkkQSJ/wwbbzTffF+PUEkhmbD+
 Xp9rVq3D4QgFOXyBZLouQ9/nOBvuePGCxJ7Xa7tsUlEuKR+i1F5svb5CVw//ilqQALlxxxepy
 /zw2NjHASoINbWfw==

Hi,

after Matthias was so kind (more than me) to make a video (!) for the
ASRock support, and after I once again referred to this thread and the
many users who have the same problem, ASRock is able to reproduce the
issues.

Ralph, all tests in comment #40 (including the network issue) where run
twice, because I did not collect logs and lspci outputs the first time.
(The corruptions seem to depend on which PCIe devices / lanes (?) are
used. That's why I also included the lspci outputs.)

(As announced in initial message, I cannot run tests ATM and for a while.)

Regards Stefan


Am 03.02.25 um 19:48 schrieb Stefan:
> Hi,
>
> just got feedback from ASRock. They asked me to make a video from the
> corruptions occurring on my remotely (and headless) running system.
> Maybe I should make video of printing out the logs that can be found an
> the Linux and Debian bug trackers ...
>
> Seems that ASRock is unwilling to solve the problem.
>
> Regards Stefan
>
>
> Am 28.01.25 um 15:24 schrieb Stefan:
>> Hi,
>>
>> Am 28.01.25 um 13:52 schrieb Dr. David Alan Gilbert:
>>> Is there any characterisation of the corrupted data; last time I
>>> looked at the bz there wasn't.
>>
>> Yes, there is. (And I already reported it at least on the Debian bug
>> tracker, see links in the initial message.)
>>
>> f3 reports overwritten sectors, i.e. it looks like the pseudo-random
>> test pattern is written to wrong position. These corruptions occur in
>> clusters whose size is an integer multiple of 2^17 bytes in most cases
>> (about 80%) and 2^15 in all cases.
>>
>> The frequency of these corruptions is roughly 1 cluster per 50 GB
>> written.
>>
>> Can others confirm this or do they observe a different characteristic?
>>
>> Regards Stefan
>>
>>
>>> I mean, is it reliably any of:
>>> =C2=A0=C2=A0=C2=A0 a) What's the size of the corruption?
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block, ca=
che line, word, bit???
>>> =C2=A0=C2=A0=C2=A0 b) Position?
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e.g. last=
 word in a block or something?
>>> =C2=A0=C2=A0=C2=A0 c) Data?
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pile of z=
ero's/ff's junk/etc?
>>>
>>> =C2=A0=C2=A0=C2=A0 d) Is it a missed write, old data, or partially wri=
tten block?
>>>
>>> Dave
>>>
>>>>> Puh.=C2=A0 I'm kinda lost on what we could do about this on the Linu=
x
>>>>> side.
>>>>
>>>> Because it also depends on the CPU series, a firmware or hardware iss=
ue
>>>> seems to be more likely than a Linux bug.
>>>>
>>>> ATM ASRock is still trying to reproduce the issue. (I'm in contact wi=
th
>>>> them to. But they have Chinese new year holidays in Taiwan this week.=
)
>>>>
>>>> If they can't reproduce it, they have to provide an explanation why t=
he
>>>> issues are seen by so many users.
>>>>
>>>> Regards Stefan
>>>>
>>>>
>>
>

