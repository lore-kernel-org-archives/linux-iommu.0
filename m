Return-Path: <SRS0=CJku=W3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5281DC3A5A6
	for <iommu@archiver.kernel.org>; Sat, 31 Aug 2019 13:56:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126F122D6D
	for <iommu@archiver.kernel.org>; Sat, 31 Aug 2019 13:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJDzltx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126F122D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B75571058;
	Sat, 31 Aug 2019 13:56:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1F9601047
	for <iommu@lists.linux-foundation.org>;
	Sat, 31 Aug 2019 13:55:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
	[209.85.219.170])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7D63B887
	for <iommu@lists.linux-foundation.org>;
	Sat, 31 Aug 2019 13:55:14 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id j199so3496892ybg.5
	for <iommu@lists.linux-foundation.org>;
	Sat, 31 Aug 2019 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=IxBgIg4l69kyi9Pn+Z2YxWfpUanE7M6BW+hzJyfmhqM=;
	b=sJDzltx4bKriwpw+685ry1k00Rxw6zvgpNGrRqv7mtcVkSf5STAxA0I1gIU03j/ClT
	n6rP+Or7tQGA4ZOJMegR6xHVL/iix9oKJwmwYevSNg9rwGF9zNQoDWlQT2JKLSkmsi7k
	MmiQXOOs6uLvNxKweyBqu8pGestr1JWH+1Ftu/1lA2Xd42hzaBR3ZbMhIWmixfZRXvET
	hjk8BeLlcUdPoWcA1H4Y/pfg+EMyIWE7eCu1wvzdBILTx2DsZhZvojaMWMjNLTZVNXMG
	e4h/ejLaoju/l7Dk2hsGUqLXL74TIt2hd6RdOakKgTQTl8SFelA0f5l1pyt7j+TpWjy1
	+f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=IxBgIg4l69kyi9Pn+Z2YxWfpUanE7M6BW+hzJyfmhqM=;
	b=DtipYmPwdreBlQOc5qjBLpHruqent2RkOpV7IEi0+zLFkUcRiKsVWT1p8uGA7fHT+Y
	fAQDPxx9BPw/R8m7sGlE4QXs9MYlUbXzzKeK0xpaaS5b+sISh2i21ooSg8ik7bae73gU
	rhbILtlOxrEl0X/k/P82G8HInphzZfEzGGelI77CHKM1eC2BiTo6o1dNBnme9pw1uKS5
	PXvDP6oPgJ5Wnytb5JEulaAQt87DzBVblDkU6bxLflOkHfDtva8A8Uxv+V4NXCo9VOrT
	gJOg4m3zaiZYmZuiTr9+GCdj6l27Gi47t/msbpkFTlnmD4fbYPssGrUp5P/FG0Yi72GE
	hBIw==
X-Gm-Message-State: APjAAAVACWHuFJ6INxHP1dZutSQPDcwTpBn/aHBSl6w6ELeYOq+w11gc
	wTJx/EzjumaTEqEvToytZz9+YDWyGT3vNX2oWJlU/LnsdA==
X-Google-Smtp-Source: APXvYqwwSyVK4gF4CcA7bCA71s3Meeu4bF8fanQfVeGBRARKcP6A8u2/kAZMQOjisGS1eCs4CLnTf095jgbyTWYSx48=
X-Received: by 2002:a5b:70b:: with SMTP id g11mr14607665ybq.468.1567259713319; 
	Sat, 31 Aug 2019 06:55:13 -0700 (PDT)
MIME-Version: 1.0
From: Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date: Sat, 31 Aug 2019 21:54:58 +0800
Message-ID: <CANnei0G9-0xOc=VqRxPNLQaLmx2sfi+fGNOy1z27JD1e2crtrg@mail.gmail.com>
Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts, In The Search
	of a Substantially Better Life
To: iommu@lists.linux-foundation.org
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

Subject: Singaporean Mr. Teo En Ming's Refugee Seeking Attempts, In
The Search of a Substantially Better Life

In reverse chronological order:

[1] Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday

Photo #1: At the building of the National Immigration Agency, Ministry
of the Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket no. 515 at the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration
Agency, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt (no. 03142) for the
submission of documents/petition from the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019, 10:00 AM

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Blogspot blog)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiwan-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Wordpress blog)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-government-of-taiwan-for-refugee-status/

[2] Application for Refugee Status at the United Nations Refugee
Agency, Bangkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at the
United Nations High Commissioner for Refugees, Bangkok

Link: https://www.youtube.com/watch?v=utpuAa1eUNI

YouTube video Published on March 22nd, 2017

Views as at 31st August 2019: 593

YouTube Channel: Turritopsis Dohrnii Teo En Ming
Subscribers as at 31st August 2019: 2815
Link: https://www.youtube.com/channel/UC__F2hzlqNEEGx-IXxQi3hA






-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
