Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D01C433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 03:26:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387E2206D6
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 03:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387E2206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB53E85BDF;
	Mon, 11 Jan 2021 03:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 82PwUcQC1h33; Mon, 11 Jan 2021 03:26:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3498F85BB8;
	Mon, 11 Jan 2021 03:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166A1C088B;
	Mon, 11 Jan 2021 03:26:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D4DFC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 03:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 13E1E85E5E
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 03:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P3SewCB2zda5 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 03:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6480085C9D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 03:26:47 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id g15so11695857pgu.9
 for <iommu@lists.linux-foundation.org>; Sun, 10 Jan 2021 19:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=o9DALHvMQ7c2790djtAoPkJytPERuXhfZ232KOAAAOo=;
 b=wS/W+UnxVXhtEtWCp9hr4E7rdFinMJMVBUxIeqn6319u9CPuDsvrdEFso4k7Hn11BC
 O7iKqsN3vEtb1Dkg2WQPmvSDzd+3W7d6S9zdcW46WjBxoqBt6Komi3wBa6uTRasulBHj
 c0ocjnhCqSgKcWT1blJwB1KsygFirTjmFamI5bkOa2viA9QWzpKG7Sz1ZILKufnuUyj7
 czXzKMaiSYk5Z78KheBj8vzPeYScx3XeTD5u4EJypar9GnQBOfSgqnxCTa3uai2uwjU5
 kC//20+eEdynRg+i9nig1GCU2O4ERndCDu+LZO3jFbopuF1fLrcg4TudwbWaKZpNa/ui
 z5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=o9DALHvMQ7c2790djtAoPkJytPERuXhfZ232KOAAAOo=;
 b=IhDK7PuQc2i6bNwCAGkCnx+wE4AuuVxBiQyLZ0nF+EeSJE5THLFBF3KZDfIuXSU3qq
 MHbLypncMmMl9IMDzg0pNWkswgHKBV+vFcKaCmA8a9nkZL7qMG02cAWQejDEmHwADhEQ
 PK2iOXOdcuDPF/F78hJUuoWuCGgwo8NSlfCyLIgOq3loXo9/PY8imrukWcfFZ65Mu4ql
 w6Vg/qW2LLyV625k58HMbD+H9WGtH4woXZSibWfP0Plexw9S9SDmadjKhdSRJlZXUJY/
 D5X/MXYJR9lMsVbflFBc/ivgv+Cmw9mLEWcdUbKG7/Q7ea7rVDvH/J5kKvTgAJ+zb18h
 n04g==
X-Gm-Message-State: AOAM5323CbVwZ5AJKl/+E1sFQq1SJKuvgCrWDRmWI2Q2tzZNwbIT8ns+
 62vjxRx8Xr+VJtleZuWfpdw/yg==
X-Google-Smtp-Source: ABdhPJzMm9ldMWkb2gXaK2PvamOC4omCPlaTwP8b9QNckusDWoe8R0otcwdwNmYcLOd55GXQrSrVhA==
X-Received: by 2002:a62:2b47:0:b029:19e:2c4b:6a8e with SMTP id
 r68-20020a622b470000b029019e2c4b6a8emr2085238pfr.30.1610335606890; 
 Sun, 10 Jan 2021 19:26:46 -0800 (PST)
Received: from ?IPv6:240e:362:4bf:e00:57d:5da4:e49:50d?
 ([240e:362:4bf:e00:57d:5da4:e49:50d])
 by smtp.gmail.com with ESMTPSA id o123sm17495916pfd.197.2021.01.10.19.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Jan 2021 19:26:46 -0800 (PST)
Subject: Re: [PATCH v9 00/10] iommu: I/O page faults for SMMUv3
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <d8e4c6f7-f194-3374-b6d6-6ea3006b57f5@linaro.org>
Date: Mon, 11 Jan 2021 11:26:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 guohanjun@huawei.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

