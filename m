Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A2C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 22:19:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C0464EC3
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 22:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C0464EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67C6D842F1;
	Wed,  3 Mar 2021 22:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gLpd9y59txfN; Wed,  3 Mar 2021 22:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 518E784312;
	Wed,  3 Mar 2021 22:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24A00C000B;
	Wed,  3 Mar 2021 22:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BDE7C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 22:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DE6240173
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 22:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hyi7Bb_dDXhy for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 22:19:02 +0000 (UTC)
X-Greylist: delayed 09:25:07 by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1CD24016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 22:19:02 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id x24so82128pfn.5
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=L3H573ByBrOBb02mX24lIDWny2m/571jx6B2ljmNh9I=;
 b=nsm0YN6OwiBC+K4bksH/UKwwlqlHN8/6zHYehmIUvbFMy2m/6ZdXis7+k2M95kBthr
 3vFkaz4iRTr4hgC3hDjLpsq4Cmn48gblX4IBupXb0rLWaVoccuf3m28hhu1tNb4F6jrf
 gSzNoOkLAcV7+u1XMmPFrNgnOUeOTGbF1GDwWjDuNK5TBFsmY+E7GGl9HyBGgyxk1vBR
 rkGvERwp9pKlgNrDRNUq6vuD8JNscgDWtQ0rlBdHQf6YBC8AwfVn4fsn/oaJTVjmnfPi
 EowMgu5d2N1iyjQluoRtsZNqUVQQDlIvye2+UFCy3LA32Vq7eJ1yxGmgjbcHwzD//e0K
 ZMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=L3H573ByBrOBb02mX24lIDWny2m/571jx6B2ljmNh9I=;
 b=Eqi47U0IjmKUChnVNlXKdKcS8xkVBx8SfXbDINRn3o7Eyn8d9eFigusB57FK6rHSWG
 ON8p9ETNGDCp/e6mE6kJsXaJwmf2l0sxtDXmVwBfjRuh+L8U/sYoxzK5HOp8bZ92d41Y
 DnTtRST7uKgZGtqzOo2VLLXRgxfBnJLJsbVSWLLNjbUsMyR6Ua+9w5/Fw39La1p7OtuY
 9khJ0qOKpb/kCQ/UvD3irRdh43e/DqzgfntgAWcfcSo7G+JYmPviNm7FB5iAyXHH9WtY
 LljMfoPMinKkLbqyUCtl8GgHoNpW7Flh8EYA5ZxPmDDJ+5Euik53uqJ7hespISD5zGZt
 v0Iw==
X-Gm-Message-State: AOAM530fYyv0LkjK0XAO+/T7SgrBCgkiZu/2zob6vAqBncbMeF38MXJe
 A4hYVZtpcZ6XzDknUISQS2j0Pg/qtLM71g==
X-Google-Smtp-Source: ABdhPJy0A2GP1mYe3NRIqvfFKpxiK0+TByyD12Ql5KhraG55vVsAP4N42M2J0O49jTzKkY6gGdMqzg==
X-Received: by 2002:a65:46c7:: with SMTP id n7mr20247495pgr.267.1614726683722; 
 Tue, 02 Mar 2021 15:11:23 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id y12sm7959008pgs.71.2021.03.02.15.11.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Mar 2021 15:11:23 -0800 (PST)
Date: Tue, 2 Mar 2021 15:08:59 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <20210302230856.GA22992@Asurada-Nvidia>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
 <20210223021343.GA6539@Asurada-Nvidia>
 <79bb1248-497f-8adf-663b-74448bea3849@gmail.com>
 <20210225062742.GA13353@Asurada-Nvidia>
 <ee0f40f4-dffe-2987-5d4b-c5896f27ec24@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee0f40f4-dffe-2987-5d4b-c5896f27ec24@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org
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

