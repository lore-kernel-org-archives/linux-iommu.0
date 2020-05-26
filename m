Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C760C433E3
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 12:07:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243C620787
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 12:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+ir68ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243C620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E910422CC7;
	Tue, 26 May 2020 12:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tvS7wPLc4t-g; Tue, 26 May 2020 12:07:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 116A4227E1;
	Tue, 26 May 2020 12:07:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09A94C0888;
	Tue, 26 May 2020 12:07:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 895B5C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 12:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7833885F83
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 12:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2tKuN8B2IgU for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 12:07:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4CC0B85F7D
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 12:07:32 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id t16so8606537plo.7
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fpsA7Nq2nxropNth7zUzBAVP9PJ+/EXl3l54pU3n9ZM=;
 b=J+ir68uaqgnC0bpUtYh7gEhKg91ecOFPaqozofq5uKsLc7Q5y3iFeqMqCZAJviMx+s
 5ig+pjzGqwz+mFaduqg65bildjvb3DkPZio13iXEBv0mAnfqdngUZrwP8cIh8JeTUCVJ
 gmFnjjcFBD8aNXil24SDu+Jkirv39gmumTTyj55+HgtSDlf8tVbBjh7E552efJG/Wjo8
 EJDaQDAdQwq7KwVsaMRKey6Y7TjZsMZCOt/LAThI6/92Dp0fkT6otf1CI6seawSCUyPt
 WoWoRsARBzdoihaCWqPAXG3jCyZxwI+pM2gsZxtGTudpYt/c710Xf3GM28FbeauVBfE6
 ryPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fpsA7Nq2nxropNth7zUzBAVP9PJ+/EXl3l54pU3n9ZM=;
 b=eVyjfGtclY4DqjAIU1lfw8dPA/yWvfcy8W3EsayuYZpVQTG0yjilYxEE63fsCBa+ty
 3Suqb/ke3z0+hW32ynji64YLHNVWUv9f3ldpiFTrfpWrtnRoi3UGR71Xifz91jmargWr
 dQDbzHYo7J2ahT+PJcg752/9JGlJWp0VfSgAD+ftHVAEkpc0xVl6uTIcBYNBU3WINZ1v
 1xXrM8NW+VumEeWlZTn3JcrppN+Vn4KA2ZVWf/2i3caE+FCye92fBjmiVDQpnV/cvIRk
 qjkMc8K4WIU+eJ9vEe3nFXCY5+zHcPlByS4QiShOVCb1k8nAo+1K4ZXIsFT4V260FqYv
 2iTw==
X-Gm-Message-State: AOAM531YbcXM8T7QdQXWFbmK5GIhtLWmKBFaqhYzcXyU4edrkNlgpx/f
 bB6p7Z76qgefhpLR1SmC/mDDLw==
X-Google-Smtp-Source: ABdhPJwJC/VIL8ph3znchjMxyQibr056u3YncVEhb6v6BwGdiIO+FoFmlj/9d7sAY/kJdEg5hx2xFg==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr822931plk.25.1590494851770; 
 Tue, 26 May 2020 05:07:31 -0700 (PDT)
Received: from [10.74.2.18] ([45.135.186.9])
 by smtp.gmail.com with ESMTPSA id x132sm15300133pfd.214.2020.05.26.05.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 05:07:30 -0700 (PDT)
Subject: Re: [PATCH 0/2] Let pci_fixup_final access iommu_fwnode
To: Joerg Roedel <joro@8bytes.org>
References: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
 <20200525134318.GB5221@8bytes.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <7c6e9389-c34a-4d30-bc8d-572c41572d15@linaro.org>
Date: Tue, 26 May 2020 20:07:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525134318.GB5221@8bytes.org>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, kenneth-lee-2012@foxmail.com,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIwLzUvMjUg5LiL5Y2IOTo0MywgSm9lcmcgUm9lZGVsIHdyb3RlOgo+IE9uIFR1ZSwg
TWF5IDEyLCAyMDIwIGF0IDEyOjA4OjI5UE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPj4g
U29tZSBwbGF0Zm9ybSBkZXZpY2VzIGFwcGVhciBhcyBQQ0kgYnV0IGFyZQo+PiBhY3R1YWxseSBv
biB0aGUgQU1CQSBidXMsIGFuZCB0aGV5IG5lZWQgZml4dXAgaW4KPj4gZHJpdmVycy9wY2kvcXVp
cmtzLmMgaGFuZGxpbmcgaW9tbXVfZndub2RlLgo+PiBTbyBjYWxsaW5nIHBjaV9maXh1cF9maW5h
bCBhZnRlciBpb21tdV9md25vZGUgaXMgYWxsb2NhdGVkLgo+Pgo+PiBGb3IgZXhhbXBsZToKPj4g
SGlzaWxpY29uIHBsYXRmb3JtIGRldmljZSBuZWVkIGZpeHVwIGluCj4+IGRyaXZlcnMvcGNpL3F1
aXJrcy5jCj4+Cj4+ICtzdGF0aWMgdm9pZCBxdWlya19odWF3ZWlfcGNpZV9zdmEoc3RydWN0IHBj
aV9kZXYgKnBkZXYpCj4+ICt7Cj4+ICsJc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjOwo+PiAr
Cj4+ICsJcGRldi0+ZWV0bHBfcHJlZml4X3BhdGggPSAxOwo+PiArCWZ3c3BlYyA9IGRldl9pb21t
dV9md3NwZWNfZ2V0KCZwZGV2LT5kZXYpOwo+PiArCWlmIChmd3NwZWMpCj4+ICsJCWZ3c3BlYy0+
Y2FuX3N0YWxsID0gMTsKPj4gK30KPj4gKwo+PiArREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJ
X1ZFTkRPUl9JRF9IVUFXRUksIDB4YTI1MCwgcXVpcmtfaHVhd2VpX3BjaWVfc3ZhKTsKPj4gK0RF
Q0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfSFVBV0VJLCAweGEyNTEsIHF1aXJr
X2h1YXdlaV9wY2llX3N2YSk7Cj4gSSBkb24ndCB0aGluayBpdCBpcyBhIGdyZWF0IGlkZWEgdG8g
aG9vayB0aGlzIGludG8gUENJX0ZJWFVQX0ZJTkFMLiBUaGUKPiBmaXh1cCBsaXN0IG5lZWRzIHRv
IGJlIHByb2Nlc3NlZCBmb3IgZXZlcnkgZGV2aWNlLCB3aGljaCB3aWxsIHNsb3cgZG93bgo+IHBy
b2JpbmcuCj4KPiBTbyBlaXRoZXIgd2UgaW50cm9kdWNlIHNvbWV0aGluZyBsaWtlIFBDSV9GSVhV
UF9JT01NVSwgaWYgdGhpcyBpcwo+IGVudGlyZWx5IFBDSSBzcGVjaWZpYy4gSWYgaXQgbmVlZHMg
dG8gYmUgZ2VuZXJpYyB3ZSBuZWVkIHNvbWUgZml4dXAKPiBpbmZyYXN0cnVjdHVyZSBpbiB0aGUg
SU9NTVUgY29kZSBpdHNlbGYuCgpUaGFua3MgSm9lcmcgZm9yIHRoZSBnb29kIHN1Z2dlc3Rpb24u
CkkgYW0gdHJ5aW5nIHRvIGludHJvZHVjZSBQQ0lfRklYVVBfSU9NTVUgaW4KaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMjAvNS8yNi8zNjYKClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
