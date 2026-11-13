Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.252.191.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559173;
	b=Y2D0uiMt5PC8T0f5ffuEqaWr8YfefEvyxyal+KbWGNAUxg9Fd89u/xVnzy1y2C05Icmt
	 zMKhgj6UFLq0+HWS2JYubKcayfpJxpGZy+TEl0i2wYULGPJH5hguIq5SlsgCs0G4BX+uF
	 mG1cFTmeOfXQektaQzIltcD9tKTsFCTvgQAvVepY0D2MsP9VaHCIpSXWv6DUwm/FfbugT
	 TmAYTsjEQIYaUrBgWjode0rvQBH/To22rTHTCnDHehdUMVytd3rWxQmwZYlEpPYboXCrB
	 ThIPzZJ66/obQUqBqkErzJdmaSqlL8/v2WCuPP+kmN8Sq84paXqyVlrBfeVHDM+Qmsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559173;
	h=DMARC-Filter:Received:DKIM-Signature:Received-SPF:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-PPP-Message-ID:X-PPP-Vhost;
	bh=/nsIgMSuEZ3IjLcOmBYDv4yvMTvK+ErcT3BPn2PeS9E=;
	b=4PArbyQHowUYaMgEZoXPmvSvGux+W0HzB74AtcutktfSOwTOsmlBwRS2WbD/9GjckCz6
	 XaMbUTJbCeRYVzyIv4eYFLs7SVs4QTgK+tzxUbqYrGwCEOFMlVBwEVdxPudCvLx3Lwt6J
	 ewv9n+pd/37jB80YpueWCPqmbFzjQ5tB0kSYilAG/f1ieSpTGhsFamWoh1+eb90XTkBn1
	 fQC8SfbDtMJgSUhTselj+3AjBfgqB4fZP469pRJXKrF1VQM7UKJZ06J3vwaIDjVqxkwSA
	 bIygyB0xuygoWdVDmcwUYySG1osjUqJiDTV6mrLJ/MMJX/dsOnfTh5E9Hv/SB2OeHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itsolution.at;
	spf=pass smtp.mailfrom=itsolution.at;
	dkim=pass header.d=itsolution.at header.i=@itsolution.at header.a=rsa-sha256 header.s=default header.b=LNdMk8ct;
	arc=none smtp.remote-ip=37.252.191.174
Received: from mail2.incublab.at (mail2.incublab.at [37.252.191.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354A606B1DB;
	Fri, 13 Nov 2026 08:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A354A606B1DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=itsolution.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itsolution.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itsolution.at header.i=@itsolution.at header.a=rsa-sha256 header.s=default header.b=LNdMk8ct
Received: from [192.168.100.123] (h081217101012.dyn.cm.kabsi.at [81.217.101.12])
	by mail2.incublab.at (Postfix) with ESMTPSA id 88F26A075B3;
	Fri, 13 Nov 2026 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itsolution.at;
	s=default; t=1794559163;
	bh=/nsIgMSuEZ3IjLcOmBYDv4yvMTvK+ErcT3BPn2PeS9E=; h=To:From:Subject;
	b=LNdMk8cteDvTGSPaoLn7s3LP3kSbEREUbO2bGrrjhK6JmsLfZAuSvrctXLl9FBiI/
	 r281XuYQby/vlIBNOJThc0R1pj2TmSmIlKAZJGgjZZK5GBnNTDwwQDXCNJwSdDG6t4
	 7PligbHmYQc5cVukTGBJv4vrLxz0YoTLC46crmOU=
Authentication-Results: mail2.incublab.at;
        spf=pass (sender IP is 81.217.101.12) smtp.mailfrom=argishti.khachik@itsolution.at smtp.helo=[192.168.100.123]
Received-SPF: pass (mail2.incublab.at: connection is authenticated)
Message-ID: <b010a7fa-73ea-43fa-a020-c2ea706295dd@itsolution.at>
Date: Fri, 13 Nov 2026 09:39:23 +0100
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
Content-Language: en-US, de-AT
To: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev
Cc: iommu@lists.linux.dev, regressions@lists.linux.dev
From: Argishti KHACHIK <argishti.khachik@itsolution.at>
Subject: [REGRESSION] brcmfmac BCM43602: DMAR read faults and firmware
 timeouts on 7.3.3 with intel_iommu=on, works on 7.2.14 / with iommu=pt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179455916379.2529963.3953393442639834989@mail2.incublab.at>
X-PPP-Vhost: itsolution.at

Hi,

since updating from 7.2.14 to 7.3.3 (Fedora 44 kernels), the
BCM43602 Wi-Fi in my Dell XPS 15 9550 is unusable when the Intel
IOMMU is in translation mode. Booting with iommu=pt fixes it.

Hardware: Dell XPS 15 9550, BIOS 1.14.0 02/13/2020
Device:   Broadcom BCM43602 [14e4:43ba], PCIe, brcmfmac (msgbuf)
Firmware: BCM43602/1 wl0: Nov 10 2015 06:38:10 version 7.35.177.61
           (r598657) FWID 01-ea662a8c (linux-firmware)
Cmdline:  ... intel_iommu=on

Results:
- 7.2.14-200.fc44.x86_64:            works
- 7.3.3-200.fc44.x86_64:             broken
- 7.3.3-200.fc44.x86_64 + iommu=pt:  works

Userspace and firmware are identical in all three cases.

The firmware loads fine, then a few seconds later the IOMMU
rejects DMA reads from the card:

   brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/1 wl0: Nov 10 
2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
   brcmfmac 0000:02:00.0 wlp2s0: renamed from wlan0
   DMAR: DRHD: handling fault status reg 2
   DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr 
0xfff83000 [fault reason 0x06] PTE Read access is not set
   DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr 
0xfff80000 [fault reason 0x06] PTE Read access is not set
   DMAR: [DMA Read NO_PASID] Request device [0000:02:00.0] fault addr 
0xfff7e000 [fault reason 0x06] PTE Read access is not set

After that, every firmware command times out:

   ieee80211 phy0: brcmf_msgbuf_query_dcmd: Timeout on response for 
query command
   ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec failed (-5)
   ieee80211 phy0: brcmf_run_escan: error (-5)
   ieee80211 phy0: brcmf_set_wsec: failed to change PSK in firmware (len=0)

and after about two minutes the command ring is full:

   ieee80211 phy0: brcmf_msgbuf_tx_ioctl: Failed to reserve space in 
commonring
   ieee80211 phy0: brcmf_run_escan: error (-12)

Unloading and reloading brcmfmac reproduces the same DMAR faults
right after the firmware loads again.

User-visible effect: networks show up briefly, connecting never
completes, then the scan list goes empty. Boot is noticeably slower.

I can provide the full kernel log, test patches or bisect between
v7.2 and v7.3 if that helps.

#regzbot introduced: v7.2..v7.3

Thanks,
Argishti
