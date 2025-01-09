Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A221D581;
	Thu,  9 Jan 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437467; cv=none; b=FGK5zvkmBJf7f2UvRJD2GHCG5LI+IOT+FBEiJX89cdEUkIuMakJPBgN6XCvdneJARAbBQeUGwKJJoJ4K6NX48SeTIem3p5v5bnPQvXfYSamQe4zWWzILvq4PMQ88aNhHfCCxtakcM7o94soz/h9WcQEAQv/MasWCQnBWQ2Bzta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437467; c=relaxed/simple;
	bh=uCwnW2QHusFHY5vfykiSiwwtuUDSfO5eo+ln8H42ydk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIo5MkLva7rOEws9Fv2A/b5HOUrSJVUAnEkSUcLvXMtgYBkHHK8bOvZRf6eaMu+TK/ZwG1A4U6colMOa9rziJTYSs5zTvOMhQCVzZ5g96AfO6tL+ID116pEVW9lEzR71yE+wMkJ3z/04bDHtdEG0+ypPe/TPmaM7MSvszkejtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de; spf=pass smtp.mailfrom=simg.de; dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b=o0Sl8cEo; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simg.de header.i=linux-kernel@simg.de header.b="o0Sl8cEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simg.de;
	s=s1-ionos; t=1736437453; x=1737042253; i=linux-kernel@simg.de;
	bh=REyuMx279JI4Y7DCVWjAQsyCew4AYt/M1mTsC7OYiDQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o0Sl8cEoA1jUFCVW4uKPC8HPSUEuXRAIpJGZh9RY5+jaJeV0HzE97IthxkR+9QVS
	 qAWZHDyAnkr7MMzTGhEwpjdOz/6AAwvsIUB7WkKCxfmf10apAFYIw23u8d2jiZYfM
	 9Yuz5b7apPl1fBtbqDG1ZQnKvadOif1NmTlcjorPDz92XUSB5RjwCGpeNVj5nHBpc
	 uQrTnIQP3G8vmQiUVtMKu/4UR/qNv7uHX5SA4+hDr2+Wrm2PXN7cDUdPfUWr49xZQ
	 vw9CwkwN8Ftdd6hWFaKSzU6rS81DdrCteq0XPeE8TCj0oPbiFmRNnXE3kTEpc3gfT
	 x/8N4CcRF5Tw4WtAaA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.60] ([87.158.38.246]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKbTo-1tAvuD0Hng-00XAQG; Thu, 09 Jan 2025 16:44:13 +0100
Message-ID: <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
Date: Thu, 9 Jan 2025 16:44:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
 bgravato@gmail.com
Cc: Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, linux-kernel@simg.de,
 Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
Content-Language: en-US
From: Stefan <linux-kernel@simg.de>
In-Reply-To: <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pqvYp2/0Kr1HTTx2WHZQ3d71DlJObzzmVe3t2OohI9vggNfMS8J
 MSZ9jBJ7XF1WDCv4h8bnLPz/RgQf5k1N2O5MhVSiomCWr6v5mw2WOPsnI4D6cMuTnm5A9wc
 j89tEVi/HX5QThtj61g+uZQHANxo1tuN+SzIz2m4X6Ee07TqzGfhvVbcMlqxCHIejgk0v8+
 bKspjKhV1yAUSN6OIKd5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xa9uewqKT84=;Qf8twounhvs9z9UcFY0Kv5+wVVW
 Wtyn4NVV+0k28Ep2xwnsiYRk3q8shF4yctjv16Pe+fTJxRoSTX8ibjKFV5NN/GOJUdJ2zTo5G
 tGKKLGJQiW3/iRa6sM8wgidsHNuF4q8YasbcBn9QSsSYrQ/WM9n5q7Jzl4XlBSFJc+j5qZLxe
 a7ehVeGIA31ySFENuRJtYkwPBOSvrqTCAlzIIoTWWDUCaeCOKYW0nTB5UPbL7AzxESCVM5s0a
 wHN5bn6Sl7l5BD62WFUsnOeZrUxyHyA4Mj1c9+MXHa8UTW1CRhhAqJyjTE7w3h85Z/klW7zqS
 1778qui2rMJs3DHLIYmQeQ1A2tSodyQ2fk1VJJOikSWamGcp7132Y8p1Rp/5qpuPkAypKYFmJ
 9a9lddlDiojDJfRUEDLxoPOG0Dz6BaGEgwqMH8b3vY0vJgwpxinsp52xm5CGlLug67uxihf8J
 g6L5RAB1NCs5jStcldhN41npLFWR2+hFHVRHpHhdbzsePegK9DcpyCuAHCsucbEOiUtCSET3Y
 3M9uLhLjsukKL7EYIlMVmAr17ZRUsdugcLrdkMg5aup95WKWl6k50fRmByfmPsvRJrsKENm9I
 MtktBqc5AW0vviWXsUYmnUMHxqwb7nZmqiYbpzeI6J1E22iXysmGtFfTnaM86CUxdyPwvne7l
 4fuP7xsv4yvX/cJz2MX1/Wi76gIODrYm1FqkcYhd/2rmD8fleD/A5H4QQxoJCB4Eg17IsJmGy
 nsr1+AOndU9vWTvFMEDkQFlhZS+eL6s1TwfKJbXNO6nuoDHvZRgqTQpQxLVmNACqC6eQqWiXc
 hQVhG//QOXxnZa8H4h0QkShtgNMpIRHvf43iXPrnqNhPuEL+FyOzr9Psb6pQYQpsa2MYl/ffz
 gpxPDcz+7aW1ayAXP8GXSwZEVTVP+yk7UMmQS+t4j/DZZFdlKhP4efp/OrzqMmKUeZqc7e/mR
 2JuOCMQmZE2IMK2Zos2vlwO7fRdjccDw58sLnHqvhy28kPw0DODZO44qX+guOxypLXZV4jbuA
 QcanY5NYTuf/GGbp/79Az9hqilRNVC6e2z/f0aE

Hi,

due to Thorstens hints, I'm trying to reply to both, the bug tracker and
the mailing list.

> --- Comment #13 from Keith Busch (kbusch@kernel.org) ---
> If I'm summarizing correctly, we're seeing corruption on Lexar, Kingston=
,
> and now Samsung NVMe's?

The Kingston read errors may be something different. They are described
in detail in messages #108 and #113 of the Debian Bug Tracker
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1076372

With the Kington, I never saw the write errors that occur with Lexar and
Samsung on newer Kernels (and which are easy to reproduce).

(ATM I cannot provide test results from the Kingston SSD because the
Lexar is installed, the PC is installed remotely and in use. Thus I
can't swap the SSDS that often.)

> # cat /sys/block/nvme0n1/queue/fua

Returns "1"

> --- Comment #15 from Keith Busch (kbusch@kernel.org) --- as a test,
> could you turn off the volatile write cache?
>
> # sudo nvme set-feature /dev/nvme0n1 -f 6 -v 0
Had to modify that a little bit:

   $ nvme get-feature /dev/nvme0n1 -f 6
   get-feature:0x06 (Volatile Write Cache), Current value:0x00000001
   $ nvme set-feature /dev/nvme0 -f 6 /dev/nvme0n1 -v 0
   set-feature:0x06 (Volatile Write Cache), value:00000000,
cdw12:00000000, save:0
   $ nvme get-feature /dev/nvme0n1 -f 6
   get-feature:0x06 (Volatile Write Cache), Current value:00000000

Corruptions disappear (under 6.13.0-rc6) if volatile write cache is
disabled (and appear again if I turn it on with "-v 1").

But, lspci says I have a

   Shenzhen Longsys Electronics Co., Ltd. Lexar NM790 NVME SSD
(DRAM-less) (rev 01) (prog-if 02 [NVM Express])

Note the "DRAM-less". This is confirmed by
https://www.techpowerup.com/ssd-specs/lexar-nm790-4-tb.d1591. Instead of
this, the SSD has a (*non-*volatile) SLC write cache and it uses 40 MB
Host-Memory-Buffer (HMB).

May there be an issue with the HMB allocation/usage ?

Is the mainboard firmware involved into HMB allocation/usage ? That
would explain, why volatile write caching via HMB works in the 2nd M.2
socket.

BTW, controller is MaxioTech MAP1602A, which is different from the
Samsung controllers.

> --- Comment #14 from Bruno Gravato (bgravato@gmail.com) --- The only
>  difference in the specs between the two M.2 slots is that one is
> gen5x4 (the main one, which is the one with problems) and the other
> is gen4x4 (this works fine, no errors).

AFAIK this primary M.2 socket is connected to dedicated PCIe lanes of
the CPU. On my PC, it runs in Gen4 mode (limited by SSD).

The secondary M.2 socket on the rear side is probably connected to PCIe
lanes which are usually used by a chipset -- but that socket works.

Regards Stefan
