Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605303;
	b=AEXiKvaTcHf7PM3oSoS0A6Za3p0gQNP2zTrNuuzbJO532CehrEwfhvf9NmiaRSF1CNTW
	 8W+33QO96aRvVYHKlvSeF001AMM40d3EN1MOu0/jmxd0J6Twl7cKjF6Ts0gnWe8vuD4dB
	 REaIDu40xoSLzRapXGDjLPPVCqe7QWgaO2IzthO/IV+2rV3cbhf6TTktfCoKQI+HdN8I4
	 EI8FI9duOBB7lnmonh0iUcrBDLClCkgItLMkFT+YOGJ+CORc/dFE1Ur22rZj7sEdK3fLb
	 7yECZqt5VsN+XsVoSBJIMQit52d1k5L09Z+fJC16KHlVj8AjvOF/lLylM3F39axo0gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605303;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:CC:Date:
	 Message-ID:In-Reply-To:References:User-Agent:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=gWh1QTQenprqzbn4sAjRMzDY/y3t0ccto3JdAdHhT4s=;
	b=mJCSyoqQ22sjKc5wcPar1J/mSGaPNhRbWM9fRkzJ6duFrCPOZPmHQ5tYjUQ/TZunyNYA
	 k9ZESpUST/FGTHdzCB/gSaPpA3wieelDTlCNgtGyE9s+5GTy1PdhS9QCx6MdCGgKCjwQm
	 0kLr2zr6lXA0/yU6xSZJc8J14hYsaE/wiErP7bSxy4FcBBYgUn99xbS+uFH+QmAZerflp
	 ZkFrn8GW8quyARUsxPyJHE7qqUT67oHRASJjP3cRMnAWjjKqtw2/q95RB0Lgm7eqdrLLz
	 cN5V+ZdfXhb/dn0DmilMaUOgHOj1CJlwF/iCjEyQ4vnQXEoWRFfSWcIXqJb5KyHR/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kkv4SXHE;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5408606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5408606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Kkv4SXHE
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e5378b281aso5299815ad.2
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605302; x=1793210102;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWh1QTQenprqzbn4sAjRMzDY/y3t0ccto3JdAdHhT4s=;
        b=2rsJA88ksYr/nDUYioyOSr6Mk4yl6m7EHMVbp3HTHWxFdih5PZ5PDv4CwLGNpkbnj5
         /snYaMbW8I3T4NBRd+W9OWnD1BRYAYN/VLOPgmKKMDwPrKLy70QGUQhDlqalCaNjV3Rr
         /4XdOJkoipw7G9F6G9e972yoYP2jRdaoPHmjR0n/Ivrngd4MJ+WSn48y8leHskchb9m9
         5H1en+NWzKXTaZFbnAv6z6U4xWt5yMLta1o/z9McvYG7mUerKrupv5Akc4fHaRoh+ucA
         6iCVwqtYtbjj3kY1tg3dccwku7YtvsysyiZzl7IrCQHZFQ/i2RYMsJW0bCNVpSFCxjRV
         eEUg==
X-Gm-Message-State: AFq9FYJTpvFPGGq/UnXES32C1llWPDntRIPPV1eaGq3Lcf2uVROhuoLM
	Ae4eYVbbd9tPje/0v/dttVCiDVFli5857YjsiOoRABpj4fNehc/4U4ZWttXyeqmDmUIWOBGf0mm
	JvDZmhfQvUz10zDJjjcGnEFycdx63YFGHdOD+c+cIfrybO2HsgToChUubFyfNrWSLO38BbypLv+
	Q7c1ljmDzmRBU/+KcDzxxUvHdYD0RZ0TaS9HTaGWOjJXCSjJA+QHI3HMsw43vTcCW3boef3ky7K
	B4QlPp0YOmoN790
X-Gm-Gg: AYBFou0+FZFgp+RSIXhCKulTFACYxfC5dQ6OStcZWv1S/OYEzo7ay2VwICI9P7sIBEn
	Za/b0Hd5zeQLVYu3E/9LQHnyCQYtyJi2yxyOXSohTiFLJSZK0T+8cyYDNLTNCIQXmOnj67E17yC
	qXHulpJQicpGs5iXMXS85I0VGYjSAMmYGnbApwPb6RnyCC0coU1Jle80ytuWugUe105t1nmC46V
	yuUfJ4S+Gwy7qZfB5dM2HZpwrni59DXDOetlZi5sgl/RJkKMrI7Ztdt7N5WLCs6Oqg4woNhu7Wb
	EjtKeWbcb/bTIlgt2RvgaKKPAiHiKaRJOsMKqwI3cLFPLwp0EbvNLABscSxKNOW6pHEvr0TqrW2
	ZkjY6s4gT96LV25LeVqv8J5GsO6Rkv4q2aNOusr/0OJjJLFUT+OOYjnVYj9cUj5Zgs71KKf7OQ9
	jwBis+dtqp4SaQp0ec2riYPzJ34oFycIgjxpPfMIWtrg==
X-Received: by 2002:a17:90b:582f:b0:39d:efa9:cd1a with SMTP id 98e67ed59e1d1-3ad86b0bc8amr2447173a91.4.1792605302392;
        Wed, 21 Oct 2026 10:55:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada47f5737sm247985a91.0.2026.10.21.10.55.00
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:55:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c46582442so641497f8f.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792605299; x=1793210099; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWh1QTQenprqzbn4sAjRMzDY/y3t0ccto3JdAdHhT4s=;
        b=Kkv4SXHEHZUzMmtFGwrOpHBfeHMZBdyfsMPYVg06Pr+MjBm9uOdeHcw9awEhM+1XWn
         kAoqiXJhY7RsFBUEBFRlw44TO/NIJieOQfvfX9XfCeu8SoObfkxPtwedFixu4JyPISSh
         TnRnKyi0NG/f8rIizssFQgf3R/pXndTnPl0qU=
X-Received: by 2002:adf:e009:0:20b0:48e:cd3:64ee with SMTP id ffacd0b85a97d-48e264ca114mr4341025f8f.18.1792605299428;
        Wed, 21 Oct 2026 10:54:59 -0700 (PDT)
X-Received: by 2002:adf:e009:0:20b0:48e:cd3:64ee with SMTP id ffacd0b85a97d-48e264ca114mr4340994f8f.18.1792605299030;
        Wed, 21 Oct 2026 10:54:59 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm6791359f8f.22.2026.10.21.10.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:54:58 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <aditya.garg@linux.dev>, Johannes Berg <johannes@sipsolutions.net>
CC: <iommu@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, Jason Perlow <jperlow@gmail.com>
Date: Wed, 21 Oct 2026 19:54:57 +0200
Message-ID: <1a15f9a1968.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20261021172238.10004-1-aditya.garg@linux.dev>
References: <20261021172238.10004-1-aditya.garg@linux.dev>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
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

Op 21 oktober 2026 19:23:05 schreef Aditya Garg <aditya.garg@linux.dev>:

> From: Jason Perlow <jperlow@gmail.com>
>
> Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
> packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
> BCM4364 firmware also reads posted RX buffers, so with VT-d
> translation enabled every such read faults ("PTE Read access is not
> set") and the firmware crashes and resets in a loop.
>
> Map the RX pool DMA_BIDIRECTIONAL again, as before that commit. TX
> keeps DMA_TO_DEVICE.
>
> Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet IDs")
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Jason Perlow <jperlow@gmail.com>
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)



