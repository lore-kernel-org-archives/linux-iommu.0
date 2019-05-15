Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F9C04E53
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 09:44:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3F720843
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 09:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6EZda+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3F720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7C9632370;
	Wed, 15 May 2019 09:44:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8BC82C90
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 09:44:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F145C837
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 09:44:52 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id 198so1926240wme.3
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=xPVV7zc6Xvw4kUxn/OfJqOB33VcRFAdUeQKXtwCKrUc=;
	b=F6EZda+wVY7ugg4ck14ypeVuYu1wSW+qGgbdSBPE58Czo/s2qnEf307yE2CN8saQtM
	VaXhqGr04J+pNayxy4AkbVg+ELwlerg4Q9dsNkBGG4pYNUTv0wmYQsteFgfDT3NJ8dDI
	w5Qa7uQkqtVPgT+AMrZUqINR27Yg/f9za0mho9SG61U6GbPhg8LQIKwo3t2cw2Xnljz5
	Iju8Ugg7GxUtBWIw/tXlthAKWWAuU8iv66qrjQV+vE2RLOo/mRtzx0UzTZ6lPZiX9udT
	h54laqkUDnNWwyyDbR+M/EzDSK69binp9ljKk4oi8jC5dLyMZ4Na0B605T2K+Nq6pvSa
	r+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xPVV7zc6Xvw4kUxn/OfJqOB33VcRFAdUeQKXtwCKrUc=;
	b=GKjMiEEEECnGZNvxB8STY5ENQwm2ecXUH4Th+7ub/yQ6ujE9sUAiwEB2dvjjxUfPNY
	fzMQjDGIV8JBd/esRSWLVr89193wz27TRHawEVELisFzF5shK/fXh1YCkXj7mMWBp2AD
	/U6Erkm3xTISZ/xTqmQCnC28MvJ5/oXkGcCF/L+7wRn+7qIYnHK8VyCFxaOYAx6k06rA
	CGwpNddGKWwvnqBZZcpfB0f5Wa1xOj6yD5+QT2CXCUgA5SP4Ppq8LHBoHRB5LuvotcKR
	z/EoO7MsQpVy03OBy35OsJM8W6zNd8QI+96w2xOuYN8o13jaGUHlTg2KAH7w8I0BXEdz
	Uhjg==
X-Gm-Message-State: APjAAAUkou9INzwJHw9Dc3N9ubcB5rTkyB80R71+jnahKfpckKE4UwXv
	Qb6jyeqLlX7d14GCS4JWwzk=
X-Google-Smtp-Source: APXvYqy8OzH420i6lujPKgmUh8sj2NTrkbCIi8axK530K3qDKAt9eLTfZx0FpXh66/NHu6Rig+BoxQ==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr21848714wmz.153.1557913491579; 
	Wed, 15 May 2019 02:44:51 -0700 (PDT)
Received: from [192.168.99.70] (mail.unidataz.cz. [193.165.148.130])
	by smtp.googlemail.com with ESMTPSA id
	m13sm1425056wrs.87.2019.05.15.02.44.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 02:44:50 -0700 (PDT)
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
Message-ID: <3e7ec2f2-ac47-a031-96ba-fa2b9f21ed2e@gmail.com>
Date: Wed, 15 May 2019 11:43:18 +0200
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
Content-Type: multipart/mixed; boundary="===============8023961234861033211=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============8023961234861033211==
Content-Type: text/html; charset=utf-8
Content-Language: cs
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    As I wrote, I made new test on kernel Linux version
    5.1.0-050100-generic amd64:<br>
    <a class="moz-txt-link-freetext" href="https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.1/">https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.1/</a><br>
    Same problem, system crash after a few seconds. Full kern.log: <a
      class="moz-txt-link-freetext" href="https://paste.ee/p/EmLsw">https://paste.ee/p/EmLsw</a><br>
    <br>
    <span class="tlid-translation translation" lang="en"><span title=""
        class="">Unfortunately, I can't judge if the patch is there, but
        I found, that this patch was added to kernel 5.0.2:<br>
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/amd_iommu.c?id=4e50ce03976fbc8ae995a000c4b10c737467beaa">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/amd_iommu.c?id=4e50ce03976fbc8ae995a000c4b10c737467beaa</a><br>
      </span></span>C<span class="tlid-translation translation"
      lang="en"><span title="" class=""><span class="tlid-translation
          translation" lang="en"><span title="" class="">an I somehow
            verify that the patch is in this ubuntu kernel 5.1.0?</span></span></span></span>
    <pre class="moz-signature" cols="72">starosta</pre>
    <div class="moz-cite-prefix">Dne 15.5.2019 v 11:17 Oliver Neukum
      napsal(a):<br>
    </div>
    <blockquote type="cite" cite="mid:1557911856.2950.10.camel@suse.com">
      <pre class="moz-quote-pre" wrap="">On Mi, 2019-05-15 at 09:54 +0200,  <a class="moz-txt-link-abbreviated" href="mailto:StarostaCZ@gmail.com">StarostaCZ@gmail.com</a>  wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hello,
can I still help with this problem? It's very important for us. Thank you.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Your first step would be t verify whether your kernel has the
fix coming in the patch Joerg mentioned.

	Regards
		Oliver

</pre>
    </blockquote>
    <br>
  </body>
</html>

--===============8023961234861033211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8023961234861033211==--
