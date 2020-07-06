Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C24AC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5944E20702
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dykUl5Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5944E20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8257088C7F;
	Mon,  6 Jul 2020 13:34:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Yaazymtl0TJ; Mon,  6 Jul 2020 13:34:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC59A88C67;
	Mon,  6 Jul 2020 13:34:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBF4C0893;
	Mon,  6 Jul 2020 13:34:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F35BDC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6E2C25D82
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LITY8LGcphKx for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:34:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by silver.osuosl.org (Postfix) with ESMTPS id 1CBE425D52
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1594042443;
 bh=zyikPEHRSl6AfWnrIJsptm0zk3698RDADIrgUvP6JL4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=dykUl5Z/jkWGSiBqMz4YjIFMzhj+0rJ2OaWEPiEAI/j5AfTD1SwZFV1ngl4I5f6DO
 fijeLzd/p3DfhXKJkRQvhkv+isL05Ej0ziAXBthUrNufqYBB/WWo6wwmf1fWJTqATk
 cYlILoX2ryhGkRtx0jITSpMnqpQpvbZEDDZTmaq0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDxCN-1k85vJ4AkJ-00HOMY; Mon, 06
 Jul 2020 15:34:03 +0200
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
To: Hillf Danton <hdanton@sina.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7ed25c44-bb51-2d8d-82d9-f11272f56424@web.de>
Date: Mon, 6 Jul 2020 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706124241.4392-1-hdanton@sina.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:hQRlprojWG/gbX7gfH4IvEPq/yWggqojlOSRndeRHXRFyV6gflb
 3xWgaDC2zU027iUUZvbgo88UWGbzSIKD1b6S9AvXbVA8CeL2Azt1uZ6fGcKlDfKdy55quTE
 cR+Mt+yHCVh8apr9KJGjIMgZJ81TahgojBeJcPw65TliQU1reY7BHvAV2cKvE9ISZVV9TD3
 mmKhR5yHSmjdIY3H8yxjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bc4I7rzFw7Y=:cNVHiMPx6Tz5XJ2v2Fet5L
 WPSOVTbpBAx5uuo8/zhhlc01QKoJzuLXGC5tm7GTsqLsqF6Wt09RES/ga7QxdZFRnPt0aFAIz
 3zLqiQAp9V7FZSYx6pDzbhdT+j9Wqjr5NY0HvJsmQxaiKNAGvcdT9pSBjmWozz3G3extGph9I
 BGpdf97jPf7BdR/w7t7l8KjaPMm9goumyruTzQAs+kLIUt1jhpxtLcRxOTO9oEZqC0gqDoyfb
 6s/fiYsSBXIX+8EKmroKYlI+JjAMxQfm5bZ/kcNck7EJuT5TBMT9L3RbBwiaxn5yDg9uXsrRe
 N7/6G6A8QNsw+bbZHejh+b1aAaHA5boGwT1hEMnMj2zi0G1SS/vE55HF/UsIYdynSGdKe+ksL
 +Jq73DwtM/9cbsrDHu/pW9WgI23InPXZqLaSGKBGBefhLOof//8shNiSnBhvmAltY5A06u1Z0
 XuyCoTNig4322Y3ZI/zqNO1tWLlCsDXNjrZSLPvzYrVNMQ5I7XH89ODiYgZBUrfEFOCHaJCS2
 thHyPSx1XF6w+zqUGXAMHJY/vGOh2a89sVrlsXIcvZm0MvEa4BaJ+1A175S51nkcxSdgdpx0s
 IX0lY/CF/mpfQO1DifuCravqMPX6w/NV3nRPGG3dw3jUD9TDKrz2o67R7e7zZTBUOKtfnqvFy
 EBqjodHKBN6PiWihbfekk+kgsu9j9olhWiRTCBC9FHGO004FfnqBcw6I0uUJvZVWP06USeqY/
 d2RNleTGOxan7MtsOJZSeVWA6j8UC26b4Nrwz3Pl970LLoQmhsCkvn7T2GSKw0FhchAwx3FIG
 S01GqDhvvW/c0Gi5GxGCifx75z0MTvpv2kJGda7EgmOnJkdC4Zc8zarKGicsgY8qZniU65+Dh
 aVZUimK5ogOuWpOkaKvBPXb4xJr2f6J51lGDy5PzwqEpD8TDY4nynfvc2GRDTxtwYJazuwXov
 H8qtq2wbzcBeA2k+mta2Wa2Pep6tuBf0SLArTxho3N/XireqaYZAEQUyTrsgj9h5zh6i4yEOg
 sv+n1Em1NRa/BVDBQIrEhrc2UVI/qowXwI7ocjOeEHpklgX7k3fYyZOG2CZHenUJZIgd0qJcx
 Jyl4p+DEu/ZA7y8NwFnSjz+ckFRw9QcyuWSSqQH2EFMhXW0hbHyu9g/GCUCzoLftX9gPHTHW4
 75ItyfO5X7Egz9+QRliWT6qhP5QXWHNHtS+4AQT/fSrmBNyCBT54B5wQhqNPTZz8eTMol0cLN
 cGWL2wYTGPTO7DVuz8ES+C7IveaDdFdjxiYNqhw==
Cc: Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
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

Pj4gQ2FuIGl0IGJlIGhlbHBmdWwgdG8gY29udmVydCBpbml0aWFsaXNhdGlvbnMgZm9yIHRoZXNl
IHZhcmlhYmxlcwo+PiBpbnRvIGxhdGVyIGFzc2lnbm1lbnRzPwo+Cj4gUGVyaGFwcy4gVGhlbiBp
dCBsb29rcyBsaWtlIHRoZSBiZWxvdy4KCgrigKYKPiArKysgYi9kcml2ZXJzL3ZmaW8vdmZpb19p
b21tdV90eXBlMS5jCj4gQEAgLTI3OTgsOSArMjc5OCwxMiBAQCBzdGF0aWMgaW50IHZmaW9faW9t
bXVfdHlwZTFfZG1hX3J3X2NodW5rCuKApgo+IC0JYm9vbCBrdGhyZWFkID0gY3VycmVudC0+bW0g
PT0gTlVMTDsKPiArCWJvb2wga3RocmVhZDsKPiArCWJvb2wgdXNlX21tOwoKSSB3b3VsZCBwcmVm
ZXIgdGhlIGZvbGxvd2luZyB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgdGhlbi4KCisJYm9vbCBrdGhy
ZWFkLCB1c2VfbW07CgoKPiAgCXNpemVfdCBvZmZzZXQ7Cj4KPiArCWt0aHJlYWQgPSBjdXJyZW50
LT5mbGFncyAmIFBGX0tUSFJFQUQ7Cj4gKwl1c2VfbW0gPSBjdXJyZW50LT5tbSA9PSBOVUxMOwoK
SSBwcm9wb3NlIHRvIG1vdmUgc3VjaCBhc3NpZ25tZW50cyBkaXJlY3RseSBiZWZvcmUgdGhlIGNv
cnJlc3BvbmRpbmcgY2hlY2suCgoK4oCmCj4gIAlpZiAoIW1tKQo+ICAJCXJldHVybiAtRVBFUk07
CgoKKwlrdGhyZWFkID0gY3VycmVudC0+ZmxhZ3MgJiBQRl9LVEhSRUFEOworCXVzZV9tbSA9ICFj
dXJyZW50LT5tbTsKCj4gLQlpZiAoa3RocmVhZCkKPiArCWlmIChrdGhyZWFkICYmIHVzZV9tbSkK
PiAgCQlrdGhyZWFkX3VzZV9tbShtbSk7CuKApgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
