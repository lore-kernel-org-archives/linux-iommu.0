Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C523EC433E1
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 00:02:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0D02072E
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 00:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXwBKN5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0D02072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10E9586FEA;
	Tue,  2 Jun 2020 00:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HbDUJrk87NCh; Tue,  2 Jun 2020 00:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68173871C0;
	Tue,  2 Jun 2020 00:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33979C088C;
	Tue,  2 Jun 2020 00:02:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB2EC088C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 00:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2824085E7C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 00:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ra_Ki69Efdy for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 00:02:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB42B85E1A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 00:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591056171;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEgguSwsSBQsO87++CE0y1rNffa4jp9PI1ZebsV4DLs=;
 b=VXwBKN5fbxKEnQk7tepgmnRafXsdL3DFCGVDZPAKPK1xSamLzs1wZQQHelY/dFcePVo22x
 2+G8JyoEcWt+Xn9G2vqFeIt9wNa++avI+NnFbchuvGdOL0xES6XvXeGnmCjveo2wUdeuJO
 /lOqhi2W6XkAyB03ZYoX/ckauGaqyM4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-KB6cnbs0McOQ33VRbftikQ-1; Mon, 01 Jun 2020 20:02:39 -0400
X-MC-Unique: KB6cnbs0McOQ33VRbftikQ-1
Received: by mail-qv1-f72.google.com with SMTP id w12so1785624qvh.13
 for <iommu@lists.linux-foundation.org>; Mon, 01 Jun 2020 17:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=WEgguSwsSBQsO87++CE0y1rNffa4jp9PI1ZebsV4DLs=;
 b=lARSLQIihmov1oiXoNzCrnxcdCM1qw+x+RwZc7tZzuCi25pFppeBVgV1YoZIAyLRSf
 nXAJ+K+3QSmgSgNL+/SFcDEtesOfZEvnPLSLV+s4XAFADFcUS4Y6a8qTThOUOWlUpFTG
 Pf6HNcQ4qV0PXG0ufAX/0beeARpmuppdH5xi3tCE98ASc7UaMs9iBlXtqY5ZW8P/7LsR
 MNsNIFn8Jc189F46Xc7Gpf+0nUJON2aFzTxHM0N2zySir5aU3WZEtAGKZdd/KVpiEuY7
 e0dB+DbQumwAsSGOBDqdlWtS6Cz22EIns42G0CBpSaoylFhuYfpt9s7V+N5+Z+y9uJgo
 03Ow==
X-Gm-Message-State: AOAM5307IfVkKXvbs2P+RM1rymvfoM452FENP+DVBuThru0jrYMMjpqx
 jExBh9LpVBUEqlW3bopmOB+Z7rfgMHspJewZ19oL24QUfxpaBuLMGDlA71HFPgV7Fws0jd1YjdT
 ddw9E7J6xSmnoCgLT1hEaRrYgZF6DfQ==
X-Received: by 2002:ac8:724c:: with SMTP id l12mr23746263qtp.259.1591056159435; 
 Mon, 01 Jun 2020 17:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRFkXYMc6X8G+o56RMfYFp5n8699HmlGFcYOLIr9n0Jz/P369Z9v//wIL4kQ8Ioy89XjW8QQ==
X-Received: by 2002:ac8:724c:: with SMTP id l12mr23746213qtp.259.1591056159140; 
 Mon, 01 Jun 2020 17:02:39 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id t13sm852903qtc.77.2020.06.01.17.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 17:02:37 -0700 (PDT)
Date: Mon, 1 Jun 2020 17:02:36 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Message-ID: <20200602000236.j4m3jvluzdhjngdc@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200529221623.qc6twmpzryh7nkvb@cantor>
 <20200601104240.7f5xhz7gooqhaq4n@cantor>
 <47711845-98ee-95b8-aa95-423a36ed9741@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <47711845-98ee-95b8-aa95-423a36ed9741@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlIEp1biAwMiAyMCwgTHUgQmFvbHUgd3JvdGU6Cj5IaSBKZXJyeSwKPgo+T24gNi8xLzIw
