Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20383B19A;
	Tue,  3 Jun 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963780; cv=none; b=Hh0verQQxcwpIwSp6m1tPA8ecg8Op9em3x5TMPiDjeIHDiF7U70+ZqLQGY4MabfJWwCI/1+rj8rALNLgTwGx/D5Xpcw7PabfDlkJZcqvINd2HN5kOJDpJ8EzbXkQC7dbkrsqAobP4SFJ1M8vB7fo5rEAf0P9e+j9dWKoC13/bLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963780; c=relaxed/simple;
	bh=zwb96lvUH2YNqj0yOFOL7saps+KFmlIXAmNXE/vYQmE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tA+AusLlKuUUwygoDgV6Dwx4ZRrpvFjxZ4kvDY63/Ryv6W3Z6prVQu3R6IZtJMYAqeF1Wd6XBjj0jDt4BlNx0CixDojxkx1fuvRKdMhf4FRkcg60dZIbH5hqhp8kj38vaj5v5i3C5wqrebAnqDd2FkGdx0T3tYTbRp+5Aj5NwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=G1hPBS7t; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="G1hPBS7t"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id AB9786003C0F;
	Tue,  3 Jun 2025 16:07:06 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id W4B508tEEkoL; Tue,  3 Jun 2025 16:07:03 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 2D70C6003023;
	Tue,  3 Jun 2025 16:06:49 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1748963209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6t7E6cPERmABs0HuzgXS6hqa1WleGUWpUgCVWrvpc0E=;
	b=G1hPBS7tPnJ0OzRIyI4Gv6IqS/Vv6ipAoxm91da4SRA2NeuFt9m/NdC6hAxkQ7WMUW0Ldb
	YBmMDHuahwXcxw1WdL8wOu8B1n8O2EbhMkUYluvF38GTriC+kueMcI5XILp8MlqiaqsCvv
	RDPMj9Ld2wHneLTFbz3pyjUDI7TLDr4=
Received: from [10.158.133.22] (dial-b1-161-46.telepac.pt [194.65.161.46])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 75A5E36008A;
	Tue,  3 Jun 2025 16:06:47 +0100 (WEST)
Message-ID: <62e7f7fe-6200-4e4f-ad42-d58ad272baa6@tecnico.ulisboa.pt>
Date: Tue, 3 Jun 2025 16:06:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: [REGRESSION] EMEM address decode error when using Tegra210 media
 engines
To: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com, jgg@ziepe.ca,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de
Cc: regressions@lists.linux.dev, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, diogo.ivo@tecnico.ulisboa.pt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Commit 50568f87d1e233e introduced a regression when trying to use the media
accelerators present on the Tegra X1 SoC.

I came across this regression when testing the branch [1] that leverages
the NVJPG engine in the Tegra X1 for decoding a JPEG file. After commit
50568f87d1e233e we see the following error messages after submitting a job
through the TEGRA_CHANNEL_SUBMIT IOCTL:

