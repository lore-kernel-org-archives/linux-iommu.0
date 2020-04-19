Return-Path: <SRS0=y66L=6D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C1C38A30
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F08214D8
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 12:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hwUT37Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F08214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 718DE8614D;
	Sun, 19 Apr 2020 12:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlJYxlzXUkj8; Sun, 19 Apr 2020 12:32:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D186857A4;
	Sun, 19 Apr 2020 12:32:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3EEC07FF;
	Sun, 19 Apr 2020 12:32:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A57B9C0177
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 12:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73FE4203BD
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 12:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CaTBvBdzr61V for <iommu@lists.linux-foundation.org>;
 Sun, 19 Apr 2020 12:32:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by silver.osuosl.org (Postfix) with ESMTPS id E46CE20035
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587299542;
 bh=Ony+WtCvlJwCqxG8+ifcy1TdD6Z04JNAUahBHfvqML0=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=hwUT37ZyJ1NZa2m+oW4WilqNetQKZGbV3Lpon+oHOpiD0cHy8nFjrsWvi9c19zQ6l
 EaFrBCgqQvsEYPNweB8cxUDLdOgMwQ86YFhlE0mJsLyntvJKTtB8wJRIC8f8g3e0ea
 85DnTNWN4s0RdTAKRNhHlgNG9RGYRo3g9/klrxCg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrryk-1jEhom2LNO-013aGB; Sun, 19
 Apr 2020 14:32:22 +0200
To: Tang Bin <tangbin@cmss.chinamobile.com>,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2] iommu/qcom: Fix local_base status check
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <73736017-cae3-1c2a-dcf4-d771d0f3bbbf@web.de>
Date: Sun, 19 Apr 2020 14:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:aM9D41FDFG533iB8w4muwOHig3soCihnk6pAK/NdvHKorniyPir
 iyQlK51/Kfk4yD8O+bwuZeovMtlA7rs/2WH5M9OlWqRCCbgeKVEQESYq+3M+0690hF18C9c
 qqkiLrbft/PoMxtRn19FtmatjUFPexga8qEjY5CKq5LZ8kAUPGaIK2AimKjj2+SPDwUaUYx
 coVSg/uQkvT05B1rJSviw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YfONjDXL5x0=:3wx3LPQ+RgsxVKYkWsZgwg
 3QgRYFxbV80SPNOpnRpsERd9bDi5bH8kHBZCZkpbGbIC/BoxJnxEOraXfCbUOj0R3LwhlYzCX
 Do2unHX8eqH2+utRbDs/WJKxbMeaDr7vodPvcV1vE0CRInXUQpJ3vVIsN8eQfXYtQdZoEGmjI
 nLSRsA1RYbAiFLLhIdngkurSmm9wMynXWZtfBwka03y1m7LuKAA/9NZHvpjJUtKeg0LYQbt5P
 q48+tvmOxxHPYPt/XpgsbYI0GfC543CZU8vHxA1RGbsw6C5iswVCGo8TzHs/mlHca3rkpJuv8
 fDNIAIRuzONIdxTXgESaYpXySEB/Fwm7WOhmsxz6QpAb5Ilr4arWLIhJjLmfHHVIjdOntECwZ
 Z6bxDkZAkt0WMoCcCO1n0gS5T76xJg1zED1G7VvgrhwMaTyOQocFTuXnsrGQ4jc+EQjdwu2Ab
 NW6ZCfu46ZFScj0Y9OPll8D5M+frIcC9HQBUUIP0SvNJFL7me/2sAKqvUa70MuNv6UqmODtJ2
 9fykdEdMNBvbM5ARFWsVerWcmdAWBzttswdw/Ejf72qNCiGEs4JP5jKRmq4a5zgUcDD9NHFPN
 N/Sl4E5plJ3cQXqoIyPhPZYuCtK3M769oYby+9vSQVIUhV5P+NdKZFXfYLaQ1SqrjUmQPKEmf
 +FSaukDfxfphjYxlSph3uJvAPTLYKbGsGIiCVHAaZ7LL3v/owPeTEN2to7wcFwd2etQsx1Qv6
 GJ+Ll3HnvqaWd+9twFGS9KcvKBr5Mr+y28HPIQsxot5lQdpGGMJ4Q9/OQC1LgNrN0EnmeIilU
 MQPhjXP96P4LnWLX0fGDkm5om31eApBqjHUcB0QOBl7ZKSDrk4VbM6jhUjv1tlfzJqJwB/sSD
 v0M9BqgZtIMGnC7fbyPn+VCu7vdfoBjcZqR3ExO0IhXmXZQSGat2etii1b0uC9vC1NimX7KK2
 //PazBLnUjlfHQBHihX2hGJwZ36CVzYty2NJGtdplii/sIg/gghw56RW8SWjDuQYhLErW5njH
 N7OIGMQKf8y7xDLDImFe+EIPBaGT8BtpzUawYujG5dO1Ff9YjGP2JbTqPgONIYMBT/xMe/mxj
 ZYHAqrPlxau0VRLD285o5eYf9vLm1ei4Kf/e024S5cNebqS7RYpC/GTFgdc1x498hLbGJTFjF
 sDZZpCAfsD/R75venw8Ue0HMZWOey3VZwrL2ZGdJjJGo8QB/wfh0Q6FAON8+OWNsMV2mIdRc1
 8pqehv5/i1X/1uGGK
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

