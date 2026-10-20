Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792495984;
	b=FY7cgxULjYGmQeZn7UoDL4kmcCwoekvnVcwplucPTQmLVNaHyKR3tU9fX12vLwg6Ygok
	 NTdV2yRwqVFUHLWI3pmWF5G4AfUZjQ28UdodVMIuUxkkOL+4aif1BnV/BRw2IQfvdTtPC
	 HrpliP9xSODL7tSbGS5JOZu8S4qY6A0u6TRprravWjTcU/glT9k4AU6m90upMo9vZEXN2
	 8E6I7+SHA28rsr+ZfY9+/z8p0X73dpAfNj1X0218dqiszfLbmAMjNBEfWQI0cwZtxELil
	 CGMpXJ7ENRAtSCVnJLR7M4dyHuBbZCVooqKElbitB4ugRYlea5LoSFDdK1pCXaG28fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6w7JRuFovvwwUBTh/FtHv2xuiuhqO2jha1lfwIcoggA=;
	b=4DRc4BkAs1/IyEQUgPr69pB8my3KAKaavrqHqZmlYM4IiTvs278tqQesZ1imgDHEsMav
	 t6Eymi4KqIoOQHRPTgl0BUPlA7iPVXfwA21zSIFZfsxgsGYNTrMVHTNAxAjvc2sXhHCYu
	 opTE2uBgtLXCcSUflfyTUWjHWbMCgKJdKKfsGfMBlvItxlLzM4OWqUYcP7j2cnQcZ9Z2i
	 /etBBeXvyjT4eWF7THNuwWXEHydt/BEDU/H9UgzuvPUKKi3h0JrShedLHcchRSCnWKopj
	 Dhzq5uvjbpNumrLCsPRA/Lq9I4YIR3YwJiyure7+6tqZDlGKP8I4bHS1StLC0TgakUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=kiddier.org;
	spf=pass smtp.mailfrom=kiddier.org;
	dkim=pass header.d=kiddier.org header.i=@kiddier.org header.a=rsa-sha256 header.s=google header.b=Kg2eU5L1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767B606A31E
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4767B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiddier.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kiddier.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kiddier.org header.i=@kiddier.org header.a=rsa-sha256 header.s=google header.b=Kg2eU5L1
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso129263e0c.1
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 04:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792495983; cv=none;
        d=google.com; s=arc-20260327;
        b=dsmgS1F/MT8Zg3Nzb29jsgEdybo6Y+yzYTGy7CDi791frQtE+5k1CdZcmIawlKhoUN
         U0Qbvq9V+epGtlO1aIbzOp379QGG/nnFL4i4sLRPwE2SUte5gNpsU6kdIjIIaiYbxPFK
         zCKQXIaZV0Y4zIE1p+l0On8Ic6HrOcuhCvBmi44NlCNJgeqp8BV9FFfgE9Y+p1OzeHvS
         +ZlvH4Z9GEHM/Xh8002gQcAVQOpgM20lYr6XCjPKJ5wsdHzl0NQAY4b/+ynzHy7XUWOn
         J/zNrU4/BzTtK2HTOqr06Pmbixcx+LK3rnaDejqe6or5Fof4+X3UnJeBYSecgL1wEggv
         Qhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6w7JRuFovvwwUBTh/FtHv2xuiuhqO2jha1lfwIcoggA=;
        fh=FVosQ+n8LmKo45faEkMcQhDT5I8ISa8o/FujY/OMFIE=;
        b=sGJeIXNbYVoORsAo/WofCZACQ0vF+frrpiXL2Y2JrMNc0jDXcISLobBUdfljAaqNCu
         lBBIeddlmZyHONAEfFhyVVn6x4A7krXaIgwbEagUc95FFXNihOW/1gyM2+td+gk8SJKb
         T+zWg6idehH3AzvD5PwqGLt82t57cr+wzaK/DdmVFr4h/HfcBrisZv/Rn6gvLLp4WeIK
         ECOQu8ubtYJ/dn/DD77Sc8oDDAoo/Q71DpK0ewW52tcAn/AXHtrGVGWwWdhrxFTmKvf4
         Dc3zZcZflpwmzxu8sTUgGCCFQLTzbLjpJZLrIP2Jt4/p6u+DrCSXGEpDvN/6SlZVOAjq
         0gUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kiddier.org; s=google; t=1792495983; x=1793100783; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6w7JRuFovvwwUBTh/FtHv2xuiuhqO2jha1lfwIcoggA=;
        b=Kg2eU5L1ZH1/rhyBK1HBZXlrJ3dThch+WIhyXGs/eDNfqSCXg4Cpdw861WyMrsHEqQ
         RGhnrBOp/up7ePk56uyKQPyWbzpmvQ4vQZTWE62gmhZtDm3vu8wn2nObjH1KBy6lOYiq
         hxrx1yEV5BQthb7uNJHUwRBSEMZT+k4K6mork=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792495983; x=1793100783;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6w7JRuFovvwwUBTh/FtHv2xuiuhqO2jha1lfwIcoggA=;
        b=OMchmbFJIe8ByyBS8vxRJOL+dTmlZnTE03VXazfiWbvDjqE2ZLyagi7eJkjgoW7xIg
         1f9oi0WOC8RDULhoSqt6frYQyt27Z1GINlU/m2fgwnNaFFSKHuScHrN8/QS1aOkD+wK4
         DdGkL916NiyG4HY2aODKAnz5nbNDxTDZ4yakuLSA8CJXwfoCWAxUSWt4nrAHvIwvGEiP
         086Pu/6+Bkz81EhEHBCq1suTxL2Z1Rns4e8DEx3rvioy+HefQ0jvCaRN8Qft0/mbTUDG
         eWZXl4KHtjYxP0Phu8WW4v3aXop0Ifb5GKJphbrxBNoXfc5cu1VL6jdCj7K2N6Vv+1TN
         oQrg==
