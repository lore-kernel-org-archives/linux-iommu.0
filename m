Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792496991;
	b=jSGAHqLWaUClo4eHEgPsAMvfVOByuOD3Al/Nt5CnbZR/PPnNpu87tMsAq4jLirTdqfn7
	 xlcgRRy4rWALJSosNY25Q5vPT8wzepsgy9466EeVE1PDpyg3E0q8C5MCC5Q1209wACeHx
	 KeRgmGZZZWLysyNd9g2+Wi69Fq+XKzijkUcDzOwwZxKsxHqJB0TYGTS/f2J+qg2hV72sy
	 2VIRlsh1jFAesdyY+Az+RA5Wlxw7eGHpfOzWIPLSVtahiy7l9WnP/CvNTZVBOmFKjrb8q
	 5dWoptsdccA602hcvFJrL0fZnS9py/9aJqVIEu6d+UnTD2M420wMtOJwwGLmO+2CEaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XLGNYitZ4EdMcotU/GOI9I5PtjbgIsDlPVNeP1wv+jI=;
	b=gEl1KGkpiRXTGoxDzDyvH+xfKb0qaP3nDDFp6tDrhmj9l5SkiVt29l5bCvEOzf8L/Qeq
	 48Rt5Q4ZsiIwm6fQxqc6VN9NMy0/6L4HIb1+oBTDi0/S8e5smWUOr3Q6775IWm7RNSzbI
	 NSgiWp2YMdU37QGcZN6FS9kOIvXSWMEu7/9Gaibd+aTgwlB09mQXB2lOJe33iXDYJ+OF0
	 Ou4nA7u0LOrBb5fHYor3+Grh2fam1bx4PzG+iYwRs43ah93wm9fBTt/kEzwWissystUk8
	 lGHh7uB4eRO3eoCmHwFXHp9/viShPuSbdcYpzSqYvrDbi2FfTlh8BZUq2zwpMzEOe/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=kiddier.org;
	spf=pass smtp.mailfrom=kiddier.org;
	dkim=pass header.d=kiddier.org header.i=@kiddier.org header.a=rsa-sha256 header.s=google header.b="P/U5Q2Qu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9B606A322
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F9B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kiddier.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kiddier.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kiddier.org header.i=@kiddier.org header.a=rsa-sha256 header.s=google header.b=P/U5Q2Qu
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac01ff101so769065e0c.2
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 04:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792496985; cv=none;
        d=google.com; s=arc-20260327;
        b=cmHbgXIqIs7J/Tq9YF3oC7T1Zhs7j/4MNA3qUSFmnDJdgsW+komkREs5qOJHSGU51g
         IKLdH0IVXhdFMy1kRdGLFqatvrl45d0LAVdNjKYR8wwWrerZBR0gFLEbdorcQjCPPIPE
         5BhKhTgvFE282qJyPkBQ4WBlNhb9fB6TwP2LGszK6T2tGuICd9I+mi+fFl0Y4OitkV5E
         8q20yhRRnStsWLviVLlgmKW2NGwb/S/JO+lz+BFYbbzjBi9BYInBl9jE2fSbkYeaF6U1
         AhZ6ZhO6+M6azqxPthP7E0Q6MCFquv084nlvuEuXY64Ixzx4DjAwEHNKf5s5w/4Mz+97
         seHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XLGNYitZ4EdMcotU/GOI9I5PtjbgIsDlPVNeP1wv+jI=;
        fh=++JMihj8UnVKO8rXczTc7S6pn5cX56ZjQNJ5WhwW0Fk=;
        b=UlVe4ualpVjxRrBiOGuTaJihrYJxv6uddnClu4ryG9Dio8BanOwqoTBorIvf5M7Q6I
         7VZqtFjE2P0TN9JV2E/WceD/d8U2ZGtWMu4CchGg+QZrIu5kYQbrSJn4CH8Lnkk8eb4i
         XsnQ/D7X/T4YcS7VP/A4gXLxSHhNwL9Gs6KkiIV7lnmW/4tMyX+SO7ActLZYV3o6FlM/
         2r3Pcx+eP9iWrbKnmysJ+hnZexGNs4vP3Gpf6BW0r3kfHbcP/+adDjaLLP5hpLGNPTVQ
         EVkESAp/myqyZAnyDHpZBRGvgY8xQE5CbVVzhlc7gMvDHesL9RPEvL9yQ9JuFdbdWwHB
         4SFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kiddier.org; s=google; t=1792496985; x=1793101785; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLGNYitZ4EdMcotU/GOI9I5PtjbgIsDlPVNeP1wv+jI=;
        b=P/U5Q2QuVUDd1Un3eSLXVWoANCWilmXwgEvWrdteXJQ4Enf+zVwpFY07RNGUDSi06m
         jawhPcM4C42kA9OMWqcDmvDXyFz0fwg+F6Of3MGTrUVPUUk2mDfr7lxya5qm2z++Qeim
         WfVrm1bvVSx21f1MV+3FNvZaNLy8sgnYJRWKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792496985; x=1793101785;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XLGNYitZ4EdMcotU/GOI9I5PtjbgIsDlPVNeP1wv+jI=;
        b=JqfoXcuWGTdoTOvCTAZpsUZ8Itq4DcRCVH09N68sIUIiT4a1gBZWhlaX3f4+pI81qJ
         jLDAtaUg4Mex98DzIKDNcejTraMtMkZTLdK+SH9F+dIrZ8LY46QfBfmMt7srHVLdUdca
         kzE7wg1t6JVWoftW4AG47tC9tmy2oRJchELFLPiGsntpD1xDMgS3IfE7YN+KPstrae7t
         q+KozFKgbQWIP+KmEFziMdzeltetOa+lxvS+/6bw5x5NEhapnRvAbjVUqTJBsOFqofeE
         XRglp3KoWTlU2MaR28gJpAHYZYg/+wAl0nmib24V1geMZy2QcVKoLkYltpErrVoYxMrt
         Y0EQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWbW57QVN7RWqAcZmDf9aHuqa4EWpwUc/6z29tIEOEy+0dJGlsg9NSHj5wZwtK2sGcmyWQpQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLC/ZuU/0G0HkE82/xSxadrTm0fun/TXundtE/J91ng1mWXzzTa
	2lsrG7iscp+r3pzmUMYIHMeL9F8jFuNGTQz1xf7erhzXg6Zqg6xfvlfNm/n1jqlQUzbNw9Dkzav
	0Bcj7lZ2wKOy2njkr7SryhRCCvYb/9fYIPeV54HFVyA==