T24gU2F0LCBGZWIgMjcsIDIwMjEgYXQgMTI6NTk6MTdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDI1LjAyLjIwMjEgMDk6MjcsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+IC4u
Lgo+ID4+IFRoZSBwYXJ0aWFsbHkgcmV2ZXJ0IHNob3VsZCBiZSBva2F5LCBidXQgaXQncyBub3Qg
Y2xlYXIgdG8gbWUgd2hhdCBtYWtlcwo+ID4+IGRpZmZlcmVuY2UgZm9yIFQxMjQgc2luY2UgSSBk
b24ndCBzZWUgdGhhdCBwcm9ibGVtIG9uIFQzMCwgd2hpY2ggYWxzbwo+ID4+IGhhcyBhY3RpdmUg
ZGlzcGxheSBhdCBhIGJvb3QgdGltZS4KPiA+IAo+ID4gSG1tLi5kbyB5b3Ugc2VlIC0+YXR0YWNo
X2RldigpIGlzIGNhbGxlZCBmcm9tIGhvc3QxeF9jbGllbnRfaW9tbXVfYXR0YWNoCj4gPiBvciBm
cm9tIG9mX2RtYV9jb25maWd1cmVfaWQvYXJjaF9zZXR1cF9kbWFfb3BzPwo+ID4gCj4gCj4gSSBh
cHBsaWVkIHlvdXJzIGRlYnVnLXBhdGNoLCBwbGVhc2Ugc2VlIGRtZXNnLnR4dCBhdHRhY2hlZCB0
byB0aGUgZW1haWwuCj4gU2VlbXMgcHJvYmUtZGVmZXIgb2YgdGhlIHRlZ3JhLWRjIGRyaXZlciBw
cmV2ZW50cyB0aGUgaW1wbGljaXQKPiB0ZWdyYV9zbW11X2F0dGFjaF9kZXYsIHNvIGl0IGhhcHBl
bnMgdG8gd29yayBieSBhY2NpZGVudC4KCj4gWyAgICAwLjMyNzgyNl0gdGVncmEtZGMgNTQyMDAw
MDAuZGM6IC0tLS0tLS10ZWdyYV9zbW11X29mX3hsYXRlOiBpZCAxCj4gWyAgICAwLjMyODY0MV0g
WzxjMDUyZWM3NT5dICh0ZWdyYV9zbW11X29mX3hsYXRlKSBmcm9tIFs8YzA1MmU1OTE+XSAob2Zf
aW9tbXVfeGxhdGUrMHg1MS8weDcwKQo+IFsgICAgMC4zMjg3NDBdIFs8YzA1MmU1OTE+XSAob2Zf
aW9tbXVfeGxhdGUpIGZyb20gWzxjMDUyZTZkNz5dIChvZl9pb21tdV9jb25maWd1cmUrMHgxMjcv
MHgxNTApCj4gWyAgICAwLjMyODg5Nl0gWzxjMDUyZTZkNz5dIChvZl9pb21tdV9jb25maWd1cmUp
IGZyb20gWzxjMDczZjY5Nz5dIChvZl9kbWFfY29uZmlndXJlX2lkKzB4MWZiLzB4MmVjKQo+IFsg
ICAgMC4zMjkwNjBdIFs8YzA3M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9pZCkgZnJvbSBbPGMw
NTk3NDNmPl0gKHJlYWxseV9wcm9iZSsweDdiLzB4MmEwKQo+IFsgICAgMC4zMzE0MzhdIHRlZ3Jh
LWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLXRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlLCA4MjIKPiBb
ICAgIDAuMzMyMjM0XSBbPGMwNTJlYmVkPl0gKHRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNlKSBmcm9t
IFs8YzA1MmJkNmQ+XSAoX19pb21tdV9wcm9iZV9kZXZpY2UrMHgzNS8weDFjNCkKPiBbICAgIDAu
MzMyMzkxXSBbPGMwNTJiZDZkPl0gKF9faW9tbXVfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA1MmMz
Y2Q+XSAoaW9tbXVfcHJvYmVfZGV2aWNlKzB4MTkvMHhlYykKPiBbICAgIDAuMzMyNTQ1XSBbPGMw
NTJjM2NkPl0gKGlvbW11X3Byb2JlX2RldmljZSkgZnJvbSBbPGMwNTJlNmFiPl0gKG9mX2lvbW11
X2NvbmZpZ3VyZSsweGZiLzB4MTUwKQo+IFsgICAgMC4zMzI3MDFdIFs8YzA1MmU2YWI+XSAob2Zf
aW9tbXVfY29uZmlndXJlKSBmcm9tIFs8YzA3M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9pZCsw
eDFmYi8weDJlYykKPiBbICAgIDAuMzMyODA0XSBbPGMwNzNmNjk3Pl0gKG9mX2RtYV9jb25maWd1
cmVfaWQpIGZyb20gWzxjMDU5NzQzZj5dIChyZWFsbHlfcHJvYmUrMHg3Yi8weDJhMCkKPiBbICAg
IDAuMzM1MjAyXSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0taW9tbXVfZ3JvdXBfZ2V0
X2Zvcl9kZXYsIDE1NzIKPiBbICAgIDAuMzM1MjkyXSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogLS0t
LS0tLS0tdGVncmFfc21tdV9kZXZpY2VfZ3JvdXAsIDg2Mgo+IFsgICAgMC4zMzU0NzRdIHRlZ3Jh
LWRjIDU0MjAwMDAwLmRjOiAtLS0tLS0tLS10ZWdyYV9zbW11X2RldmljZV9ncm91cCwgOTA5OiAx
OiBkcm0KPiBbICAgIDAuMzM1NTY2XSB0ZWdyYS1kYyA1NDIwMDAwMC5kYzogLS0tLS0tLS0taW9t
bXVfZ3JvdXBfZ2V0X2Zvcl9kZXYsIDE1NzQKPiBbICAgIDAuMzM1NzE4XSB0ZWdyYS1kYyA1NDIw
MDAwMC5kYzogLS0tLS0tLS0taW9tbXVfZ3JvdXBfYWRkX2RldmljZSwgODU4Cj4gWyAgICAwLjMz
NTg2Ml0gdGVncmEtZGMgNTQyMDAwMDAuZGM6IEFkZGluZyB0byBpb21tdSBncm91cCAxCj4gWyAg
ICAwLjMzNTk1NV0gdGVncmEtZGMgNTQyMDAwMDAuZGM6IC0tLS0tLS0tLWlvbW11X2FsbG9jX2Rl
ZmF1bHRfZG9tYWluLCAxNTQzOiB0eXBlIDMKPiBbICAgIDAuMzM2MTAxXSBpb21tdTogLS0tLS0t
aW9tbXVfZ3JvdXBfYWxsb2NfZGVmYXVsdF9kb21haW46IHBsYXRmb3JtLCAobnVsbCksIGRybQo+
IFsgICAgMC4zMzYxODddIC0tLS0tLS0tLXRlZ3JhX3NtbXVfZG9tYWluX2FsbG9jLCAyODQ6IHR5
cGUgMwogWyAgICAwLjMzNjk2OF0gWzxjMGEwZmY0NT5dICh0ZWdyYV9zbW11X2RvbWFpbl9hbGxv
YykgZnJvbSBbPGMwYTBmODdiPl0gKGlvbW11X2dyb3VwX2FsbG9jX2RlZmF1bHRfZG9tYWluKzB4
NGIvMHhmYSkKPiBbICAgIDAuMzM3MTI3XSBbPGMwYTBmODdiPl0gKGlvbW11X2dyb3VwX2FsbG9j
X2RlZmF1bHRfZG9tYWluKSBmcm9tIFs8YzA1MmM0MWQ+XSAoaW9tbXVfcHJvYmVfZGV2aWNlKzB4
NjkvMHhlYykKPiBbICAgIDAuMzM3Mjg1XSBbPGMwNTJjNDFkPl0gKGlvbW11X3Byb2JlX2Rldmlj
ZSkgZnJvbSBbPGMwNTJlNmFiPl0gKG9mX2lvbW11X2NvbmZpZ3VyZSsweGZiLzB4MTUwKQo+IFsg
ICAgMC4zMzc0NDFdIFs8YzA1MmU2YWI+XSAob2ZfaW9tbXVfY29uZmlndXJlKSBmcm9tIFs8YzA3
M2Y2OTc+XSAob2ZfZG1hX2NvbmZpZ3VyZV9pZCsweDFmYi8weDJlYykKPiBbICAgIDAuMzM3NTk5
XSBbPGMwNzNmNjk3Pl0gKG9mX2RtYV9jb25maWd1cmVfaWQpIGZyb20gWzxjMDU5NzQzZj5dIChy
ZWFsbHlfcHJvYmUrMHg3Yi8weDJhMCkKPiBbICAgIDAuMzM5OTEzXSB0ZWdyYS1kYyA1NDIwMDAw
MC5kYzogLS0tLS0tLS0taW9tbXVfcHJvYmVfZGV2aWNlLCAyNzIKPiBbICAgIDAuMzQ4MTQ0XSB0
ZWdyYS1kYyA1NDIwMDAwMC5kYzogZmFpbGVkIHRvIHByb2JlIFJHQiBvdXRwdXQ6IC01MTcKCkht
bS4ubm90IHN1cmUgd2hlcmUgdGhpcyBFUFJPQkVfREVGRVIgY29tZXMgZnJvbS4gQnV0IHlvdSBh
cmUgcmlnaHQsCmFzIG9mX2RtYV9jb25maWd1cmVfaWQoKSByZXR1cm5zIGJlY2F1c2Ugb2YgdGhh
dCBzbyBpdCBkaWRuJ3QgcnVuIHRvCmFyY2hfc2V0dXBfZG1hX29wcygpIGNhbGwsIHdoaWNoIGFs
bG9jYXRlcyBhbiBVTk1BTkFHRUQgaW9tbXUgZG9tYWluCmFuZCBhdHRhY2hlcyBEQyB0byBpdCBv
biBUZWdyYTEyNC4KCkJ5IHRoZSB3YXksIGFueW9uZSBjYW4gYWNjZXB0IHRoaXMgY2hhbmdlPyBJ
dCBkb2Vzbid0IGZlZWwgcmlnaHQgdG8KbGVhdmUgYSByZWdyZXNzaW9uIGluIHRoZSBuZXdlciBy
ZWxlYXNlLi4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
