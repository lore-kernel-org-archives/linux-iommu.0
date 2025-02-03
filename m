Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82B2046A2;
	Mon,  3 Feb 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594880; cv=none; b=ICPp3sCOOPdDlNGULU1mMp0gMdcaQ9KAh5kOCbH6XZF6zNBEdBGg73EI9r9/TP8AkKk/SsNXQPCPKT3zZdJZEv8Uv/+ybdR+4v1M63RocAW+tc7T9hBlsHETvq1Xg49myfgf1or8Se5VagTm3KFa1/9NkmWKG+Tuv5brC6HsmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594880; c=relaxed/simple;
	bh=kiAeIKH8Zyb+y7Ct4xYR39wFwiIIvIq6JAQ6bTBxM08=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Gm0EVkCWr5MS+jtMcT8hT8IppJwTjqeQouk6aoYskI5tRdDcRULGDBC+BMljMqjQ/tFWCyIGDkxEMTb63KyLplLXJNKFsKH2H/3xHEkkaEaffdbfG03ZB9cnWyJT6ifPmRvCDG1eqpbVvSKC0Ny9zQNztNe+u9gwsbDGWoYyM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=hZh10e/+; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="hZh10e/+"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id EADEA6007C0F;
	Mon,  3 Feb 2025 14:55:26 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with UTF8LMTP id 7e-HybVbE-7Q; Mon,  3 Feb 2025 14:55:24 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 69CFD6006BAB;
	Mon,  3 Feb 2025 14:55:23 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1738594523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gjKZmCpxgtx0eISGW2N8kiRISSFTr5QyPkvTSYFKwNY=;
	b=hZh10e/+vMU02GLtH//wwlHkm8++ZAVHMItUJ2HD/SWYG3vcjBKVtVeAB85hnSDrnKtOvv
	jFCH5g9gnf5nDMPRkd8mRId+f6GuNRkjYphkD9pJF696tN7WfcMOS90CBWI3jyIUBy0wKT
	V9v0F+XdXvq9Pu61cMSfdLWg7fIcQWo=
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id AA49E360265;
	Mon,  3 Feb 2025 14:55:21 +0000 (WET)
Message-ID: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>
Date: Mon, 3 Feb 2025 14:55:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: [REGRESSION] Invalid gather when using Tegra210 media engines
To: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com, jgg@ziepe.ca,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de
Cc: regressions@lists.linux.dev, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, diogo.ivo@tecnico.ulisboa.pt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Commit c8cc2655cc6c introduced a regression when trying to use the media
accelerators present on the Tegra X1 SoC.

I came across this regression when testing the branch [1] that leverages
the NVJPG engine in the Tegra X1 for decoding a JPEG file. After commit
c8cc2655cc6c we see the following error messages after submitting a job
through the TEGRA_CHANNEL_SUBMIT IOCTL:

