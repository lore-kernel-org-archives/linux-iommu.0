Return-Path: <SRS0=I0uF=LX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0439BC11F64
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 02:26:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2916191B
	for <iommu@archiver.kernel.org>; Tue, 29 Jun 2021 02:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2916191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4733960629;
	Tue, 29 Jun 2021 02:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id re-0VRybg5gO; Tue, 29 Jun 2021 02:26:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 229C4605A3;
	Tue, 29 Jun 2021 02:26:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA2C1C001A;
	Tue, 29 Jun 2021 02:26:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F2AEC000E
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 02:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52D8040276
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 02:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q8IEvOK3LBVJ for <iommu@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 02:26:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 155BD400A8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 02:26:52 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id b2so2194729ejg.8
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 19:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=436iowW5G+3AhfaQeY6hf4XjL/XjrpmKBydXgJfyA5c=;
 b=ZgaNzCWSgvDCp3W0+7M7fWukxNa4zA3fTXV1kaarlE9zTzD1fKf8iVqwLsF89vugIC
 9dcjxKh/qW9PROxd2BblzqndRgBWoyP5PWT7Ca0ICMXU2kOiD9nPC5NZCH7Nma3nK2os
 2K/GV+jZyxe0vUCCbu/qFMoo7E6Bazc+6seVNiXIzEemn9BPky8X1/7asxp/mTgIzD1W
 CT63JHVJQej9lyEXcyVFIWegTp3xYHaOiWsZmD4lzu37ZCa2EQox0aV1EIgVm7S2D+fg
 fPQiuXCDISqeRNxnowY3Ocd+N0XVi3/L5afCqOsq3fxqaVRCugUmPevg2EzrnSIm+lMT
 GKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=436iowW5G+3AhfaQeY6hf4XjL/XjrpmKBydXgJfyA5c=;
 b=eAL68KnrvDVfmhjJwMf2RupvPTUXUixZRQgbf8oehRFkxukSeU8C8k6fchodJdubRf
 v9FjHG8TibSK7k1Jn99saeuXqmg050jx0N/uZdhowY64EFthUd2kuD+HV/vLW46ta0wQ
 DQU4CI56V573JFqErUrt1g31MgWIRuSNde1UlG7S74mS43MZAPrNjEmizP7fFH+pDMRG
 lGrQ3+SWI6fPBSo5Y42H0hGSrNO+d7pSEWrd0GOLFwsxdgFRtVVFiG3iNAMQssR/YbNj
 zW2lzO+eMRPL5SNWKJaBmc294Di3fBwYiPZ2AMMnTSbFRS7AQ4mDc8G4Mq9z9XpIgMC2
 mnvw==
X-Gm-Message-State: AOAM532bjTWK/JSYI0Oien0SLmRXmp7YyMfntqJrFMPlrUq6ViCw7dK6
 65NN7Y5MmJpzEUklPrR22hUgGNk9BvivRaTVhzFi
X-Google-Smtp-Source: ABdhPJxZ3odiQnt9cl8KrT87lSdpmglQti+N9ZByUxEwzMT+zjXAVbmRXZy8vuZGeYWwod7YWLY2hOoSJaOTu2UwbQo=
X-Received: by 2002:a17:906:a28e:: with SMTP id
 i14mr26931454ejz.395.1624933611032; 
 Mon, 28 Jun 2021 19:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <adfb2be9-9ed9-ca37-ac37-4cd00bdff349@redhat.com>
 <CACycT3tAON+-qZev+9EqyL2XbgH5HDspOqNt3ohQLQ8GqVK=EA@mail.gmail.com>
 <1bba439f-ffc8-c20e-e8a4-ac73e890c592@redhat.com>
 <CACycT3uzMJS7vw6MVMOgY4rb=SPfT2srV+8DPdwUVeELEiJgbA@mail.gmail.com>
 <0aeb7cb7-58e5-1a95-d830-68edd7e8ec2e@redhat.com>
 <CACycT3uuooKLNnpPHewGZ=q46Fap2P4XCFirdxxn=FxK+X1ECg@mail.gmail.com>
 <e4cdee72-b6b4-d055-9aac-3beae0e5e3e1@redhat.com>
 <CACycT3u8=_D3hCtJR+d5BgeUQMce6S7c_6P3CVfvWfYhCQeXFA@mail.gmail.com>
 <d2334f66-907c-2e9c-ea4f-f912008e9be8@redhat.com>
 <CACycT3uCSLUDVpQHdrmuxSuoBDg-4n22t+N-Jm2GoNNp9JYB2w@mail.gmail.com>
 <48cab125-093b-2299-ff9c-3de8c7c5ed3d@redhat.com>
 <CACycT3tS=10kcUCNGYm=dUZsK+vrHzDvB3FSwAzuJCu3t+QuUQ@mail.gmail.com>
 <b10b3916-74d4-3171-db92-be0afb479a1c@redhat.com>
 <CACycT3vpMFbc9Fzuo9oksMaA-pVb1dEVTEgjNoft16voryPSWQ@mail.gmail.com>
 <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
