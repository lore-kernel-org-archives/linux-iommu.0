Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C62C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 08:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09FA6812E2;
	Tue, 22 Feb 2022 08:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VU8u0dZldozS; Tue, 22 Feb 2022 08:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D9CCF8146C;
	Tue, 22 Feb 2022 08:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB44C001A;
	Tue, 22 Feb 2022 08:27:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD322C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 08:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6E5E8146C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 08:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w_IUkzGztrTF for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:27:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4A40812E2
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zfYHUsgUj9bMp9XYzGWc9eCMGjpGs1SMSVRvMazWtpo=; b=QHyYx+SEEBJQcikLDxVb11HMI/
 2DeGvHzOW+RxzucK9R5fB+ys4CS7odv616RThf4BocUwCSEmx+Lgo8ekre1mE+DOGH5lndthE7cuF
 LJgPVhqRqWgWCAwG2TShhc4y5cDEJ63yjNi8IHNyaSJLrMcgUDNYKl7HJyGUK2qTaSkzVh4tyafcG
 tX4n0/urq6mUwVFF5eL9hyy7tytH9AsCsf4Fic8G6mLH/0FQc9k8/jPHwKQCHQ+f9xZty259++SHc
 THiCCaySgOh3OTTdIV5o2RXnNsbn/dhsifKpI422xSjAbDXK5+DFwC3r7RAsQ7fYFLz9LiuepQ1Sf
 AEBNkh5g==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nMQVk-0003Nm-2i; Tue, 22 Feb 2022 10:27:04 +0200
Message-ID: <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
Date: Tue, 22 Feb 2022 10:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
 <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMi8yMS8yMiAyMjoxMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDIxLjAyLjIwMjIgMTQ6
NDQsIE1pa2tvIFBlcnR0dW5lbiDQv9C40YjQtdGCOgo+PiBPbiAyLzE5LzIyIDIwOjU0LCBEbWl0
cnkgT3NpcGVua28gd3JvdGU6Cj4+PiAxOS4wMi4yMDIyIDIxOjQ5LCBEbWl0cnkgT3NpcGVua28g
0L/QuNGI0LXRgjoKPj4+PiAxOC4wMi4yMDIyIDE0OjM5LCBNaWtrbyBQZXJ0dHVuZW4g0L/QuNGI
0LXRgjoKPj4+Pj4gK3N0YXRpYyBpbnQgdmljX2dldF9zdHJlYW1pZF9vZmZzZXQoc3RydWN0IHRl
Z3JhX2RybV9jbGllbnQgKmNsaWVudCkKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCBzdHJ1Y3Qgdmlj
ICp2aWMgPSB0b192aWMoY2xpZW50KTsKPj4+Pj4gK8KgwqDCoCBpbnQgZXJyOwo+Pj4+PiArCj4+
Pj4+ICvCoMKgwqAgZXJyID0gdmljX2xvYWRfZmlybXdhcmUodmljKTsKPj4+Pgo+Pj4+IFlvdSBj
YW4ndCBpbnZva2UgdmljX2xvYWRfZmlybXdhcmUoKSB3aGlsZSBSUE0gaXMgc3VzcGVuZGVkLiBF
aXRoZXIKPj4+PiByZXBsYWNlIHRoaXMgd2l0aCBSUE0gZ2V0L3B1dCBvciBkbyBzb21ldGhpbmcg
ZWxzZS4KPj4KPj4gV2h5IG5vdCwgSSdtIG5vdCBzZWVpbmcgYW55IEhXIGFjY2Vzc2VzIGluIHZp
Y19sb2FkX2Zpcm13YXJlPyBBbHRob3VnaAo+PiBpdCBsb29rcyBsaWtlIGl0IG1pZ2h0IHJhY2Ug
d2l0aCB0aGUgdmljX2xvYWRfZmlybXdhcmUgY2FsbCBpbgo+PiB2aWNfcnVudGltZV9yZXN1bWUg
d2hpY2ggcHJvYmFibHkgbmVlZHMgdG8gYmUgZml4ZWQuCj4gCj4gSXQgd2FzIG5vdCBjbGVhciBm
cm9tIHRoZSBmdW5jdGlvbidzIG5hbWUgdGhhdCBoL3cgaXMgdW50b3VjaGVkLCBJIHJlYWQKPiAi
bG9hZCIgYXMgInVwbG9hZCIgYW5kIHRoZW4gbG9va2VkIGF0IHZpY19ydW50aW1lX3Jlc3VtZSgp
LiBJJ2QgcmVuYW1lCj4gdmljX2xvYWRfZmlybXdhcmUoKSB0byB2aWNfcHJlcGFyZV9maXJtd2Fy
ZV9pbWFnZSgpLgo+IAo+IEFuZCB5ZXMsIHRlY2huaWNhbGx5IGxvY2sgaXMgbmVlZGVkLgoKWWVw
LCBJJ2xsIGNvbnNpZGVyIHJlbmFtaW5nIGl0LgoKTWlra28KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
