Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.252.191.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835506;
	b=R0p1PLON0zvN1L3JOEJ71N3MaREzXtEdaH54dhd79QIhAU/WsChNhGnhtYemiTPpmrg8
	 eWx0q4gYkqeXFj16cKlG90ViltSJOJFkH8ZKxWtb5wtyl3hIul+zgIhWOPjqK642e+u1s
	 5OY4IEstB3oh72lnR+ErlAykXjWwqRLdoCk1fuZ1lIWgia8PvBTx0m7IcGxaev/oZpld0
	 8DkUr08Kew0f1FooyrP1zJFo5ULtAj5SMm6LX+OzGBakkm6at/QudUaNlR5UcfGvX7UMj
	 Hx/GUYgq/6ZmPqNg8ZDu+RVwD+HGyCpBMQ1LPa2hRqW+4Dt9kA7S6dj/H8XKithARbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835506;
	h=DMARC-Filter:Received:DKIM-Signature:Received-SPF:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-PPP-Message-ID:X-PPP-Vhost;
	bh=h6R5zw96jSHtgk0JQfnX575DXRGvVboeUDNYcjh0khE=;
	b=ww0cYU229KbPb4ESHdr4DIQpBHpRGcB/FZoWIrvClNCu/a9b5IO1xZAvz/0J4ik5BEFL
	 b2Z73eA2i9oYwx0r75H7yrvLBQ3RjpHlsV7pRvAIVAVtKwOBgQqNQaMSu+ZBXBm1k5vjM
	 FP006lybeDDqXgL7BPvGxZdpETGA+3SVodvFWurN3PWFIdjY/OLKaD8ylZ0pdlgI2rO74
	 TBCSCzEQwXfaUT3hT6fV31+IvdFh9LaDNoZyXMLUvkzGJSyGgOnoLZKSdbchYZoId+rue
	 MwwMOQKX30Az3j1DOmdqMs6Vw98DGWiuw8mNaW1CDKZnXhwlhnd+OivuTwBNbr8ELUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itsolution.at;
	spf=pass smtp.mailfrom=itsolution.at;
	dkim=pass header.d=itsolution.at header.i=@itsolution.at header.a=rsa-sha256 header.s=default header.b=mY3gSENn;
	arc=none smtp.remote-ip=37.252.191.174
