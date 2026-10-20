Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513484;
	b=H+5bgmKuN/OP7dUhLqN48Or+deRvR5oNLwcqujwUb5MFS8fKeO6mEpU5iQ55x3f2N3Xu
	 /uG9On8c1G1R9mr9AXjh8DMZMdak4NJ6VOUnBrh2XYG9Sz3qWXlfIBf7YLeYvIuZl6oNb
	 AbjjZ4qJbQeO6XtVvtcqSDxpVVOLMOPoWXze8GcEbaQh4/deayFbg6+qMaLEFsWNNoAjv
	 DOr2rAi8S5BLMoc6GE1BfbMh4m4r0Hxd9+lNsXdjNmb82dyqn7BivFav8f8W0SbPfFJug
	 CNZzhsl0V9Bpcj7cHwdneqVx9RuAfIkQv0WwigHxnzy+JrzkDTZX8AeyiLLjdaCUGbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OigSq64J0rt4TZoDpYc+GBYQyOVQhjW9BeOIpOHcBFA=;
	b=M6yQfeiKsnw44Qk6sMFOlTYlsN6SEx8yaYpKN1cM4c4jCgTd0dwxfCt0q+DhTjzEfkVK
	 8M5HZKbHaGmF11s3EraUGsq2P0occVxEqfkETpLem5y3qamqf2OXTkAg83yNX98JkdJZW
	 tyvD104e4EPpUJM8cyyhZ2jnfBxA6iro6jN1FoXrzqVe+OCFrFGglrqnh+0UWVq5jtSWc
	 v7XQGhodwm4hk4RyCuvOHuKcH1vIQRm7ZBKxKLkcjnxwFBWxo5Nh6vmaWrs/RP15xtcxN
	 l2ERGm3VNJTYTAH4+4IG4uhJ0Vt46eqMpcpU6zlitjQ7VIfYfYpzVwh3jxDmgrCvDXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IeYWvaqu;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF34606A33F
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 16:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF34606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IeYWvaqu
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6774639a8a4so2868860d50.0
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792513483; x=1793118283; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :user-agent:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OigSq64J0rt4TZoDpYc+GBYQyOVQhjW9BeOIpOHcBFA=;
        b=IeYWvaqukesCoPDloy/+BHTRcyvUaerh2uP8ra3QIz+eYK5nR9Z5W3IXTgHrjYQflA
         Nm/1Zb7cYJhcuBQOcLAFjKDCLZPXNhaUFq6ZsEG/V8qjeDxef5M3JRoqeL44jNRrN0JP
         0Nqb4/71aCju55iz5xe8ZzCPUjZgSmz8Prq/BLIW3S8bw9m0g8tVZvOrYWzD668Tn1Jk
         8u1DshEYbeYXY9GWzW+GVyLo7/13Gofw2I6OU40qOS4VkPLEREnwFAj/UbYnI1XeHadQ
         lnOfBrG4GQd3fKGU3Mj1jkqRrSFMZOz+eR6ojyAvS6ToIVA+QjcPigEVt5t0oJiUPArs
         FXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513483; x=1793118283;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :user-agent:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OigSq64J0rt4TZoDpYc+GBYQyOVQhjW9BeOIpOHcBFA=;
        b=lIt7pyK/A3dLcq7RrhUexijwomqU9Y2F9cvVAkTXexlirp12eu2TjwBBN1iA617Jlx
         /hTory/dGYHC2VB5KXV6qYkvhoeiZ169+7NHu1MINP/4WopmEDchqCM48gm8dQ7x0Ic9
         ADUi6hvTKCuXa+eCh4VT9E2dYa3iNaHRxl5B7URHc9uue1fM5l8DDCjBSwE/0WG5/KUv
         Be2xJyoeTK/MUDMfKsrQSJOed9RPhNIZlWjjkVU0hdBVLTom9UW0+C46Krg0C0jK2uR/
         J749B38t3qBJ1IfTzVoNQsnuJmiL0rNoBIJI6vZJlQOWleTlUVeMnaZ5tZw2TeMPXbjv
         v00A==
X-Gm-Message-State: AFq9FYJAwKzlk4hl4zCqQ5mEPMW/B3rajRa74qRhnKM62CDJlNQDtm1P
	+lTtbgpflLIxTlbcQ6CfIvwg2Xt2lzOzvLbnR/xNTC/VbgRwZHPcDhpn
