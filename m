Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600798;
	b=uJL5DO6ykkQxQxs4MpTF/AS+xGmxxz+IyBw51DvwnvZSZXXc6fuLu3tUXxx9BZhoC7Cf
	 KJAP5IsgcTN0pRDyZvYQIi3ZgONhJhb2Gix0lde1uTfAxw4Ffi4mJDN52Erl8G9ENY4gt
	 5tFE+qFPMe8XmiFWO97h6d+lVAg9Iq7HZsTKmv6aJQPSrmc5YIkJdAagT+5S1NNJyt5aG
	 JCP+qGXNtqPTfaUrlvHpezFAyBcC9JrHROGMcMOCipAICvq1pCAl+x7VfrIutyyXi6uMk
	 1JHnUsoBgZh9zqOpJGJ2BXWTD4N5/vhxVakK0YCWGjF/L6hC5OkDpi739k3UQU4dAow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600798;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:CC:Date:
	 Message-ID:In-Reply-To:References:User-Agent:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=8/LkuqpxItTOMcNoVAaFJJp8ILxgErWXgOG+sNgyAtk=;
	b=tllS8S8mwExVBdSu4oFPT+hTPmYBw9wy68qgZ7E0+Xl1HgJO8bQNNISpgOhEULrcBMfa
	 gcD1QEcKfM0TUAeb0noh2Fl6L9uAbE1iaSL55mhDrvZvs4Kyt9zl1/rZ7wZHT+BUaEygE
	 vMjY2e1UG7B4xFP7J9dYSXfTIu5tdegSi03vrpZcBP/vugCg0DVjxlwXwuzAGJ2+nsCgs
	 kosy2iK7T+zK4L7JcP9zBLfcP0qngVnnIxQw4ITtJJqzg2xrV8tNV9zUEHJRQqxLlh3Dz
	 p/x5YHWyHzlhFK8JEpFtc7ZGKgxM88gjVGDoa1E3KcNjkQ9ZpuOIaFWltvowPYI9gPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HIL4EcDM;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94568606A31D
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 16:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94568606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HIL4EcDM
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cd3310348d2so10702a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600797; x=1793205597;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8/LkuqpxItTOMcNoVAaFJJp8ILxgErWXgOG+sNgyAtk=;
        b=J0ufapG6GMLTeSOksoZlzRiB/NzSfitu/PdARIDpP8gtgor2quIYgfIxdi2IBXwh2Y
         D16StwxSU+fLoRzlYRV7+t0wRbdHSRDE6shqrD65tKXGd7bkVKgwxCZtLrKRgAMsspJK
         jsWUEgL4hcjr+2q5CpRu2z0vPEPHyB6M7Gv4RxBw/efBc54asRXkqmPGVbMOwQyRXz8S
         HfK6PiIETE3X6PZFRP4neuLeFWbsy/25hfWQ/ND7eh2ftLuqSNWZ8xfZ/bqE7wVZXCj4
         mzgmGZp+sjpMlJAbIXE8VML6F+9uT9M7T47fWABXy61LGXVDK8drulmkGyRtSyk5tbZt
         Ccsw==
X-Gm-Message-State: AFq9FYKz8V2d/JGNy14TvR13YaKdN7ul4Zl1KlmYk35p5MlU/q9qohFq
	9jSJPmGrV/hhdbqZf5OuKu6FruEW7DWCN/lyVrLUpsp0b9zdcuKjsPnmvt6iLaUSEM+pKeim2/A
	MA7z8L0oxDOVhI/2sXtS+pEzzTlCWhzLy262WXX6o1bWLWgH/ln+9OZbkFW6eDHZPOKaF8gOCTB
	2bo0/gao1ZlQNiDZYqXwGYxNSuHvZO1gOenmCA1zuKb2bqF0zCwYkJSFM3TtQAh+3zq/PAnRN1u
	3YW7h9c1knH9w==
