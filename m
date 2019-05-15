Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C9C46470
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 11:22:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FDE20818
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 11:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU4cXrD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FDE20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 54D60AF7;
	Wed, 15 May 2019 11:22:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EA1B5ACD
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 11:22:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D41B83A
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 11:22:34 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id f8so2261834wrt.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ckBX2l5f1VZG5CnTLL79iVDtrDK0NkXfJfWMzfaal8I=;
	b=IU4cXrD1OXfGBlV80LdeWPSYSO9PVeq/P6eP0zLDvxjn0aLZk5g2Cu08z6TSC/3SrE
	ArcZpUc0L4Kf7Y7u9B3edXERb5IGf7TnI/lC6zIbk64VwEDdY8aEX2Kb3jCELBQKJRem
	IuK+vSbkyYYJrN/vwGxs0lbZ7vt2xZmoGtKugCv6l/hwddBm/vROpQFTZA5mo9QYFW3m
	iXm9Wo/pzY0UvQC2AmAiVqCvfHJAzi6UxoqybtJ1lJSh1PK2xYe9+sEuBdKvPoyHx5yd
	QX1lU4BvHVHfVhzQrnrMyCid1TFrQz2hD3nF8Fv2EjeIR4tmTWAq4ohlmJO8zW47iv5x
	xHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ckBX2l5f1VZG5CnTLL79iVDtrDK0NkXfJfWMzfaal8I=;
	b=HuCMEOGouFHDg1K82w+rPjpKG+HeoKjcB6EV25wtBqifQh9XFDJsP+Yi6Y9vXBfN5C
	IKjXl4LxDfcwvM7ttUPCvaOwf7l94USoo+ypnI/9rSe+hT1OttCi7kxcheNTBNSZVIIy
	4MPjUi79Eur7XZ6LCIeCYaYOZx8kU1Qpbek9NeAE1SjQdxzeJOEnZwO4RDgoDi+YJ2Hz
	LZucRM+2SGfunxFdoyQV6ulBXYmAek3eAvJyPZUXqUZXigY3ImCLeEhvMlBQpMKxTh7i
	YGvitPtMYoKnlnanDjVPNRvESFL9bJflF0DWJ6IaOORJEpD2wGJhIZLMyaZDL+sxgwFL
	AKMA==
X-Gm-Message-State: APjAAAWdeSrdUrYZibC5/OS4d/hOAthvpyXp+2hCz9cMFdhaEe11MmOa
	xTytjQGebw0rkYTepJPEd6o=
X-Google-Smtp-Source: APXvYqwM2FHWOKfhtPK9q1xtu8lj4VCZCTvys9W5/RT1tHaabqHbX8MRqWWWgveccEQEMBQG+BK8OA==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr26305678wrv.131.1557919353044; 
	Wed, 15 May 2019 04:22:33 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	y130sm2196797wmc.44.2019.05.15.04.22.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 04:22:32 -0700 (PDT)
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
Message-ID: <c57ccafd-7ad4-63e4-54c1-e1fb136ebeed@gmail.com>
Date: Wed, 15 May 2019 13:21:00 +0200
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
Content-Type: multipart/mixed; boundary="===============5896034572950411621=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============5896034572950411621==
Content-Type: text/html; charset=utf-8
Content-Language: cs
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Dne 15.5.2019 v 11:46 Oliver Neukum napsal(a):<br>
    <blockquote type="cite" cite="mid:1557913582.2950.15.camel@suse.com">
      <div>Most helpful. First, try to replicate this with the iommu
        disabled.</div>
    </blockquote>
    I am trying this with "iommu disabled" in bios, but system crash
    too: <a class="moz-txt-link-freetext" href="https://paste.ee/p/wUgHl">https://paste.ee/p/wUgHl</a><br>
    <br>
    <blockquote type="cite" cite="mid:1557913582.2950.15.camel@suse.com">
      <div>Secondly, make a proper bugreport mentioning the affected
        kernel version (5.1)</div>
    </blockquote>
    How can I do this?<br>
    <br>
    <blockquote type="cite" cite="mid:1557913582.2950.15.camel@suse.com">
      <div>Thirdly, if possible replicate this with the vanilla kernel
        from kernel.org</div>
    </blockquote>
    I am afraid, that is not possible. My skills is not too good - is
    there some procedure to how do this?<br>
    I made test with mainline kernel 5.1.2 from
    <a class="moz-txt-link-freetext" href="https://kernel.ubuntu.com/~kernel-ppa/mainline/">https://kernel.ubuntu.com/~kernel-ppa/mainline/</a><br>
    but computer crash on boot (kernel panic: unable to mount root
    fs...).<br>
    <br>
    starosta<br>
  </body>
</html>

--===============5896034572950411621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5896034572950411621==--
