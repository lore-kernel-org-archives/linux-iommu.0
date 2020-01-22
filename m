Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5DCC33CAF
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 15:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC2F217F4
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 15:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLixP1Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC2F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4470385593;
	Wed, 22 Jan 2020 15:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yz8A36xzJSjO; Wed, 22 Jan 2020 15:44:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A1D81848AB;
	Wed, 22 Jan 2020 15:44:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93AF9C0176;
	Wed, 22 Jan 2020 15:44:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF53C0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 15:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8362C86084
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 15:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jkGBjT91VJhm for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 15:44:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3C13B848AB
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579707894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zv+bCnNOl3qjnstEYa92uxa3f6bv0jFexwgAKSb/Wgw=;
 b=ZLixP1Z6FdGKiUYFt5lLeQJteMCiqrBeSE1jjFzKrfl2HKsGPF89nAzjSY9RCUzasSiYfl
 tvvOhM3G77cRgSpyuKZ1CNv3o8L31+ROfTdbTjEQy5vfvVmWiWiAuVoPXTUkcp8XSYWn8Q
 1GzUXPC9Rwo2KcHjVl5kTOMGifvfho8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-a4Tiof7MMxWBTfcSzhEVxA-1; Wed, 22 Jan 2020 10:44:51 -0500
Received: by mail-wm1-f70.google.com with SMTP id s25so1558828wmj.3
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 07:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zv+bCnNOl3qjnstEYa92uxa3f6bv0jFexwgAKSb/Wgw=;
 b=tkB9+0jnqz79yXmUImNcOxwsS2baM4kYaXaikC5SFKWIi9VwLxuQDEPrMfKfVa3fFj
 CeTmLzy2g/y+oluLDLQ1BRRDIYCjWXO/XB3IR0hmAErjg6U4DFevRw8dZOCEoEaE8Y4k
 IvDGguZ+7galuCg8QmnmapNlCrOsfo6l05YjVK/5Q7xknNQ0nu1FvGu3tUeaftGPeufA
 Gl+HOjergidPn1bj3Bh9vAY4g4eu4w+LJSAtGnxIrWbtGEaMTamKaEKpIXVuAVCNRSiG
 xYQyv3IcNRpO7sn/8nAg4jkgusQAYBrFIfms48tn/9VPy3Cm+EVlYtybRYCLAsgP15Gw
 1ofQ==
X-Gm-Message-State: APjAAAUvHM4hJrRe8S52hGnUUo8qGVXduMCFXibG/AYFBTvTouYVoUBu
 WVHhtZ0P9jO94XxjvFDL6vGFbICoxjtTku2HsMxUeGAMwhKXF6tm9nx0Z0T5HpIlleggos7nTux
 oukXcxl8kSExFcuRIL3/V1m8NpKcrXw==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr3608527wmf.60.1579707890544; 
 Wed, 22 Jan 2020 07:44:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzf+zGrSWPw3ihUGr7p4vlyzpMTPSct3QELlX5YtRHHUGB/lGQLmBvKenlxYxVN83lyYY0RNQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr3608506wmf.60.1579707890287; 
 Wed, 22 Jan 2020 07:44:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id q3sm4358926wmj.38.2020.01.22.07.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:44:49 -0800 (PST)
Subject: Re: [PATCH] svm/avic: iommu/amd: Flush IOMMU IRT after update all
 entries
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20190320081432.2606-1-suravee.suthikulpanit@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d599b411-3f1e-c67e-dd39-ad4ef42764e7@redhat.com>
Date: Wed, 22 Jan 2020 16:44:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190320081432.2606-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
X-MC-Unique: a4Tiof7MMxWBTfcSzhEVxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
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

