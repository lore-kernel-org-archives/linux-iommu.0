Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C41A841E;
	Tue, 28 Jan 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074283; cv=none; b=KjCyUav3iL8KjCCsKbOd/2XGDxDRBHdNsdLmgiQASSj6FZxpdfxNgNgDDzx/M/JhRJaLx9eYfrXSl0p9/ZlY7YyLDnesKronY+LhTruLb0MgLz3S1sEX8gB2rrAacZ9GS0vG7+6HaWO1dbPLo2f1hyCX5keiigwG5x/HzCM5uwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074283; c=relaxed/simple;
	bh=W+UEOhbFx/rklJvMkdqpyyUT1DddbYt5ggnJeVz08EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+1d1TPJyT6VhEZ2BkBEwSsyDIbbSdbTngIil70jLdXpdx5BoLWa+hkEpfEAm0ooUmfk4DOAuhVNTD6EeYbGyz2h+XS+6p0HLOXkt8p36+FvavWFtWVqnsMJVeFmmqWN84mFB2j8iqYyBegVaqLzRbzAll0xbgxy/lPr/Vreg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=xvL3OkTa; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="xvL3OkTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1738074265; x=1738679065; i=linux-kernel@simg.de;
	bh=mSwKFariyFIkIz2C7OT20lJ2HRy8/iEqy4unexi0ZWA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=xvL3OkTaqrOxzUzsTJ9Ai4OOU+c7gS7MB4stk50ObOTOnlDgTvJeFWDnzyNNykHe
	 pZC+QiSV7Ei6l5jf2O3uxBpiUQ602JzZdM1asnUqVQVZqcW9K60HoTUhfx1j9KxlA
	 kRMFnCI07Bppr/ey2zNE5jZVIfVQbCrN7HyfQNY4zlofGfxWmVXL3KNzmtuOxlNV4
	 5mTw1gorLn55IYupGcQCL3NSQYQ3NrrGP20rzaU4OuFhfEYt80fWIctgUPBMjsFZy
	 trjO9SS6Jahv0bf5Y/FArmTrfB4lSplYiyWqB7X/wL+nPsnBxf3GiRXpfqN2Vbnw+
	 kj1yLqJOpOqxRP9v4w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([93.217.97.102]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRVy9-1trJFs0Yz7-00SCYr; Tue, 28 Jan 2025 15:24:25 +0100
Message-ID: <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
Date: Tue, 28 Jan 2025 15:24:24 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: "Dr. David Alan Gilbert" <linux@treblig.org>, bugzilla-daemon@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis <linux@leemhuis.info>,
 bugzilla-daemon@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
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
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <Z5jTKTfKUeLm4uJT@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/P/SH35o2dcXOOcdHEWfuB7XIuUjpuAcCyL91L8fn3Gf07gYgGe
 opGiETDLtflImCYl+epBa6MuxfJdJIlbgMkdI8xpPOj9Q/IFJNGvEGIjDL+lJ+igD1L/rU9
 2gQvfKdRN5/QxRmcJ8YLg7xzzqLf0u2xbG5S2N+zsq86KTYkjebgEe4s7pNMjjP7mTpyxOS
 GFut2iv8qumgCQJijxMTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Utrt6PODP34=;0QnlnCFh+ie3wFy6kCKVptnOQhr
 85ulsoTaYyCr5QmSlH8STjNzcUnWVrAFJxxFkGyMtkuvyVGLEqlKLcUYVI7uYKnwb0oMdTrrD
 rGxmUdpO82/TGXX/BsqQ3ugl5wGcdbNVpx84S0Mawnqg9C+wjD+yvdMYG8t42AcD4APtu7pMb
 wbnwtm3tS0yauuRK8vTgarnM5S1i+XDHQzPwqOXAuUgYm+zdiapyCks8wT26ly7fwncW9s2qc
 TN7IBmUgaYtVOrT6oU5p3ytzQp0qF2bJoANmWdEeduIVXX9gGfTVq9wnfYAhu0QpMeY90zrS0
 vvnLwkMIwK0Awo8lSzW4tlErULPBVKv69Al7FZqiyxzRkTzGLl/Szjiv2DUZjbILkk2Q7Vv6x
 OlVHHxsvra/7Tvb3iVbZ/gswD3qoob7LifJjWdYAEDyhf2ulVyAJJNvwphK5MD3/i2jBTGiBL
 1BkLU9DCgnoHYGSvAJKxLKgN4yju4Yz4uPKx8a2RDhUB1+9f40TePTBa3+CHsdjHxs+eMTrpw
 kUPPfrodtG2Bi3zrS2eSS3+FgDisIpC8GSWYA1lYBxzhQXkzIO5AMes7KCHAHZ8m47Cf5UCrq
 Y6oDkHIXOhLwlsSfXdhWIWmUGMbXGaZxWSp13V3P+NPyjj3OG+VlzvRojX8uEak7EyyDilt29
 /yZo0ww97fV9Ln+Ds+rnpcUz9r7MDV991zpwglFkPEqYitZk2VRPKhWSciKUV8t88E/Isoiw1
 IKb59bilSxCFHh5VNoJL5O+SneKJknKkWPIJysqUM96BVf0Lf8PU1fgfeMLrYOSpnWKlcZ2Ti
 D1ICAAT9W+nV1mRoDanxWW166WTmuZu+vnVW7zbAxCXbq/Yg1oiy0G8sEwX3dGrxgsf9Veh57
 e7iKbPhei+fD8J9fDXyJ/0Zl6jL8MRJkDid/XlkZv1+TwRviJyOILVssWAsBI4MBlUNUCE+Rp
 XrySnr3TxedmpDaJZ285COjuMo47xa7bbvpfJ2qNvOjI0r69qvk2MzJzkFsgqACi457m+MCj5
 YwtT6lKfj/XDPdx4DCxeHlWwzgdNiDhsNZDLSUlN1Evd2EJ3g2g5D42N+8Ff+oz56mCUGNdRt
 x+gxJJCS1XTJ3EPA3wz/VOOK53AWZe+knlrDFsvDJ4MxzxNn8nENX1Qmc3kaBCqMjWWWqcOcu
 35gG076nIw4tNoMGo/lttYDemDGM8FBTh4r0Al8BUvz87iSQjqnMCeVx9gE8FMkWiGKel7YkL
 FoXC7PKDCeInmpLH47/UmAMDlLXSSts7qX9HOw1hcqQVTqup0j8Lab0=

Hi,

Am 28.01.25 um 13:52 schrieb Dr. David Alan Gilbert:
> Is there any characterisation of the corrupted data; last time I
> looked at the bz there wasn't.

Yes, there is. (And I already reported it at least on the Debian bug
tracker, see links in the initial message.)

f3 reports overwritten sectors, i.e. it looks like the pseudo-random
test pattern is written to wrong position. These corruptions occur in
clusters whose size is an integer multiple of 2^17 bytes in most cases
(about 80%) and 2^15 in all cases.

The frequency of these corruptions is roughly 1 cluster per 50 GB written.

Can others confirm this or do they observe a different characteristic?

Regards Stefan


> I mean, is it reliably any of:
>     a) What's the size of the corruption?
>            block, cache line, word, bit???
>     b) Position?
>            e.g. last word in a block or something?
>     c) Data?
>            pile of zero's/ff's junk/etc?
>
>     d) Is it a missed write, old data, or partially written block?
>
> Dave
>
>>> Puh.  I'm kinda lost on what we could do about this on the Linux
>>> side.
>>
>> Because it also depends on the CPU series, a firmware or hardware issue
>> seems to be more likely than a Linux bug.
>>
>> ATM ASRock is still trying to reproduce the issue. (I'm in contact with
>> them to. But they have Chinese new year holidays in Taiwan this week.)
>>
>> If they can't reproduce it, they have to provide an explanation why the
>> issues are seen by so many users.
>>
>> Regards Stefan
>>
>>