[   17.993237] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
@0x00000000ffffbe00: EMEM address decode error (SMMU translation error 
[--S])
[   18.003625] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
@0x00000000ffffbe00: Page fault (SMMU translation error [--S])
[   18.015088] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
@0x00000000ffffbf00: EMEM address decode error (SMMU translation error 
[--S])
[   18.027626] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
@0x00000000ffffbf00: Page fault (SMMU translation error [--S])
[   28.131228] ---- mlocks ----
[   28.131816] 0: unlocked
[   28.134238] 1: unlocked
[   28.136680] 2: unlocked
[   28.139091] 3: unlocked
[   28.141527] 4: unlocked
[   28.143950] 5: unlocked
[   28.146371] 6: unlocked
[   28.148803] 7: unlocked
[   28.151229] 8: unlocked
[   28.153649] 9: unlocked
[   28.156089] 10: unlocked
[   28.158589] 11: unlocked
[   28.161110] 12: unlocked
[   28.163621] 13: unlocked
[   28.166128] 14: unlocked
[   28.168650] 15: unlocked
[   28.171154]
[   28.172633] ---- syncpts ----
[   28.175588] id 0 (0-reserved-nop) min 0 max 0 (0 waiters)
[   28.180964] id 1 (1-54200000.dc) min 0 max 0 (0 waiters)
[   28.186246] id 2 (2-54240000.dc) min 0 max 0 (0 waiters)
[   28.191531] id 3 (3-54340000.vic) min 0 max 0 (0 waiters)
[   28.196907] id 4 (4-ffmpeg) min 0 max 1 (1 waiters)
[   28.201988]
[   28.203234] ---- channels ----
[   28.206259] 0: fifo:
[   28.208431] FIFOSTAT 80100840
[   28.211375] [empty]
[   28.213454] 0-54340000.vic:
[   28.213457] inactive
[   28.213457]
[   28.219956] 1: fifo:
[   28.222116] FIFOSTAT 80100840
[   28.225070] [empty]
[   28.227146] 1-54340000.vic:
[   28.227150] inactive
[   28.227150]
[   28.233650] 2: fifo:
[   28.235816] FIFOSTAT 80100840
[   28.238754] [empty]
[   28.240846] 2-54380000.nvjpg:
[   28.240851] active class c0, offset 0000, val 00000104
[   28.248990] DMASTART 0x00000000ffffd000, DMAEND 0x0000000000000ffc
[   28.255141] DMAPUT 00000018 DMAGET 00000018 DMACTL 00000000
[   28.260689] CBREAD 00000104 CBSTAT 00c00000
[   28.264852] JOB, syncpt 4: 1 timeout: 10000 num_slots: 3 num_handles: 1
[   28.271440]     0x00000000ffffd000: 00080041: SETCL(class=001, 
offset=008, mask=01, [04000000])
[   28.280106]     0x00000000ffffd008: 00003000: SETCL(class=0c0)
[   28.285910]     0x00000000ffffd00c: 20000000: NONINCR(offset=000, [])
[   28.292333]     0x00000000ffffd010: 6000001d: GATHER(offset=000, 
insert=0, type=0, count=001d, addr=[ffffc000])
[   28.302380]   GATHER at 0x00000000ffffc000+0x0, 29 words
[   28.307673]     0x00000000ffffc000: 10100002: INCR(offset=010, 
[00000080, 00000001])
[   28.315380]     0x00000000ffffc00c: 10100002: INCR(offset=010, 
[000001c0, 00000000])
[   28.323091]     0x00000000ffffc018: 10100002: INCR(offset=010, 
[000001c1, 00000000])
[   28.330804]     0x00000000ffffc024: 10100002: INCR(offset=010, 
[000001c2, 00014cc0])
[   28.338517]     0x00000000ffffc030: 10100002: INCR(offset=010, 
[000001c4, 00011710])
[   28.346232]     0x00000000ffffc03c: 10100002: INCR(offset=010, 
[000001c5, 00000000])
[   28.353945]     0x00000000ffffc048: 10100002: INCR(offset=010, 
[000001c6, 0000b910])
[   28.361658]     0x00000000ffffc054: 10100002: INCR(offset=010, 
[000001c7, 00000000])
[   28.369372]     0x00000000ffffc060: 10100002: INCR(offset=010, 
[000000c0, 00000100])
[   28.377085]     0x00000000ffffc06c: 20000001: NONINCR(offset=000, 
[00000104])
[   28.384190]
[   28.385660] tegra-host1x 50000000.host1x: cdma_timeout_handler: 
timeout: 4 (4-ffmpeg), HW thresh 0, done 1

Please let me know if you need more information on my side and I'll be
happy to provide it.

Best regards,
Diogo

#regzbot introduced: 50568f87d1e233e

[1]: https://gitlab.freedesktop.org/d.ivo/mesa/-/tree/diogo/vaapi_remove_gpu
