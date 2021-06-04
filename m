Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B63C47099
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 01:11:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1516140D
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 01:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1516140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F154A84036;
	Fri,  4 Jun 2021 01:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tIHg2DCVMLCT; Fri,  4 Jun 2021 01:11:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEEB783DEB;
	Fri,  4 Jun 2021 01:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2369C000E;
	Fri,  4 Jun 2021 01:11:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E25C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BF536F931
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vuBWdG39m9DB for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:11:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E14FB60AF2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622769076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74wa3D7052FGdwsOb19pvsgbuYGA5vLypJgGwvpg9kA=;
 b=a37wmN21NMiNqjs6CSHLYuHZjqb6wCLH+LZfaXhCht2TsQxTxs6l+n0xHrtrQ4F8j+lSAB
 eF0uY1mVHBer36oeFvnSDcASegOzFoJxD3FRjO7xf/IW7lZCPecPzXfzHCyeMcoUbBz68G
 M2URL10SkPoKdMHoX10Eh8hftny+ZJw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-CiP0Pt11NaSj2spCZ61Icg-1; Thu, 03 Jun 2021 21:11:14 -0400
X-MC-Unique: CiP0Pt11NaSj2spCZ61Icg-1
Received: by mail-pl1-f199.google.com with SMTP id
 u1-20020a1709027141b02901040cac08fdso3387082plm.12
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 18:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=74wa3D7052FGdwsOb19pvsgbuYGA5vLypJgGwvpg9kA=;
 b=ChbN5QTZ052+mBXRHR8nL9gWHPhRQBIV4NdImQV9y1pTNnAn/jL3wW66YiT/TmYa4w
 6J8F+nncMo655cGl1ejifdHje/Mi20CXPpif2O+kE2Ivvamnn3kuqBzpgtTd9cCG0X/D
 NGm8bgrw/VE7j2MzE0U0awqpgFClQuV7azw0V/KsvxFmR2nQDP7J452sdLyMDuDsS/wY
 TOLWOf517uaBQ7w1+I42JMEptYLh5VBAIWLT88vfMYjcrjZnE7Jt0zT4ThtvRwIrClax
 oO7xrgSqfssdnC1ge69lUOAZcz3tfrt0bPyi4tjg7ZJO1TP6euYvLnsXzcRJkEpIBmZB
 5X5g==
X-Gm-Message-State: AOAM531DEvr6jmOLa776RkewOMxj2LCm7KygKCCAlJQVgzypg5gw0zqv
 Kuxoz6IbLAXgT4EVQ5MiW4KK7iZSd2TJPPKaChTSSyh6gVzKcDQRLeL21QjQ2nJnCY80qQDUedK
 w3i8elhDnLzzBM3BAEHfp1cGg3xzaGQ==
X-Received: by 2002:a63:370b:: with SMTP id e11mr2255873pga.356.1622769073849; 
 Thu, 03 Jun 2021 18:11:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw19wf1A8+65Q36xarUBfhf8NPj5f2hsFRG2/Iexl5uV4W9R5ePiMPVn1Z2bNWIP1oHtD7E3w==
X-Received: by 2002:a63:370b:: with SMTP id e11mr2255853pga.356.1622769073569; 
 Thu, 03 Jun 2021 18:11:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h18sm248362pgl.87.2021.06.03.18.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 18:11:13 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
