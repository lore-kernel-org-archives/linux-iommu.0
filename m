Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B8C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 07:06:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8B220734
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 07:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qyHztjWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8B220734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4022721549;
	Tue,  2 Jun 2020 07:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gt-EsmqfD2AW; Tue,  2 Jun 2020 07:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CF4C320014;
	Tue,  2 Jun 2020 07:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5345C0865;
	Tue,  2 Jun 2020 07:06:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84128C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 729FD87818
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wh6ZB+a5xwhM for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 07:06:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB7F78739E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 07:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591081573;
 bh=3Bmo/FstVjMESOqr4jH3BM6qBvz/63iqicZxdkKFNGE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=qyHztjWrawclVP5TU0teVaC5QGxpVWb2g6+NKiL9/IJ68u4ALeAq0OAYIXHDaegb7
 d+USuaSnKKWEYUE+xaUr2Yt6cuIzmqJ4b4PMqHUL5MnKNKqaDRy7nbzi/h7ZQZ7kxN
 CbrHXYnN/TegSSr0B15wTVHVZiNfq7Zq3IvQRVXE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lecda-1jCfj12P5q-00qRoz; Tue, 02
 Jun 2020 09:06:13 +0200
Subject: Re: iommu: Improve exception handling in iommu_group_alloc()
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 iommu@lists.linux-foundation.org
References: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
 <20200602015044.GA89266@VM20190228-100.tbsite.net>
 <b31fbcd1-b5f8-992b-a994-2a950ab36b61@web.de>
 <20200602055639.GB89266@VM20190228-100.tbsite.net>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44b4a048-ef36-f75b-5869-22e5fe4b15d2@web.de>
