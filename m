Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A9C11F68
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 14:16:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF3B6142D
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 14:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF3B6142D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B200A42390;
	Fri,  2 Jul 2021 14:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FqSNq3zNSkP; Fri,  2 Jul 2021 14:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DD69423BC;
	Fri,  2 Jul 2021 14:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E616DC0010;
	Fri,  2 Jul 2021 14:16:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42226C000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 14:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23C1760BA2
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 14:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RT7lYkEh4tpq for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 14:16:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A58760B98
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 14:16:29 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id d16so18350480lfn.3
 for <iommu@lists.linux-foundation.org>; Fri, 02 Jul 2021 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qZ59h8hRa4ZDg98NbXY065EEOg9pTRSMK3+GCkG//7w=;
 b=CBmUJwaGeiO+XIdGctqbrAeVA7dXsC1nudWsYZlHvFmlNIwzPLizAErA5zHGraGRZB
 yXI8har6Kh7Nm4PJ+O6AZEh9mIDk5Lt0hDLCiraE2sVsdr7FToh057wvgUnLic60NtsR
 3TxwtUjuow3jpS4M+FQJuTM24mxz//scuv8QIxEmEccglTCpyvH072ysjOw+eFuY6jTG
 0nMJZV0aATtzkoNKw3oHQtS+MB/mHIGZLyITv0rsei68/6ubJLNHODL/r8L/r1mqLPs6
 4oOmlc24p9zJ+BCWIw8npWMRsAr/5rwg+m576oIPszWzzxANk62jnupUKkkrUOp+j9sc
 JeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qZ59h8hRa4ZDg98NbXY065EEOg9pTRSMK3+GCkG//7w=;
 b=CwV809YDyfRgh5hsYJHaI9t5gaAlQiDT/FbJ/oMxSJq12DkyeQBueO0ADJNLGkoNgM
 SHPBAasekG3124sG9MA90m7A/YSdvEjpnpUbNKhln80nfG3EiXSOL2FSNm2noAoOyHr4
 O7DlNYZy3DpQTd1eiNGL/YCVwl1Z/QCufNy8FGd4+UrMn/9JEdh2xjASaXeIkuiUO3mB
 s9AYooM/3397W+vWlofaADoSlM8QmZTzuEwpJGnemTs+TtTGtzmm1F9eosF6r7npNqrs
 GtR1fCOh9ojEtcUbsdzFBj45TZV4v9fpygeA/b6wkxm/aLzQjqPp0DpG0Hu8l+aA5qPM
 V4ZA==
X-Gm-Message-State: AOAM532+q5Gi9/9V51bAzCbh+vktsk8AMdBKJcxuWDQATxEnp6iMnHNs
 pIN8dRmiW4Utog5dzin17Io=
X-Google-Smtp-Source: ABdhPJyEm6nf1wc2oQQHUHY4ne3HT6Yid9byglxb+/U/anHmWWyPg9wj1E2i1QgAAZRySErj1c14IQ==
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr4252129lff.51.1625235386928; 
 Fri, 02 Jul 2021 07:16:26 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru.
 [94.29.37.113])
 by smtp.googlemail.com with ESMTPSA id b30sm362479ljr.137.2021.07.02.07.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jul 2021 07:16:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory
 region specifier
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-2-thierry.reding@gmail.com>
 <20210520220306.GA1976116@robh.at.kernel.org>
 <YLEgXyLBF8PEFNw2@orome.fritz.box> <YL+gHN4YZ4vt1vPk@orome.fritz.box>
 <YN4F/nH/9tDuWDnQ@orome.fritz.box>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7995b0ed-a277-ced1-b3d0-e0e7e02817a6@gmail.com>
Date: Fri, 2 Jul 2021 17:16:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YN4F/nH/9tDuWDnQ@orome.fritz.box>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