Date: Fri, 4 Jun 2021 09:11:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603130927.GZ1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8zIM/Czuc5OjA5LCBKYXNvbiBHdW50aG9ycGUg0LS1wDoKPiBPbiBUaHUsIEp1
biAwMywgMjAyMSBhdCAxMDo1Mjo1MUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4+IEJh
c2ljYWxseSwgd2UgZG9uJ3Qgd2FudCB0byBib3RoZXIgd2l0aCBwc2V1ZG8gS1ZNIGRldmljZSBs
aWtlIHdoYXQgVkZJTwo+PiBkaWQuIFNvIGZvciBzaW1wbGljaXR5LCB3ZSBydWxlcyBvdXQgdGhl
IElPTU1VIHRoYXQgY2FuJ3QgZW5mb3JjZSBjb2hlcmVuY3kKPj4gaW4gdmhvc3QtdkRQQSBpZiB0
aGUgcGFyZW50IHB1cmVseSBkZXBlbmRzIG9uIHRoZSBwbGF0Zm9ybSBJT01NVToKPiBWRFBBIEhX
IGNhbm5vdCBpc3N1ZSBuby1zbm9vcCBUTFBzIGluIHRoZSBmaXJzdCBwbGFjZS4KCgpOb3RlIHRo
YXQgdmlydGlvL3ZEUEEgaXMgbm90IG5lY2Vzc2FyaWx5IGEgUENJIGRldmljZS4KCgo+Cj4gdmly
dGlvIGRvZXMgbm90IGRlZmluZSBhIHByb3RvY29sIHRvIGRpc2NvdmVyIHN1Y2ggYSBmdW5jdGlv
bmFsaXR5LAoKCkFjdHVhbGx5IHdlIGhhZDoKClZJUlRJT19GX0FDQ0VTU19QTEFURk9STSgzMykK
VGhpcyBmZWF0dXJlIGluZGljYXRlcyB0aGF0IHRoZSBkZXZpY2UgY2FuIGJlIHVzZWQgb24gYSBw
bGF0Zm9ybSB3aGVyZSAKZGV2aWNlIGFjY2VzcyB0byBkYXRhIGluIG1lbW9yeSBpcyBsaW1pdGVk
IGFuZC9vciB0cmFuc2xhdGVkLiBFLmcuIHRoaXMgCmlzIHRoZSBjYXNlIGlmIHRoZSBkZXZpY2Ug
Y2FuIGJlIGxvY2F0ZWQgYmVoaW5kIGFuIElPTU1VIHRoYXQgdHJhbnNsYXRlcyAKYnVzIGFkZHJl
c3NlcyBmcm9tIHRoZSBkZXZpY2UgaW50byBwaHlzaWNhbCBhZGRyZXNzZXMgaW4gbWVtb3J5LCBp
ZiB0aGUgCmRldmljZSBjYW4gYmUgbGltaXRlZCB0byBvbmx5IGFjY2VzcyBjZXJ0YWluIG1lbW9y
eSBhZGRyZXNzZXMgb3IgaWYgCnNwZWNpYWwgY29tbWFuZHMgc3VjaCBhcyBhIGNhY2hlIGZsdXNo
IGNhbiBiZSBuZWVkZWQgdG8gc3luY2hyb25pc2UgZGF0YSAKaW4gbWVtb3J5IHdpdGggdGhlIGRl
dmljZS4KCgo+IG5vciBkbyBhbnkgdmlydGlvIGRyaXZlcnMgaW1wbGVtZW50IHRoZSByZXF1aXJl
ZCBwbGF0Zm9ybSBzcGVjaWZpYwo+IGNhY2hlIGZsdXNoaW5nIHRvIG1ha2Ugbm8tc25vb3AgVExQ
cyB3b3JrLgoKCkkgZG9uJ3QgZ2V0IHdoeSB2aXJ0aW8gZHJpdmVycyBuZWVkcyB0byBkbyB0aGF0
LiBJIHRoaW5rIERNQSBBUEkgc2hvdWxkIApoaWRlIHRob3NlIGFyY2gvcGxhdGZvcm0gc3BlY2lm
aWMgc3R1ZmZzIGZyb20gdXMuCgoKPgo+IEl0IGlzIGZ1bmRhbWVudGFsbHkgcGFydCBvZiB0aGUg
dmlydGlvIEhXIFBDSSBBUEkgdGhhdCBhIGRldmljZSB2ZW5kb3IKPiBjYW5ub3QgYWx0ZXIuCgoK
VGhlIHNwZWMgZG9lc24ndCBmb3JiaWQgdGhpcywgYW5kIGl0IGp1c3QgbGVhdmUgdGhlIGRldGVj
dGlvbiBhbmQgYWN0aW9uIAp0byB0aGUgZHJpdmVyIGluIGEgcGxhdGZvcm0gc3BlY2lmaWMgd2F5
LgoKVGhhbmtzCgoKPgo+IEJhc2ljYWxseSBzaW5jZSB3ZSBhbHJlYWR5IGtub3cgdGhhdCB0aGUg
dmlydGlvIGtlcm5lbCBkcml2ZXJzIGRvIG5vdAo+IGNhbGwgdGhlIGNhY2hlIGZsdXNoIGluc3Ry
dWN0aW9uIHdlIGRvbid0IG5lZWQgdGhlIHdlaXJkIEtWTSBsb2dpYyB0bwo+IHR1cm4gaXQgb24g
YXQgYWxsLgo+Cj4gRW5mb3JjaW5nIG5vLXNub29wIGF0IHRoZSBJT01NVSBoZXJlIGlzIHJlZHVu
ZGFudC9jb25mdXNpbmcuCj4KPiBKYXNvbgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
