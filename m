Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01C4D599;
	Wed, 15 Jan 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958394; cv=none; b=ipZPP7J2/5UD6IZw8jgb5pR+NWEFmdR8vDhOqEHFPdAV5a0qGr/vZiCuPDRJ23pYxpD5Qy9HL4V7A6U1VKetSryKru8FQoAGcs77tL2dS6V5Sb/QAXzz4I3ovwpWRYyesr6HAn+wC6jBddXew/jJolc7cZr4vSDx5wjVl5SWRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958394; c=relaxed/simple;
	bh=RltW2sS2ZYMoz6QtuOL8V8aRWEPd79GUWtcQFb6H7tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqIQF1fqojg5I/+twMsCQjrQfrPjTG9cIkOZlwEsByLOhSWWns2sqgmgX061JqtzdZRhCv1skjHNIJfs1MU8Ru+RypHhjrtWuPQ6xYrH3MHLa2EWUjB0LJ9XxC7z9f0eVMogsUiU8jmYsM3RrA7O+oFEhRf2tVDeiPEmMHxpTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=YWsVxS4X; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="YWsVxS4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1736958375; x=1737563175; i=linux-kernel@simg.de;
	bh=RltW2sS2ZYMoz6QtuOL8V8aRWEPd79GUWtcQFb6H7tI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YWsVxS4XUviVD6iRL/DAP5GU43rw1YNHdSrhkJ8cBjso6aWLoXdYMWOMp3BRTlXY
	 gdxROmotnfqln9Xn9241J0pZkMOOSmyxGZdZ3dNApNpZSDkzqngxWWSMZO9/U2W2X
	 lI+0W/ZMzu9n0GrG8uQIfeqMYGg5ydrRY9UNA2eazGxRu7dZ/ulEgZM5XDCChrOaX
	 bPdZj2EoMgL7uAEht1D+zFef8teiG7zd/Q7RmaVfBWDfSSYEqFhfKOv1u6aB/9pDb
	 aCyLux2u/3NWUAO+m+Rydk8k2td3JTWn3TZyWvYSgNKWu4BJ11DO4l2ebVpoJ8q1s
	 RSYqbHBH5nI+lKex9A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([93.217.99.181]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPowd-1ttDsK2rlj-00SSnq; Wed, 15 Jan 2025 17:26:15 +0100
Message-ID: <7e5b72e9-7f7f-4e68-a42a-4411cc5778b1@simg.de>
Date: Wed, 15 Jan 2025 17:26:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Bruno Gravato <bgravato@gmail.com>, bugzilla-daemon@kernel.org
Cc: bugzilla-daemon@kernel.org, Keith Busch <kbusch@kernel.org>,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
 <CAOBLbT9LrqdHQ4-gGkRyB+vU3WnGo8f7X7m2=qK29+x=3QpzPw@mail.gmail.com>
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <CAOBLbT9LrqdHQ4-gGkRyB+vU3WnGo8f7X7m2=qK29+x=3QpzPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s6m+XZFkNT4XqeH9ZJr2u+oy+7X2xp4vVEBn5fsWllVwF3JOyUU
 GJ5KAyZxl0py8rBIkROyWGo4qucHklto2Cq8exPWuYx1T1wP+n2eJBZczG2IaYAqBLl3bxl
 as7rUiIibF09qncBYdfUM6zLxbrYDbA1zuIAf+U/H9xzI2pSqwRQ/loUN6h9q+ZjdibKQ/X
 ltj6/mI14UKIJOm1cDGhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kKnzRXl7azo=;TFVJ7dn1EfZPsiykdqQCXIRgMV3
 iYE7wBSQ7tzcgf11PLvSox2WYT2fSzMwl74uQYIb+fenOrprLQES6IeILrBDhDNmCLjFAdosw
 ZXVzJCns+DAIpSX+jFJJqpu760nRvR+JFO1LXtpO7ZDd3EzlxpyPgwULeK9e7wOLr/3tuStcS
 Mn9fzB5IdM1yTi3sBgRbH5AdwChPQr+Ip7NaAyZvPH5u+iAo+lgsI++d33/m1VZ/pvhoCsyoT
 gd9gyWeUjOJ7vSW1uKwo7/OeLIb3SVZvg2qrHnzkeZ9VTbjVVexoyEA5B/TpW6eUXmQgG7hMW
 GDvlqxKipG2sdt8q+lrqZrPjt4eV0mUpnMo/T+MRP9/LerM7zzZvYecRrBeUmOk2oTDq4EmMe
 blu+B3gdGImBCfkEGTjWO1Yk2JceguDKNchqpfp0Sxd25qEssLk8Lk+HI3QasTast6iodYA9r
 faQ/gMtk4alJAZXpgDhoecU3CYnlVluEq6XjmgvP4u2j8dG6QpsivKPTNKe9Hpql+PbhWJW23
 RT516kfCuZ+3AWBGYjDyPmxgVWWnv3FKfZduFcO+m03H3T56rdZRztKq0ypVhkOfDUUkrMK6o
 0Qcbwp1z5Wp8vZUc5JH7zbG3yvbQXDUrlUbLrW/YvhwScNOatyMJZFnecb+h4O7AH3VgSiMWR
 sXuMQB00End/OEri+A+w9lMTAjfmRH9KsGvakCFVl2tsEYvxHMAQn6H9NgRoKpRhMr/8M7Txs
 JhR+NB+NKZa5igiUy94SmYQ6f8RqMWLEDRQsJYDwTx/l4Ao75CvzRNNy9RpXBm/QYWuiF+8x2
 jF+OhXFKnBJC+B/EFdrRplZkgXpgWGo51rOdjWBxhXn6Aj9HeIxZpE4b+7uUGXFhANT4J/FDX
 Ghh+iDJAmNTe92Zf1K14UziqqTTPcCQtvfFaNsRRy+EiNDZmVrkLHs7JceWyd1ulXkMAal2BI
 6HJ4MLMYdXtRWyAcoZlfnTKWk6IhYIvoix/O6ap7/lwLXyQRFJXeQXYW063CakMC9DK4GdRoI
 h5YllOImqm3FZDjTTzlQNtO8pXG68JPbeiwQyofkIPK1kr397DLkQRE/CdQ1CkhxIfDf/fnPA
 3151QV0ylu9BIGYszbJyg09aQApEdln/4jDdywCKA/w6hkGQNYmFAjshNkzFrUfcVH1EUOC+o
 =


Hi,

Am 15.01.25 um 14:14 schrieb Bruno Gravato:
> If yours behaves like mine, I'd expect that if you swap the disks in
> config 2, that you won't have any errors as well...

yeah, I would just need to plug something into the 2nd M.2 socket. But
that can't be done remotely. I will do that on weekend or in next week.

BTW, is there a kernel parameter to ignore a NVME/PCI device? If the
corruptions appear again after disabling the 2nd SSD, it is more likely
that it is a kernel problem, e.g. a driver writing to memory reserved
for some other driver/component. Such a bug may only occur under rare
conditions. AFAIU, the patch "nvme-pci: place descriptor addresses in
iod" form 6.3-rc1 attempts to use some space which is otherwise unused.
Unfortunately I was not able to revert that patch because later changes
depend on it.

So, I now only tried out whether just `NVME_MAX_SEGS 127` helps (see
message from Matthias). Answer is no. This only seem to by an upper
limit, because `/sys/class/block/nvme0n1/queue/max_segments` reports 33
with unmodified kernels >=3D 6.3.7. With older kernels or kernels with
reversed patch "nvme-pci: clamp max_hw_sectors based on DMA optimized
limitation" (introduced in 6.3.7) this value is 127 and corruptions
disappear.

I guess, this value somehow has to be 127. In my case it is sufficient
to revert the patch form 6.3.7. In Matthias's case, the values then
becomes 128 and has to be limited additionally using `NVME_MAX_SEGS 127`

Regards Stefan


