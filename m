Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3494AC4741F
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 20:52:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36A5207EA
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p21Cw0Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36A5207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A63387190;
	Sat, 26 Sep 2020 20:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QBgpey3odUTg; Sat, 26 Sep 2020 20:52:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A60C38718A;
	Sat, 26 Sep 2020 20:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96135C0859;
	Sat, 26 Sep 2020 20:52:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1C76C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 20:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CD37D8586A
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 20:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jM89_8BwcSOR for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 20:52:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D91885821
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 20:52:40 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id z19so6071347pfn.8
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=WDzjfa8QUsgUaih+kIpPeyFOqv/pDOBqTsibbBt+0tA=;
 b=p21Cw0Gd5+8Un3GCJAR7IRm9YOwwgnJJTECiQUrzwluzON3YE0rHS2rkhNAToyq1iy
 LAiYyWrglDQyz1NimEvVAcwlPrhwKCeNkTIrfi9u/8T+0YT5I1dPG5yZgXDp6CKMCEhX
 0Ao9gibUIOzk65fw0c7HBQxMnJer5x/yxdlohKQxN1XJ5x09QjnGDi4KIGGMD+21JBeQ
 ecfno/bfvh55TgkY6kcdwQ+guh3DBnwPt/Ap28BI1ou6Ot2319GPrkP8lqe3rTwLZTBP
 S7RoKJbABPrDYnDtryxA2qmYCuNeihYSkZbcL61TBg/h9ly7Gk0pEg3AtDC4kRS2jwFb
 rWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=WDzjfa8QUsgUaih+kIpPeyFOqv/pDOBqTsibbBt+0tA=;
 b=jnxu45TuRr7x5pv0BIGkE5v5+iPX6vQ8DlIVr+y2YTIdJDoJ6036WnKgMn/I9KlA7n
 M0DZGE2RCf1WWjfc55DFmPnvxl3UJ4YTdQd5nr9fWD1/vx3qzHkW6+AruhkNtvdl2WZC
 hxRULBbVyMR4+FMcldLvBW2cfZePbHko4OpZKPmiZILs3Y0RbaoCCGH0AZM92pzb3MUX
 L3TG04zXWvJl+BcRie9FoeA6BGm6b4cU17yjycVsULf4QRDSz/RXhwjZOUUmpbXEUA4V
 M3eIGN925AhXY/nmHFwP+s6Lwe/+8U9pFf8s5A5mz/XZM3U2YSVQYSs1mr7l9+N5mjGM
 ffag==
X-Gm-Message-State: AOAM531cl9YlNo2J8PJY62Q1HGh/kD+idriAX//RVeaec2N/LoUxMI6k
 +yVE6P4j3PypEawCYuzBkgc=
X-Google-Smtp-Source: ABdhPJzQgKnWxoBbJQBJf/eknMgjtWp+DPqXjU/t6wROxeDyeHz3Nq1vOnxzQ3KbUmJjCyFz+Zi+xQ==
X-Received: by 2002:a63:f54f:: with SMTP id e15mr3816188pgk.310.1601153559608; 
 Sat, 26 Sep 2020 13:52:39 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id c6sm6314291pfd.83.2020.09.26.13.52.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Sep 2020 13:52:39 -0700 (PDT)
Date: Sat, 26 Sep 2020 13:47:44 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 5/5] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20200926204744.GB4947@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-6-nicoleotsuka@gmail.com>
 <0c9ca297-d656-59a5-eefd-00e0c0542c29@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c9ca297-d656-59a5-eefd-00e0c0542c29@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