[   46.879757] tegra-nvjpg 54380000.nvjpg: invalid gather for push 
buffer 0x0000000108f08000
[   46.888018] tegra-mc 70019000.memory-controller: host1xdmar: read 
@0x00000000021f7000: EMEM address decode error (EMEM decode error)
[   57.052256] ---- mlocks ----
[   57.055156] 0: unlocked
[   57.057620] 1: unlocked
[   57.060069] 2: unlocked
[   57.062533] 3: unlocked
[   57.064993] 4: unlocked
[   57.067439] 5: unlocked
[   57.069896] 6: unlocked
[   57.072351] 7: unlocked
[   57.074798] 8: unlocked
[   57.077254] 9: unlocked
[   57.079702] 10: unlocked
[   57.082251] 11: unlocked
[   57.084796] 12: unlocked
[   57.087329] 13: unlocked
[   57.089871] 14: unlocked
[   57.092411] 15: unlocked
[   57.094945]
[   57.096449] ---- syncpts ----
[   57.099423] id 0 (0-reserved-nop) min 0 max 0 (0 waiters)
[   57.104836] id 1 (1-54200000.dc) min 3261 max 0 (0 waiters)
[   57.110420] id 2 (2-54240000.dc) min 0 max 0 (0 waiters)
[   57.115745] id 3 (3-54340000.vic) min 0 max 0 (0 waiters)
[   57.121155] id 4 (4-ffmpeg) min 0 max 1 (1 waiters)
[   57.126275]
[   57.127766] ---- channels ----
[   57.130834] 0: fifo:
[   57.133029] FIFOSTAT 80100840
[   57.135997] [empty]
[   57.138109] 0-54340000.vic:
[   57.138113] inactive
[   57.138113]
[   57.144669] 1: fifo:
[   57.146856] FIFOSTAT 80100840
[   57.149833] [empty]
[   57.151936] 1-54340000.vic:
[   57.151940] inactive
[   57.151940]
[   57.158499] 2: fifo:
[   57.160694] FIFOSTAT 80100840
[   57.163661] [empty]
[   57.165775] 2-54380000.nvjpg:
[   57.165780] active class 00, offset 0fff, val ffffffff
[   57.173987] DMASTART 0x00000000021f7000, DMAEND 0x0000000000000ffc
[   57.180183] DMAPUT 00000010 DMAGET 00000010 DMACTL 00000000
[   57.185766] CBREAD ffffffff CBSTAT 00000fff
[   57.189960] JOB, syncpt 4: 1 timeout: 10000 num_slots: 2 num_handles: 1
[   57.196587]     0x00000001021f7000: 00080041: SETCL(class=001, 
offset=008, mask=01, [04000000])
[   57.205314]     0x00000001021f7008: 00003000: SETCL(class=0c0)
[   57.211161]     0x00000001021f700c: 20000000: NONINCR(offset=000, [])
[   57.217622]   GATHER at 0x0000000108f08000+0x0, 32 words
[   57.222944]     0x0000000108f08000: 10100002: INCR(offset=010, 
[00000080, 00000001])
[   57.230708]     0x0000000108f0800c: 10100002: INCR(offset=010, 
[000001c0, 00000000])
[   57.238472]     0x0000000108f08018: 10100002: INCR(offset=010, 
[000001c1, 00000000])
[   57.246235]     0x0000000108f08024: 10100002: INCR(offset=010, 
[000001c2, 0005ae60])
[   57.253998]     0x0000000108f08030: 10100002: INCR(offset=010, 
[000001c3, 0001fa40])
[   57.261761]     0x0000000108f0803c: 10100002: INCR(offset=010, 
[000001c4, 000516a0])
[   57.269524]     0x0000000108f08048: 10100002: INCR(offset=010, 
[000001c5, 0001fa60])
[   57.277287]     0x0000000108f08054: 10100002: INCR(offset=010, 
[000001c6, 00000000])
[   57.285050]     0x0000000108f08060: 10100002: INCR(offset=010, 
[000001c7, 00000000])
[   57.292814]     0x0000000108f0806c: 10100002: INCR(offset=010, 
[000000c0, 00000100])
[   57.300577]     0x0000000108f08078: 20000001: NONINCR(offset=000, 
[00000104])
[   57.307729]
[   57.309236] tegra-host1x 50000000.host1x: cdma_timeout_handler: 
timeout: 4 (4-ffmpeg), HW thresh 0, done 1

These error messages are printed with commit fae6e669cdc5 applied. If
this commit is not applied not even the Display Controllers work, as 
mentioned in
the regression report [2], and there is no display output, which we at
least get with the fix from fae6e669cdc5.

Something interesting here is that prior to c8cc2655cc6c we see the
following messages in dmesg:

[    0.044463] platform 50000000.host1x: Adding to iommu group 0
[    0.044547] platform 57000000.gpu: Adding to iommu group 1
[    1.385557] Failed to set up IOMMU for device 50000000.host1x; 
retaining platform DMA ops
[    1.395120] platform 54200000.dc: Adding to iommu group 2
[    1.400834] platform 54240000.dc: Adding to iommu group 2
[    1.406930] platform 54340000.vic: Adding to iommu group 3
[    1.412762] platform 54380000.nvjpg: Adding to iommu group 4
[    1.420438] Failed to set up IOMMU for device 54200000.dc; retaining 
platform DMA ops
[    1.436616] Failed to set up IOMMU for device 54240000.dc; retaining 
platform DMA ops
[    1.456545] Failed to set up IOMMU for device 54340000.vic; retaining 
platform DMA ops
[    1.465057] Failed to set up IOMMU for device 54380000.nvjpg; 
retaining platform DMA ops

whereas after c8cc2655cc6c + fae6e669cdc5 we only get:

[    1.818480] tegra-host1x 50000000.host1x: Adding to iommu group 0
[    1.829288] tegra-dc 54200000.dc: Adding to iommu group 1
[    1.839705] tegra-dc 54240000.dc: Adding to iommu group 1
[    1.855328] tegra-vic 54340000.vic: Adding to iommu group 2
[    1.859287] tegra-nvjpg 54380000.nvjpg: Adding to iommu group 3

Here GPU does not show up because I disabled the compilation of Nouveau but
the results are the same.

Please let me know if you need more information on my side and I'll be
happy to provide it.

Best regards,
Diogo

#regzbot introduced: c8cc2655cc6c

[1]: https://gitlab.freedesktop.org/d.ivo/mesa/-/tree/diogo/vaapi_remove_gpu
[2]: 
https://lore.kernel.org/linux-tegra/bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh/
