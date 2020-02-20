Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF055C11D0C
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 16:24:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ADB206F4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 16:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6e2K+jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ADB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B77D835EF;
	Thu, 20 Feb 2020 16:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvHnR8Rv_9iU; Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EFD5E83505;
	Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6495C1D81;
	Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB87C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 38BF5214EB
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 16:24:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uOjER6aVaFcK for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 16:24:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id A9FA0214E4
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215889;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFDhWGMMz3c3KINy5m2oRHAjI8OMHRzcdj6Y8N7UCZs=;
 b=Q6e2K+jAVVWzC5N3gy/qZt+GDlfI3ZSJXbh6/FLVPgX8qGbEu7yDjZd39SwXdRi7m9psEj
 kasd1ySaY7JRy001YJqp3oLtuA5Xmh1HBYVZXYHWWkoBVGtFXD4kA23AwhUY+XPRL0xrzR
 ooJ7KGVCkMsv3jTTmEsl8ny0axqQq58=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-_n4RpExOM1K3HpNuol1HzQ-1; Thu, 20 Feb 2020 11:24:44 -0500
X-MC-Unique: _n4RpExOM1K3HpNuol1HzQ-1
Received: by mail-qv1-f70.google.com with SMTP id z39so2924587qve.5
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 08:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=EFDhWGMMz3c3KINy5m2oRHAjI8OMHRzcdj6Y8N7UCZs=;
 b=GsSgXD2vJVOecYsoP3m9X/sugj5IgwB25BgvViXPmCjOo727R/qcXRsqeqzwXt8FCx
 kMZJoIh0sO0HTKWFLeRmQldDwUXO2m7lRJnODbBedEidQ7ZKzXRj92xmLRI/HPy1YXZY
 UlWPhFmQ0/OewQ8mruYYWZQ/p/+INEhpCF4KEj1v1RiV7xZW27jS7AzTCeKtjwFhxRIG
 oGTyHOQOvmmTANyOKTjgDi3/UjnH3wBXsjEoCUQ/P7bl9cVcGZy8140PwVrI1A5Uf7SE
 HVmcoGf2mcDUtU7zAihd+4oTa0pfH25+Tkjj7Ae0xZ3YtLAnLBAqqqSlNq5XLTDycCQp
 X/yw==
X-Gm-Message-State: APjAAAXQ+Cq99zm9hM9bhi3KgwdPPQRd85zcTW5XnEp8wCC7xWl1MNSv
 DNgP55iKGjUIjLJ0OLURT4BOIMEcJIFHEFbIuDKMXK5w5JFwPkgCnvrmNpzNXPJsETDb3MHed13
 /dmwlqMttgw9Eb1DE/GBD+n6Y9HTEng==
X-Received: by 2002:ac8:694f:: with SMTP id n15mr27477727qtr.372.1582215883456; 
 Thu, 20 Feb 2020 08:24:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyINpVliNmfQj2109URCheTtboHhJq7WugBr7svl7X1mdti4Mdwelx5BzueHntrTa2VfSINqg==
X-Received: by 2002:ac8:694f:: with SMTP id n15mr27477689qtr.372.1582215883126; 
 Thu, 20 Feb 2020 08:24:43 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id l25sm8111qkk.115.2020.02.20.08.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 08:24:42 -0800 (PST)
Date: Thu, 20 Feb 2020 09:24:41 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: question about iommu_need_mapping
Message-ID: <20200220162441.bhnpwgsmj4vlp3ve@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200219235516.zl44y7ydgqqja6x5@cantor>
 <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <af5a148e-76bc-4aa4-dd1c-b04a5ffc56b1@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

