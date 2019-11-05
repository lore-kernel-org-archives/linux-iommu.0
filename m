Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB91CA9ED9
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 08:02:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7A120869
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 08:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="G15Xd9kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7A120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 30C5D10BB;
	Tue,  5 Nov 2019 08:02:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7C1761075
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 08:02:33 +0000 (UTC)
X-Greylist: delayed 00:05:57 by SQLgrey-1.7.6
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
	[85.215.255.84])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4959227B
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572940950;
	s=strato-dkim-0002; d=xenosoft.de;
	h=In-Reply-To:Date:Message-ID:References:To:From:Subject:
	X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
	bh=lkzbMGkHWur9AlJl2ovp2V95ZZOPOfTo0f2kTkXCsE0=;
	b=G15Xd9kQ2m1lIS1LFU1zi6ayTtNxcQ5LT4yFu3RtAlacdSxyO9mLTxrvlbGKYyyH4W
	aN/wNASVOO36U5cskhc6cpeigy//jS5SvH4t50Job9ntYotd5Df/y65Z0kcFZR+I7X4N
	Ngs39x1O+g+oxSLP5v5gCqZNuBnSibIk4ZiJQqB7j6Wj9X1A1m6ZY5OQBjJfcFz8qmbG
	tU8W+XZJriulpWu7yIMarQ3szaJiMz1oBP/dVzGFAbbamLaxAi46SGKSIOEpu3mUSYJA
	max1NmI8ugahtfcajMlrz75yZTig5AJEKSvKKdrxCtjtVe8YhUcTgVAUSoEjzh10ukTJ
	H3rA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhXL9XuxvA4F2rcIKuJAVhUjF3LQQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:49a6:a8ac:11b0:71e8]
	by smtp.strato.de (RZmta 44.29.0 AUTH)
	with ESMTPSA id q007c8vA57uRiD4
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Tue, 5 Nov 2019 08:56:27 +0100 (CET)
Subject: Bug 205201 - overflow of DMA mask and bus mask
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org, Olof Johansson <olof@lixom.net>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
	<84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
	<20181213091021.GA2106@lst.de>
	<835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
	<76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
	<20181213112511.GA4574@lst.de>
	<e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
	<ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
	<e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
	<008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
	<20190103073622.GA24323@lst.de>
	<71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
	<1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
	<3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
Message-ID: <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
Date: Tue, 5 Nov 2019 08:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
Content-Language: de-DE
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgQWxsLAoKV2Ugc3RpbGwgaGF2ZSBETUEgcHJvYmxlbXMgd2l0aCBzb21lIFBDSSBkZXZpY2Vz
LiBTaW5jZSB0aGUgUG93ZXJQQyAKdXBkYXRlcyA0LjIxLTEgWzFdIHdlIG5lZWQgdG8gZGVjcmVh
c2UgdGhlIFJBTSB0byAzNTAwTUIgKG1lbT0zNTAwTSkgaWYgCndlIHdhbnQgdG8gd29yayB3aXRo
IG91ciBQQ0kgZGV2aWNlcy4gVGhlIEZTTCBQNTAyMCBhbmQgUDUwNDAgaGF2ZSB0aGVzZSAKcHJv
YmxlbXMgY3VycmVudGx5LgoKRXJyb3IgbWVzc2FnZToKClvCoMKgIDI1LjY1NDg1Ml0gYnR0diAx
MDAwOjA0OjA1LjA6IG92ZXJmbG93IDB4MDAwMDAwMDBmZTA3NzAwMCs0MDk2IG9mIApETUEgbWFz
ayBmZmZmZmZmZiBidXMgbWFzayBkZjAwMDAwMAoKQWxsIDUueCBMaW51eCBrZXJuZWxzIGNhbid0
IGluaXRpYWxpemUgYSBTQ1NJIFBDSSBjYXJkIGFueW1vcmUgc28gCmJvb3Rpbmcgb2YgYSBMaW51
eCB1c2VybGFuZCBpc24ndCBwb3NzaWJsZS4KClBMRUFTRSBjaGVjayB0aGUgRE1BIGNoYW5nZXMg
aW4gdGhlIFBvd2VyUEMgdXBkYXRlcyA0LjIxLTEgWzFdLiBUaGUgCmtlcm5lbCA0LjIwIHdvcmtz
IHdpdGggYWxsIFBDSSBkZXZpY2VzIHdpdGhvdXQgbGltaXRhdGlvbiBvZiBSQU0uCgpXZSBjcmVh
dGVkIGEgYnVnIHJlcG9ydCBhIG1vbnRoIGFnby4gWzJdCgpUaGFua3MsCkNocmlzdGlhbgoKWzFd
IApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvY29tbWl0Lz9pZD04ZDY5NzMzMjdlZTg0YzJmNDBkZDllZmQ4OTI4ZDRhMTE4
NmM5NmUyClsyXSBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIw
NTIwMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