Date: Tue, 2 Jun 2020 09:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602055639.GB89266@VM20190228-100.tbsite.net>
Content-Language: en-GB
X-Provags-ID: V03:K1:eMosH1UTbBDIg78NfuZoHK77msPCbizRxnTp/nSwYuEzfDGJ/fO
 s4PNQOqsra3BrHoLzV5UoPaHYfjWhz6V1oPiAicIFfn5b5ymE/00p5hrvDqZEhPz6nBdaBE
 qAtzbu+inpc80YtSct0V39rUTGi69f8VXRSCtyQtU6PtbVYP595EpZxQuJbpSeT2PXbTfFG
 iLlKYw7Ry4apdO0bT0e2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H8Xw11KU2Kc=:WpWb356sHDumiusM8R6Jry
 1D/cPIxGr+akDkEvm/EIHJ/o0cQZnlP0Ndgaw6u1I3gg+oe1doeU/KQ+1NSwWIs7bq0h7Ansq
 fnS91RU1rjbgl51e8iKT59mEtO3LIUJ6j7cnZ/DWQideKoMUWqUyAyZKAr2E4Y6sfKyTbKV/4
 ZoFIPp44I4YwZSRYVQk1DXGb4mvMiWHTWSjWPIAgj3Fo5VJmbMRIgOSnOOHYETWZrKnnKinjw
 IIaFoN0lwQ308fg8PIWhiMTiV6mXJ8aifouBPUaQcSSVn9KuReH2c9+TI/B6Mtc02ZWlVFK/j
 Bd2b2BFEwg8kerTdxkNRJrC48T14Sxs02I14w+MrbJSGpK/aPuuak475JOQBb6etqE0HEWhqr
 PdHCgPDoNOuowdlFTMgDj54cEkPvXGymYC1bvvGbfN8Lf+bE6lLl5jqxRxG9jh0uzVeSOooxw
 f8cxXOxlCGKevT0xGnUTlVLsXF8O3E7dCwDSH60BRPNLlNNLXbLxQmMXUwLRlrWJjopBa9lDj
 UBzhxPi8lrHLIqhnjwd7SdecFMIKAnrhYR9zNbIwddxPIoX8S1YYQy6iCblMtfkfL/RZpCW07
 Xd3msDzRJ0pvAQM4Fn5MdN2hpxSzA2fQNqqmFfUhe/J0V0ZtOuSjtts6f8CLSZyw2mjdChbCe
 2TAZCOTRm5Ag8clx58NxUDYPeRMyzetzw0pEii4QvJ0L5zlwzbxx7+gPI3qyLfPcHMKybL+/9
 /dWjq6ZXMWuw2soclLil9Rpx+PQ8FG58qhvwPV40SLYzQppaXzttzoFYBi4sf3+PdZTAURnOD
 m7gjCMEadNTife8bNZksc9S4vALbkaRo/l3YJLq4CSlhSeqPwg2jjLTu+uGZNzPlOPfsXlD9C
 Zt/bjLmvIkkj/XUAeb7hE9REWHqZAGE3EZbYM7znP9PjHJyeGbcKJDWV0yTGJKE7MG9PmGMOQ
 OXc6fYa79nU545rZfTvnNUQDWkS76mvXe1zr6DtYEy6bo/A7niqhl33A8O45LwzCmopol4yoZ
 fvUm96qCX4Upy50KuiUgXrOGj6wP/c/gb5/Z0slNG+/P7TssGscLLGpRSiJonq4E5BWdVaqj8
 KgCl61zeubhdHRYBS/LmE9vQLgJBpn4K4w5M/DV6Ww6qMPSOCJWQlYkUtllXcn6uFrRD75fGM
 hVHgVeHYj6doIZ2oNUsn2BGwCKn62BkxDF7Ly9Gmn8CUrQQPJl5juo4Q+gOlcp+udzzXRBuVB
 C0ttB/0bpcKhucMDA
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Pj4gRG8geW91IGRpc2FncmVlIHRvIHRoZSBhcHBsaWNhdGlvbiBvZiB0aGUgTGludXggY29kaW5n
IHN0eWxlIHRoZW4KPj4gZm9yIHRoZSByZWNvbW1lbmRlZCBleGNlcHRpb24gaGFuZGxpbmc/Cj4K
PiBObywgdGhhdCdzIG5vdCB3aGF0IEkgbWVhbi4gTXkgcG9pbnQgaXMgdGhlIGV4Y2VwdGlvbiBo
YW5kbGluZyBpbiB0aGlzCj4gcGF0Y2ggaXMgc2ltcGxlIGFuZCBubyBuZWVkIHRvIGFkZCAnZ290
bycgc3RhdGVtZW50IHdoaWNoIGRvZXMgbm90IGhlbHAKPiB0byBpbXByb3ZlIHJlYWRhYmlsaXR5
LgoKRG8gd2UgY29tZSBhbG9uZyBkaWZmZXJlbnQgcHJvZ3JhbW1pbmcgaW1hZ2luYXRpb25zPwoK
Cj4gQW5kIEkgYWdyZWUgaXQgaXMgaGVscGZ1bCBmb3IgdGhlIGNhc2VzIHdoZXJlIGEgZnVuY3Rp
b24gZXhpdHMgZnJvbSBtdWx0aXBsZSBsb2NhdGlvbnMKPiBhbmQgbW9yZSBzYW1lIGNsZWFudXAg
d29yayBuZWVkIHRvIGRvLgoKQ2FuIHRoaXMgdmlldyBmaXQgYWxzbyB0byBjYWxscyBvZiB0aGUg
ZnVuY3Rpb24g4oCca29iamVjdF9wdXTigJ0/Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNo
d29yay9wYXRjaC8xMjUxMzI2LwpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS84
YmZkMDE4ZWY0YWRkMDgzYTM1YTZhOTRhOGRhMDQ1Y2YzYWY1MWI2LjE1OTEwNjMyNzEuZ2l0LmJh
b2xpbi53YW5nQGxpbnV4LmFsaWJhYmEuY29tLwpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2lvbW11
L2lvbW11LmM/aWQ9N2NjMzE2MTM3MzRjNDg3MGFlMzJmNTI2NWQ1NzZlZjI5NjYyMTM0MyNuNDc4
Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1Ljcvc291cmNlL2RyaXZlcnMvaW9t
bXUvaW9tbXUuYyNMNDc4CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
