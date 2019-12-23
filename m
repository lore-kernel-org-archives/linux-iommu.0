Return-Path: <SRS0=R7pc=2N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB525C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 13:43:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BAF206CB
	for <iommu@archiver.kernel.org>; Mon, 23 Dec 2019 13:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6kMDUZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BAF206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B10E864FB;
	Mon, 23 Dec 2019 13:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 37hUqcjIsSxZ; Mon, 23 Dec 2019 13:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 482D184EA0;
	Mon, 23 Dec 2019 13:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A3F0C1D81;
	Mon, 23 Dec 2019 13:43:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C224C0881
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 13:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8412B8456F
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 13:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpqT7UgBwzcM for <iommu@lists.linux-foundation.org>;
 Mon, 23 Dec 2019 13:43:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66A0D822AE
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 13:43:01 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id l24so8859486pgk.2
 for <iommu@lists.linux-foundation.org>; Mon, 23 Dec 2019 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=wVTAxAkLybU/XzL/opvLLffdVLtU7bgXnpcg4bd91o4=;
 b=Y6kMDUZyIpXUhY/6S6BGldJrLa3Be3lQw1aP1BG6W+6jpQs0H94u4738rszDgOEhev
 yj1YEU5Dhi+0a5z+R8dlTKCFEuU7NWGPTiCqZMIE80senDFfhVqi6pcyZbipej4nkQ1d
 V6tESjmrSWYreiBea6tmcV267sBT5fNb09WlZ1BUoaTGrqGyrgi8V+t4P7pGb2ZnYemn
 JQiamP8GzVdx2hTRs/mV/QNsjP6r2E86kVtm2jS0pSsqEyoL0hwlTM8OUhoWzQLioUq1
 qo3tKYhZjjwuv5Wwu/PXS8Oo+fqbuCWVUjnmzjEaSEIUUYY3m7TB7K6FLeQseWDqYeP9
 DSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wVTAxAkLybU/XzL/opvLLffdVLtU7bgXnpcg4bd91o4=;
 b=LehXINQJ8RXuL9VTT+iQ9T2nuVD8GQFQLfxXjBHXVczO4F8EdrvRBikCuYJNiN5FpJ
 ZQdCowFeeTs+IErwn+nfRyuU1bdy7uCVyWb+B6KWNxdbU/3u79ZG6inx7olJrslSawgK
 3aZ6j5zvEzENSepNd6Q0pA6nbSK8CR3nQOyHJgHbVAVScd3wUzZHcfR7vaLt+Kqc0lbt
 yrrhfJT+MrGi5Ni0GU671vaB8gy+5jUgqV713Kg9yRFmJ0VqkXkP+syd9GLwxyvfI6xo
 Ruxx2jtc+ymzGFz2PQo+CKg4TgZ727BnlvmBQ1PB/8G9VWSLziBARqAsqUMou6yohr6r
 2bVg==
X-Gm-Message-State: APjAAAUFUxM0GGodM3tAw7ZgJ+nwqnfA30c84HsPCwgCE4G3v4NDH0ZC
 jWz/f4F80YVsMxL00U4RU4+uomImDbQ=
X-Google-Smtp-Source: APXvYqwmupBlYBUO32XRngGKnjqX9G8UnI7c7rx2T5XTS3rPO/gmjyWX42Do7N5EQcg90Wl/OdkwDQ==
X-Received: by 2002:a63:89c2:: with SMTP id
 v185mr30692540pgd.135.1577108580760; 
 Mon, 23 Dec 2019 05:43:00 -0800 (PST)
Received: from [192.168.11.202] (li1566-229.members.linode.com.
 [139.162.86.229])
 by smtp.gmail.com with ESMTPSA id z4sm21121512pjn.29.2019.12.23.05.42.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Dec 2019 05:43:00 -0800 (PST)
Subject: Re: [PATCH v10 0/4] Add uacce module for Accelerator
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>, Jerome Glisse
 <jglisse@redhat.com>, ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
 kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0e7f16b7-938b-402a-e3e3-2a0bed6fb708@linaro.org>