X-Gm-Gg: AYBFou034sYKcDlXGOdubn+iYAqRV5lTqzNjFF7Qlfx0C0tPc4YyFZ6nE0Xr8mWJyZS
	8pfxr1yYKAiJsGgqNpS/oFt97ZPBSvVpUZ8jMib5XKUT6y7YDv6SSQPYfnO5KJPjK/pxoXR80DO
	IW+XfmO+3Lx7WUsX2vF7hlLBMdU0EIf02OIvrm6UqbQu/Et1l5i8qgLRh0MKVu1T3ZTRH13o/CA
	hnfXI5BGzZ2uCIv3eq014xRjCosnOO5XVlU9Wk7obxPf1SSpAv61dS6Ivv9q8VpdiGXfvzNx+mr
	Fviy/b5E7iZmRc58A8qI3/qQuo2umUxd+Hrol3HLg8fmGFMi0164cknlMLAU35P7aj5vr9XIeWz
	b+ticDBSPPYFjE4oSFF5aEMgPBTLydFeM7aLDqmhLUdaLN1osENUT7hXM2LjeVBBI44Dcij2OXm
	Y832yjbIUcmxEgMzzfNRANE43HOyZm/ZFNWAfWQzHb3+7Wx1BWugISKC2DXWwuCf2oLvBUvzfz7
	C9ZYQOoXZuYiGkgcYZb0nfrtuXRyNNx+qSUFoXbY+RQFO6Wpyk9tbnx6vVCUF2pktCT7wx4FLpz
	ViurpJJZ+ch9cyWZEMAOyc7ALmFewLJ4ZPhN8b7LsCI5G4DkpcNQnB4BOz4bLwnlLXMak6Pq/SY
	MDpI5DQ==
X-Received: by 2002:a05:690e:43c3:b0:679:980d:996d with SMTP id 956f58d0204a3-679ca75c039mr1677629d50.23.1792513482689;
        Tue, 20 Oct 2026 09:24:42 -0700 (PDT)
Received: from ehlo.thunderbird.net (212.153.88.200.l.sta.codetel.net.do. [200.88.153.212])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e095efsm5543486d50.5.2026.10.20.09.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:24:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:24:40 -0400
From: Jason Perlow <jperlow@gmail.com>
To: aditya.garg@linux.dev, baolu.lu@linux.intel.com, dwmw2@infradead.org
CC: iommu@lists.linux.dev, bhelgaas@google.com, linux-pci@vger.kernel.org,
 arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
Subject: =?US-ASCII?Q?=5BREGRESSION=5D_intel-iommu/brcmfmac?=
 =?US-ASCII?Q?_DMAR_fault_on_Broadcom_PCIe_wifi=2C?=
 =?US-ASCII?Q?_v7=2E3-rc7_-=3E_v7=2E3_final_--_candida?=
 =?US-ASCII?Q?te_mechanism_and_proposed_fix_path?=
User-Agent: Thunderbird for Android
Message-ID: <7A444F17-F81B-4A33-A7AF-9E30B3EEFA67@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Resending, stupid Gmail mobile client/HTML/apologies =2E

=3D=3D=3D ORIGINAL REPORT =3D=3D=3D

Hardware: Intel CoffeeLake-H platforms, various=2E The affected device is =
a Broadcom BCM4364 802=2E11ac PCIe wifi adapter (14e4:4464) at 0000:05:00=
=2E0 on an Apple MacBookPro16,1 (T2 Mac)=2E Aditya, including you directly =
since this is T2 hardware; copying iommu/pci/wireless because the fault sig=
nature and the fact that it reproduces on only one of five tested machines =
(at the time of the original report -- see follow-up below, that has since =
changed) looked like it needed eyes on the core IOMMU/PCI path, not the dri=
ver=2E

SYMPTOM

Between a locally-built v7=2E3-rc7 kernel and a v7=2E3 final kernel (same =
=2Econfig template, same patch series beyond one T2-specific AER quirk that=
 is upstream in final and therefore held out of our patch set), the BCM4364=
 wifi firmware on the affected unit crash-loops continuously:

   brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4364b3-pcie for ch=
