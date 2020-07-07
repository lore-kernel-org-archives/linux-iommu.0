Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25EDC433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C71A20739
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="A1FsX9GT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C71A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 74DAC88144;
	Tue,  7 Jul 2020 06:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SC+E10ZzBH59; Tue,  7 Jul 2020 06:05:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3ED188391;
	Tue,  7 Jul 2020 06:05:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE0E2C0893;
	Tue,  7 Jul 2020 06:05:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05FA2C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 766838814A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5hkp0ziFmKWw for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 06:05:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E6C0A88134
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1594101902;
 bh=8JM2O9jcHjAbFpQBOjma2wnTkbwYl3IQhMDrSrqvnYI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=A1FsX9GT90we5fowiGnbvuZJCLBoyb7X4dQZDgWQkxrbNNJzRxxUi/ItvwYqIjwGt
 5HoUVjfSTB9NcS9KBmFTV4571CPOfV7CQ618Jm0dWAcuDiBZFeY+betbFdhWhRSPQs
 iMiiusLwCY/6IRxxb9J4voalZkA5cU6him+maxAs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.121.241]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqkB-1k2LmA39jn-009eyu; Tue, 07
 Jul 2020 08:05:01 +0200
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
To: Hillf Danton <hdanton@sina.com>, iommu@lists.linux-foundation.org
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
 <20200707011420.1416-1-hdanton@sina.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f29f7008-6489-0db3-86b3-5f83f5ed7770@web.de>
Date: Tue, 7 Jul 2020 08:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707011420.1416-1-hdanton@sina.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:FjEVrQWL2QA5e4X0aVFByqrubBufrf7DYh3N3MlILuX7K7HSyMz
 U1kbCSZuNLw3tmincyjBqV8H+D3Z9Xst0EU/762LG04H/pOmEpOPI6pyW31RZQmcmpOtvWu
 eHL2O4w5hEjIckphsLdgWszNCHuqOznsDh7pubtDRZFy1OYYHu9ONqRJiIy0VbZTYxPZCkG
 t65wGHu5PXBjx9brtccgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RuTW5/5Es3w=:/gvupHiTAIkF9FbZ9XFiys
 A+VYE5eipB8Ccvhww8ybH852MiOD5JjN5frTKbFEz3sP1Oy4EsORIuLUI0TatBQV90YDjll4O
 5LQ9y7CzcPvUTkjFFsHbyB9dN+Pb41mVgSv4J00+2mlUCjoeYe4VNg68pwOQixhl3kOWbQURp
 RlHwraH8PBBrH/VO8pL15GlBTlxoSwkl0Ltm3FVgqiIMEoPx6gB0GI/GhXqY696oWLlw8f28z
 b4v8g8MMj4PrI1bUgWRrFNz9zTLr/WMGfhTXJPGjzOUhjqIuEdMYmqGmk5+S5A2RgkVUBqufU
 izJzYgQfpDvrcn1oZbwtTpwgjC8+bx6K9otplZkTATwjQhZgAYLU/OEPRQuMdQapcZMbaoNnl
 YO9OlMduNTbkFIjoH35p4iZH2d1jmi2A55rU5whZZ5SvPFXTLAdn9O41JI90tU/872zjU6Aim
 tQPgTQUG1LQLN0djJktTGSzpMI9JMVKzWLB/RiXCF8hNjPpM4YRRLqBRVyPdFAPeBOKdzaNZ9
 WA5Othv4GZax0FiP2hKx+kjjhh/zgHjhHZVu980wmLbIQFjzdF9Qi/qRsXYCJxxbqz6ttYEGO
 RlP79RUenZGMKk3ezQcF0aZLvCynoYLNbj0WF9u37J5WS3Q9p9+3Icgo+ZjfpWDcpShNXn865
 AAw7XVcsZRF+p7m121TsJsdONZl8dRJJUzBd9l0Dqc+Og9PZM/dEyHuHgWKqoR2vICInnIgXh
 7mtETRcJlRjx6hIbBmV2GjhFLhfMsCcx4oV1RFkDwaM9d6GEBlz9RW5MV780GKTe+u0S/sqED
 4Tg9ps9bJtiyv750Qm0a6Evz3Rh1ozVtFKEWl83T8nNiLdT28r3SeF++p1HWCqXePN7nwnL73
 q898y+UWBqV0dr6gRUtKUy/F3UT0+6N8hUdlKSnyatMn6JSs59n2WUgAgTeJaE7r5P+sswdFv
 XaavkJC17ihYgBukuqkpi4RlQbF96aviQrrHM7CPYimBTlpX9D/G4eh7/iHRIXO0rMQhAN2Q0
 dFyot2H/tGSZPD64lr4mQa8lywopZlPArXvk6+sTmGJ2dMw27VyZ6xB0qY3wBKLaINepwWMwQ
 MS/Lv5pYv2fCWC3xc18AjZlu+YjnrqDDotgDMRAMiuwagXJGaS0yl8HdTo9toQQDPkiyN4sfz
 1Wd2RPTXmUqer3NsMT3vv0fmcS98fOGrX7bdZmJa4Y22nj23xzxjUwMGEXtFPhcNWTarFM+Yg
 55Y6BT+D1DvrqWnSr19yI1FhsK4+vVMcNc0Y33g==
Cc: Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Christoph Hellwig <hch@lst.de>
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

4oCmCj4gKysrIGIvZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYwo+IEBAIC0yNzk4LDcg
KzI3OTgsNyBAQCBzdGF0aWMgaW50IHZmaW9faW9tbXVfdHlwZTFfZG1hX3J3X2NodW5rCuKApgo+
IC0JYm9vbCBrdGhyZWFkID0gY3VycmVudC0+bW0gPT0gTlVMTDsKPiArCWJvb2wga3RocmVhZF9s
b2FkX21tOwo+ICAJc2l6ZV90IG9mZnNldDsKCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gcmVk
dWNlIHRoZSBzY29wZSBmb3Igc3VjaCB2YXJpYWJsZXM/Cmh0dHBzOi8vcmVmYWN0b3JpbmcuY29t
L2NhdGFsb2cvcmVkdWNlU2NvcGVPZlZhcmlhYmxlLmh0bWwKCgrigKYKPiBAQCAtMjgxMiwxMSAr
MjgxMiwxMiBAQCBzdGF0aWMgaW50IHZmaW9faW9tbXVfdHlwZTFfZG1hX3J3X2NodW5rCuKApgo+
ICAJaWYgKCFtbSkKPiAgCQlyZXR1cm4gLUVQRVJNOwrigKYKPiArCWt0aHJlYWRfbG9hZF9tbSA9
IGN1cnJlbnQtPmZsYWdzICYgUEZfS1RIUkVBRCAmJgo+ICsJCQkJY3VycmVudC0+bW0gPT0gTlVM
TDsK4oCmCgpXb3VsZCB5b3UgbGlrZSB0byBhcHBseSBhIG1vcmUgc3VjY2luY3QgY29kZSB2YXJp
YW50PwoKKwlrdGhyZWFkX2xvYWRfbW0gPSBjdXJyZW50LT5mbGFncyAmIFBGX0tUSFJFQUQgJiYg
IWN1cnJlbnQtPm1tOwoKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
