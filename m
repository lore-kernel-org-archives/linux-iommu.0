Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571956;
	b=u778/N1wGRO4dwZtXh6DVqKA//XKooAiuLrlGiBZujGqDOnX9dTkN4o/XR7gHwECOp4U
	 xaQbZ4UhrUjSDi19ZaYfBvL2weIxnDU38B+3u/ZW1ochu3mek/IzbImZ6NKi/aQQybx+i
	 eLcJlCzwBsPPAz7nk2xAfPEn3l2WneiMsqm79Wj4+blKRIsbLGwl0zOcp/9iY4P1/jbPs
	 GAdxumNSuuN7ey8Phg1Y23gTbsPNYWmP/2m/UOlRaLi7z30972JCFZl/beeuNLpTQ3BhO
	 JKtIlwVPknhdSuzQCqsrAK9eFL9Q/poGCLZJfGG/jtQ/9GvqBDeqmsluwyx/QriOdkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571956;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=YRXwFSRhdWp/W2rW9Y/SDS5xAnZEmQtLtB30oGZWhEw=;
	b=jP/0oJHnElhjBBXZk10D0r5XGmGasZADg8bwlzX87b0N5XjcYdBoq4f8aG60eEVo/heO
	 JpMTsr+4NUlaxXc1bGjYGsgLjvlFKocwJ2g83CIHz7kfkpa9svGDh2WfBn70Ay+3x95EY
	 vsLr+uBWNuW5qFPchepJrtKLeui22gxqyguM8/GcOD4Dv75g0c3nIfbO7NAgEZ3RobtXB
	 QR3UgP7CDOew5SbvycXjrpNKx5DZl4E/FbfDgNR1cBOBtveiOw3fGY7Q3A7QA1V9Bf/NO
	 I0X8WLrplreMnJ5A6tPwRgVoZ/DdfZtO+lwAjeJwhx4v04M7OdPfc63uc1GGrzSfTiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HtcO4OFo;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A298606A319
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A298606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HtcO4OFo
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ad91684554so117709a91.2
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571955; x=1793176755;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YRXwFSRhdWp/W2rW9Y/SDS5xAnZEmQtLtB30oGZWhEw=;
        b=Cl0TJCFoizawimI0atOhl/2YiGGK8wfr4FHyUGVhYQR+gfO4Axk/TmrZ3sFxn5ieAl
         OOLkacX/q9MsuEOCUAnTwbQVH6o9g4DgaXvwFWaXm8vMyQTH/j2/t8e0wgfvaXT/PMFB
         7MJ5KZKckRNcU4PJJ8W4MscwECeVscLim65K3soQfIeE5TrsyeWH7nJNpwkfGeAtoHJV
         AoLklYRQPc7K/VxnFste48eSggFdZ0pfLukBkAYPbawfAhgbTESLmWZ2I/zb+TCKG1aD
         o58yAHlN4NGvBRxWmC+yaEJSJkehgd6g/v+2Y2+HfP84nOmSQrQ+jgLKyUH43dMCtzuB
         dq/A==
X-Gm-Message-State: AFq9FYJ0kl2mwBsfgZonYB3g2gOwkfOZ6OfErcyd6/4Y7G9MSQtqhXr+
	KaOwMyhlbg53I9IIZMonzCXSBq5R/jn8K3R7l3P0yzLRSmiZWbnHrhEOfF4sIxL5LwuvTH1uJA3
	lIBmdrD9Zdyh/XsSsNaPED0eeAn2DYRHstw3rh5EpsA+aYKHJIaxYpUg5a0qNGdVwgvLaDQ5i8K
	+O9nsN3+UzAVScR5A7x2cD4zSRTr09ncyRarn8bnVU5YhrsDVwkXdYE45+vvA3eny/soQgS92eN
	alb8BH/MwzVK8e9
