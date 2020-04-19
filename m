Return-Path: <SRS0=y66L=6D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4BCC38A30
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 13:10:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A4A22247
	for <iommu@archiver.kernel.org>; Sun, 19 Apr 2020 13:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Uu0sq4Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A4A22247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 46BAA87525;
	Sun, 19 Apr 2020 13:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zWsxShKh4Nts; Sun, 19 Apr 2020 13:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2ECF081EBC;
	Sun, 19 Apr 2020 13:10:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B600C1D7E;
	Sun, 19 Apr 2020 13:10:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C20F5C0177
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 13:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B04CD85361
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 13:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id klLa1u02meCq for <iommu@lists.linux-foundation.org>;
 Sun, 19 Apr 2020 13:10:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 946DF8535F
 for <iommu@lists.linux-foundation.org>; Sun, 19 Apr 2020 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587301835;
 bh=4oYS+cYKZQPqayi2RhTLLU5txfFXZV6+2Fd5/sGAsQU=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=Uu0sq4DtAPDVTCgJ9WqHiPgBHd2Oi/cHMeCerwQ/eeaE975R4sz5wZhTpnI8Uqy0Z
 CAFAGJp1UTswDU6oDEzcfnruPCz5zCe9rrmbk8S6S1Plq7c6Qf/IuGCAr65PU/tZl3
 WQmi0d75aBYmjpCJ7GBxqplFcGIE4t6enyS/Yzvg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWAwH-1jkCcF42dV-00XH53; Sun, 19
 Apr 2020 15:10:35 +0200
Subject: Re: [PATCH v2] iommu/qcom: Fix local_base status check
From: Markus Elfring <Markus.Elfring@web.de>
To: Tang Bin <tangbin@cmss.chinamobile.com>,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>
References: <73736017-cae3-1c2a-dcf4-d771d0f3bbbf@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b07d3b02-bf96-fd73-8333-a1104da9ae47@web.de>
Date: Sun, 19 Apr 2020 15:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <73736017-cae3-1c2a-dcf4-d771d0f3bbbf@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:csvZDhaz4z/yZURfSdj4uatoN5JobxslgnDWP5IBxiUdVCF5P5L
 ErUP3aEhDKRvkvI0W5p/UlEAj0rYAkeYiydJVgRWD0r9G+hGdRnodq86bkiKFTGxzhD6gSj
 pHrmlB5ryh9ibKQN+RHlS++X/pcKSdWPZEhw7ilC6gFlwKXzdfiOJIc49wbhuJK2zspdIuZ
 qzQYBsqiGNlKkLgtxQRPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YP5tX25VIBU=:MbOSbvZbuDSo89A1cbzHeO
 JWHwRkc3GSnQ8758M2xMrm2LEep79GLVIHpXGaHXPXMNw86ZQFNw7wMcCzJxhYffml32FcbhP
 CpqfPD0On3BApJ0Jf7SfHqJ+AVdbmGyEPZWZ0WJapSgpknXoh5o7k5zmSy3m2mO58Ic9u9y6D
 rmZQRsfP37ysXWjwBBBG0Dr4RB1NqZMoXCGVW0gIGgCYoUCZoSuy1/uaFfSluANXeGBl1Z3PG
 NvoeRrFcegkhCEOCKnU5l0N3B9QLfA4HoM/xA5qwykWqciRkd6RdAxiUYpnQU7/Ox1kl2jXcz
 Ur1WXBhvWPOBKXDdRKzMD2F0iCajnhPceE+P3OaVV1rJD7ujvwUqw4eJgtW/+BZPYAwycBVNJ
 OFDCo0G+NmIOqmgA1Rf7qo+PJCqdToud3tmqvemrjEE2hwZ/rIYG9n87/YxxvIDYH1JzViuaX
 DqJEt1oaDtAD0b8UUUM6AwVuERNGxOCBeQrR6uU8SfSph+3RKdvuLPnKxbgq3qz++WpfkCJI4
 qF9meDyaUIkNjTs7eZpjGJWoQNFNvMJ1pI/q5gduZKztXrXP+MGU4QCK4y/PgCsGiLcwSYkI4
 IP1hEg1RcrePU8eBmx6DF3RRwhW9Mlmw5qFCgpUbWKvEKjYjXAIgkvAzwf8jfS/wRsyvK6FQt
 TdnGD9sF3Dl6f4chUzf9i2d4CJswCXw2ISZWsVGKhHzt/zWGNqIhMTrVTn4eQSVlQqm2AErHK
 TWx7nV9o2Lprpc6vWDevZSrUjwYt5gHZJhd4jT0qnPFJuzaC5IEdFJJcXFE5QhBpuwzy1Z9mm
 KZtBcTlPDm2gpwuJLsTIRMKzpyv0QrZb1+3ZCYV4C215CBYI7X7dUN/JU9NhqdGi5YSDO50lA
 ZNAi7GXbxa5p2fIxGF69g50ISNK4718orUHdPl6a5yvTXjZGlRGZGDHHOGSr6L7kDS1ar1i8p
 iGlCcTMQOhYhS1L1rMG1Rx2yhnf7I/xGu3D60ONfNue+Pi47ETKscGZMSlvJjFaCisU9bFe4M
 SKPg5xJQSEGSEUpQv3cBeH7xv07y5AhiOxVyjBW7ZoGLII7n/cSoPiC2HHsY2SwE8sNBevymO
 dE5BtMe9vZU4w3QIti7qhbRxMinenU2sTbgPYpGPSithcHfKxwXtu68FINbxEdBHxrVWy/eO+
 HwKXDhOjAa8s+/QYHh0Mn9+rhcz0gp5p9hMNDdToKLkIm/jeiUZmDs8jwsAFyf3s3ON/0RW0y
 MyLPcV62MtucsrWHT
Cc: Dejin Zheng <zhengdejin5@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

PiDigKYKPj4gKysrIGIvZHJpdmVycy9pb21tdS9xY29tX2lvbW11LmMKPj4gQEAgLTgxMyw4ICs4
MTMsMTEgQEAgc3RhdGljIGludCBxY29tX2lvbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQo+PiAgCXFjb21faW9tbXUtPmRldiA9IGRldjsKPj4KPj4gIAlyZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOwrigKYKPj4g
IAkJcWNvbV9pb21tdS0+bG9jYWxfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJl
cyk7CuKApgo+IFBsZWFzZSB0YWtlIGFub3RoZXIgbG9vayBhdCBhIGNvcnJlc3BvbmRpbmcgdXNh
Z2UgZXhhbXBsZS4KCkkgd291bGQgbGlrZSB0byBwb2ludCBhbm90aGVyIHBvc3NpYmlsaXR5IG91
dCBmb3IgZGVzaXJhYmxlIHNvZnR3YXJlIGV2b2x1dGlvbi4KSG93IGRvIHlvdSB0aGluayBhYm91
dCB0byBjYWxsIGEg4oCca25vd27igJ0gd3JhcHBlciBmdW5jdGlvbiBpbnN0ZWFkPwoKZGV2bV9w
bGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UKaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjUuNy1yYzEvc291cmNlL2RyaXZlcnMvYmFzZS9wbGF0Zm9ybS5jI0w2NgpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvbG9nL2RyaXZlcnMvYmFzZS9wbGF0Zm9ybS5jCgpSZWdhcmRzLApNYXJrdXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