ip BCM4364/4
   brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4364/4 wl0: =2E=2E=2E
   ieee80211 phy0: brcmf_fw_crashed: Firmware has halted or crashed

repeating every ~6s, indefinitely=2E dmesg shows the actual mechanism -- a=
 real IOMMU DMAR page fault on the wifi device, timed to the same cadence a=
s the firmware crash:

   DMAR: DRHD: handling fault status reg 3
   DMAR: [DMA Read NO_PASID] Request device [0000:05:00=2E0] fault addr 0x=
ffeff000 [fault reason 0x06] PTE Read access is not set

Four such faults logged at uptime 13=2E4s/19=2E4s/25=2E3s/31=2E2s, each im=
mediately followed by a brcmf_fw_crashed event=2E intel_iommu=3Doff removes=
 the fault and the crash entirely (8+ minutes stable, single clean firmware=
 load, stable AP association)=2E The prior v7=2E3-rc7 kernel on the SAME un=
it has zero DMAR faults and zero firmware crashes with IOMMU on by default,=
 so this is a regression introduced somewhere in the rc7->final window on t=
his unit, not a long-standing issue=2E

ORIGINAL 1-of-5-machines SURVEY (since superseded, see follow-up)

We initially ran the identical kernel build across five machines and only =
one faulted at the time: the affected unit; a second MacBookPro16,1 with th=
e same BCM4364 chip; three non-Mac x86_64 machines spanning three more wifi=
 vendors (Intel iwlwifi AX201, Intel iwlwifi Centrino 2230, Realtek rtw89 8=
852BE), all clean=2E IOMMU was actively translating DMA on every one of the=
 five machines; only the one unit faulted at that time=2E

WHAT WE RULED OUT BEFORE WRITING IN

 * AER/ANFE quirk on the T2 Secure Enclave device: its PCI ID match is exa=
ct (Apple SEP, 106b:1802) and does not touch the wifi device (14e4:4464); r=
eal PCI topology on the affected unit also shows SEP and wifi on separate r=
oot ports (00:1b=2E0 -> [04] vs 00:1c=2E0 -> [05] off the PCH), so there's =
no shared-root-port mechanism either=2E
 * brcmfmac driver source: git diff v7=2E3-rc7=2E=2Ev7=2E3 -- drivers/net/=
wireless/broadcom/brcm80211/ is empty=2E
 * Our own config template: byte-identical between the rc7 and final build=
s=2E
 * The upstream Kconfig stanza for INTEL_IOMMU_DEFAULT_ON (drivers/iommu/i=
ntel/Kconfig): byte-identical text between v7=2E3-rc7 and v7=2E3 (default y=
, no depends on)=2E

THE ONE ANOMALY WE CAN'T YET EXPLAIN

Despite the last two items above being unchanged, the actual generated =2E=
config has CONFIG_INTEL_IOMMU_DEFAULT_ON unset after make olddefconfig agai=
nst the rc7 source tree, but =3Dy after the same process against the final =
source tree, even though our template explicitly answers "# CONFIG_INTEL_IO=
MMU_DEFAULT_ON is not set" in both cases=2E Our working theory is that some=
 other symbol started selecting/implying INTEL_IOMMU_DEFAULT_ON between rc7=
 and final -- which would override an explicitly-seeded "not set" answer du=
ring olddefconfig resolution -- but we have not identified which one yet=2E

=3D=3D=3D FOLLOW-UP (what changed since the original report) =3D=3D=3D

1=2E The second test unit we called "clean" (CHIMERA, identical MacBookPro=
16,1 model and BCM4364 chip to the affected unit) was NOT actually immune -=
- left running longer, it crashed at 41 minutes uptime with the identical s=
ignature=2E So this is not host-specific or even config-specific within a m=
odel; it is cumulative/probabilistic with firmware-crash retries, not a sta=
tic per-unit property=2E We now apply intel_iommu=3Doff to both units=2E

2=2E We tested iommu=2Estrict=3D1 (forcing synchronous TLB invalidation, n=
o lazy-unmap window) on the affected unit=2E It does NOT fix the problem --=
 9 firmware crashes and 18 DMAR faults in the first minute, same as baselin=
e with lazy invalidation=2E This rules out a stale-mapping-during-lazy-unma=
p race specifically=2E The IOMMU is failing to produce a valid mapping for =
the address the device requests, not failing to invalidate an old one in ti=
me=2E

