Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C09C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 19:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AB3242693;
	Thu,  9 Dec 2021 19:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KNO3hnn7uczt; Thu,  9 Dec 2021 19:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B46E42685;
	Thu,  9 Dec 2021 19:58:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04AF7C001E;
	Thu,  9 Dec 2021 19:58:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F03E6C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEBAF42647
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qF6j-PuvkV6Z for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 19:58:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29B2A424EC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 19:58:36 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id l22so14093922lfg.7
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 11:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uM+eFXoWiWetPTI10tceV6UBa9/7Dufz9K7yclEKlI0=;
 b=oCqfCY2JIiJilttvVZHOauO6ECOE6Afie3ANJ3X5Vr0i3pfRV1nmwcCXijTzpzh9wY
 bi7YBYlkFbKiFcSgZo6cBhenPCTubiN4V9FPUJ9YZIioT9j2O9Ixln1xN+qIsClVc1Do
 +EKXvKKkUfWEDljaIXjhfucZxW8ta+H202606N8GoTjulMKAhQHNkQrvYT0I4NVbHFuF
 H09hKK9k/McDAYEwxAzbKUirIj//T9cNDM4e/JI1yrhhnARSjTRVBGyYCEgijek8tPWU
 6DIeF4/ceATr4ZALuEnwXMssodFcxmS/7XWya+Q5QpoFNR5WTWntKlGUtjYW/1ct97d0
 2DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uM+eFXoWiWetPTI10tceV6UBa9/7Dufz9K7yclEKlI0=;
 b=MaJ3ExImREjSFOgwlOB8V8VE8ioNeqqjCpYYhxEVI8U0Oq7jca0rZUe3VamFoulrSB
 3mmlN7V595EIAAjGErNImYhaXh7TWcKlHasbR98cP2wqEm+tHgJuhxSzV14xZoFhbTED
 P4185tBtnlX+bnX5inT2DqarTiNyWeTLVCNFly5mANY8TOnraJcb+ekbzhiOj9R0IPtv
 +rMQmhvaZzfqOCQNt56C2lynEI9uT41FHvS9jUK4Zz7JuYwPcSD6EmrQjuDuhXHtkxwY
 S4JqQ/IeZpCFrS2THfjHELa4EDr0jeAXa8qkWeUePpIfOjUav8SkMv6RBZ2CMgmaLmam
 3QiA==
X-Gm-Message-State: AOAM5318xh1MWso7s5PLY0OjX5Vp3+kldUzYjbtbrhzht367WwBI1uk4
 f1aY8HemHVURX+sYcSL6WYM=
X-Google-Smtp-Source: ABdhPJx7I+soYFAg27UyyMF614X5ml5K/O6igAuGctXo8HGNaRIcXOQdKsUNc8fVwmt4dOF//1/+rw==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr1252953lfg.85.1639079914011; 
 Thu, 09 Dec 2021 11:58:34 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru.
 [94.29.46.111])
 by smtp.googlemail.com with ESMTPSA id y11sm83212ljh.54.2021.12.09.11.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 11:58:33 -0800 (PST)
Subject: Re: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
 <20211209073822.26728-7-nicolinc@nvidia.com>
 <63b4c2e2-0e55-5701-4c45-70684c7e058e@gmail.com>
 <20211209192450.GA34762@Asurada-Nvidia>
 <fab11209-a579-bbfb-a701-e613cecabd56@gmail.com>
 <20211209195450.GB35526@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <520bc232-7173-dc28-2d81-6b0f42773bc8@gmail.com>
Date: Thu, 9 Dec 2021 22:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209195450.GB35526@Asurada-Nvidia>
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