In-Reply-To: <d7e42109-0ba6-3e1a-c42a-898b6f33c089@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 29 Jun 2021 10:26:40 +0800
Message-ID: <CACycT3u9-id2DxPpuVLtyg4tzrUF9xCAGr7nBm=21HfUJJasaQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in
 Userspace
To: Jason Wang <jasowang@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

T24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgMTI6NDAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzYvMjUg5LiL5Y2IMTI6MTksIFlvbmdqaSBY
aWUg5YaZ6YGTOgo+ID4+IDJiKSBmb3Igc2V0X3N0YXR1cygpOiBzaW1wbHkgcmVsYXkgdGhlIG1l
c3NhZ2UgdG8gdXNlcnNwYWNlLCByZXBseSBpcyBubwo+ID4+IG5lZWRlZC4gVXNlcnNwYWNlIHdp
bGwgdXNlIGEgY29tbWFuZCB0byB1cGRhdGUgdGhlIHN0YXR1cyB3aGVuIHRoZQo+ID4+IGRhdGFw
YXRoIGlzIHN0b3AuIFRoZSB0aGUgc3RhdHVzIGNvdWxkIGJlIGZldGNoZWQgdmlhIGdldF9zdGF0
cygpLgo+ID4+Cj4gPj4gMmIgbG9va3MgbW9yZSBzcGVjIGNvbXBsYWludC4KPiA+Pgo+ID4gTG9v
a3MgZ29vZCB0byBtZS4gQW5kIEkgdGhpbmsgd2UgY2FuIHVzZSB0aGUgcmVwbHkgb2YgdGhlIG1l
c3NhZ2UgdG8KPiA+IHVwZGF0ZSB0aGUgc3RhdHVzIGluc3RlYWQgb2YgaW50cm9kdWNpbmcgYSBu
ZXcgY29tbWFuZC4KPiA+Cj4KPiBKdXN0IG5vdGljZSB0aGlzIHBhcnQgaW4gdmlydGlvX2ZpbmFs
aXplX2ZlYXR1cmVzKCk6Cj4KPiAgICAgICAgICB2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJ
T19DT05GSUdfU19GRUFUVVJFU19PSyk7Cj4gICAgICAgICAgc3RhdHVzID0gZGV2LT5jb25maWct
PmdldF9zdGF0dXMoZGV2KTsKPiAgICAgICAgICBpZiAoIShzdGF0dXMgJiBWSVJUSU9fQ09ORklH
X1NfRkVBVFVSRVNfT0spKSB7Cj4KPiBTbyB3ZSBubyByZXBseSBkb2Vzbid0IHdvcmsgZm9yIEZF
QVRVUkVTX09LLgo+Cj4gU28gbXkgdW5kZXJzdGFuZGluZyBpczoKPgo+IDEpIFdlIG11c3Qgbm90
IHVzZSBub3JlcGx5IGZvciBzZXRfc3RhdHVzKCkKPiAyKSBXZSBjYW4gdXNlIG5vcmVwbHkgZm9y
IGdldF9zdGF0dXMoKSwgYnV0IGl0IHJlcXVpcmVzIGEgbmV3IGlvY3RsIHRvCj4gdXBkYXRlIHRo
ZSBzdGF0dXMuCj4KPiBTbyBpdCBsb29rcyB0byBtZSB3ZSBuZWVkIHN5bmNocm9uaXplIGZvciBi
b3RoIGdldF9zdGF0dXMoKSBhbmQKPiBzZXRfc3RhdHVzKCkuCj4KCldlIHNob3VsZCBub3Qgc2Vu
ZCBtZXNzYWdlcyB0byB1c2Vyc3BhY2UgaW4gdGhlIEZFQVRVUkVTX09LIGNhc2UuIFNvCnRoZSBz
eW5jaHJvbml6YXRpb24gaXMgbm90IG5lY2Vzc2FyeS4KClRoYW5rcywKWW9uZ2ppCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