CgpPbiAyMDIxLzEvOCDkuIvljYgxMDo1MiwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+
IEFkZCBzdGFsbCBzdXBwb3J0IHRvIHRoZSBTTU1VdjMsIGFsb25nIHdpdGggYSBjb21tb24gSS9P
IFBhZ2UgRmF1bHQKPiBoYW5kbGVyLgo+Cj4gQ2hhbmdlcyBzaW5jZSB2OCBbMV06Cj4gKiBBZGRl
ZCBwYXRjaGVzIDEgYW5kIDIgd2hpY2ggYXJlbid0IHN0cmljdGx5IHJlbGF0ZWQgdG8gSU9QRiBi
dXQgbmVlZCB0bwo+ICAgIGJlIGFwcGxpZWQgaW4gb3JkZXIgLSA4IGRlcGVuZHMgb24gMiB3aGlj
aCBkZXBlbmRzIG9uIDEuIFBhdGNoIDIgbW92ZXMKPiAgICBwYXNpZC1udW0tYml0cyB0byBhIGRl
dmljZSBwcm9wZXJ0eSwgZm9sbG93aW5nIFJvYmluJ3MgY29tbWVudCBvbiB2OC4KPiAqIFBhdGNo
ZXMgMy01IGV4dHJhY3QgdGhlIElPUEYgZmVhdHVyZSBmcm9tIHRoZSBTVkEgb25lLCB0byBzdXBw
b3J0IFNWQQo+ICAgIGltcGxlbWVudGF0aW9ucyB0aGF0IGhhbmRsZSBJL08gcGFnZSBmYXVsdHMg
dGhyb3VnaCB0aGUgZGV2aWNlIGRyaXZlcgo+ICAgIHJhdGhlciB0aGFuIHRoZSBJT01NVSBkcml2
ZXIgWzJdCj4gKiBVc2UgZGV2aWNlIHByb3BlcnRpZXMgZm9yIGRtYS1jYW4tc3RhbGwsIGluc3Rl
YWQgb2YgYSBzcGVjaWFsIGZ3c3BlYwo+ICAgIG1lbWJlci4KPiAqIERyb3BwZWQgUFJJIHN1cHBv
cnQgZm9yIG5vdywgc2luY2UgaXQgZG9lc24ndCBzZWVtIHRvIGJlIGF2YWlsYWJsZSBpbgo+ICAg
IGhhcmR3YXJlIGFuZCBhZGRzIHNvbWUgY29tcGxleGl0eS4KPiAqIEhhZCB0byBkcm9wIHNvbWUg
QWNrcyBhbmQgVGVzdGVkIHRhZ3MgdW5mb3J0dW5hdGVseSwgZHVlIHRvIGNvZGUKPiAgICBjaGFu
Z2VzLgo+Cj4gQXMgdXN1YWwsIHlvdSBjYW4gZ2V0IHRoZSBsYXRlc3QgU1ZBIHBhdGNoZXMgZnJv
bQo+IGh0dHA6Ly9qcGJydWNrZXIubmV0L2dpdC9saW51eCBzdmEvY3VycmVudAo+Cj4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjAxMTEyMTI1NTE5LjM5ODc1OTUt
MS1qZWFuLXBoaWxpcHBlQGxpbmFyby5vcmcvCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWlvbW11L0JZNVBSMTJNQjM3NjRGNUQwN0U4RUM0ODMyN0UzOUM4NkIzQzYwQEJZNVBS
MTJNQjM3NjQubmFtcHJkMTIucHJvZC5vdXRsb29rLmNvbS8KPgo+IEplYW4tUGhpbGlwcGUgQnJ1
Y2tlciAoMTApOgo+ICAgIGlvbW11OiBSZW1vdmUgb2Jzb2xldGUgY29tbWVudAo+ICAgIGlvbW11
L2FybS1zbW11LXYzOiBVc2UgZGV2aWNlIHByb3BlcnRpZXMgZm9yIHBhc2lkLW51bS1iaXRzCj4g
ICAgaW9tbXU6IFNlcGFyYXRlIElPTU1VX0RFVl9GRUFUX0lPUEYgZnJvbSBJT01NVV9ERVZfRkVB
VF9TVkEKPiAgICBpb21tdS92dC1kOiBTdXBwb3J0IElPTU1VX0RFVl9GRUFUX0lPUEYKPiAgICB1
YWNjZTogRW5hYmxlIElPTU1VX0RFVl9GRUFUX0lPUEYKPiAgICBpb21tdTogQWRkIGEgcGFnZSBm
YXVsdCBoYW5kbGVyCj4gICAgaW9tbXUvYXJtLXNtbXUtdjM6IE1haW50YWluIGEgU0lELT5kZXZp
Y2Ugc3RydWN0dXJlCj4gICAgZHQtYmluZGluZ3M6IGRvY3VtZW50IHN0YWxsIHByb3BlcnR5IGZv
ciBJT01NVSBtYXN0ZXJzCj4gICAgQUNQSS9JT1JUOiBFbmFibGUgc3RhbGwgc3VwcG9ydCBmb3Ig
cGxhdGZvcm0gZGV2aWNlcwo+ICAgIGlvbW11L2FybS1zbW11LXYzOiBBZGQgc3RhbGwgc3VwcG9y
dCBmb3IgcGxhdGZvcm0gZGV2aWNlcwoKVGhhbmtzIEplYW4KSSBoYXZlIHRlc3RlZCBvbiBIaXNp
bGljb24gS3VucGVuZzkyMCBib2FyZC4KCiDCoFRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZz4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