SGkgRG1pdHJ5LAoKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LgoKT24gU2F0LCBTZXAgMjYsIDIw
MjAgYXQgMDU6NDg6NTRQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDI2LjA5LjIw
MjAgMTE6MDcsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+IC4uLgo+ID4gK3N0YXRpYyBpbnQg
dGVncmFfc21tdV9tYXBwaW5nc19zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqZGF0YSkK
PiA+ICt7Cj4gPiArCXN0cnVjdCB0ZWdyYV9zbW11X2dyb3VwX2RlYnVnICpncm91cF9kZWJ1ZyA9
IHMtPnByaXZhdGU7Cj4gPiArCWNvbnN0IHN0cnVjdCB0ZWdyYV9zbW11X3N3Z3JvdXAgKmdyb3Vw
Owo+ID4gKwlzdHJ1Y3QgdGVncmFfc21tdV9hcyAqYXM7Cj4gPiArCXN0cnVjdCB0ZWdyYV9zbW11
ICpzbW11Owo+ID4gKwlpbnQgcGRfaW5kZXgsIHB0X2luZGV4Owo+ID4gKwl1NjQgcHRlX2NvdW50
ID0gMDsKPiA+ICsJdTMyIHBkZV9jb3VudCA9IDA7Cj4gPiArCXUzMiB2YWwsIHB0Yl9yZWc7Cj4g
PiArCXUzMiAqcGQ7Cj4gPiArCj4gPiArCWlmICghZ3JvdXBfZGVidWcgfHwgIWdyb3VwX2RlYnVn
LT5wcml2IHx8ICFncm91cF9kZWJ1Zy0+Z3JvdXApCj4gPiArCQlyZXR1cm4gMDsKPiA+ICsKPiA+
ICsJZ3JvdXAgPSBncm91cF9kZWJ1Zy0+Z3JvdXA7Cj4gPiArCWFzID0gZ3JvdXBfZGVidWctPnBy
aXY7Cj4gPiArCXNtbXUgPSBhcy0+c21tdTsKPiA+ICsKPiA+ICsJdmFsID0gc21tdV9yZWFkbChz
bW11LCBncm91cC0+cmVnKSAmIFNNTVVfQVNJRF9FTkFCTEU7Cj4gPiArCWlmICghdmFsKQo+ID4g
KwkJcmV0dXJuIDA7Cj4gPiArCj4gPiArCXBkID0gcGFnZV9hZGRyZXNzKGFzLT5wZCk7Cj4gPiAr
CWlmICghcGQpCj4gPiArCQlyZXR1cm4gMDsKPiA+ICsKPiA+ICsJc2VxX3ByaW50ZihzLCAiXG5T
V0dST1VQOiAlc1xuQVNJRDogJWRcbnJlZzogMHgleFxuIiwgZ3JvdXAtPm5hbWUsCj4gPiArCQkJ
YXMtPmlkLCBncm91cC0+cmVnKTsKPiA+ICsKPiA+ICsJbXV0ZXhfbG9jaygmc21tdS0+bG9jayk7
Cj4gPiArCXNtbXVfd3JpdGVsKHNtbXUsIGFzLT5pZCAmIDB4N2YsIFNNTVVfUFRCX0FTSUQpOwo+
ID4gKwlwdGJfcmVnID0gc21tdV9yZWFkbChzbW11LCBTTU1VX1BUQl9EQVRBKTsKPiAKPiBJIHRo
aW5rIHRoZSB3aG9sZSB0cmF2ZXJzZSBuZWVkcyBhIGxvY2tpbmcgcHJvdGVjdGlvbiwgZG9lc24n
dCBpdD8KCkhtbS4ucHJvYmFibHkgd291bGQgYmUgbmljZXIuIFdpbGwgbW92ZSB0aGUgbXV0ZXgg
dG8gdGhlIHRvcC4KCj4gPiArCW11dGV4X3VubG9jaygmc21tdS0+bG9jayk7Cj4gPiArCj4gPiAr
CXNlcV9wcmludGYocywgIlBUQl9BU0lEOiAweCV4XG5hcy0+cGRfZG1hOiAweCVsbHhcbiIsIHB0
Yl9yZWcsIGFzLT5wZF9kbWEpOwo+ID4gKwlzZXFfcHV0cyhzLCAie1xuIik7Cj4gPiArCj4gPiAr
CWZvciAocGRfaW5kZXggPSAwOyBwZF9pbmRleCA8IFNNTVVfTlVNX1BERTsgcGRfaW5kZXgrKykg
ewo+ID4gKwkJc3RydWN0IHBhZ2UgKnB0Owo+ID4gKwkJdTMyICphZGRyOwo+ID4gKwo+ID4gKwkJ
aWYgKCFhcy0+Y291bnRbcGRfaW5kZXhdIHx8ICFwZFtwZF9pbmRleF0pCj4gPiArCQkJY29udGlu
dWU7Cj4gPiArCj4gPiArCQlwZGVfY291bnQrKzsKPiA+ICsJCXB0ZV9jb3VudCArPSBhcy0+Y291
bnRbcGRfaW5kZXhdOwo+ID4gKwkJc2VxX3ByaW50ZihzLCAiXHRbJWRdIDB4JXggKCVkKVxuIiwK
PiA+ICsJCQkgICBwZF9pbmRleCwgcGRbcGRfaW5kZXhdLCBhcy0+Y291bnRbcGRfaW5kZXhdKTsK
PiA+ICsJCXB0ID0gYXMtPnB0c1twZF9pbmRleF07Cj4gPiArCQlhZGRyID0gcGFnZV9hZGRyZXNz
KHB0KTsKPiAKPiBUaGlzIG5lZWRzIGFzLT5sb2NrIHByb3RlY3Rpb24uCgpXaWxsIGFkZCB0aGF0
LgoKPiA+ICsJCXNlcV9wdXRzKHMsICJcdHtcbiIpOwo+ID4gKwkJc2VxX3ByaW50ZihzLCAiXHRc
dCUtNXMgJS00cyAlMTJzICUxMnNcbiIsICJQREUiLCAiQVRUUiIsICJQSFlTIiwgIklPVkEiKTsK
PiA+ICsJCWZvciAocHRfaW5kZXggPSAwOyBwdF9pbmRleCA8IFNNTVVfTlVNX1BURTsgcHRfaW5k
ZXgrKykgewo+ID4gKwkJCXU2NCBpb3ZhOwo+ID4gKwo+ID4gKwkJCWlmICghYWRkcltwdF9pbmRl
eF0pCj4gPiArCQkJCWNvbnRpbnVlOwo+ID4gKwo+ID4gKwkJCWlvdmEgPSAoKGRtYV9hZGRyX3Qp
cGRfaW5kZXggJiAoU01NVV9OVU1fUERFIC0gMSkpIDw8IFNNTVVfUERFX1NISUZUOwo+ID4gKwkJ
CWlvdmEgfD0gKChkbWFfYWRkcl90KXB0X2luZGV4ICYgKFNNTVVfTlVNX1BURSAtIDEpKSA8PCBT
TU1VX1BURV9TSElGVDsKPiA+ICsKPiA+ICsJCQlzZXFfcHJpbnRmKHMsICJcdFx0IyUtNGQgMHgl
LTR4IDB4JS0xMmxseCAweCUtMTJsbHhcbiIsCj4gPiArCQkJCSAgIHB0X2luZGV4LCBhZGRyW3B0
X2luZGV4XSA+PiBTTU1VX1BURV9BVFRSX1NISUZULAo+ID4gKwkJCQkgICBTTU1VX1BGTl9QSFlT
KGFkZHJbcHRfaW5kZXhdICYgflNNTVVfUFRFX0FUVFIpLCBpb3ZhKTsKPiA+ICsJCX0KPiA+ICsJ
CXNlcV9wdXRzKHMsICJcdH1cbiIpOwo+ID4gKwl9Cj4gPiArCXNlcV9wdXRzKHMsICJ9XG4iKTsK
PiA+ICsJc2VxX3ByaW50ZihzLCAiVG90YWwgUERFIGNvdW50OiAlZFxuIiwgcGRlX2NvdW50KTsK
PiA+ICsJc2VxX3ByaW50ZihzLCAiVG90YWwgUFRFIGNvdW50OiAlbGxkXG4iLCBwdGVfY291bnQp
Owo+ID4gKwo+ID4gKwlyZXR1cm4gMDsKPiA+ICt9Cj4gPiArCj4gPiArREVGSU5FX1NIT1dfQVRU
UklCVVRFKHRlZ3JhX3NtbXVfbWFwcGluZ3MpOwo+ID4gKwo+ID4gIHN0YXRpYyB2b2lkIHRlZ3Jh
X3NtbXVfZGVidWdmc19pbml0KHN0cnVjdCB0ZWdyYV9zbW11ICpzbW11KQo+ID4gIHsKPiA+ICsJ
Y29uc3Qgc3RydWN0IHRlZ3JhX3NtbXVfc29jICpzb2MgPSBzbW11LT5zb2M7Cj4gPiArCXN0cnVj
dCB0ZWdyYV9zbW11X2dyb3VwX2RlYnVnICpncm91cF9kZWJ1ZzsKPiA+ICsJc3RydWN0IGRldmlj
ZSAqZGV2ID0gc21tdS0+ZGV2Owo+ID4gKwlzdHJ1Y3QgZGVudHJ5ICpkOwo+ID4gKwlpbnQgaTsK
PiA+ICsKPiA+ICsJZ3JvdXBfZGVidWcgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmdyb3Vw
X2RlYnVnKSAqIHNvYy0+bnVtX3N3Z3JvdXBzLCBHRlBfS0VSTkVMKTsKPiAKPiBkZXZtX2tjYWxs
b2MoKQoKV2lsbCBjaGFuZ2UgaXQuCgpUaGFua3MKTmljCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