CANDIDATE MECHANISM

The four DMAR fault addresses we captured are all exactly 4K-page-aligned,=
 clustered within a ~2MB window, with irregular (non-fixed-stride) deltas b=
etween them -- consistent with each firmware-crash retry requesting a genui=
nely fresh page, not a sub-page cacheable-alias bug=2E

Reading drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie=2Ec (v7=2E3)=
 shows why=2E On firmware crash, the bus =2Ereset op (brcmf_pcie_reset()) r=
uns this sequence, unconditionally, for every chip revision:

 1=2E Disable ASPM=2E
 2=2E A real hardware watchdog reset of the wifi chip's own silicon: WRITE=
CC32(devinfo, watchdog, 4) -- a write to the BCMA ChipCommon core's watchdo=
g register, Broadcom's standard SoC-wide hardware reset mechanism (used her=
e in place of a PCIe FLR)=2E
 3=2E Restore ASPM=2E
 4=2E Free the old ring buffers (brcmf_pcie_release_ringbuffers, dma_free_=
coherent) and allocate fresh ones (brcmf_pcie_init_ringbuffers -> dma_alloc=
_coherent, confirmed clean, correct DMA-API usage -- no raw pointer math, n=
o dma_map_single/dma_map_page misuse)=2E

So every firmware-crash recovery cycle contains an actual chip-level hardw=
are reset of the wifi silicon, sitting inside the normal recovery path, imm=
ediately before fresh DMA buffers are allocated=2E The IOMMU has no visibil=
ity into that internal chip reset -- it only tracks dma_alloc_coherent/dma_=
free_coherent calls=2E If the chip's internal DMA engine state (cached poin=
ters, in-flight descriptor/prefetch state) is not fully re-synchronized wit=
h the IOMMU's page tables across that reset window -- plausibly interacting=
 with whatever changed in pci_dev_wait()'s reset-timing behavior between v7=
=2E3-rc7 and final, one of the only real PCI-core diffs we could find betwe=
en those two tags -- a stale or premature DMA read from the chip in that wi=
ndow would produce exactly "PTE Read access is not set": a page the IOMMU h=
as no reason to have mapped yet=2E

This reads as plausibly Broadcom-specific rather than a generic any-PCIe-w=
ifi-vendor bug: in our survey across Intel iwlwifi (two chip generations) a=
nd Realtek rtw89, all clean on identical kernel/IOMMU config, none of those=
 drivers perform a full chip-level silicon watchdog reset as part of routin=
e firmware-crash recovery the way brcmfmac does=2E That is a direct consequ=
ence of Broadcom's wifi chips having their own embedded ARM co-processor an=
d firmware, versus a more host-driven firmware model elsewhere=2E

We have not proven this causally yet -- it is a source-grounded mechanism,=
 not a confirmed root cause=2E

PROPOSED FIX PATH

1=2E Bisect: the real fix, if this mechanism is right, most likely belongs=
 in one of two places -- (a) brcmfmac's reset sequence, inserting a synchro=
nization point (barrier, or a readback to force completion) between the poi=
nt where the fresh DMA mapping is guaranteed IOMMU-visible and the point wh=
ere the device is signaled ready to resume (brcmf_pcie_hostready / the mail=
box write that follows), or (b) PCI/IOMMU core, if pci_dev_wait()'s v7=2E3 =
behavior change doesn't give the IOMMU enough time to fully settle before t=
he device can issue a post-reset DMA=2E We don't yet know which=2E
2=2E We are rebuilding with CONFIG_DMA_API_DEBUG=3Dy to reproduce this on =
the affected unit=2E That should show the exact call site and timing of the=
 bad mapping, which would tell us definitively whether this is a one-line b=
rcmfmac timing fix or something deeper in IOMMU/PCI core=2E Will report bac=
k with results=2E
3=2E In the meantime, worth testing as a less blunt interim workaround tha=
n intel_iommu=3Doff: iommu=3Dpt (passthrough -- disables DMA remapping but =
keeps interrupt remapping)=2E Haven't tried this yet ourselves=2E

Happy to share full dmesg, the DMA_API_DEBUG output once we have it, or te=
st a proposed patch on real hardware -- we have the affected unit and can r=
eproduce on demand=2E
