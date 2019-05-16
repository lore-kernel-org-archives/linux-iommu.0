Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D77FC04AAF
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 12:31:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D223120848
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thC3f1iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D223120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 95E14DCD;
	Thu, 16 May 2019 12:31:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 923DADC2
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 12:31:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 16B80878
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 12:31:18 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id j187so3297834wmj.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=irrf18TkAnIBwB/sk9ySrW1xPmg8nh248pMwpcOj6vw=;
	b=thC3f1iDVZgRUtHibjDrwdsOXWSHr76v4O4wTGuAdeXHJTGtLP9jHX8SSD1Jy3ZgFr
	CHwQCgEqkWMds3L6fBkwCB105+8ouKkF2l686QPfbsGYwnnmPOM80VW4J4VHousWmnfr
	CPD+PDpaBIBedyR98yR/KWhbBeb0gAId5wOEzrMhyKAT/LqtXjdpVOprl7jrcjqiRZfM
	7C/GjSmWmrc42hN+gm4+3UoUv0IPn+oqs5W4lsaeYbMzKeCeZdlZZw/mEja+nBmbWpw8
	+Wt33Ed3HpB3uA3riiQn0WJb5BT6PQKQkJAv9D3byS0LZX18Pc6/zf1T24tXNGqreEGu
	+N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=irrf18TkAnIBwB/sk9ySrW1xPmg8nh248pMwpcOj6vw=;
	b=ZdQKuzElaS277WppxGiy5qPBBADsle6weDmT7JyInrT2lFPzVZwZOMKNIOFTEBKdnH
	CzjY3MYCom5ACc8/e6WZ9/WQSrAWLcBpr4TkAqBs2K3c24UkC8ZpDfHoNaQp2A25r+Gg
	/cvZ6gLeCOlOXktiKiKNUZBBlFYYtuj5odgIdKG/eiUZICbH/hESFbWUlK/g9Xiv2EAf
	oBqYUbRfu37PobZLOkuuk7lZJm/CRQ4naPdgYkozw2QqexRbwpxWweyW9VN+LIf9elzd
	wdiKnyItGUJCMbOvuZOpiBVJAFo9PVy9oSmXq6r3rzEQiqIXYFHdALRGVLqFafVcB6zO
	B7zA==
X-Gm-Message-State: APjAAAXQ1p5YfudCMR2AbWR6Gn0lxau4zNQcG7Xi5anGJ8IBp6N5GMAg
	ZI8XuHxODq5wc7+khnXUFkQ=
X-Google-Smtp-Source: APXvYqzfdrxn81F0I8WiF0aHTKPNawHy9ngG+eXrZmJExhlx1p+O3dRKoolJHbwzcmRqomCK/B8E4Q==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr27129291wmt.33.1558009876799; 
	Thu, 16 May 2019 05:31:16 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	p14sm4563625wrt.53.2019.05.16.05.31.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 05:31:15 -0700 (PDT)
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
	<c57ccafd-7ad4-63e4-54c1-e1fb136ebeed@gmail.com>
	<1557928483.2950.18.camel@suse.com>
	<4a48a017-fbcb-619f-f2d5-4d627a673021@gmail.com>
	<1557993530.14649.0.camel@suse.com>
	<b4c3eba7-758d-7951-afd0-d90a261346e8@gmail.com>
	<1557995692.14649.2.camel@suse.com>
Message-ID: <e1f84b32-fb1f-8a47-612b-aa556981959f@gmail.com>
Date: Thu, 16 May 2019 14:29:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557995692.14649.2.camel@suse.com>
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

Dne 16.5.2019 v 10:34 Oliver Neukum napsal(a):
> Mention
>
> 1. kernel version
> 2. whether this is known to be a regression
Sorry for question, can you more specify what you mean?

> 3. include the log with iommu disabled and mention that you disabled
> the IOMMU
> 4. Include the output of lsusb
>
> 	HTH
> 		Oliver
Thank you
starosta
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