IDY6NDIgUE0sIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+Pgo+Pj5IaSBKb2VyZywKPj4+Cj4+
PldpdGggdGhpcyBwYXRjaHNldCwgSSBoYXZlIGFuIGVweWMgc3lzdGVtIHdoZXJlIGlmIEkgYm9v
dCB3aXRoCj4+PmlvbW11PW5vcHQgYW5kIGZvcmNlIGEgZHVtcCBJIHdpbGwgc2VlIHNvbWUgaW8g
cGFnZSBmYXVsdHMgZm9yIGEgbmljCj4+Pm9uIHRoZSBzeXN0ZW0uIFRoZSB2bWNvcmUgaXMgaGFy
dmVzdGVkIGFuZCB0aGUgc3lzdGVtIHJlYm9vdHMuIEkKPj4+aGF2ZW4ndCByZXByb2R1Y2VkIGl0
IG9uIG90aGVyIHN5c3RlbXMgeWV0LCBidXQgd2l0aG91dCB0aGUgcGF0Y2hzZXQgSQo+Pj5kb24n
dCBzZWUgdGhlIGlvIHBhZ2UgZmF1bHRzIGR1cmluZyB0aGUga2R1bXAuCj4+Pgo+Pj5SZWdhcmRz
LAo+Pj5KZXJyeQo+Pgo+PkkganVzdCBoaXQgYW4gaXNzdWUgb24gYSBzZXBhcmF0ZSBpbnRlbCBi
YXNlZCBzeXN0ZW0gKGtkdW1wIGlvbW11PW5vcHQpLAo+PndoZXJlIGl0IHBhbmljcyBpbiBkdXJp
bmcgaW50ZWxfaW9tbXVfYXR0YWNoX2RldmljZSwgaW4gaXNfYXV4X2RvbWFpbiwKPj5kdWUgdG8g
ZGV2aWNlX2RvbWFpbl9pbmZvIGJlaW5nIERFRkVSX0RFVklDRV9ET01BSU5fSU5GTy4gVGhhdCBk
b2Vzbid0Cj4+Z2V0IHNldCB0byBhIHZhbGlkIGFkZHJlc3MgdW50aWwgdGhlIGRvbWFpbl9hZGRf
ZGV2X2luZm8gY2FsbC4KPj4KPj5JcyBpdCBhcyBzaW1wbGUgYXMgdGhlIGZvbGxvd2luZz8KPgo+
SSBndWVzcyB5b3Ugd29uJ3QgaGl0IHRoaXMgaXNzdWUgaWYgeW91IHVzZSBpb21tdS9uZXh0IGJy
YW5jaCBvZiBKb2VyZydzCj50cmVlLiBXZSd2ZSBjaGFuZ2VkIHRvIHVzZSBhIGdlbmVyaWMgaGVs
cGVyIHRvIHJldHJpZXZlIHRoZSB2YWxpZCBwZXIKPmRldmljZSBpb21tdSBkYXRhIG9yIE5VTEwg
KGlmIHRoZXJlJ3Mgbm8pLgo+Cj5CZXN0IHJlZ2FyZHMsCj5iYW9sdQo+CgpZZWFoLCB0aGF0IHdp
bGwgc29sdmUgdGhlIHBhbmljLiAKCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+PmluZGV4IDI5ZDM5NDA4
NDdkMy4uZjFiYmVlZDQ2YTRjIDEwMDY0NAo+Pi0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9t
bXUuYwo+PisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+PkBAIC01MDUzLDggKzUw
NTMsOCBAQCBpc19hdXhfZG9tYWluKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IAo+PmlvbW11
X2RvbWFpbiAqZG9tYWluKQo+PiDCoHsKPj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9k
b21haW5faW5mbyAqaW5mbyA9IGRldi0+YXJjaGRhdGEuaW9tbXU7Cj4+Cj4+LcKgwqDCoMKgwqDC
oCByZXR1cm4gaW5mbyAmJiBpbmZvLT5hdXhkX2VuYWJsZWQgJiYKPj4twqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9tYWluLT50eXBlID09IElPTU1VX0RPTUFJ
Tl9VTk1BTkFHRUQ7Cj4+K8KgwqDCoMKgwqDCoCByZXR1cm4gaW5mbyAmJiBpbmZvICE9IERFRkVS
X0RFVklDRV9ET01BSU5fSU5GTyAmJgo+PivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
Zm8tPmF1eGRfZW5hYmxlZCAmJiBkb21haW4tPnR5cGUgPT0gCj4+SU9NTVVfRE9NQUlOX1VOTUFO
QUdFRDsKPj4gwqB9Cj4+Cj4+IMKgc3RhdGljIHZvaWQgYXV4aWxpYXJ5X2xpbmtfZGV2aWNlKHN0
cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluLAo+Pgo+Pgo+PlJlZ2FyZHMsCj4+SmVycnkKPl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5pb21tdSBtYWlsaW5n
IGxpc3QKPmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj5odHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