MDEuMDcuMjAyMSAyMToxNCwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBPbiBUdWUsIEp1
biAwOCwgMjAyMSBhdCAwNjo1MTo0MFBNICswMjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToKPj4g
T24gRnJpLCBNYXkgMjgsIDIwMjEgYXQgMDY6NTQ6NTVQTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4+PiBPbiBUaHUsIE1heSAyMCwgMjAyMSBhdCAwNTowMzowNlBNIC0wNTAwLCBSb2Ig
SGVycmluZyB3cm90ZToKPj4+PiBPbiBGcmksIEFwciAyMywgMjAyMSBhdCAwNjozMjozMFBNICsw
MjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToKPj4+Pj4gRnJvbTogVGhpZXJyeSBSZWRpbmcgPHRy
ZWRpbmdAbnZpZGlhLmNvbT4KPj4+Pj4KPj4+Pj4gUmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbiBwaGFu
ZGxlIHJlZmVyZW5jZXMgY2FuIGJlIGFjY29tcGFuaWVkIGJ5IGEKPj4+Pj4gc3BlY2lmaWVyIHRo
YXQgcHJvdmlkZXMgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBhYm91dCBob3cgdGhhdCBzcGVjaWZp
Ywo+Pj4+PiByZWZlcmVuY2Ugc2hvdWxkIGJlIHRyZWF0ZWQuCj4+Pj4+Cj4+Pj4+IE9uZSB1c2Ut
Y2FzZSBpcyB0byBtYXJrIGEgbWVtb3J5IHJlZ2lvbiBhcyBuZWVkaW5nIGFuIGlkZW50aXR5IG1h
cHBpbmcKPj4+Pj4gaW4gdGhlIHN5c3RlbSdzIElPTU1VIGZvciB0aGUgZGV2aWNlIHRoYXQgcmVm
ZXJlbmNlcyB0aGUgcmVnaW9uLiBUaGlzIGlzCj4+Pj4+IG5lZWRlZCBmb3IgZXhhbXBsZSB3aGVu
IHRoZSBib290bG9hZGVyIGhhcyBzZXQgdXAgaGFyZHdhcmUgKHN1Y2ggYXMgYQo+Pj4+PiBkaXNw
bGF5IGNvbnRyb2xsZXIpIHRvIGFjdGl2ZWx5IGFjY2VzcyBhIG1lbW9yeSByZWdpb24gKGUuZy4g
YSBib290Cj4+Pj4+IHNwbGFzaCBzY3JlZW4gZnJhbWVidWZmZXIpIGR1cmluZyBib290LiBUaGUg
b3BlcmF0aW5nIHN5c3RlbSBjYW4gdXNlIHRoZQo+Pj4+PiBpZGVudGl0eSBtYXBwaW5nIGZsYWcg
ZnJvbSB0aGUgc3BlY2lmaWVyIHRvIG1ha2Ugc3VyZSBhbiBJT01NVSBpZGVudGl0eQo+Pj4+PiBt
YXBwaW5nIGlzIHNldCB1cCBmb3IgdGhlIGZyYW1lYnVmZmVyIGJlZm9yZSBJT01NVSB0cmFuc2xh
dGlvbnMgYXJlCj4+Pj4+IGVuYWJsZWQgZm9yIHRoZSBkaXNwbGF5IGNvbnRyb2xsZXIuCj4+Pj4+
Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+
Cj4+Pj4+IC0tLQo+Pj4+PiAgLi4uL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0
ICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKwo+Pj4+PiAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9yZXNlcnZlZC1tZW1vcnkuaCAgICAgICAgIHwgIDggKysrKysrKwo+Pj4+PiAgMiBmaWxlcyBj
aGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9kdC1iaW5kaW5ncy9yZXNlcnZlZC1tZW1vcnkuaAo+Pj4+Cj4+Pj4gU29ycnkgZm9yIGJlaW5n
IHNsb3cgb24gdGhpcy4gSSBoYXZlIDIgY29uY2VybnMuCj4+Pj4KPj4+PiBGaXJzdCwgdGhpcyBj
cmVhdGVzIGFuIEFCSSBpc3N1ZS4gQSBEVCB3aXRoIGNlbGxzIGluICdtZW1vcnktcmVnaW9uJyAK
Pj4+PiB3aWxsIG5vdCBiZSB1bmRlcnN0b29kIGJ5IGFuIGV4aXN0aW5nIE9TLiBJJ20gbGVzcyBj
b25jZXJuZWQgYWJvdXQgdGhpcyAKPj4+PiBpZiB3ZSBhZGRyZXNzIHRoYXQgd2l0aCBhIHN0YWJs
ZSBmaXguIChUaG91Z2ggSSdtIHByZXR0eSBzdXJlIHdlJ3ZlIAo+Pj4+IG5haXZlbHkgYWRkZWQg
Iz8tY2VsbHMgaW4gdGhlIHBhc3QgaWdub3JpbmcgdGhpcyBpc3N1ZS4pCj4+Pgo+Pj4gQSB3aGls
ZSBhZ28gSSBoYWQgcHJvcG9zZWQgYWRkaW5nIG1lbW9yeS1yZWdpb24qcyogYXMgYW4gYWx0ZXJu
YXRpdmUKPj4+IG5hbWUgZm9yIG1lbW9yeS1yZWdpb24gdG8gbWFrZSB0aGUgbmFtaW5nIG1vcmUg
Y29uc2lzdGVudCB3aXRoIG90aGVyCj4+PiB0eXBlcyBvZiBwcm9wZXJ0aWVzICh0aGluayBjbG9j
a3MsIHJlc2V0cywgZ3Bpb3MsIC4uLikuIElmIHdlIGFkZGVkCj4+PiB0aGF0LCB3ZSBjb3VsZCBl
YXNpbHkgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSAibGVnYWN5IiBjYXNlcyB3aGVyZQo+Pj4g
bm8gI21lbW9yeS1yZWdpb24tY2VsbHMgd2FzIGFsbG93ZWQgYW5kIHRoZSBuZXcgY2FzZXMgd2hl
cmUgaXQgd2FzLgo+Pj4KPj4+PiBTZWNvbmQsIGl0IGNvdWxkIGJlIHRoZSBib290bG9hZGVyIHNl
dHRpbmcgdXAgdGhlIHJlc2VydmVkIHJlZ2lvbi4gSWYgYSAKPj4+PiBub2RlIGFscmVhZHkgaGFz
ICdtZW1vcnktcmVnaW9uJywgdGhlbiBhZGRpbmcgbW9yZSByZWdpb25zIGlzIG1vcmUgCj4+Pj4g
Y29tcGxpY2F0ZWQgY29tcGFyZWQgdG8gYWRkaW5nIG5ldyBwcm9wZXJ0aWVzLiBBbmQgZGVmaW5p
bmcgd2hhdCBlYWNoIAo+Pj4+IG1lbW9yeS1yZWdpb24gZW50cnkgaXMgb3IgaG93IG1hbnkgaW4g
c2NoZW1hcyBpcyBpbXBvc3NpYmxlLgo+Pj4KPj4+IEl0J3MgdHJ1ZSB0aGF0IHVwZGF0aW5nIHRo
ZSBwcm9wZXJ0eSBnZXRzIGEgYml0IGNvbXBsaWNhdGVkLCBidXQgaXQncwo+Pj4gbm90IGV4YWN0
bHkgcm9ja2V0IHNjaWVuY2UuIFdlIHJlYWxseSBqdXN0IG5lZWQgdG8gc3BsaWNlIHRoZSBhcnJh
eS4gSQo+Pj4gaGF2ZSBhIHdvcmtpbmcgaW1wbGVtZW50aW9uIGZvciB0aGlzIGluIFUtQm9vdC4K
Pj4+Cj4+PiBGb3Igd2hhdCBpdCdzIHdvcnRoLCB3ZSBjb3VsZCBydW4gaW50byB0aGUgc2FtZSBp
c3N1ZSB3aXRoIGFueSBuZXcKPj4+IHByb3BlcnR5IHRoYXQgd2UgYWRkLiBFdmVuIGlmIHdlIHJl
bmFtZWQgdGhpcyB0byBpb21tdS1tZW1vcnktcmVnaW9uLAo+Pj4gaXQncyBzdGlsbCBwb3NzaWJs
ZSB0aGF0IGEgYm9vdGxvYWRlciBtYXkgaGF2ZSB0byB1cGRhdGUgdGhpcyBwcm9wZXJ0eQo+Pj4g
aWYgaXQgYWxyZWFkeSBleGlzdHMgKGl0IGNvdWxkIGJlIGhhcmQtY29kZWQgaW4gRFQsIG9yIGl0
IGNvdWxkIGhhdmUKPj4+IGJlZW4gYWRkZWQgYnkgc29tZSBlYXJsaWVyIGJvb3Rsb2FkZXIgb3Ig
ZmlybXdhcmUpLgo+Pj4KPj4+PiBCb3RoIGNvdWxkIGJlIGFkZHJlc3NlZCB3aXRoIGEgbmV3IHBy
b3BlcnR5LiBQZXJoYXBzIHNvbWV0aGluZyBsaWtlIAo+Pj4+ICdpb21tdS1tZW1vcnktcmVnaW9u
ID0gPCZwaGFuZGxlPjsnLiBJIHRoaW5rIHRoZSAnaW9tbXUnIHByZWZpeCBpcyAKPj4+PiBhcHBy
b3ByaWF0ZSBnaXZlbiB0aGlzIGlzIGVudGlyZWx5IGJlY2F1c2Ugb2YgdGhlIElPTU1VIGJlaW5n
IGluIHRoZSAKPj4+PiBtaXguIEkgbWlnaHQgZmVlbCBkaWZmZXJlbnRseSBpZiB3ZSBoYWQgb3Ro
ZXIgdXNlcyBmb3IgY2VsbHMsIGJ1dCBJIAo+Pj4+IGRvbid0IHJlYWxseSBzZWUgaXQgaW4gdGhp
cyBjYXNlLiAKPj4+Cj4+PiBJJ20gYWZyYWlkIHRoYXQgZG93biB0aGUgcm9hZCB3ZSdsbCBlbmQg
dXAgd2l0aCBvdGhlciBjYXNlcyBhbmQgdGhlbiB3ZQo+Pj4gbWlnaHQgcHJvbGlmZXJhdGUgYSBu
dW1iZXIgb2YgKi1tZW1vcnktcmVnaW9uIHByb3BlcnRpZXMgd2l0aCB2YXJ5aW5nCj4+PiBwcmVm
aXhlcy4KPj4+Cj4+PiBJIGFtIGF3YXJlIG9mIG9uZSBvdGhlciBjYXNlIHdoZXJlIHdlIG1pZ2h0
IG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpczogb24KPj4+IHNvbWUgVGVncmEgU29DcyB3ZSBoYXZl
IGF1ZGlvIHByb2Nlc3NvcnMgdGhhdCB3aWxsIGFjY2VzcyBtZW1vcnkgYnVmZmVycwo+Pj4gdXNp
bmcgYSBETUEgZW5naW5lLiBUaGVzZSBwcm9jZXNzb3JzIGFyZSBib290ZWQgZnJvbSBlYXJseSBm
aXJtd2FyZQo+Pj4gdXNpbmcgZmlybXdhcmUgZnJvbSBzeXN0ZW0gbWVtb3J5LiBJbiBvcmRlciB0
byBhdm9pZCB0cmFzaGluZyB0aGUKPj4+IGZpcm13YXJlLCB3ZSBuZWVkIHRvIHJlc2VydmUgbWVt
b3J5LiBXZSBjYW4gZG8gdGhpcyB1c2luZyByZXNlcnZlZAo+Pj4gbWVtb3J5IG5vZGVzLiBIb3dl
dmVyLCB0aGUgYXVkaW8gRE1BIGVuZ2luZSBhbHNvIHVzZXMgdGhlIFNNTVUsIHNvIHdlCj4+PiBu
ZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBmaXJtd2FyZSBtZW1vcnkgaXMgbWFya2VkIGFzIHJl
c2VydmVkIHdpdGhpbgo+Pj4gdGhlIFNNTVUuIFRoaXMgaXMgc2ltaWxhciB0byB0aGUgaWRlbnRp
dHkgbWFwcGluZyBjYXNlLCBidXQgbm90IGV4YWN0bHkKPj4+IHRoZSBzYW1lLiBJbnN0ZWFkIG9m
IGNyZWF0aW5nIGEgMToxIG1hcHBpbmcsIHdlIGp1c3Qgd2FudCB0aGF0IElPVkEKPj4+IHJlZ2lv
biB0byBiZSByZXNlcnZlZCAoaS5lLiBJT01NVV9SRVNWX1JFU0VSVkVEIGluc3RlYWQgb2YKPj4+
IElPTU1VX1JFU1ZfRElSRUNUeyxfUkVMQVhBQkxFfSkuCj4+Pgo+Pj4gVGhhdCB3b3VsZCBhbHNv
IGZhbGwgaW50byB0aGUgSU9NTVUgZG9tYWluLCBidXQgd2UgY2FuJ3QgcmV1c2UgdGhlCj4+PiBp
b21tdS1tZW1vcnktcmVnaW9uIHByb3BlcnR5IGZvciB0aGF0IGJlY2F1c2UgdGhlbiB3ZSBkb24n
dCBoYXZlIGVub3VnaAo+Pj4gaW5mb3JtYXRpb24gdG8gZGVjaWRlIHdoaWNoIHR5cGUgb2YgcmVz
ZXJ2YXRpb24gd2UgbmVlZC4KPj4+Cj4+PiBXZSBjb3VsZCBvYnZpb3VzbHkgbWFrZSBpb21tdS1t
ZW1vcnktcmVnaW9uIHRha2UgYSBzcGVjaWZpZXIsIGJ1dCB3ZQo+Pj4gY291bGQganVzdCBhcyB3
ZWxsIHVzZSBtZW1vcnktcmVnaW9ucyBpbiB0aGF0IGNhc2Ugc2luY2Ugd2UgaGF2ZQo+Pj4gc29t
ZXRoaW5nIG1vcmUgZ2VuZXJpYyBhbnl3YXkuCj4+Pgo+Pj4gV2l0aCB0aGUgI21lbW9yeS1yZWdp
b24tY2VsbHMgcHJvcG9zYWwsIHdlIGNhbiBlYXNpbHkgZXh0ZW5kIHRoZSBjZWxsIGluCj4+PiB0
aGUgc3BlY2lmaWVyIHdpdGggYW4gYWRkaXRpb25hbCBNRU1PUllfUkVHSU9OX0lPTU1VX1JFU0VS
VkUgZmxhZyB0bwo+Pj4gdGFrZSB0aGF0IG90aGVyIHVzZSBjYXNlIGludG8gYWNjb3VudC4gSWYg
d2UgdGhhbiBhbHNvIGNoYW5nZSB0byB0aGUgbmV3Cj4+PiBtZW1vcnktcmVnaW9ucyBwcm9wZXJ0
eSBuYW1lLCB3ZSBhdm9pZCB0aGUgQUJJIGlzc3VlIChhbmQgd2UgZ2FpbiBhIGJpdAo+Pj4gb2Yg
Y29uc2lzdGVuY3kgd2hpbGUgYXQgaXQpLgo+Pgo+PiBQaW5nPyBSb2IsIGRvIHlvdSB3YW50IG1l
IHRvIGFkZCB0aGlzIHNlY29uZCB1c2UtY2FzZSB0byB0aGUgcGF0Y2gKPj4gc2VyaWVzIHRvIG1h
a2UgaXQgbW9yZSBvYnZpb3VzIHRoYXQgdGhpcyBpc24ndCBqdXN0IGEgb25lLW9mZiB0aGluZz8g
T3IKPj4gaG93IGRvIHdlIHByb2NlZWQ/Cj4gCj4gUm9iLCBnaXZlbiB0aGF0IGFkZGl0aW9uYWwg
dXNlLWNhc2UsIGRvIHlvdSB3YW50IG1lIHRvIHJ1biB3aXRoIHRoaXMKPiBwcm9wb3NhbCBhbmQg
c2VuZCBvdXQgYW4gdXBkYXRlZCBzZXJpZXM/CgoKV2hhdCBhYm91dCB2YXJpYW50IHdpdGggYSAi
ZGVzY3JpcHRvciIgcHJvcGVydGllcyB0aGF0IHdpbGwgZGVzY3JpYmUKZWFjaCByZWdpb246Cgpm
Yl9kZXNjOiBkaXNwbGF5LWZyYW1lYnVmZmVyLW1lbW9yeS1kZXNjcmlwdG9yIHsKCW5lZWRzLWlk
ZW50aXR5LW1hcHBpbmc7Cn0KCmRpc3BsYXlANTI0MDAwMDAgewoJbWVtb3J5LXJlZ2lvbiA9IDwm
ZmIgLi4uPjsKCW1lbW9yeS1yZWdpb24tZGVzY3JpcHRvciA9IDwmZmJfZGVzYyAuLi4+Owp9OwoK
SXQgY291bGQgYmUgYSBtb3JlIGZsZXhpYmxlL2V4dGVuZGlibGUgdmFyaWFudC4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