X-Gm-Gg: AYBFou2j/94bRfHiqFF61ZrrFypvZ55nxnkLKUMgSVKPXipEXTToESf9XldmIhjkrKd
	Y74E0E5qDL1D7qpiILVgyq4pO0hzWcc2zZBE+RCyUPXMQr0xku5AE+RbfA//hCz3yi8lFfwZPJd
	19l7MmxcxUhU6sjBvoVSQomYU2kOZx2i36pSq7bKuiSCkEJW1lItxgorqjTBVyV84zeoUJYFqN0
	lXyCB2oXDdTPSjHwap9+CdYPouK7VHXMDN0QT0K87YeLNRuFrjPia8DKpN+YmttwH1YjbayFt0Z
	HPapWnY/tv3lKdG3MfhD3IfRIOgs/xQIAP4LsgrBLrjXKrCh3PxmwRmPLbklYoNDtFSyUTWfpQ7
	KbyropDxJX+DHxNj4tf+uogDjROk+wgLM7o0r3CkYNLT2IjvLKWBdPN68XZZ9ixmqed9IJc1wwL
	t/2sB7eyIL2XPv/bvc2uVVJoXlYDrd2X95fsrEPHTQMg==
X-Received: by 2002:a17:90b:3846:b0:3ac:85be:cd52 with SMTP id 98e67ed59e1d1-3ad86f7388cmr1394767a91.59.1792571954952;
        Wed, 21 Oct 2026 01:39:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad81a5e1cesm1541212a91.3.2026.10.21.01.39.14
        for <iommu@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:39:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb71b1443so97105085a.2
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792571954; x=1793176754; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRXwFSRhdWp/W2rW9Y/SDS5xAnZEmQtLtB30oGZWhEw=;
        b=HtcO4OFo5rxN9pqHCwLtZJCFy8iEb0uUc0SE0Odr8wplLfih0oFBea+yUC2gB8qyuq
         pD6NLWRKqhFf9qzdnqQu5C2gYKuTOuoNqwUadJagDutHhoqX0X/2xQe53U/kXXq+0T31
         oCBpN4eb5ZYVX+ckwVvO7AcGQOCKpb4aeXnWg=
X-Received: by 2002:a05:620a:31a9:b0:93f:25c7:a4e1 with SMTP id af79cd13be357-93f57f707e5mr288326585a.26.1792571953675;
        Wed, 21 Oct 2026 01:39:13 -0700 (PDT)
X-Received: by 2002:a05:620a:31a9:b0:93f:25c7:a4e1 with SMTP id af79cd13be357-93f57f707e5mr288323885a.26.1792571953265;
        Wed, 21 Oct 2026 01:39:13 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9af50sm195498585a.8.2026.10.21.01.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 01:39:12 -0700 (PDT)
Message-ID: <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com>
Date: Wed, 21 Oct 2026 10:39:06 +0200
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
Subject: Re: intel-iommu: DMAR PTE Read fault crash-loops a PCIe wifi device,
 v7.3-rc7 -> v7.3 final regression, reproduces on one unit out of five tested
To: Jason Perlow <jperlow@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Aditya Garg <aditya.garg@linux.dev>, dwmw2@infradead.org
Cc: iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com>
 <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com>
 <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <74570358-8085-4767-BF76-D865CA95853E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Please respond inline. No top posting.

On 21/10/2026 09:33, Jason Perlow wrote:
> Yes, done. rc7 with intel_iommu=on on the same MacBookPro16,1 shows
> the same fault: 95 DMAR faults, each followed by brcmf_fw_crashed, in
> one boot. So no rc7 -> final regression in the IOMMU code.
> 
> It is a v7.2 -> v7.3-rc1 regression in brcmfmac, from f0ba5fd51ff2
> ("wifi: brcmfmac: Set DMA direction for msgbuf packet IDs"). RX
> buffers are now mapped DMA_FROM_DEVICE (prot 0x6, no IOMMU_READ) and
> the BCM4364 firmware reads them:
> 
>    36.512689 map   iova=0xffeff2c0 size=2048 prot=0x6 (brcmf_msgbuf_rxbuf_data_post)
>    41.110125 DMAR: [DMA Read NO_PASID] Request device [0000:05:00.0] fault addr 0xffeff000 [fault reason 0x06] PTE Read access is not set
>    41.139317 brcmf_fw_crashed: Firmware has halted or crashed
> 
> The fault comes before the crash. Before that commit the direction
> stayed 0 (DMA_BIDIRECTIONAL).
> 
> Thanks for the pointer.

The only DMA related commit that I could think of was indeed the DMA 
direction change. Hope restoring DMA_BIDIRECTIONAL fixes it.

Regards,
Arend