X-Gm-Gg: AYBFou2WB1NWd6AKMznwDxCcB+pglcLNysZC2uWj9Hp7/OqF9DmREljdKF5EEHTJKeE
	Gq+BjoAVx1clPocY1t0D9X6LIA8ibvz+Qrl8nWjNp2+9znSh0aCUin//wLbQqPEdavlrGGx8tp1
	9rm+oLw2YKxdoj9Ocn+NZFitbzsZR4b9ApD1T4Y+9YS/PNEbb1rmNzT8guJoDrz0b1n5YsOSxY6
	KIAuHzPhJVS0REKitO3tKf6raTupDjZbzi4/GqpltcefDlpdUsfoo+zCWvVjfJZfd1uXIYOmNay
	ap5iB+RFc56GGvE+vsEC3uKJFd+cpRR4dUM9ud7MNtkcTfuZYJLnQeohUg==
X-Received: by 2002:a05:6122:8c1:b0:5da:9b81:1aa4 with SMTP id
 71dfb90a1353d-5eaaa3c174cmr3451932e0c.5.1792496984909; Tue, 20 Oct 2026
 04:49:44 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CA+3E589O46nj=c1Y+Rwk_nPZZKEUjFvMfWaAFmQ2-7De9iUxFw@mail.gmail.com>
In-Reply-To: <CA+3E589O46nj=c1Y+Rwk_nPZZKEUjFvMfWaAFmQ2-7De9iUxFw@mail.gmail.com>
From: Peter Kiddier <peter@kiddier.org>
Date: Tue, 20 Oct 2026 22:49:33 +1100
X-Gm-Features: AclHuK_KgzridKLRANvtLJkSHaLWJWHnmxsRRdoNj6COaR_e09DKIcJwjLUSHC0
Message-ID: <CA+3E58-2N-uVNsmwvOGDKZvtnDQ1DF=GzFbTyRLuN8FpAd4qdg@mail.gmail.com>
Subject: [REGRESSION] BCM4355 Wi-Fi fails with Intel IOMMU on 7.3.0-2-t2-noble
To: linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, iommu@lists.linux.dev, 
	arend.vanspriel@broadcom.com, regressions@lists.linux.dev, jgg@nvidia.com, 
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding the IOMMU maintainers and linux-kernel.