T24gMjAvMDMvMTkgMDk6MTQsIFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUgd3JvdGU6Cj4gV2hlbiBB
VklDIGlzIGVuYWJsZWQgYW5kIHRoZSBWTSBoYXMgZGlzY3JldGUgZGV2aWNlIGFzc2lnbm1lbnQs
Cj4gdGhlIGludGVycnVwdCByZW1hcHBpbmcgdGFibGUgKElSVCkgaXMgdXNlZCB0byBrZWVwIHRy
YWNrIG9mIHdoaWNoCj4gZGVzdGluYXRpb24gQVBJQyBJRCB0aGUgSU9NTVUgd2lsbCBpbmplY3Qg
dGhlIGRldmljZSBpbnRlcnJwdXQgdG8uCj4gCj4gVGhpcyBtZWFucyBldmVyeSB0aW1lIGEgdmNw
dSBpcyBibG9ja2VkIG9yIGNvbnRleHQtc3dpdGNoZWQgKGkuZS4KPiB2Y3B1X2Jsb2NraW5nL3Vu
YmxvY2tpbmcoKSBhbmQgdmNwdV9sb2FkL3B1dCgpKSwgdGhlIGluZm9ybWF0aW9uCj4gaW4gSVJU
IG11c3QgYmUgdXBkYXRlZCBhbmQgdGhlIElPTU1VIElSVCBmbHVzaCBjb21tYW5kIG11c3QgYmUK
PiBpc3N1ZWQuCj4gCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZmx1c2hlcyBJT01NVSBJ
UlQgZXZlcnkgdGltZSBhbiBlbnRyeQo+IGlzIG1vZGlmaWVkLiBJZiB0aGUgYXNzaWduZWQgZGV2
aWNlIGhhcyBsYXJnZSBudW1iZXIgb2YgaW50ZXJydXB0cwo+IChoZW5jZSBsYXJnZSBudW1iZXIg
b2YgZW50cmllcyksIHRoaXMgd291bGQgYWRkIGxhcmdlIGFtb3VudCBvZgo+IG92ZXJoZWFkIHRv
IHZjcHUgY29udGV4dC1zd2l0Y2guIEluc3RlYWQsIHRoaXMgY2FuIGJlIG9wdG1pemVkIGJ5Cj4g
b25seSBmbHVzaCBJUlQgb25jZSBwZXIgdmNwdSBjb250ZXh0LXN3aXRjaCBwZXIgZGV2aWNlIGFm
dGVyIGFsbAo+IElSVCBlbnRyaWVzIGFyZSBtb2RpZmllZC4KPiAKPiBUaGUgZnVuY3Rpb24gYW1k
X2lvbW11X3VwZGF0ZV9nYSgpIGlzIHJlZmFjdG9yZWQgdG8gb25seSB1cGRhdGUKPiBJUlQgZW50
cnksIHdoaWxlIHRoZSBhbWRfaW9tbXVfc3luY19nYSgpIGlzIGludHJvZHVjZWQgdG8gYWxsb3cK
PiBJUlQgZmx1c2hpbmcgdG8gYmUgZG9uZSBzZXBhcmF0ZWx5Lgo+IAo+IENjOiBKb2VyZyBSb2Vk
ZWwgPGpvcm9AOGJ5dGVzLm9yZz4KPiBDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhh
dC5jb20+Cj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1k
LmNvbT4KPiAtLS0KPiAgYXJjaC94ODYva3ZtL3N2bS5jICAgICAgICB8IDM1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystCj4gIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMgfCAy
MCArKysrKysrKysrKysrKysrKy0tLQo+ICBpbmNsdWRlL2xpbnV4L2FtZC1pb21tdS5oIHwgMTMg
KysrKysrKysrKy0tLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCgpJIGZvdW5kIHRoaXMgcGF0Y2ggaW4gbXkgaW5ib3guLi4gIEknZCByYXRoZXIg
YXZvaWQgYWxsb2NhdGluZyA4ayBvZiBSQU0KcGVyIHZDUFUuICBDYW4geW91IG1ha2UgaXQgcGVy
LVZNPwoKUGFvbG8KCj4gKwkvKgo+ICsJICogQml0bWFwIHVzZWQgdG8gc3RvcmUgUENJIGRldmlk
IHRvIHN5bmMKPiArCSAqIEFNRCBJT01NVSBpbnRlcnJ1cHQgcmVtYXBwaW5nIHRhYmxlCj4gKwkg
Ki8KPiArCXVuc2lnbmVkIGxvbmcgKmF2aWNfZGV2aWRfc3luY19iaXRtYXA7Cj4gIH07Cj4gIAo+
ICAvKgo+IEBAIC0xOTg0LDYgKzE5OTIsNyBAQCBzdGF0aWMgaW5saW5lIGludAo+ICBhdmljX3Vw
ZGF0ZV9pb21tdV92Y3B1X2FmZmluaXR5KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IGNwdSwg
Ym9vbCByKQo+ICB7Cj4gIAlpbnQgcmV0ID0gMDsKPiArCWludCBkZXZpZCA9IDA7Cj4gIAl1bnNp
Z25lZCBsb25nIGZsYWdzOwo+ICAJc3RydWN0IGFtZF9zdm1faW9tbXVfaXIgKmlyOwo+ICAJc3Ry
dWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7Cj4gQEAgLTIwMDEsOSArMjAxMCwyMSBA
QCBhdmljX3VwZGF0ZV9pb21tdV92Y3B1X2FmZmluaXR5KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
aW50IGNwdSwgYm9vbCByKQo+ICAJCWdvdG8gb3V0Owo+ICAKPiAgCWxpc3RfZm9yX2VhY2hfZW50
cnkoaXIsICZzdm0tPmlyX2xpc3QsIG5vZGUpIHsKPiAtCQlyZXQgPSBhbWRfaW9tbXVfdXBkYXRl
X2dhKGNwdSwgciwgaXItPmRhdGEpOwo+ICsJCXJldCA9IGFtZF9pb21tdV91cGRhdGVfZ2EoY3B1
LCByLCBpci0+ZGF0YSwgJmRldmlkKTsKPiAgCQlpZiAocmV0KQo+ICAJCQlicmVhazsKPiArCQlz
ZXRfYml0KGRldmlkLCBzdm0tPmF2aWNfZGV2aWRfc3luY19iaXRtYXApOwo+ICsJfQo+ICsKPiAr
CS8qIFN5bmMgQU1EIElPTU1VIGludGVycnVwdCByZW1hcHBpbmcgdGFibGUgY2hhbmdlcyBmb3Ig
ZWFjaCBkZXZpY2UuICovCj4gKwlkZXZpZCA9IGZpbmRfbmV4dF9iaXQoc3ZtLT5hdmljX2Rldmlk
X3N5bmNfYml0bWFwLAo+ICsJCQkgICAgICBBVklDX0RFVklEX0JJVE1BUF9TSVpFLCAwKTsKPiAr
Cj4gKwl3aGlsZSAoZGV2aWQgPCBBVklDX0RFVklEX0JJVE1BUF9TSVpFKSB7Cj4gKwkJY2xlYXJf
Yml0KGRldmlkLCBzdm0tPmF2aWNfZGV2aWRfc3luY19iaXRtYXApOwo+ICsJCXJldCA9IGFtZF9p
b21tdV9zeW5jX2dhKGRldmlkKTsKPiArCQlkZXZpZCA9IGZpbmRfbmV4dF9iaXQoc3ZtLT5hdmlj
X2RldmlkX3N5bmNfYml0bWFwLAo+ICsJCQkJICAgICAgQVZJQ19ERVZJRF9CSVRNQVBfU0laRSwg
ZGV2aWQrMSk7Cj4gIAl9Cj4gIG91dDoKPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnN2bS0+
aXJfbGlzdF9sb2NrLCBmbGFncyk7Cj4gQEAgLTIxMDcsNiArMjEyOCwxMyBAQCBzdGF0aWMgaW50
IGF2aWNfaW5pdF92Y3B1KHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQo+ICAJSU5JVF9MSVNUX0hFQUQo
JnN2bS0+aXJfbGlzdCk7Cj4gIAlzcGluX2xvY2tfaW5pdCgmc3ZtLT5pcl9saXN0X2xvY2spOwo+
ICAKPiArCXN2bS0+YXZpY19kZXZpZF9zeW5jX2JpdG1hcCA9ICh2b2lkICopX19nZXRfZnJlZV9w
YWdlcygKPiArCQkJCQlHRlBfS0VSTkVMIHwgX19HRlBfWkVSTywKPiArCQkJCQlnZXRfb3JkZXIo
QVZJQ19ERVZJRF9CSVRNQVBfU0laRS84KSk7Cj4gKwlpZiAoc3ZtLT5hdmljX2RldmlkX3N5bmNf
Yml0bWFwID09IE5VTEwpCj4gKwkJcmV0ID0gLUVOT01FTTsKPiArCW1lbXNldChzdm0tPmF2aWNf
ZGV2aWRfc3luY19iaXRtYXAsIDAsIEFWSUNfREVWSURfQklUTUFQX1NJWkUvOCk7Cj4gKwo+ICAJ
cmV0dXJuIHJldDsKPiAgfQo+ICAKPiBAQCAtMjIyMSw2ICsyMjQ5LDExIEBAIHN0YXRpYyB2b2lk
IHN2bV9mcmVlX3ZjcHUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQo+ICAJX19mcmVlX3BhZ2VzKHZp
cnRfdG9fcGFnZShzdm0tPm1zcnBtKSwgTVNSUE1fQUxMT0NfT1JERVIpOwo+ICAJX19mcmVlX3Bh
Z2UodmlydF90b19wYWdlKHN2bS0+bmVzdGVkLmhzYXZlKSk7Cj4gIAlfX2ZyZWVfcGFnZXModmly
dF90b19wYWdlKHN2bS0+bmVzdGVkLm1zcnBtKSwgTVNSUE1fQUxMT0NfT1JERVIpOwo+ICsKPiAr
CWZyZWVfcGFnZXMoKHVuc2lnbmVkIGxvbmcpc3ZtLT5hdmljX2RldmlkX3N5bmNfYml0bWFwLAo+
ICsJCSAgIGdldF9vcmRlcihBVklDX0RFVklEX0JJVE1BUF9TSVpFLzgpKTsKPiArCXN2bS0+YXZp
Y19kZXZpZF9zeW5jX2JpdG1hcCA9IE5VTEw7Cj4gKwo+ICAJa3ZtX3ZjcHVfdW5pbml0KHZjcHUp
Owo+ICAJa21lbV9jYWNoZV9mcmVlKHg4Nl9mcHVfY2FjaGUsIHN2bS0+dmNwdS5hcmNoLmd1ZXN0
X2ZwdSk7Cj4gIAlrbWVtX2NhY2hlX2ZyZWUoa3ZtX3ZjcHVfY2FjaGUsIHN2bSk7Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21t
dS5jCj4gaW5kZXggMmE3Yjc4YmI5OGI0Li42MzdiY2M5MTkyZTUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9pb21tdS9hbWRfaW9tbXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMK
PiBAQCAtNDQ5OSw3ICs0NDk5LDIwIEBAIGludCBhbWRfaW9tbXVfY3JlYXRlX2lycV9kb21haW4o
c3RydWN0IGFtZF9pb21tdSAqaW9tbXUpCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiAtaW50IGFt
ZF9pb21tdV91cGRhdGVfZ2EoaW50IGNwdSwgYm9vbCBpc19ydW4sIHZvaWQgKmRhdGEpCj4gK2lu
dCBhbWRfaW9tbXVfc3luY19nYShpbnQgZGV2aWQpCj4gK3sKPiArCXN0cnVjdCBhbWRfaW9tbXUg
KmlvbW11ID0gYW1kX2lvbW11X3Jsb29rdXBfdGFibGVbZGV2aWRdOwo+ICsKPiArCWlmICghaW9t
bXUpCj4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4gKwo+ICsJaW9tbXVfZmx1c2hfaXJ0KGlvbW11LCBk
ZXZpZCk7Cj4gKwlpb21tdV9jb21wbGV0aW9uX3dhaXQoaW9tbXUpOwo+ICsJcmV0dXJuIDA7Cj4g
K30KPiArRVhQT1JUX1NZTUJPTChhbWRfaW9tbXVfc3luY19nYSk7Cj4gKwo+ICtpbnQgYW1kX2lv
bW11X3VwZGF0ZV9nYShpbnQgY3B1LCBib29sIGlzX3J1biwgdm9pZCAqZGF0YSwgaW50ICppZCkK
PiAgewo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsKPiAgCXN0cnVjdCBhbWRfaW9tbXUgKmlvbW11
Owo+IEBAIC00NTIxLDYgKzQ1MzQsOSBAQCBpbnQgYW1kX2lvbW11X3VwZGF0ZV9nYShpbnQgY3B1
LCBib29sIGlzX3J1biwgdm9pZCAqZGF0YSkKPiAgCWlmICghdGFibGUpCj4gIAkJcmV0dXJuIC1F
Tk9ERVY7Cj4gIAo+ICsJaWYgKGlkKQo+ICsJCSppZCA9IGRldmlkOwo+ICsKPiAgCXJhd19zcGlu
X2xvY2tfaXJxc2F2ZSgmdGFibGUtPmxvY2ssIGZsYWdzKTsKPiAgCj4gIAlpZiAocmVmLT5sby5m
aWVsZHNfdmFwaWMuZ3Vlc3RfbW9kZSkgewo+IEBAIC00NTM2LDggKzQ1NTIsNiBAQCBpbnQgYW1k
X2lvbW11X3VwZGF0ZV9nYShpbnQgY3B1LCBib29sIGlzX3J1biwgdm9pZCAqZGF0YSkKPiAgCj4g
IAlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGFibGUtPmxvY2ssIGZsYWdzKTsKPiAgCj4g
LQlpb21tdV9mbHVzaF9pcnQoaW9tbXUsIGRldmlkKTsKPiAtCWlvbW11X2NvbXBsZXRpb25fd2Fp
dChpb21tdSk7Cj4gIAlyZXR1cm4gMDsKPiAgfQo+ICBFWFBPUlRfU1lNQk9MKGFtZF9pb21tdV91
cGRhdGVfZ2EpOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FtZC1pb21tdS5oIGIvaW5j
bHVkZS9saW51eC9hbWQtaW9tbXUuaAo+IGluZGV4IDA5NzUxZDM0OTk2My4uYjk0ZDRiMzNkZmQ3
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvYW1kLWlvbW11LmgKPiArKysgYi9pbmNsdWRl
L2xpbnV4L2FtZC1pb21tdS5oCj4gQEAgLTE5Myw4ICsxOTMsOSBAQCBzdGF0aWMgaW5saW5lIGlu
dCBhbWRfaW9tbXVfZGV0ZWN0KHZvaWQpIHsgcmV0dXJuIC1FTk9ERVY7IH0KPiAgLyogSU9NTVUg
QVZJQyBGdW5jdGlvbiAqLwo+ICBleHRlcm4gaW50IGFtZF9pb21tdV9yZWdpc3Rlcl9nYV9sb2df
bm90aWZpZXIoaW50ICgqbm90aWZpZXIpKHUzMikpOwo+ICAKPiAtZXh0ZXJuIGludAo+IC1hbWRf
aW9tbXVfdXBkYXRlX2dhKGludCBjcHUsIGJvb2wgaXNfcnVuLCB2b2lkICpkYXRhKTsKPiArZXh0
ZXJuIGludCBhbWRfaW9tbXVfdXBkYXRlX2dhKGludCBjcHUsIGJvb2wgaXNfcnVuLCB2b2lkICpk
YXRhLCBpbnQgKmRldmlkKTsKPiArCj4gK2V4dGVybiBpbnQgYW1kX2lvbW11X3N5bmNfZ2EoaW50
IGRldmlkKTsKPiAgCj4gICNlbHNlIC8qIGRlZmluZWQoQ09ORklHX0FNRF9JT01NVSkgJiYgZGVm
aW5lZChDT05GSUdfSVJRX1JFTUFQKSAqLwo+ICAKPiBAQCAtMjA1LDcgKzIwNiwxMyBAQCBhbWRf
aW9tbXVfcmVnaXN0ZXJfZ2FfbG9nX25vdGlmaWVyKGludCAoKm5vdGlmaWVyKSh1MzIpKQo+ICB9
Cj4gIAo+ICBzdGF0aWMgaW5saW5lIGludAo+IC1hbWRfaW9tbXVfdXBkYXRlX2dhKGludCBjcHUs
IGJvb2wgaXNfcnVuLCB2b2lkICpkYXRhKQo+ICthbWRfaW9tbXVfdXBkYXRlX2dhKGludCBjcHUs
IGJvb2wgaXNfcnVuLCB2b2lkICpkYXRhLCBpbnQgKmRldmlkKQo+ICt7Cj4gKwlyZXR1cm4gMDsK
PiArfQo+ICsKPiArc3RhdGljIGlubGluZSBpbnQKPiArYW1kX2lvbW11X3N5bmNfZ2EoaW50IGRl
dmlkKQo+ICB7Cj4gIAlyZXR1cm4gMDsKPiAgfQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
