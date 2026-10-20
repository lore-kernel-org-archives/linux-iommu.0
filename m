Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516253;
	b=wMD8HJk0ZS9D4NO8KrZDzpj+bv3p3cJTSBhaaVNopFF+luMEnCbWoep4Jy0PKJYKZLEE
	 dCue4vvh7DjgiaXQNfcj4hGjCoSnTWZlUCkKokAbvK1dC9+i+NCGHWeZPhF2+MhsI8rYE
	 NXXr2f2ieZCwIKnhkLuuWMksll5I7qASCKoxyRusFd3vb0Feef3w2RyNVtZBmTP/w4b0V
	 rI0GAaPYqe3aEmZG8mjEkF2w1bTKaOwIZNtXBzvn6Zf/saAoLrojVlWPDlYgPYQyEaj/w
	 gBT9XoYJar76wbpIW72kbdPtK4CazP4CaU/Y9mQ3zscAKQt4J9GBId/TkyzBD7f35/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516253;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:CC:Date:
	 Message-ID:In-Reply-To:References:User-Agent:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=VJqkIiPNVDYg99+7WtjqOTUKFy/SQG4E1Zt5xkilM1s=;
	b=3DSZz5HVnS7p8y3UxLsmkMIgfRIn7xtmOyoZQ6j/Tusy1uCodrMMIo3JqXhAdXaVKCE8
	 n9vMdMDXQsqw/G44tKSUNEv28Bxs4hg/V0eA18meWt9BKTcelz/DZoM/M3AB+cFTf9nbS
	 TefhWKbSJ2QuDSeQHrZWBtwMinjR91OC3zfIoPcReD9Be5P74IhmXIwH9nifw6sxGvoMJ
	 VrrJZWt848M9QhUpBxBdjG1xw8amq3Hqe9sDp3YsaNezNa9/kFLMxVYfq+dtumje0B1S7
	 +qo2zC5PEGVfKzayRP38z79F5Z8827eiemF0mFTEFzT/4ENKdIbHuweNHl6+SAV1pwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CMX8YgaV;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9E606A31C
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 17:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CMX8YgaV
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so1759565a12.1
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 10:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516252; x=1793121052;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJqkIiPNVDYg99+7WtjqOTUKFy/SQG4E1Zt5xkilM1s=;
        b=pJUl0aBHnx9HB6ON41I9xlaj/qJn0GrA9OfpJQou/Pe/WA+OefN572JYukn9x4mIEO
         lOeH1dhFKkcd/roEN1aQEBCv3ikGmWxLYiGMD09CHiHWwfXV32LBnhbiD5gUrR+tzh/W
         lb/htlk1g4flTZKGepU3Xq8pxTKOiJo8U7gyhTYs/NCHGd8VjGqvPptyUdh5ua2lekdH
         rk8xGc28XjbcsoneGzxt2FJixGY0EjXWsO7gdeLxXxBO6FRmTiEI1UOpyJvEkNRlfpNx
         iysvh5tX70EkUdX2whzDqVh8Gfei8+MyZgmAv+H7ho/AkROF0od7f+oyimSjK48JTT1K
         ypsQ==
X-Gm-Message-State: AFq9FYI5TVrwaUeg1Pu6qc8+9fA6+QKHIURJ/mUKBemtxeVo6dmsavLI
	uslZZuNXL6RMy2tIJem6mc3/loJhAlnn5Qv150En6na01pGYFjinyZdAqWe5ohp2D6RdcZJWkjt
	/u1JGuwLvO2RL7nxzuUEbNNuZVnUmcrF4s4KrUhfdRpXAu2sMnZMOWP+IBXr2cVw2jQ3nWalXat
	D0sjxGS63Mhl87oZ8EwSiqDQ2E5VfwP6b/C/eCp6UtkECXDXznO+V3ellBPRX/VVGewCzVlKwW9
	rHH8GrXMM3sYArE
