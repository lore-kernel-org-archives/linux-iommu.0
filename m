Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5F1FDE15;
	Wed,  8 Jan 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347145; cv=none; b=KD4UGykLQoD0CO+52ZAzB5N0HhOjxfS8a6vNIx3LEy4ntiXQxKPHs+1dzH7zItZ4JVzmz1ONWvw4rW/mAua7g4QWXl5RmAebvHOPDm4WfnqtFOlG5dzrNNecnfqON0jTShLmd6b4/EXpJH4BwE36btHfqwjaCvLEeXIsg814QDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347145; c=relaxed/simple;
	bh=8Ia+Munolo2hOcL7KhB/f4+uIkZ6KctIJfvMEBR3UtU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YTxhCgue6XIT8jHT+Ol34mrXsADyVe357BmREJ+r7OtzSjPd/qejkuy25kHE4Ravf7aco/94CM3eATbbQTE3/2NyibRBlKMmk3zIvxMh42z0YlppTWAwUOBB5jWA/hYEepgDIwtxmDh5FZuxwFSSepi0yWBBWlLe0SgNi58T1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wvjfuGAe; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wvjfuGAe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0Q5SkpUB7nvYDr5G8znzFgNJ4lPKjcvCCPURLA9g7mQ=; t=1736347143; x=1736779143; 
	b=wvjfuGAeJRwyE14j8QD68eomPWo/8wMYzrLBa2YMriscG2nDa3sHImqu5UY5/ZJ7eG/7/aya/Yx
	Sap+GN56V5Bg7H5lduyHqnggGFz5esaCQwGu8eopq7A4PqQuyyl1WrE1sSoLqfDxQrooDdmUlsoDk
	igB/cN6o3iEMYnSv3/MH72IEdxejMonpD4zpGqZ6zeFkOunJmSXdUDrTMGYS2QQjLN1fSy2LjHvT8
	F6Gya6or+uSDJDAkj1ly0zdGFG6yvVUaR8HmaLVNapI08JpAGQJhsEE/lIiUzvhZfv4f1N4J41j5a
	8eb/fTyd8B9oFj8EqzeNm9joTY6JbsotYj3g==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tVXCw-006qbM-24;
	Wed, 08 Jan 2025 15:38:54 +0100
Message-ID: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
Date: Wed, 8 Jan 2025 15:38:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
To: Adrian Huang <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [Regression] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1736347143;3f0162a6;
X-HE-SMSGID: 1tVXCw-006qbM-24

[side note TWIMC: regression tracking is sadly kinda dormant temporarily
(hopefully this will change again soon), but this was brought to my
attention and looked kinda important]

Hi, Thorsten here, the Linux kernel's regression tracker.

Adrian, Christoph I noticed a report about a regression in
bugzilla.kernel.org that appears to be caused by a change you too
handled a while ago -- or it exposed an earlier problem:

3710e2b056cb92 ("nvme-pci: clamp max_hw_sectors based on DMA optimized
limitation") [v6.4-rc3]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219609 :

> Bug 219609 - File corruptions on SSD in 1st M.2 socket of AsRock X600M-STX + Ryzen 8700G
>
> there are one or two bugs which were originally reported at
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1076372 . For details
> (logs, etc.), see there. Here, I will post a summary and try to point
> out the most relevant observations:
> 
> Bug 1: Write errors with Lexar NM790 NVME
> 
> * Occur since Debian kernel 6.5, but reproduced with upstream kernel
> 6.11.5 (the only upstream kernel I tested)
> * Only occur in 1st M.2 socket (not in the 2nd one on rear side)
> * Easiest way to reproduce them is to use f3 (
> https://fight-flash-fraud.readthedocs.io/en/latest/usage.html ). f3
> reports overwritten sectors
> * The errors seem not to occur in the last files of 500 file (=500 GB)
> test runs and I never detected file system corruption (just defect
> files; I produced probably more than thousand ones). The reason for the
> latter observation is maybe, that file system information are written
> last. (See see message 113 in the Debian bug report)
> 
> (Possible) Bug 2: Read errors with Kingston FURY Renegade
> 
> * Only occur in 1st M.2 socket (did not tested the rear socket, because
> the warranty seal would to be broken in order to remove the heat sink)
> * Almost impossible to reproduce it, only detected it in Debian kernel
> that bases on 6.1.112
> * 1st occurrence: I detected in an SSD intensive computation (as data
> cache) which produced wrong results after a few days (but not in the
> first days). The error could be reproduced with f3: The corruptions were
> massive and different files were affected in subsequent f3read runs (==>
> read errors). Unfortunately I did not stored the f3 logs. (I still have
> the corrupt computation results, so it was real.)
> * 2nd occurrence: A single defect sector (read error) in a multi-day
> attempt to reproduce the error with the same kernel (Debian 6.1.112),
> see message 113 in the Debian bug report
> 
> Consideration / Notes:
> * These serial links (PCIe) need to be calibrated. Calibration issues
> would explain while the errors (dis)appear under certain condition. But
> errors like this should be detected (nothing could be found in the
> kernel logs). Is the error correction possibly inactive? However, this
> still does not explain why f2 reports overwritten sectors, unless the
> signal errors occur during command / address transmission.
> * Testing is difficult, because the machine is installed remotely and in
> use. ATM, till about end of Janaury, can run tests for bug 1.
> * On the AsRock X600M-STX mainboard (without chipset), the CPU (Ryzen
> 8700G) runs in SoC (system on chip) mode. Maybe someone did not tested
> this properly ...
> 
[...]

> With the help of TJ from the Debian kernel team ( https://
> bugs.debian.org/cgi-bin/bugreport.cgi?bug=1076372 ), at least a
> workaround could be found.
> 
> The bug is triggered by the patch "nvme-pci: clamp max_hw_sectors
> based on DMA optimized limitation" (see https://lore.kernel.org/linux-
> iommu/20230503161759.GA1614@lst.de/ ) introduced in 6.3.7
> 
> To examine the situation, I added this debug info (all files are
> located in `drivers/nvme/host`):
> 
>> --- core.c.orig       2025-01-03 14:27:38.220428482 +0100
>> +++ core.c    2025-01-03 12:56:34.503259774 +0100
>> @@ -3306,6 +3306,7 @@
>>               max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
>>       else
>>               max_hw_sectors = UINT_MAX;
>> +     dev_warn(ctrl->device, "id->mdts=%d,  max_hw_sectors=%d, 
>> ctrl->max_hw_sectors=%d\n", id->mdts, max_hw_sectors, ctrl->max_hw_sectors);
>>       ctrl->max_hw_sectors =
>>               min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
> 
> 6.3.6 (last version w/o mentioned patch and w/o data corruption) says:
> 
>> [  127.196212] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
>> ctrl->max_hw_sectors=16384
>> [  127.203530] nvme nvme0: allocated 40 MiB host memory buffer.
> 
> 6.3.7 (first version w/ mentioned patch and w/ data corruption) says:
> 
>> [   46.436384] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
>> ctrl->max_hw_sectors=256
>> [   46.443562] nvme nvme0: allocated 40 MiB host memory buffer.
> 
> After I reverted the mentioned patch (
> 
>> --- pci.c.orig        2025-01-03 14:28:05.944819822 +0100
>> +++ pci.c     2025-01-03 12:54:37.014579093 +0100
>> @@ -3042,7 +3042,8 @@
>>        * over a single page.
>>        */
>>       dev->ctrl.max_hw_sectors = min_t(u32,
>> -             NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
>> +//           NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
>> +             NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
>>       dev->ctrl.max_segments = NVME_MAX_SEGS;
>>  
>>       /*
> 
> ), 6.11.5 (used this version because sources were laying around) works and says:
> 
>> [    1.251370] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
>> ctrl->max_hw_sectors=16384
>> [    1.261168] nvme nvme0: allocated 40 MiB host memory buffer.
> 
> Thus, the corruption occurs if `ctrl->max_hw_sectors` is set to another (a smaller) value than defined by `id->mdts`. 
> 
> If this should be allowed, the mentioned patch is not the (root) cause, but reversion is at least a workaround.

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

