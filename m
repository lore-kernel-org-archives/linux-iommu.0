Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136E1FA851;
	Fri, 17 Jan 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107480; cv=none; b=pMhyLO3VpomHUdPsneB2Fs5Hbck1QAFD9JaXBfKwy8WUd5ts+h7Yo4qYiHUoBKHbckgKRJnKDG/tLm9lH1u1qw0sDubZckMHay+9HlV/uY4RFYRAAK/orYZ4kf2z90/hyTODC7w8qXcjx9QK6K7s5KU5XPcQK+hDFl6awKYeNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107480; c=relaxed/simple;
	bh=+Sg6AdU2njfJLBb4GboZi1e8xhi+0Jy63KmocZgFQtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBHVkeQZjtCqMeBK4H7LTfZa+IQ6wwkt0PN8uXlrGrG/h4XUoHcCUXz9WzulivxzJGYU0c6i0LDX6G9jBSjOyDQpnSwaODyMbtY0L8L92LY8VlAr6f2LxdoNEebtpKxowy/CA5fLbxVYoF5Zyld+HjCCmhrtG1Oclx7o9EYr9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=p0gHeq2i; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="p0gHeq2i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9TSWTbzFOjQI35Ms/FoU8HyF1BS7JwOhnBq64tiVCoY=; t=1737107478;
	x=1737539478; b=p0gHeq2iVj1sTM9V4nI2PVd+UHTIVrQbdM5KFn/zcCjOAoPHdFIwKRHbbxqxr
	O47z5eJAfJOJJnJ3AJn1Vrf7aURKyGyoz5bcKl6OpgP+60pWVkamC1Yd530dUnHchW3VsKCgpkiJq
	+luwpTF8da5drljzJqB3ektG2qfH2gKSwn7J5t6nBv2c5oS3tFV7kyfx8nPTn+s4gAmhVmYP//lyx
	3Mtmu6BDRAxEt56QfC3JNc4yooyLS91kkdgZc55R5Z6suXR8bTO1A1uKH6cXFcwGKSwMB8T6jXLyQ
	5R1kkhY4OZ/rlYP9XzFhYNCkWMcRMa9AIulaa5bZ6EPnEsyOGw==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tYj0Q-00CSES-0t;
	Fri, 17 Jan 2025 10:51:10 +0100
Message-ID: <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
Date: Fri, 17 Jan 2025 10:51:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Christoph Hellwig <hch@lst.de>
Cc: Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>,
 Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20250117080507.GA25953@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1737107478;5cb3cb0b;
X-HE-SMSGID: 1tYj0Q-00CSES-0t

On 17.01.25 09:05, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 09:40:04AM +0100, Thorsten Leemhuis wrote:
>
>> hch initially brought up that swiotlb seems to be used. Are there any
>> BIOS setup settings we should try? I tried a few changes yesterday, but
>> I still get the "PCI-DMA: Using software bounce buffering for IO
>> (SWIOTLB)" message in the log and not a single line mentioning DMAR.
> 
> The real question would be to figure out why it is used.
> 
> Do you see the
> 
> 	pci_dbg(dev, "marking as untrusted\n");
> 
> message in the commit log if enabling the pci debug output?

By booting with 'ignore_loglevel dyndbg="file drivers/pci/* +p"' I
suppose? No, that is not printed (but other debug lines from the pci
code are).

Side note: that "PCI-DMA: Using software bounce buffering for IO
>> (SWIOTLB)" message does show up on two other AMD machines I own as
well. One also has a Ryzen 8000, the other one a much older one.

And BTW a few bits of the latest development in the bugzilla ticket
(https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):

* iommu=pt and amd_iommu=off seems to work around the problem (in
addition to disabling the iommu in the BIOS setup).

* Not totally sure, but it seems most or everyone affected is using a
Ryzen 8000 CPU -- and now one user showed up that mentioned a DeskMini
x600 with a Ryzen 7000 CPU is not affected (see ticket for details). But
that might be due to other aspects. A former colleague of mine who can
reproduce the problem will later test if a different CPU line really is
making a difference.

Ciao, Thorsten
