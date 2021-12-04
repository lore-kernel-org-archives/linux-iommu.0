Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BDC433F5
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 07:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BFDC83046;
	Sat,  4 Dec 2021 07:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTtDeRqj_VST; Sat,  4 Dec 2021 07:22:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 88AA983417;
	Sat,  4 Dec 2021 07:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A2EEC006E;
	Sat,  4 Dec 2021 07:22:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49DA4C0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C5984095D
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhGRefjRcb7p for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 07:22:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09DC4403FD
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:22:04 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id b13so3639164plg.2
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 23:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ZkQEYozmB0wgYJcxDO/m983AAdy8n14FhucCaGoUzA4=;
 b=blREAYP23qBjIahcqczEuNSUq6MRbQ5UXgW1oG4ZGSSpOed90dbanN+LHvJF7N6ME0
 Y9LKoSwodHr9BOd//+DW6OvBPSh6Rf4BdMb2EzDvtQ+sVoes1f6+7VWyUKFWqiaSHHqU
 Am+FtOCVPnOAgj6oTP0k0IWgh4dooTt7QX7KQKbCT+o69WR7nP4hJQspPwFm25qXtPCW
 kBdkmADgMPc7HTKvYOavrblwjUfXQ3wlSxkW6E/shgs8QAhLWvPBZ3tVRmEVD7CWY44S
 t8LTdIFpatSjby01xMjLjf42MSd1m5DtLtC+1uS3bLpAx3vREm/i+1aUCO81LPZgXzuP
 nkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZkQEYozmB0wgYJcxDO/m983AAdy8n14FhucCaGoUzA4=;
 b=MrfagQgQn1lTMLQiYWYtFOf7GQo1FjGYEHpykELmaNwQbpurfXHmi9laYkgZrn4S36
 MxqTOfnO25T3ewQjQnJ+vJhpUveOID62bFMnXLLKO5tnh026YNbBuRHkXa4+UJ6fUicb
 yMl4dOGLMNV/CIvzz7JlDYuyPwKPci26ZiIMBQXf0I1z5YyA8VnhkiWHVTC2oHA8bLgW
 BO5bxYsv1XV/ETt8DF0bejME/BsnJRjAQMum5c8DbM7cta+0MpDEo51FV197BMGNvnA0
 4i0TdDs2lUWen8L6Zxj7tYQQIqExTDvUlpFzgTq5stKzcKKNu+FvEqD6G2M0LJpINbi7
 A7sw==
X-Gm-Message-State: AOAM530Y+nuoxK9g3A7DFifedOXAU3WYgq24tZ9IY+3Zah0+nAT/WoEK
 ldajD87KJ0SnUNN7cI+fesI=
X-Google-Smtp-Source: ABdhPJzcZuwuxSGpXoC+LpAfScg+HY+PAZl5x85Fy3cmkRF8TnHHjxYQIiUVC9++sZKTL0nxBihlXA==
X-Received: by 2002:a17:903:1105:b0:143:a593:dc6e with SMTP id
 n5-20020a170903110500b00143a593dc6emr28523850plh.6.1638602524291; 
 Fri, 03 Dec 2021 23:22:04 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 t10sm4331860pga.6.2021.12.03.23.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 23:22:03 -0800 (PST)
Message-ID: <59e41c28-260f-876d-c7cf-a13669ad8984@gmail.com>
Date: Sat, 4 Dec 2021 15:21:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 1/5] Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-2-ltykernel@gmail.com>
 <41bb0a87-9fdb-4c67-a903-9e87d092993a@amd.com>
 <e78ba239-2dad-d48f-671e-f76a943052f1@gmail.com>
 <06faf04c-dc4a-69fd-0be9-04f57f779ffe@amd.com>
 <1b7b8e20-a861-ab26-26a1-dad1eb80a461@amd.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1b7b8e20-a861-ab26-26a1-dad1eb80a461@amd.com>
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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

T24gMTIvNC8yMDIxIDQ6MDYgQU0sIFRvbSBMZW5kYWNreSB3cm90ZToKPj4+IEhpIFRvbToKPj4+
IMKgwqDCoMKgwqDCoCBUaGFua3MgZm9yIHlvdXIgdGVzdC4gQ291bGQgeW91IGhlbHAgdG8gdGVz
dCB0aGUgZm9sbG93aW5nIAo+Pj4gcGF0Y2ggYW5kIGNoZWNrIHdoZXRoZXIgaXQgY2FuIGZpeCB0
aGUgaXNzdWUuCj4+Cj4+IFRoZSBwYXRjaCBpcyBtYW5nbGVkLiBJcyB0aGUgb25seSBkaWZmZXJl
bmNlIHdoZXJlIAo+PiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIGlzIGNhbGxlZD8KPiAKPiBJIGRl
LW1hbmdsZWQgdGhlIHBhdGNoLiBObyBtb3JlIHN0YWNrIHRyYWNlcyB3aXRoIFNNRSBhY3RpdmUu
Cj4gCj4gVGhhbmtzLAo+IFRvbQoKSGkgVG9tOgoJVGhhbmtzIGEgbG90IGZvciB5b3VyIHJld29y
ayBhbmQgdGVzdC4gSSB3aWxsIHVwZGF0ZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
