Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88924C433FE
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 07:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C33F3404C6;
	Fri, 25 Mar 2022 07:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7OcGCeb34RwB; Fri, 25 Mar 2022 07:12:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F776400D8;
	Fri, 25 Mar 2022 07:12:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 217B0C002C;
	Fri, 25 Mar 2022 07:12:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA5FC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 980F441CF2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=natalenko.name
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gVQcUZglPFAo for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:12:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BF4D41CF1
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:12:43 +0000 (UTC)
Received: from spock.localnet (unknown [83.148.33.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 0402BE4C661;
 Fri, 25 Mar 2022 08:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1648192359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcXLBP3mIfbGljUpsP//FsQOHOTfI0szjq2ialy/sIU=;
 b=nTgcEEtgRJjs1kBrwhIgdlq/eHBdXP950twIufQRtgGI9t1yPmzXlHuARe5Mm4Ku1Wl+gj
 J1qtm2C0WtQDcQ1vPPoPlPSxgR6hQ7w2kxF8mGOtYKwbxIJ1skLC/zf5LPO3fyjV3xW742
 nilK7AS68nMA3cP9Tzef//M9aMfeDRo=
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Maxime Bizon <mbizon@freebox.fr>,
 Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Date: Fri, 25 Mar 2022 08:12:37 +0100
Message-ID: <4699073.GXAFRqVoOG@natalenko.name>
In-Reply-To: <871qyr9t4e.fsf@toke.dk>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
MIME-Version: 1.0
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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
From: Oleksandr Natalenko via iommu <iommu@lists.linux-foundation.org>
Reply-To: Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGVsbG8uCgpPbiDEjXR2cnRlayAyNC4gYsWZZXpuYSAyMDIyIDE4OjA3OjI5IENFVCBUb2tlIEjD
uGlsYW5kLUrDuHJnZW5zZW4gd3JvdGU6Cj4gUmlnaHQsIGJ1dCBpcyB0aGF0IHN5bmNfZm9yX2Rl
dmljZSBjYWxsIHJlYWxseSBuZWVkZWQ/IEFGQUlDVCwgdGhhdAo+IGF0aDlrX2h3X3Byb2Nlc3Nf
cnhkZXNjX2VkbWEoKSBpbnZvY2F0aW9uIGRvZXNuJ3QgYWN0dWFsbHkgbW9kaWZ5IGFueSBvZgo+
IHRoZSBkYXRhIHdoZW4gaXQgcmV0dXJucyBFSU5QUk9HUkVTUywgc28gY291bGQgd2UganVzdCBz
a2lwIGl0PyBMaWtlCj4gdGhlIHBhdGNoIGJlbG93PyBPciBhbSBJIG1pc3VuZGVyc3RhbmRpbmcg
dGhlIHNlbWFudGljcyBoZXJlPwo+IAo+IC1Ub2tlCj4gCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg5ay9yZWN2LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9h
dGgvYXRoOWsvcmVjdi5jCj4gaW5kZXggMGMwNjI0YTNiNDBkLi4xOTI0NGQ0YzBhZGEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDlrL3JlY3YuYwo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGg5ay9yZWN2LmMKPiBAQCAtNjQ3LDEyICs2NDcsOCBA
QCBzdGF0aWMgYm9vbCBhdGhfZWRtYV9nZXRfYnVmZmVycyhzdHJ1Y3QgYXRoX3NvZnRjICpzYywK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbW1vbi0+cnhfYnVmc2l6ZSwgRE1B
X0ZST01fREVWSUNFKTsKPiAgCj4gICAgICAgICByZXQgPSBhdGg5a19od19wcm9jZXNzX3J4ZGVz
Y19lZG1hKGFoLCBycywgc2tiLT5kYXRhKTsKPiAtICAgICAgIGlmIChyZXQgPT0gLUVJTlBST0dS
RVNTKSB7Cj4gLSAgICAgICAgICAgICAgIC8qbGV0IGRldmljZSBnYWluIHRoZSBidWZmZXIgYWdh
aW4qLwo+IC0gICAgICAgICAgICAgICBkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZShzYy0+ZGV2
LCBiZi0+YmZfYnVmX2FkZHIsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21t
b24tPnJ4X2J1ZnNpemUsIERNQV9GUk9NX0RFVklDRSk7Cj4gKyAgICAgICBpZiAocmV0ID09IC1F
SU5QUk9HUkVTUykKPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+IC0gICAgICAgfQo+
ICAKPiAgICAgICAgIF9fc2tiX3VubGluayhza2IsICZyeF9lZG1hLT5yeF9maWZvKTsKPiAgICAg
ICAgIGlmIChyZXQgPT0gLUVJTlZBTCkgewoKV2l0aCB0aGlzIHBhdGNoIGFuZCBib3RoIGRkYmQ4
OWRlYjdkMythYTZmOGRjYmFiNDcgaW4gcGxhY2UgdGhlIEFQIHdvcmtzIGZvciBtZS4KClRoYW5r
cy4KCi0tIApPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