PiBUaGUgZnVuY3Rpb24gcWNvbV9pb21tdV9kZXZpY2VfcHJvYmUoKSBkb2VzIG5vdCBwZXJmb3Jt
IHN1ZmZpY2llbnQKPiBlcnJvciBjaGVja2luZyBhZnRlciBleGVjdXRpbmcgZGV2bV9pb3JlbWFw
X3Jlc291cmNlKCksIHdoaWNoIGNhbgo+IHJlc3VsdCBpbiBjcmFzaGVzIGlmIGEgY3JpdGljYWwg
ZXJyb3IgcGF0aCBpcyBlbmNvdW50ZXJlZC4KCllvdXIgdXBkYXRlIHN1Z2dlc3Rpb24gd2lsbCBi
ZSByZWNoZWNrZWQgb25jZSBtb3JlLgoKKiBDYW4gaXQgYmUgdGhhdCB0aGUgcGF0Y2ggd291bGQg
bmVlZCBhIGhpZ2hlciB2ZXJzaW9uIG51bWJlcgogIGFjY29yZGluZyB0byBwcmV2aW91cyByZXZp
ZXcgY29tbWVudHM/CgoqIFdvdWxkIHlvdSBsaWtlIHRvIGFkanVzdCB0aGUgcGF0Y2ggc3ViamVj
dD8KCgrigKYKPiArKysgYi9kcml2ZXJzL2lvbW11L3Fjb21faW9tbXUuYwo+IEBAIC04MTMsOCAr
ODEzLDExIEBAIHN0YXRpYyBpbnQgcWNvbV9pb21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPiAgCXFjb21faW9tbXUtPmRldiA9IGRldjsKPgo+ICAJcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKPiAtCWlmIChy
ZXMpCgpJIGZpbmQgdGhlIGRlbGV0aW9uIG9mIHRoaXMgY2hlY2sgYXBwcm9wcmlhdGUuCgoKPiAr
CWlmIChyZXMpIHsKPiAgCQlxY29tX2lvbW11LT5sb2NhbF9iYXNlID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgcmVzKTsKCkJ1dCBJIGRvIG5vdCBzZWUgYSBuZWVkIHRvIHByZXNlcnZlIHN1
Y2ggYSBjaGVjayBiZWNhdXNlIHRoaXMgZnVuY3Rpb24KcGVyZm9ybXMgaW5wdXQgcGFyYW1ldGVy
IHZhbGlkYXRpb24uCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjctcmMxL3Nv
dXJjZS9saWIvZGV2cmVzLmMjTDExNgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9saWIvZGV2cmVzLmM/aWQ9NTBj
YzA5YzE4OTg1ZWFjYmJkNjY2YWNmZDdiZTIzOTEzOTQ3MzNmNSNuMTE2CgpQbGVhc2UgdGFrZSBh
bm90aGVyIGxvb2sgYXQgYSBjb3JyZXNwb25kaW5nIHVzYWdlIGV4YW1wbGUuCgpSZWdhcmRzLApN
YXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
