Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4128C3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 16:34:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8148E20665
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 16:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148E20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mni.thm.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A730C90;
	Fri, 16 Aug 2019 16:34:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 108F8C91
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 16:27:31 +0000 (UTC)
X-Greylist: delayed 00:18:59 by SQLgrey-1.7.6
Received: from mout2.fh-giessen.de (mout2.fh-giessen.de [212.201.18.46])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 81E998A6
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 16:27:30 +0000 (UTC)
Received: from mx2.fh-giessen.de ([212.201.18.41])
	by mout2.fh-giessen.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hyemB-0003t1-8u; Fri, 16 Aug 2019 18:08:27 +0200
Received: from mailgate-2.its.fh-giessen.de ([212.201.18.14])
	by mx2.fh-giessen.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hyemB-006LjD-4G; Fri, 16 Aug 2019 18:08:27 +0200
Received: from p2e561b42.dip0.t-ipconnect.de ([46.86.27.66]
	helo=[192.168.1.24]) by mailgate-2.its.fh-giessen.de with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hyemA-000UF7-Qz; Fri, 16 Aug 2019 18:08:26 +0200
To: kvalo@codeaurora.org, davem@davemloft.net, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux-foundation.org
From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: regression in ath10k dma allocation
Message-ID: <8fe8b415-2d34-0a14-170b-dcb31c162e67@mni.thm.de>
Date: Fri, 16 Aug 2019 18:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101
	Thunderbird/70.0a1
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Fri, 16 Aug 2019 16:34:52 +0000
Cc: tobias.klausmann@freenet.de
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

SGVsbG8gYWxsLAoKd2l0aGluIHRoZSBjdXJyZW50IGRldmVsb3BtZW50IGN5Y2xlIGkgbm90ZWQg
dGhlIGF0aDEwayBkcml2ZXIgZmFpbGluZyAKdG8gc2V0dXA6CgpbwqDCoMKgIDMuMTg1NjYwXSBh
dGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIGFsbG9jIENFIGRlc3QgcmluZyAxOiAt
MTIKW8KgwqDCoCAzLjE4NTY2NF0gYXRoMTBrX3BjaSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byBh
bGxvY2F0ZSBjb3B5IGVuZ2luZSAKcGlwZSAxOiAtMTIKW8KgwqDCoCAzLjE4NTY2N10gYXRoMTBr
X3BjaSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byBhbGxvY2F0ZSBjb3B5IGVuZ2luZSAKcGlwZXM6
IC0xMgpbwqDCoMKgIDMuMTg1NjY5XSBhdGgxMGtfcGNpIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRv
IHNldHVwIHJlc291cmNlOiAtMTIKW8KgwqDCoCAzLjE4NTY5Ml0gYXRoMTBrX3BjaTogcHJvYmUg
b2YgMDAwMDowMjowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0xMgoKdGhlIGFjdHVhbCBmYWlsdXJl
IGNvbWVzIGZyb20gWzFdIGFuZCBpbmRlZWQgYmlzZWN0aW5nIGJyb3VnaHQgbWUgdG8gYSAKcmVs
YXRlZCBjb21taXQgImRtYS1jb250aWd1b3VzOiBhZGQgZG1hX3thbGxvYyxmcmVlfV9jb250aWd1
b3VzKCkgCmhlbHBlcnMiIFsyXS4gUmV2ZXJ0aW5nIHRoZSBjb21taXQgZml4ZXMgdGhlIHByb2Js
ZW0sIHlldCB0aGlzIG1pZ2h0IApqdXN0IGJlIHRoZSBkcml2ZXIgYWJ1c2luZyB0aGUgZG1hIGlu
ZnJhc3RydWN0dXJlLCBzbyBob3BlZnVsbHkgc29tZW9uZSAKY2FuIGhhdmUgYSBsb29rIGF0IGl0
LCBhcyBpJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIGNvZGUhCgoKWzFdOiAKaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3Ry
ZWUvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEway9jZS5jP2g9djUuMy1yYzQjbjE2NTAK
ClsyXTogCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWIxZDJkYzAwOWRlY2U0Y2Q3ZTYyOTQxOWI1MjI2
NmJhNTE5NjBhNmIKCgpHcmVldGluZ3MsCgpUb2JpYXMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
