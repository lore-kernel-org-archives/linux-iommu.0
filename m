Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B528C04E53
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 07:56:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F722084A
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 07:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SluTyKcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F722084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1FFF7B6D;
	Wed, 15 May 2019 07:56:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6A25AB62
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 07:56:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C5252C3
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 07:56:18 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id y3so1557597wmm.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=rBex1R9irR8avZOElxAJHU70GLvNreCgKQt4QdExZ90=;
	b=SluTyKcCl6WXTC6B8cG+tW+gV5I+1HneedKnl9R9nJTDQ57laZrekoNH50LMRQinL9
	jKO+siRsPSvuCwp3kHA1Sx0eQJCBWdQNOEM8sDGGtRXfgvtEf2aQiLXkrAvbz+IM91z/
	BUIY167oEXuCYY0FWhWXcuA91jEcWdqwOI6yQ/vmFEI0vki/7NRIYXgs2hgq5SYCNuBB
	qt+okyGxmOtqrK3BM6nVxdOdiJ6uQ5bjIWVB9OzTVVSdGJOvOgchDigYT0KsO+EF1XMj
	arWXYW3LLFZrhDbrJZwjUibn4DikorvpDIs5HdWnUpplB7D/eq6B+Z2/ULf4rE/D9ipY
	zBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=rBex1R9irR8avZOElxAJHU70GLvNreCgKQt4QdExZ90=;
	b=iiPKggczHhA4g3GvSmn0XbyLn78RiOxfmFWcZ+0148E15Ao4q/AuMHEPJrl0TfQYHf
	B7rwL0eGFlYCQMMoN6UVYYesxin6Apct756yhrlAlLrGwXOSK6AFS9leOIisJOX802X5
	74E+p6Gm6/C64eSH7XDtzTf+yS5s3mAhXZnwc/xd33CKzfM58H1RsfMq4UiJFP1LeSLQ
	FjTeSUgEVLTCTT+bquPjt38pS79X4BRxSa8q2r/HyzRnXpfm+XhxtCWmKj6i6yen1/CV
	Dos0LdlV4qnz5pV416ScmitZSmF6+tqY1meIb8o7OOoEYv+248EtOqH+XOOYZhXRAuav
	rZMQ==
X-Gm-Message-State: APjAAAU34l7yaoQagKG/kZrGx5IOZ0qD9stGi9MHIrXzKnRwLMIrivGm
	XVI8svcDtXgsfj/nuvVImRg/IP9Fy+Y=
X-Google-Smtp-Source: APXvYqymW2MN2a95wioLbYgs+h+ZvgQ2fCj8d+MFdr1X2p+Qp5IRpPGBDrFLcxJpHTU9duQ4YsELTw==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr22419717wmq.144.1557906976425;
	Wed, 15 May 2019 00:56:16 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	s124sm1613878wmf.42.2019.05.15.00.56.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 00:56:15 -0700 (PDT)
From: "StarostaCZ@gmail.com" <starostacz@gmail.com>
X-Google-Original-From: "StarostaCZ@gmail.com" <StarostaCZ@gmail.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on AMD
	boards.
To: Joerg Roedel <joro@8bytes.org>, Johan Hovold <johan@kernel.org>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost> <20190503153716.GE11605@8bytes.org>
	<8748125e-f360-ff0e-ea15-699bce9e7747@gmail.com>
Message-ID: <4e7f0267-eba8-81c3-4036-25924ea9df98@gmail.com>
Date: Wed, 15 May 2019 09:54:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8748125e-f360-ff0e-ea15-699bce9e7747@gmail.com>
Content-Language: cs
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hello,
can I still help with this problem? It's very important for us. Thank you.

starosta

Dne 6.5.2019 v 9:10 StarostaCZ@gmail.com napsal(a):
> New test on kernel Linux version 5.1.0-050100-generic. Same problem, =

> system crash after a few seconds.
> Full kern.log: https://paste.ee/p/EmLsw
> I can do access to my pc through SSH if useful.
>
> starosta
>
> Dne 3.5.2019 v 17:37 Joerg Roedel napsal(a):
>> On Mon, Apr 29, 2019 at 11:48:47AM +0200, Johan Hovold wrote:
>>> So this is a debian 4.18 kernel seemingly crashing due to a xhci or
>>> iommu issue.
>>>
>>> Can you reproduce this on a mainline kernel?
>>>
>>> If so, please post the corresponding logs to the lists and CC the xhci
>>> and iommu maintainers (added to CC).
>> Your kernel is probably missing this upstream fix:
>>
>> =A0=A0=A0=A04e50ce03976f iommu/amd: fix sg->dma_address for sg->offset b=
igger =

>> than PAGE_SIZE
>>
>> Regards,
>>
>> =A0=A0=A0=A0Joerg
>>
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
