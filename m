Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B1ECE58F
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 15:22:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52622168B
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 15:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52622168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6F218E38;
	Tue, 15 Oct 2019 15:22:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E3931E36
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 15:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BCE3C6D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 15:22:03 +0000 (UTC)
Received: from mail-pf1-f198.google.com ([209.85.210.198])
	by youngberry.canonical.com with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
	(envelope-from <gpiccoli@canonical.com>) id 1iKOe9-0001En-WF
	for iommu@lists.linux-foundation.org; Tue, 15 Oct 2019 15:22:02 +0000
Received: by mail-pf1-f198.google.com with SMTP id u21so13321364pfm.22
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 08:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=4uWEMUtO+/0Vvy5QnKlN0NMPVmJvd5IxagN1D1K9RuM=;
	b=FCYVEguJY4PGOhsWvq+daLOFPhT2gAFla7EmtTBvgYpivWJTnTJ/kemqGjYCfzpjxc
	3O3isKuv7c9TAAEjXeV8x31doBK6nUX0+/7z4RyAUvLfxxPCuKMT6qCx+XX4uYOlNo4G
	hgWlYUxxmrZMjwV4bJbZ0NthZF8n+hpeiC/fgfJIb/GG66byEViiQszxcGl7eHwfJ24v
	BmVB3QshAynvu+hd5l5CfMN5D35hSMsXltRsPvB0PopeN7DY40EXkFED36lkM8b/tdhY
	3ql8whH3qaSlK9vkBiUkphzHTvwECjtQjTwEEZDPA274OlOiAhmBR0gMPcmyy38ZTz4s
	/k8A==
X-Gm-Message-State: APjAAAXLDg2pnC2NfFRV6mHYfbabTnCuJN3s88S7s6JU4Mxk9oKsODyq
	EcWsm720JzehGBORh1hBELG9WBj5s8iLj82QyEOjHYYmkknRwuoO3/eZEihfIm8bmrVJ5df8h7a
	vK5A6D4BEPubYjUmdXIhOE/vqZmV6gtEyez5Ggwg6ho9b2Z0=
X-Received: by 2002:a63:3c41:: with SMTP id i1mr4452936pgn.287.1571152920612; 
	Tue, 15 Oct 2019 08:22:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzqIwZ8/hi+1TI04wvVCUT6kOctE1TYvzNEHURTZj+QItUndJsJWTqG0o6Iq6T0rUfS9prSFw==
X-Received: by 2002:a63:3c41:: with SMTP id i1mr4452910pgn.287.1571152920254; 
	Tue, 15 Oct 2019 08:22:00 -0700 (PDT)
Received: from [192.168.1.200] (201-92-249-168.dsl.telesp.net.br.
	[201.92.249.168]) by smtp.gmail.com with ESMTPSA id
	r21sm28603670pfc.27.2019.10.15.08.21.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 15 Oct 2019 08:21:59 -0700 (PDT)
Subject: Re: Advice on oops - memory trap on non-memory access instruction
	(invalid CR2?)
To: Thomas Gleixner <tglx@linutronix.de>
References: <66eeae28-bfd3-c7a0-011c-801981b74243@canonical.com>
	<alpine.DEB.2.21.1910141602270.2531@nanos.tec.linutronix.de>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
	mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
	Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
	30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
	irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
	7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
	AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
	AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
	5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
	4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
	q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
	iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
	LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
	aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
	pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
	kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
	nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
	bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
	BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
	1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
	egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
	Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
	kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
	X18zwLgdiQ==
Message-ID: <331f83c2-1d52-dfdb-1006-e910ff20c3a5@canonical.com>
Date: Tue, 15 Oct 2019 12:21:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141602270.2531@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: halves@canonical.com, mfo@canonical.com, kvm@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, ioanna-maria.alifieraki@canonical.com,
	jay.vosburgh@canonical.com, gavin.guo@canonical.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 14/10/2019 11:10, Thomas Gleixner wrote:
> On Mon, 14 Oct 2019, Guilherme G. Piccoli wrote:
>> Modules linked in: <...>
>> CPU: 40 PID: 78274 Comm: qemu-system-x86 Tainted: P W  OE
> 
> Tainted: P     - Proprietary module loaded ...
> 
> Try again without that module

Thanks Thomas, for the prompt response. This is some ScaleIO stuff, I
guess it's part of customer setup, and I agree would be better to not
have this kind of module loaded. Anyway, the analysis of oops show a
quite odd situation that we'd like to at least have a strong clue before
saying the scaleio stuff is the culprit.

> 
> Tainted: W     - Warning issued before
> 
> Are you sure that that warning is harmless and unrelated?
> 

Sorry I didn't mention that before, the warn is:

[5946866.593060] WARNING: CPU: 42 PID: 173056 at
/build/linux-lts-xenial-80t3lB/linux-lts-xenial-4.4.0/arch/x86/events/intel/core.c:1868
intel_pmu_handle_irq+0x2d4/0x470()
[5946866.593061] perfevents: irq loop stuck!

It happened ~700 days before the oops (yeah, the uptime is quite large,
about 900 days when the oops happened heh).


>> 4.4.0-45-generic #66~14.04.1-Ubuntu
> 
> Does the same problem happen with a not so dead kernel? CR2 handling got
> quite some updates/fixes since then.

Unfortunately we don't have ways to test that for now, but your comment
is quite interesting - we can take a look in the CR2 fixes since v4.4.

But what do you think about having a #PF while the instruction pointed
in the oops Code section (and the RIP address) is not a memory-related insn?

Thanks,


Guilherme
> 
> Thanks,
> 
> 	tglx
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