X-Forwarded-Encrypted: i=1; AKwUvBzPelHnMnSuR32528EN4dLL41Jq+aMds8DjlGNdL9zKXPTGrvgV6oDbYJErcysyep/84sL+CQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJQ7y+hzNvQ98T81mTBS632vDKazbr6TtiDNwP4MKV2Ayu2H28+
	r6f7ETlPaXUxi1fHu/Mzz1psFJnS5HlL/Ie6VKOOO1V5HL53qjcwOnKmo+jy8Y1GFweeE3hUWzZ
	vjkBMdP3s7iw1N96Y27B9UdjpIfKXVmXIkGH4Bt/ISA==
X-Gm-Gg: AYBFou1nWQprwGVIH6GDcBgqYtDunxypMbwIe2eTAgDO07VKUYLSXGPYGphlzaECHzN
	WTn8W267LMVqeVy+IrkSYJHIF2+Auuu7TZsYv3B0BqVLUGR9Id6ZWKCNZCPQ9OuBrS/MrKpnbfR
	FlYpJUJdjlZSZsVuABQJR+6MopQDiJuKDnkM4lJ1t47eGJx4oV1bi+OzUHRnSsYeDLCrhJBeRIv
	qybCHSdOwtHodbvkc9DbwjQ842nIumXCQAiWkZAeJHUE3c0qIwMKHjdFZ2nM0k6kBUb94TYVtZ+
	PbL9A+UiuIjLjU7ihLSYlvHHf21qwZz3tXI6KsnQ+6UykSa8nZJliYnI8g==
X-Received: by 2002:a05:6122:4307:b0:5e9:7458:9bb2 with SMTP id
 71dfb90a1353d-5eaaa392b1emr2875328e0c.5.1792495982934; Tue, 20 Oct 2026
 04:33:02 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Peter Kiddier <peter@kiddier.org>
