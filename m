Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3341B3957;
	Fri, 17 Jan 2025 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149527; cv=none; b=hykSmF0x5j2R7gfQUTunuX8u4z1Pz0Q4Mf87+4fY19k20Fc5GNth31+Qg+I567wDK1076HlSt0WVV3Hvk5KOEnFUdqPYnCOL3rUuPMnHxJg3lwZ7YCh0/s4AVRtG52itposA1jmY7NerdhBWu7iGOWI3iJOdPwHIQGJUUPB5BU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149527; c=relaxed/simple;
	bh=xesf0RCMEI2P5fhtJgMZzY28yOfhI9GmNrYN1XjxGWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXZ+nm9gCW/cKG1gBqrMVPFLmP1iOWgcBzv5HFm3VlJJTTPIRUxxAPUd/ZQ5ioNk4HtU1DAMAK/Qyt+9VFTOnxDomhgQtFfe7tqN7hhPfoy9r/FdJHsT23cfazna43g5fb6EApoFask6LdaEoxD864aSWDiOZiH7zM2YN65vBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=T/M5mc5l; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="T/M5mc5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1737149516; x=1737754316; i=linux-kernel@simg.de;
	bh=vNc3h5uz9F4zhx4XMa1OwgBRM5wJa5mr4x8QwvlWzk0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T/M5mc5lTZXyVaWu0YWpBjHAmx/n/Y8ZNzZl+x2Ryn+ckxyftT5UkUjrPc9QxJW7
	 zs7xdFhVS1AVvSqgimuxAfkHG4y4FOP9DP4EwTbFqHlU2VN4y8fCKG66FeAmtgUqG
	 kUmtQn0KCCz1+TVAjXYU8hfuh2iSuE3lh+9kNmKYYIye5SOUtkR2mhFaurcmzZNT1
	 AM2DfrPt3C18Ig2OfwpL0m3SKWYTii7NUFVgTA+igEHbWENWIebUXPaOPm/RJ63yq
	 dJJmfrlSFP1sNrmN2+y0CyauNza88GRLhbSE/2cDP+c+HpWtSukcbwoIAj2f6Geof
	 NLw0+yN2L/njjLIwYA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([87.158.34.72]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N63i4-1tS8fs2Vtw-00v2kz; Fri, 17 Jan 2025 22:31:56 +0100
Message-ID: <00b01ab3-ec9d-4a35-a593-c9fc764e0f04@simg.de>
Date: Fri, 17 Jan 2025 22:31:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Christoph Hellwig <hch@lst.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>, bugzilla-daemon@kernel.org
Cc: Bruno Gravato <bgravato@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Adrian Huang <ahuang12@lenovo.com>,
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
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <20250117080507.GA25953@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m6Gfmgmqsk1tjmFw4DSDSQY9LC787w7nASuI3Gm+xrtwkaC9xWO
 YyVeYms/XHyiKruYe4PrlqMd4fEVS3nE2dYlPB7GgyySZ4NjxGh4UixOipPGP9phEQtxLfy
 OrGBQsk7erGNtjGXUnPF7YxK55BHxl2HNGyzkG5PwBRBCyYHgRgJKP4tITa9TMxqQ7RoX+m
 Lolu3EZaJdyYogq8FD9Iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+r7IGKcPWO0=;+/zIaAyPYIR0wy63YVAFUefbk/m
 7Ir7bLJsMPr28cKxbPiNL8F05l0XrmiSLB37W89WY1hcz6arFtOt2eAFAnjXp4xOrWIRJVuxi
 UzouLXYp6Wkhbg3wKUAuT+tKU2IVFoC9xzOYDTi9iilELgjiRNQinQWR3rbuLNVFjngXOFsA3
 5XLjjB1p7IRkIcjuD2y3vYTEi78A0lBtFUIXlkks4RaZQn73Gmcv4N5f5pniT+PbJZhJzQM7+
 L7S6Uu4I52EZeCUdNQ5Ve/lwiB6TjEtkzQ+BmyMOVr1dbatGJ/El/BoYvTjg5xaP8+S/5e6k4
 GdpsWhT4v9KV31BkNbiJgzjSFxuUjwwK/ysTALMcTrLCOgubqLnHB3Nx44d1Wc640QT1vUW5E
 WuGB6DMeKmumtIRamw3A0vRUVSJM7Gah6kJikT+/FUBENQuppO0fm8/KcqI6EC1ncFs70XQKe
 znvaBPNZh/aKZLIIDR88vnRsrIU5GGdxbfZTLO/wf7cRpcbSSb/CrsOQLYYV/xStMvDsnpU7B
 l72nShRWUNxb4H2pEbBUxKvUH8z+KQMGW0LPBBaxHDF4TAC/aV0nTq4E9FbFHzqro+b6jwTw3
 rQWwanIktq+QTf/lV/1zlIP7YfdOQd0J3QNDgLnHHosgzQf9alJA5FdfkTq/77DumddF9wGeP
 1ZzCAik1dYDv8z260qXsWUB4lqYDYmP1ixCXwF+vaDTJtg84/6nbsKNqlLLExaz8qogpGF3kV
 OYPM0r4+OKqlPJ+p+ZGzXfv0+8vfoxaYamGx9UXXBWAHhuw9Dyl0xbVqx/IS8uOFdlRuyrP5Y
 vO0goD7A+ntV7Px2pG77v6CL9oPs4naINUrnWyB+2/yzSfiz33d1wN8jxXAZ2nMa7tnn11qFI
 g8RQK06KvN2a8s7stXP1KBtXbkmD9r1XzDTOk6X/bHKKSLZXjtTBsAXnk6508nwaZcocGTzH+
 cV1j9KSNtySAVA9wMA1D86bqAeVqkYBE5iH37CzX70mxFPo+JIg9QNNd45BuwiMoYWueNoNrJ
 edon2FFt3CjdUIw0wRZUbZXLqN4/hIkEDbPyX8jc+mdipKSKtCcsasA+d7zlsBuFslUmHzSOa
 dVtLQ3Wyui7Ivg3sXu/KclEwcgOJtPAsa3edI0GnAYJXezuG9yrzhpw0/ZjuuYTFPh/pV6mXw
 =


Hi,

>> What does it mean that disabling the NVMe devices's write cache
>> often but apparently not always helps? It it just reducing the
>> chance of the problem occurring or accidentally working around it?
>
> For consumer NAND device you basically can't disable the volatile
> write cache.  If you do disable it, that just means it gets flushed
> after every write, meaning you have to write the entire NAND
> (super)block for every write, causing a huge slowdown (and a lot of
> media wear).  This will change timings a lot obviously.  If it
> doesn't change the timing the driver just fakes it, which reputable
> vendors shouldn't be doing, but I would not be entirely surprised
> about for noname devices.

As already mentioned, my SSD has no DRAM and uses HMB (Host memory
buffer). (It has non-volatile SLC cache.) Disabling volatile write cache
has no significant effect on read/write performance of large files,
because the HMB size in only 40MB. But things like file deletions may be
slower.

AFAIS the corruption occur with both kinds of SSD's, the ones that have
own DRAM and he ones that use HMB.

> --- Comment #49 from Bruno Gravato ---
>> * Not totally sure, but it seems most or everyone affected is
>> using a Ryzen 8000 CPU -- and now one user showed up that mentioned
>> a DeskMini x600 with a Ryzen 7000 CPU is not affected (see ticket
>> for details). But that might be due to other aspects. A former
>> colleague of mine who can reproduce the problem will later test if
>> a different CPU line really is making a difference.
>
> One other different aspect for that user besides the 7000 series CPU
> is that he's using a wifi card as well (that sits in a M.2 wifi slot
> just below the main M.2 disk slot), so I wonder if that may play a
> role? I think most of us have no wifi card installed. I think I have
> a M.2 wifi card on my former NUC, I'll see if it's compatible with
> the deskmini and try it out.
>
> The other reason could be some disk models aren't affected... I think
> Stefan reported no issues on a Firecuda 520.

Correct. To verify that the two other CPU series are not affected,
someone who can reproduce this error and who have laying around another
CPU must swap them.

> --- Comment #51 from Ralph Gerstman --- > A missing network might preven=
t the failure during install - at least
> in Ubuntu> 22.10 - but can happen anyway. Enabling network seems to
> raise the chance.
I had to disable it in BIOS. Just not connecting it has no effect
because drivers and firmware are still loaded.


Just for the files (already mentioned it): I'm using the latest BIOS
version 4.08 with  AGESA PI 1.2.0.2a (according to AsRock page) and
firmware blobs version 20241210 from
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/
and I can confirm the the corruptions also occur with older versions of
BIOS/firmware.

Regards Stefan
