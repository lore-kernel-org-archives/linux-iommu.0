Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B1C04E53
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 09:45:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59FC2084F
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 09:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugX6i4Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59FC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ACDAB2371;
	Wed, 15 May 2019 09:45:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B098FC90
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 09:44:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 34BFC837
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 09:44:59 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id f2so1785565wmj.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=DtE5HfpZ+1qLrXuVQIbAVQkRD8RJlyrTRnxIJR/9Qsw=;
	b=ugX6i4OrdC+UZoznH6hLcexrGpTujUDcdsOyi4i98cGQ4xpLoA9UjtUCNdXDv7WojE
	tR+DlFn9yGc5c/KXHu3DIW/9Ixz3V1VtqQSXSCYnh8vBSvhC+I2yZIOr1+Ypyq02KaOY
	IjnjhdGSp4pvqsn4xMmPEe+VX9ukaUfBbRue0Z0EEqFdfS1jodVZR4Acq1pwoCY9x/Cv
	G4Zx+tDkWCirGlr6ePP1RSdvkB6d9OLk4C01ozmdXrdvG/Q6IlNMFp4aLfsH+aQmVFe/
	N5nvBqfqPJKXjZUmjPZsG9Cp7pr4WqCwCQ3t7MRRZ69vWDFEmfPDaoGsH2p+lCrwwh5c
	Kj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=DtE5HfpZ+1qLrXuVQIbAVQkRD8RJlyrTRnxIJR/9Qsw=;
	b=ptECl3sLLZkHHhjLD4gbNdhDYuY+yMgLZp8K1gAzq7GvpbveX9VtdquLSJPWWgiS5j
	8TPWv8JgjQEIsBZBR6d5FvLE1oghYnzNnRucU5HtU9Rf3SIbITsRCuqnbljgH8bO+eRY
	K/nYJ+D4I/FMRUrChMwTKuLrIfs2bT12RLwVZZub1Pmj56jXqDImNXWPdWiEko68eLi5
	nsQCldCdzxZhK5sVxtc+FB+Zdtk8H0Z4yVj+znw9+wV2urxAfVje/3lEfPHpPUso1d+b
	IC34Z++FCCgNaf1ozMdJfW/2zyBkUPLyIPanBCDAPEMRnmugTnslP8HDXKzCeXNM1MFR
	EVwg==
X-Gm-Message-State: APjAAAUK3zM0HxqKcWF6/ZEByYQMT9RIwwI6hPdkyiZeOW9TVfc8Fn0v
	bY7zJHspJCnezLlwBhoVhss=
X-Google-Smtp-Source: APXvYqxkoIvkqJFRe89FKzN6JMv8Vi5ELPAijKSwFqaz4sdD0rG36eUIOP/bcCzykmpc2y/sDmcOFA==
X-Received: by 2002:a05:600c:23ce:: with SMTP id
	p14mr8580468wmb.36.1557913497835; 
	Wed, 15 May 2019 02:44:57 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	a4sm1923346wmf.45.2019.05.15.02.44.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 02:44:57 -0700 (PDT)
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
Message-ID: <d74dba47-5a58-cf34-3c36-975f9ccee0ea@gmail.com>
Date: Wed, 15 May 2019 11:43:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557911856.2950.10.camel@suse.com>
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

As I wrote, I made new test on kernel Linux version 5.1.0-050100-generic 
amd64:
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.1/
Same problem, system crash after a few seconds. Full kern.log: 
https://paste.ee/p/EmLsw

Unfortunately, I can't judge if the patch is there, but I found, that 
this patch was added to kernel 5.0.2:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/amd_iommu.c?id=4e50ce03976fbc8ae995a000c4b10c737467beaa
Can I somehow verify that the patch is in this ubuntu kernel 5.1.0?

starosta

Dne 15.5.2019 v 11:17 Oliver Neukum napsal(a):
> On Mi, 2019-05-15 at 09:54 +0200,  StarostaCZ@gmail.com  wrote:
>> Hello,
>> can I still help with this problem? It's very important for us. Thank you.
> Your first step would be t verify whether your kernel has the
> fix coming in the patch Joerg mentioned.
>
> 	Regards
> 		Oliver
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
