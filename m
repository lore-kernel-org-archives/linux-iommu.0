Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27C1C11F68
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 14:05:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC716142C
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 14:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC716142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 127B583E0C;
	Fri,  2 Jul 2021 14:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MifqVvKhZUYI; Fri,  2 Jul 2021 14:05:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B74983E09;
	Fri,  2 Jul 2021 14:05:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 800D6C001A;
	Fri,  2 Jul 2021 14:05:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7615C000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 14:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81780606AA
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 14:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1sG28fUD21Q for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 14:05:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A553660672
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 14:05:38 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id k10so18212747lfv.13
 for <iommu@lists.linux-foundation.org>; Fri, 02 Jul 2021 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cjfl3c0J1wDK0xB6m0y3uhz6p6gS8JB9sGZSHtLepfc=;
 b=ocEmqlClYeANx41+Aff3aBsIZIc3UVL4RukOuIMXBs3c/pjDrBTh7SKzR1xGu3X1D+
 HnLnYqQSqbVNwZphjkzXKuzrtTREydyNMI7xq0um2Dijg2FABDK5/f7wv3q1U9OPhpTD
 lE9dlJ7Bl0jRg6UJdme4qM2uWiLTYOm4+6N9dZwQjsWyIWXYqUdoUeZ130j0vJXLsaUy
 rbeGxR1S8HWJ8p9uPlQU7oCzGUJ3+DqhFRDtUqzcdd2gBc0jaZh6FDCzm4uoiOWIh32c
 uK6h1asNzG2jqNBMt/8czvBAiSBePEULa8Ib1Bn/fGPGDaQpernRoyWYEJGdeA+/j4Gz
 xkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cjfl3c0J1wDK0xB6m0y3uhz6p6gS8JB9sGZSHtLepfc=;
 b=kUW5FGSxcrkDH+LbH/mi3BSYmQq8PQc+HNxM/FG6bn2O8byeGZgDMH1ivJ5UXP+nv3
 qFhip65cCgdlLAxd44u4Rs2Hz1I3+bC/Tbgrl2mhgEtF/C6a5vfLC2m9XTY1i97qJf6+
 1tIhspSSs3mhMVEXMXcXV9Af0EdY5b9v5ipqXajjbHt0N/+Zi0+qN1KnMfnNjZ5GxHuY
 v/FqXlzx/SvlbKexCxtcPTZVm1DBYBKGK3qVlGROKV8EF5L+QiJm8rgtRUPnRk2UKIGE
 v1Z253g2OP8zvyrxJdJ+Wgk2vCMFqGr0MYlTRRvA+se/ip33dIjgTqNTs0xrIrjqDwAC
 CKTw==
X-Gm-Message-State: AOAM530Nyy9V29w0ViLDf4MV9NsKWlG/R+mvFJi0C5ruQbkn6d7YT0i6
 Pjm4Xg/90Ax4Mi1UaOlvkpI=
X-Google-Smtp-Source: ABdhPJzkutMeeLEPXZOMUQKVeT4A2lCgpel8CCjVgI5HBDtKFzrED7+2eYblNwWvXC7GZ5j86yLWyw==
X-Received: by 2002:a05:6512:3fa2:: with SMTP id
 x34mr3972751lfa.437.1625234736576; 
 Fri, 02 Jul 2021 07:05:36 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru.
 [94.29.37.113])
 by smtp.googlemail.com with ESMTPSA id q24sm304955lfj.200.2021.07.02.07.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jul 2021 07:05:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] iommu: Implement of_iommu_get_resv_regions()
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-3-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bdc42077-d1f3-f561-2e4d-647b5fceb7b6@gmail.com>
Date: Fri, 2 Jul 2021 17:05:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210423163234.3651547-3-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

MjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiArdm9pZCBvZl9p
b21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVh
ZCAqbGlzdCkKPiArewo+ICsJc3RydWN0IG9mX3BoYW5kbGVfaXRlcmF0b3IgaXQ7Cj4gKwlpbnQg
ZXJyOwo+ICsKPiArCW9mX2Zvcl9lYWNoX3BoYW5kbGUoJml0LCBlcnIsIGRldi0+b2Zfbm9kZSwg
Im1lbW9yeS1yZWdpb24iLCAiI21lbW9yeS1yZWdpb24tY2VsbHMiLCAwKSB7Cj4gKwkJc3RydWN0
IGlvbW11X3Jlc3ZfcmVnaW9uICpyZWdpb247Cj4gKwkJc3RydWN0IG9mX3BoYW5kbGVfYXJncyBh
cmdzOwo+ICsJCXN0cnVjdCByZXNvdXJjZSByZXM7Cj4gKwo+ICsJCWFyZ3MuYXJnc19jb3VudCA9
IG9mX3BoYW5kbGVfaXRlcmF0b3JfYXJncygmaXQsIGFyZ3MuYXJncywgTUFYX1BIQU5ETEVfQVJH
Uyk7Cj4gKwo+ICsJCWVyciA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2UoaXQubm9kZSwgMCwgJnJl
cyk7Cj4gKwkJaWYgKGVyciA8IDApIHsKPiArCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcGFy
c2UgbWVtb3J5IHJlZ2lvbiAlcE9GOiAlZFxuIiwKPiArCQkJCWl0Lm5vZGUsIGVycik7Cj4gKwkJ
CWNvbnRpbnVlOwo+ICsJCX0KPiArCj4gKwkJaWYgKGFyZ3MuYXJnc19jb3VudCA+IDApIHsKPiAr
CQkJLyoKPiArCQkJICogQWN0aXZlIG1lbW9yeSByZWdpb25zIGFyZSBleHBlY3RlZCB0byBiZSBh
Y2Nlc3NlZCBieSBoYXJkd2FyZSBkdXJpbmcKPiArCQkJICogYm9vdCBhbmQgbXVzdCB0aGVyZWZv
cmUgaGF2ZSBhbiBpZGVudGl0eSBtYXBwaW5nIGNyZWF0ZWQgcHJpb3IgdG8gdGhlCj4gKwkJCSAq
IGRyaXZlciB0YWtpbmcgY29udHJvbCBvZiB0aGUgaGFyZHdhcmUuIFRoaXMgZW5zdXJlcyB0aGF0
IG5vbi1xdWllc2NlbnQKPiArCQkJICogaGFyZHdhcmUgZG9lc24ndCBjYXVzZSBJT01NVSBmYXVs
dHMgZHVyaW5nIGJvb3QuCj4gKwkJCSAqLwo+ICsJCQlpZiAoYXJncy5hcmdzWzBdICYgTUVNT1JZ
X1JFR0lPTl9JREVOVElUWV9NQVBQSU5HKSB7Cj4gKwkJCQlyZWdpb24gPSBpb21tdV9hbGxvY19y
ZXN2X3JlZ2lvbihyZXMuc3RhcnQsIHJlc291cmNlX3NpemUoJnJlcyksCj4gKwkJCQkJCQkJIElP
TU1VX1JFQUQgfCBJT01NVV9XUklURSwKPiArCQkJCQkJCQkgSU9NTVVfUkVTVl9ESVJFQ1RfUkVM
QVhBQkxFKTsKPiArCQkJCWlmICghcmVnaW9uKQo+ICsJCQkJCWNvbnRpbnVlOwo+ICsKPiArCQkJ
CWxpc3RfYWRkX3RhaWwoJnJlZ2lvbi0+bGlzdCwgbGlzdCk7Cj4gKwkJCX0KPiArCQl9Cj4gKwl9
Cj4gK30KPiArRVhQT1JUX1NZTUJPTChvZl9pb21tdV9nZXRfcmVzdl9yZWdpb25zKTsKCkFueSBy
ZWFzb24gd2h5IHRoaXMgaXMgbm90IEVYUE9SVF9TWU1CT0xfR1BMPyBJJ20gY3VyaW91cyB3aGF0
IGlzIHRoZQpsb2dpYyBiZWhpbmQgdGhlIE9GIHN5bWJvbHMgaW4gZ2VuZXJhbCBzaW5jZSBpdCBs
b29rcyBsaWtlIGhhbGYgb2YgdGhlbQphcmUgR1BMLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
