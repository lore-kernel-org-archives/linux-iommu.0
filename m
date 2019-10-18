Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A656CA9EA1
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 07:00:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6215621925
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 07:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KF9PRB4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6215621925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 029FED80;
	Fri, 18 Oct 2019 07:00:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E2B9CD7F
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 07:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0FF2B7DB
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 07:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1571382016;
	bh=3BZbPmFPPAO7+0U6MgcVQbBO3tWHd1O9cxxtmg54BBM=;
	h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
	b=KF9PRB4bh6OhSMGUuVBTTVSbfH6+Xqh7zqVULVdmSSkL7dXoGdWOr9KZA1KKvd7qZ
	q+pYLPLvJij1xf/k8ZVSY/GMO7Nxtj9x8cn5HZCqYpSK04sgxPj0Gbi5bYkYVRHQXJ
	OzJlIu5KVhXAOfARVnKz2fQeibIkEK6kRT052krA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb004
	[213.165.67.108]) with ESMTPSA (Nemesis) id 0MODW0-1iQsYm1RmG-005Xd9;
	Fri, 18 Oct 2019 09:00:16 +0200
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, =?UTF-8?Q?Heiko_St=c3=bcbner?=
	<heiko@sntech.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: iommu/rockchip: Checking a device_link_add() call in
	rk_iommu_add_device()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
	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
	FEE=
Message-ID: <c4a1fdd2-4383-dd0f-1d4b-f27ab62b383e@web.de>
Date: Fri, 18 Oct 2019 09:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:arHMSO7J7Lbq059QWI4APZnKfleWL2ALjonNGJQWyv0XlvhcHFc
	/wt6BcAF87ZKe+PY5KJhaqIyTCp5zWwqP4wNfPgeDGYwZcPWcDeaOi5OnRmqGjaN3nxVnod
	AG8WTaSiFFUmMvvZbkNKGWJlRvd7DZ+pSkyqyxJqIpZWXi4Luv35Uf9BECan/G7+eka2RiN
	RFhpEmGKfod4TxXorqUmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v7PSuKQXx3Q=:yHmW7GyqR7nk7NlD6LQee3
	OfezZASVPw1AczXasYQKYOhVgq8qFnO7j83I/qnrINkSvN0zdciaoHUadm1Aqc29NNx4ySByk
	Abo4qq8bgggofnaZer1hb6nXytqYK8fK8ThXDMmQXa3OeMyGzwVYs59wmvwrwlKYRBsSJGuc3
	Y1jQOp9OWwDMy5jsqQyhsfaebyladS/tl+665sS63XN6GYkwmq1ZC8DfBT5Jy0T6EOlcLw5nr
	pZm6mxcPDMTmEFCyf6wzX8vC+L3ZFl6kQe4IU9CccKLZS4GCh5dBC03bFjIUdTeXJp5IUHmoM
	JX5emqO9i0PX3aEz42ggkTZGBx14W7jCNWB2TYdDk0QYU2pFN5ewpjAUDEAPV8N2w2ffNA4fN
	OuNthHiZCPp78nbklesi/ygf3U1/I+gDp01+miTWRqnjt+loz9uWv4gz1q1VH30KZlwe99sOz
	NxBv6CnEjDr1clLLwL3sylewyBzJr840Wwc/1nP+ubtdimaXe6WVvWxvSnEOOX98WT4cCnb+p
	shB6mXRioRVeOgnq8KGqvmGYE7hro+yWrAKUESlHBHWKjpIjcdvNNMk0RcIpslVTBeI+RaRoQ
	iQuchPOfUIjxofkMyPlfr0KxBNcEFmjJnKdcJ4V2yDOUUaMnPn3TmBH3IBBBj499AcdO3jvze
	PYLWyTETCj/Mu2lW+lEVL+K21fAMbCOZI0O5puTZYu+R9pi/WRwMoH5ES43C41Hjl61+gu8ER
	mtL68GtBCDIgS4PReRzw+uLUKX5Nzj0OAt+I71MsxnNC5aR9XEUAUIKjXenipEBMVb9BEshSV
	yQtkrlVwkXurjt3EtzdnIUmct8xms1wsJvj9uHOzNQqSGTXkvKhXO7PV5i9M4o6u8JsayGXtn
	eNT43boz5iMWQVOqhyxBCFf6neOVnRW91XUbSnnM/qQbBUnQMoT6PNE7U4LVE8RU8iMzz0OeG
	Q++07KYZzsIdVr4f/U4Cd0zOkL1iqdHpbU86/oAjtXmFsj9VtHysQ9gSiEFmzb324NVQQp/8D
	4fn2QDYgCVSWip4NRTdAWWMNvUsh352Kvv4AiyjvVzdJ82VDWv174Tniu+/mAYAz+lUWz2Q2h
	LYxyD9o4XukNDGRN51fjYaxe+xS4XGzFBI218w6p5tznJ6Yel0ixLAnAYebta5INmOGidzj3x
	fwnItSCzedNRDwnjIbb/0X7XHcjmg77ARJpj6xiq5G4eI/8QLRZkarfJLbi5afxWFFtpEi49o
	zyjB4Jv8wHqI2RL/RNjT9bbN1SNM/enlJv5pwgI4KjGd/ETOptz+uvbClw+g=
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, kernel-janitors@vger.kernel.org,
	Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
	LKML <linux-kernel@vger.kernel.org>, Navid Emamdoost <emamd001@umn.edu>,
	Aditya Pakki <pakki001@umn.edu>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGVsbG8sCgpJIHRyaWVkIGFub3RoZXIgc2NyaXB0IGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFu
Z3VhZ2Ugb3V0LgpUaGlzIHNvdXJjZSBjb2RlIGFuYWx5c2lzIGFwcHJvYWNoIHBvaW50cyBvdXQg
dGhhdCB0aGUgaW1wbGVtZW50YXRpb24Kb2YgdGhlIGZ1bmN0aW9uIOKAnHJrX2lvbW11X2FkZF9k
ZXZpY2XigJ0gY29udGFpbnMgc3RpbGwKYW4gdW5jaGVja2VkIGNhbGwgb2YgdGhlIGZ1bmN0aW9u
IOKAnGRldmljZV9saW5rX2FkZOKAnS4KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC90cmVlL2RyaXZlcnMvaW9tbXUvcm9j
a2NoaXAtaW9tbXUuYz9pZD0zZWY4NDVkYTNjM2IxODBkZGQzODZlMjI4YWMzMjI4ZDg0YTUyMmQz
I24xMDc1Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjQtcmMyL3NvdXJjZS9k
cml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11LmMjTDEwNzEKCkhvdyBkbyB5b3UgdGhpbmsgYWJv
dXQgdG8gaW1wcm92ZSBpdD8KCldoaWNoIGVycm9yIGNvZGUgd291bGQgeW91IGxpa2UgdG8gcmV0
dXJuIGZvciBhIGZhaWxlZApkZXZpY2UgbGluayBhZGRpdGlvbiBhdCB0aGlzIHBsYWNlPwoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
