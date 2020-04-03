Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCCEC43331
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 17:21:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3B0206F5
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VOphlUdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3B0206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BADC87004;
	Fri,  3 Apr 2020 17:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9J3JnCqckBnP; Fri,  3 Apr 2020 17:21:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7294786F66;
	Fri,  3 Apr 2020 17:21:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6075BC1831;
	Fri,  3 Apr 2020 17:21:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7253AC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 17:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FE5088329
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 17:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2nyJ4i9zEpp for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 17:21:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2B8BB8831F
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585934437;
 bh=F9+0iNVN/a+RVMnBnJdNBU74AYqMy21kwnfqkkiNbBE=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=VOphlUdXZfNgudGMpAMjysIP8EgolgN1sg8RY2Yt4FE1d7YfWPhIQJRIDoXRxorkw
 QUrjRJGLSdxT0dbOJXIvHY077oMlas9lpIS/15JxDqgamHaBg2K4K0xeXOuSi0vRup
 siaXuqXNWGZC5DRA2YVsB8eQVa7wh19HU1XSGSjQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOlTq-1jN9ox2PNm-0068Li; Fri, 03
 Apr 2020 19:20:37 +0200
To: Tang Bin <tangbin@cmss.chinamobile.com>,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2] iommu/qcom: Fix local_base status check
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <084eb9b2-3f5f-4e87-08aa-fe57ed3f5d35@web.de>
Date: Fri, 3 Apr 2020 19:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:hpy7tG+6LUJMeU5uQuElQKaca1QpFU1e+UTi5sL2zkkRxn6H59o
 vs1+rlUxOwVshOR1yyH7Ko1uo+NzsIMD0Srv1fshtmBzLDzFAalzDuzrtzWrR7vd/BzEeWd
 lqPu6oQ0ba8zhHtHocaWc/7MsnkuNp/Iddr5lf1wyO+6+E96x9oVWxCDcdPjV0A0bxxkJ93
 TH3nbYk7kl9UaB/ZSS1VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:snu08ePOQ4Y=:RERL+WTQn6HpQ6VfYEVlHO
 UXU85GqBFMvttK96XRK6n8M1VBFCKIF016QJ8DKvfQLNy5uEBxcRnXQ3O7AhYHxXS5aBwyymi
 WGqDg5cVVolvhYPG7Of1lEhHvrxozWagv6ElJGNMqb0Q63k2aByZCBBuuS3f4grF2aChqCXSr
 CvunvGRzG8kKN6jFafdW4cP1RrwmSwc70z8QjgmcQa0jRUJ4DbsjEgTS+pcp9I4HeP3dUYy53
 ZVx/gNeVPntplWct/B+SZUWHlpshNGSJrZo1YW9bMLKez/SNd6q0YOTa0Wy+4PPr1RCkLere8
 cqMcMJ9EU8lsUJOGLDWgvlVd4TPG9HKLT86bJtR87Ygl0cLr80R6ck7wsb8Qr+Nmd1uGuBf44
 YLPpNmRPUQsTb2itsRjGtBc/oAtexHl2CI8Oelvj/hT2xVxAdqZjEl7Gpx+L/3LZlywb2/6ar
 j+YHP+YMoZoZGuX95M+FTVJVd+NFljOPUffS6qzTdtqZH9vK0TaBlXQHoYzr4LNE2pKuftF6e
 txYuTXQTwUEqM0Ai6mZu4LiMrDXIjdCIdSNXoZtfiKI0xGzVfeeqIeIYn6Ij+u5lv3Yieipdm
 259NgBXXMtpEsz0SDT2e/aQs2S2PMJ6kkI9RFCiPUTeyiYK43FT4QmtaTVOHeXXjm9ICB8Jjq
 decirzYn+Fk4bj+ePMTP9iVEvPAfqmhBglHPM3gX+9U5trOLVxsqq8Fa++1rzOG7mj8eYN5iV
 85m1M1dm1vY5zx2e8fCcmoUtrsPJUc3PH+mfSWksHjjH+vuMyqc47tQFlydyR6j61MTMKbIE5
 HVqmEkGvgnP+zoiNMDp5OEf2c+JQXdft55QDi2hAI4/yNDlcwub2q7gG3d8oa5zo2VfWNQSNr
 5crK6iUAPmTx3oxUA0EVmVoh4gfDjnWER9hOj99efi5FPBvSoU77IdqL68xvrDcSV7ICo20Gl
 OaXO9q+/Jqg5DRAxhgdxhBGpWrqkqPElcc+b/RAjfRvZVebtsnZGbCtN+TJuMtm7e2B3dAkqO
 sm27odlHxgwxpVg0GHtKgcLs+MMZyohkP8fIEWWpvyif+QFlbqyb35hpvdTFuzHmlfIwOPKJN
 fQo9CEiMI36fdhUFlc/qDZUYBcwD6mO55QhUfLW0aitRUjiehkiTafBoZSeAWUY4J5eXFqBMc
 tcNwHy8M3jdCZTnrq5DwSmytiWNRQ62M4Lvn1wRTvPBIcGQB00q3R+AMSQLCwefWQNxt+vjXk
 vgx5hjJkW3mCFeQOM
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

PiBSZWxlYXNlIHJlc291cmNlcyB3aGVuIGV4aXRpbmcgb24gZXJyb3IuCgpJIGhhdmUgZ290IGRv
dWJ0cyB0aGF0IHN1Y2ggYSBjaGFuZ2UgZGVzY3JpcHRpb24gZml0cyB0bwp0aGUgcHJvcG9zZWQg
c291cmNlIGNvZGUgYWRqdXN0bWVudC4KCgrigKYKPiArKysgYi9kcml2ZXJzL2lvbW11L3Fjb21f
aW9tbXUuYwo+IEBAIC04MTMsOCArODEzLDExIEBAIHN0YXRpYyBpbnQgcWNvbV9pb21tdV9kZXZp
Y2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCXFjb21faW9tbXUtPmRl
diA9IGRldjsKPgo+ICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VS
Q0VfTUVNLCAwKTsKPiAtCWlmIChyZXMpCj4gKwlpZiAocmVzKSB7Cj4gIAkJcWNvbV9pb21tdS0+
bG9jYWxfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7Cj4gKwkJaWYgKElT
X0VSUihxY29tX2lvbW11LT5sb2NhbF9iYXNlKSkKPiArCQkJcmV0dXJuIFBUUl9FUlIocWNvbV9p
b21tdS0+bG9jYWxfYmFzZSk7Cj4gKwl9Cj4KPiAgCXFjb21faW9tbXUtPmlmYWNlX2NsayA9IGRl
dm1fY2xrX2dldChkZXYsICJpZmFjZSIpOwrigKYKCldpbGwgdGhlIGNvbW1pdCBtZXNzYWdlIGJl
IGltcHJvdmVkIGFueSBmdXJ0aGVyPwoKV291bGQgeW91IGxpa2UgdG8gYWRkIHRoZSB0YWcg4oCc
Rml4ZXPigJ0/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
