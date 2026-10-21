Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603717;
	b=EUeDMd4suoe3Ls4Yon6085Svnq5wIOaKvZDryPUACc/TCH4X1g9/rf+c0+R7eo8vD23e
	 3cnz6qlJ5/+VEfyYIVIrmhmwZApG2wSvEV+C3RAxkohMckCVPvrfyQRMquGpcFm3E3wbK
	 5zA76w51KeYmL7y1zlYSsrxsif1xrVK4Bp92cB+uBLvGD0bnhrhQSeMrSLeP17RAvDlkh
	 o/fD7kPaHYO/lVbOAKUdDutecQKSpIYFFugH6f8L8MQKB/dxKFi83mYfPdrKU/LExWj+5
	 yLN5Rxj2xTIlgz8gQ0GmXw3v5EO0sxAoySVFOJs3Fw00SF5RsKJIrLhd0M8qBvOp7cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603717;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:CC:Date:
	 Message-ID:In-Reply-To:References:User-Agent:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=yBW5lI4RGoshpEvuEkqFomfPwP4gRy6G1sr7L5RUhY4=;
	b=4mtUObyLEWy686HXpsrjrPaAkaeNE3rzesvHYOeCcWMAy0RtqZ0sW8TZgrDpQyZEeCMV
	 OTss48WIUUdUEQChF1NlrusjZskntaVLJG/rkt3jzKru/Mktzptr2d5tYpcJvFLu2jepk
	 VYjLkKnhQ8RSuvL1/aG7qqu+s5xWMTrG6EQkdKe8mCZLJ5CFYjOWD2e71nhGkG8VNbr5v
	 ZwGFeRGsTkfzisSj7El1iOzsJ6e+x9L9m8dKKizUVPZ7JplOChaLYpBTYseiL9Etheweb
	 Ivftc4ClwrotXzyeQcnl4QiCy3MqUcabs6vCxJxU6fCtp1K1ZuEEz3FuDr6tnElaHKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=eIACM2lM;
	arc=none smtp.remote-ip=209.85.219.97
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7660A380B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B7660A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=eIACM2lM
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-91b8306b9f8so15103456d6.3
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792603716; x=1793208516;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBW5lI4RGoshpEvuEkqFomfPwP4gRy6G1sr7L5RUhY4=;
        b=YP8o9PXNT/bDBjBOtAOq45NpgbCnIxoelcadH931sfdq/f+OzL8uzgMZ4qs8s0BAst
         nqnJmyt34jTnMBD4GFbWthcOdYQ7q0AabgipQHgNQ2AKNJpS2mU/xISwmCBlwD1/FGIt
         pw5bVK0HCAiGWc5jBUymJKkqvpDPCxX9PnXMr5b62qqGdB+gDkq85/bMxiN95W8DPsK8
         FGSvMVv212PDSml+iOPl915T5Nc0lkMlmaoa+qTkSMTmvnXWq7D3dR1sl58ePEjJccrp
         yMfT/IbljnCICG+ir3wKx6heELMXlpfq/ufDRIVewabGBoVlxIncGOzUqQ0/YzNKHKLq
         HFlQ==
X-Gm-Message-State: AFq9FYK+zB3Kc7od3L/7M62wEvNa8enUx5OdJISkUpmHr1SOXIjJzCGy
	J++lWquhwKJ/ZhmPO0cx0ndZa884BforkE5wg0douNQlWTQDjn5yuEkKuWTUa7rDM9uW+vHsZc6
	uu3nahJdT+VHz11rWEfCBQdFsoaSkf/4xaMNpE7pAgxerYaVIY3gF+V2miXfJE0XOwEMEdL44mX
	PM/XiKFe394TYzrGo5lnmh7eSy52CzjDG6cVOKdRiw2B/ER5QPVWU7hICGR8SHZkqWQKK8yJrLu
	1CGxtN+DvOsKU4R
