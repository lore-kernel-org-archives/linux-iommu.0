Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E641C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 20:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CCA586071;
	Thu,  9 Dec 2021 20:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oLugHH8nLRSc; Thu,  9 Dec 2021 20:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25F2C8606B;
	Thu,  9 Dec 2021 20:03:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E62BDC001E;
	Thu,  9 Dec 2021 20:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E2FFC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A33D424D2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15c1uxfrmVP4 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 20:03:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8F464010A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:03:03 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id k2so10689571lji.4
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ihEOhQoEWEgRs+9CLdXQa11iSfCT9fZ1UIZNVOm6lHI=;
 b=YsK6MGTpEJOO/0KbE/ZB9XYZdlgXIFyU6eamuFCje3seQSXH/gUooimKw+SVh4xCI5
 2WWVXZg4z+TSVPDTlyLuarP5R/L9hdhi2s2qmfGFsgfq54IDs6lHpjBQOfHFWNwijuPb
 4ASNoAMLYQ7cHPaTfvn7LnFRcHyqqpRn3jQu647IbWBS3TmajskyWWJ5eU+I6SviqDmA
 K6l23fdxLoXOnjsiwcVqnO03R3VjpkJGnhQWOT7WR3p2UJ3XPDd5c0fMC8EBlWAc8f2W
 WX6xC/wbo0TSZiyAIQKcPKdNVQogVemB3QAjnj5yYkcQscqRcSf80GBhphvM/xH5VZez
 Sp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ihEOhQoEWEgRs+9CLdXQa11iSfCT9fZ1UIZNVOm6lHI=;
 b=vsF8MyFnodMXffbUncMWqOw+PiR+Mgb08JHAC1ev5vgJo1HWbT54A/aa3wesnmLr1S
 Ago+UXe7iaUwCUt0sO+9I+/jvsLCDeYAAJb4Uw1AnnownsInsjlW/9oPdtl65QjHo3Zj
 C4fo6tVzOAzu4wbPuvASyHjNUB7OSK8FLf99Un3k7Jk/xKlaykvyr0usYGim2mnY1zFt
 9pQBVAcO4r4lJESXfi+k31+kACjmiKUaX8/8Nr1oS3PazI83W8HflYSiTX8odvuYlg2k
 6xeqxgwn3VDYMmxPK1PPS+V690O+MGdAOAI7D6pPMeAu23KAQiYeMIECOQT+XnfQASYT
 q5HA==
X-Gm-Message-State: AOAM530p22geCTHgcp5xezHtCv74dbG9nyaj0wYXdCWe3wikCi3eVf+X
 b+jjepoBW8HakuddvW54mAE=
X-Google-Smtp-Source: ABdhPJyIC6hdlhzGyYreJsxY/lkGafPwOf/c5Z7ZUSqaW/xN3uShMkXg9Ddp+HXFak2uB9cEZURuSg==
X-Received: by 2002:a05:651c:b23:: with SMTP id
 b35mr9021210ljr.286.1639080181485; 
 Thu, 09 Dec 2021 12:03:01 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id l14sm96276lfk.80.2021.12.09.12.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 12:03:01 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
 <20211209195450.GB35526@Asurada-Nvidia>
 <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
 <20211209200141.GA35858@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8baa58f4-fd3c-1273-d770-035a2fb76c96@gmail.com>
Date: Thu, 9 Dec 2021 23:03:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209200141.GA35858@Asurada-Nvidia>
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

MDkuMTIuMjAyMSAyMzowMSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBEZWMg
MDksIDIwMjEgYXQgMTA6NTg6MzJQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+
Pgo+Pgo+PiAwOS4xMi4yMDIxIDIyOjU0LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9u
IFRodSwgRGVjIDA5LCAyMDIxIGF0IDEwOjQ0OjI1UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3
cm90ZToKPj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cwo+Pj4+Cj4+Pj4KPj4+PiAwOS4xMi4yMDIxIDIyOjI0LCBOaWNvbGluIENoZW4g
0L/QuNGI0LXRgjoKPj4+Pj4gT24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDU6NDk6MDlQTSArMDMw
MCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0
aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gMDku
MTIuMjAyMSAxMDozOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4+Pj4+Pj4gK3N0YXRpYyB1
bnNpZ25lZCBsb25nIHBkX3B0X2luZGV4X2lvdmEodW5zaWduZWQgaW50IHBkX2luZGV4LCB1bnNp
Z25lZCBpbnQgcHRfaW5kZXgpCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArICAgICByZXR1cm4gKHBkX2lu
ZGV4ICYgKFNNTVVfTlVNX1BERSAtIDEpKSA8PCBTTU1VX1BERV9TSElGVCB8Cj4+Pj4+Pj4gKyAg
ICAgICAgICAgIChwdF9pbmRleCAmIChTTU1VX05VTV9QVEUgLSAxKSkgPDwgU01NVV9QVEVfU0hJ
RlQ7Cj4+Pj4+Pj4gK30KPj4+Pj4+Cj4+Pj4+PiBJJ2QgY2hhbmdlIHRoZSByZXR1cm4gdHlwZSB0
byB1MzIgaGVyZSwgZm9yIGNvbnNpc3RlbmN5Lgo+Pj4+Pgo+Pj4+PiBUaGUgd2hvbGUgZmlsZSBk
ZWZpbmVzIGlvdmEgdXNpbmcgInVuc2lnbmVkIGxvbmciLCB3aGljaCBJIHNlZQo+Pj4+PiBhcyB0
aGUgY29uc2lzdGVuY3kuLi4gSWYgd2UgY2hhbmdlIGl0IHRvIHUzMiwgaXQnZCBiZSBwcm9iYWJs
eQo+Pj4+PiBuZWNlc3NhcnkgdG8gY2hhbmdlIGFsbCBpb3ZhIHR5cGVzIHRvIHUzMiB0b28uLi4g
U28gSSdkIHJhdGhlcgo+Pj4+PiBrZWVwIGl0ICJ1bnNpZ25lZCBsb25nIiBoZXJlLiBJZiB5b3Ug
c2VlIGEgYmlnIG5lY2Vzc2l0eSB0byBkbwo+Pj4+PiB0aGF0LCBhbiBhZGRpdGlvbmFsIHBhdGNo
IHdvdWxkIGJlIG5pY2VyIElNSE8uCj4+Pj4+Cj4+Pj4KPj4+PiBJbiBnZW5lcmFsIElPVkEgaXMg
InVuc2lnbmVkIGxvbmciLCBvZiBjb3Vyc2UuIEJ1dCBpbiBjYXNlIG9mIFRlZ3JhCj4+Pj4gU01N
VSwgd2Uga25vdyB0aGF0IGlzIGFsd2F5cyB1MzIuCj4+Pj4KPj4+PiBBbHJpZ2h0LCBJIHNlZSBu
b3cgdGhhdCB0aGVyZSBhcmUgb3RoZXIgcGxhY2VzIGluIHRoZSBkcml2ZXIgY29kZSB0aGF0Cj4+
Pj4gdXNlICJ1bnNpZ25lZCBsb25nIiwgc28gbmVlZCB0byBjaGFuZ2UgaXQgaW4gdGhpcyBwYXRj
aC4KPj4+Cj4+PiBJIHRoaW5rIHdlIHNob3VsZCBkbyB0aGF0IGluIGEgc2VwYXJhdGUgcGF0Y2gg
dGhhdCBjaGFuZ2VzIHRoZSBpb3ZhCj4+PiB0eXBlIGluIHRoZSBlbnRpcmUgdGVncmEtc21tdSBm
aWxlLiBJIGNhbiBhZGQgb25lIGluIHRoaXMgc2VyaWVzLCBpZgo+Pj4gdGhpcyBtYWtlcyB5b3Ug
aGFwcHkuLi4KPj4+Cj4+Cj4+IFBsZWFzZSBrZWVwIGl0ICJ1bnNpZ25lZCBsb25nIiwgbm8gbmVl
ZCBmb3IgZXh0cmEgcGF0Y2hlcy4KPiAKPiBPaCwgSSBndWVzcyB0aGF0ICJzbyBuZWVkIHRvIGNo
YW5nZSBpdCBpbiB0aGlzIHBhdGNoIiBzaG91bGQgYmUKPiAic28gKG5vKSBuZWVkIHRvIGNoYW5n
ZSBpdCBpbiB0aGlzIHBhdGNoIiB0aGVuPwo+IAoKSW5kZWVkLCBJIG1pc3NlZCB0aGF0IHR5cG8s
IHNvcnJ5LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
