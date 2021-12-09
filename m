Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F183C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D5BF424D0;
	Thu,  9 Dec 2021 19:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gQMhMhP1p5j; Thu,  9 Dec 2021 19:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE56D4010A;
	Thu,  9 Dec 2021 19:58:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF474C001E;
	Thu,  9 Dec 2021 19:58:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B877FC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92AC9403E5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id se0gXTCGCFXP for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:58:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48328403C5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:58:18 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id a37so9570163ljq.13
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IEeVho3+ZGBFM/fmNQDb763cjTKB84TOM9P4baD+LcY=;
 b=ZSnnmgt9r1Dv1p+tRXvYN9WzST5JpCAxCxgSuL7TlN6cW9Q/JXeGduQ2X34ucOUGi+
 +9yFJpHOUcNbHiyi2+fJf9sH51D0j/+5f5Nd1HW51hOkKsuE9h7+xSZJP9TJ66fLlbsG
 PWTk0oUXPgVvR0hvUTshpioOFkDgQI5uEgPyjxAJl2QS0DfVBGDCzZzThpLF8xOh4Dit
 sMY3abt0z1bjsyrC1aBSpUdfboeRsnhEluMJXv3qqNywhSR8c37fZIQTc8lvx8GY1EXX
 hr91mDCOUjAZEOgIo2izaMZwK1hxRD0Pbcy0jIcrpAGhEQ5I7cKFVKR2aJyK+btWO0Bk
 WGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IEeVho3+ZGBFM/fmNQDb763cjTKB84TOM9P4baD+LcY=;
 b=nLaaz2DmxwK/mIqC9sDK+PEEqODvZGBjnpxdiACYChqG6oUzNceeCcR0th9mh6q394
 vw4SC4YXlFQKcWjTzNm7R+wylAgWFlvGkyzLYluCBoL8FLUI43sgJU6yqknd7EhmAGWZ
 S7LGi4c+j3ls+2+v/wZbVQRgzgwIwBfKKOn9xiCv1GZgmTFN/x+onIq/I3PGSgvtvM1A
 /hw28PRyjDwdJF8fbT960NGM1IFmi+ZrhG+W09C+wixU6hqPASsod+icOlrH7I4FLSjz
 /WgdCi3G/6WuQKnZEAC0MOm5kjAY694e5aouVedMcUnzDlG3rvGh/+4CywCMrPefuLok
 lljQ==
X-Gm-Message-State: AOAM530mBF2sedU3cF1z/XGT2zJAk/w19XhyCJrlrduUX/Eoc1aijBkm
 nLBwRBSYp1417e3QlZrW11M=
X-Google-Smtp-Source: ABdhPJwpdCSPAcMKjslAF7mr6CyWEIaJXYq48zjgf+9WJ8qhS9zhxOTI3ZWKOjnu7CsVOj9lfY5nfg==
X-Received: by 2002:a2e:a378:: with SMTP id i24mr8805987ljn.290.1639079895951; 
 Thu, 09 Dec 2021 11:58:15 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id w15sm84215lfe.184.2021.12.09.11.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 11:58:15 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <5713902d-823b-63ca-00c9-aa6c64c1af41@gmail.com>
 <20211209193253.GB34762@Asurada-Nvidia>
 <97a32c9a-2ec7-6579-7d8d-026d6f820a3e@gmail.com>
 <20211209195128.GA35526@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a4002ad9-70d9-22d1-7bcc-ae4f712187c8@gmail.com>
Date: Thu, 9 Dec 2021 22:58:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209195128.GA35526@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