X-Gm-Gg: AYBFou1aYuS+x1V7jK5+VFR4Hd4PiLy4esCTpbpWdJTEcHAV7KcjMZdnXUvsrEE+vei
	sM6wqLxpDKUE2R3OvStRCIVUfMCQiPfqDetCrDwjGVLpQDPmDglvEvQjWW3agFuqlM0TTsYY6OF
	lgxlG4ultrpKqskYY0cQL4gLW/8+C61DrcWyuK6UYPvtw/Hlef7+HKboWA7kF5fi88D0TXasBdT
	fLSamC8w596wI7kui3wHudthD8ayWAPWz9CH84nOO7WuHCJinPWsOT1N3WdLa0WudFeLFegjDsR
	rSusS0mTOyjdFTFZWWQRurHnQLA7SuPlmQabfpeYSCV0Tg8DFyWmr4VFI6P1ej91dBxch5m5fzx
	qk6l4ZzdafyOe542AVF27JADtSYle8xzv2Y4h9XyOB5umArXE6YqATYvX9hOsfb2e6hJyotclMv
	/+vwgQs/UawfmVd3gHLYZ/wxwLETagMgt6MdnW5XSnRg==
X-Received: by 2002:a05:6214:407:b0:914:7df6:ca80 with SMTP id 6a1803df08f44-91c12ec72c5mr51292456d6.20.1792603715725;
        Wed, 21 Oct 2026 10:28:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91c10bdf284sm386866d6.28.2026.10.21.10.28.35
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:28:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c046843f1so29708246d6.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792603715; x=1793208515; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBW5lI4RGoshpEvuEkqFomfPwP4gRy6G1sr7L5RUhY4=;
        b=eIACM2lMfAiXIgmMJbW9wOcSwYIEjr+IdRvoM+T3G1c9XIHi0MHutVfvvhaMRMN202
         vGM12neaqLSpngtlqWDIw2GXi5lcG25Grf7ZudUbYu3Hc1AHa7f3k0REz3j9LkrkhvlQ
         GswFgSaEVCXJmmfgYabYUFjp0ris03qlSrRZc=
X-Received: by 2002:ad4:5aad:0:b0:91b:8b10:ce01 with SMTP id 6a1803df08f44-91c12f031b0mr45327926d6.35.1792603714988;
        Wed, 21 Oct 2026 10:28:34 -0700 (PDT)
X-Received: by 2002:ad4:5aad:0:b0:91b:8b10:ce01 with SMTP id 6a1803df08f44-91c12f031b0mr45327506d6.35.1792603714445;
        Wed, 21 Oct 2026 10:28:34 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c5002bsm29465846d6.42.2026.10.21.10.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:28:34 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Perlow <jperlow@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>, <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
Date: Wed, 21 Oct 2026 19:28:31 +0200
Message-ID: <1a15f81e618.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20F90036-F53C-4490-B27A-DFD055DB22E8@gmail.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com>
 <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com>
 <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
 <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
 <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
 <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20F90036-F53C-4490-B27A-DFD055DB22E8@gmail.com>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: intel-iommu: DMAR PTE Read fault crash-loops a PCIe wifi device, v7.3-rc7 -> v7.3 final regression, reproduces on one unit out of five tested
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

Op 21 oktober 2026 19:04:11 schreef Jason Perlow <jperlow@gmail.com>:

>>
>> I would prefer the above in proper patch, but it's up to Johannes.
>>
>> Regards,
>> Arend
> Patch below.

I don't think patchwork will pick it up like this. At least I didn't see it 
there.

Can you send it as a self contained patch. That would be great.

Regards,
Arend

> -- >8 --
> Subject: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional
>
> Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
> packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE. The
> BCM4364 firmware also reads posted RX buffers, so with VT-d
> translation enabled every such read faults ("PTE Read access is not
> set") and the firmware crashes and resets in a loop.
>
> ...