Date: Mon, 23 Dec 2019 21:41:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIEdyZWcKCk9uIDIwMTkvMTIvMTYg5LiK5Y2IMTE6MDgsIFpoYW5nZmVpIEdhbyB3cm90ZToK
PiBVYWNjZSAoVW5pZmllZC9Vc2VyLXNwYWNlLWFjY2Vzcy1pbnRlbmRlZCBBY2NlbGVyYXRvciBG
cmFtZXdvcmspIHRhcmdldHMgdG8KPiBwcm92aWRlIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3Npbmcg
KFNWQSkgYmV0d2VlbiBhY2NlbGVyYXRvcnMgYW5kIHByb2Nlc3Nlcy4KPiBTbyBhY2NlbGVyYXRv
ciBjYW4gYWNjZXNzIGFueSBkYXRhIHN0cnVjdHVyZSBvZiB0aGUgbWFpbiBjcHUuCj4gVGhpcyBk
aWZmZXJzIGZyb20gdGhlIGRhdGEgc2hhcmluZyBiZXR3ZWVuIGNwdSBhbmQgaW8gZGV2aWNlLCB3
aGljaCBzaGFyZQo+IGRhdGEgY29udGVudCByYXRoZXIgdGhhbiBhZGRyZXNzLgo+IEJlY2F1c2Ug
b2YgdW5pZmllZCBhZGRyZXNzLCBoYXJkd2FyZSBhbmQgdXNlciBzcGFjZSBvZiBwcm9jZXNzIGNh
biBzaGFyZQo+IHRoZSBzYW1lIHZpcnR1YWwgYWRkcmVzcyBpbiB0aGUgY29tbXVuaWNhdGlvbi4K
Pgo+IFVhY2NlIGlzIGludGVuZGVkIHRvIGJlIHVzZWQgd2l0aCBKZWFuIFBoaWxpcHBlIEJydWNr
ZXIncyBTVkEKPiBwYXRjaHNldFsxXSwgd2hpY2ggZW5hYmxlcyBJTyBzaWRlIHBhZ2UgZmF1bHQg
YW5kIFBBU0lEIHN1cHBvcnQuCj4gV2UgaGF2ZSBrZWVwIHZlcmlmeWluZyB3aXRoIEplYW4ncyBz
dmEgcGF0Y2hzZXQgWzJdCj4gV2UgYWxzbyBrZWVwIHZlcmlmeWluZyB3aXRoIEVyaWMncyBTTU1V
djMgTmVzdGVkIFN0YWdlIHBhdGNoZXMgWzNdCj4KPiBUaGlzIHNlcmllcyBhbmQgcmVsYXRlZCB6
aXAgJiBxbSBkcml2ZXIKPiBodHRwczovL2dpdGh1Yi5jb20vTGluYXJvL2xpbnV4LWtlcm5lbC13
YXJwZHJpdmUvdHJlZS92NS41LXJjMS11YWNjZS12MTAKPgo+IFRoZSBsaWJyYXJ5IGFuZCB1c2Vy
IGFwcGxpY2F0aW9uOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9MaW5hcm8vd2FycGRyaXZlL3RyZWUv
d2RwcmQtdXBzdHJlYW0tdjEwCj4KPiBSZWZlcmVuY2VzOgo+IFsxXSBodHRwOi8vanBicnVja2Vy
Lm5ldC9zdmEvCj4gWzJdIGh0dHA6Ly9qcGJydWNrZXIubmV0L2dpdC9saW51eC9sb2cvP2g9c3Zh
L3ppcC1kZXZlbAo+IFszXSBodHRwczovL2dpdGh1Yi5jb20vZWF1Z2VyL2xpbnV4L3RyZWUvdjUu
My4wLXJjMC0yc3RhZ2UtdjkKPgo+IENoYW5nZSBIaXN0b3J5Ogo+IHYxMDoKPiBNb2RpZnkgdGhl
IGluY2x1ZGUgaGVhZGVyIHRvIGZpeCBrYnVpbGQgdGVzdCBlcm9yciBpbiBvdGhlciBhcmNoLgo+
Cj4KPiBLZW5uZXRoIExlZSAoMik6Cj4gICAgdWFjY2U6IEFkZCBkb2N1bWVudHMgZm9yIHVhY2Nl
Cj4gICAgdWFjY2U6IGFkZCB1YWNjZSBkcml2ZXIKPgo+IFpoYW5nZmVpIEdhbyAoMik6Cj4gICAg
Y3J5cHRvOiBoaXNpbGljb24gLSBSZW1vdmUgbW9kdWxlX3BhcmFtIHVhY2NlX21vZGUKPiAgICBj
cnlwdG86IGhpc2lsaWNvbiAtIHJlZ2lzdGVyIHppcCBlbmdpbmUgdG8gdWFjY2UKPgo+CgpXb3Vs
ZCB5b3UgbWluZCB0YWtlIGEgbG9vayBhdCB0aGUgcGF0Y2ggc2V0PwoKVGhlIHBhdGNoZXMgYXJl
IGFsc28gdXNlZCBmb3IgdmVyaWZ5aW5nIHRoZSBzdmEgZmVhdHVyZS4KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtaW9tbXUvMjAxOTEyMTkxNjMwMzMuMjYwODE3Ny0xLWplYW4tcGhpbGlw
cGVAbGluYXJvLm9yZy8KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