X-Gm-Gg: AYBFou2P/TneQ05shfvS4wjOoCMX2l90BG/Prhl8uLWbOxRqHN5kucxA3UHBj+nWMIY
	JWfLbKTeXv9NTMQ1X8DIdW7qRbv3Wd7lZYfh0RWTN4lNmRgRA5FzMDVoJRBXswEMqDI+H0HBLbd
	tuj84V5iJi/riO8533Bta+iizRv/rCHEt87bYVNCBGpJ7hWwHsvuA3eA+pXfv47eqiozJww8ukI
	V/3w9MMYcvC1JA+5sJ+b4BIPO417TdJeNQrRfkQIc+CTBXvK/jZldaq8xNG1RY6tCU2MI3Z/ZzB
	hsAVZm5QCLRyPXsb7PKpNfmccDaVfidf38GA6RNuxb+/52sJ16C5O3tqkLxjF6xnIuarL9sqWJf
	Nja+0Xsd/MRh0ZwGHYEejrqCMPhS1Y5kCIJ6kOPgw4GJSwfR+7Nup6topxY7usUABXC+hYR3+d9
	5tDd99fzeO+K5OxSPIrECIAo7QZFldEzzeBW8Kl3RMkQ==
X-Received: by 2002:a17:90b:562b:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3aceefbfd37mr8354517a91.20.1792516252236;
        Tue, 20 Oct 2026 10:10:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad8301b0b8sm34215a91.3.2026.10.20.10.10.51
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:10:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91bebff9fcaso97683136d6.2
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792516251; x=1793121051; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJqkIiPNVDYg99+7WtjqOTUKFy/SQG4E1Zt5xkilM1s=;
        b=CMX8YgaVyyqQd6oTyvXdlr+DJTmDOzFZT7p2zGJQMqYydBTZj6GwuVsMtW3tRrpDxY
         3peuDpNZioJIlQf6AKhXj1px0IThuUUpWCDe2I9mk5BfX+0AB38GpB7MB7B98dWF0WM9
         RV9/FDzlftfD4r3TqCF/YWYSX8vp1PCy0kcrA=
X-Received: by 2002:a05:6214:250d:b0:914:51b1:6161 with SMTP id 6a1803df08f44-91bdf0df624mr198193736d6.30.1792516250831;
        Tue, 20 Oct 2026 10:10:50 -0700 (PDT)
X-Received: by 2002:a05:6214:250d:b0:914:51b1:6161 with SMTP id 6a1803df08f44-91bdf0df624mr198193046d6.30.1792516250202;
        Tue, 20 Oct 2026 10:10:50 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c48c49sm2815656d6.41.2026.10.20.10.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 10:10:49 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Perlow <jperlow@gmail.com>, <aditya.garg@linux.dev>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>, <regressions@leemhuis.info>
Date: Tue, 20 Oct 2026 19:10:46 +0200
Message-ID: <1a15a4b49f0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <D0E6473C-3234-4367-83E7-B85C022B0F1A@gmail.com>
References: <D0E6473C-3234-4367-83E7-B85C022B0F1A@gmail.com>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [REGRESSION] intel-iommu/brcmfmac DMAR fault on Broadcom PCIe wifi, v7.3-rc7 -> v7.3 final -- candidate mechanism and proposed fix path
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 20 oktober 2026 18:02:30 schreef Jason Perlow <jperlow@gmail.com>:

> NOTE: an earlier report on this bug from us bounced off one of these lists 
> due to HTML/multipart formatting from the mail client used -- apologies, 
> switching clients. This mail includes the full original report plus a 
> follow-up, merged into one self-contained report since the original never 
> reached anyone.
>
> === ORIGINAL REPORT ===
>
> Hardware: Intel CoffeeLake-H platforms, various. The affected device is a 
> Broadcom BCM4364 802.11ac PCIe wifi adapter (14e4:4464) at 0000:05:00.0 on 
> an Apple MacBookPro16,1 (T2 Mac). Aditya, including you directly since this 
> is T2 hardware; copying iommu/pci/wireless because the fault signature and 
> the fact that it reproduces on only one of five tested machines (at the 
> time of the original report -- see follow-up below, that has since changed) 
> looked like it needed eyes on the core IOMMU/PCI path, not the driver.

[...]

> THE ONE ANOMALY WE CAN'T YET EXPLAIN
>
> Despite the last two items above being unchanged, the actual generated 
> .config has CONFIG_INTEL_IOMMU_DEFAULT_ON unset after make olddefconfig 
> against the rc7 source tree, but =y after the same process against the 
> final source tree, even though our template explicitly answers "# 
> CONFIG_INTEL_IOMMU_DEFAULT_ON is not set" in both cases. Our working theory 
> is that some other symbol started selecting/implying INTEL_IOMMU_DEFAULT_ON 
> between rc7 and final -- which would override an explicitly-seeded "not 
> set" answer during olddefconfig resolution -- but we have not identified 
> which one yet.

Simply run make menuconfig and it should be able to tell you how it is 
selected.

Regards,
Arend>