T24gVGh1IEZlYiAyMCAyMCwgTHUgQmFvbHUgd3JvdGU6Cj5IaSBKZXJyeSwKPgo+T24gMjAyMC8y
LzIwIDc6NTUsIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+SXMgaXQgcG9zc2libGUgZm9yIGEg
ZGV2aWNlIHRvIGVuZCB1cCB3aXRoIGRldi0+YXJjaGRhdGEuaW9tbXUgPT0gTlVMTAo+Pm9uIGlv
bW11X25lZWRfbWFwcGluZyBpbiB0aGUgZm9sbG93aW5nIGluc3RhbmNlOgo+Pgo+PjEuIGlvbW11
X2dyb3VwIGhhcyBkbWEgZG9tYWluIGZvciBkZWZhdWx0Cj4+Mi4gZGV2aWNlIGdldHMgcHJpdmF0
ZSBpZGVudGl0eSBkb21haW4gaW4gaW50ZWxfaW9tbXVfYWRkX2RldmljZQo+PjMuIGlvbW11X25l
ZWRfbWFwcGluZyBnZXRzIGNhbGxlZCB3aXRoIHRoYXQgZGV2aWNlLgo+PjQuIGRtYXJfcmVtb3Zl
X29uZV9kZXZfaW5mbyBzZXRzIGRldi0+YXJjaGRhdGEuaW9tbXUgPSBOVUxMIHZpYSAKPj51bmxp
bmtfZG9tYWluX2luZm8uCj4+NS4gcmVxdWVzdF9kZWZhdWx0X2RvbWFpbl9mb3JfZGV2IGV4aXRz
IGFmdGVyIGNoZWNraW5nIHRoYXQgCj4+Z3JvdXAtPmRlZmF1bHRfZG9tYWluCj4+IMKgwqAgZXhp
c3RzLCBhbmQgZ3JvdXAtPmRlZmF1bHRfZG9tYWluLT50eXBlIGlzIGRtYS4KPj42LiBpb21tdV9y
ZXF1ZXN0X2RtYV9kb21haW5fZm9yX2RldiByZXR1cm5zIDAgZnJvbSAKPj5yZXF1ZXN0X2RlZmF1
bHRfZG9tYWluX2Zvcl9kZXYKPj4gwqDCoCBhbmQgYSBwcml2YXRlIGRtYSBkb21haW4gaXNuJ3Qg
Y3JlYXRlZCBmb3IgdGhlIGRldmljZS4KPj4KPgo+WWVzLiBJdCdzIHBvc3NpYmxlLgo+Cj4+VGhl
IGNhc2UgSSB3YXMgc2VlaW5nIHdlbnQgYXdheSB3aXRoIGNvbW1pdCA5MjM1Y2IxM2Q3ZDEgKCJp
b21tdS92dC1kOgo+PkFsbG93IGRldmljZXMgd2l0aCBSTVJScyB0byB1c2UgaWRlbnRpdHkgZG9t
YWluIiksIGJlY2F1c2UgaXQgY2hhbmdlZAo+PndoaWNoIGRvbWFpbiB0aGUgZ3JvdXAgYW5kIGRl
dmljZXMgd2VyZSB1c2luZywgYnV0IGl0IHNlZW1zIGxpa2UgaXQgaXMKPj5zdGlsbCBhIHBvc3Np
YmlsaXR5IHdpdGggdGhlIGNvZGUuIEJhb2x1LCB5b3UgbWVudGlvbmVkIHBvc3NpYmx5Cj4+cmVt
b3ZpbmcgdGhlIGRvbWFpbiBzd2l0Y2guIENvbW1pdCA5OGIyZmZmYjVlMjcgKCJpb21tdS92dC1k
OiBIYW5kbGUKPj4zMmJpdCBkZXZpY2Ugd2l0aCBpZGVudGl0eSBkZWZhdWx0IGRvbWFpbiIpIG1h
a2VzIGl0IHNvdW5kIGxpa2UgdGhlCj4+ZG9tYWluIHN3aXRjaCBpcyByZXF1aXJlZC4KPgo+SXQn
cyBtb3JlICJuaWNlIHRvIGhhdmUiIHRoYW4gInJlcXVpcmVkIiBpZiB0aGUgaW9tbXUgZHJpdmVy
IGRvZXNuJ3QKPmRpc2FibGUgc3dpb3RsYiBleHBsaWNpdGx5LiBUaGUgZGV2aWNlIGFjY2VzcyBv
ZiBzeXN0ZW0gbWVtb3J5IGhpZ2hlcgo+dGhhbiB0aGUgZGV2aWNlJ3MgYWRkcmVzc2luZyBjYXBh
YmlsaXR5IGNvdWxkIGdvIHRocm91Z2ggdGhlIGJvdW5jZWQKPmJ1ZmZlciBpbXBsZW1lbnRlZCBp
biBzd2lvdGxiLgo+Cj5CZXN0IHJlZ2FyZHMsCj5iYW9sdQoKSGkgQmFvbHUsCgpXb3VsZCB0aGlz
IG1lYW4gc3dpdGNoaW5nIHRvIGJvdW5jZV9kbWFfb3BzIGluc3RlYWQ/CgpSZWdhcmRzLApKZXJy
eQoKPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5pb21t
dSBtYWlsaW5nIGxpc3QKPmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj5odHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