The original report and test results are below for context.

I haven't tested a vanilla upstream kernel, and may have limited time
for further testing, but wanted to share the findings in case they're
useful.

Thank you.


On Tue, 20 Oct 2026 at 22:32, Peter Kiddier <peter@kiddier.org> wrote:
>
> Hello,
>
> I am reporting a Wi-Fi regression on a 2018 Apple MacBook Air with a
> T2 chip, running Linux Mint Zena based on Ubuntu 24.04.
>
> The Broadcom BCM4355 Wi-Fi device works with kernel 7.2.11-3-t2-noble
> but fails with 7.3.0-2-t2-noble. Disabling the Intel IOMMU using
> intel_iommu=off restores Wi-Fi on 7.3.0-2.
>
> Hardware:
> - Apple MacBook Air 2018 (MacBookAir8,1)
> - Wi-Fi: Broadcom BCM4355 802.11ac Wireless LAN SoC
> - PCI ID: 14e4:43dc (subsystem 106b:0843)
> - Driver: brcmfmac
> - Interface: wlp2s0
>
> Test results:
>
> - 7.2.11-3-t2-noble, default kernel command line: Wi-Fi works.
> - 7.3.0-2-t2-noble, default kernel command line: Wi-Fi fails.
> - 7.3.0-2-t2-noble with intel_iommu=off: Wi-Fi works.
> - Reloading brcmfmac on the failing configuration does not restore Wi-Fi.
>
> On the failing 7.3.0-2 boot, the driver detects the device, loads its
> firmware and creates wlp2s0:
>
> brcmfmac 0000:02:00.0: enabling device (0000 -> 0002)
> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4355c1-pcie for
> chip BCM4355/12
> brcmfmac: brcmf_c_process_txcap_blob: TxCap blob found, loading
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4355/12 wl0: Jul  8 2023
> 17:49:51 version 9.30.503.0.32.5.87 FWID 01-e74b9cb0
> brcmfmac 0000:02:00.0 wlp2s0: renamed from wlan0
>
> However, Wi-Fi subsequently stops responding. The kernel log reports
> errors including:
>
> brcmf_msgbuf_query_dcmd: Timeout on response for query command
> brcmf_cfg80211_scan: scan error (-5)
> brcmf_run_escan: error (-5)
> brcmf_msgbuf_tx_ioctl: Failed to reserve space in commonring
> brcmf_cfg80211_get_channel: chanspec failed (-5)
>
> There is also an error creating the P2P interface:
>
> brcmf_cfg80211_add_iface: add iface p2p-dev-wlp2s0 type 10 failed: err=-52
>
> I tried reloading the driver using:
>
> sudo modprobe -r brcmfmac_wcc
> sudo modprobe -r brcmfmac
> sudo modprobe brcmfmac
>
> The driver and firmware loaded again, but Wi-Fi remained unusable.
>
> The firmware files are present under /lib/firmware/brcm/, and the
> firmware version reported by the driver is the same on the working and
> failing kernels.
>
> The brcmfmac module metadata differs between the kernels:
>
> Working kernel 7.2.11-3-t2-noble:
> srcversion: 3B6176FDB720DDE8E7C596B
>
> Failing kernel 7.3.0-2-t2-noble:
> srcversion: 3DCA38D52402541701276CF
>
> I did not find obvious PCIe AER or fatal errors in the failing boot's
> kernel log.
>
> It has been suggested testing intel_iommu=off after reloading
> brcmfmac. The driver reload did not help, but booting with
> intel_iommu=off restored Wi-Fi.
>
> This strongly suggests an interaction between Intel IOMMU handling and
> the BCM4355/brcmfmac driver in the 7.3.0-2-t2-noble kernel.
>
> I have not tested a vanilla upstream kernel, so I cannot yet confirm
> whether this reproduces outside the T2 kernel packages. Unfortunately,
> I have limited time available for further testing, so I may not be
> able to investigate additional requests promptly. I wanted to report
> the reproducible behaviour and the intel_iommu=off workaround in case
> it helps identify the regression.
>
> Could you advise on further diagnostics, or whether this should be
> investigated as an IOMMU or brcmfmac regression?
>
> Thank you.
