Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5ADC04E87
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 11:24:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09922084F
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 11:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2nfQ9d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09922084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B0F7ACAA;
	Wed, 15 May 2019 11:24:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C3FCCACD
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 11:24:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8C96387C
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 11:24:18 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r7so2206435wrr.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=iK7Jdq13nvzwfdloB64qXfEzplthagbP/dPnPLWGrQE=;
	b=X2nfQ9d+ogB+13LzvpWGxU2FtqTrDaFgjbZJzfz+GIN8KSMsrKP/i0HzYodOqb8NM+
	/U0q1gjkWBvxCr6gnV9iFvvm4Qu9iuYNC+CVBLw3jKBLF/ni3DzhMgsEYIAHHkkRIZHQ
	6+kggP58nysZT4vzheXB4aPdeMl6xVIc665ECpbwx+TfK4wBDIWNWQZRUQ6VcqyhlNnD
	v4yNoZyF61wiNs4hReHZE8sd+eAcPI8gn330Yid8BBsudM9oVHcAHwdW+/2bgn7lEvqc
	eLkiuae7O8StNQAF05Xt8N6LUBzH1oNGYy8451YAYOeYRYUBCjk/CNxeZEhW7YW9t0z+
	mZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=iK7Jdq13nvzwfdloB64qXfEzplthagbP/dPnPLWGrQE=;
	b=ik2N+6ziFbycXDHoYOOo88Y75RXsT/Hhmjl5Cz7/MtVVJ3Nm9e60GvFaoBpiDpHg1z
	RI7fwL5wA4y3jeRAJWwU18T1vm2iXIWT1e7lyPkQXjoKqmGQeO5ntuhPYLlKtr88lKd/
	yOe6+luISBRY3O3VvltlegA02Rh+A7enrtBgtf3EAa8wp8Pb39XC9/+C1yW8sdlfsYYz
	Ilrm389qAvQ2L7EHjtH4EwuukXlgot9KLqoOFLpPQ+ZouZhc8iL8D399Z/XbEVFbJT8A
	qXbh6v1njaYXayfKYslL0ClUp++KVgrPFauIwQpkZ2jGkP2dgFygmdICHDwxyMiiwiez
	/OBQ==
X-Gm-Message-State: APjAAAV8sMcEW6WHnv1rfzFb6QU8lqqDUKdwLHO+66mjOf2/i0isCgm8
	qdRT4fr2OfqpyWQTsJcREV8=
X-Google-Smtp-Source: APXvYqz20Ph3VMG2q93+rpwvfwoVjuDwSfuDmS3H+IKGL6HGHqdN89ujL1mQtamj+N+3HJJOxB1WWg==
X-Received: by 2002:adf:dc8a:: with SMTP id r10mr25577049wrj.15.1557919457324; 
	Wed, 15 May 2019 04:24:17 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	e8sm3959408wrc.34.2019.05.15.04.24.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 04:24:16 -0700 (PDT)
From: "StarostaCZ@gmail.com" <starostacz@gmail.com>
X-Google-Original-From: "StarostaCZ@gmail.com" <StarostaCZ@gmail.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on AMD
	boards.
To: Oliver Neukum <oneukum@suse.com>, Joerg Roedel <joro@8bytes.org>,
	Johan Hovold <johan@kernel.org>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost> <20190503153716.GE11605@8bytes.org>
	<8748125e-f360-ff0e-ea15-699bce9e7747@gmail.com>
	<4e7f0267-eba8-81c3-4036-25924ea9df98@gmail.com>
	<1557911856.2950.10.camel@suse.com>
	<3e7ec2f2-ac47-a031-96ba-fa2b9f21ed2e@gmail.com>
	<1557913582.2950.15.camel@suse.com>
Message-ID: <0903714d-8b72-e714-70ea-67d9dcd94b74@gmail.com>
Date: Wed, 15 May 2019 13:22:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557913582.2950.15.camel@suse.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Dne 15.5.2019 v 11:46 Oliver Neukum napsal(a):
> Most helpful. First, try to replicate this with the iommu disabled.
I am trying this with "iommu disabled" in bios, but system crash too: 
https://paste.ee/p/wUgHl

> Secondly, make a proper bugreport mentioning the affected kernel 
> version (5.1)
How can I do this?

> Thirdly, if possible replicate this with the vanilla kernel from 
> kernel.org
I am afraid, that is not possible. My skills is not too good - is there 
some procedure to how do this?
I made test with mainline kernel 5.1.2 from 
https://kernel.ubuntu.com/~kernel-ppa/mainline/
but computer crash on boot (kernel panic: unable to mount root fs...).

starosta
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