MDkuMTIuMjAyMSAyMjo1MSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBEZWMg
MDksIDIwMjEgYXQgMTA6NDA6NDJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+
Pgo+Pgo+PiAwOS4xMi4yMDIxIDIyOjMyLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9u
IFRodSwgRGVjIDA5LCAyMDIxIGF0IDA1OjQ3OjE4UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3
cm90ZToKPj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cwo+Pj4+Cj4+Pj4KPj4+PiAwOS4xMi4yMDIxIDEwOjM4LCBOaWNvbGluIENoZW4g
0L/QuNGI0LXRgjoKPj4+Pj4gQEAgLTU0NSw2ICs3MTksMTUgQEAgc3RhdGljIHZvaWQgdGVncmFf
c21tdV9kZXRhY2hfYXMoc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUsCj4+Pj4+ICAgICAgICAgICAg
ICAgaWYgKGdyb3VwLT5zd2dycCAhPSBzd2dycCkKPj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOwo+Pj4+PiAgICAgICAgICAgICAgIGdyb3VwLT5hcyA9IE5VTEw7Cj4+Pj4+ICsK
Pj4+Pj4gKyAgICAgICAgICAgICBpZiAoc21tdS0+ZGVidWdmc19tYXBwaW5ncykgewo+Pj4+IERv
IHdlIHJlYWxseSBuZWVkIHRoaXMgY2hlY2s/Cj4+Pj4KPj4+PiBMb29rcyBsaWtlIGFsbCBkZWJ1
Z2ZzX2NyZWF0ZV9kaXIoKSB1c2FnZXMgaW4gdGhpcyBkcml2ZXIgYXJlIGluY29ycmVjdCwKPj4+
PiB0aGF0IGZ1bmN0aW9uIG5ldmVyIHJldHVybnMgTlVMTC4gUGxlYXNlIGZpeCB0aGlzLgo+Pj4g
ZGVidWdmc19jcmVhdGVfZGlyIHJldHVybnMgRVJSX1BUUiBvbiBmYWlsdXJlLiBTbyBoZXJlIHNo
b3VsZCBiZQo+Pj4gdG8gY2hlY2sgIUlTX0VSUi4gVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQh
Cj4+Pgo+Pgo+PiBBbGwgZGVidWdmcyBmdW5jdGlvbnMgaGFuZGxlIElTX0VSUigpLiBHcmVnS0gg
cmVtb3ZlcyBhbGwgc3VjaCBjaGVja3MKPj4gYWxsIG92ZXIgdGhlIGtlcm5lbC4gU28gdGhlIGNo
ZWNrIHNob3VsZG4ndCBiZSBuZWVkZWQgYXQgYWxsLCBwbGVhc2UKPj4gcmVtb3ZlIGl0IGlmIGl0
J3MgdW5uZWVkZWQgb3IgcHJvdmUgdGhhdCBpdCdzIG5lZWRlZC4KPiAKPiBkZWJ1Z2ZzX2NyZWF0
ZV9maWxlIGNhbiBoYW5kbGUgYSBOVUxMIHBhcmVudCwgYnV0IG5vdCBFUlJfUFRSIG9uZSwKPiBh
bmQgdGhlbiBpdCBwdXRzIHRoZSBuZXcgbm9kZSB1bmRlciB0aGUgcm9vdC4gU28gZWl0aGVyIHBh
c3NpbmcgYW4KPiBFUlJfUFRSIHBhcmVudCBvciBjcmVhdGluZyBvcnBoYW4gbm9kZXMgaGVyZSBk
b2Vzbid0IHNvdW5kIGdvb2QuLi4KPiAKCldoYXQgbWFrZXMgeW91IHNheSBzbz8gUGxlYXNlIHNo
b3cgdGhlIGV4YWN0IHNvdXJjZSBjb2RlIHRoYXQgd2lsbCBjYXVzZQp0aGUgcHJvYmxlbS4KClRo
ZSBzbW11LT5kZWJ1Z2ZzX21hcHBpbmdzIGNhbid0IGV2ZXIgYmUgTlVMTCBhbmQgZGVidWdmc19j
cmVhdGVfZmlsZQpoYW5kbGVzIHRoZSBFUlJfUFRSIFsxXVsyXS4KClsxXSBodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2ZzL2RlYnVnZnMvaW5vZGUuYyNMMzk3
CgpbMl0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9mcy9k
ZWJ1Z2ZzL2lub2RlLmMjTDMzMApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