Date: Tue, 20 Oct 2026 22:32:51 +1100
X-Gm-Features: AclHuK_5AI531dlJobOpneIUNwUkuWTyVSnUQajyWhdToxWSB6hT9Bldv5uGkoQ
Message-ID: <CA+3E589O46nj=c1Y+Rwk_nPZZKEUjFvMfWaAFmQ2-7De9iUxFw@mail.gmail.com>
Subject: [REGRESSION] BCM4355 Wi-Fi fails with Intel IOMMU on 7.3.0-2-t2-noble
To: linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, iommu@lists.linux.dev, 
	arend.vanspriel@broadcom.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a Wi-Fi regression on a 2018 Apple MacBook Air with a
T2 chip, running Linux Mint Zena based on Ubuntu 24.04.

The Broadcom BCM4355 Wi-Fi device works with kernel 7.2.11-3-t2-noble
but fails with 7.3.0-2-t2-noble. Disabling the Intel IOMMU using
intel_iommu=off restores Wi-Fi on 7.3.0-2.

Hardware:
- Apple MacBook Air 2018 (MacBookAir8,1)
- Wi-Fi: Broadcom BCM4355 802.11ac Wireless LAN SoC
- PCI ID: 14e4:43dc (subsystem 106b:0843)
- Driver: brcmfmac
- Interface: wlp2s0

Test results:

- 7.2.11-3-t2-noble, default kernel command line: Wi-Fi works.
- 7.3.0-2-t2-noble, default kernel command line: Wi-Fi fails.
- 7.3.0-2-t2-noble with intel_iommu=off: Wi-Fi works.
- Reloading brcmfmac on the failing configuration does not restore Wi-Fi.

On the failing 7.3.0-2 boot, the driver detects the device, loads its
firmware and creates wlp2s0:

brcmfmac 0000:02:00.0: enabling device (0000 -> 0002)
brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4355c1-pcie for
chip BCM4355/12
brcmfmac: brcmf_c_process_txcap_blob: TxCap blob found, loading
brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4355/12 wl0: Jul  8 2023
17:49:51 version 9.30.503.0.32.5.87 FWID 01-e74b9cb0
brcmfmac 0000:02:00.0 wlp2s0: renamed from wlan0

However, Wi-Fi subsequently stops responding. The kernel log reports
errors including:

brcmf_msgbuf_query_dcmd: Timeout on response for query command
brcmf_cfg80211_scan: scan error (-5)
brcmf_run_escan: error (-5)
brcmf_msgbuf_tx_ioctl: Failed to reserve space in commonring
brcmf_cfg80211_get_channel: chanspec failed (-5)

There is also an error creating the P2P interface:

brcmf_cfg80211_add_iface: add iface p2p-dev-wlp2s0 type 10 failed: err=-52

I tried reloading the driver using:

sudo modprobe -r brcmfmac_wcc
sudo modprobe -r brcmfmac
sudo modprobe brcmfmac

The driver and firmware loaded again, but Wi-Fi remained unusable.

The firmware files are present under /lib/firmware/brcm/, and the
firmware version reported by the driver is the same on the working and
failing kernels.

The brcmfmac module metadata differs between the kernels:

Working kernel 7.2.11-3-t2-noble:
srcversion: 3B6176FDB720DDE8E7C596B

Failing kernel 7.3.0-2-t2-noble:
srcversion: 3DCA38D52402541701276CF

I did not find obvious PCIe AER or fatal errors in the failing boot's
kernel log.

It has been suggested testing intel_iommu=off after reloading
brcmfmac. The driver reload did not help, but booting with
intel_iommu=off restored Wi-Fi.

This strongly suggests an interaction between Intel IOMMU handling and
the BCM4355/brcmfmac driver in the 7.3.0-2-t2-noble kernel.

I have not tested a vanilla upstream kernel, so I cannot yet confirm
whether this reproduces outside the T2 kernel packages. Unfortunately,
I have limited time available for further testing, so I may not be
able to investigate additional requests promptly. I wanted to report
the reproducible behaviour and the intel_iommu=off workaround in case
it helps identify the regression.

Could you advise on further diagnostics, or whether this should be
investigated as an IOMMU or brcmfmac regression?

Thank you.
