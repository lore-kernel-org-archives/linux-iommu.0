Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833808;
	b=E3sHSsfyPdNOJG+bIkFW/jSQ8go8J3dnzz2vaKpUCM7m9ClcuUSCBFJllXfD2ldFj7A0
	 +GzqTE0tUdz/nFh0YxrA9aBLd3c6mo/1v1uRZ6mPL8sEX31Y6fM7SkDksWFYF0nXw2gmE
	 QBbycRk5xZkiGWtHgUN181m/ksNyYBdCbePV2RkBXXwk/JvB2rdEdzY8KgnXPPgX9gXNW
	 PK+De6kcBznMrPaIANNLHTIYuATRm2MNOrFlZA704mVDTHqiF+/Dlm0qe5wciM6KT6XCU
	 Oxgl6LOzwahlBOStydasL7K4NYdhY/mGLLJxrnk3fv69v6lZq/cgIR6XPSEsf6HnI0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=AySk9TZzV4MYiU/BGdCP3GZJ+DuHFYPn7n3AJWBQ9/U=;
	b=WFXuDLDrx3LEuKDfwT3+35TgP01RkYp8cBY6RyY2A+mE83ZEXG3VRDK8XyGe/MHAaMrk
	 u+FLa48bKLchY5hbFKcQ359/+c0zr91vbiXEBV9n92zzYqFD3nhptkthR4O10lgpz+OlR
	 Qd4oivnWQ+ssXUyBRn5Vc41JL9uKZIJ/niK6m0Slv5XnyFQIYxBTVbBoiiinEBRmqzInm
	 fcH9A3OA9NUIk1CoaoL9Gfqk8bb8rI5fnVh3nl9HeN448hAHC9qmo14gCJYFeKHm08La+
	 GTXektQSWNwpAmvprF2N4eKrqPGuYGvpLzT1whJUJAfb3+4V/vYh0zSqwU92ha/7/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=G98JHegM;
	arc=none smtp.remote-ip=188.68.63.166
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610FB606A31C;
	Mon, 16 Nov 2026 12:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 610FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=G98JHegM
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jSntZ2FrNz4Jvq;
	Mon, 16 Nov 2026 13:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794833798;
	bh=RUCNJeguN48m5eoyub5yMpKhrSolVckKqyUaULknHCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G98JHegMDZXR2RMTEZbqKHeJ012FIUi4YbLhYQWcB0Lo+54Q1IUYV4Oh3s6hr5qHz
	 SeF8y+U6ro4OEy2o4sRl8zgU2QkjysAGAgk0pnhZ9D3PEeg/7TQsUj/H3fOycMAIKq
	 gLANn9rqJ1IMfnHv+PJqwj8IvpM4JUcNLPCJGeLrLI/2Q2xN62XDpH7dZlYqhcYXLD
	 d5i08xoefDZCQ9mX7yxMBRl/ft1N7BjmmURkZXBR7U25FkUsYoOZqbRzM0sUgewyzN
	 vlpXb9jcphiARipmIHnewp9H3fz8toOwnwVxqi60B3MmF7cg8VNKxwr8pkZro76k1Y
	 rL3VMRC9wLLCQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jSntZ1YhSz4Jvf;
	Mon, 16 Nov 2026 13:56:38 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jSntZ3ZLDz8sb7;
	Mon, 16 Nov 2026 13:56:38 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7811C5F9EB;
	Mon, 16 Nov 2026 13:56:33 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4a47a57d-ee54-45c2-8948-fabbcbc6e322@leemhuis.info>
Date: Mon, 16 Nov 2026 13:56:32 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] brcmfmac BCM43602: DMAR read faults and firmware
 timeouts on 7.3.3 with intel_iommu=on, works on 7.2.14 / with iommu=pt
To: Argishti KHACHIK <argishti.khachik@itsolution.at>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
Cc: iommu@lists.linux.dev, regressions@lists.linux.dev
References: <b010a7fa-73ea-43fa-a020-c2ea706295dd@itsolution.at>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <b010a7fa-73ea-43fa-a020-c2ea706295dd@itsolution.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179483379382.1000705.2016802566482365866@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 7811C5F9EB
X-NC-CID: wo7XxjZvvxvxxZLF30kXgaRnnU84ojJuzpJUm/nFgafWKYiNY1A=

On 11/13/26 09:39, Argishti KHACHIK wrote:
> 
> since updating from 7.2.14 to 7.3.3 (Fedora 44 kernels), the
> BCM43602 Wi-Fi in my Dell XPS 15 9550 is unusable when the Intel
> IOMMU is in translation mode. Booting with iommu=pt fixes it.
> 
> Hardware: Dell XPS 15 9550, BIOS 1.14.0 02/13/2020
> Device:   Broadcom BCM43602 [14e4:43ba], PCIe, brcmfmac (msgbuf)
> Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61
>           (r598657) FWID 01-ea662a8c (linux-firmware)
> Cmdline:  ... intel_iommu=on
> 
> Results:
> - 7.2.14-200.fc44.x86_64:            works
> - 7.3.3-200.fc44.x86_64:             broken
> - 7.3.3-200.fc44.x86_64 + iommu=pt:  works
> 
> Userspace and firmware are identical in all three cases.
> 
> The firmware loads fine, then a few seconds later the IOMMU
> rejects DMA reads from the card:
> 
>   brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 2015
> 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
>   brcmfmac 0000:02:00.0 wlp2s0: renamed from wlan0
>   DMAR: DRHD: handling fault status reg 2

Thx for the report. This is not at all my area of expertise, so be aware
that the following might be misleading:

From a quick search for your error msg I found this thread that sounds
somewhat related:
https://lore.kernel.org/all/2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com/

A fix for that is currently heading towards 7.3.y:
wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
https://lore.kernel.org/all/20261113153755.740970246@linuxfoundation.org/

Is that maybe solving your problem as well?

Ciao, Thorsten

>   DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr
> 0xfff83000 [fault reason 0x06] PTE Read access is not set
>   DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr
> 0xfff80000 [fault reason 0x06] PTE Read access is not set
>   DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr
> 0xfff7e000 [fault reason 0x06] PTE Read access is not set
> 
> After that, every firmware command times out:
> 
>   ieee80211 phy0: brcmf_msgbuf_query_dcmd: Timeout on response for query
> command
>   ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec failed (-5)
>   ieee80211 phy0: brcmf_run_escan: error (-5)
>   ieee80211 phy0: brcmf_set_wsec: failed to change PSK in firmware (len=0)
> 
> and after about two minutes the command ring is full:
> 
>   ieee80211 phy0: brcmf_msgbuf_tx_ioctl: Failed to reserve space in
> commonring
>   ieee80211 phy0: brcmf_run_escan: error (-12)
> 
> Unloading and reloading brcmfmac reproduces the same DMAR faults
> right after the firmware loads again.
> 
> User-visible effect: networks show up briefly, connecting never
> completes, then the scan list goes empty. Boot is noticeably slower.
> 
> I can provide the full kernel log, test patches or bisect between
> v7.2 and v7.3 if that helps.
> 
> #regzbot introduced: v7.2..v7.3
> 
> Thanks,
> Argishti

