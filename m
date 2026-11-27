Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789675;
	b=AQ1Y/kMwQSYQadlkDIw4E4VMj5VpkFcL4EGUG7d5KV+fiIddehVOCyjVlt8lqsJphOtA
	 3y2dfhODncRmEy76qW6Vvis++GjNP5/o6WRhbsiASGuYzpXnsUKtY+UtvI0usCHKBACjm
	 yzq9aj2OeTrYOaHfmuS41wpZybZyzAPbzkznnjXQURGCPPxkH5UDXue6AtXjMddDsRjzY
	 czAgcMemiL0SwuSgQUJQzQpPy5+0dGMdCK9LJ8Pho6XSvTrpLMFB3E9iLiJdWUvCwUOVh
	 0WtUg0GOTa/Sr+1GoEE5wOvS5K2F0iu7TMBqFECOrxJPAwCRxkloVU3p9OPNPe3vuPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789675;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 In-Reply-To:References:Message-Id:Date;
	bh=2lvQDzIwXX86EkagmIwt4gm5b7c7JGMGPsZmdb6GU58=;
	b=xkE+4ywmr+k688ewTEpAPQqvGeMKOLCW1f35ld4Qn7YX+uSx5ASLflAkYk0rqjLzvrrB
	 gR8wboDEOoEZIv+y8WluVEAuZ81IJ9lC4/ApHGBHKEz1qUwiEvqCmh754yCEPHASBLVN7
	 GBdllxYJmFKUdBxD6RQQP7Ge1V0pioqTCPATCIgV+jFK6kQEQ/WBWpK1TMMLAQyQiDVBy
	 moq6P1jUq0i9Zuat7XQnt7BMVEoQ8zB2wZq87LiFhkICx7Cu1EaByXoouEeuVnqFHLn3y
	 RHbLNtek7VRN+p/9M/1WsRQN4ivDYUPNQGi521jfh6H+Fzuz6Oagi/e0FBLOgXjKlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aigeus.net;
	spf=pass smtp.mailfrom=aigeus.net;
	dkim=pass header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=Gy7J5hUr;
	arc=none smtp.remote-ip=109.224.244.107
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C9606C2CA
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE5C9606C2CA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aigeus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aigeus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=Gy7J5hUr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aigeus.net;
	s=protonmail; t=1795789672; x=1796048872;
	bh=2lvQDzIwXX86EkagmIwt4gm5b7c7JGMGPsZmdb6GU58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-Id:Date:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gy7J5hUrmtzUN/1DvQDRWZEpM+NdhOjMfKIgRymkF1plat/eRyZbgNLDCEPFYXXuO
	 08NLbFbcKK7fFXAaP4zJg+JbPfWoEp0SpSp0UD811nixs6d8IqzIWDMNWK16oiNdYu
	 uThCnISs/pdkR7CZEFaerMML7F5jePQo9kT6fuykBVvbsVEVAYCr1L9NV83dNut4RG
	 PikxibvBs+sASblCQxO7unAPmIneZL28rzah3tpSqNTfSZ1HMusL8SwscFSW5liN4i
	 ykHdXV7VVMDUPtzSmh7oF5i5u4ImBwlpqNn1K+k5AqQ8cndY04ioJHygHxpaF3mx2I
	 cQ2cw3v3pCKAw==
X-Pm-Submission-Id: 4jbbNj4Glnz2ScWg
From: Aigeus <info@aigeus.net>
To: "70sp" <70sp@protonmail.com>, "Baolu Lu" <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, regressions@lists.linux.dev,
 "Thorsten Leemhuis" <regressions@leemhuis.info>
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
In-Reply-To: <d931a389-c143-4a6a-931c-bc7025bcefb9@linux.intel.com>
References: <275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06070@linux.intel.com>
 <QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU=@protonmail.com>
 <d931a389-c143-4a6a-931c-bc7025bcefb9@linux.intel.com>
Message-Id: <4jbbNj4Glnz2ScWg@mailsubfra1002.protonmail.ch>
Date: Fri, 27 Nov 2026 14:27:49 +0000 (UTC)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

Hello,

I am the reporter of the in-kernel amdgpu case in this thread (the one
without VFIO, also filed as Debian bug #1155044). The superpage
hypothesis fits my machine exactly and sp_off confirms it, so here is
an independent data point from a plain DMA-API domain.

Hardware: Gigabyte H97-HD3 (BIOS F9c), Core i7-4790K (Haswell, iGPU
enabled and driven by i915), Radeon RX 5500 XT (Navi 14) at
0000:03:00.0, Debian 13, kernel 7.3.4+deb13-amd64.

With plain intel_iommu=on this box fails as in my message of 23 Nov:
DMAR faults with reason 0x0c (non-zero reserved fields in PTE) on DMA
reads issued by the GPU itself, then "PSP load smu failed" and
"Fatal error during GPU init" (36 fault lines across the failing
boots, 0 on 6.12.118).

After appending sp_off to the intel_iommu= options and rebooting, with
everything else unchanged:

  /proc/cmdline: ... ro quiet splash intel_iommu=on,sp_off
  DMAR: IOMMU enabled
  DMAR-IR: Enabled IRQ remapping in xapic mode
  i915 0000:00:02.0: [drm] VT-d active for gfx access
  amdgpu 0000:03:00.0: VRAM: 8176M ...
  amdgpu 0000:03:00.0: SMU is initialized successfully!
  [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 1
  dmesg | grep -c "fault reason"  ->  0

So the fault class is not VFIO-specific: an in-kernel driver using a
plain DMA-API domain hits the same reserved-PTE rejection, and
disabling superpages removes it while DMA remapping and interrupt
remapping stay enabled. That is consistent with the Haswell
IGD/superpage restriction Šimon described.

Once the change is reposted as a formal patch I can build it against
the Debian 7.3.4 tree and boot-test it on this machine within a day,
so the verification does not have to rest on one box.

Thanks,
Aigeus
GitHub: EgolOS <79418083+EgolOS@users.noreply.github.com>