MDkuMTIuMjAyMSAyMjo1NCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVGh1LCBEZWMg
MDksIDIwMjEgYXQgMTA6NDQ6MjVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+
Pgo+Pgo+PiAwOS4xMi4yMDIxIDIyOjI0LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9u
IFRodSwgRGVjIDA5LCAyMDIxIGF0IDA1OjQ5OjA5UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3
cm90ZToKPj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cwo+Pj4+Cj4+Pj4KPj4+PiAwOS4xMi4yMDIxIDEwOjM4LCBOaWNvbGluIENoZW4g
0L/QuNGI0LXRgjoKPj4+Pj4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIHBkX3B0X2luZGV4X2lvdmEo
dW5zaWduZWQgaW50IHBkX2luZGV4LCB1bnNpZ25lZCBpbnQgcHRfaW5kZXgpCj4+Pj4+ICt7Cj4+
Pj4+ICsgICAgIHJldHVybiAocGRfaW5kZXggJiAoU01NVV9OVU1fUERFIC0gMSkpIDw8IFNNTVVf
UERFX1NISUZUIHwKPj4+Pj4gKyAgICAgICAgICAgIChwdF9pbmRleCAmIChTTU1VX05VTV9QVEUg
LSAxKSkgPDwgU01NVV9QVEVfU0hJRlQ7Cj4+Pj4+ICt9Cj4+Pj4KPj4+PiBJJ2QgY2hhbmdlIHRo
ZSByZXR1cm4gdHlwZSB0byB1MzIgaGVyZSwgZm9yIGNvbnNpc3RlbmN5Lgo+Pj4KPj4+IFRoZSB3
aG9sZSBmaWxlIGRlZmluZXMgaW92YSB1c2luZyAidW5zaWduZWQgbG9uZyIsIHdoaWNoIEkgc2Vl
Cj4+PiBhcyB0aGUgY29uc2lzdGVuY3kuLi4gSWYgd2UgY2hhbmdlIGl0IHRvIHUzMiwgaXQnZCBi
ZSBwcm9iYWJseQo+Pj4gbmVjZXNzYXJ5IHRvIGNoYW5nZSBhbGwgaW92YSB0eXBlcyB0byB1MzIg
dG9vLi4uIFNvIEknZCByYXRoZXIKPj4+IGtlZXAgaXQgInVuc2lnbmVkIGxvbmciIGhlcmUuIElm
IHlvdSBzZWUgYSBiaWcgbmVjZXNzaXR5IHRvIGRvCj4+PiB0aGF0LCBhbiBhZGRpdGlvbmFsIHBh
dGNoIHdvdWxkIGJlIG5pY2VyIElNSE8uCj4+Pgo+Pgo+PiBJbiBnZW5lcmFsIElPVkEgaXMgInVu
c2lnbmVkIGxvbmciLCBvZiBjb3Vyc2UuIEJ1dCBpbiBjYXNlIG9mIFRlZ3JhCj4+IFNNTVUsIHdl
IGtub3cgdGhhdCBpcyBhbHdheXMgdTMyLgo+Pgo+PiBBbHJpZ2h0LCBJIHNlZSBub3cgdGhhdCB0
aGVyZSBhcmUgb3RoZXIgcGxhY2VzIGluIHRoZSBkcml2ZXIgY29kZSB0aGF0Cj4+IHVzZSAidW5z
aWduZWQgbG9uZyIsIHNvIG5lZWQgdG8gY2hhbmdlIGl0IGluIHRoaXMgcGF0Y2guCj4gCj4gSSB0
aGluayB3ZSBzaG91bGQgZG8gdGhhdCBpbiBhIHNlcGFyYXRlIHBhdGNoIHRoYXQgY2hhbmdlcyB0
aGUgaW92YQo+IHR5cGUgaW4gdGhlIGVudGlyZSB0ZWdyYS1zbW11IGZpbGUuIEkgY2FuIGFkZCBv
bmUgaW4gdGhpcyBzZXJpZXMsIGlmCj4gdGhpcyBtYWtlcyB5b3UgaGFwcHkuLi4KPiAKClBsZWFz
ZSBrZWVwIGl0ICJ1bnNpZ25lZCBsb25nIiwgbm8gbmVlZCBmb3IgZXh0cmEgcGF0Y2hlcy4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
