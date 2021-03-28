Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68709C433C1
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 15:36:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BE16197E
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 15:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BE16197E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AE93403CC;
	Sun, 28 Mar 2021 15:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ohtaYlKB9ps; Sun, 28 Mar 2021 15:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C938F403CB;
	Sun, 28 Mar 2021 15:36:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AEFEC000C;
	Sun, 28 Mar 2021 15:36:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA0CC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 15:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01C2683B5B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 15:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_YjOSe93ACV for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 15:36:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F24C083B4C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 15:36:46 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 184so13090146ljf.9
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4McCAtm/bgYfEvyy6rwiTH7xGHWa8NKknSEfmeF9cro=;
 b=JjOH+vLDlZTRgODNsnxEA3Qad9ZZO7kp9drxRf4eVuyjWvJSt7y5EgCqyQsiiGH+1H
 CXF3FBFNig0cAK1y4S8Gd9J/sMUOCkKCc6f0zFlc5xmMKgpqKpK56JcrIYs0bF+U76um
 yHJY0nBos3xXxZW/As3///NEgv8DEFC5le2pX7biJuw0Q27RdrCkyP+xZ+UUPLw0POTW
 eaCu6VLrtSsOEoLztxp+EGGf2eqhkKwLYACYyTKLntTTiRzvsjzN3HeTW6n5tbxe6/Tv
 FKjMAKJEb2xBrmWjkNdQxBNZhW/dLQRcsPg1e0Zy5DhgkRILQslHn4nJppuuj2RemcyK
 yqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4McCAtm/bgYfEvyy6rwiTH7xGHWa8NKknSEfmeF9cro=;
 b=Eh6LevFbejR/PSwwzdOAGCJbNFSVlC9QH21f3R3BY4G5oxrlHN2Pz7fDfKU7HPfRRX
 lISfkYrMy+KII4YyWQfgZhOcsCeDOvVuyx9tPln0USvlzFd7rAFOKMxliWmqYejDnqEg
 g0olL2Iw2CI6t9QHxB8nzYUDP+k/KGaG2a8hwImkJiyj0tYEToUl8tElr/v3ZXvRoqRE
 SeU15Rud5O6ByDLMuzicCgMQVbLVVUdFPwgtgKVJtihRtMqjzs1HXGgy4w5hWQWxW05o
 i6M2W+s7Q/7erX1evozpOB9cWadwwD2GNdixvohEyYyfHVtxVlUJsv7ji0WkJkBguMP/
 KaAA==
X-Gm-Message-State: AOAM5331grudSOIZ47lRXmC84/vTqjQOBrISislgNMWzdwW6OT8ZXTJj
 ia2HeJ6TOOEbycWbUkzwKLA=
X-Google-Smtp-Source: ABdhPJzfJzm0Y5jnPOR/i07q0qCt3tFIfqvC/u2H0GBy/FuPgEqkpdtkZiKccT0LosHkzt1ZS6bgMg==
X-Received: by 2002:a2e:9a0a:: with SMTP id o10mr15113901lji.243.1616945804830; 
 Sun, 28 Mar 2021 08:36:44 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:b259:a10:76ff:fe69:21b6?
 ([2a00:1370:814d:b259:a10:76ff:fe69:21b6])
 by smtp.googlemail.com with ESMTPSA id d26sm1512544lfl.84.2021.03.28.08.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Mar 2021 08:36:44 -0700 (PDT)
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
From: Dmitry Osipenko <digetx@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
 <20210223021343.GA6539@Asurada-Nvidia>
 <79bb1248-497f-8adf-663b-74448bea3849@gmail.com>
 <20210225062742.GA13353@Asurada-Nvidia>
 <ee0f40f4-dffe-2987-5d4b-c5896f27ec24@gmail.com>
 <20210302230856.GA22992@Asurada-Nvidia>
 <4a407ad8-33cb-94e9-398a-78fa65178e08@gmail.com>
 <94f8f949-197c-e8fc-38d9-74360dca8c51@gmail.com>
Message-ID: <4e2391af-8423-bee6-e45b-f4b434b1e9b0@gmail.com>
Date: Sun, 28 Mar 2021 18:36:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <94f8f949-197c-e8fc-38d9-74360dca8c51@gmail.com>
Content-Language: en-US
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, will@kernel.org,
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

MjguMDMuMjAyMSAxODoyNSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDMuMDMuMjAy
MSAxMjo0NywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+IDAzLjAzLjIwMjEgMDI6MDgs
IE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+Pj4gT24gU2F0LCBGZWIgMjcsIDIwMjEgYXQgMTI6
NTk6MTdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+IDI1LjAyLjIwMjEgMDk6
MjcsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+Pj4+IC4uLgo+Pj4+Pj4gVGhlIHBhcnRpYWxs
eSByZXZlcnQgc2hvdWxkIGJlIG9rYXksIGJ1dCBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IG1h
a2VzCj4+Pj4+PiBkaWZmZXJlbmNlIGZvciBUMTI0IHNpbmNlIEkgZG9uJ3Qgc2VlIHRoYXQgcHJv
YmxlbSBvbiBUMzAsIHdoaWNoIGFsc28KPj4+Pj4+IGhhcyBhY3RpdmUgZGlzcGxheSBhdCBhIGJv
b3QgdGltZS4KPj4+Pj4gSG1tLi5kbyB5b3Ugc2VlIC0+YXR0YWNoX2RldigpIGlzIGNhbGxlZCBm
cm9tIGhvc3QxeF9jbGllbnRfaW9tbXVfYXR0YWNoCj4+Pj4+IG9yIGZyb20gb2ZfZG1hX2NvbmZp
Z3VyZV9pZC9hcmNoX3NldHVwX2RtYV9vcHM/Cj4+Pj4+Cj4+Pj4gSSBhcHBsaWVkIHlvdXJzIGRl
YnVnLXBhdGNoLCBwbGVhc2Ugc2VlIGRtZXNnLnR4dCBhdHRhY2hlZCB0byB0aGUgZW1haWwuCj4+
Pj4gU2VlbXMgcHJvYmUtZGVmZXIgb2YgdGhlIHRlZ3JhLWRjIGRyaXZlciBwcmV2ZW50cyB0aGUg
aW1wbGljaXQKPj4+PiB0ZWdyYV9zbW11X2F0dGFjaF9kZXYsIHNvIGl0IGhhcHBlbnMgdG8gd29y
ayBieSBhY2NpZGVudC4KPj4+PiBbICAgIDAuMzI3ODI2XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzog
LS0tLS0tLXRlZ3JhX3NtbXVfb2ZfeGxhdGU6IGlkIDEKPj4+PiBbICAgIDAuMzI4NjQxXSBbPGMw
NTJlYzc1Pl0gKHRlZ3JhX3NtbXVfb2ZfeGxhdGUpIGZyb20gWzxjMDUyZTU5MT5dIChvZl9pb21t
dV94bGF0ZSsweDUxLzB4NzApCj4+Pj4gWyAgICAwLjMyODc0MF0gWzxjMDUyZTU5MT5dIChvZl9p
b21tdV94bGF0ZSkgZnJvbSBbPGMwNTJlNmQ3Pl0gKG9mX2lvbW11X2NvbmZpZ3VyZSsweDEyNy8w
eDE1MCkKPj4+PiBbICAgIDAuMzI4ODk2XSBbPGMwNTJlNmQ3Pl0gKG9mX2lvbW11X2NvbmZpZ3Vy
ZSkgZnJvbSBbPGMwNzNmNjk3Pl0gKG9mX2RtYV9jb25maWd1cmVfaWQrMHgxZmIvMHgyZWMpCj4+
Pj4gWyAgICAwLjMyOTA2MF0gWzxjMDczZjY5Nz5dIChvZl9kbWFfY29uZmlndXJlX2lkKSBmcm9t
IFs8YzA1OTc0M2Y+XSAocmVhbGx5X3Byb2JlKzB4N2IvMHgyYTApCj4+Pj4gWyAgICAwLjMzMTQz
OF0gdGVncmEtZGMgNTQyMDAwMDAuZGM6IC0tLS0tLS0tdGVncmFfc21tdV9wcm9iZV9kZXZpY2Us
IDgyMgo+Pj4+IFsgICAgMC4zMzIyMzRdIFs8YzA1MmViZWQ+XSAodGVncmFfc21tdV9wcm9iZV9k
ZXZpY2UpIGZyb20gWzxjMDUyYmQ2ZD5dIChfX2lvbW11X3Byb2JlX2RldmljZSsweDM1LzB4MWM0
KQo+Pj4+IFsgICAgMC4zMzIzOTFdIFs8YzA1MmJkNmQ+XSAoX19pb21tdV9wcm9iZV9kZXZpY2Up
IGZyb20gWzxjMDUyYzNjZD5dIChpb21tdV9wcm9iZV9kZXZpY2UrMHgxOS8weGVjKQo+Pj4+IFsg
ICAgMC4zMzI1NDVdIFs8YzA1MmMzY2Q+XSAoaW9tbXVfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA1
MmU2YWI+XSAob2ZfaW9tbXVfY29uZmlndXJlKzB4ZmIvMHgxNTApCj4+Pj4gWyAgICAwLjMzMjcw
MV0gWzxjMDUyZTZhYj5dIChvZl9pb21tdV9jb25maWd1cmUpIGZyb20gWzxjMDczZjY5Nz5dIChv
Zl9kbWFfY29uZmlndXJlX2lkKzB4MWZiLzB4MmVjKQo+Pj4+IFsgICAgMC4zMzI4MDRdIFs8YzA3
M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9pZCkgZnJvbSBbPGMwNTk3NDNmPl0gKHJlYWxseV9w
cm9iZSsweDdiLzB4MmEwKQo+Pj4+IFsgICAgMC4zMzUyMDJdIHRlZ3JhLWRjIDU0MjAwMDAwLmRj
OiAtLS0tLS0tLS1pb21tdV9ncm91cF9nZXRfZm9yX2RldiwgMTU3Mgo+Pj4+IFsgICAgMC4zMzUy
OTJdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLS10ZWdyYV9zbW11X2RldmljZV9ncm91
cCwgODYyCj4+Pj4gWyAgICAwLjMzNTQ3NF0gdGVncmEtZGMgNTQyMDAwMDAuZGM6IC0tLS0tLS0t
LXRlZ3JhX3NtbXVfZGV2aWNlX2dyb3VwLCA5MDk6IDE6IGRybQo+Pj4+IFsgICAgMC4zMzU1NjZd
IHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLS1pb21tdV9ncm91cF9nZXRfZm9yX2Rldiwg
MTU3NAo+Pj4+IFsgICAgMC4zMzU3MThdIHRlZ3JhLWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLS1p
b21tdV9ncm91cF9hZGRfZGV2aWNlLCA4NTgKPj4+PiBbICAgIDAuMzM1ODYyXSB0ZWdyYS1kYyA1
NDIwMDAwMC5kYzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDEKPj4+PiBbICAgIDAuMzM1OTU1XSB0
ZWdyYS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0taW9tbXVfYWxsb2NfZGVmYXVsdF9kb21haW4s
IDE1NDM6IHR5cGUgMwo+Pj4+IFsgICAgMC4zMzYxMDFdIGlvbW11OiAtLS0tLS1pb21tdV9ncm91
cF9hbGxvY19kZWZhdWx0X2RvbWFpbjogcGxhdGZvcm0sIChudWxsKSwgZHJtCj4+Pj4gWyAgICAw
LjMzNjE4N10gLS0tLS0tLS0tdGVncmFfc21tdV9kb21haW5fYWxsb2MsIDI4NDogdHlwZSAzCj4+
PiAgWyAgICAwLjMzNjk2OF0gWzxjMGEwZmY0NT5dICh0ZWdyYV9zbW11X2RvbWFpbl9hbGxvYykg
ZnJvbSBbPGMwYTBmODdiPl0gKGlvbW11X2dyb3VwX2FsbG9jX2RlZmF1bHRfZG9tYWluKzB4NGIv
MHhmYSkKPj4+PiBbICAgIDAuMzM3MTI3XSBbPGMwYTBmODdiPl0gKGlvbW11X2dyb3VwX2FsbG9j
X2RlZmF1bHRfZG9tYWluKSBmcm9tIFs8YzA1MmM0MWQ+XSAoaW9tbXVfcHJvYmVfZGV2aWNlKzB4
NjkvMHhlYykKPj4+PiBbICAgIDAuMzM3Mjg1XSBbPGMwNTJjNDFkPl0gKGlvbW11X3Byb2JlX2Rl
dmljZSkgZnJvbSBbPGMwNTJlNmFiPl0gKG9mX2lvbW11X2NvbmZpZ3VyZSsweGZiLzB4MTUwKQo+
Pj4+IFsgICAgMC4zMzc0NDFdIFs8YzA1MmU2YWI+XSAob2ZfaW9tbXVfY29uZmlndXJlKSBmcm9t
IFs8YzA3M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9pZCsweDFmYi8weDJlYykKPj4+PiBbICAg
IDAuMzM3NTk5XSBbPGMwNzNmNjk3Pl0gKG9mX2RtYV9jb25maWd1cmVfaWQpIGZyb20gWzxjMDU5
NzQzZj5dIChyZWFsbHlfcHJvYmUrMHg3Yi8weDJhMCkKPj4+PiBbICAgIDAuMzM5OTEzXSB0ZWdy
YS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0taW9tbXVfcHJvYmVfZGV2aWNlLCAyNzIKPj4+PiBb
ICAgIDAuMzQ4MTQ0XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogZmFpbGVkIHRvIHByb2JlIFJHQiBv
dXRwdXQ6IC01MTcKPj4+IEhtbS4ubm90IHN1cmUgd2hlcmUgdGhpcyBFUFJPQkVfREVGRVIgY29t
ZXMgZnJvbS4KPj4gREMgZHJpdmVyIG9uIE5leHVzIDcgZGVwZW5kcyBvbiBMVkRTIGJyaWRnZSBh
bmQgZGlzcGxheSBwYW5lbCwgd2hpY2gKPj4gY2F1c2UgdGhlIHByb2JlIGRlZmVyLgo+Pgo+Pj4g
QnV0IHlvdSBhcmUgcmlnaHQsCj4+PiBhcyBvZl9kbWFfY29uZmlndXJlX2lkKCkgcmV0dXJucyBi
ZWNhdXNlIG9mIHRoYXQgc28gaXQgZGlkbid0IHJ1biB0bwo+Pj4gYXJjaF9zZXR1cF9kbWFfb3Bz
KCkgY2FsbCwgd2hpY2ggYWxsb2NhdGVzIGFuIFVOTUFOQUdFRCBpb21tdSBkb21haW4KPj4+IGFu
ZCBhdHRhY2hlcyBEQyB0byBpdCBvbiBUZWdyYTEyNC4KPj4+Cj4+PiBCeSB0aGUgd2F5LCBhbnlv
bmUgY2FuIGFjY2VwdCB0aGlzIGNoYW5nZT8gSXQgZG9lc24ndCBmZWVsIHJpZ2h0IHRvCj4+PiBs
ZWF2ZSBhIHJlZ3Jlc3Npb24gaW4gdGhlIG5ld2VyIHJlbGVhc2UuLi4KPiAKPiBHdXlzLCBJIGhh
dmUgYSBnb29kIGFuZCBiYWQgbmV3cy4KPiAKPiBUaGUgZ29vZCBuZXdzIGlzIHRoYXQgSSBmaWd1
cmVkIG91dCB3aHkgSSBkaWRuJ3Qgc2VlIHRoaXMgcHJvYmxlbSBvbgo+IE5leHVzIDcgYW5kIHRo
ZSByZWFzb24gaXMgdGhhdCBJIGhhZCBDT05GSUdfQVJNX0RNQV9VU0VfSU9NTVU9bi4KPiAKPiBU
aGUgb3RoZXIgZ29vZCBuZXdzIGlzIHRoYXQgSSBoYXZlIGEgc2ltcGxlIHdvcmthcm91bmQgd2hp
Y2ggZml4ZXMgdGhlCj4gaW1wbGljaXQgSU9NTVUgcHJvYmxlbSBieSBkZWZlcnJpbmcgdGhlIEFT
SUQgZW5hYmxpbmcgZm9yIGRpc3BsYXkgY2xpZW50cy4KPiAKPiBUaGUgYmFkIG5ld3MgaXMgdGhh
dCBDT05GSUdfQVJNX0RNQV9VU0VfSU9NTVU9eSBicmVha3MgR1BVIChEUk0sIGhvc3QxeCkKPiBk
cml2ZXJzIGJlY2F1c2UgdGhleSBhcmVuJ3QgcHJvcGVybHkgcHJlcGFyZWQgdG8gdGhpcyBjYXNl
IGFuZAo+IENPTkZJR19BUk1fRE1BX1VTRV9JT01NVSBpcyBlbmFibGVkIGluIG11bHRpLXBsYXRm
b3JtIGtlcm5lbCBjb25maWcuIEkKPiB3aWxsIHRyeSB0byBmaXggdXAgdGhlIGRyaXZlcnMsIGJ1
dCBub3Qgc3VyZSBob3cgbXVjaCB0aW1lIHRoaXMgbWF5IHRha2UuCj4gCgpPaCwgYWN0dWFsbHkg
dGhlIG9sZCB3b3JrYXJvdW5kIHdpdGggYXJtX2lvbW11X2RldGFjaF9kZXZpY2UoKSBzdGlsbAp3
b3Jrcywgc28gd2UganVzdCBuZWVkIHRvIGJyaW5nIGl0IGJhY2suIEknbGwgcHJlcGFyZSB0aGUg
cGF0Y2hlcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