Received: from mail2.incublab.at (mail2.incublab.at [37.252.191.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADC606A32F;
	Mon, 16 Nov 2026 13:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91ADC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=itsolution.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itsolution.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itsolution.at header.i=@itsolution.at header.a=rsa-sha256 header.s=default header.b=mY3gSENn
Received: from [192.168.100.123] (h081217101012.dyn.cm.kabsi.at [81.217.101.12])
	by mail2.incublab.at (Postfix) with ESMTPSA id 438A3A64FC2;
	Mon, 16 Nov 2026 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itsolution.at;
	s=default; t=1794835497;
	bh=h6R5zw96jSHtgk0JQfnX575DXRGvVboeUDNYcjh0khE=; h=Subject:To:From;
	b=mY3gSENnecDKHMk3U75VfLRZMipmGqnw//u114enc8jWng+m1G91dPXY1/J8YgqSE
	 n3rLIlMnvFikZAF38QedyPovfVWeRklxM2kcKA6FTqUR5x3PLsztQJ/NWWtMsjSujl
	 JNbqdkgG/kcEKadPISn4K+Q8v+3ABzkiPh5ckosQ=
Authentication-Results: mail2.incublab.at;
        spf=pass (sender IP is 81.217.101.12) smtp.mailfrom=argishti.khachik@itsolution.at smtp.helo=[192.168.100.123]
Received-SPF: pass (mail2.incublab.at: connection is authenticated)
Message-ID: <81369be8-24b1-4f49-b63c-82e841b4c829@itsolution.at>
Date: Mon, 16 Nov 2026 14:24:56 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [REGRESSION] brcmfmac BCM43602: DMAR read faults and firmware
 timeouts on 7.3.3 with intel_iommu=on, works on 7.2.14 / with iommu=pt
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
Cc: iommu@lists.linux.dev, regressions@lists.linux.dev
References: <b010a7fa-73ea-43fa-a020-c2ea706295dd@itsolution.at>
 <4a47a57d-ee54-45c2-8948-fabbcbc6e322@leemhuis.info>
Content-Language: en-US, de-AT
From: Argishti KHACHIK <argishti.khachik@itsolution.at>
In-Reply-To: <4a47a57d-ee54-45c2-8948-fabbcbc6e322@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179483549754.811134.2094845711762216302@mail2.incublab.at>
X-PPP-Vhost: itsolution.at

Thanks, Thorsten. That looks like exactly my issue: same "PTE Read 
access is not set" DMAR faults on the RX side, followed by firmware 
command timeouts, and iommu=pt avoids it.
The BCM43602 uses the same msgbuf path as the BCM4364 in that report.

I'll test as soon as a Fedora kernel with the fix (7.3.5) is available 
and report back.

#regzbot fix: wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Ciao, Argishti

On 16.11.2026 13:56, Thorsten Leemhuis wrote:
> On 11/13/26 09:39, Argishti KHACHIK wrote:
>> since updating from 7.2.14 to 7.3.3 (Fedora 44 kernels), the
>> BCM43602 Wi-Fi in my Dell XPS 15 9550 is unusable when the Intel
>> IOMMU is in translation mode. Booting with iommu=pt fixes it.
>>
>> Hardware: Dell XPS 15 9550, BIOS 1.14.0 02/13/2020
>> Device:   Broadcom BCM43602 [14e4:43ba], PCIe, brcmfmac (msgbuf)
>> Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61
>>            (r598657) FWID 01-ea662a8c (linux-firmware)
>> Cmdline:  ... intel_iommu=on
>>
>> Results:
>> - 7.2.14-200.fc44.x86_64:            works
>> - 7.3.3-200.fc44.x86_64:             broken
>> - 7.3.3-200.fc44.x86_64 + iommu=pt:  works
>>
>> Userspace and firmware are identical in all three cases.
>>
>> The firmware loads fine, then a few seconds later the IOMMU
>> rejects DMA reads from the card:
>>
>>    brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 2015
>> 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
>>    brcmfmac 0000:02:00.0 wlp2s0: renamed from wlan0
>>    DMAR: DRHD: handling fault status reg 2
> Thx for the report. This is not at all my area of expertise, so be aware
> that the following might be misleading:
>
>  From a quick search for your error msg I found this thread that sounds
> somewhat related:
> https://lore.kernel.org/all/2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com/
>
> A fix for that is currently heading towards 7.3.y:
> wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
> https://lore.kernel.org/all/20261113153755.740970246@linuxfoundation.org/
>
> Is that maybe solving your problem as well?
>
> Ciao, Thorsten
>
>>    DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr
>> 0xfff83000 [fault reason 0x06] PTE Read access is not set
>>    DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr
>> 0xfff80000 [fault reason 0x06] PTE Read access is not set
>>    DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr
>> 0xfff7e000 [fault reason 0x06] PTE Read access is not set
>>
>> After that, every firmware command times out:
>>
>>    ieee80211 phy0: brcmf_msgbuf_query_dcmd: Timeout on response for query
>> command
>>    ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec failed (-5)
>>    ieee80211 phy0: brcmf_run_escan: error (-5)
>>    ieee80211 phy0: brcmf_set_wsec: failed to change PSK in firmware (len=0)
>>
>> and after about two minutes the command ring is full:
>>
>>    ieee80211 phy0: brcmf_msgbuf_tx_ioctl: Failed to reserve space in
>> commonring
>>    ieee80211 phy0: brcmf_run_escan: error (-12)
>>
>> Unloading and reloading brcmfmac reproduces the same DMAR faults
>> right after the firmware loads again.
>>
>> User-visible effect: networks show up briefly, connecting never
>> completes, then the scan list goes empty. Boot is noticeably slower.
>>
>> I can provide the full kernel log, test patches or bisect between
>> v7.2 and v7.3 if that helps.
>>
>> #regzbot introduced: v7.2..v7.3
>>
>> Thanks,
>> Argishti
