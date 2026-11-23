Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462525;
	b=0/xem7tlhAR69Z3uIaf3c4UlyvyKmvg6w4ZkI8c8Iy+NcDAXOqFCTdaf5+GMnsysXlPw
	 0CdOdc5YWZEvWVO0kzG2xSsuBYna1r7OckSYki+D1B6Sc0E2zx0/CNr2Rps4pGCMbcckE
	 AflincgpmN0V4NplpAMtz2KpNE8iXtgzN9dO6X55RyOdmg0QZUEoG4aPKCa9tc6YRwKaP
	 FUllC5y9V5rnQtn+A4npGuhjngmkZWU9FI8B5eBviVvvbrgD/h432qSHp4uxrgRr1ZryP
	 ozrpPR9j5Eep1nzycPSW+Mymv+zUC0GglMsRns5VjjLAT5bEUKjSk/wBppJMa+lC9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462525;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Message-Id:Date;
	bh=ZiwswBjB8SuAHKpqVoUng3ormeEZ1lBb3Z+5aMiucdM=;
	b=u6AzTzCJ6CXYCdl2KOkkGKy48u/c1l/YxyFKqG3aYrDw3AICsv38QC7qtopjm2nQzPAA
	 bwkPLY2QaxXVpVtD3CxPV1Uwfj+PEogVQP84LWBulzxB7e6yeRExeEmBOH6MjPqI0rs3A
	 1ue6aor8dV3o/818PiC2KWMWrI0Lscl1b3PjooZ/a6g45474676LTXDfIqyPM9OuTHxDs
	 PmjkoQ3UiSPjgfa3WoM6kW5M6JQH+R1E/YxHLtMGPUNPIrvQhHsep+JCuclnKMPNirkgp
	 kCwY5ymvrgfNAXBykHZgfAxE1HXwC43K5o6V+5754rzkJvQTIzI5V7F3QF1KQ5F7P7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aigeus.net;
	spf=pass smtp.mailfrom=aigeus.net;
	dkim=pass header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=jnNUAiE+;
	arc=none smtp.remote-ip=79.135.106.111
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF44606A326
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF44606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aigeus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aigeus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=jnNUAiE+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aigeus.net;
	s=protonmail; t=1795462522; x=1795721722;
	bh=ZiwswBjB8SuAHKpqVoUng3ormeEZ1lBb3Z+5aMiucdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-Id:Date:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jnNUAiE+qblP0m3bUbNS7ANJmBbAc5EHc8VM8emCJ8xH2o4smvQMRivA3kklTGSJW
	 hsx93P4zmwkjxIkzGrUE/MZkTDNrSqL7uWoKh2DtzO78hg/jJwRhfg9JPO+MDYEwLM
	 MozBWlKwb4mlkJQT0uSGfSOe70+Mc/JnlRjUNBhgrBRxJ4b6a/dvaCmSHUU32lV74X
	 co/p8oKt+lKKrPzoL0pLhi6gyyAOqQq3HNFnZ9LE2RpHoQjN6sJ1yS0FgkU7DWjEZ4
	 MwDwF9C6SQ+S4yEcVgU/FHA8j4NFVM+2kikfS4K6O5qfUKeyhbnzdUpApCwdAr6m5B
	 in9xFCjQRb+/w==
X-Pm-Submission-Id: 4jYGPN6WyGz2ScQD
From: Aigeus <info@aigeus.net>
To: iommu@lists.linux.dev, regressions@lists.linux.dev
Cc: baolu.lu@linux.intel.com
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
In-Reply-To: <HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=@protonmail.com>
References: <HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <4jYGPN6WyGz2ScQD@mailsubfra1001.protonmail.ch>
Date: Mon, 23 Nov 2026 19:35:20 +0000 (UTC)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

Hello again,

Two follow-ups to my previous message, both of which strengthen the case that
this is the page-table producer rather than the driver.

1) The workaround is now verified with the card actually installed (before it I
   could only show that the faults stop). Same machine, same BIOS, same kernel
   7.3.4+deb13-amd64, intel_iommu=off, monitor on the AMD output:

     amdgpu 0000:03:00.0: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
     amdgpu 0000:03:00.0: SMU is initialized successfully!
     [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 1
     fbcon: amdgpudrmfb (fb0) is primary device
     dmesg | grep -c "fault reason"   ->  0

   So on this box the only thing that breaks the RX 5500 XT is the Intel IOMMU
   code path; with remapping off the card initialises normally and becomes the
   primary display. iommu.passthrough=1 is still untested - say the word and I
   will boot with it and report, it is a five-minute test now that the card
   works.

2) While filing this with Debian I found two other reports of the same fault
   reason on the same kernel family, with completely different drivers:

   - Debian #1154877: linux-image-7.3.4+deb14-amd64, "brcmfmac BCM43602 Wi-Fi
     broken by IOMMU DMAR faults (regression from 7.2.15)"
   - Debian #1155040: linux-image-6.12.118+deb13-amd64, "Boot hangs with
     nouveau GPU faults and DMAR errors; 6.12.117 works" (different kernel
     line, so possibly a different cause - I have not read that log)
   - mine is now Debian #1155044 (amdgpu PSP/SMC, the report above)

   Three unrelated drivers losing DMA with fault reason 0x0c on the same kernel
   family is hard to explain as a driver bug.

Anything you would like me to bisect or measure on this box, I can turn around
within a day now.

-- 
Aigeus
GitHub: EgolOS <79418083+EgolOS@users.noreply.github.com>
