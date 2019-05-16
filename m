Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B0C04AB4
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 13:38:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1C520833
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaJcgZaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1C520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8C21DA49;
	Thu, 16 May 2019 13:38:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 32BF99E7
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 13:38:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B0EF95E4
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 13:38:01 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id h4so3447387wre.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=FFOI0ZUH55p4MBcmLBSoDHFwh9O1y33Z+QL/gL7CF3c=;
	b=XaJcgZaW01x4qPENcCQ5Ataca3oPJcsV2k7H3l78PmA0NSo12IMGu59dqrkaKgJUeH
	avOPXSyW2jhm+csZw3URRAewdIzhy+vZ7WhoN3UdPamENdBl/NhQgWIVuWlTpKx/TvP1
	1P1YPB5Z1PROJccaKGl1Fq+cq/tNWsIf4hi9Z2GMfZC3zNrWwLzSmyk+0WEdeHYw4DSR
	LkoWLdkbD7aQo7zSA9FKBRDXRfwhx2CzMORe4funzdz3aLDOFVNu9pj7XUK11c8btMMM
	wQ8tHDaSBL0KgdMCTv95rAcuxupJfJjSQdsQE9HdLQJA8JdWJDB3oOwA8siagW1vz5Yl
	6sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=FFOI0ZUH55p4MBcmLBSoDHFwh9O1y33Z+QL/gL7CF3c=;
	b=LbhZ/LebvLsk5E4GodIui4B8raa+RRJYj1vEVYB4RR7Uua5FdxUo9nbDyIVOaD1M94
	90MnuYoE7ggN9NB0+mCjxHXLBQC+R3w/kPR6L0aa6jiL3BQSjaxVg8IEION8qJKLGk6p
	Iu9e6HMEP+N0kr1wC+ZWc54XEFAhRfECEC/8US8rEf0WSjNxzi1xkS3ve67KuSuzTW98
	ehruGKtAGkKz0rUDrZ45DpCzCeFUyfHnduy0v7G1ipwuFrA7QL5J+D3CnR0jR0kAhSH9
	xpNjMLnQryWyfNSOUHox8pLND52Qr0wjCOwAoyh3APpPFy+WfrmgM/C/utHWukv1fH4O
	VtlQ==
X-Gm-Message-State: APjAAAVjtSBlcT+04q9Ru0sivX+FH9FWybcORhW52Jsp6ei9Hq5kmPjm
	kO30Z7s2Y9O/gjXHdXXVwaE=
X-Google-Smtp-Source: APXvYqxqZqZJ01a2hG8nkQknkQ4PGjfUG72VKBMhziC4ERZ+KmBO28jCNTi4hGchKOHZc2JoOmWMtA==
X-Received: by 2002:adf:dc0c:: with SMTP id t12mr17184746wri.101.1558013880448;
	Thu, 16 May 2019 06:38:00 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	t6sm5512804wmt.8.2019.05.16.06.37.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 06:37:59 -0700 (PDT)
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
	<e1f84b32-fb1f-8a47-612b-aa556981959f@gmail.com>
	<1558012314.3309.2.camel@suse.com>
Message-ID: <9db5488c-c5f6-58a5-6edf-cdac4108f284@gmail.com>
Date: Thu, 16 May 2019 15:36:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558012314.3309.2.camel@suse.com>
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

Dne 16.5.2019 v 15:11 Oliver Neukum napsal(a):
>
> You will be asked whether this worked in earlier version of the
> kernel. The answer would be: yes, no, unknown (why)
>
> 	HTH
> 		Oliver
>
Thank you, I sent new report.
starosta
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
