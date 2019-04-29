Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FCBC04AA6
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 18:32:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B3A215EA
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 18:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+lWFkWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3A215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EA66C24E6;
	Mon, 29 Apr 2019 18:32:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2381C1E27
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 10:52:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9EAAB608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 10:52:12 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id g3so15284624wrx.9
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=BlH2+2dT8DBceBf7g6p1pnr3mj+D4ldrgPjNPWpGkFA=;
	b=a+lWFkWCn7SzQPH12EobCZkEwlCUKdZQ6aBPNfYrxVMz2P7zVHyHmcnbVlKXcjXLsN
	9KG/nLWX0k7WpXXnDBdm810SD+7u45uFXf7yjyb+IAAC5m74vRE1bIPBEP2s4K0dB2Vb
	iraHyQRQjYuKvbm8Z10CHUssqU4Mh3PU3nzFQNoF16AFIGQAIhqgjciS/BsrgE9QCGbi
	EEG2fDc0iUQHpx00MecEUsLHq5H1RLbKqxFBByvpao/3mkqKN8mwwEsREp+uKMmkO8hL
	EuVKEBa8qxZCHdB2GsHyGKQQ8G3+b++QAzecfECm4Sy0/PA5BTL3/qRJAdbnwBLqY7Wu
	Qasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=BlH2+2dT8DBceBf7g6p1pnr3mj+D4ldrgPjNPWpGkFA=;
	b=UymtD8SI0u49QmSX00jLVFhRo0USqg3RRQoMKJ6D1Bl9G49SUoh/lr5MnozmVJ/poT
	3qGItO5rHYCDC/HCpq2ChPwqVTzkveuy2KG8g+eK3RdBI3jHg8pB/WZurY4UJ9YV1hOJ
	7rEJaft4Z8wSSiTxg4LxBBwiXOdRQsqHnYj29r36m93Wb2JAMoAZC73Sk2J7Gc7R+zVQ
	C50SHMn58BBQw5N3HuOfH31Dvmdz/KZJWDum4lLGFkbjjuKPS/WvQQtCYHEb4uTmFZlI
	kXz1oHW/KnJbJ8PBDtUsELJAQoMyrobcKBkSmvJuU8+GuZn+8HG6W3aM56ICdF8t9HFw
	mKVg==
X-Gm-Message-State: APjAAAWFzua0sz5Uhr1ihBQEAQHJwTU8Ei2u0LfpxCvj6w7Ga1cSoKlX
	Vfy7Lv6efW/aa6Sm9fT454RfMX6I
X-Google-Smtp-Source: APXvYqwTlIKhawd3e/E7t+s7vNZEZjhgL2Ez3LAhCr836dwrQ/8DQk6h3Z/LLH+ex2dUaR2tBCHDqQ==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr1287347wru.199.1556535131064; 
	Mon, 29 Apr 2019 03:52:11 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	s132sm6990652wms.10.2019.04.29.03.52.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 03:52:09 -0700 (PDT)
From: "StarostaCZ@gmail.com" <starostacz@gmail.com>
X-Google-Original-From: "StarostaCZ@gmail.com" <StarostaCZ@gmail.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on AMD
	boards.
To: Johan Hovold <johan@kernel.org>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost>
Message-ID: <26c4a175-dae2-3410-6924-92fe7c8ec6fe@gmail.com>
Date: Mon, 29 Apr 2019 12:51:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429094847.GI26546@localhost>
Content-Language: cs
X-Mailman-Approved-At: Mon, 29 Apr 2019 18:32:46 +0000
Cc: linux-usb@vger.kernel.org, iommu@lists.linux-foundation.org,
	Mathias Nyman <mathias.nyman@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429105120.97LNBfSRNaXUW-09WzRaw6i-2-mR_WciKYHRq00_lB8@z>

Hello,
sorry for other questions, but I am new in this list:
Is Ubuntu server 19.04 with "kernel 5.0.9-050009-generic" good for this 
test?
Can I add attachments to this lists?
And who is xhci and iommu maintainers? Are they CC in this mail?

starosta

Dne 29.4.2019 v 11:48 Johan Hovold napsal(a):
> So this is a debian 4.18 kernel seemingly crashing due to a xhci or
> iommu issue.
>
> Can you reproduce this on a mainline kernel?
>
> If so, please post the corresponding logs to the lists and CC the xhci
> and iommu maintainers (added to CC).

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