X-Gm-Gg: AYBFou2f4aQhFs+gmCusFS9ebreaL5A5qcESRy0IfM8dvBKTR7RA9lK1F4PhRrQra1f
	mW7Q/8Qn/j1ygu5mWmOfwuWup7Fgy/3raRKX83zuAbSysGAeG2K2Jk6Kh1KQ9WjkeT9BNzxUh7l
	cwNUkCfsUwNIR53qxKMguhOZj9CZVLpzUyhi4dDB77IhMkFLJnufMquSwi/DI2n7yPrumd0CDRh
	8GkCPmOhOunh9iBrcV/d7py6RmZkXVb4ivA8astaew7Dz1qu7dSxHyGPGrxnnxq6XNY+dVmyp2K
	HoOR4kzsr3WChZmzm6AbQhdw+siHKeIyD5Ons2B8i7bXvlIOqUEY/LTgJnm+ag4dZDiZAILuzmM
	2QO2FQ5nopBxMZ1tsJASLWLFnr6M0J6j9wApoe2azPYCNdhOzQMDz7DEb953IuFrdQvskmi/mL1
	p2aoE0Y38dZiPEd/nfFg+eIhhV/k3Cnx3f+6eGQYnSEQ==
X-Received: by 2002:a17:90b:164c:b0:3a4:b509:88bd with SMTP id 98e67ed59e1d1-3ad86da4754mr1495137a91.2.1792600796782;
        Wed, 21 Oct 2026 09:39:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad8602f10asm946238a91.1.2026.10.21.09.39.56
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:39:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso5187585a.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792600795; x=1793205595; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8/LkuqpxItTOMcNoVAaFJJp8ILxgErWXgOG+sNgyAtk=;
        b=HIL4EcDMpYFL1E/xuHyke3fRo8SAwq/k/cecvHooCG90xeSdUcUfxdUsMSszhJHsex
         BBzM8itK0ERJNs2NZgdCIU3PXXW7ZavUYQxJWYIw/4LfO1KqKLmg9WuNUEbODfH//KTY
         UrONnoyn1rQDmN1B0BwaQ/eRWNB/Sx0LsnMhY=
X-Received: by 2002:a05:620a:1a0d:b0:93e:60b7:eb1c with SMTP id af79cd13be357-93f57f5ebd1mr479092785a.8.1792600795435;
        Wed, 21 Oct 2026 09:39:55 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0d:b0:93e:60b7:eb1c with SMTP id af79cd13be357-93f57f5ebd1mr479088985a.8.1792600794923;
        Wed, 21 Oct 2026 09:39:54 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56dd0022sm297747585a.20.2026.10.21.09.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:39:54 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Jason Perlow <jperlow@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>, <dwmw2@infradead.org>
CC: <iommu@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
Date: Wed, 21 Oct 2026 18:39:51 +0200
Message-ID: <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com>
 <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com>
 <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
 <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
 <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com>
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

Op 21 oktober 2026 15:53:56 schreef Jason Perlow <jperlow@gmail.com>:

>> Thanks for the pointer.
>>
>> The only DMA related commit that I could think of was indeed the DMA 
>> direction change. Hope restoring DMA_BIDIRECTIONAL fixes it.
>>
>> Regards,
>> Arend
>
>
> Restoring DMA_BIDIRECTIONAL for the RX pool fixes it.
>
> v7.3 plus the change below, intel_iommu=on (05:00.0 in a DMA-FQ
> domain), MacBookPro16,1 / BCM4364/4: 15 minutes of traffic, 7.25 GB
> received, 899/899 pings, 0 DMAR faults, 0 firmware crashes. Without
> it the faults start within seconds of attach.
>
> - msgbuf->rx_pktids = brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
> -     DMA_FROM_DEVICE);
> + msgbuf->rx_pktids = brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
> +     DMA_BIDIRECTIONAL);
>
> TX stays DMA_TO_DEVICE; no faults on it. I can send this as a proper
> patch with Fixes: f0ba5fd51ff2 and Cc stable, unless you'd rather
> revert the whole commit.

I would prefer the above in proper patch, but it's up to Johannes.

Regards,
Arend



